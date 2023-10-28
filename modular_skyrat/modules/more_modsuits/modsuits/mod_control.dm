/obj/item/mod/control/rnd
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/modsuits/mod_clothing.dmi'
	icon = 'modular_skyrat/master_files/icons/obj/clothing/modsuits/mod_clothing.dmi'
	icon_state = "rnd-control"
	theme = /datum/mod_theme/rnd

/obj/item/mod/control/pre_equipped/rnd
	icon_state = "rnd-control"
	theme = /datum/mod_theme/rnd
	starting_frequency = MODLINK_FREQ_NANOTRASEN
	applied_cell = /obj/item/stock_parts/cell/hyper
	applied_modules = list(
		/obj/item/mod/module/dna_lock,
		/obj/item/mod/module/emp_shield,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/storage/bluespace,
		/obj/item/mod/module/tether,
	)
