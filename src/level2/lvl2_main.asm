Section "Level2",ROM0

LEVEL2::
    ld a,%00011011
    ld [rOBP0],a
    ld a,%00100111
    ld [rBGP],a
    ld  a,%11001011
    ld [rLCDC],a

    call LVL2_INIT_CHARACTER
    call LVL2_INIT_ENEMIES
    call LVL2_INIT_BACKGROUND

LEVEL2_LOOP::
    call WAIT_VBLANK
    call LVL2_BACKGROUND_ANIMATE
    call $FF80
    call READ_JOYPAD
    call LVL2_UPDATE_CHARACTER
    call LVL2_UPDATE_ENEMIES
    nop
    jp LEVEL2_LOOP