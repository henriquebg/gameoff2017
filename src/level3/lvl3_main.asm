Section "Level3",ROM0

LEVEL3::
    call WAIT_VBLANK
    ld	a,%00000000
	ld	[rLCDC],a

    ld bc,576
    ld	de,_SCRN1
    ld	hl,LVL3_MAP
    call LOAD_MAP

    call LVL3_INIT_CHARACTER
    call LVL3_INIT_SHOT
    call LVL3_INIT_BOSS
    call LVL3_INIT_BOSS_SHOT

    ld a,$00
    ld [rSCY],a
    ld a,$F0
    ld [rSCX],a
    ld a,%11111111
    ld [rOBP0],a
    ld a,%11001011
    ld [rLCDC],a

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
    jp nz,LVL3_ANIM_BEGIN
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
    cp $20
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
    ld a,[rSCX]
    cp $F0
    jp nc,LVL3_SCROLL_END
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

    call LVL3_REPEAT_VBLANK_WAIT
    ld a,$3B
    ld [sprite_5+2],a
    ld a,$3C
    ld [sprite_7+2],a
    call LVL3_REPEAT_VBLANK_WAIT
    ld a,$3D
    ld [sprite_5+2],a
    ld a,$3E
    ld [sprite_7+2],a
    call LVL3_REPEAT_VBLANK_WAIT
    ld a,$3F
    ld [sprite_5+2],a
    ld a,$40
    ld [sprite_7+2],a
    call LVL3_REPEAT_VBLANK_WAIT
    ld a,$41
    ld [sprite_5+2],a
    ld a,$39
    ld [sprite_6+2],a
    ld a,$41
    ld [sprite_7+2],a
    ld a,$3A
    ld [sprite_8+2],a
    call LVL3_REPEAT_VBLANK_WAIT
    ld a,$F0
    ld [sprite_5],a
    ld [sprite_7],a
    ld a,$42
    ld [sprite_6+2],a
    ld a,$43
    ld [sprite_8+2],a
    call LVL3_REPEAT_VBLANK_WAIT
    ld a,$44
    ld [sprite_6+2],a
    ld a,$45
    ld [sprite_8+2],a
    call LVL3_REPEAT_VBLANK_WAIT
    ld a,$46
    ld [sprite_6+2],a
    ld a,$47
    ld [sprite_8+2],a
    call LVL3_REPEAT_VBLANK_WAIT
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
    ld a,$F0
    ld [sprite_0],a
    ld [sprite_1],a

    call WAIT_VBLANK
    call $FF80
    ld  a,%00000000
    ld [rLCDC],a
    ld bc,680
    ld	de,$8800
    ld	hl,ENDING_TILES_1
    call LOAD_MAP
    ld bc,680
    ld	de,$8AA8
    ld	hl,ENDING_TILES_2
    call LOAD_MAP
    ld bc,576
    ld	de,_SCRN0
    ld	hl,ENDING_MAP
    call LOAD_MAP
    ld a,%11000011
    ld [rLCDC],a
    ld a,$00
    ld [rSCX],a
    ld d,$1E
    ld hl,rBGP
    call FADE_IN
    call WAIT_VBLANK
ENDING_LOOP::
    call READ_JOYPAD
    ld  a,[joypad_pressed]
    call JOY_START
    jp z,LVL3_GOTO_START
    jp ENDING_LOOP

LVL3_GOTO_START::
    ld d,$1E
    ld hl,rBGP
    call FADE_OUT
    jp START

LVL3_REPEAT_VBLANK_WAIT::
    call WAIT_VBLANK
    call $FF80
    ld c,$0F
    call WAIT
    ret