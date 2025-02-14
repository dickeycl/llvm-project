; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=armv7a < %s | FileCheck %s --check-prefix=ARM
; RUN: llc -mtriple=armv6m < %s | FileCheck %s --check-prefix=THUMB
; RUN: llc -mtriple=armv7m < %s | FileCheck %s --check-prefix=THUMB2

define i1 @cmp_ne_zero_and_rr(i32 %a, i32 %b) {
; ARM-LABEL: cmp_ne_zero_and_rr:
; ARM:       @ %bb.0:
; ARM-NEXT:    ands r0, r0, r1
; ARM-NEXT:    movwne r0, #1
; ARM-NEXT:    bx lr
;
; THUMB-LABEL: cmp_ne_zero_and_rr:
; THUMB:       @ %bb.0:
; THUMB-NEXT:    ands r0, r1
; THUMB-NEXT:    subs r1, r0, #1
; THUMB-NEXT:    sbcs r0, r1
; THUMB-NEXT:    bx lr
;
; THUMB2-LABEL: cmp_ne_zero_and_rr:
; THUMB2:       @ %bb.0:
; THUMB2-NEXT:    ands r0, r1
; THUMB2-NEXT:    it ne
; THUMB2-NEXT:    movne r0, #1
; THUMB2-NEXT:    bx lr
  %and = and i32 %a, %b
  %res = icmp ne i32 %and, 0
  ret i1 %res
}

define i1 @cmp_ne_zero_and_ri(i32 %a) {
; ARM-LABEL: cmp_ne_zero_and_ri:
; ARM:       @ %bb.0:
; ARM-NEXT:    ands r0, r0, #42
; ARM-NEXT:    movwne r0, #1
; ARM-NEXT:    bx lr
;
; THUMB-LABEL: cmp_ne_zero_and_ri:
; THUMB:       @ %bb.0:
; THUMB-NEXT:    movs r1, #42
; THUMB-NEXT:    ands r0, r1
; THUMB-NEXT:    subs r1, r0, #1
; THUMB-NEXT:    sbcs r0, r1
; THUMB-NEXT:    bx lr
;
; THUMB2-LABEL: cmp_ne_zero_and_ri:
; THUMB2:       @ %bb.0:
; THUMB2-NEXT:    ands r0, r0, #42
; THUMB2-NEXT:    it ne
; THUMB2-NEXT:    movne r0, #1
; THUMB2-NEXT:    bx lr
  %and = and i32 %a, 42
  %res = icmp ne i32 %and, 0
  ret i1 %res
}

define i1 @cmp_ne_zero_and_rsr(i32 %a, i32 %b, i32 %c) {
; ARM-LABEL: cmp_ne_zero_and_rsr:
; ARM:       @ %bb.0:
; ARM-NEXT:    and r0, r0, r1, lsl r2
; ARM-NEXT:    cmp r0, #0
; ARM-NEXT:    movwne r0, #1
; ARM-NEXT:    bx lr
;
; THUMB-LABEL: cmp_ne_zero_and_rsr:
; THUMB:       @ %bb.0:
; THUMB-NEXT:    lsls r1, r2
; THUMB-NEXT:    ands r0, r1
; THUMB-NEXT:    subs r1, r0, #1
; THUMB-NEXT:    sbcs r0, r1
; THUMB-NEXT:    bx lr
;
; THUMB2-LABEL: cmp_ne_zero_and_rsr:
; THUMB2:       @ %bb.0:
; THUMB2-NEXT:    lsls r1, r2
; THUMB2-NEXT:    ands r0, r1
; THUMB2-NEXT:    it ne
; THUMB2-NEXT:    movne r0, #1
; THUMB2-NEXT:    bx lr
  %sh = shl i32 %b, %c
  %and = and i32 %sh, %a
  %res = icmp ne i32 %and, 0
  ret i1 %res
}

define i1 @cmp_ne_zero_and_rsi(i32 %a, i32 %b) {
; ARM-LABEL: cmp_ne_zero_and_rsi:
; ARM:       @ %bb.0:
; ARM-NEXT:    and r0, r0, r1, lsr #17
; ARM-NEXT:    cmp r0, #0
; ARM-NEXT:    movwne r0, #1
; ARM-NEXT:    bx lr
;
; THUMB-LABEL: cmp_ne_zero_and_rsi:
; THUMB:       @ %bb.0:
; THUMB-NEXT:    lsrs r1, r1, #17
; THUMB-NEXT:    ands r0, r1
; THUMB-NEXT:    subs r1, r0, #1
; THUMB-NEXT:    sbcs r0, r1
; THUMB-NEXT:    bx lr
;
; THUMB2-LABEL: cmp_ne_zero_and_rsi:
; THUMB2:       @ %bb.0:
; THUMB2-NEXT:    and.w r0, r0, r1, lsr #17
; THUMB2-NEXT:    cmp r0, #0
; THUMB2-NEXT:    it ne
; THUMB2-NEXT:    movne r0, #1
; THUMB2-NEXT:    bx lr
  %sh = lshr i32 %b, 17
  %and = and i32 %sh, %a
  %res = icmp ne i32 %and, 0
  ret i1 %res
}

define i1 @cmp_ne_zero_or_rr(i32 %a, i32 %b) {
; ARM-LABEL: cmp_ne_zero_or_rr:
; ARM:       @ %bb.0:
; ARM-NEXT:    orrs r0, r0, r1
; ARM-NEXT:    movwne r0, #1
; ARM-NEXT:    bx lr
;
; THUMB-LABEL: cmp_ne_zero_or_rr:
; THUMB:       @ %bb.0:
; THUMB-NEXT:    orrs r0, r1
; THUMB-NEXT:    subs r1, r0, #1
; THUMB-NEXT:    sbcs r0, r1
; THUMB-NEXT:    bx lr
;
; THUMB2-LABEL: cmp_ne_zero_or_rr:
; THUMB2:       @ %bb.0:
; THUMB2-NEXT:    orrs r0, r1
; THUMB2-NEXT:    it ne
; THUMB2-NEXT:    movne r0, #1
; THUMB2-NEXT:    bx lr
  %or = or i32 %a, %b
  %res = icmp ne i32 %or, 0
  ret i1 %res
}

define i1 @cmp_ne_zero_or_ri(i32 %a) {
; ARM-LABEL: cmp_ne_zero_or_ri:
; ARM:       @ %bb.0:
; ARM-NEXT:    orrs r0, r0, #42
; ARM-NEXT:    movwne r0, #1
; ARM-NEXT:    bx lr
;
; THUMB-LABEL: cmp_ne_zero_or_ri:
; THUMB:       @ %bb.0:
; THUMB-NEXT:    movs r1, #42
; THUMB-NEXT:    orrs r0, r1
; THUMB-NEXT:    subs r1, r0, #1
; THUMB-NEXT:    sbcs r0, r1
; THUMB-NEXT:    bx lr
;
; THUMB2-LABEL: cmp_ne_zero_or_ri:
; THUMB2:       @ %bb.0:
; THUMB2-NEXT:    orrs r0, r0, #42
; THUMB2-NEXT:    it ne
; THUMB2-NEXT:    movne r0, #1
; THUMB2-NEXT:    bx lr
  %or = or i32 %a, 42
  %res = icmp ne i32 %or, 0
  ret i1 %res
}

