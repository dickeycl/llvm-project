//===--- IsAnyOf.h - Format C++ code ----------------------------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
///
/// \file
/// This file contains a helper function to test whether a value is equal to
/// any of a list of candidates. The object is to shorten code of the form
///   if ( enumval == A || enumval == B || enumval == C ... )
/// to
///   if ( isAnyOf(enumval, A, B, C ... ) )
///
//===----------------------------------------------------------------------===//

#ifndef CLANG_LIB_FORMAT_IS_ANY_OF_H
#define CLANG_LIB_FORMAT_IS_ANY_OF_H

namespace {

template<typename T, typename... V>
bool isAnyOf(T t, V ... v) {
  const auto pred = [t] (T v_n) { return t == v_n; };
  return (pred(v) || ...);
}

}

#endif
