SECTION "Shot",ROM0

LVL1_INIT_SHOT::
    ld a,$00
    ld [is_shooting],a
    ld a,$F0
    ld [sprite_2],a
    ld a,$0F
    ld [sprite_2+1],a
    ld a,$0E
    ld [sprite_2+2],a
    ld a,$00
    ld [sprite_2+3],a
    ret

LVL1_UPDATE_SHOT::
    ld a,[is_shooting]
    cp $01
    jp nz,LVL1_SHOT_END
    jp z,LVL1_MOVE_RIGHT
    ret

LVL1_MOVE_RIGHT::
    ld a,[sprite_2+1]
    cp _RIGHT_BORDER_OFFSET
    jp nc,LVL1_RESET_SHOT
    ld a,[sprite_2+1]
    add a,$04
    ld [sprite_2+1],a
    ;call LVL1_CHECK_ENEMY_COLLISION
    ;call INICIA_INIMIGO
    ret

LVL1_CHECK_ENEMY_COLLISION::
    ld a,[sprite_2+1]
    ld b,a
    ld a,[sprite_3+1]
    cp b
    jp nc,LVL1_SHOT_END
    sub $08
    cp b
    jp nc,LVL1_SHOT_END
    ld a,[sprite_2]
    ld b,a
    ld a,[sprite_3]
    cp b
    jp nc,LVL1_SHOT_END
    sub $08
    cp b
    jp nc,LVL1_SHOT_END
    call LVL1_INIT_SHOT
    ;call INIT_ENEMY
    ret

LVL1_RESET_SHOT::
    ld a,$00
    ld [is_shooting],a
    ret

LVL1_SHOT_END::
    ret