define i1 @cmp_ne_zero_or_rsr(i32 %a, i32 %b, i32 %c) {
; ARM-LABEL: cmp_ne_zero_or_rsr:
; ARM:       @ %bb.0:
; ARM-NEXT:    orr r0, r0, r1, lsl r2
; ARM-NEXT:    cmp r0, #0
; ARM-NEXT:    movwne r0, #1
; ARM-NEXT:    bx lr
;
; THUMB-LABEL: cmp_ne_zero_or_rsr:
; THUMB:       @ %bb.0:
; THUMB-NEXT:    lsls r1, r2
; THUMB-NEXT:    orrs r0, r1
; THUMB-NEXT:    subs r1, r0, #1
; THUMB-NEXT:    sbcs r0, r1
; THUMB-NEXT:    bx lr
;
; THUMB2-LABEL: cmp_ne_zero_or_rsr:
; THUMB2:       @ %bb.0:
; THUMB2-NEXT:    lsls r1, r2
; THUMB2-NEXT:    orrs r0, r1
; THUMB2-NEXT:    it ne
; THUMB2-NEXT:    movne r0, #1
; THUMB2-NEXT:    bx lr
  %sh = shl i32 %b, %c
  %or = or i32 %sh, %a
  %res = icmp ne i32 %or, 0
  ret i1 %res
}

define i1 @cmp_ne_zero_or_rsi(i32 %a, i32 %b) {
; ARM-LABEL: cmp_ne_zero_or_rsi:
; ARM:       @ %bb.0:
; ARM-NEXT:    orr r0, r0, r1, lsr #17
; ARM-NEXT:    cmp r0, #0
; ARM-NEXT:    movwne r0, #1
; ARM-NEXT:    bx lr
;
; THUMB-LABEL: cmp_ne_zero_or_rsi:
; THUMB:       @ %bb.0:
; THUMB-NEXT:    lsrs r1, r1, #17
; THUMB-NEXT:    orrs r0, r1
; THUMB-NEXT:    subs r1, r0, #1
; THUMB-NEXT:    sbcs r0, r1
; THUMB-NEXT:    bx lr
;
; THUMB2-LABEL: cmp_ne_zero_or_rsi:
; THUMB2:       @ %bb.0:
; THUMB2-NEXT:    orr.w r0, r0, r1, lsr #17
; THUMB2-NEXT:    cmp r0, #0
; THUMB2-NEXT:    it ne
; THUMB2-NEXT:    movne r0, #1
; THUMB2-NEXT:    bx lr
  %sh = lshr i32 %b, 17
  %or = or i32 %sh, %a
  %res = icmp ne i32 %or, 0
  ret i1 %res
}

define i1 @cmp_ne_zero_xor_rr(i32 %a, i32 %b) {
; ARM-LABEL: cmp_ne_zero_xor_rr:
; ARM:       @ %bb.0:
; ARM-NEXT:    eors r0, r0, r1
; ARM-NEXT:    movwne r0, #1
; ARM-NEXT:    bx lr
;
; THUMB-LABEL: cmp_ne_zero_xor_rr:
; THUMB:       @ %bb.0:
; THUMB-NEXT:    eors r0, r1
; THUMB-NEXT:    subs r1, r0, #1
; THUMB-NEXT:    sbcs r0, r1
; THUMB-NEXT:    bx lr
;
; THUMB2-LABEL: cmp_ne_zero_xor_rr:
; THUMB2:       @ %bb.0:
; THUMB2-NEXT:    eors r0, r1
; THUMB2-NEXT:    it ne
; THUMB2-NEXT:    movne r0, #1
; THUMB2-NEXT:    bx lr
  %xor = xor i32 %a, %b
  %res = icmp ne i32 %xor, 0
  ret i1 %res
}

define i1 @cmp_ne_zero_xor_ri(i32 %a) {
; ARM-LABEL: cmp_ne_zero_xor_ri:
; ARM:       @ %bb.0:
; ARM-NEXT:    subs r0, r0, #42
; ARM-NEXT:    movwne r0, #1
; ARM-NEXT:    bx lr
;
; THUMB-LABEL: cmp_ne_zero_xor_ri:
; THUMB:       @ %bb.0:
; THUMB-NEXT:    subs r0, #42
; THUMB-NEXT:    subs r1, r0, #1
; THUMB-NEXT:    sbcs r0, r1
; THUMB-NEXT:    bx lr
;
; THUMB2-LABEL: cmp_ne_zero_xor_ri:
; THUMB2:       @ %bb.0:
; THUMB2-NEXT:    subs r0, #42
; THUMB2-NEXT:    it ne
; THUMB2-NEXT:    movne r0, #1
; THUMB2-NEXT:    bx lr
  %xor = xor i32 %a, 42
  %res = icmp ne i32 %xor, 0
  ret i1 %res
}

define i1 @cmp_ne_zero_xor_rsr(i32 %a, i32 %b, i32 %c) {
; ARM-LABEL: cmp_ne_zero_xor_rsr:
; ARM:       @ %bb.0:
; ARM-NEXT:    eor r0, r0, r1, lsl r2
; ARM-NEXT:    cmp r0, #0
; ARM-NEXT:    movwne r0, #1
; ARM-NEXT:    bx lr
;
; THUMB-LABEL: cmp_ne_zero_xor_rsr:
; THUMB:       @ %bb.0:
; THUMB-NEXT:    lsls r1, r2
; THUMB-NEXT:    eors r0, r1
; THUMB-NEXT:    subs r1, r0, #1
; THUMB-NEXT:    sbcs r0, r1
; THUMB-NEXT:    bx lr
;
; THUMB2-LABEL: cmp_ne_zero_xor_rsr:
; THUMB2:       @ %bb.0:
; THUMB2-NEXT:    lsls r1, r2
; THUMB2-NEXT:    eors r0, r1
; THUMB2-NEXT:    it ne
; THUMB2-NEXT:    movne r0, #1
; THUMB2-NEXT:    bx lr
  %sh = shl i32 %b, %c
  %xor = xor i32 %sh, %a
  %res = icmp ne i32 %xor, 0
  ret i1 %res
}

