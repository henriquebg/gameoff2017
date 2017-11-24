SECTION "Shot",ROM0

LVL1_INIT_SHOT::
    ld a,$00
    ld [lvl1_is_shooting],a
    ld a,$F0
    ld [sprite_2],a
    ld a,$0F
    ld [sprite_2+1],a
    ld a,$0E
    ld [sprite_2+2],a
    ld a,$00
    ld [sprite_2+3],a
    ld a,$04
    ld [lvl1_speed_shot],a
    ret

LVL1_ACTIVATE_SHOT::
    ld a,$01
    ld [lvl1_is_shooting],a
    ld a,[sprite_0]
    inc a
    ld [sprite_2],a
    ld a,[sprite_0+1]
    ld [sprite_2+1],a
    ret

LVL1_UPDATE_SHOT::
    ld a,[lvl1_is_shooting]
    cp $01
    jp nz,LVL1_SHOT_END
    jp z,LVL1_MOVE_RIGHT
    ret

LVL1_MOVE_RIGHT::
    ld a,[sprite_2+1]
    cp _RIGHT_BORDER
    jp nc,LVL1_RESET_SHOT
    ld a,[lvl1_speed_shot]
    ld b,a
    ld a,[sprite_2+1]
    add a,b
    ld [sprite_2+1],a
    call LVL1_SHOT_ENEMY_COLLISION_1
    ret

;This one will test if front of shot is within enemy's area
LVL1_SHOT_ENEMY_COLLISION_1::
    ;Test if center of shot in x (x = 8 in tile) is less than enemy's right corner
    ld a,[sprite_3+1]
    ld b,a
    ld a,[sprite_2+1]
    cp b
    jp nc,LVL1_SHOT_ENEMY_COLLISION_2
    ;Test if center of shot in x (x = 8 in tile) is more than enemy's left corner
    ld a,[sprite_3+1]
    sub $08
    ld b,a
    ld a,[sprite_2+1]
    cp b
    jp c,LVL1_SHOT_ENEMY_COLLISION_2
    ;Test if center of shot in y (y = 8 in tile) is less than enemy's bottom
    ld a,[sprite_3]
    ld b,a
    ld a,[sprite_2]
    cp b
    jp nc,LVL1_SHOT_ENEMY_COLLISION_2
    ;Test if center of shot in y (y = 8 in tile) is less than enemy's top
    ld a,[sprite_3]
    sub $08
    ld b,a
    ld a,[sprite_2]
    cp b
    jp c,LVL1_SHOT_ENEMY_COLLISION_2
    ;If everything is true, so shot is within enemy's area
    ld a,[lvl1_score]
    inc a
    ld [lvl1_score],a
    call LVL1_INIT_SHOT
    call LVL1_RESET_ENEMY
    ret

;This one will test if back of shot is within enemy's area
LVL1_SHOT_ENEMY_COLLISION_2::
    ;Test if center of shot in x (x - 4px) is less than enemy's right corner
    ld a,[sprite_3+1]
    ld b,a
    ld a,[sprite_2+1]
    sub $04
    cp b
    jp nc,LVL1_SHOT_END
    ;Test if center of shot in x (x - 4px) is more than enemy's left corner
    ld a,[sprite_3+1]
    sub $08
    ld b,a
    ld a,[sprite_2+1]
    sub $04
    cp b
    jp c,LVL1_SHOT_END
    ;Test if center of shot in y (y = 8) is less than enemy's bottom
    ld a,[sprite_3]
    ld b,a
    ld a,[sprite_2]
    cp b
    jp nc,LVL1_SHOT_END
    ;Test if center of shot in y (y = 8) is less than enemy's top
    ld a,[sprite_3]
    sub $08
    ld b,a
    ld a,[sprite_2]
    cp b
    jp c,LVL1_SHOT_END
    ;If everything is true, so shot is within enemy's area
    ld a,[lvl1_score]
    inc a
    ld [lvl1_score],a
    call LVL1_INIT_SHOT
    call LVL1_RESET_ENEMY
    ret

LVL1_RESET_SHOT::
    ld a,$00
    ld [lvl1_is_shooting],a
    ld a,$F0
    ld [sprite_2+1],a
    ret

LVL1_SHOT_END::
    ret