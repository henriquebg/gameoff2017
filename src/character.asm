SECTION "Character",ROM0

INIT_CHARACTER::
    ld a,$50
    ld [sprite_character],a
    ld a,$48
    ld [sprite_character+1],a
    ld a,$00
    ld [sprite_character+2],a
    ld a,$00
    ld [sprite_character+3],a
    ret

UPDATE_CHARACTER::
    ld  a,[joypad_down]
    call JOY_A
    jp  nz,CHECK_UP
    ret

CHECK_UP::
    ld  a,[joypad_down]
    call JOY_UP
    jp  nz,CHECK_DOWN
    ld a,[sprite_character]
    sub a,_SPEED_CHARACTER
    cp _UPPER_BORDER
    jp c,CHECK_DOWN
    ld [sprite_character],a
    jp CHECK_RIGHT
    ret

CHECK_DOWN::
    ld  a,[joypad_down]
    call JOY_DOWN
    jp  nz,CHECK_RIGHT
    ld a,[sprite_character]
    add a,_SPEED_CHARACTER
    cp _LOWER_BORDER_OFFSET
    jp nc,CHECK_RIGHT
    ld [sprite_character],a
    jp CHECK_RIGHT
    ret

CHECK_RIGHT::
    ld  a,[joypad_down]
    call JOY_RIGHT
    jp  nz,CHECK_LEFT
    ld a,[sprite_character+1]
    add a,_SPEED_CHARACTER
    cp _RIGHT_BORDER
    jp nc,CHECK_LEFT
    ld [sprite_character+1],a
    ret

CHECK_LEFT::
    ld  a,[joypad_down]
    call JOY_LEFT
    jp  nz,END_CHARACTER
    ld a,[sprite_character+1]
    sub a,_SPEED_CHARACTER
    cp _LEFT_BORDER
    jp c,END_CHARACTER
    ld [sprite_character+1],a
    ret

END_CHARACTER::
    ret