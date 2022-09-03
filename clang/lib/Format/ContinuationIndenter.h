//===--- ContinuationIndenter.h - Format C++ code ---------------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
///
/// \file
/// This file implements an indenter that manages the indentation of
/// continuations.
///
//===----------------------------------------------------------------------===//

#ifndef LLVM_CLANG_LIB_FORMAT_CONTINUATIONINDENTER_H
#define LLVM_CLANG_LIB_FORMAT_CONTINUATIONINDENTER_H

#include "Encoding.h"
#include "FormatToken.h"
#include "clang/Format/Format.h"
#include "llvm/Support/Regex.h"
#include <tuple>

namespace clang {
class SourceManager;

namespace format {

class AnnotatedLine;
class BreakableToken;
struct FormatToken;
struct LineState;
struct ParenState;
struct RawStringFormatStyleManager;
class WhitespaceManager;

struct RawStringFormatStyleManager {
  llvm::StringMap<FormatStyle> DelimiterStyle;
  llvm::StringMap<FormatStyle> EnclosingFunctionStyle;

  RawStringFormatStyleManager(const FormatStyle &CodeStyle);

  llvm::Optional<FormatStyle> getDelimiterStyle(StringRef Delimiter) const;

  llvm::Optional<FormatStyle>
  getEnclosingFunctionStyle(StringRef EnclosingFunction) const;
};

/* FormatStyle for a specific language, as specified by additional keywords */
struct LanguageFormatStyle
{
  const FormatStyle &Style;
  const AdditionalKeywords &Keywords;
  LanguageFormatStyle(const FormatStyle &Style, const AdditionalKeywords &Keywords)
    : Style(Style)
    , Keywords(Keywords)
  {}

  /// Returns \c true, if a line break after \p State is allowed.
  bool canBreak(const LineState &State) const;

  /// Returns \c true, if a line break after \p State is mandatory.
  bool mustBreak(const LineState &State) const;

  /// Calculate the new column for a line wrap before the next token.
  unsigned getNewLineColumn(const LineState &State) const;

  /// Get the column limit for this line. This is the style's column
  /// limit, potentially reduced for preprocessor definitions.
  unsigned getColumnLimit(const LineState &State) const;

  /// Returns \c true if the next token starts a multiline string
  /// literal.
  ///
  /// This includes implicitly concatenated strings, strings that will be broken
  /// by clang-format and string literals with escaped newlines.
  bool nextIsMultilineString(const LineState &State) const;
};

class ContinuationIndenter {
public:
  /// Constructs a \c ContinuationIndenter to format \p Line starting in
  /// column \p FirstIndent.
  ContinuationIndenter(const LanguageFormatStyle &LanguageStyle,
                       const SourceManager &SourceMgr,
                       WhitespaceManager &Whitespaces,
                       encoding::Encoding Encoding,
                       bool BinPackInconclusiveFunctions);
  /// Get the initial state, i.e. the state after placing \p Line's
  /// first token at \p FirstIndent. When reformatting a fragment of code, as in
  /// the case of formatting inside raw string literals, \p FirstStartColumn is
  /// the column at which the state of the parent formatter is.
  LineState getInitialState(unsigned FirstIndent, unsigned FirstStartColumn,
                            const AnnotatedLine *Line, bool DryRun);

  // FIXME: canBreak and mustBreak aren't strictly indentation-related.
  // Implementation moved to LanguageFormatStyle, but as they are public
  // functions UnwrappedLineFormatter expects to find them in ContinuationIndenter
  /// Returns \c true, if a line break after \p State is allowed.
  bool canBreak(const LineState &State) const { return LanguageStyle.canBreak(State); };

  /// Returns \c true, if a line break after \p State is mandatory.
  bool mustBreak(const LineState &State) const { return LanguageStyle.mustBreak(State); };

  /// Appends the next token to \p State and updates information
  /// necessary for indentation.
  ///
  /// Puts the token on the current line if \p Newline is \c false and adds a
  /// line break and necessary indentation otherwise.
  ///
  /// If \p DryRun is \c false, also creates and stores the required
  /// \c Replacement.
  unsigned addTokenToState(LineState &State, bool Newline, bool DryRun,
                           unsigned ExtraSpaces = 0);

  /// Get the column limit for this line. This is the style's column
  /// limit, potentially reduced for preprocessor definitions.
  unsigned getColumnLimit(const LineState &State) const { return LanguageStyle.getColumnLimit(State); }

private:
  /// Mark the next token as consumed in \p State and modify its stacks
  /// accordingly.
  unsigned moveStateToNextToken(LineState &State, bool DryRun, bool Newline);

