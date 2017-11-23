Section "Level1Enemy",ROM0

LVL1_INIT_ENEMY::
    ; ld b,%01111100
    ; call RAND_NUM
    ld a,$50
    ld [sprite_3],a
    ld a,$B0
    ld [sprite_3+1],a
    ld a,$0F
    ld [sprite_3+2],a
    ld a,$00
    ld [sprite_3+3],a
    ld b,%00000001
    call RAND_NUM
    ld [lvl1_enemy_direction],a
    call LVL1_ENEMY0
    ret

LVL1_UPDATE_ENEMY::
    ld a,[sprite_3]
    cp _LOWER_BORDER_OFFSET
    jp z,LVL1_ENEMY_DIRECTION_UP
    cp _UPPER_BORDER_OFFSET
    jp z,LVL1_ENEMY_DIRECTION_DOWN
    jp LVL1_MOVE_ENEMY
    ret

LVL1_ENEMY_DIRECTION_UP::
    ld a,$01
    ld [lvl1_enemy_direction],a
    jp LVL1_MOVE_ENEMY

LVL1_ENEMY_DIRECTION_DOWN::
    ld a,$00
    ld [lvl1_enemy_direction],a
    jp LVL1_MOVE_ENEMY

LVL1_MOVE_ENEMY::
    ld a,[lvl1_enemy_direction]
    cp $00
    jp z,LVL1_MOVE_ENEMY_DOWN
    cp $01
    jp z,LVL1_MOVE_ENEMY_UP
    ret

LVL1_MOVE_ENEMY_DOWN::
    ld a,[lvl1_enemy_delay]
    cp $00
    jp nz,LVL1_ENEMY_END
    ld a,[lvl1_enemy_speed_y]
    ld b,a
    ld a,[sprite_3]
    add a,b
    ld [sprite_3],a
    ld a,[lvl1_enemy_speed_delay]
    ld [lvl1_enemy_delay],a
    ld a,[lvl1_enemy_speed_x]
    ld b,a
    ld a,[sprite_3+1]
    sub b
    ld [sprite_3+1],a
    ret

LVL1_MOVE_ENEMY_UP::
    ld a,[lvl1_enemy_delay]
    cp $00
    jp nz,LVL1_ENEMY_END
    ld a,[lvl1_enemy_speed_y]
    ld b,a
    ld a,[sprite_3]
    sub b
    ld [sprite_3],a
    ld a,[lvl1_enemy_speed_delay]
    ld [lvl1_enemy_delay],a
    ld a,[lvl1_enemy_speed_x]
    ld b,a
    ld a,[sprite_3+1]
    sub b
    ld [sprite_3+1],a
    ret

LVL1_RESET_ENEMY::
    ld b,%00111000
    call RAND_NUM
    ld [sprite_3],a
    ld a,$B0
    ld [sprite_3+1],a
    ld b,%00000001
    call RAND_NUM
    ld [lvl1_enemy_direction],a
    
    ld a,[lvl1_score]
    cp $01
    jp z,LVL1_ENEMY1
    cp $02
    jp z,LVL1_ENEMY2
    cp $03
    jp z,LVL1_ENEMY3
    cp $04
    jp z,LVL1_ENEMY4
    cp $05
    jp z,START
    ret

LVL1_ENEMY0::
    ;This delay is used only when speed has to be less than 1px per frame (in this case,
    ;better set speed x and y to $01)
    ld a,$00
    ld [lvl1_enemy_delay],a
    ld [lvl1_enemy_speed_delay],a

    ;Amount of pixels per frame
    ;More value of x means a wider movement.
    ;More value of y means a spiky movement.
    ld a,$01
    ld [lvl1_enemy_speed_x],a
    ld a,$01
    ld [lvl1_enemy_speed_y],a
    ret

LVL1_ENEMY1::
    ld a,$00
    ld [lvl1_enemy_delay],a
    ld [lvl1_enemy_speed_delay],a
    ld a,$02
    ld [lvl1_enemy_speed_x],a
    ld a,$01
    ld [lvl1_enemy_speed_y],a
    ld a,$02
    ld [lvl1_speed_character],a
    ld a,$03
    ld [lvl1_scroll_speed],a
    ld a,$05
    ld [lvl1_speed_shot],a
    ret

LVL1_ENEMY2::
    ld a,$00
    ld [lvl1_enemy_delay],a
    ld [lvl1_enemy_speed_delay],a
    ld a,$02
    ld [lvl1_enemy_speed_x],a
    ld a,$03
    ld [lvl1_enemy_speed_y],a
    ld a,$02
    ld [lvl1_scroll_speed],a
    ld a,$06
    ld [lvl1_speed_shot],a
    ret

LVL1_ENEMY3::
    ld a,$00
    ld [lvl1_enemy_delay],a
    ld [lvl1_enemy_speed_delay],a
    ld a,$03
    ld [lvl1_enemy_speed_x],a
    ld a,$03
    ld [lvl1_enemy_speed_y],a
    ld a,$03
    ld [lvl1_speed_character],a
    ld a,$01
    ld [lvl1_scroll_speed],a
    ld a,$07
    ld [lvl1_speed_shot],a
    ret

LVL1_ENEMY4::
    ld a,$00
    ld [lvl1_enemy_delay],a
    ld [lvl1_enemy_speed_delay],a
    ld a,$04
    ld [lvl1_enemy_speed_x],a
    ld a,$03
    ld [lvl1_enemy_speed_y],a
    ld a,$04
    ld [lvl1_speed_character],a
    ld a,$00
    ld [lvl1_scroll_speed],a
    ld a,$08
    ld [lvl1_speed_shot],a
    ret

LVL1_ENEMY_END::
    ld a,[lvl1_enemy_delay]
    dec a
    ld [lvl1_enemy_delay],a
    ret