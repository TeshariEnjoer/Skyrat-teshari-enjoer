/obj/item/storage/part_replacer/bluespace/mod
	name = "MOD bluespace rapid part exchange device"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/modsuits/mod_modules.dmi'
	icon_state = "module_part_replacer"
	custom_materials = null
	force = 0
	pshoom_or_beepboopblorpzingshadashwoosh = 'modular_skyrat/master_files/sound/mod/energy_emit.ogg'
	alt_sound = 'modular_skyrat/master_files/sound/mod/energy_emit.ogg'

/obj/item/pipe_dispenser/mod
	name = "MOD pipe dispenser"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/modsuits/mod_modules.dmi'
	icon_state = "module_pipe_dispanser"
	custom_materials = null
	force = 0

/obj/item/experi_scanner/mod
	name = "MOD Experi-Scanner"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/modsuits/mod_modules.dmi'
	icon_state = "module_research_scaner"

/**
 * MOD spear
 */

/obj/item/energy_spear
	name = "\improper MOD energy spear"
	desc = "A spear made of pure energy, incredibly light to the touch."
	icon = 'modular_skyrat/master_files/icons/obj/mod.dmi'
	icon_state = "energy_spear"
	force = 0
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = null
	throwforce = 20
	// Very fast
	throw_speed = 10
	demolition_mod = 2
	// Just for safe
	embedding = list("impact_pain_mult" = 0, "remove_pain_mult" = 0, "jostle_chance" = 0)
	armour_penetration = 50
	custom_materials = null
	wound_bonus = -50
	bare_wound_bonus = 30

	inhand_icon_state = "energy_spear"
	lefthand_file = 'modular_skyrat/master_files/icons/mob/inhands/mod/melee_lefthand.dmi'
	righthand_file = 'modular_skyrat/master_files/icons/mob/inhands/mod/melee_righthand.dmi'
	mob_throw_hit_sound = 'modular_skyrat/master_files/sound/mod/energy_spear_throw.ogg'

/**
 * MOD blade
 */

/obj/item/melee/mod_blade
	name = "\improper MOD blade"
	desc = "A sharp, stylish and massive MOD blade built into the hand."
	icon = 'modular_skyrat/master_files/icons/obj/mod.dmi'
	icon_state = "mod_blade"
	force = 15
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = null
	throwforce = 0
	throw_speed =0
	demolition_mod = 2
	embedding = list("impact_pain_mult" = 0, "remove_pain_mult" = 0, "jostle_chance" = 0)
	armour_penetration = 50
	custom_materials = null
	wound_bonus = -10
	bare_wound_bonus = 30

	inhand_icon_state = "mod_blade"
	lefthand_file = 'modular_skyrat/master_files/icons/mob/inhands/mod/melee_lefthand.dmi'
	righthand_file = 'modular_skyrat/master_files/icons/mob/inhands/mod/melee_righthand.dmi'
	// Damage for alt right click attack
	var/alt_attack_force = 10
	var/alt_attack_cooldown = 5 SECONDS
	COOLDOWN_DECLARE(cooldown_aoe)
	var/alt_attack_power_cost = 50
	// Mod for power drain
	var/obj/item/mod/control/mod

/obj/item/melee/mod_blade/Initialize(mapload, obj/item/mod/control/connected_mod)
	. = ..()
	mod = connected_mod

/obj/item/melee/mod_blade/Destroy(force)
	. = ..()
	mod = null

/obj/item/melee/mod_blade/examine(mob/user)
	. = ..()
	. += span_notice("Right click for AOE attack.")

/obj/item/melee/mod_blade/pre_attack_secondary(atom/target, mob/living/user, params)
	. = ..()
	if(!COOLDOWN_FINISHED(src, cooldown_aoe))
		user.balloon_alert(user, "On cooldown!")
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	if(!mod.subtract_charge(alt_attack_power_cost))
		user.balloon_alert(user, "No power!")
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	COOLDOWN_START(src, cooldown_aoe, alt_attack_cooldown)
	var/turf/user_turf = get_turf(user)
	var/dir_to_target = get_dir(user_turf, get_turf(target))
	var/static/list/attack_angles = list(0, -45, 45)
	for(var/i in attack_angles)
		var/turf/turf = get_step(user_turf, turn(dir_to_target, i))
		for(var/mob/living/living_target in turf)
			if(user.Adjacent(living_target) && living_target.body_position != LYING_DOWN)
				if(living_target == user)
					user.balloon_alert(user, "Hurting self!")
					break
				living_target.apply_damage(alt_attack_force, BRUTE, attacking_item = src)
	user.do_attack_animation(target, "slash", src, TRUE)
	playsound(get_turf(user), 'modular_skyrat/master_files/sound/mod/attack_slice.ogg', 40)
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/item/melee/mod_blade/syndicate
	name = "\improper MOD armblade"
	desc = "A sharp, stylish and massive MOD blade built into the hand. This blade is especially strong, \
			colored blood red, and can cut through flesh like butter."
	icon_state = "mod_armblade"
	inhand_icon_state = "mod_armblade"
	force = 30
	wound_bonus = 30
	bare_wound_bonus = 30
	alt_attack_force = 20
	alt_attack_power_cost = 100

/**
 * MOD omnitool
 */
/obj/item/mod_omnitool
	name = "\improper MOD arms control"
	icon = 'modular_skyrat/master_files/icons/obj/mod.dmi'
	icon_state = "mod_omnitool"
	force = 15
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = null
	throwforce = 0
	throw_speed = 0
	demolition_mod = 0
	custom_materials = null
	tool_behaviour = TOOL_SCREWDRIVER
	toolspeed = 0.2
	usesound = 'modular_skyrat/master_files/sound/mod/energy_emit.ogg'
	//Mod module we in.
	var/obj/item/mod/module/mod_module
	var/power_drain_per_operation = 5

/obj/item/mod_omnitool/examine(mob/user)
	. = ..()
	. += span_notice("Attack self for choise active tool.")
	. += span_green("Current tool is: [tool_behaviour]")

/obj/item/mod_omnitool/tool_use_check(mob/living/user, amount)
	if(!mod_module?.mod?.subtract_charge(power_drain_per_operation))
		return FALSE
	return ..()

/obj/item/mod_omnitool/attack_self(mob/user, modifiers)
	. = ..()
	if(!mod_module)
		return
	var/choise = show_radial_menu(user, user, get_tool_opinions())
	if(!choise)
		return
	tool_behaviour = choise
	if(tool_behaviour == TOOL_WELDER)
		damtype = BURN
	else
		damtype = BRUTE
	playsound(get_turf(user), 'modular_skyrat/master_files/sound/mod/energy_emit.ogg', 40)

/obj/item/mod_omnitool/proc/get_tool_opinions()
	var/list/opinions = list(
		TOOL_SCREWDRIVER = image(icon = 'icons/obj/items_cyborg.dmi', icon_state = "screwdriver_cyborg"),
		TOOL_WIRECUTTER = image(icon = 'icons/obj/items_cyborg.dmi', icon_state = "wirecutters_cyborg"),
		TOOL_WRENCH = image(icon = 'icons/obj/items_cyborg.dmi', icon_state = "wrench_cyborg"),
		TOOL_CROWBAR = image(icon = 'icons/obj/items_cyborg.dmi', icon_state = "crowbar_cyborg"),
		TOOL_WELDER = image(icon = 'icons/obj/items_cyborg.dmi', icon_state = "indwelder_cyborg"),
		TOOL_MULTITOOL = image(icon = 'icons/obj/items_cyborg.dmi', icon_state = "multitool_cyborg"),
	)
	return opinions


