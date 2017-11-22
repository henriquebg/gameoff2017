SECTION "Level1Character",ROM0

LVL1_INIT_CHARACTER::
    ld a,$50
    ld [sprite_0],a
    ld a,$0F
    ld [sprite_0+1],a
    ld a,$00
    ld [sprite_0+2],a
    ld a,$00
    ld [sprite_0+3],a
    ld a,$58
    ld [sprite_1],a
    ld a,$0F
    ld [sprite_1+1],a
    ld a,$01
    ld [sprite_1+2],a
    ld a,$00
    ld [sprite_1+3],a
    ret

LVL1_UPDATE_CHAR::
    ld  a,[joypad_down]
    call JOY_A
    jp  nz,LVL1_CHECK_UP
    ld a,[is_shoting]
    cp $01
    jp  z,LVL1_CHECK_UP
    ld a,$01
    ld [is_shoting],a
    ld a,[sprite_0]
    inc a
    ld [sprite_2],a
    ld a,[sprite_0+1]
    ld [sprite_2+1],a
    jp LVL1_CHECK_UP
    ret

LVL1_CHECK_UP::
    ld  a,[joypad_down]
    call JOY_UP
    jp  nz,LVL1_CHECK_DOWN
    ld a,[sprite_0]
    dec a
    cp _UPPER_BORDER
    jp c,LVL1_CHECK_DOWN
    ld [sprite_0],a
    ld a,[sprite_1]
    dec a
    ld [sprite_1],a
    jp LVL1_CHECK_RIGHT
    ret

LVL1_CHECK_DOWN::
    ld  a,[joypad_down]
    call JOY_DOWN
    jp  nz,LVL1_CHECK_RIGHT
    ld a,[sprite_0]
    inc a
    cp _LOWER_BORDER
    jp nc,LVL1_CHECK_RIGHT
    ld [sprite_0],a
    ld a,[sprite_1]
    inc a
    ld [sprite_1],a
    jp LVL1_CHECK_RIGHT
    ret

LVL1_CHECK_RIGHT::
    ld  a,[joypad_down]
    call JOY_RIGHT
    jp  nz,LVL1_CHECK_LEFT
    ld a,[sprite_0+1]
    inc a
    cp _RIGHT_BORDER
    jp nc,LVL1_CHECK_LEFT
    ld [sprite_0+1],a
    ld a,[sprite_1+1]
    inc a
    ld [sprite_1+1],a
    ret

LVL1_CHECK_LEFT::
    ld  a,[joypad_down]
    call JOY_LEFT
    jp  nz,LVL1_END_CHAR
    ld a,[sprite_0+1]
    dec a
    cp _LEFT_BORDER
    jp c,LVL1_END_CHAR
    ld [sprite_0+1],a
    ld a,[sprite_1+1]
    dec a
    ld [sprite_1+1],a
    ret

LVL1_END_CHAR::
    ret