SECTION "RAM Vars",WRAM0[$C000]

;vblank variables from exezin's game
vblank_flag:           DB
vblank_count:          DB

;Joypad variables from exezin's game
joypad_down:           DB
joypad_pressed:        DB

;Splash screen variable
splash_scroll_delay    DB
splash_anim_wait       DB

;Background animation variables
speed_anim_bg          DB
counter_anim_bg        DB

;Enemies variables
enemy_0_y              DB
enemy_0_x              DB
enemy_0_sprite_delay   DB
enemy_0_sprite_set     DB



SECTION "OAM Vars",WRAM0[$C100]

sprite_0_splash:  DS 4
sprite_1_splash:  DS 4
sprite_2_splash:  DS 4
sprite_3_splash:  DS 4
sprite_4_splash:  DS 4
sprite_5_splash:  DS 4
sprite_6_splash:  DS 4
sprite_7_splash:  DS 4
sprite_8_splash:  DS 4
sprite_9_splash:  DS 4

sprite_character: DS 4

sprite_0_enemy_0: DS 4
sprite_1_enemy_0: DS 4
sprite_2_enemy_0: DS 4
sprite_3_enemy_0: DS 4