define i1 @cmp_ne_zero_xor_rsi(i32 %a, i32 %b) {
; ARM-LABEL: cmp_ne_zero_xor_rsi:
; ARM:       @ %bb.0:
; ARM-NEXT:    eor r0, r0, r1, lsr #17
; ARM-NEXT:    cmp r0, #0
; ARM-NEXT:    movwne r0, #1
; ARM-NEXT:    bx lr
;
; THUMB-LABEL: cmp_ne_zero_xor_rsi:
; THUMB:       @ %bb.0:
; THUMB-NEXT:    lsrs r1, r1, #17
; THUMB-NEXT:    eors r0, r1
; THUMB-NEXT:    subs r1, r0, #1
; THUMB-NEXT:    sbcs r0, r1
; THUMB-NEXT:    bx lr
;
; THUMB2-LABEL: cmp_ne_zero_xor_rsi:
; THUMB2:       @ %bb.0:
; THUMB2-NEXT:    eor.w r0, r0, r1, lsr #17
; THUMB2-NEXT:    cmp r0, #0
; THUMB2-NEXT:    it ne
; THUMB2-NEXT:    movne r0, #1
; THUMB2-NEXT:    bx lr
  %sh = lshr i32 %b, 17
  %xor = xor i32 %sh, %a
  %res = icmp ne i32 %xor, 0
  ret i1 %res
}

define i1 @cmp_ne_zero_and_not_rr(i32 %a, i32 %b) {
; ARM-LABEL: cmp_ne_zero_and_not_rr:
; ARM:       @ %bb.0:
; ARM-NEXT:    bic r0, r0, r1
; ARM-NEXT:    cmp r0, #0
; ARM-NEXT:    movwne r0, #1
; ARM-NEXT:    bx lr
;
; THUMB-LABEL: cmp_ne_zero_and_not_rr:
; THUMB:       @ %bb.0:
; THUMB-NEXT:    bics r0, r1
; THUMB-NEXT:    subs r1, r0, #1
; THUMB-NEXT:    sbcs r0, r1
; THUMB-NEXT:    bx lr
;
; THUMB2-LABEL: cmp_ne_zero_and_not_rr:
; THUMB2:       @ %bb.0:
; THUMB2-NEXT:    bics r0, r1
; THUMB2-NEXT:    cmp r0, #0
; THUMB2-NEXT:    it ne
; THUMB2-NEXT:    movne r0, #1
; THUMB2-NEXT:    bx lr
  %not = xor i32 %b, -1
  %and = and i32 %a, %not
  %res = icmp ne i32 %and, 0
  ret i1 %res
}

define i1 @cmp_ne_zero_and_not_ri(i32 %a) {
; ARM-LABEL: cmp_ne_zero_and_not_ri:
; ARM:       @ %bb.0:
; ARM-NEXT:    bic r0, r0, #42
; ARM-NEXT:    cmp r0, #0
; ARM-NEXT:    movwne r0, #1
; ARM-NEXT:    bx lr
;
; THUMB-LABEL: cmp_ne_zero_and_not_ri:
; THUMB:       @ %bb.0:
; THUMB-NEXT:    movs r1, #42
; THUMB-NEXT:    bics r0, r1
; THUMB-NEXT:    subs r1, r0, #1
; THUMB-NEXT:    sbcs r0, r1
; THUMB-NEXT:    bx lr
;
; THUMB2-LABEL: cmp_ne_zero_and_not_ri:
; THUMB2:       @ %bb.0:
; THUMB2-NEXT:    bic r0, r0, #42
; THUMB2-NEXT:    cmp r0, #0
; THUMB2-NEXT:    it ne
; THUMB2-NEXT:    movne r0, #1
; THUMB2-NEXT:    bx lr
  %not = xor i32 42, -1
  %and = and i32 %a, %not
  %res = icmp ne i32 %and, 0
  ret i1 %res
}

define i1 @cmp_ne_zero_and_not_rsr(i32 %a, i32 %b, i32 %c) {
; ARM-LABEL: cmp_ne_zero_and_not_rsr:
; ARM:       @ %bb.0:
; ARM-NEXT:    bic r0, r0, r1, lsl r2
; ARM-NEXT:    cmp r0, #0
; ARM-NEXT:    movwne r0, #1
; ARM-NEXT:    bx lr
;
; THUMB-LABEL: cmp_ne_zero_and_not_rsr:
; THUMB:       @ %bb.0:
; THUMB-NEXT:    lsls r1, r2
; THUMB-NEXT:    bics r0, r1
; THUMB-NEXT:    subs r1, r0, #1
; THUMB-NEXT:    sbcs r0, r1
; THUMB-NEXT:    bx lr
;
; THUMB2-LABEL: cmp_ne_zero_and_not_rsr:
; THUMB2:       @ %bb.0:
; THUMB2-NEXT:    lsls r1, r2
; THUMB2-NEXT:    bics r0, r1
; THUMB2-NEXT:    cmp r0, #0
; THUMB2-NEXT:    it ne
; THUMB2-NEXT:    movne r0, #1
; THUMB2-NEXT:    bx lr
  %sh = shl i32 %b, %c
  %not = xor i32 %sh, -1
  %and = and i32 %not, %a
  %res = icmp ne i32 %and, 0
  ret i1 %res
}

define i1 @cmp_ne_zero_and_not_rsi(i32 %a, i32 %b) {
; ARM-LABEL: cmp_ne_zero_and_not_rsi:
; ARM:       @ %bb.0:
; ARM-NEXT:    bic r0, r0, r1, lsr #17
; ARM-NEXT:    cmp r0, #0
; ARM-NEXT:    movwne r0, #1
; ARM-NEXT:    bx lr
;
; THUMB-LABEL: cmp_ne_zero_and_not_rsi:
; THUMB:       @ %bb.0:
; THUMB-NEXT:    lsrs r1, r1, #17
; THUMB-NEXT:    bics r0, r1
; THUMB-NEXT:    subs r1, r0, #1
; THUMB-NEXT:    sbcs r0, r1
; THUMB-NEXT:    bx lr
;
; THUMB2-LABEL: cmp_ne_zero_and_not_rsi:
; THUMB2:       @ %bb.0:
; THUMB2-NEXT:    bic.w r0, r0, r1, lsr #17
; THUMB2-NEXT:    cmp r0, #0
; THUMB2-NEXT:    it ne
; THUMB2-NEXT:    movne r0, #1
; THUMB2-NEXT:    bx lr
  %sh = lshr i32 %b, 17
  %not = xor i32 %sh, -1
  %and = and i32 %not, %a
  %res = icmp ne i32 %and, 0
  ret i1 %res
}