  /// Update 'State' according to the next token's fake left parentheses.
  void moveStatePastFakeLParens(LineState &State, bool Newline);
  /// Update 'State' according to the next token's fake r_parens.
  void moveStatePastFakeRParens(LineState &State);

  /// Update 'State' according to the next token being one of "(<{[".
  void moveStatePastScopeOpener(LineState &State, bool Newline);
  /// Update 'State' according to the next token being one of ")>}]".
  void moveStatePastScopeCloser(LineState &State);
  /// Update 'State' with the next token opening a nested block.
  void moveStateToNewBlock(LineState &State);

  /// Reformats a raw string literal.
  ///
  /// \returns An extra penalty induced by reformatting the token.
  unsigned reformatRawStringLiteral(const FormatToken &Current,
                                    LineState &State,
                                    const FormatStyle &RawStringStyle,
                                    bool DryRun, bool Newline);

  /// If the current token is at the end of the current line, handle
  /// the transition to the next line.
  unsigned handleEndOfLine(const FormatToken &Current, LineState &State,
                           bool DryRun, bool AllowBreak, bool Newline);

  /// If \p Current is a raw string that is configured to be reformatted,
  /// return the style to be used.
  llvm::Optional<FormatStyle> getRawStringStyle(const FormatToken &Current,
                                                const LineState &State) const;

  /// If the current token sticks out over the end of the line, break
  /// it if possible.
  ///
  /// \returns A pair (penalty, exceeded), where penalty is the extra penalty
  /// when tokens are broken or lines exceed the column limit, and exceeded
  /// indicates whether the algorithm purposefully left lines exceeding the
  /// column limit.
  ///
  /// The returned penalty will cover the cost of the additional line breaks
  /// and column limit violation in all lines except for the last one. The
  /// penalty for the column limit violation in the last line (and in single
  /// line tokens) is handled in \c addNextStateToQueue.
  ///
  /// \p Strict indicates whether reflowing is allowed to leave characters
  /// protruding the column limit; if true, lines will be split strictly within
  /// the column limit where possible; if false, words are allowed to protrude
  /// over the column limit as long as the penalty is less than the penalty
  /// of a break.
  std::pair<unsigned, bool> breakProtrudingToken(const FormatToken &Current,
                                                 LineState &State,
                                                 bool AllowBreak, bool DryRun,
                                                 bool Strict);

/* Future candidate for LanugageFormatStyle?
 *    Uses WhitespacesManager, but read-only.
 *    Uses CommentPragmasRegex, but read-only.
 */
  /// Returns the \c BreakableToken starting at \p Current, or nullptr
  /// if the current token cannot be broken.
  std::unique_ptr<BreakableToken>
  createBreakableToken(const FormatToken &Current, LineState &State,
                       bool AllowBreak) const;

  /// Appends the next token to \p State and updates information
  /// necessary for indentation.
  ///
  /// Puts the token on the current line.
  ///
  /// If \p DryRun is \c false, also creates and stores the required
  /// \c Replacement.
  void addTokenOnCurrentLine(LineState &State, bool DryRun,
                             unsigned ExtraSpaces);

  /// Appends the next token to \p State and updates information
  /// necessary for indentation.
  ///
  /// Adds a line break and necessary indentation.
  ///
  /// If \p DryRun is \c false, also creates and stores the required
  /// \c Replacement.
  unsigned addTokenOnNewLine(LineState &State, bool DryRun);

  /// Calculate the new column for a line wrap before the next token.
  unsigned getNewLineColumn(const LineState &State) const { return LanguageStyle.getNewLineColumn(State); }

  /// Adds a multiline token to the \p State.
  ///
  /// \returns Extra penalty for the first line of the literal: last line is
  /// handled in \c addNextStateToQueue, and the penalty for other lines doesn't
  /// matter, as we don't change them.
  unsigned addMultilineToken(const FormatToken &Current, LineState &State);

  const LanguageFormatStyle &LanguageStyle;
  const FormatStyle &Style;
  const SourceManager &SourceMgr;
  WhitespaceManager &Whitespaces;
  encoding::Encoding Encoding;
  bool BinPackInconclusiveFunctions;
  llvm::Regex CommentPragmasRegex;
  const RawStringFormatStyleManager RawStringFormats;
};

} // end namespace format
} // end namespace clang

#endif
