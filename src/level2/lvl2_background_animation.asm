SECTION "Level2Background Animation",ROM0

LVL2_INIT_BACKGROUND::
    ld a,$00
    ld [lvl2_speed_anim_bg],a
    ld [lvl2_counter_anim_bg],a

LVL2_BACKGROUND_ANIMATE::
    ld a,[lvl2_speed_anim_bg]
    cp $02
    jp z,LVL2_CHANGE_BG0
    inc a
    ld [lvl2_speed_anim_bg],a
    ret

LVL2_CHANGE_BG0::
    ld a,[lvl2_counter_anim_bg]
    cp $00
    jp nz,LVL2_CHANGE_BG1
    inc a
    ld [lvl2_counter_anim_bg],a
    ld	hl,LVL2_BG0_0
	ld	de,$92A0
	ld	bc,64
    call LOAD_TILES
    call WAIT_VBLANK
    ld	hl,LVL2_BG0_1
	ld	de,$92E0
	ld	bc,64
    call LOAD_TILES
    call WAIT_VBLANK
    ld	hl,LVL2_BG0_2
	ld	de,$9320
	ld	bc,64
    call LOAD_TILES
    ld a,$00
    ld [lvl2_speed_anim_bg],a
    nop
    ret

LVL2_CHANGE_BG1::
    ld a,[lvl2_counter_anim_bg]
    cp $01
    jp nz,LVL2_CHANGE_BG2
    inc a
    ld [lvl2_counter_anim_bg],a
    ld	hl,LVL2_BG1_0
	ld	de,$92A0
	ld	bc,64
    call LOAD_TILES
    call WAIT_VBLANK
    ld	hl,LVL2_BG1_1
	ld	de,$92E0
	ld	bc,64
    call LOAD_TILES
    call WAIT_VBLANK
    ld	hl,LVL2_BG1_2
	ld	de,$9320
	ld	bc,64
    call LOAD_TILES
    ld a,$00
    ld [lvl2_speed_anim_bg],a
    nop
    ret

LVL2_CHANGE_BG2::
   ld a,[lvl2_counter_anim_bg]
    cp $02
    jp nz,LVL2_CHANGE_BG3
    inc a
    ld [lvl2_counter_anim_bg],a
    ld	hl,LVL2_BG2_0
	ld	de,$92A0
	ld	bc,64
    call LOAD_TILES
    call WAIT_VBLANK
    ld	hl,LVL2_BG2_1
	ld	de,$92E0
	ld	bc,64
    call LOAD_TILES
    call WAIT_VBLANK
    ld	hl,LVL2_BG2_2
	ld	de,$9320
	ld	bc,64
    call LOAD_TILES
    ld a,$00
    ld [lvl2_speed_anim_bg],a
    nop
    ret

LVL2_CHANGE_BG3::
    ld a,[lvl2_counter_anim_bg]
    cp $03
    jp nz,LVL2_RESET
    ld	hl,LVL2_BG3_0
	ld	de,$92A0
	ld	bc,64
    call LOAD_TILES
    call WAIT_VBLANK
    ld	hl,LVL2_BG3_1
	ld	de,$92E0
	ld	bc,64
    call LOAD_TILES
    call WAIT_VBLANK
    ld	hl,LVL2_BG3_2
	ld	de,$9320
	ld	bc,64
    call LOAD_TILES
    ld a,$00
    ld [lvl2_counter_anim_bg],a
    ld [lvl2_speed_anim_bg],a
    nop
    ret

LVL2_RESET::
    ld a,$00
    ld [lvl2_counter_anim_bg],a
    nop
    ret