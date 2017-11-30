Section "Level3Boss",ROM0

LVL3_INIT_BOSS::
    ld a,$50
    ld [lvl3_boss_y],a
    ld a,$F0
    ld [lvl3_boss_x],a
    call LVL3_UPDATE_BOSS_POSITION
    ld a,$3B
    ld [sprite_5+2],a
    ld a,$39
    ld [sprite_6+2],a
    ld a,$3C
    ld [sprite_7+2],a
    ld a,$3A
    ld [sprite_8+2],a
    ld a,%00010000
    ld [sprite_5+3],a
    ld [sprite_6+3],a
    ld [sprite_7+3],a
    ld [sprite_8+3],a
    ld a,%00100111
    ld [rOBP1],a

    ld a,$00
    ld [lvl3_boss_delay],a
    ld [lvl3_boss_speed_delay],a
    ld [lvl3_boss_hits],a
    ld [lvl3_boss_anim_delay],a
    ld [lvl3_boss_anim_set],a

    ld a,$05
    ld [lvl3_boss_anim_speed],a

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
    call LVL3_BOSS_CHECK_SPRITE_DELAY
    ld a,[lvl3_is_boss_shooting]
    cp $00
    jp z,LVL3_ACTIVATE_BOSS_SHOT
    jp LVL3_CHECK_BOSS_POSITION

LVL3_BOSS_CHECK_SPRITE_DELAY::
    ld a,[lvl3_boss_anim_speed]
    ld b,a
    ld a,[lvl3_boss_anim_delay]
    cp b
    jp z,LVL3_BOSS_CHANGE_SPRITE
    inc a
    ld [lvl3_boss_anim_delay],a
    ret

LVL3_BOSS_CHANGE_SPRITE::
    ld a,[lvl3_boss_anim_set]
    cp $02
    jp nc,LVL3_BOSS_RESET_ANIM
    inc a
    ld [lvl3_boss_anim_set],a

    ld a,[sprite_5+2]
    add a,$02
    ld [sprite_5+2],a

    ld a,[sprite_7+2]
    add a,$02
    ld [sprite_7+2],a

    ld a,$00
    ld [lvl3_boss_anim_delay],a
    ret

LVL3_BOSS_RESET_ANIM::
    ld a,$3B
    ld [sprite_5+2],a
    ld a,$3C
    ld [sprite_7+2],a
    ld a,$00
    ld [lvl3_boss_anim_set],a
    ld [lvl3_boss_anim_delay],a
    ret
    
LVL3_CHECK_BOSS_POSITION::
    ld a,[lvl3_boss_y]
    sub $04
    sub _LOWER_BORDER
    cp $01
    jp c,LVL3_BOSS_DIRECTION_UP
    ld a,[lvl3_boss_y]
    add $04
    sub _UPPER_BORDER
    cp $01
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
    call LVL3_UPDATE_BOSS_POSITION
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
    call LVL3_UPDATE_BOSS_POSITION
    ret

LVL3_HIT_BOSS::
    ld a,[lvl3_boss_hits]
    inc a
    ld [lvl3_boss_hits],a
    cp $05
    jp z,LVL3_BOSS_SHOT_SPEED_INC
    cp $0A
    jp z,LVL3_BOSS_SHOT_SPEED_INC
    cp $0E
    jp z,LVL3_BOSS_SHOT_SPEED_INC
    ret

LVL3_BOSS_SHOT_SPEED_INC::
    ld a,[lvl3_speed_boss_shot]
    inc a
    ld [lvl3_speed_boss_shot],a
    ld a,[lvl3_boss_anim_speed]
    dec a
    ld [lvl3_boss_anim_speed],a
    ret

LVL3_BOSS_END::
    ld a,[lvl3_boss_delay]
    dec a
    ld [lvl3_boss_delay],a
    ret