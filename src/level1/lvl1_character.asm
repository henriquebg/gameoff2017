SECTION "Level1Character",ROM0

LVL1_INIT_CHARACTER::
    ld a,$50
    ld [sprite_0],a
    ld a,$0F
    ld [sprite_0+1],a
    ld a,$0C
    ld [sprite_0+2],a
    ld a,$00
    ld [sprite_0+3],a
    ld a,$58
    ld [sprite_1],a
    ld a,$0F
    ld [sprite_1+1],a
    ld a,$0D
    ld [sprite_1+2],a
    ld a,$00
    ld [sprite_1+3],a
    ld a,$01
    ld [lvl1_speed_character],a
    ret

LVL1_UPDATE_CHAR::
    call LVL1_CHARACTER_ENEMY_COLLISION
    ld  a,[joypad_down]
    call JOY_A
    jp  nz,LVL1_CHECK_UP

    ; ;Refresh seed everytime A is pressed
    ; ld a,[rDIV]
    ; ld [seed_rand_num],a

    ld a,[lvl1_is_shooting]
    cp $01
    jp  z,LVL1_CHECK_UP
    call LVL1_ACTIVATE_SHOT
    jp LVL1_CHECK_UP
    ret

LVL1_CHECK_UP::
    ld  a,[joypad_down]
    call JOY_UP
    jp  nz,LVL1_CHECK_DOWN
    ld a,[lvl1_speed_character]
    ld b,a
    ld a,[sprite_0]
    sub b
    cp _UPPER_BORDER
    jp c,LVL1_CHECK_DOWN
    ld [sprite_0],a
    ld a,[sprite_1]
    sub b
    ld [sprite_1],a
    jp LVL1_CHECK_RIGHT
    ret

LVL1_CHECK_DOWN::
    ld  a,[joypad_down]
    call JOY_DOWN
    jp  nz,LVL1_CHECK_RIGHT
    ld a,[lvl1_speed_character]
    ld b,a
    ld a,[sprite_0]
    add a,b
    cp _LOWER_BORDER
    jp nc,LVL1_CHECK_RIGHT
    ld [sprite_0],a
    ld a,[sprite_1]
    add a,b
    ld [sprite_1],a
    jp LVL1_CHECK_RIGHT
    ret

LVL1_CHECK_RIGHT::
    ld  a,[joypad_down]
    call JOY_RIGHT
    jp  nz,LVL1_CHECK_LEFT
    ld a,[lvl1_speed_character]
    ld b,a
    ld a,[sprite_0+1]
    add a,b
    cp _RIGHT_BORDER
    jp nc,LVL1_CHECK_LEFT
    ld [sprite_0+1],a
    ld a,[sprite_1+1]
    add a,b
    ld [sprite_1+1],a
    ret

LVL1_CHECK_LEFT::
    ld  a,[joypad_down]
    call JOY_LEFT
    jp  nz,LVL1_END_CHAR
    ld a,[lvl1_speed_character]
    ld b,a
    ld a,[sprite_0+1]
    sub b
    cp _LEFT_BORDER
    jp c,LVL1_END_CHAR
    ld [sprite_0+1],a
    ld a,[sprite_1+1]
    sub b
    ld [sprite_1+1],a
    ret

LVL1_CHARACTER_ENEMY_COLLISION::
    ld a,[sprite_0+1]
    sub $08
    ld b,a
    ld a,[sprite_3+1]
    sub $08
    sub b
    cp $08
    jp nc,LVL1_END_CHAR
    ld a,[sprite_0]
    sub $08
    ld b,a
    ld a,[sprite_3]
    sub $08
    sub b
    cp $0F
    jp nc,LVL1_END_CHAR
    ld c,$3C
    call WAIT
    ld d,$08
    ld hl,rBGP
    call FADE_OUT
    jp START

LVL1_END_CHAR::
    ret