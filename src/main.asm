INCLUDE "constants.asm"
INCLUDE "variables.asm"
INCLUDE "header.asm"
INCLUDE "util.asm"
INCLUDE "maps.asm"
INCLUDE "tiles_table.asm"
INCLUDE "background_animation.asm"
INCLUDE "character.asm"
INCLUDE "enemies.asm"
INCLUDE "splash_screen.asm"

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

    ld	hl,SPLASH_SPRITES
	ld	de,$8000
	ld	bc,192
    call LOAD_TILES

    ld	hl,SPLASH_TILES
	ld	de,$8800
	ld	bc,147*16
    call LOAD_TILES

    ld	de,_SCRN0	;where our map goes
    ld	hl,SPLASH_MAP	;our little map
    call LOAD_MAP
	
    ld	a,%11100100	;load a normal palette up 11 10 01 00 - dark->light
	ldh	[rBGP],a	;load the palette

    ld	a,%00100111	;load a normal palette up 11 10 01 00 - dark->light
	ldh	[rOBP0],a	;load the palette

	;turn on LCD, BG0, OBJ0, etc
    ld  a,%11000101
    ldh [rLCDC],a

    call INIT_CHARACTER
    call INIT_ENEMIES
    
    ;call INIT_BACKGROUND
    call DMA_COPY
    ei

BEGIN_GAME::
    call INIT_SPLASH
    call SPLASH_SCREEN
LOOP::
	call WAIT_VBLANK
    ld d,$08
    call FADE_OUT
    ;call BACKGROUND_ANIMATE
    call READ_JOYPAD
    ;call UPDATE_CHARACTER
    ;call UPDATE_ENEMIES
    ;call $FF80
    nop
	jp LOOP


