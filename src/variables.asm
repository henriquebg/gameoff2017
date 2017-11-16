SECTION "RAM Vars",WRAM0[$C000]

;vblank variables from exezin's game
vblank_flag:           DB
vblank_count:          DB

;Joypad variables from exezin's game
joypad_down:           DB
joypad_pressed:        DB

;Enemies variables
enemy_0_y              DB
enemy_0_x              DB
enemy_0_sprite_delay   DB
enemy_0_sprite_set     DB

;Background animation variables
speed_anim_bg          DB
counter_anim_bg        DB

SECTION "OAM Vars",WRAM0[$C100]

sprite_character: DS 4

sprite_0_enemy_0: DS 4
sprite_1_enemy_0: DS 4
sprite_2_enemy_0: DS 4
sprite_3_enemy_0: DS 4