define i1 @cmp_ne_zero_shl_rr(i32 %a, i32 %b) {
; ARM-LABEL: cmp_ne_zero_shl_rr:
; ARM:       @ %bb.0:
; ARM-NEXT:    mov r3, #0
; ARM-NEXT:    lsl r2, r0, r1
; ARM-NEXT:    cmp r3, r0, lsl r1
; ARM-NEXT:    movwne r2, #1
; ARM-NEXT:    mov r0, r2
; ARM-NEXT:    bx lr
;
; THUMB-LABEL: cmp_ne_zero_shl_rr:
; THUMB:       @ %bb.0:
; THUMB-NEXT:    lsls r0, r1
; THUMB-NEXT:    subs r1, r0, #1
; THUMB-NEXT:    sbcs r0, r1
; THUMB-NEXT:    bx lr
;
; THUMB2-LABEL: cmp_ne_zero_shl_rr:
; THUMB2:       @ %bb.0:
; THUMB2-NEXT:    lsls r0, r1
; THUMB2-NEXT:    it ne
; THUMB2-NEXT:    movne r0, #1
; THUMB2-NEXT:    bx lr
    %sh = shl i32 %a, %b
    %cmp = icmp ne i32 %sh, 0
    ret i1 %cmp
}

define i1 @cmp_ne_zero_shl_ri(i32 %a) {
; ARM-LABEL: cmp_ne_zero_shl_ri:
; ARM:       @ %bb.0:
; ARM-NEXT:    mov r2, #0
; ARM-NEXT:    lsl r1, r0, #7
; ARM-NEXT:    cmp r2, r0, lsl #7
; ARM-NEXT:    movwne r1, #1
; ARM-NEXT:    mov r0, r1
; ARM-NEXT:    bx lr
;
; THUMB-LABEL: cmp_ne_zero_shl_ri:
; THUMB:       @ %bb.0:
; THUMB-NEXT:    lsls r0, r0, #7
; THUMB-NEXT:    subs r1, r0, #1
; THUMB-NEXT:    sbcs r0, r1
; THUMB-NEXT:    bx lr
;
; THUMB2-LABEL: cmp_ne_zero_shl_ri:
; THUMB2:       @ %bb.0:
; THUMB2-NEXT:    lsls r0, r0, #7
; THUMB2-NEXT:    it ne
; THUMB2-NEXT:    movne r0, #1
; THUMB2-NEXT:    bx lr
    %sh = shl i32 %a, 7
    %cmp = icmp ne i32 %sh, 0
    ret i1 %cmp
}

define i1 @cmp_ne_zero_lshr_rr(i32 %a, i32 %b) {
; ARM-LABEL: cmp_ne_zero_lshr_rr:
; ARM:       @ %bb.0:
; ARM-NEXT:    mov r3, #0
; ARM-NEXT:    lsr r2, r0, r1
; ARM-NEXT:    cmp r3, r0, lsr r1
; ARM-NEXT:    movwne r2, #1
; ARM-NEXT:    mov r0, r2
; ARM-NEXT:    bx lr
;
; THUMB-LABEL: cmp_ne_zero_lshr_rr:
; THUMB:       @ %bb.0:
; THUMB-NEXT:    lsrs r0, r1
; THUMB-NEXT:    subs r1, r0, #1
; THUMB-NEXT:    sbcs r0, r1
; THUMB-NEXT:    bx lr
;
; THUMB2-LABEL: cmp_ne_zero_lshr_rr:
; THUMB2:       @ %bb.0:
; THUMB2-NEXT:    lsrs r0, r1
; THUMB2-NEXT:    it ne
; THUMB2-NEXT:    movne r0, #1
; THUMB2-NEXT:    bx lr
    %sh = lshr i32 %a, %b
    %cmp = icmp ne i32 %sh, 0
    ret i1 %cmp
}

define i1 @cmp_ne_zero_lshr_ri(i32 %a) {
; ARM-LABEL: cmp_ne_zero_lshr_ri:
; ARM:       @ %bb.0:
; ARM-NEXT:    mov r2, #0
; ARM-NEXT:    lsr r1, r0, #7
; ARM-NEXT:    cmp r2, r0, lsr #7
; ARM-NEXT:    movwne r1, #1
; ARM-NEXT:    mov r0, r1
; ARM-NEXT:    bx lr
;
; THUMB-LABEL: cmp_ne_zero_lshr_ri:
; THUMB:       @ %bb.0:
; THUMB-NEXT:    lsrs r0, r0, #7
; THUMB-NEXT:    subs r1, r0, #1
; THUMB-NEXT:    sbcs r0, r1
; THUMB-NEXT:    bx lr
;
; THUMB2-LABEL: cmp_ne_zero_lshr_ri:
; THUMB2:       @ %bb.0:
; THUMB2-NEXT:    lsrs r0, r0, #7
; THUMB2-NEXT:    it ne
; THUMB2-NEXT:    movne r0, #1
; THUMB2-NEXT:    bx lr
    %sh = lshr i32 %a, 7
    %cmp = icmp ne i32 %sh, 0
    ret i1 %cmp
}

define i1 @cmp_ne_zero_ashr_rr(i32 %a, i32 %b) {
; ARM-LABEL: cmp_ne_zero_ashr_rr:
; ARM:       @ %bb.0:
; ARM-NEXT:    mov r3, #0
; ARM-NEXT:    asr r2, r0, r1
; ARM-NEXT:    cmp r3, r0, asr r1
; ARM-NEXT:    movwne r2, #1
; ARM-NEXT:    mov r0, r2
; ARM-NEXT:    bx lr
;
; THUMB-LABEL: cmp_ne_zero_ashr_rr:
; THUMB:       @ %bb.0:
; THUMB-NEXT:    asrs r0, r1
; THUMB-NEXT:    subs r1, r0, #1
; THUMB-NEXT:    sbcs r0, r1
; THUMB-NEXT:    bx lr
;
; THUMB2-LABEL: cmp_ne_zero_ashr_rr:
; THUMB2:       @ %bb.0:
; THUMB2-NEXT:    asrs r0, r1
; THUMB2-NEXT:    cmp r0, #0
; THUMB2-NEXT:    it ne
; THUMB2-NEXT:    movne r0, #1
; THUMB2-NEXT:    bx lr
    %sh = ashr i32 %a, %b
    %cmp = icmp ne i32 %sh, 0
    ret i1 %cmp
}

define i1 @cmp_ne_zero_ashr_ri(i32 %a) {
; ARM-LABEL: cmp_ne_zero_ashr_ri:
; ARM:       @ %bb.0:
; ARM-NEXT:    mov r2, #0
; ARM-NEXT:    asr r1, r0, #7
; ARM-NEXT:    cmp r2, r0, asr #7
; ARM-NEXT:    movwne r1, #1
; ARM-NEXT:    mov r0, r1
; ARM-NEXT:    bx lr
;
; THUMB-LABEL: cmp_ne_zero_ashr_ri:
; THUMB:       @ %bb.0:
; THUMB-NEXT:    asrs r0, r0, #7
; THUMB-NEXT:    subs r1, r0, #1
; THUMB-NEXT:    sbcs r0, r1
; THUMB-NEXT:    bx lr
;
; THUMB2-LABEL: cmp_ne_zero_ashr_ri:
; THUMB2:       @ %bb.0:
; THUMB2-NEXT:    asrs r0, r0, #7
; THUMB2-NEXT:    cmp r0, #0
; THUMB2-NEXT:    it ne
; THUMB2-NEXT:    movne r0, #1
; THUMB2-NEXT:    bx lr
    %sh = ashr i32 %a, 7
    %cmp = icmp ne i32 %sh, 0
    ret i1 %cmp
}

