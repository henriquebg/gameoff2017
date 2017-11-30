Section "Level3Enemy",ROM0

LVL3_INIT_ENEMY::
    ld a,$50
    ld [sprite_3],a
    ld a,$FF
    ld [sprite_3+1],a
    ld a,$0F
    ld [sprite_3+2],a
    ld a,$00
    ld [sprite_3+3],a
    ld b,%00000001
    call RAND_NUM
    ld [lvl3_enemy_direction],a
    ld a,$00
    ld [lvl3_plot_twist],a
    call LVL3_ENEMY0
    ret

LVL3_UPDATE_ENEMY::
    ld a,[lvl3_plot_twist]
    cp $01
    jp z,LVL3_MOVE_ENEMY
    ld a,[sprite_3]
    sub _LOWER_BORDER_OFFSET
    cp $04
    jp c,LVL3_ENEMY_DIRECTION_UP
    ld a,[sprite_3]
    sub _UPPER_BORDER
    cp $04
    jp c,LVL3_ENEMY_DIRECTION_DOWN
    jp LVL3_MOVE_ENEMY
    ret

LVL3_ENEMY_DIRECTION_UP::
    ld a,$01
    ld [lvl3_enemy_direction],a
    jp LVL3_MOVE_ENEMY

LVL3_ENEMY_DIRECTION_DOWN::
    ld a,$00
    ld [lvl3_enemy_direction],a
    jp LVL3_MOVE_ENEMY

LVL3_MOVE_ENEMY::
    ld a,[lvl3_enemy_direction]
    cp $00
    jp z,LVL3_MOVE_ENEMY_DOWN
    cp $01
    jp z,LVL3_MOVE_ENEMY_UP
    ret

LVL3_MOVE_ENEMY_DOWN::
    ld a,[lvl3_enemy_delay]
    cp $00
    jp nz,LVL3_ENEMY_END
    ld a,[lvl3_enemy_speed_y]
    ld b,a
    ld a,[sprite_3]
    add a,b
    ld [sprite_3],a
    ld a,[lvl3_enemy_speed_delay]
    ld [lvl3_enemy_delay],a
    ld a,[lvl3_enemy_speed_x]
    ld b,a
    ld a,[sprite_3+1]
    sub b
    ld [sprite_3+1],a
    ret

LVL3_MOVE_ENEMY_UP::
    ld a,[lvl3_enemy_delay]
    cp $00
    jp nz,LVL3_ENEMY_END
    ld a,[lvl3_enemy_speed_y]
    ld b,a
    ld a,[sprite_3]
    sub b
    ld [sprite_3],a
    ld a,[lvl3_enemy_speed_delay]
    ld [lvl3_enemy_delay],a
    ld a,[lvl3_enemy_speed_x]
    ld b,a
    ld a,[sprite_3+1]
    sub b
    ld [sprite_3+1],a
    ret

LVL3_RESET_ENEMY::
    ld b,%00111000
    call RAND_NUM
    ld [sprite_3],a
    ld a,$FF
    ld [sprite_3+1],a
    ld b,%00000001
    call RAND_NUM
    ld [lvl3_enemy_direction],a

    ld a,[lvl3_score]
    cp $01
    jp z,LVL3_ENEMY1
    cp $02
    jp z,LVL3_ENEMY2
    cp $03
    jp z,LVL3_ENEMY3
    cp $04
    jp z,LVL3_ENEMY4
    cp $05
    jp z,LVL3_GOTO_LEVEL2
    ret

;Level 2 uses this procedure for restarting, so it uses some Level 2's variables
LVL3_GOTO_LEVEL2::   
    ld a,$F0
    ld [sprite_2],a
    ld [sprite_3],a
    call WAIT_VBLANK
    call $FF80

    ld c,$0F
    call WAIT

    ld hl,rBGP
    ld d,$0F
    call FADE_OUT
    ld hl,rOBP0
    ld d,$0F
    call FADE_OUT
    ld a,$00
    ld [rSCX],a

    ld a,$F0
    ld [lvl2_enemy_0_x],a
    ld [lvl2_enemy_0_y],a
    ld [lvl2_enemy_1_x],a
    ld [lvl2_enemy_1_y],a
    ld a,$F0
    ld [sprite_0],a
    ld a,$F0
    ld [sprite_0+1],a
    call LVL2_UPDATE_ENEMY_0_POSITION
    call LVL2_UPDATE_ENEMY_1_POSITION
    call WAIT_VBLANK
    call $FF80

    jp LEVEL2

LVL3_ENEMY0::
    ;This delay is used only when speed has to be less than 1px per frame (in this case,
    ;better set speed x and y to $01)
    ld a,$00
    ld [lvl3_enemy_delay],a
    ld [lvl3_enemy_speed_delay],a

    ;Amount of pixels per frame
    ;More value of x means a wider movement.
    ;More value of y means a spiky movement.
    ld a,$01
    ld [lvl3_enemy_speed_x],a
    ld a,$01
    ld [lvl3_enemy_speed_y],a
    ret

LVL3_ENEMY1::
    ld a,$00
    ld [lvl3_enemy_delay],a
    ld [lvl3_enemy_speed_delay],a
    ld a,$01
    ld [lvl3_enemy_speed_x],a
    ld a,$02
    ld [lvl3_enemy_speed_y],a
    ld a,$03
    ld [lvl3_scroll_speed],a
    ret

LVL3_ENEMY2::
    ld a,$00
    ld [lvl3_enemy_delay],a
    ld [lvl3_enemy_speed_delay],a
    ld a,$02
    ld [lvl3_enemy_speed_x],a
    ld a,$03
    ld [lvl3_enemy_speed_y],a
    ld a,$02
    ld [lvl3_scroll_speed],a
    ld a,$05
    ld [lvl3_speed_shot],a
    ret

LVL3_ENEMY3::
    ld a,$00
    ld [lvl3_enemy_delay],a
    ld [lvl3_enemy_speed_delay],a
    ld a,$03
    ld [lvl3_enemy_speed_x],a
    ld a,$04
    ld [lvl3_enemy_speed_y],a
    ld a,$01
    ld [lvl3_scroll_speed],a
    ld a,$01
    ld [lvl3_plot_twist],a
    ld a,$02
    ld [lvl3_speed_character],a
    ret

LVL3_ENEMY4::
    ld a,$00
    ld [lvl3_enemy_delay],a
    ld [lvl3_enemy_speed_delay],a
    ld a,$05
    ld [lvl3_enemy_speed_x],a
    ld a,$03
    ld [lvl3_enemy_speed_y],a
    ld a,$00
    ld [lvl3_scroll_speed],a
    ld a,$06
    ld [lvl3_speed_shot],a
    ret

LVL3_ENEMY_END::
    ld a,[lvl3_enemy_delay]
    dec a
    ld [lvl3_enemy_delay],a
    ret