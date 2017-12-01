SECTION "Level3BossShot",ROM0

LVL3_INIT_BOSS_SHOT::
    ld a,$00
    ld [lvl3_is_boss_shooting],a
    ld b,$F0
    ld c,$F0
    ld d,$0E
    ld e,%00100000
    ld hl,sprite_4
    call INIT_SPRITE
    ld a,$01
    ld [lvl3_speed_boss_shot],a
    ret

LVL3_ACTIVATE_BOSS_SHOT::
    ld a,$01
    ld [lvl3_is_boss_shooting],a
    ld a,[lvl3_boss_y]
    inc a
    ld [sprite_4],a
    ld a,[lvl3_boss_x]
    ld [sprite_4+1],a
    jp LVL3_CHECK_BOSS_POSITION
    ret

LVL3_UPDATE_BOSS_SHOT::
    ld a,[lvl3_is_boss_shooting]
    cp $01
    jp z,LVL3_BOSS_SHOT_MOVE_LEFT
    ret

LVL3_BOSS_SHOT_MOVE_LEFT::
    ld a,[sprite_4+1]
    cp _LEFT_BORDER
    jp c,LVL3_RESET_BOSS_SHOT
    ld a,[lvl3_speed_boss_shot]
    ld b,a
    ld a,[sprite_4+1]
    sub b
    ld [sprite_4+1],a
    call LVL3_SHOT_CHAR_COLLISION
    ret

LVL3_SHOT_CHAR_COLLISION::
    ld a,[sprite_4]
    ld b,a
    ld a,[sprite_1]
    cp b
    jp c,LVL3_BOSS_SHOT_END
    sub $0F
    cp b
    jp nc,LVL3_BOSS_SHOT_END
    ld a,[sprite_4+1]
    ld b,a
    ld a,[sprite_1+1]
    cp b
    jp c,LVL3_BOSS_SHOT_END
    sub $08
    cp b
    jp nc,LVL3_BOSS_SHOT_END

    ld a,$F0
    ld [sprite_2],a
    ld [sprite_4],a
    call WAIT_VBLANK
    call $FF80

    ld c,$3C
    call WAIT
    ld d,$0F
    ld hl,rBGP
    call FADE_OUT
    
    ld d,$0F
    ld hl,rOBP0
    call FADE_OUT

    ld d,$0F
    ld hl,rOBP1
    call FADE_OUT

    ld a,$F0
    ld [sprite_0],a
    ld [sprite_1],a
    ld [lvl3_boss_y],a
    call LVL3_UPDATE_BOSS_POSITION
    call WAIT_VBLANK
    call $FF80
    ld a,$00
    ld [rSCX],a
    jp LEVEL3

LVL3_RESET_BOSS_SHOT::
    ld a,$00
    ld [lvl3_is_boss_shooting],a
    ld a,$F0
    ld [sprite_4+1],a
    ret

LVL3_BOSS_SHOT_END::
    ret