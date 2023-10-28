
// NEW NODES

/datum/techweb_node/adv_vision
	id = "adv_vision"
	display_name = "Combat Cybernetic Eyes"
	description = "Military grade combat implants to improve vision."
	prereq_ids = list("combat_cyber_implants", "alien_bio")
	design_ids = list(
		"ci-thermals",
		"ci-xray",
		"ci-thermals-moth",
		"ci-xray-moth",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 4000)

// MODULAR ADDITIONS AND REMOVALS

//Base Nodes
/datum/techweb_node/base/New()
	. = ..()
	design_ids += list(
		"polarizer",
		"vox_gas_filter",
	)

/datum/techweb_node/cyborg/New()
	. = ..()
	design_ids += list(
		"affection_module",
	)

/datum/techweb_node/basic_tools/New()
	. = ..()
	design_ids += list(
		"bowl",
		"drinking_glass",
		"shot_glass",
	)

/datum/techweb_node/basic_medical/New()
	. = ..()
	design_ids += list(
		"hospital_gown",
		"synth_eyes",
		"synth_tongue",
		"synth_liver",
		"synth_lungs",
		"synth_stomach",
		"synth_ears",
		"synth_heart",
	)

/////////////////////////Biotech/////////////////////////

/datum/techweb_node/adv_biotech/New()
	. = ..()
	design_ids += list(
		"monkey_helmet",
		"brute2medicell",
		"burn2medicell",
		"toxin2medicell",
		"oxy2medicell",
		"relocatemedicell",
		"tempmedicell",
		"bodymedicell",
		"clotmedicell",
	)

/datum/techweb_node/biotech/New()
	. = ..()
	design_ids += list(
		"anesthetic_machine",
		"smartdartgun",
	)

/////////////////////////EMP tech/////////////////////////

/datum/techweb_node/emp_basic/New()
	. = ..()
	design_ids += list(
		"gownmedicell",
		"bedmedicell",
	)

////////////////////////Computer tech////////////////////////

/datum/techweb_node/comptech/New()
	. = ..()
	design_ids += list(
		"time_clock_frame",
	)

/datum/techweb_node/integrated_hud/New()
	. = ..()
	design_ids += list(
		"health_hud_prescription",
		"security_hud_prescription",
		"diagnostic_hud_prescription",
		"science_hud_prescription",
		"health_hud_aviator",
		"security_hud_aviator",
		"diagnostic_hud_aviator",
		"meson_hud_aviator",
		"science_hud_aviator",
		"health_hud_projector",
		"security_hud_projector",
		"diagnostic_hud_projector",
		"meson_hud_projector",
		"science_hud_projector",
		"permit_glasses",
		"nifsoft_money_sense",
		"nifsoft_hud_kit",
		"nifsoft_hud_science",
		"nifsoft_hud_meson",
		"nifsoft_hud_medical",
		"nifsoft_hud_security",
		"nifsoft_hud_diagnostic",
		"nifsoft_hud_cargo",
	)

////////////////////////Medical////////////////////////

/datum/techweb_node/genetics/New()
	. = ..()
	design_ids += list(
		"self_actualization_device",
	)

/datum/techweb_node/cyber_organs/New()
	. = ..()
	design_ids += list(
		"cybernetic_tongue",
	)

// Modularly removes x-ray and thermals from here, it's in adv_vision instead
/datum/techweb_node/combat_cyber_implants/New()
	. = ..()
	design_ids -= list(
		"ci-thermals",
		"ci-xray",
		"ci-thermals-moth",
		"ci-xray-moth",
	)

////////////////////////Tools////////////////////////

/datum/techweb_node/botany/New()
	. = ..()
	design_ids += list(
		"salvemedicell",
	)

/datum/techweb_node/sec_basic/New()
	. = ..()
	design_ids += list(
		"nifsoft_remover",
	)

/////////////////////////weaponry tech/////////////////////////

/datum/techweb_node/weaponry/New()
	. = ..()
	design_ids += list(
		"ammoworkbench_disk_lethal",
	)

/datum/techweb_node/adv_weaponry/New()
	. = ..()
	design_ids += list(
		"ammo_workbench",
	)

/datum/techweb_node/electric_weapons/New()
	. = ..()
	design_ids += list(
		"medigun_speed",
	)

////////////////////////Alien technology////////////////////////

/datum/techweb_node/alien_bio/New()
	. = ..()
	design_ids += list(
		"brute3medicell",
		"burn3medicell",
		"oxy3medicell",
		"toxin3medicell",
	)

/////////////////////////engineering tech/////////////////////////

/datum/techweb_node/adv_engi/New()
	. = ..()
	design_ids += list(
		"engine_goggles_prescription",
		"mesons_prescription",
		"multi_cell_charger",
		"tray_goggles_prescription",
		"plumbing_eng",
	)

/////////////////////////robotics tech/////////////////////////

/datum/techweb_node/robotics/New()
	. = ..()
	design_ids += list(
		"borg_upgrade_snacks",
		"mini_soulcatcher",
	)

/datum/techweb_node/neural_programming/New()
	. = ..()
	design_ids += list(
		"soulcatcher_device",
		"rsd_interface",
	)

/datum/techweb_node/cyborg_upg_util/New()
	. = ..()
	design_ids += list(
		"borg_upgrade_clamp",
		"borg_upgrade_brush",
	)

/datum/techweb_node/cyborg_upg_engiminer/New()
	. = ..()
	design_ids += list(
		"advanced_materials",
		"inducer_module",
	)

/datum/techweb_node/cyborg_upg_med/New()
	. = ..()
	design_ids += list(
		"borg_upgrade_surgicaltools",
	)

	design_ids -= list(
		"borg_upgrade_pinpointer",
	)

/////////////////////////mod suits/////////////////////////
/datum/techweb_node/mod_rnd
	id = "mod_rnd"
	display_name = "MOD research and develop modular suits"
	description = "RND modules and suits, provadet by Laplas anomalistic corporation."
	prereq_ids = list("bluespace_travel", "mod_advanced", "adv_engi")
	design_ids = list(
		"rnd_mod_plating",
		"rnd_module_part_replacer",
		"rnd_module_eperiscaner",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 4500)
	discount_experiments = list(
		/datum/experiment/ordnance/gaseous/bz = 3000,
	)

/datum/techweb_node/advanced_mod_utility_modules
	id = "advanced_mod_utility_modules"
	display_name = "MOD advanced utility modules"
	description = "Advanced utility modules for MOD suits. Designed by Laplas anomalistic and nanotransen."
	prereq_ids = list("mod_advanced", "adv_engi")
	design_ids = list(
		"mod_toolarms_module",
		"mod_shock_protection_module",
		"mod_rpd_module",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 5000)

/datum/techweb_node/utility_effection_mod_module
	id = "effective_mod_utility_modules"
	display_name = "MOD part effective modules"
	description = "Utility modules, what can upgrade MOD part effective."
	prereq_ids = list("mod_advanced")
	design_ids = list(
		"mod_energy_eff_module",
		"mod_speed_eff_module",
		"mod_cc_eff_module",
		"mod_sprinter_module",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 5000)
	discount_experiments = list(
		/datum/experiment/ordnance/gaseous/bz = 4000,
	)
