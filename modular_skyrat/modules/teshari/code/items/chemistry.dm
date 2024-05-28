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
