INCLUDE "constants.asm"
INCLUDE "variables.asm"
INCLUDE "header.asm"
INCLUDE "util.asm"
INCLUDE "background_map.asm"
INCLUDE "tiles_table.asm"
INCLUDE "background_animation.asm"
INCLUDE "character.asm"

;****************************************************************************************************************************************************
;*	Program Start
;****************************************************************************************************************************************************

SECTION "StartGame",ROM0[$0150]
START::
	di			;disable interrupts
	ld	sp,$FFFE	;set the stack to $FFFE
	call WAIT_VBLANK	;wait for v-blank

	ld	a,0		;
	ldh	[rLCDC],a	;turn off LCD 

    call CLEAR_MAP
    call CLEAR_OAM
    call CLEAR_RAM

    ld	hl,BG0_0
	ld	de,$9000
	ld	bc,6*16
    call LOAD_TILES
    ld	hl,BG0_1
	ld	de,$9084
	ld	bc,6*16
    call LOAD_TILES

    ld	hl,CHARACTER_TILES
	ld	de,$8000
	ld	bc,1*16
    call LOAD_TILES

    ld	de,_SCRN0	;where our map goes
    ld	hl,BGMAP	;our little map
    call LOAD_MAP
	
    ld	a,%11100100	;load a normal palette up 11 10 01 00 - dark->light
	ldh	[rBGP],a	;load the palette

    ld	a,%11100100	;load a normal palette up 11 10 01 00 - dark->light
	ldh	[rOBP0],a	;load the palette

	;turn on LCD, BG0, OBJ0, etc
    ld  a,%11000011
    ldh [rLCDC],a

    call INIT_CHARACTER
    call PLACE_CHARACTER
    ld a,$00
    ld [speed_anim_bg],a
    ld [counter_anim_bg],a
    ld [comecou],a
    call DMA_COPY
    ei

LOOP::
	call WAIT_VBLANK
    call BACKGROUND_ANIMATE
    call READ_JOYPAD
    call UPDATE_CHARACTER
    call $FF80
    nop
	jp LOOP

BEGIN_GAME::
    call $FF80
    nop
    jp LOOP


