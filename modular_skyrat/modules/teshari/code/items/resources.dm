// Aeroglass

/datum/material/aeroglass
	name = "aeroglass"
	desc = "Orangetheory, incredibly lightweight glass."
	color = "#cc732a"
	greyscale_colors = "#cc732a"
	alpha = 150
	categories = list(MAT_CATEGORY_ITEM_MATERIAL = TRUE, MAT_CATEGORY_RIGID = TRUE)
	integrity_modifier = 0.2
	sheet_type = /obj/item/stack/sheet/aeroglass
	shard_type = /obj/item/shard/aeroglass
	value_per_unit = 5 / SHEET_MATERIAL_AMOUNT
	minimum_value_override = 0
	beauty_modifier = 0.1
	armor_modifiers = list(MELEE = 0.1, BULLET = 0.1, ENERGY = 1, BIO = 0.1, FIRE = 1, ACID = 0.1)
	points_per_unit = 1 / SHEET_MATERIAL_AMOUNT
	texture_layer_icon_state = "sharp"

/obj/item/stack/sheet/aeroglass
	name = "aeroglass"
	desc = "Oranges, an incredibly light and fragile glass."
	icon = 'modular_skyrat/master_files/icons/obj/stack_objects.dmi'
	singular_name = "aeroglass sheet"
	icon_state = "sheet-aeroglass"
	inhand_icon_state = "sheet-aeroglass"
	mats_per_unit = list(/datum/material/aeroglass=SHEET_MATERIAL_AMOUNT)
	armor_type = /datum/armor/aeroglass
	resistance_flags = ACID_PROOF
	merge_type = /obj/item/stack/sheet/aeroglass
	grind_results = list(/datum/reagent/silicon = 5, /datum/reagent/carbon = 15)
	material_type = /datum/material/aeroglass
	matter_amount = 4
	cost = SHEET_MATERIAL_AMOUNT

/obj/item/stack/sheet/aeroglass/get_main_recipes()
	. = ..()
	. += new/datum/stack_recipe("Aeroglass shard", /obj/item/shard/aeroglass, time = 3 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ON_SOLID_GROUND, category = CAT_MISC)

/obj/item/stack/sheet/aeroglass/examine_more(mob/user)
	. = ..()
	if(isteshari(user))
		. += span_notice("Aerogel is an ephemeral lattice of molecules with incredible structural properties, despite weighing next to nothing.")
	return .
/datum/armor/aeroglass
	fire = 50
	acid = 100

/obj/item/shard/aeroglass
	name = "Organe shard"
	desc = "Incredibly light and sharp shard of aeroglass glass."
	force = 12
	throwforce = 15
	armour_penetration = 30
	bare_wound_bonus = 30
	icon = 'modular_skyrat/master_files/icons/obj/debris.dmi'
	lefthand_file = 'modular_skyrat/master_files/icons/mob/inhands/melee_lefthand.dmi'
	righthand_file = 'modular_skyrat/master_files/icons/mob/inhands/melee_righthand.dmi'
	icon_state = "aeroglasslarge"
	inhand_icon_state = "shard-aeroglass"
	custom_materials = list(/obj/item/stack/sheet/aeroglass=SHEET_MATERIAL_AMOUNT)
	icon_prefix = "aeroglass"
	weld_material = /obj/item/stack/sheet/aeroglass
	embedding = list("embed_chance" = 0)
	craft_time = 13 SECONDS

/obj/item/shard/aeroglass/afterattack(atom/A, mob/user, proximity)
	. = ..()
	if(ismob(A) || isobj(A))
		playsound(src, 'sound/effects/footstep/glass_step.ogg')
		qdel(src)

/obj/item/shard/aeroglass/examine_more(mob/user)
	. = ..()
	. += span_warning("The shard will shatter after the first blow!")
	return .