define i1 @cmp_eq_zero_and_rr(i32 %a, i32 %b) {
; ARM-LABEL: cmp_eq_zero_and_rr:
; ARM:       @ %bb.0:
; ARM-NEXT:    and r0, r0, r1
; ARM-NEXT:    clz r0, r0
; ARM-NEXT:    lsr r0, r0, #5
; ARM-NEXT:    bx lr
;
; THUMB-LABEL: cmp_eq_zero_and_rr:
; THUMB:       @ %bb.0:
; THUMB-NEXT:    ands r0, r1
; THUMB-NEXT:    rsbs r1, r0, #0
; THUMB-NEXT:    adcs r0, r1
; THUMB-NEXT:    bx lr
;
; THUMB2-LABEL: cmp_eq_zero_and_rr:
; THUMB2:       @ %bb.0:
; THUMB2-NEXT:    ands r0, r1
; THUMB2-NEXT:    clz r0, r0
; THUMB2-NEXT:    lsrs r0, r0, #5
; THUMB2-NEXT:    bx lr
  %and = and i32 %a, %b
  %res = icmp eq i32 %and, 0
  ret i1 %res
}

define i1 @cmp_eq_zero_and_ri(i32 %a) {
; ARM-LABEL: cmp_eq_zero_and_ri:
; ARM:       @ %bb.0:
; ARM-NEXT:    and r0, r0, #42
; ARM-NEXT:    clz r0, r0
; ARM-NEXT:    lsr r0, r0, #5
; ARM-NEXT:    bx lr
;
; THUMB-LABEL: cmp_eq_zero_and_ri:
; THUMB:       @ %bb.0:
; THUMB-NEXT:    movs r1, #42
; THUMB-NEXT:    ands r0, r1
; THUMB-NEXT:    rsbs r1, r0, #0
; THUMB-NEXT:    adcs r0, r1
; THUMB-NEXT:    bx lr
;
; THUMB2-LABEL: cmp_eq_zero_and_ri:
; THUMB2:       @ %bb.0:
; THUMB2-NEXT:    and r0, r0, #42
; THUMB2-NEXT:    clz r0, r0
; THUMB2-NEXT:    lsrs r0, r0, #5
; THUMB2-NEXT:    bx lr
  %and = and i32 %a, 42
  %res = icmp eq i32 %and, 0
  ret i1 %res
}

define i1 @cmp_eq_zero_and_rsr(i32 %a, i32 %b, i32 %c) {
; ARM-LABEL: cmp_eq_zero_and_rsr:
; ARM:       @ %bb.0:
; ARM-NEXT:    and r0, r0, r1, lsl r2
; ARM-NEXT:    clz r0, r0
; ARM-NEXT:    lsr r0, r0, #5
; ARM-NEXT:    bx lr
;
; THUMB-LABEL: cmp_eq_zero_and_rsr:
; THUMB:       @ %bb.0:
; THUMB-NEXT:    lsls r1, r2
; THUMB-NEXT:    ands r0, r1
; THUMB-NEXT:    rsbs r1, r0, #0
; THUMB-NEXT:    adcs r0, r1
; THUMB-NEXT:    bx lr
;
; THUMB2-LABEL: cmp_eq_zero_and_rsr:
; THUMB2:       @ %bb.0:
; THUMB2-NEXT:    lsls r1, r2
; THUMB2-NEXT:    ands r0, r1
; THUMB2-NEXT:    clz r0, r0
; THUMB2-NEXT:    lsrs r0, r0, #5
; THUMB2-NEXT:    bx lr
  %sh = shl i32 %b, %c
  %and = and i32 %sh, %a
  %res = icmp eq i32 %and, 0
  ret i1 %res
}

define i1 @cmp_eq_zero_and_rsi(i32 %a, i32 %b) {
; ARM-LABEL: cmp_eq_zero_and_rsi:
; ARM:       @ %bb.0:
; ARM-NEXT:    and r0, r0, r1, lsr #17
; ARM-NEXT:    clz r0, r0
; ARM-NEXT:    lsr r0, r0, #5
; ARM-NEXT:    bx lr
;
; THUMB-LABEL: cmp_eq_zero_and_rsi:
; THUMB:       @ %bb.0:
; THUMB-NEXT:    lsrs r1, r1, #17
; THUMB-NEXT:    ands r0, r1
; THUMB-NEXT:    rsbs r1, r0, #0
; THUMB-NEXT:    adcs r0, r1
; THUMB-NEXT:    bx lr
;
; THUMB2-LABEL: cmp_eq_zero_and_rsi:
; THUMB2:       @ %bb.0:
; THUMB2-NEXT:    and.w r0, r0, r1, lsr #17
; THUMB2-NEXT:    clz r0, r0
; THUMB2-NEXT:    lsrs r0, r0, #5
; THUMB2-NEXT:    bx lr
  %sh = lshr i32 %b, 17
  %and = and i32 %sh, %a
  %res = icmp eq i32 %and, 0
  ret i1 %res
}

define i1 @cmp_eq_zero_or_rr(i32 %a, i32 %b) {
; ARM-LABEL: cmp_eq_zero_or_rr:
; ARM:       @ %bb.0:
; ARM-NEXT:    orr r0, r0, r1
; ARM-NEXT:    clz r0, r0
; ARM-NEXT:    lsr r0, r0, #5
; ARM-NEXT:    bx lr
;
; THUMB-LABEL: cmp_eq_zero_or_rr:
; THUMB:       @ %bb.0:
; THUMB-NEXT:    orrs r0, r1
; THUMB-NEXT:    rsbs r1, r0, #0
; THUMB-NEXT:    adcs r0, r1
; THUMB-NEXT:    bx lr
;
; THUMB2-LABEL: cmp_eq_zero_or_rr:
; THUMB2:       @ %bb.0:
; THUMB2-NEXT:    orrs r0, r1
; THUMB2-NEXT:    clz r0, r0
; THUMB2-NEXT:    lsrs r0, r0, #5
; THUMB2-NEXT:    bx lr
  %or = or i32 %a, %b
  %res = icmp eq i32 %or, 0
  ret i1 %res
}

