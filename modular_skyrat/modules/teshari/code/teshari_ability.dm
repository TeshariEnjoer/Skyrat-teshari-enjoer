#define AGILITY_DEFAULT_COOLDOWN_TIME 2 SECONDS

/datum/action/cooldown/spell/tehsari_agility
	name = "Toggle agility"
	desc = "Toggle you agility"
	button_icon = 'modular_skyrat/master_files/icons/hud/actions.dmi'
	button_icon_state = "agility_off"
	overlay_icon_state = "bg_alien_border"
	cooldown_time = AGILITY_DEFAULT_COOLDOWN_TIME
	spell_requirements = NONE
	var/enabled = FALSE

/datum/action/cooldown/spell/tehsari_agility/cast(atom/cast_on)
	. = ..()

	if(enabled)
		update_button_state("agility_off")
		owner.balloon_alert(owner, "Ignoring!")
		passtable_off(owner, INNATE_TRAIT)
		enabled = FALSE
	else
		update_button_state("agility_on")
		owner.balloon_alert(owner, "Moving above!")
		passtable_on(owner, INNATE_TRAIT)
		enabled = TRUE
	return TRUE

/datum/action/cooldown/spell/tehsari_agility/proc/update_button_state(new_state)
	button_icon_state = new_state
	owner.update_action_buttons()

#undef AGILITY_DEFAULT_COOLDOWN_TIME
