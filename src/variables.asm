SECTION "RAM Vars",WRAM0[$C000]

;vblank stuffs
vblank_flag:           DB
vblank_count:          DB

joypad_down:           DB
joypad_pressed:        DB

tiro_direcao:          DB
atirando:              DB

nave_direcao:          DB

scroll_delay           DB
comecou                DB
efeito_delay           DB

speed_anim_bg          DB
counter_anim_bg        DB

SECTION "OAM Vars",WRAM0[$C100]

sprite_character: DS 4