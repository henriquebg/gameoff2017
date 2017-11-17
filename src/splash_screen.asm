SECTION "SplashScreen",ROM0

INIT_SPLASH::
    ld a,$70
    ld [rSCY],a

    call CLEAR_RAM

    ld a,$80
    ld [sprite_0_splash],a
    ld [sprite_1_splash],a
    ld [sprite_2_splash],a
    ld [sprite_3_splash],a
    ld [sprite_4_splash],a
    ld [sprite_5_splash],a
    ld [sprite_6_splash],a
    ld [sprite_7_splash],a
    ld [sprite_8_splash],a
    ld [sprite_9_splash],a

    ld a,$2A
    ld [sprite_0_splash+1],a
    ld a,$32
    ld [sprite_1_splash+1],a
    ld a,$3A
    ld [sprite_2_splash+1],a
    ld a,$42
    ld [sprite_3_splash+1],a
    ld a,$4A
    ld [sprite_4_splash+1],a
    ld a,$5A
    ld [sprite_5_splash+1],a
    ld a,$62
    ld [sprite_6_splash+1],a
    ld a,$6A
    ld [sprite_7_splash+1],a
    ld a,$72
    ld [sprite_8_splash+1],a
    ld a,$7A
    ld [sprite_9_splash+1],a

    ld a,$00
    ld [sprite_0_splash+2],a
    ld a,$02
    ld [sprite_1_splash+2],a
    ld a,$04
    ld [sprite_2_splash+2],a
    ld a,$06
    ld [sprite_3_splash+2],a
    ld a,$06
    ld [sprite_4_splash+2],a
    ld a,$06
    ld [sprite_5_splash+2],a
    ld a,$08
    ld [sprite_6_splash+2],a
    ld a,$0A
    ld [sprite_7_splash+2],a
    ld a,$02
    ld [sprite_8_splash+2],a
    ld a,$08
    ld [sprite_9_splash+2],a

    ld a,$00
    ld [sprite_0_splash+3],a
    ld [sprite_1_splash+3],a
    ld [sprite_2_splash+3],a
    ld [sprite_3_splash+3],a
    ld [sprite_4_splash+3],a
    ld [sprite_5_splash+3],a
    ld [sprite_6_splash+3],a
    ld [sprite_7_splash+3],a
    ld [sprite_8_splash+3],a
    ld [sprite_9_splash+3],a
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
    ret