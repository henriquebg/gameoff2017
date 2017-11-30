Section "Level3",ROM0

LEVEL3::
    ld a,%11111111
    ld [rOBP0],a
    ld  a,%11001011
    ld [rLCDC],a
    
    call LVL3_INIT_CHARACTER
    call LVL3_INIT_SHOT
    call LVL3_INIT_BOSS
    call LVL3_INIT_BOSS_SHOT

    ld a,$00
    ld [lvl3_score],a

    ld a,$01
    ld [lvl3_scroll_speed],a
    ld a,$01
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
    
    ld c,$80
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
    jp c,LVL3_ANIM_BEGIN
    ld c,$80
    call WAIT
    jp LEVEL3_LOOP

LEVEL3_LOOP::
    call WAIT_VBLANK
    call $FF80
    call READ_JOYPAD
    call LVL3_UPDATE_CHAR
    call LVL3_UPDATE_SHOT
    ld a,[lvl3_boss_hits]
    cp $01
    jp z,LEVEL3_END
    call LVL3_UPDATE_BOSS
    call LVL3_UPDATE_BOSS_SHOT
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

LEVEL3_END::
    ld a,$F0
    ld [sprite_2],a
    ld [sprite_4],a
    call WAIT_VBLANK
    call $FF80
    ld c,$0F
    ld hl,rOBP1
    call FADE_OUT_INV
    ld a,%00100111
    ld [rOBP1],a
    ld c,$0F
    ld hl,rOBP1
    call FADE_OUT_INV
    ld a,%00100111
    ld [rOBP1],a
    ld c,$0F
    ld hl,rOBP1
    call FADE_OUT_INV
    ld a,%00100111
    ld [rOBP1],a
    ld c,$0F
    ld hl,rOBP1
    call FADE_OUT_INV
    ld a,%00100111
    ld [rOBP1],a

    ld c,$0F
    call WAIT
    ld a,$3B
    ld [sprite_5+2],a
    ld a,$3C
    ld [sprite_7+2],a
    call WAIT_VBLANK
    call $FF80
    ld c,$0F
    call WAIT
    ld a,$3D
    ld [sprite_5+2],a
    ld a,$3E
    ld [sprite_7+2],a
    call WAIT_VBLANK
    call $FF80
    ld c,$0F
    call WAIT
    ld a,$3F
    ld [sprite_5+2],a
    ld a,$40
    ld [sprite_7+2],a
    call WAIT_VBLANK
    call $FF80
    ld c,$0F
    call WAIT
    ld a,$41
    ld [sprite_5+2],a
    ld a,$39
    ld [sprite_6+2],a
    ld a,$41
    ld [sprite_7+2],a
    ld a,$3A
    ld [sprite_8+2],a
    call WAIT_VBLANK
    call $FF80
    ld c,$0F
    call WAIT
    ld a,$41
    ld [sprite_5+2],a
    ld a,$41
    ld [sprite_7+2],a
    call WAIT_VBLANK
    call $FF80
    ld c,$0F
    call WAIT
    ld a,$F0
    ld [sprite_5],a
    ld [sprite_7],a
    ld a,$42
    ld [sprite_6+2],a
    ld a,$43
    ld [sprite_8+2],a
    call WAIT_VBLANK
    call $FF80
    ld c,$0F
    call WAIT
    ld a,$44
    ld [sprite_6+2],a
    ld a,$45
    ld [sprite_8+2],a
    call WAIT_VBLANK
    call $FF80
    ld c,$0F
    call WAIT
    ld a,$46
    ld [sprite_6+2],a
    ld a,$47
    ld [sprite_8+2],a
    call WAIT_VBLANK
    call $FF80
    ld c,$0F
    call WAIT
    ld a,$F0
    ld [lvl3_boss_y],a
    ld [lvl3_boss_x],a
    call LVL3_UPDATE_BOSS_POSITION
    call WAIT_VBLANK
    call $FF80
    ld c,$3C
    call WAIT
    ld d,$0F
    ld hl,rBGP
    call FADE_OUT
    ld d,$0F
    ld hl,rOBP0
    call FADE_OUT
    nop
    halt