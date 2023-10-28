/**
 * Shock protection
 */

/obj/item/mod/module/shock_protect
	name = "MOD shock protect module"
	desc = "A MOD module installed in users chest and arms, gift a shock resistant to suit parts,\
	but make this weak for EMP brusts."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/modsuits/mod_modules.dmi'
	icon_state = "module_shock_protect"
	complexity = 3
	idle_power_cost = DEFAULT_CHARGE_DRAIN * 0.5
	incompatible_modules = list(
		/obj/item/mod/module/shock_protect,
		/obj/item/mod/module/armor_booster,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/projectile_dampener,
		/obj/item/mod/module/rad_protection,
		/obj/item/mod/module/emp_shield,
		/obj/item/mod/module/stealth,
	)

/obj/item/mod/module/shock_protect/on_suit_activation()
	. = ..()
	for(var/obj/item/part as anything in mod.mod_parts)
		part.siemens_coefficient = 0


/obj/item/mod/module/shock_protect/on_suit_deactivation(deleting)
	. = ..()
	for(var/obj/item/part as anything in mod.mod_parts)
		part.siemens_coefficient = initial(part.siemens_coefficient)

/obj/item/mod/module/shock_protect/emp_act(severity)
	. = ..()
	if(!mod.wearer)
		return
	mod.wearer.electrocute_act(20, src, 1)

/**
 * Mechanical arms
 */

/obj/item/mod/module/tool_arms
	name = "MOD tools arms module"
	desc = "A module installed to users spine. That gift\
			Thwo mechanical robotics arm with kit of basic tools."
	module_type = MODULE_ACTIVE
	complexity = 2
	device = /obj/item/mod_omnitool
	icon = 'modular_skyrat/master_files/icons/obj/clothing/modsuits/mod_modules.dmi'
	overlay_icon_file = 'modular_skyrat/master_files/icons/mob/clothing/modsuits/mod_modules.dmi'
	overlay_state_inactive = "toolarm_module"
	icon_state = "module_toolarm"
	incompatible_modules = list(/obj/item/mod/module/tool_arms)

/obj/item/mod/module/tool_arms/Initialize(mapload)
	. = ..()
	var/obj/item/mod_omnitool/tool = device
	tool.mod_module = src

/**
 * MOD RPD
 */

/obj/item/mod/module/rpd
	name = "MOD rpd module"
	desc = "A MOD module installed in users arm, gift a portable version of RPD device."
	module_type = MODULE_ACTIVE
	complexity = 2
	device = /obj/item/pipe_dispenser/mod
	icon = 'modular_skyrat/master_files/icons/obj/clothing/modsuits/mod_modules.dmi'
	icon_state = "module_pipe_dispanser"
	incompatible_modules = list(/obj/item/mod/module/rpd)
