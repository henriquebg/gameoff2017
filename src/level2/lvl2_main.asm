Section "Level2",ROM0

LEVEL2::
    call LVL2_LOAD_MAP
    call LVL2_INIT_CHARACTER
    call LVL2_INIT_ENEMIES
    call LVL2_INIT_BACKGROUND

    ld a,$00
    ld [lvl2_score],a
    ld a,$02
    ld [lvl2_lives],a
    ld a,$01
    ld [lvl2_enemies_active],a

    ld c,$40
    call WAIT

    ld  a,%11000011
    ld [rLCDC],a
    ld hl,rBGP
    ld d,$0F
    call FADE_IN_INV
    ld hl,rOBP0
    ld d,$0F
    call FADE_IN_INV
    ld a,%00011011
    ld [rOBP0],a
    jp LEVEL2_LOOP

LEVEL2_LOOP::
    call WAIT_VBLANK
    call LVL2_BACKGROUND_ANIMATE
    call $FF80
    ld a,[lvl2_score]
    cp $1E
    jp z,LEVEL2_END_ANIM
    ld a,[lvl2_lives]
    cp $00
    jp z,LEVEL2_RESTART
    call READ_JOYPAD
    call LVL2_UPDATE_CHARACTER
    call LVL2_UPDATE_ENEMIES
    nop
    jp LEVEL2_LOOP

LEVEL2_END_ANIM::
    ld hl,rOBP0
    ld d,$0F
    call FADE_OUT_INV
    ld a,$F0
    ld [sprite_0],a
    ld [sprite_0+1],a
    ld [lvl2_enemy_0_y],a
    ld [lvl2_enemy_0_x],a
    ld [lvl2_enemy_1_y],a
    ld [lvl2_enemy_1_x],a
    call LVL2_UPDATE_ENEMY_0_POSITION
    call LVL2_UPDATE_ENEMY_1_POSITION
    call LVL2_INIT_PLANET

    ld a,$0F
    ld [lvl2_anim_planet_delay],a

    ld a,%00100111
    ld [rOBP0],a

    call WAIT_VBLANK
    call $FF80
    ld a,$00
    ld [lvl2_enemies_active],a
LEVEL2_END_ANIM_LOOP::
    call WAIT_VBLANK
    call LVL2_BACKGROUND_ANIMATE
    call $FF80
    ld a,[lvl2_anim_planet_delay]
    dec a
    ld [lvl2_anim_planet_delay],a
    cp $00
    jp nz,LEVEL2_END_ANIM_LOOP
    ld a,[rSCY]
    cp $E0
    jp z,LVL2_FADE_OUT
    ld b,$00
    ld d,$00
    ld e,$04
    ld hl,sprite_9
    call LVL2_UPDATE_SPRITES_PLANET
    ld a,[rSCY]
    sub $01
    ld [rSCY],a
    ld a,$0F
    ld [lvl2_anim_planet_delay],a
    jp LEVEL2_END_ANIM_LOOP

LVL2_INIT_PLANET::
    ld b,$F0
    ld c,$38
    ld d,$31
    ld e,$08
    ld hl,sprite_9
    call LVL2_PLANET_ROW_INIT
    ld b,$F8
    ld c,$38
    ld d,$29
    ld e,$08
    ld hl,sprite_17
    call LVL2_PLANET_ROW_INIT
    ld b,$00
    ld c,$40
    ld d,$23
    ld e,$06
    ld hl,sprite_25
    call LVL2_PLANET_ROW_INIT
    ret

;b = y position
;c = first x position
;d = first sprite num
;e = amount of sprites
;hl = address of first sprite in row
LVL2_PLANET_ROW_INIT::
    ld a,b
    ld [hl+],a
    ld a,c
    ld [hl+],a
    ld a,d
    ld [hl+],a
    ld a,$00
    ld [hl+],a
    ld a,c
    add a,$08
    ld c,a
    inc d
    dec e
    ld a,e
    cp $00
    jp nz,LVL2_PLANET_ROW_INIT
    ret

LVL2_UPDATE_SPRITES_PLANET::
    ld a,[hl]
    inc a
    ld [hl],a
    add hl,de
    ld a,b
    inc a
    ld b,a
    cp $16
    jp nz,LVL2_UPDATE_SPRITES_PLANET
    ret

LEVEL2_RESTART::
    jp LVL1_GOTO_LEVEL2
    ret

LVL2_FADE_OUT::
    ld a,[rSCY]
    cp $E0
    jp nz,LVL2_RET
    ld a,%00010110
    ld [rBGP],a
    ld [rOBP0],a
    ld c,$0F
    call WAIT
    ld a,%00000101
	ld	[rBGP],a
    ld	[rOBP0],a
    ld c,$0F
    call WAIT
    ld a,%00000001
	ld	[rBGP],a
    ld	[rOBP0],a
    ld c,$0F
    call WAIT
    ld a,%00000000
	ld	[rBGP],a
    ld	[rOBP0],a
    ld c,$0F
    call WAIT
    jp LVL2_GOTO_LEVEL3

LVL2_GOTO_LEVEL3::    
    nop
    halt

LVL2_RET::
    ret

LVL2_LOAD_MAP::
    call WAIT_VBLANK
    ld bc,64
    ld	de,$9800
    ld	hl,LVL2_MAP_0
    call LOAD_MAP
    call WAIT_VBLANK
    ld bc,64
    ld	de,$9840
    ld	hl,LVL2_MAP_1
    call LOAD_MAP
    call WAIT_VBLANK
    ld bc,64
    ld	de,$9880
    ld	hl,LVL2_MAP_2
    call LOAD_MAP
    call WAIT_VBLANK
    ld bc,64
    ld	de,$98C0
    ld	hl,LVL2_MAP_3
    call LOAD_MAP
    call WAIT_VBLANK
    ld bc,64
    ld	de,$9900
    ld	hl,LVL2_MAP_4
    call LOAD_MAP
    call WAIT_VBLANK
    ld bc,64
    ld	de,$9940
    ld	hl,LVL2_MAP_5
    call LOAD_MAP
    call WAIT_VBLANK
    ld bc,64
    ld	de,$9980
    ld	hl,LVL2_MAP_6
    call LOAD_MAP
    call WAIT_VBLANK
    ld bc,64
    ld	de,$99C0
    ld	hl,LVL2_MAP_7
    call LOAD_MAP
    call WAIT_VBLANK
    ld bc,64
    ld	de,$9A00
    ld	hl,LVL2_MAP_8
    call LOAD_MAP
    call WAIT_VBLANK
    ld bc,64
    ld	de,$9B80
    ld	hl,LVL2_MAP_0
    call LOAD_MAP
    call WAIT_VBLANK
    ld bc,64
    ld	de,$9BC0
    ld	hl,LVL2_MAP_0
    call LOAD_MAP
    ret