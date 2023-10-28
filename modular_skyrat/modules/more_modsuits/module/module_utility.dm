#define MODULE_RIG_DEFAULT_NAME "rig_module_"

/**
 * energy eff
 */

/obj/item/mod/module/energy_effective
	name = "MOD gnergy effective module"
	desc = "A MOD module installed in MOD control, make them more power effective, but general movement slower"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/modsuits/mod_modules.dmi'
	icon_state = "module_power_effective"
	complexity = 2
	idle_power_cost = 0
	incompatible_modules = list(
		/obj/item/mod/module/energy_effective,
		/obj/item/mod/module/movemenet_effective,
	)
	var/added_modifaer

/obj/item/mod/module/energy_effective/on_suit_activation()
	. = ..()
	mod.charge_drain = (mod.charge_drain * 0.5)
	added_modifaer = mod.slowdown_active * 2
	mod.slowdown += added_modifaer
	mod.wearer.update_equipment_speed_mods()


/obj/item/mod/module/energy_effective/on_suit_deactivation(deleting)
	. = ..()
	mod.charge_drain = initial(mod.charge_drain)
	mod.slowdown -= added_modifaer
	mod.wearer.update_equipment_speed_mods()

/**
 * movement eff
 */

/obj/item/mod/module/movemenet_effective
	name = "MOD movement effective module"
	desc = "MOD module installed in MOD control, adjust movement speed by causing faster power drain."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/modsuits/mod_modules.dmi'
	icon_state = "module_movement_effective"
	complexity = 3
	idle_power_cost = DEFAULT_CHARGE_DRAIN
	incompatible_modules = list(
		/obj/item/mod/module/movemenet_effective,
		/obj/item/mod/module/energy_effective,
	)
	var/added_modifaer

/obj/item/mod/module/movemenet_effective/on_suit_activation()
	. = ..()
	added_modifaer = max(0.5, mod.slowdown_active * 0.5)
	mod.slowdown -= added_modifaer
	mod.wearer.update_equipment_speed_mods()
	mod.charge_drain = (mod.charge_drain * 2)

/obj/item/mod/module/movemenet_effective/on_suit_deactivation(deleting)
	. = ..()
	mod.slowdown += added_modifaer
	mod.wearer.update_equipment_speed_mods()
	mod.charge_drain = initial(mod.charge_drain)
/**
 * cop eff
 */

/obj/item/mod/module/complexity_effective
	name = "MOD complexity effective module"
	desc = "MOD module installed in MOD control, adjust number of maximum installed modules, bu causing impossible install storage modules."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/modsuits/mod_modules.dmi'
	icon_state = "module_complexity_effective"
	complexity = 0
	incompatible_modules = list(
		/obj/item/mod/module/plate_compression,
		/obj/item/mod/module/storage,
		/obj/item/mod/module/complexity_effective,
	)

/obj/item/mod/module/complexity_effective/on_install()
	. = ..()
	mod.complexity += 10

/obj/item/mod/module/complexity_effective/on_uninstall(deleting)
	. = ..()
	mod.complexity = initial(mod.complexity)

/**
 * Sprinter
 */

/obj/item/mod/module/sprinter
	name = "MOD sprinter module"
	desc = "MOD module installed in wearer legs. Allow to adjust movemenet speed causing hight power use."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/modsuits/mod_modules.dmi'
	overlay_icon_file = 'modular_skyrat/master_files/icons/mob/clothing/modsuits/mod_modules.dmi'
	module_type = MODULE_TOGGLE
	icon_state = "module_sprinter"
	overlay_state_active = "sprinter_module"
	overlay_state_inactive = "sprinter_module"
	complexity = 2
	incompatible_modules = list(
		/obj/item/mod/module/sprinter,
		/obj/item/mod/module/movemenet_effective,
	)
	var/added_speed = 1
	var/power_use_per_step = 50

/obj/item/mod/module/sprinter/on_activation()
	. = ..()
	mod.wearer.balloon_alert(mod.wearer, "Actutor overstressed!")
	RegisterSignal(mod.wearer, COMSIG_MOVABLE_MOVED, PROC_REF(on_wearer_move))
	mod.slowdown -= added_speed
	mod.wearer.update_equipment_speed_mods()

/obj/item/mod/module/sprinter/on_deactivation(display_message, deleting)
	. = ..()
	mod.wearer.balloon_alert(mod.wearer, "Actutor stabilized!")
	UnregisterSignal(mod.wearer, COMSIG_MOVABLE_MOVED)
	mod.slowdown += added_speed
	mod.wearer.update_equipment_speed_mods()

/obj/item/mod/module/sprinter/proc/on_wearer_move()
	SIGNAL_HANDLER
	mod.subtract_charge(power_use_per_step)

/**
 * RIG
 */

/obj/item/mod/module/rig_module
	name = "MOD RIG module"
	desc = "A module installed to users spine. That analyse information about user health."
	removable = FALSE
	complexity = 0
	idle_power_cost = 0
	module_type = MODULE_PASSIVE

	overlay_icon_file = 'modular_skyrat/master_files/icons/mob/clothing/modsuits/mod_modules.dmi'
	overlay_state_inactive = "rig_module_dead"

	var/overlay_rig_icon

/obj/item/mod/module/rig_module/on_suit_activation()
	. = ..()
	if(!mod.wearer)
		return
	RegisterSignal(mod.wearer, COMSIG_LIVING_DEATH, PROC_REF(wearer_dead))

/obj/item/mod/module/rig_module/on_suit_deactivation(deleting)
	. = ..()
	UnregisterSignal(mod.wearer, COMSIG_LIVING_DEATH)

/obj/item/mod/module/rig_module/generate_worn_overlay(mutable_appearance/standing)
	. = ..()
	if(!mod.active)
		return

	var/mutable_appearance/rig_icon = mutable_appearance(overlay_icon_file, overlay_rig_icon, layer = standing.layer + 0.1)
	rig_icon.appearance_flags |= RESET_COLOR
	. += rig_icon

/obj/item/mod/module/rig_module/on_use()
	. = ..()
	calculate_health()

/obj/item/mod/module/rig_module/on_process(seconds_per_tick)
	. = ..()
	on_use()

/obj/item/mod/module/rig_module/proc/wearer_dead()
	SIGNAL_HANDLER
	playsound(get_turf(mod.wearer), 'modular_skyrat/master_files/sound/mod/rig_module_dead.ogg', 40)

/obj/item/mod/module/rig_module/proc/calculate_health()
	if(!mod.wearer)
		return

	var/target_state = MODULE_RIG_DEFAULT_NAME
	switch(mod.wearer?.health || 0)
		if(91 to INFINITY)
			target_state += "normal"
		if(40 to 90)
			target_state += "damaged"
		if(-200 to 39)
			target_state += "critical"

	if(mod.wearer.stat & DEAD)
		target_state = MODULE_RIG_DEFAULT_NAME + "dead"

	overlay_rig_icon = target_state

/datum/mod_theme
	inbuilt_modules = list(/obj/item/mod/module/rig_module)
/datum/mod_theme/advanced
	inbuilt_modules = list(/obj/item/mod/module/rig_module, /obj/item/mod/module/magboot/advanced)
/datum/mod_theme/rescue
	inbuilt_modules = list(/obj/item/mod/module/rig_module, /obj/item/mod/module/quick_carry/advanced)

#undef MODULE_RIG_DEFAULT_NAME

