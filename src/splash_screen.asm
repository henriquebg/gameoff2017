SECTION "SplashScreen",ROM0

INIT_SPLASH::
    ld a,$70
    ld [rSCY],a

    call CLEAR_RAM

    ld b,$80
    ld e,$00

    ld c,$2A
    ld d,$00
    ld hl,sprite_0
    call INIT_SPRITE

    ld c,$32
    ld d,$02
    ld hl,sprite_1
    call INIT_SPRITE

    ld c,$3A
    ld d,$04
    ld hl,sprite_2
    call INIT_SPRITE

    ld c,$42
    ld d,$06
    ld hl,sprite_3
    call INIT_SPRITE

    ld c,$4A
    ld d,$06
    ld hl,sprite_4
    call INIT_SPRITE

    ld c,$5A
    ld d,$06
    ld hl,sprite_5
    call INIT_SPRITE

    ld c,$62
    ld d,$08
    ld hl,sprite_6
    call INIT_SPRITE

    ld c,$6A
    ld d,$0A
    ld hl,sprite_7
    call INIT_SPRITE

    ld c,$72
    ld d,$02
    ld hl,sprite_8
    call INIT_SPRITE

    ld c,$7A
    ld d,$08
    ld hl,sprite_9
    call INIT_SPRITE

    call $FF80

    ld a,$00
    ld [press_start_colour],a
    ld a,$08
    ld [press_start_delay],a
    ret

SPLASH_SCREEN::
    call WAIT_VBLANK
    ld a,[rSCY]
    cp $00
    jp z,SPLASH_SCROLL_END
    ld a,[rSCY]
    dec a
    ld [rSCY],a
    ld c,$02
    call WAIT
    nop
    jp SPLASH_SCREEN

SPLASH_SCROLL_END::
    ld hl,rBGP
    ld d,$08
    call FADE_OUT
    ld d,$08
    call FADE_IN
    ld c,$20
    call WAIT
    ld  a,%11000111
    ldh [rLCDC],a
;TODO: make it like a thread, because it's not working properly
SPLASH_WAIT::
    call WAIT_VBLANK
    call READ_JOYPAD
    ld  a,[joypad_pressed]
    call JOY_START
    jp z,EXIT_SPLASH
    ld a,[press_start_delay]
    cp $00
    jp z,CHANGE_PRESS_START
    dec a
    ld [press_start_delay],a
    jp SPLASH_WAIT

CHANGE_PRESS_START::
    ld a,[press_start_colour]
    cp $00
    jp z,PRESS_START_COLOUR_0
    cp $01
    jp z,PRESS_START_COLOUR_1
    cp $02
    jp z,PRESS_START_COLOUR_2
    ld a,$00
    ld [press_start_colour],a
    jp SPLASH_WAIT

PRESS_START_COLOUR_0::
    ld	a,%00100111
	ld	[rOBP0],a
    ld a,$01
    ld [press_start_colour],a
    ld a,$08
    ld [press_start_delay],a
    jp SPLASH_WAIT

PRESS_START_COLOUR_1::
    ld	a,%10100111
	ld	[rOBP0],a
    ld a,$02
    ld [press_start_colour],a
    ld a,$08
    ld [press_start_delay],a
    jp SPLASH_WAIT

PRESS_START_COLOUR_2::
    ld	a,%01100111
	ld	[rOBP0],a
    ld a,$00
    ld [press_start_colour],a
    ld a,$08
    ld [press_start_delay],a
    jp SPLASH_WAIT

EXIT_SPLASH::
    ;Initialising seed with value of divisor (kind of random).
    ld a,[rDIV]
    ld [seed_rand_num],a

    ld	a,%00100111
	ld	[rOBP0],a

    ld c,$3C
    call WAIT

    ld hl,rBGP
    ld d,$0F
    call FADE_OUT

    ld c,$10
    call WAIT

    ld a,$F0
    ld [sprite_0],a
    ld [sprite_1],a
    ld [sprite_2],a
    ld [sprite_3],a
    ld [sprite_4],a
    ld [sprite_5],a
    ld [sprite_6],a
    ld [sprite_7],a
    ld [sprite_8],a
    ld [sprite_9],a
    call WAIT_VBLANK
    call $FF80

    ld a,%11000011
    ld [rLCDC],a
    ret