define i1 @cmp_eq_zero_or_ri(i32 %a) {
; ARM-LABEL: cmp_eq_zero_or_ri:
; ARM:       @ %bb.0:
; ARM-NEXT:    mov r0, #0
; ARM-NEXT:    bx lr
;
; THUMB-LABEL: cmp_eq_zero_or_ri:
; THUMB:       @ %bb.0:
; THUMB-NEXT:    movs r1, #42
; THUMB-NEXT:    orrs r0, r1
; THUMB-NEXT:    rsbs r1, r0, #0
; THUMB-NEXT:    adcs r0, r1
; THUMB-NEXT:    bx lr
;
; THUMB2-LABEL: cmp_eq_zero_or_ri:
; THUMB2:       @ %bb.0:
; THUMB2-NEXT:    movs r0, #0
; THUMB2-NEXT:    bx lr
  %or = or i32 %a, 42
  %res = icmp eq i32 %or, 0
  ret i1 %res
}

define i1 @cmp_eq_zero_or_rsr(i32 %a, i32 %b, i32 %c) {
; ARM-LABEL: cmp_eq_zero_or_rsr:
; ARM:       @ %bb.0:
; ARM-NEXT:    orr r0, r0, r1, lsl r2
; ARM-NEXT:    clz r0, r0
; ARM-NEXT:    lsr r0, r0, #5
; ARM-NEXT:    bx lr
;
; THUMB-LABEL: cmp_eq_zero_or_rsr:
; THUMB:       @ %bb.0:
; THUMB-NEXT:    lsls r1, r2
; THUMB-NEXT:    orrs r0, r1
; THUMB-NEXT:    rsbs r1, r0, #0
; THUMB-NEXT:    adcs r0, r1
; THUMB-NEXT:    bx lr
;
; THUMB2-LABEL: cmp_eq_zero_or_rsr:
; THUMB2:       @ %bb.0:
; THUMB2-NEXT:    lsls r1, r2
; THUMB2-NEXT:    orrs r0, r1
; THUMB2-NEXT:    clz r0, r0
; THUMB2-NEXT:    lsrs r0, r0, #5
; THUMB2-NEXT:    bx lr
  %sh = shl i32 %b, %c
  %or = or i32 %sh, %a
  %res = icmp eq i32 %or, 0
  ret i1 %res
}

define i1 @cmp_eq_zero_or_rsi(i32 %a, i32 %b) {
; ARM-LABEL: cmp_eq_zero_or_rsi:
; ARM:       @ %bb.0:
; ARM-NEXT:    orr r0, r0, r1, lsr #17
; ARM-NEXT:    clz r0, r0
; ARM-NEXT:    lsr r0, r0, #5
; ARM-NEXT:    bx lr
;
; THUMB-LABEL: cmp_eq_zero_or_rsi:
; THUMB:       @ %bb.0:
; THUMB-NEXT:    lsrs r1, r1, #17
; THUMB-NEXT:    orrs r0, r1
; THUMB-NEXT:    rsbs r1, r0, #0
; THUMB-NEXT:    adcs r0, r1
; THUMB-NEXT:    bx lr
;
; THUMB2-LABEL: cmp_eq_zero_or_rsi:
; THUMB2:       @ %bb.0:
; THUMB2-NEXT:    orr.w r0, r0, r1, lsr #17
; THUMB2-NEXT:    clz r0, r0
; THUMB2-NEXT:    lsrs r0, r0, #5
; THUMB2-NEXT:    bx lr
  %sh = lshr i32 %b, 17
  %or = or i32 %sh, %a
  %res = icmp eq i32 %or, 0
  ret i1 %res
}

define i1 @cmp_eq_zero_xor_rr(i32 %a, i32 %b) {
; ARM-LABEL: cmp_eq_zero_xor_rr:
; ARM:       @ %bb.0:
; ARM-NEXT:    eor r0, r0, r1
; ARM-NEXT:    clz r0, r0
; ARM-NEXT:    lsr r0, r0, #5
; ARM-NEXT:    bx lr
;
; THUMB-LABEL: cmp_eq_zero_xor_rr:
; THUMB:       @ %bb.0:
; THUMB-NEXT:    eors r0, r1
; THUMB-NEXT:    rsbs r1, r0, #0
; THUMB-NEXT:    adcs r0, r1
; THUMB-NEXT:    bx lr
;
; THUMB2-LABEL: cmp_eq_zero_xor_rr:
; THUMB2:       @ %bb.0:
; THUMB2-NEXT:    eors r0, r1
; THUMB2-NEXT:    clz r0, r0
; THUMB2-NEXT:    lsrs r0, r0, #5
; THUMB2-NEXT:    bx lr
  %xor = xor i32 %a, %b
  %res = icmp eq i32 %xor, 0
  ret i1 %res
}

define i1 @cmp_eq_zero_xor_ri(i32 %a) {
; ARM-LABEL: cmp_eq_zero_xor_ri:
; ARM:       @ %bb.0:
; ARM-NEXT:    sub r0, r0, #42
; ARM-NEXT:    clz r0, r0
; ARM-NEXT:    lsr r0, r0, #5
; ARM-NEXT:    bx lr
;
; THUMB-LABEL: cmp_eq_zero_xor_ri:
; THUMB:       @ %bb.0:
; THUMB-NEXT:    subs r0, #42
; THUMB-NEXT:    rsbs r1, r0, #0
; THUMB-NEXT:    adcs r0, r1
; THUMB-NEXT:    bx lr
;
; THUMB2-LABEL: cmp_eq_zero_xor_ri:
; THUMB2:       @ %bb.0:
; THUMB2-NEXT:    subs r0, #42
; THUMB2-NEXT:    clz r0, r0
; THUMB2-NEXT:    lsrs r0, r0, #5
; THUMB2-NEXT:    bx lr
  %xor = xor i32 %a, 42
  %res = icmp eq i32 %xor, 0
  ret i1 %res
}

define i1 @cmp_eq_zero_xor_rsr(i32 %a, i32 %b, i32 %c) {
; ARM-LABEL: cmp_eq_zero_xor_rsr:
; ARM:       @ %bb.0:
; ARM-NEXT:    eor r0, r0, r1, lsl r2
; ARM-NEXT:    clz r0, r0
; ARM-NEXT:    lsr r0, r0, #5
; ARM-NEXT:    bx lr
;
; THUMB-LABEL: cmp_eq_zero_xor_rsr:
; THUMB:       @ %bb.0:
; THUMB-NEXT:    lsls r1, r2
; THUMB-NEXT:    eors r0, r1
; THUMB-NEXT:    rsbs r1, r0, #0
; THUMB-NEXT:    adcs r0, r1
; THUMB-NEXT:    bx lr
;
; THUMB2-LABEL: cmp_eq_zero_xor_rsr:
; THUMB2:       @ %bb.0:
; THUMB2-NEXT:    lsls r1, r2
; THUMB2-NEXT:    eors r0, r1
; THUMB2-NEXT:    clz r0, r0
; THUMB2-NEXT:    lsrs r0, r0, #5
; THUMB2-NEXT:    bx lr
  %sh = shl i32 %b, %c
  %xor = xor i32 %sh, %a
  %res = icmp eq i32 %xor, 0
  ret i1 %res
}

