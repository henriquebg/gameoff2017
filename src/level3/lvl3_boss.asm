Section "Level1Boss",ROM0

LVL3_INIT_BOSS::
    ld a,$50
    ld [lvl3_boss_y],a
    ld a,$F0
    ld [lvl3_boss_x],a
    call LVL3_UPDATE_BOSS_POSITION
    ld a,$0F
    ld [sprite_5+2],a
    ld a,$0F
    ld [sprite_6+2],a
    ld a,$0F
    ld [sprite_7+2],a
    ld a,$0F
    ld [sprite_8+2],a
    ld a,$00
    ld [sprite_5+3],a
    ld [sprite_6+3],a
    ld [sprite_7+3],a
    ld [sprite_8+3],a
    ld [lvl3_boss_delay],a
    ld [lvl3_boss_speed_delay],a

    ld a,$01
    ld [lvl3_boss_speed_y],a

    ld b,%00000001
    call RAND_NUM
    ld [lvl3_boss_direction],a
    ret

LVL3_UPDATE_BOSS_POSITION::
    ld a,[lvl3_boss_y]
    ld [sprite_5],a
    ld [sprite_6],a
    add a,$08
    ld [sprite_7],a
    ld [sprite_8],a

    ld a,[lvl3_boss_x]
    ld [sprite_5+1],a
    ld [sprite_7+1],a
    add a,$08
    ld [sprite_6+1],a
    ld [sprite_8+1],a
    ret

LVL3_UPDATE_BOSS::
    ld a,[lvl3_boss_y]
    sub $08
    sub _LOWER_BORDER_OFFSET
    cp $04
    jp c,LVL3_BOSS_DIRECTION_UP
    ld a,[lvl3_boss_y]
    add a,$08
    sub _UPPER_BORDER
    cp $04
    jp c,LVL3_BOSS_DIRECTION_DOWN
    jp LVL3_MOVE_BOSS

LVL3_BOSS_DIRECTION_UP::
    ld a,$01
    ld [lvl3_boss_direction],a
    jp LVL3_MOVE_BOSS

LVL3_BOSS_DIRECTION_DOWN::
    ld a,$00
    ld [lvl3_boss_direction],a
    jp LVL3_MOVE_BOSS

LVL3_MOVE_BOSS::
    ld a,[lvl3_boss_direction]
    cp $00
    jp z,LVL3_MOVE_BOSS_DOWN
    cp $01
    jp z,LVL3_MOVE_BOSS_UP
    ret

LVL3_MOVE_BOSS_DOWN::
    ld a,[lvl3_boss_delay]
    cp $00
    jp nz,LVL3_BOSS_END
    ld a,[lvl3_boss_speed_y]
    ld b,a
    ld a,[lvl3_boss_y]
    add a,b
    ld [lvl3_boss_y],a
    ld a,[lvl3_boss_speed_delay]
    ld [lvl3_boss_delay],a
    ret

LVL3_MOVE_BOSS_UP::
    ld a,[lvl3_boss_delay]
    cp $00
    jp nz,LVL3_BOSS_END
    ld a,[lvl3_boss_speed_y]
    ld b,a
    ld a,[lvl3_boss_y]
    sub b
    ld [lvl3_boss_y],a
    ld a,[lvl3_boss_speed_delay]
    ld [lvl3_boss_delay],a
    ret

LVL3_HIT_BOSS::
    ret

LVL3_BOSS_END::
    ld a,[lvl3_boss_delay]
    dec a
    ld [lvl3_boss_delay],a
    ret