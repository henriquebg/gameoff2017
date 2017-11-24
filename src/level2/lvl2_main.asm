Section "Level2",ROM0

LEVEL2::
    call LVL2_LOAD_MAP
    call LVL2_INIT_CHARACTER
    call LVL2_INIT_ENEMIES
    call LVL2_INIT_BACKGROUND

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
    call READ_JOYPAD
    call LVL2_UPDATE_CHARACTER
    call LVL2_UPDATE_ENEMIES
    nop
    jp LEVEL2_LOOP

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
    ret