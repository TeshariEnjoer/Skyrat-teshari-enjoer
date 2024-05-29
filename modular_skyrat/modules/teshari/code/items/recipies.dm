/datum/chemical_reaction/aeroglass_polymers
	required_reagents = list(
	/datum/reagent/carbon = 5,
	/datum/reagent/silicon = 9,
	/datum/reagent/gold = 3,
	/datum/reagent/thermite = 3)
	required_temp = 800
	reaction_flags = REACTION_INSTANT
	reaction_tags = REACTION_TAG_MODERATE | REACTION_TAG_CHEMICAL

/datum/chemical_reaction/aeroglass_polymers/on_reaction(datum/reagents/holder, datum/equilibrium/reaction, created_volume)
	var/location = get_turf(holder.my_atom)
	for(var/i in 1 to created_volume)
		new /obj/item/stack/sheet/aeroglass(location)

/datum/crafting_recipe/block_bow
	name = "Aeroglass block bow"
	tool_behaviors = list(TOOL_WIRECUTTER, TOOL_MULTITOOL, TOOL_SCREWDRIVER, TOOL_CROWBAR)
	result = /obj/item/gun/ballistic/bow/aeroglass
	reqs = list(
		/obj/item/stack/sheet/aeroglass = 3,
		/obj/item/stack/medical/suture = 5,
		/obj/item/stock_parts/servo/nano = 2,
		/obj/item/pipe = 1,
	)
	time = 15 SECONDS
	category = CAT_WEAPON_RANGED

/datum/crafting_recipe/aeroglass_arrow
	name = "Aeroglass arrow"
	tool_behaviors = list(TOOL_WIRECUTTER, TOOL_SCREWDRIVER)
	result = /obj/item/ammo_casing/arrow/aeroglass
	reqs = list(
		/obj/item/shard/aeroglass = 1,
		/obj/item/pipe = 1
	)
	time = 2 SECONDS
	category = CAT_WEAPON_AMMO

/datum/crafting_recipe/aeroglass_spear
	name = "Aeroglass spear"
	tool_behaviors = list(TOOL_WIRECUTTER, TOOL_SCREWDRIVER, TOOL_CROWBAR, TOOL_WELDER)
	result = /obj/item/spear/aeroglass
	reqs = list(
		/obj/item/shard/aeroglass = 2,
		/obj/item/pipe = 3,
	)
	time = 5 SECONDS
	category = CAT_WEAPON_MELEE
