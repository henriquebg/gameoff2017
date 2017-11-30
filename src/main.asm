INCLUDE "constants.asm"
INCLUDE "variables.asm"
INCLUDE "header.asm"
INCLUDE "util.asm"
INCLUDE "maps.asm"
INCLUDE "tiles_table.asm"
INCLUDE "splash_screen.asm"
INCLUDE "level1/lvl1_main.asm"
INCLUDE "level1/lvl1_character.asm"
INCLUDE "level1/lvl1_shot.asm"
INCLUDE "level1/lvl1_enemy.asm"
INCLUDE "level2/lvl2_main.asm"
INCLUDE "level2/lvl2_character.asm"
INCLUDE "level2/lvl2_enemies.asm"
INCLUDE "level2/lvl2_enemy_0.asm"
INCLUDE "level2/lvl2_enemy_1.asm"
INCLUDE "level2/lvl2_background_animation.asm"
INCLUDE "level3/lvl3_main.asm"
INCLUDE "level3/lvl3_character.asm"
INCLUDE "level3/lvl3_shot.asm"
;INCLUDE "level3/lvl3_enemy.asm"
INCLUDE "level3/lvl3_boss.asm"
INCLUDE "level3/lvl3_boss_shot.asm"

;****************************************************************************************************************************************************
;*	Program Start
;****************************************************************************************************************************************************

SECTION "StartGame",ROM0[$0150]
START::
	di			;disable interrupts
	ld	sp,$FFFE	;set the stack to $FFFE
	call WAIT_VBLANK	;wait for v-blank

	ld	a,%00000000
	ld	[rLCDC],a	;turn off LCD 

    call CLEAR_MAP
    call CLEAR_OAM
    call CLEAR_RAM

    ;Load sprite tiles for Splash Screen, Level 1 and Level 2
    ld	hl,SPRITES
	ld	de,$8000
	ld	bc,1152
    call LOAD_TILES

    ;Load background tiles for Splash Screen, Level 1 and Level 2
    ld	hl,TILES
	ld	de,$8800
	ld	bc,2912
    call LOAD_TILES

    ;Load maps for Splash Screen and Level 1
    ld bc,1024
    ld	de,_SCRN0
    ld	hl,SPLASH_MAP
    call LOAD_MAP

    ld bc,1024
    ld	de,_SCRN1
    ld	hl,LVL1_MAP
    call LOAD_MAP
	
    ;Loading background and sprites palletes for Splash Screen
    ld	a,%11100100	;load a normal palette up 11 10 01 00 - dark->light
	ld	[rBGP],a	;load the palette

    ld	a,%00100111	;load a normal palette up 11 10 01 00 - dark->light
	ld	[rOBP0],a	;load the palette

	;turn on LCD, BG0, OBJ0, etc
    ld  a,%11000001
    ld [rLCDC],a

    ; ;Initialising seed with current divisor's value
    ; ld a,[rDIV]
    ; ld [seed_rand_num],a

    ;Copy DMA routine to High RAM for transferring sprites to OAM
    call DMA_COPY
    ei

BEGIN_GAME::
    ; call INIT_SPLASH
    ; call SPLASH_SCREEN
    call LEVEL3
    nop
    halt
    jp BEGIN_GAME


