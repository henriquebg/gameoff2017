SECTION "Shot",ROM0

LVL3_INIT_SHOT::
    ld a,$00
    ld [lvl3_is_shooting],a
    ld a,$F0
    ld [sprite_2],a
    ld a,$0F
    ld [sprite_2+1],a
    ld a,$0E
    ld [sprite_2+2],a
    ld a,$00
    ld [sprite_2+3],a
    ld a,$04
    ld [lvl3_speed_shot],a
    ret

LVL3_ACTIVATE_SHOT::
    ld a,$01
    ld [lvl3_is_shooting],a
    ld a,[sprite_0]
    inc a
    ld [sprite_2],a
    ld a,[sprite_0+1]
    ld [sprite_2+1],a
    ret

LVL3_UPDATE_SHOT::
    ld a,[lvl3_is_shooting]
    cp $01
    jp nz,LVL3_SHOT_END
    jp z,LVL3_MOVE_RIGHT
    ret

LVL3_MOVE_RIGHT::
    ld a,[sprite_2+1]
    cp _RIGHT_BORDER
    jp nc,LVL3_RESET_SHOT
    ld a,[lvl3_speed_shot]
    ld b,a
    ld a,[sprite_2+1]
    add a,b
    ld [sprite_2+1],a
    call LVL3_SHOT_BOSS_COLLISION
    ret

LVL3_SHOT_BOSS_COLLISION::
    ld a,[sprite_2]
    ld b,a
    ld a,[lvl3_boss_y]
    sub $08
    cp b
    jp nc,LVL3_SHOT_END
    add $0F
    cp b
    jp c,LVL3_SHOT_END
    ld a,[sprite_2+1]
    ld b,a
    ld a,[lvl3_boss_x]
    sub $08
    cp b
    jp nc,LVL3_SHOT_END
    add $0F
    cp b
    jp c,LVL3_SHOT_END
    call LVL3_INIT_SHOT
    call LVL3_HIT_BOSS
    ret

LVL3_RESET_SHOT::
    ld a,$00
    ld [lvl3_is_shooting],a
    ld a,$F0
    ld [sprite_2+1],a
    ret

LVL3_SHOT_END::
    ret