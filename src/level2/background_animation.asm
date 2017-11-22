SECTION "Background Animation",ROM0

INIT_BACKGROUND::
    ld a,$00
    ld [speed_anim_bg],a
    ld [counter_anim_bg],a

BACKGROUND_ANIMATE::
    ld a,[speed_anim_bg]
    cp $02
    jp z,CHANGE_BG0
    inc a
    ld [speed_anim_bg],a
    ret

CHANGE_BG0::
    ld a,[counter_anim_bg]
    cp $00
    jp nz,CHANGE_BG1
    inc a
    ld [counter_anim_bg],a
    ld	hl,BG0_0
	ld	de,$9000
	ld	bc,4*16
    call LOAD_TILES
    call WAIT_VBLANK
    ld	hl,BG0_1
	ld	de,$9040
	ld	bc,4*16
    call LOAD_TILES
    call WAIT_VBLANK
    ld	hl,BG0_2
	ld	de,$9080
	ld	bc,4*16
    call LOAD_TILES
    ld a,$00
    ld [speed_anim_bg],a
    nop
    ret

CHANGE_BG1::
    ld a,[counter_anim_bg]
    cp $01
    jp nz,CHANGE_BG2
    inc a
    ld [counter_anim_bg],a
    ld	hl,BG1_0
	ld	de,$9000
	ld	bc,4*16
    call LOAD_TILES
    call WAIT_VBLANK
    ld	hl,BG1_1
	ld	de,$9040
	ld	bc,4*16
    call LOAD_TILES
    call WAIT_VBLANK
    ld	hl,BG1_2
	ld	de,$9080
	ld	bc,4*16
    call LOAD_TILES
    ld a,$00
    ld [speed_anim_bg],a
    nop
    ret

CHANGE_BG2::
   ld a,[counter_anim_bg]
    cp $02
    jp nz,CHANGE_BG3
    inc a
    ld [counter_anim_bg],a
    ld	hl,BG2_0
	ld	de,$9000
	ld	bc,4*16
    call LOAD_TILES
    call WAIT_VBLANK
    ld	hl,BG2_1
	ld	de,$9040
	ld	bc,4*16
    call LOAD_TILES
    call WAIT_VBLANK
    ld	hl,BG2_2
	ld	de,$9080
	ld	bc,4*16
    call LOAD_TILES
    ld a,$00
    ld [speed_anim_bg],a
    nop
    ret

CHANGE_BG3::
    ld a,[counter_anim_bg]
    cp $03
    jp nz,ZERA
    ld	hl,BG3_0
	ld	de,$9000
	ld	bc,4*16
    call LOAD_TILES
    call WAIT_VBLANK
    ld	hl,BG3_1
	ld	de,$9040
	ld	bc,4*16
    call LOAD_TILES
    call WAIT_VBLANK
    ld	hl,BG3_2
	ld	de,$9080
	ld	bc,4*16
    call LOAD_TILES
    ld a,$00
    ld [counter_anim_bg],a
    ld [speed_anim_bg],a
    nop
    ret

ZERA::
    ld a,$00
    ld [counter_anim_bg],a
    nop
    ret