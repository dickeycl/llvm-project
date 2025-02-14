; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-linux-gnu | FileCheck %s

define { i64, i64 } @sub(i64 noundef %0, i64 noundef %1, i64 noundef %2, i64 noundef %3) {
; CHECK-LABEL: sub:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movq %rdi, %rax
; CHECK-NEXT:    subq %rdx, %rax
; CHECK-NEXT:    sbbq $0, %rsi
; CHECK-NEXT:    subq %rcx, %rsi
; CHECK-NEXT:    movq %rsi, %rdx
; CHECK-NEXT:    retq
  %5 = zext i64 %1 to i128
  %6 = shl nuw i128 %5, 64
  %7 = zext i64 %0 to i128
  %8 = zext i64 %3 to i128
  %9 = mul i128 %8, -18446744073709551616
  %10 = zext i64 %2 to i128
  %11 = or i128 %6, %7
  %12 = sub i128 %11, %10
  %13 = add i128 %12, %9
  %14 = trunc i128 %13 to i64
  %15 = lshr i128 %13, 64
  %16 = trunc i128 %15 to i64
  %17 = insertvalue { i64, i64 } poison, i64 %14, 0
  %18 = insertvalue { i64, i64 } %17, i64 %16, 1
  ret { i64, i64 } %18
}