define i1 @cmp_eq_zero_xor_rsi(i32 %a, i32 %b) {
; ARM-LABEL: cmp_eq_zero_xor_rsi:
; ARM:       @ %bb.0:
; ARM-NEXT:    eor r0, r0, r1, lsr #17
; ARM-NEXT:    clz r0, r0
; ARM-NEXT:    lsr r0, r0, #5
; ARM-NEXT:    bx lr
;
; THUMB-LABEL: cmp_eq_zero_xor_rsi:
; THUMB:       @ %bb.0:
; THUMB-NEXT:    lsrs r1, r1, #17
; THUMB-NEXT:    eors r0, r1
; THUMB-NEXT:    rsbs r1, r0, #0
; THUMB-NEXT:    adcs r0, r1
; THUMB-NEXT:    bx lr
;
; THUMB2-LABEL: cmp_eq_zero_xor_rsi:
; THUMB2:       @ %bb.0:
; THUMB2-NEXT:    eor.w r0, r0, r1, lsr #17
; THUMB2-NEXT:    clz r0, r0
; THUMB2-NEXT:    lsrs r0, r0, #5
; THUMB2-NEXT:    bx lr
  %sh = lshr i32 %b, 17
  %xor = xor i32 %sh, %a
  %res = icmp eq i32 %xor, 0
  ret i1 %res
}

define i1 @cmp_eq_zero_and_not_rr(i32 %a, i32 %b) {
; ARM-LABEL: cmp_eq_zero_and_not_rr:
; ARM:       @ %bb.0:
; ARM-NEXT:    bic r0, r0, r1
; ARM-NEXT:    clz r0, r0
; ARM-NEXT:    lsr r0, r0, #5
; ARM-NEXT:    bx lr
;
; THUMB-LABEL: cmp_eq_zero_and_not_rr:
; THUMB:       @ %bb.0:
; THUMB-NEXT:    bics r0, r1
; THUMB-NEXT:    rsbs r1, r0, #0
; THUMB-NEXT:    adcs r0, r1
; THUMB-NEXT:    bx lr
;
; THUMB2-LABEL: cmp_eq_zero_and_not_rr:
; THUMB2:       @ %bb.0:
; THUMB2-NEXT:    bics r0, r1
; THUMB2-NEXT:    clz r0, r0
; THUMB2-NEXT:    lsrs r0, r0, #5
; THUMB2-NEXT:    bx lr
  %not = xor i32 %b, -1
  %and = and i32 %a, %not
  %res = icmp eq i32 %and, 0
  ret i1 %res
}

define i1 @cmp_eq_zero_and_not_ri(i32 %a) {
; ARM-LABEL: cmp_eq_zero_and_not_ri:
; ARM:       @ %bb.0:
; ARM-NEXT:    bic r0, r0, #42
; ARM-NEXT:    clz r0, r0
; ARM-NEXT:    lsr r0, r0, #5
; ARM-NEXT:    bx lr
;
; THUMB-LABEL: cmp_eq_zero_and_not_ri:
; THUMB:       @ %bb.0:
; THUMB-NEXT:    movs r1, #42
; THUMB-NEXT:    bics r0, r1
; THUMB-NEXT:    rsbs r1, r0, #0
; THUMB-NEXT:    adcs r0, r1
; THUMB-NEXT:    bx lr
;
; THUMB2-LABEL: cmp_eq_zero_and_not_ri:
; THUMB2:       @ %bb.0:
; THUMB2-NEXT:    bic r0, r0, #42
; THUMB2-NEXT:    clz r0, r0
; THUMB2-NEXT:    lsrs r0, r0, #5
; THUMB2-NEXT:    bx lr
  %not = xor i32 42, -1
  %and = and i32 %a, %not
  %res = icmp eq i32 %and, 0
  ret i1 %res
}

define i1 @cmp_eq_zero_and_not_rsr(i32 %a, i32 %b, i32 %c) {
; ARM-LABEL: cmp_eq_zero_and_not_rsr:
; ARM:       @ %bb.0:
; ARM-NEXT:    bic r0, r0, r1, lsl r2
; ARM-NEXT:    clz r0, r0
; ARM-NEXT:    lsr r0, r0, #5
; ARM-NEXT:    bx lr
;
; THUMB-LABEL: cmp_eq_zero_and_not_rsr:
; THUMB:       @ %bb.0:
; THUMB-NEXT:    lsls r1, r2
; THUMB-NEXT:    bics r0, r1
; THUMB-NEXT:    rsbs r1, r0, #0
; THUMB-NEXT:    adcs r0, r1
; THUMB-NEXT:    bx lr
;
; THUMB2-LABEL: cmp_eq_zero_and_not_rsr:
; THUMB2:       @ %bb.0:
; THUMB2-NEXT:    lsls r1, r2
; THUMB2-NEXT:    bics r0, r1
; THUMB2-NEXT:    clz r0, r0
; THUMB2-NEXT:    lsrs r0, r0, #5
; THUMB2-NEXT:    bx lr
  %sh = shl i32 %b, %c
  %not = xor i32 %sh, -1
  %and = and i32 %not, %a
  %res = icmp eq i32 %and, 0
  ret i1 %res
}

define i1 @cmp_eq_zero_and_not_rsi(i32 %a, i32 %b) {
; ARM-LABEL: cmp_eq_zero_and_not_rsi:
; ARM:       @ %bb.0:
; ARM-NEXT:    bic r0, r0, r1, lsr #17
; ARM-NEXT:    clz r0, r0
; ARM-NEXT:    lsr r0, r0, #5
; ARM-NEXT:    bx lr
;
; THUMB-LABEL: cmp_eq_zero_and_not_rsi:
; THUMB:       @ %bb.0:
; THUMB-NEXT:    lsrs r1, r1, #17
; THUMB-NEXT:    bics r0, r1
; THUMB-NEXT:    rsbs r1, r0, #0
; THUMB-NEXT:    adcs r0, r1
; THUMB-NEXT:    bx lr
;
; THUMB2-LABEL: cmp_eq_zero_and_not_rsi:
; THUMB2:       @ %bb.0:
; THUMB2-NEXT:    bic.w r0, r0, r1, lsr #17
; THUMB2-NEXT:    clz r0, r0
; THUMB2-NEXT:    lsrs r0, r0, #5
; THUMB2-NEXT:    bx lr
  %sh = lshr i32 %b, 17
  %not = xor i32 %sh, -1
  %and = and i32 %not, %a
  %res = icmp eq i32 %and, 0
  ret i1 %res
}

