SECTION "Level2Enemies",ROM0

LVL2_INIT_ENEMIES::
    call LVL2_INIT_ENEMY_0
    call LVL2_INIT_ENEMY_1
    ld a,$00
    ld [lvl2_enemy_0_is_active],a
    ld [lvl2_enemy_1_is_active],a
    ld b,%01111111
    call RAND_NUM
    ld [lvl2_enemy_0_spawn_delay],a
    ld b,%01111111
    call RAND_NUM
    ld [lvl2_enemy_1_spawn_delay],a
    ld a,$F0
    ld [lvl2_enemy_0_x],a
    ld [lvl2_enemy_0_y],a
    ld [lvl2_enemy_1_x],a
    ld [lvl2_enemy_1_y],a
    ld a,$40
    ld [lvl2_enemies_change_speed],a
    call LVL2_UPDATE_ENEMY_0_POSITION
    call LVL2_UPDATE_ENEMY_1_POSITION
    ret

LVL2_UPDATE_ENEMIES::
    ld a,[lvl2_enemies_active]
    cp $01
    jp nz,LVL2_ENEMY_END
    call LVL2_UPDATE_ENEMY_0
    call LVL2_UPDATE_ENEMY_1
    ret

LVL2_ENEMY_END::
    ret