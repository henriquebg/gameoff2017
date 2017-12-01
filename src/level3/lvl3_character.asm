SECTION "Level3Character",ROM0

LVL3_INIT_CHARACTER::
    ld b,$50
    ld c,$0F
    ld d,$0C
    ld e,$00
    ld hl,sprite_0
    call INIT_SPRITE
    ld b,$58
    ld c,$0F
    ld d,$0D
    ld e,$00
    ld hl,sprite_1
    call INIT_SPRITE
    ld a,$01
    ld [lvl3_speed_character],a
    ret

LVL3_UPDATE_CHAR::
    call LVL3_CHARACTER_ENEMY_COLLISION
    ld  a,[joypad_down]
    call JOY_A
    jp  nz,LVL3_CHECK_UP
    ld a,[lvl3_is_shooting]
    cp $01
    jp  z,LVL3_CHECK_UP
    call LVL3_ACTIVATE_SHOT
    jp LVL3_CHECK_UP
    ret

LVL3_CHECK_UP::
    ld  a,[joypad_down]
    call JOY_UP
    jp  nz,LVL3_CHECK_DOWN
    ld a,[lvl3_speed_character]
    ld b,a
    ld a,[sprite_0]
    sub b
    cp _UPPER_BORDER
    jp c,LVL3_CHECK_DOWN
    ld [sprite_0],a
    ld a,[sprite_1]
    sub b
    ld [sprite_1],a
    jp LVL3_CHECK_RIGHT
    ret

LVL3_CHECK_DOWN::
    ld  a,[joypad_down]
    call JOY_DOWN
    jp  nz,LVL3_CHECK_RIGHT
    ld a,[lvl3_speed_character]
    ld b,a
    ld a,[sprite_0]
    add a,b
    cp _LOWER_BORDER
    jp nc,LVL3_CHECK_RIGHT
    ld [sprite_0],a
    ld a,[sprite_1]
    add a,b
    ld [sprite_1],a
    jp LVL3_CHECK_RIGHT
    ret

LVL3_CHECK_RIGHT::
    ld  a,[joypad_down]
    call JOY_RIGHT
    jp  nz,LVL3_CHECK_LEFT
    ld a,[lvl3_speed_character]
    ld b,a
    ld a,[sprite_0+1]
    add a,b
    cp $80
    jp nc,LVL3_CHECK_LEFT
    ld [sprite_0+1],a
    ld a,[sprite_1+1]
    add a,b
    ld [sprite_1+1],a
    ret

LVL3_CHECK_LEFT::
    ld  a,[joypad_down]
    call JOY_LEFT
    jp  nz,LVL3_END_CHAR
    ld a,[lvl3_speed_character]
    ld b,a
    ld a,[sprite_0+1]
    sub b
    cp _LEFT_BORDER
    jp c,LVL3_END_CHAR
    ld [sprite_0+1],a
    ld a,[sprite_1+1]
    sub b
    ld [sprite_1+1],a
    ret

LVL3_CHARACTER_ENEMY_COLLISION::
    ld a,[sprite_0+1]
    sub $08
    ld b,a
    ld a,[sprite_3+1]
    sub $08
    sub b
    cp $08
    jp nc,LVL3_END_CHAR
    ld a,[sprite_0]
    sub $08
    ld b,a
    ld a,[sprite_3]
    sub $08
    sub b
    cp $0F
    jp nc,LVL3_END_CHAR
    ld c,$3C
    call WAIT
    ld d,$0F
    ld hl,rBGP
    call FADE_OUT
    
    ld a,$F0
    ld [sprite_2],a
    call WAIT_VBLANK
    call $FF80

    ld d,$0F
    ld hl,rOBP0
    call FADE_OUT

    ld a,$F0
    ld [sprite_0],a
    ld [sprite_1],a
    ld [sprite_3],a
    call WAIT_VBLANK
    call $FF80
    ld a,$00
    ld [rSCX],a
    jp LEVEL1

LVL3_END_CHAR::
    ret