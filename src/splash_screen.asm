SECTION "SplashScreen",ROM0

INIT_SPLASH::
    ld a,$70
    ld [rSCY],a

    call CLEAR_RAM

    ;Setting PRESS START sprites' position
    ld a,$80
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

    ld a,$2A
    ld [sprite_0+1],a
    ld a,$32
    ld [sprite_1+1],a
    ld a,$3A
    ld [sprite_2+1],a
    ld a,$42
    ld [sprite_3+1],a
    ld a,$4A
    ld [sprite_4+1],a
    ld a,$5A
    ld [sprite_5+1],a
    ld a,$62
    ld [sprite_6+1],a
    ld a,$6A
    ld [sprite_7+1],a
    ld a,$72
    ld [sprite_8+1],a
    ld a,$7A
    ld [sprite_9+1],a

    ld a,$00
    ld [sprite_0+2],a
    ld a,$02
    ld [sprite_1+2],a
    ld a,$04
    ld [sprite_2+2],a
    ld a,$06
    ld [sprite_3+2],a
    ld a,$06
    ld [sprite_4+2],a
    ld a,$06
    ld [sprite_5+2],a
    ld a,$08
    ld [sprite_6+2],a
    ld a,$0A
    ld [sprite_7+2],a
    ld a,$02
    ld [sprite_8+2],a
    ld a,$08
    ld [sprite_9+2],a

    ld a,$00
    ld [sprite_0+3],a
    ld [sprite_1+3],a
    ld [sprite_2+3],a
    ld [sprite_3+3],a
    ld [sprite_4+3],a
    ld [sprite_5+3],a
    ld [sprite_6+3],a
    ld [sprite_7+3],a
    ld [sprite_8+3],a
    ld [sprite_9+3],a
    call $FF80
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
    ld	a,%00100111
	ldh	[rOBP0],a
    ld  a,[joypad_pressed]
    call JOY_START
    jp z,EXIT_SPLASH
    ld c,$08
    call WAIT
    ld	a,%10100111
	ldh	[rOBP0],a
    ld  a,[joypad_pressed]
    call JOY_START
    jp z,EXIT_SPLASH
    ld c,$08
    call WAIT
    ld	a,%01100111
	ldh	[rOBP0],a
    ld  a,[joypad_pressed]
    call JOY_START
    jp z,EXIT_SPLASH
    ld c,$08
    call WAIT
    ld  a,[joypad_pressed]
    call JOY_START
    jp z,EXIT_SPLASH
    nop
    jp SPLASH_WAIT

EXIT_SPLASH::
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

    call $FF80
    
    ld a,%11000011
    ld [rLCDC],a

    ld hl,rBGP
    ld d,$08
    call FADE_OUT
    ld hl,rOBP0
    ld d,$01
    call FADE_OUT
    ret