define i1 @cmp_eq_zero_shl_rr(i32 %a, i32 %b) {
; ARM-LABEL: cmp_eq_zero_shl_rr:
; ARM:       @ %bb.0:
; ARM-NEXT:    lsl r0, r0, r1
; ARM-NEXT:    clz r0, r0
; ARM-NEXT:    lsr r0, r0, #5
; ARM-NEXT:    bx lr
;
; THUMB-LABEL: cmp_eq_zero_shl_rr:
; THUMB:       @ %bb.0:
; THUMB-NEXT:    lsls r0, r1
; THUMB-NEXT:    rsbs r1, r0, #0
; THUMB-NEXT:    adcs r0, r1
; THUMB-NEXT:    bx lr
;
; THUMB2-LABEL: cmp_eq_zero_shl_rr:
; THUMB2:       @ %bb.0:
; THUMB2-NEXT:    lsls r0, r1
; THUMB2-NEXT:    clz r0, r0
; THUMB2-NEXT:    lsrs r0, r0, #5
; THUMB2-NEXT:    bx lr
    %sh = shl i32 %a, %b
    %cmp = icmp eq i32 %sh, 0
    ret i1 %cmp
}

define i1 @cmp_eq_zero_shl_ri(i32 %a) {
; ARM-LABEL: cmp_eq_zero_shl_ri:
; ARM:       @ %bb.0:
; ARM-NEXT:    lsl r0, r0, #7
; ARM-NEXT:    clz r0, r0
; ARM-NEXT:    lsr r0, r0, #5
; ARM-NEXT:    bx lr
;
; THUMB-LABEL: cmp_eq_zero_shl_ri:
; THUMB:       @ %bb.0:
; THUMB-NEXT:    lsls r1, r0, #7
; THUMB-NEXT:    rsbs r0, r1, #0
; THUMB-NEXT:    adcs r0, r1
; THUMB-NEXT:    bx lr
;
; THUMB2-LABEL: cmp_eq_zero_shl_ri:
; THUMB2:       @ %bb.0:
; THUMB2-NEXT:    lsls r0, r0, #7
; THUMB2-NEXT:    clz r0, r0
; THUMB2-NEXT:    lsrs r0, r0, #5
; THUMB2-NEXT:    bx lr
    %sh = shl i32 %a, 7
    %cmp = icmp eq i32 %sh, 0
    ret i1 %cmp
}

define i1 @cmp_eq_zero_lshr_rr(i32 %a, i32 %b) {
; ARM-LABEL: cmp_eq_zero_lshr_rr:
; ARM:       @ %bb.0:
; ARM-NEXT:    lsr r0, r0, r1
; ARM-NEXT:    clz r0, r0
; ARM-NEXT:    lsr r0, r0, #5
; ARM-NEXT:    bx lr
;
; THUMB-LABEL: cmp_eq_zero_lshr_rr:
; THUMB:       @ %bb.0:
; THUMB-NEXT:    lsrs r0, r1
; THUMB-NEXT:    rsbs r1, r0, #0
; THUMB-NEXT:    adcs r0, r1
; THUMB-NEXT:    bx lr
;
; THUMB2-LABEL: cmp_eq_zero_lshr_rr:
; THUMB2:       @ %bb.0:
; THUMB2-NEXT:    lsrs r0, r1
; THUMB2-NEXT:    clz r0, r0
; THUMB2-NEXT:    lsrs r0, r0, #5
; THUMB2-NEXT:    bx lr
    %sh = lshr i32 %a, %b
    %cmp = icmp eq i32 %sh, 0
    ret i1 %cmp
}

define i1 @cmp_eq_zero_lshr_ri(i32 %a) {
; ARM-LABEL: cmp_eq_zero_lshr_ri:
; ARM:       @ %bb.0:
; ARM-NEXT:    lsr r0, r0, #7
; ARM-NEXT:    clz r0, r0
; ARM-NEXT:    lsr r0, r0, #5
; ARM-NEXT:    bx lr
;
; THUMB-LABEL: cmp_eq_zero_lshr_ri:
; THUMB:       @ %bb.0:
; THUMB-NEXT:    lsrs r1, r0, #7
; THUMB-NEXT:    rsbs r0, r1, #0
; THUMB-NEXT:    adcs r0, r1
; THUMB-NEXT:    bx lr
;
; THUMB2-LABEL: cmp_eq_zero_lshr_ri:
; THUMB2:       @ %bb.0:
; THUMB2-NEXT:    lsrs r0, r0, #7
; THUMB2-NEXT:    clz r0, r0
; THUMB2-NEXT:    lsrs r0, r0, #5
; THUMB2-NEXT:    bx lr
    %sh = lshr i32 %a, 7
    %cmp = icmp eq i32 %sh, 0
    ret i1 %cmp
}

define i1 @cmp_eq_zero_ashr_rr(i32 %a, i32 %b) {
; ARM-LABEL: cmp_eq_zero_ashr_rr:
; ARM:       @ %bb.0:
; ARM-NEXT:    asr r0, r0, r1
; ARM-NEXT:    clz r0, r0
; ARM-NEXT:    lsr r0, r0, #5
; ARM-NEXT:    bx lr
;
; THUMB-LABEL: cmp_eq_zero_ashr_rr:
; THUMB:       @ %bb.0:
; THUMB-NEXT:    asrs r0, r1
; THUMB-NEXT:    rsbs r1, r0, #0
; THUMB-NEXT:    adcs r0, r1
; THUMB-NEXT:    bx lr
;
; THUMB2-LABEL: cmp_eq_zero_ashr_rr:
; THUMB2:       @ %bb.0:
; THUMB2-NEXT:    asrs r0, r1
; THUMB2-NEXT:    clz r0, r0
; THUMB2-NEXT:    lsrs r0, r0, #5
; THUMB2-NEXT:    bx lr
    %sh = ashr i32 %a, %b
    %cmp = icmp eq i32 %sh, 0
    ret i1 %cmp
}

define i1 @cmp_eq_zero_ashr_ri(i32 %a) {
; ARM-LABEL: cmp_eq_zero_ashr_ri:
; ARM:       @ %bb.0:
; ARM-NEXT:    asr r0, r0, #7
; ARM-NEXT:    clz r0, r0
; ARM-NEXT:    lsr r0, r0, #5
; ARM-NEXT:    bx lr
;
; THUMB-LABEL: cmp_eq_zero_ashr_ri:
; THUMB:       @ %bb.0:
; THUMB-NEXT:    asrs r1, r0, #7
; THUMB-NEXT:    rsbs r0, r1, #0
; THUMB-NEXT:    adcs r0, r1
; THUMB-NEXT:    bx lr
;
; THUMB2-LABEL: cmp_eq_zero_ashr_ri:
; THUMB2:       @ %bb.0:
; THUMB2-NEXT:    asrs r0, r0, #7
; THUMB2-NEXT:    clz r0, r0
; THUMB2-NEXT:    lsrs r0, r0, #5
; THUMB2-NEXT:    bx lr
    %sh = ashr i32 %a, 7
    %cmp = icmp eq i32 %sh, 0
    ret i1 %cmp
}
