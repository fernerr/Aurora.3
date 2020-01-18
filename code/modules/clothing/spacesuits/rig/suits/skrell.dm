/obj/item/clothing/head/helmet/space/rig/skrell
	light_overlay = "helmet_light_jargon_rig"

/obj/item/rig/skrell
	name = "jargon suit control module"
	desc = "A suit control module designed by the Jargon Federation for JFSF operations. It is designed to be sleek and agile, equipped with best protection and technology the Federation has to offer for its elite."
	suit_type = "jargon suit"
	icon_state = "jargon_rig"
	armor = list(melee = 60, bullet = 40, laser = 70, energy = 30, bomb = 30, bio = 100, rad = 100)
	siemens_coefficient = 0.1
	emp_protection = 30
	vision_restriction = 0
	slowdown = 0
	offline_slowdown = 3
	vision_restriction = TINT_NONE
	icon = 'icons/obj/clothing/species/skrell/rigs.dmi'
	icon_state = "jargon_rig"
	species_restricted = list("Skrell")

	helm_type = /obj/item/clothing/head/helmet/space/rig/skrell
	allowed = list(/obj/item/gun,/obj/item/device/flashlight,/obj/item/tank,/obj/item/device/suit_cooling_unit,/obj/item/melee/baton,/obj/item/melee/energy)

	initial_modules = list(
		/obj/item/rig_module/ai_container,
		/obj/item/rig_module/maneuvering_jets,
		/obj/item/rig_module/grenade_launcher,
		/obj/item/rig_module/vision/multi,
		/obj/item/rig_module/mounted/pulse,
		/obj/item/rig_module/chem_dispenser/combat,
		/obj/item/rig_module/chem_dispenser/injector,
		/obj/item/rig_module/device/drill,
		/obj/item/rig_module/device/rfd_c,
		/obj/item/rig_module/datajack,
		/obj/item/rig_module/actuators/combat
		)

	allowed_module_types = MODULE_GENERAL | MODULE_LIGHT_COMBAT | MODULE_HEAVY_COMBAT | MODULE_SPECIAL

/obj/item/clothing/head/helmet/space/rig/skrell/tup
	light_overlay = "helmet_light_tadpole"

/obj/item/rig/skrell/tup
	desc = "A suit control module designed by the Jargon Federation for Tup operations. The best of the best."
	suit_type = "tup suit"
	icon_state = "tup_rig"
	armor = list(melee = 85, bullet = 85, laser = 90, energy = 85, bomb = 90, bio = 100, rad = 100)
	siemens_coefficient = 0.1
	emp_protection = 95
	vision_restriction = 0
	icon_state = "tup_rig"

	helm_type = /obj/item/clothing/head/helmet/space/rig/skrell/tup
	allowed = list(/obj/item/gun,/obj/item/device/flashlight,/obj/item/tank,/obj/item/device/suit_cooling_unit,/obj/item/melee/baton,/obj/item/melee/energy)

	initial_modules = list(
		/obj/item/rig_module/ai_container,
		/obj/item/rig_module/maneuvering_jets,
		/obj/item/rig_module/grenade_launcher,
		/obj/item/rig_module/vision/multi,
		/obj/item/rig_module/mounted/pulse,
		/obj/item/rig_module/chem_dispenser/combat,
		/obj/item/rig_module/chem_dispenser/injector,
		/obj/item/rig_module/device/drill,
		/obj/item/rig_module/device/rfd_c,
		/obj/item/rig_module/datajack,
		/obj/item/rig_module/actuators/combat,
		/obj/item/rig_module/teleporter/skrell,
		/obj/item/rig_module/electrowarfare_suite
		)

	allowed_module_types = MODULE_GENERAL | MODULE_LIGHT_COMBAT | MODULE_HEAVY_COMBAT | MODULE_SPECIAL