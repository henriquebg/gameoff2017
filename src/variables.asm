SECTION "RAM Vars",WRAM0[$C000]

;vblank variables from exezin's game
vblank_flag:                DB
vblank_count:               DB

;Joypad variables from exezin's game
joypad_down:                DB
joypad_pressed:             DB

;Splash screen variables
splash_scroll_delay         DB
splash_anim_wait            DB
press_start_delay           DB
press_start_colour          DB

; ;Random number generator's seed
seed_rand_num               DB

;Level 1 variables
lvl1_is_shooting            DB
lvl1_enemy_direction        DB
lvl1_enemy_delay            DB
lvl1_enemy_speed_delay      DB
lvl1_enemy_speed_x          DB
lvl1_enemy_speed_y          DB
lvl1_score                  DB
lvl1_scroll_delay           DB
lvl1_scroll_speed           DB
lvl1_speed_character        DB
lvl1_speed_shot             DB
lvl1_plot_twist             DB

;Level 2 variables
;Background animation variables
lvl2_speed_anim_bg          DB
lvl2_counter_anim_bg        DB
lvl2_speed_character        DB

;Enemies variables
lvl2_enemies_change_speed   DB

lvl2_enemy_0_y              DB
lvl2_enemy_0_x              DB
lvl2_enemy_0_sprite_delay   DB
lvl2_enemy_0_sprite_set     DB
lvl2_enemy_0_is_active      DB
lvl2_enemy_0_spawn_delay    DB

;Enemies variables
lvl2_enemy_1_y              DB
lvl2_enemy_1_x              DB
lvl2_enemy_1_sprite_delay   DB
lvl2_enemy_1_sprite_set     DB
lvl2_enemy_1_is_active      DB
lvl2_enemy_1_spawn_delay    DB

;Character variables
lvl2_is_shooting            DB

;General variables
lvl2_score                  DB
lvl2_lives                  DB
lvl2_enemies_active         DB
lvl2_anim_planet_delay      DB

;Level 3 variables
lvl3_is_shooting            DB
lvl3_score                  DB
lvl3_scroll_delay           DB
lvl3_scroll_speed           DB
lvl3_speed_character        DB
lvl3_speed_shot             DB
lvl3_plot_twist             DB
lvl3_boss_x                 DB
lvl3_boss_y                 DB
lvl3_boss_direction         DB
lvl3_boss_delay             DB
lvl3_boss_speed_delay       DB
lvl3_boss_speed_y           DB
lvl3_boss_hits              DB
lvl3_speed_boss_shot        DB
lvl3_is_boss_shooting       DB
lvl3_boss_anim_delay        DB
lvl3_boss_anim_speed        DB
lvl3_boss_anim_set          DB

SECTION "OAM Vars",WRAM0[$C100]

sprite_0:  DS 4
sprite_1:  DS 4
sprite_2:  DS 4
sprite_3:  DS 4
sprite_4:  DS 4
sprite_5:  DS 4
sprite_6:  DS 4
sprite_7:  DS 4
sprite_8:  DS 4
sprite_9:  DS 4
sprite_10:  DS 4
sprite_11:  DS 4
sprite_12:  DS 4
sprite_13:  DS 4
sprite_14:  DS 4
sprite_15:  DS 4
sprite_16:  DS 4
sprite_17:  DS 4
sprite_18:  DS 4
sprite_19:  DS 4
sprite_20:  DS 4
sprite_21:  DS 4
sprite_22:  DS 4
sprite_23:  DS 4
sprite_24:  DS 4
sprite_25:  DS 4
sprite_26:  DS 4
sprite_27:  DS 4
sprite_28:  DS 4
sprite_29:  DS 4
sprite_30:  DS 4

; sprite_character: DS 4

; sprite_0_enemy_0: DS 4
; sprite_1_enemy_0: DS 4
; sprite_2_enemy_0: DS 4
; sprite_3_enemy_0: DS 4

; ;Level 1 sprites
; sprite1_lvl1_char: DS 4
; sprite2_lvl1_char: DS 4
; sprite_lvl1_shot:  DS 4