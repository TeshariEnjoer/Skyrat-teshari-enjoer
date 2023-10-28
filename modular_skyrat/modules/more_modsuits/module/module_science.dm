/obj/item/mod/module/core_rnd
	name = "MOD core research module"
	desc = "The primary electronic systems operating within the suit. Utilizing outgoing signals, \
		and analyse users stats."
	icon_state = "infiltrator"
	complexity = 0
	removable = FALSE
	idle_power_cost = DEFAULT_CHARGE_DRAIN * 0
	incompatible_modules = list(
		/obj/item/mod/module/armor_booster,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/holster,
		/obj/item/mod/module/projectile_dampener,
		/obj/item/mod/module/active_sonar,
		/obj/item/mod/module/shooting_assistant,
	)

/obj/item/mod/module/core_rnd/on_suit_activation()
	. = ..()
	ADD_TRAIT(mod.wearer, TRAIT_REAGENT_SCANNER, REF(src))

/obj/item/mod/module/core_rnd/on_suit_deactivation(deleting)
	. = ..()
	REMOVE_TRAIT(mod.wearer, TRAIT_REAGENT_SCANNER, REF(src))

/**
 * BRPED
 */

/obj/item/mod/module/part_replacer
	name = "MOD part replacer module"
	desc = "A MOD module installed in users arm, gift a portable version of bluespace part replacer device."
	complexity = 1
	icon_state = "module_part_replacer"
	device = /obj/item/storage/part_replacer/bluespace/mod
	incompatible_modules = list(/obj/item/mod/module/part_replacer)

/**
 * Experiscaner
 */

/obj/item/mod/module/experiscanner
	name = "MOD research scaner module"
	desc = "A MOD module installed in users arm, gift a portable version of research scaner."
	complexity = 1
	icon_state = "module_research_scaner"
	device = /obj/item/experi_scanner/mod
	incompatible_modules = list(/obj/item/mod/module/experiscanner)
