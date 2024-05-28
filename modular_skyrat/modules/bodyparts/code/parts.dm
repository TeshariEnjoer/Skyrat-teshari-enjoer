/obj/item/bodypart
	/// Should we use a custom body damage overlays beside original one.
	var/custom_damage_overlays
/obj/item/bodypart/chest
	/// The offset datum for our accessory overlay.
	var/datum/worn_feature_offset/worn_accessory_offset

/obj/item/bodypart/chest/Destroy(force)
	QDEL_NULL(worn_accessory_offset)
	return ..()
