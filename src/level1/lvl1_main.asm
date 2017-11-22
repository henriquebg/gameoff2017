Section "Level1",ROM0

LEVEL1::
    call WAIT_VBLANK
    ld	hl,LVL1_SPRITES
	ld	de,$8000
	ld	bc,64
    call LOAD_TILES

    call WAIT_VBLANK
    ld	hl,LVL1_BG_TILES_0
	ld	de,$8800
	ld	bc,64
    call LOAD_TILES

    call WAIT_VBLANK
    ld	hl,LVL1_BG_TILES_1
	ld	de,$8840
	ld	bc,64
    call LOAD_TILES

    call WAIT_VBLANK
    ld	hl,LVL1_BG_TILES_2
	ld	de,$8880
	ld	bc,64
    call LOAD_TILES

    call WAIT_VBLANK
    ld	hl,LVL1_BG_TILES_3
	ld	de,$88C0
	ld	bc,64
    call LOAD_TILES

    call WAIT_VBLANK
    ld	hl,LVL1_BG_TILES_4
	ld	de,$8900
	ld	bc,64
    call LOAD_TILES

    call WAIT_VBLANK
    ld	hl,LVL1_BG_TILES_2
	ld	de,$8930
	ld	bc,48
    call LOAD_TILES

    call WAIT_VBLANK
    ld bc,64
    ld	de,$9800
    ld	hl,LVL1_MAP_0
    call LOAD_MAP

    call WAIT_VBLANK
    ld bc,64
    ld	de,$9840
    ld	hl,LVL1_MAP_1
    call LOAD_MAP

    call WAIT_VBLANK
    ld bc,64
    ld	de,$9880
    ld	hl,LVL1_MAP_2
    call LOAD_MAP

    call WAIT_VBLANK
    ld bc,64
    ld	de,$98C0
    ld	hl,LVL1_MAP_3
    call LOAD_MAP

    call WAIT_VBLANK
    ld bc,64
    ld	de,$9900
    ld	hl,LVL1_MAP_4
    call LOAD_MAP

    call WAIT_VBLANK
    ld bc,64
    ld	de,$9940
    ld	hl,LVL1_MAP_5
    call LOAD_MAP

    call WAIT_VBLANK
    ld bc,64
    ld	de,$9980
    ld	hl,LVL1_MAP_6
    call LOAD_MAP

    call WAIT_VBLANK
    ld bc,64
    ld	de,$99C0
    ld	hl,LVL1_MAP_7
    call LOAD_MAP

    call WAIT_VBLANK
    ld bc,64
    ld	de,$9A00
    ld	hl,LVL1_MAP_8
    call LOAD_MAP

    call WAIT_VBLANK
    ld bc,64
    ld	de,$9A40
    ld	hl,LVL1_MAP_9
    call LOAD_MAP

    call WAIT_VBLANK
    ld bc,64
    ld	de,$9A80
    ld	hl,LVL1_MAP_10
    call LOAD_MAP

    ld a,%00100111
    ld [rOBP0],a
    ld  a,%11000011
    ld [rLCDC],a

    call LVL1_INIT_CHARACTER

    ld hl,rBGP
    ld d,$0F
    call FADE_IN
    
    nop
    jp LEVEL1_LOOP

LEVEL1_LOOP::
    call WAIT_VBLANK
    call READ_JOYPAD
    call LVL1_UPDATE_CHAR
    ;call ATUALIZA_TIRO
    ;call ATUALIZA_INIMIGO
    call $FF80
    ;call SCROLL_BACKGROUND
    nop
    jp LEVEL1_LOOP