Section "Level2Enemy1",ROM0

;Enemy 1 routines
LVL2_INIT_ENEMY_1::
    ;Setting initial position for enemy 0
LVL_2_ENEMY_1_LOOP_POS_Y::    
    ld b,%00111000
    call RAND_NUM
    cp _UPPER_BORDER
    jp c,LVL_2_ENEMY_1_LOOP_POS_Y
    cp $49
    jp nc,LVL_2_ENEMY_1_LOOP_POS_Y
    ld [lvl2_enemy_1_y],a
LVL_2_ENEMY_1_LOOP_POS_X::    
    ld b,%11111111
    call RAND_NUM
    cp _RIGHT_BORDER_NEGATIVE_OFFSET
    jp nc,LVL_2_ENEMY_1_LOOP_POS_X
    cp $50
    jp c,LVL_2_ENEMY_1_LOOP_POS_X
    ld [lvl2_enemy_1_x],a
    call LVL2_UPDATE_ENEMY_1_POSITION

    ;Setting initial sprites for enemy 0
    ld a,$11
    ld [sprite_5+2],a
    ld a,$12
    ld [sprite_7+2],a
    ld a,$13
    ld [sprite_6+2],a
    ld a,$14
    ld [sprite_8+2],a

    ;Setting sprites' flags and variables
    ld a,$00
    ld [sprite_5+3],a
    ld [sprite_6+3],a
    ld [sprite_7+3],a
    ld [sprite_8+3],a
    ld [lvl2_enemy_1_sprite_delay],a
    ld [lvl2_enemy_1_sprite_set],a
    ld a,$40
    ld [lvl2_enemy_1_change_speed],a
    ret    

LVL2_UPDATE_ENEMY_1::
    ld a,[lvl2_enemy_1_is_active]
    cp $01
    jp z, LVL2_UPDATE_ENEMY_1_SPRITE
    call LVL2_ENEMY_1_SPAWN
    ret

LVL2_UPDATE_ENEMY_1_SPRITE::
    ld a,[lvl2_enemy_1_change_speed]
    ld b,a
    ld a,[lvl2_enemy_1_sprite_delay]
    cp b
    jp z,LVL2_CHANGE_ENEMY_1_SPRITE
    inc a
    ld [lvl2_enemy_1_sprite_delay],a
    ret

LVL2_CHANGE_ENEMY_1_SPRITE::
    ld a,[lvl2_enemy_1_sprite_set]
    cp $03
    jp nc,LVL2_ENEMY_1_DAMAGE

    ld a,[lvl2_enemy_1_sprite_set]
    inc a
    ld [lvl2_enemy_1_sprite_set],a

    ld a,[sprite_5+2]
    add a,$04
    ld [sprite_5+2],a

    ld a,[sprite_6+2]
    add a,$04
    ld [sprite_6+2],a

    ld a,[sprite_7+2]
    add a,$04
    ld [sprite_7+2],a

    ld a,[sprite_8+2]
    add a,$04
    ld [sprite_8+2],a

    ld a,$00
    ld [lvl2_enemy_1_sprite_delay],a

    ;call LVL2_MOVE_ENEMY_1
    ret

LVL2_MOVE_ENEMY_1::
    ld a,[lvl2_enemy_1_y]
    add a,$08
    ld [lvl2_enemy_1_y],a
    call LVL2_UPDATE_ENEMY_1_POSITION
    ret

LVL2_UPDATE_ENEMY_1_POSITION::
    ld a,[lvl2_enemy_1_y]
    ld [sprite_5],a
    ld [sprite_6],a
    add a,$08
    ld [sprite_7],a
    ld [sprite_8],a

    ld a,[lvl2_enemy_1_x]
    ld [sprite_5+1],a
    ld [sprite_7+1],a
    add a,$08
    ld [sprite_6+1],a
    ld [sprite_8+1],a
    ret

LVL2_ENEMY_1_SPAWN::
    ld a,[lvl2_enemy_1_spawn_delay]
    dec a
    ld [lvl2_enemy_1_spawn_delay],a
    cp $00
    jp nz,LVL2_ENEMY_END
    ld a,$01
    ld [lvl2_enemy_1_is_active],a
    call LVL2_INIT_ENEMY_1
    ret

LVL2_ENEMY_1_DAMAGE::
    ld hl,rBGP
    ld d,$02
    call FADE_OUT
    ld d,$02
    call FADE_IN
    ld a,%00100111
    ld [rBGP],a
    ld a,$FF
    ld [lvl2_enemy_1_x],a
    ld [lvl2_enemy_1_y],a
    ld a,$00
    ld [lvl2_enemy_1_is_active],a
    ld [lvl2_enemy_1_sprite_set],a
    ld b,%01111111
    call RAND_NUM
    ld [lvl2_enemy_1_spawn_delay],a
    call LVL2_UPDATE_ENEMY_1_POSITION
    ret

LVL2_KILL_ENEMY_1::
    ld a,$FF
    ld [lvl2_enemy_1_x],a
    ld [lvl2_enemy_1_y],a
    ld a,$00
    ld [lvl2_enemy_1_is_active],a
    ld [lvl2_enemy_1_sprite_set],a
    ld b,%01111111
    call RAND_NUM
    ld [lvl2_enemy_1_spawn_delay],a
    call LVL2_UPDATE_ENEMY_1_POSITION
    ret