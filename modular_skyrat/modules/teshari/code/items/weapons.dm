
// Avali spear(makeshift)

/obj/item/spear/aeroglass
	name = "Aeroglass spear"
	desc = "An incredibly sharp but fragile spear, with an aeroglass tip."
	icon = 'modular_skyrat/master_files/icons/obj/weapons/spear.dmi'
	icon_state = "aeroglass_spear"
	lefthand_file = 'modular_skyrat/master_files/icons/mob/inhands/melee_lefthand.dmi'
	righthand_file = 'modular_skyrat/master_files/icons/mob/inhands/melee_righthand.dmi'

	throwforce = 25
	custom_materials = list(/datum/material/aeroglass = SHEET_MATERIAL_AMOUNT * 1, /datum/material/iron = SHEET_MATERIAL_AMOUNT * 1)
	force_unwielded = 12
	bare_wound_bonus = 30
	armour_penetration = 50
	force_wielded = 20
	embedding = list("embed_chance" = 0)
	icon_prefix = "aeroglassspear"

	var/broke_chance = 0

/obj/item/spear/aeroglass/examine_more(mob/user)
	. = ..()
	if(isteshari(user))
		. += span_notice("Traditional hunters leap onto their prey from above and use gravity to drive the lance into them.")
	. += span_warning("The spear is incredibly fragile and can break, after any blow")
	return .

/obj/item/spear/aeroglass/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	if(!(ismob(target) || isobj(target)))
		return
	if(prob(broke_chance))
		playsound(src, 'sound/effects/footstep/glass_step.ogg')
		qdel(src)
		return
	broke_chance += 10

// Block bow and arrow

/obj/item/gun/ballistic/bow/aeroglass
	name = "Block bow"
	desc = "A lightweight block bow that has the ability to significantly strengthen the arrows it releases."
	icon = 'modular_skyrat/master_files/icons/obj/weapons/bow.dmi'
	lefthand_file = 'modular_skyrat/master_files/icons/mob/inhands/bow_lefthand.dmi'
	righthand_file = 'modular_skyrat/master_files/icons/mob/inhands/bow_righthand.dmi'
	icon_state = "block_bow"
	inhand_icon_state = "block_bow"
	base_icon_state = "block_bow"
	force = 10
	var/strong_tension = FALSE


	//Bonuses applied for strong tension
	var/tension_bonus = 25
	var/penetration_bonus = 20

/obj/item/gun/ballistic/bow/aeroglass/examine(mob/user)
	. = ..()
	. += span_notice("Use in hand to increas tension while chabered.")
	. += span_warning("Incressed tension will cause you to lose stamina!")
	return .


/obj/item/gun/ballistic/bow/aeroglass/proc/incress_tension()
	START_PROCESSING(SSprocessing, src)
	strong_tension = TRUE
	update_icon_state()

/obj/item/gun/ballistic/bow/aeroglass/proc/release_tenstion()
	STOP_PROCESSING(SSprocessing, src)
	strong_tension = FALSE
	update_icon_state()

/obj/item/gun/ballistic/bow/aeroglass/process(seconds_per_tick)
	. = ..()
	if(strong_tension && drawn) // To hold the strong tension of bowstring, you need to invite a lot of power.
		var/mob/living/carbon/human/user = src.loc
		if(!ishuman(user))
			return
		user.apply_damage((10 * seconds_per_tick), STAMINA)

/obj/item/gun/ballistic/bow/aeroglass/update_icon_state()
	..()
	if(strong_tension)
		icon_state = "[base_icon_state]_drawn_super"

/obj/item/gun/ballistic/bow/aeroglass/afterattack(atom/target, mob/living/user, flag, params, passthrough)
	if(drawn && strong_tension)
		release_tenstion()
	return ..()

/obj/item/gun/ballistic/bow/aeroglass/drop_arrow()
	if(strong_tension)
		release_tenstion()
	return ..()

/obj/item/gun/ballistic/bow/aeroglass/click_alt(mob/user)
	if(strong_tension)
		release_tenstion()
	return ..()

/obj/item/gun/ballistic/bow/aeroglass/attack_self(mob/user)
	if(drawn && !strong_tension)
		if(!istype(chambered, /obj/item/ammo_casing/arrow/aeroglass))
			balloon_alert(user, "Wrong arrow!")
			return ..()
		balloon_alert(user, "Increasing the tension!")
		if(!do_after(user, 3 SECONDS, user))
			balloon_alert(user, "Stand still!")
			return
		incress_tension()
		balloon_alert(user, "Tension increased!")
	else if(strong_tension)
		balloon_alert(user, "Realesing tension!")
		release_tenstion()
		return
	else
		return ..()

/obj/item/gun/ballistic/bow/aeroglass/shoot_live_shot(mob/living/user, pointblank, atom/pbtarget, message)
	if(strong_tension && !isnull(chambered) && drawn)
		var/obj/projectile/bullet/arrow/aeroglass/arrow_to_force = chambered.loaded_projectile
		arrow_to_force.damage += tension_bonus
		arrow_to_force.speed = 3
		arrow_to_force.armour_penetration += penetration_bonus
	return ..()


/obj/item/ammo_casing/arrow/aeroglass
	name = "Aeroglass arrow"
	desc = "Fragile but deadly."
	icon = 'modular_skyrat/master_files/icons/obj/weapons/bow.dmi'
	icon_state = "aeroglass_arrow"
	projectile_type = /obj/projectile/bullet/arrow
	reusable = FALSE

/obj/projectile/bullet/arrow/aeroglass
	icon = 'modular_skyrat/master_files/icons/obj/weapons/bow.dmi'
	icon_state = "aeroglass_arrow_projectile"
	damage = 25
	speed = 2
	range = 25
	armour_penetration = 20
	bare_wound_bonus = 25
	wound_bonus = 15
	shrapnel_type = null
	embedding = null

/obj/projectile/bullet/arrow/aeroglass/on_hit(atom/target, blocked, pierce_hit)
	. = ..()
	playsound(target, 'sound/effects/footstep/glass_step.ogg')
