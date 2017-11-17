SECTION "Enemies",ROM0

INIT_ENEMIES::
    call INIT_ENEMY_0
    ret

INIT_ENEMY_0::
    ;Setting initial position for enemy 0
    ld b,%01111100
    call RAND_NUM
    ld [enemy_0_y],a
    ld b,%00111100
    call RAND_NUM
    ld [enemy_0_x],a
    call UPDATE_ENEMY_0_POSITION

    ;Setting initial sprites for enemy 0
    ld a,$01
    ld [sprite_0_enemy_0+2],a
    ld a,$03
    ld [sprite_1_enemy_0+2],a
    ld a,$02
    ld [sprite_2_enemy_0+2],a
    ld a,$04
    ld [sprite_3_enemy_0+2],a

    ;Setting sprites' flags and variables
    ld a,$00
    ld [sprite_0_enemy_0+3],a
    ld [sprite_1_enemy_0+3],a
    ld [sprite_2_enemy_0+3],a
    ld [sprite_3_enemy_0+3],a
    ld [enemy_0_sprite_delay],a
    ld [enemy_0_sprite_set],a
    ret    

UPDATE_ENEMIES:: 
    call UPDATE_ENEMY_0
    ret

UPDATE_ENEMY_0::
    ;call MOVE_ENEMY_0
    call UPDATE_ENEMY_0_POSITION
    call UPDATE_ENEMY_0_SPRITE
    ret

MOVE_ENEMY_0::
    ld a,[enemy_0_y]
    sub a,$01
    ld [enemy_0_y],a
    ld a,[enemy_0_x]
    sub a,$01
    ld [enemy_0_x],a
    ret

UPDATE_ENEMY_0_POSITION::
    ld a,[enemy_0_y]
    ld [sprite_0_enemy_0],a
    ld [sprite_1_enemy_0],a
    add a,$08
    ld [sprite_2_enemy_0],a
    ld [sprite_3_enemy_0],a

    ld a,[enemy_0_x]
    ld [sprite_0_enemy_0+1],a
    ld [sprite_2_enemy_0+1],a
    add a,$08
    ld [sprite_1_enemy_0+1],a
    ld [sprite_3_enemy_0+1],a
    ret

UPDATE_ENEMY_0_SPRITE::
    ld a,[enemy_0_sprite_delay]
    cp $40
    jp z,CHANGE_ENEMY_0_SPRITE
    inc a
    ld [enemy_0_sprite_delay],a
    ret

CHANGE_ENEMY_0_SPRITE::
    ld a,[enemy_0_sprite_set]
    cp $03
    jp nc,ENEMY_END

    ld a,[enemy_0_sprite_set]
    inc a
    ld [enemy_0_sprite_set],a

    ld a,[sprite_0_enemy_0+2]
    add a,$04
    ld [sprite_0_enemy_0+2],a

    ld a,[sprite_1_enemy_0+2]
    add a,$04
    ld [sprite_1_enemy_0+2],a

    ld a,[sprite_2_enemy_0+2]
    add a,$04
    ld [sprite_2_enemy_0+2],a

    ld a,[sprite_3_enemy_0+2]
    add a,$04
    ld [sprite_3_enemy_0+2],a

    ld a,$00
    ld [enemy_0_sprite_delay],a
    ret

ENEMY_END::
    ret

; MUDA_DIRECAO_CIMA::
;     ld a,$01
;     ld [inimigo_direcao],a
;     jp MOVE_INIMIGO
;     ret

; MUDA_DIRECAO_BAIXO::
;     ld a,$00
;     ld [inimigo_direcao],a
;     jp MOVE_INIMIGO
;     ret

; MOVE_INIMIGO::
;     ld a,[inimigo_direcao]
;     cp $00
;     jp z,MOVE_BAIXO
;     cp $01
;     jp z,MOVE_CIMA
;     ret

; MOVE_BAIXO::
;     ld a,[sprite_inimigo]
;     add a,$01
;     ld [sprite_inimigo],a
;     sub $08
;     ld [sprite_inimigo_fim_y],a
;     ld a,[inimigo_delay]
;     cp $00
;     jp nz,FIM_INIMIGO
;     ld a,$04
;     ld [inimigo_delay],a
;     ld a,[sprite_inimigo+1]
;     sub a,$01
;     ld [sprite_inimigo+1],a
;     sub $08
;     ld [sprite_inimigo_fim_x],a
;     ret

; MOVE_CIMA::
;     ld a,[sprite_inimigo]
;     sub a,$01
;     ld [sprite_inimigo],a
;     sub $08
;     ld [sprite_inimigo_fim_y],a
;     ld a,[inimigo_delay]
;     cp $00
;     jp nz,FIM_INIMIGO
;     ld a,$04
;     ld [inimigo_delay],a
;     ld a,[sprite_inimigo+1]
;     sub a,$01
;     ld [sprite_inimigo+1],a
;     sub $08
;     ld [sprite_inimigo_fim_x],a
;     ret

; FIM_INIMIGO::
;     ld a,[inimigo_delay]
;     dec a
;     ld [inimigo_delay],a
;     ret


