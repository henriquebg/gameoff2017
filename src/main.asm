INCLUDE "constants.asm"
INCLUDE "variables.asm"
INCLUDE "header.asm"
INCLUDE "util.asm"
INCLUDE "maps.asm"
INCLUDE "tiles_table.asm"
INCLUDE "background_animation.asm"
INCLUDE "character.asm"
INCLUDE "enemies.asm"

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

    ld	hl,SPLASH_TILES
	ld	de,$8800
	ld	bc,147*16
    call LOAD_TILES

    ; ld	hl,BG0_0
	; ld	de,$9000
	; ld	bc,6*16
    ; call LOAD_TILES
    ; ld	hl,BG0_1
	; ld	de,$9084
	; ld	bc,6*16
    ; call LOAD_TILES

    ; ld	hl,SPRITES
	; ld	de,$8000
	; ld	bc,17*16
    ; call LOAD_TILES

    ld	de,_SCRN0	;where our map goes
    ld	hl,SPLASH_MAP	;our little map
    call LOAD_MAP

    ; ld	de,_SCRN1	;where our map goes
    ; ld	hl,WINDOWMAP	;our little map
    ; call LOAD_MAP
	
    ld	a,%11100100	;load a normal palette up 11 10 01 00 - dark->light
	ldh	[rBGP],a	;load the palette

    ld	a,%11100100	;load a normal palette up 11 10 01 00 - dark->light
	ldh	[rOBP0],a	;load the palette

	;turn on LCD, BG0, OBJ0, etc
    ld  a,%11000011
    ldh [rLCDC],a

    ld a,$A0
    ld [rSCY],a

    call INIT_CHARACTER
    call INIT_ENEMIES
    ;call INIT_BACKGROUND
    call DMA_COPY
    ei

LOOP::
	call WAIT_VBLANK
    call SPLASH_ANIM
    ;call BACKGROUND_ANIMATE
    call READ_JOYPAD
    ;call UPDATE_CHARACTER
    ;call UPDATE_ENEMIES
    ;call $FF80
    nop
	jp LOOP

SPLASH_ANIM::
    ld a,[rSCY]
    cp $00
    jp z,SPLASH_ANIM_END
    inc a
    ld [rSCY],a
    ret

SPLASH_ANIM_END::
    ret

BEGIN_GAME::
    call $FF80
    nop
    jp LOOP


