Section "Level1",ROM0

LEVEL3::
    ld a,%11111111
    ld [rOBP0],a
    ld  a,%11001011
    ld [rLCDC],a
    
    call LVL3_INIT_CHARACTER
    call LVL3_INIT_SHOT
    call LVL3_INIT_BOSS

    ld a,$00
    ld [lvl3_score],a

    ld a,$05
    ld [lvl3_scroll_speed],a
    ld [lvl3_scroll_delay],a

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
    jp LVL3_ANIM_BEGIN

LVL3_ANIM_BEGIN::
    call WAIT_VBLANK
    call $FF80
    call LVL3_SCROLL_BACKGROUND
    call LVL3_UPDATE_BOSS_POSITION
    ld a,[rSCX]
    cp $60
    jp nz,LVL3_ANIM_BEGIN
    jp LEVEL3_LOOP

LEVEL3_LOOP::
    call WAIT_VBLANK
    call $FF80
    call READ_JOYPAD
    call LVL3_UPDATE_CHAR
    call LVL3_UPDATE_SHOT
    call LVL3_UPDATE_BOSS
    jp LEVEL3_LOOP

LVL3_SCROLL_BACKGROUND::
    ld a,[lvl3_scroll_delay]
    cp $00
    jp z,LVL3_SCROLL_BG
    dec a
    ld [lvl3_scroll_delay],a
    ret

LVL3_SCROLL_BG::
    ld a,[rSCX]
    inc a
    ld [rSCX],a
    ld a,[lvl3_scroll_speed]
    ld [lvl3_scroll_delay],a
    ld a,[lvl3_boss_x]
    dec a
    ld [lvl3_boss_x],a
    ret

LVL3_SCROLL_END::
    ret