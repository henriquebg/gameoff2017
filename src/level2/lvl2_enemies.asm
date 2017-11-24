SECTION "Level2Enemies",ROM0

LVL2_INIT_ENEMIES::
    call LVL2_INIT_ENEMY_0
    ret

LVL2_INIT_ENEMY_0::
    ;Setting initial position for enemy 0
    ld b,%00111000
    call RAND_NUM
    add a,$0F
    ld [lvl2_enemy_0_y],a
    ld b,%01111000
    call RAND_NUM
    add a,$08
    ld [lvl2_enemy_0_x],a
    call LVL2_UPDATE_ENEMY_0_POSITION

    ;Setting initial sprites for enemy 0
    ld a,$11
    ld [sprite_1+2],a
    ld a,$12
    ld [sprite_3+2],a
    ld a,$13
    ld [sprite_2+2],a
    ld a,$14
    ld [sprite_4+2],a

    ;Setting sprites' flags and variables
    ld a,$00
    ld [sprite_1+3],a
    ld [sprite_2+3],a
    ld [sprite_3+3],a
    ld [sprite_4+3],a
    ld [lvl2_enemy_0_sprite_delay],a
    ld [lvl2_enemy_0_sprite_set],a

    ld a,$01
    ld [lvl2_enemy_0_is_active],a
    ret    

LVL2_UPDATE_ENEMIES:: 
    ld a,[lvl2_enemy_0_is_active]
    cp $01
    jp z,LVL2_UPDATE_ENEMY_0
    ret

LVL2_UPDATE_ENEMY_0::
    ;call MOVE_ENEMY_0
    call LVL2_UPDATE_ENEMY_0_POSITION
    call LVL2_UPDATE_ENEMY_0_SPRITE
    ret

LVL2_MOVE_ENEMY_0::
    ld a,[lvl2_enemy_0_y]
    sub a,$01
    ld [lvl2_enemy_0_y],a
    ld a,[lvl2_enemy_0_x]
    sub a,$01
    ld [lvl2_enemy_0_x],a
    ret

LVL2_UPDATE_ENEMY_0_POSITION::
    ld a,[lvl2_enemy_0_y]
    ld [sprite_1],a
    ld [sprite_2],a
    add a,$08
    ld [sprite_3],a
    ld [sprite_4],a

    ld a,[lvl2_enemy_0_x]
    ld [sprite_1+1],a
    ld [sprite_3+1],a
    add a,$08
    ld [sprite_2+1],a
    ld [sprite_4+1],a
    ret

LVL2_UPDATE_ENEMY_0_SPRITE::
    ld a,[lvl2_enemy_0_sprite_delay]
    cp $40
    jp z,LVL2_CHANGE_ENEMY_0_SPRITE
    inc a
    ld [lvl2_enemy_0_sprite_delay],a
    ret

LVL2_CHANGE_ENEMY_0_SPRITE::
    ld a,[lvl2_enemy_0_sprite_set]
    cp $03
    jp nc,LVL2_ENEMY_0_DAMAGE

    ld a,[lvl2_enemy_0_sprite_set]
    inc a
    ld [lvl2_enemy_0_sprite_set],a

    ld a,[sprite_1+2]
    add a,$04
    ld [sprite_1+2],a

    ld a,[sprite_2+2]
    add a,$04
    ld [sprite_2+2],a

    ld a,[sprite_3+2]
    add a,$04
    ld [sprite_3+2],a

    ld a,[sprite_4+2]
    add a,$04
    ld [sprite_4+2],a

    ld a,$00
    ld [lvl2_enemy_0_sprite_delay],a
    ret

LVL2_ENEMY_0_DAMAGE::
    ld hl,rBGP
    ld d,$02
    call FADE_OUT
    ld d,$02
    call FADE_IN
    ld a,%00100111
    ld [rBGP],a

    ld a,$FF
    ld [sprite_1],a
    ld a,$FF
    ld [sprite_2],a
    ld a,$FF
    ld [sprite_3],a
    ld a,$FF
    ld [sprite_4],a

    ld a,$00
    ld [lvl2_enemy_0_is_active],a
    ret