SECTION "Level2Character",ROM0

LVL2_INIT_CHARACTER::
    ld a,$40
    ld [sprite_0],a
    ld a,$48
    ld [sprite_0+1],a
    ld a,$10
    ld [sprite_0+2],a
    ld a,$00
    ld [sprite_0+3],a
    ld a,$02
    ld [lvl2_speed_character],a
    ret

LVL2_UPDATE_CHARACTER::
    ld  a,[joypad_down]
    call JOY_A
    jp  nz,LVL2_CHECK_UP
    ret

LVL2_CHECK_UP::
    ld  a,[joypad_down]
    call JOY_UP
    jp  nz,LVL2_CHECK_DOWN
    ld a,[lvl2_speed_character]
    ld b,a
    ld a,[sprite_0]
    sub b
    cp _UPPER_BORDER
    jp c,LVL2_CHECK_DOWN
    ld [sprite_0],a
    jp LVL2_CHECK_RIGHT
    ret

LVL2_CHECK_DOWN::
    ld  a,[joypad_down]
    call JOY_DOWN
    jp  nz,LVL2_CHECK_RIGHT
    ld a,[lvl2_speed_character]
    ld b,a
    ld a,[sprite_0]
    add a,b
    cp _LOWER_BORDER_OFFSET
    jp nc,LVL2_CHECK_RIGHT
    ld [sprite_0],a
    jp LVL2_CHECK_RIGHT
    ret

LVL2_CHECK_RIGHT::
    ld  a,[joypad_down]
    call JOY_RIGHT
    jp  nz,LVL2_CHECK_LEFT
    ld a,[lvl2_speed_character]
    ld b,a
    ld a,[sprite_0+1]
    add a,b
    cp _RIGHT_BORDER
    jp nc,LVL2_CHECK_LEFT
    ld [sprite_0+1],a
    ret

LVL2_CHECK_LEFT::
    ld  a,[joypad_down]
    call JOY_LEFT
    jp  nz,LVL2_END_CHARACTER
    ld a,[lvl2_speed_character]
    ld b,a
    ld a,[sprite_0+1]
    sub b
    cp _LEFT_BORDER
    jp c,LVL2_END_CHARACTER
    ld [sprite_0+1],a
    ret

LVL2_END_CHARACTER::
    ret