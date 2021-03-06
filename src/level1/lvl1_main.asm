Section "Level1",ROM0

LEVEL1::
    ld a,%11111111
    ld [rOBP0],a
    ld  a,%11001011
    ld [rLCDC],a
    
    call LVL1_INIT_CHARACTER
    call LVL1_INIT_SHOT
    call LVL1_INIT_ENEMY

    ld a,$00
    ld [lvl1_score],a

    ld a,$04
    ld [lvl1_scroll_speed],a
    ld [lvl1_scroll_delay],a

    ld hl,rBGP
    ld d,$0F
    call FADE_IN

    call WAIT_VBLANK
    call $FF80

    ld hl,rOBP0
    ld d,$0F
    call FADE_IN
    ld a,%00100111
    ld [rOBP0],a
    
    ld c,$72
    call WAIT

    nop
    jp LEVEL1_LOOP

LEVEL1_LOOP::
    call WAIT_VBLANK
    call $FF80
    call READ_JOYPAD
    call LVL1_UPDATE_CHAR
    call LVL1_UPDATE_SHOT
    call LVL1_UPDATE_ENEMY
    call LVL1_SCROLL_BACKGROUND
    jp LEVEL1_LOOP

LVL1_SCROLL_BACKGROUND::
    ld a,[lvl1_scroll_delay]
    cp $00
    jp z,LVL1_SCROLL_BG
    dec a
    ld [lvl1_scroll_delay],a
    ret

LVL1_SCROLL_BG::
    ld a,[rSCX]
    inc a
    ld [rSCX],a
    ld a,[lvl1_scroll_speed]
    ld [lvl1_scroll_delay],a
    ret