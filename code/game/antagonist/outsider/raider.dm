var/datum/antagonist/raider/raiders

/datum/antagonist/raider
	id = MODE_RAIDER
	role_text = "Raider"
	role_text_plural = "Raiders"
	bantype = "raider"
	antag_indicator = "mutineer"
	landmark_id = "voxstart"
	welcome_text = "Use :H to talk on your encrypted channel."
	flags = ANTAG_OVERRIDE_JOB | ANTAG_CLEAR_EQUIPMENT | ANTAG_CHOOSE_NAME | ANTAG_VOTABLE | ANTAG_SET_APPEARANCE | ANTAG_HAS_LEADER | ANTAG_NO_FLAVORTEXT
	antaghud_indicator = "hudmutineer"
	required_age = 10

	hard_cap = 6
	hard_cap_round = 10
	initial_spawn_req = 4
	initial_spawn_target = 6

	faction = "syndicate"

	id_type = /obj/item/card/id/syndicate

	var/list/raider_guns = list(
		/obj/item/gun/energy/rifle/laser,
		/obj/item/gun/energy/rifle/laser/xray,
		/obj/item/gun/energy/rifle/icelance,
		/obj/item/gun/energy/retro,
		/obj/item/gun/energy/xray,
		/obj/item/gun/energy/mindflayer,
		/obj/item/gun/energy/toxgun,
		/obj/item/gun/energy/stunrevolver,
		/obj/item/gun/energy/rifle/ionrifle,
		/obj/item/gun/energy/taser,
		/obj/item/gun/energy/crossbow/largecrossbow,
		/obj/item/gun/launcher/crossbow,
		/obj/item/gun/launcher/grenade,
		/obj/item/gun/launcher/pneumatic,
		/obj/item/gun/launcher/harpoon,
		/obj/item/gun/projectile/automatic/mini_uzi,
		/obj/item/gun/projectile/automatic/c20r,
		/obj/item/gun/projectile/automatic/wt550,
		/obj/item/gun/projectile/automatic/rifle/sts35,
		/obj/item/gun/projectile/automatic/tommygun,
		/obj/item/gun/projectile/automatic/x9,
		/obj/item/gun/projectile/silenced,
		/obj/item/gun/projectile/shotgun/pump,
		/obj/item/gun/projectile/shotgun/pump/combat,
		/obj/item/gun/projectile/shotgun/doublebarrel,
		/obj/item/gun/projectile/shotgun/doublebarrel/pellet,
		/obj/item/gun/projectile/shotgun/doublebarrel/sawn,
		/obj/item/gun/projectile/shotgun/pump/rifle,
		/obj/item/gun/projectile/shotgun/foldable,
		/obj/item/gun/projectile/colt,
		/obj/item/gun/projectile/sec,
		/obj/item/gun/projectile/pistol,
		/obj/item/gun/projectile/deagle,
		/obj/item/gun/projectile/revolver,
		/obj/item/gun/projectile/revolver/deckard,
		/obj/item/gun/projectile/revolver/derringer,
		/obj/item/gun/projectile/revolver/lemat,
		/obj/item/gun/projectile/contender,
		/obj/item/gun/projectile/pirate,
		/obj/item/gun/projectile/tanto,
		/obj/item/gun/projectile/shotgun/pump/rifle/vintage
		)


	var/list/raider_holster = list(
		/obj/item/clothing/accessory/holster/armpit,
		/obj/item/clothing/accessory/holster/waist,
		/obj/item/clothing/accessory/holster/hip
		)

/datum/antagonist/raider/New()
	..()
	raiders = src

/datum/antagonist/raider/update_access(var/mob/living/player)
	for(var/obj/item/storage/wallet/W in player.contents)
		for(var/obj/item/card/id/id in W.contents)
			id.name = "[player.real_name]'s Passport"
			id.registered_name = player.real_name
			W.name = "[initial(W.name)] ([id.name])"

/datum/antagonist/raider/create_global_objectives()

	if(!..())
		return 0

	var/i = 1
	var/max_objectives = pick(2,2,2,2,3,3,3,4)
	global_objectives = list()
	while(i<= max_objectives)
		var/list/goals = list("kidnap","loot","salvage")
		var/goal = pick(goals)
		var/datum/objective/heist/O

		if(goal == "kidnap")
			goals -= "kidnap"
			O = new /datum/objective/heist/kidnap()
		else if(goal == "loot")
			O = new /datum/objective/heist/loot()
		else
			O = new /datum/objective/heist/salvage()
		O.choose_target()
		global_objectives |= O

		i++

	global_objectives |= new /datum/objective/heist/preserve_crew
	return 1

/datum/antagonist/raider/check_victory()
	// Totally overrides the base proc.
	var/win_type = "Major"
	var/win_group = "Crew"
	var/win_msg = ""

	//No objectives, go straight to the feedback.
	if(config.objectives_disabled || !global_objectives.len)
		return

	var/success = global_objectives.len
	//Decrease success for failed objectives.
	for(var/datum/objective/O in global_objectives)
		if(!(O.check_completion())) success--
	//Set result by objectives.
	if(success == global_objectives.len)
		win_type = "Major"
		win_group = "Raider"
	else if(success > 2)
		win_type = "Minor"
		win_group = "Raider"
	else
		win_type = "Minor"
		win_group = "Crew"
	//Now we modify that result by the state of the vox crew.
	if(antags_are_dead())
		win_type = "Major"
		win_group = "Crew"
		win_msg += "<B>The Raiders have been wiped out!</B>"
	else if(is_raider_crew_safe())
		if(win_group == "Crew" && win_type == "Minor")
			win_type = "Major"
		win_group = "Crew"
		win_msg += "<B>The Raiders have left someone behind!</B>"
	else
		if(win_group == "Raider")
			if(win_type == "Minor")
				win_type = "Major"
			win_msg += "<B>The Raiders escaped the station!</B>"
		else
			win_msg += "<B>The Raiders were repelled!</B>"

	to_world("<span class='danger'><font size = 3>[win_type] [win_group] victory!</font></span>")
	to_world("[win_msg]")
	feedback_set_details("round_end_result","heist - [win_type] [win_group]")

/datum/antagonist/raider/proc/is_raider_crew_safe()

	if(!current_antagonists || current_antagonists.len == 0)
		return 0

	for(var/datum/mind/player in current_antagonists)
		if(!player.current || get_area(player.current) != locate(/area/antag/raider))
			return 0
	return 1

/datum/antagonist/raider/equip(var/mob/living/carbon/human/player)

	if(!..())
		return 0

	for (var/obj/item/I in player)
		if (istype(I, /obj/item/implant))
			continue
		player.drop_from_inventory(I)
		if(I.loc != player)
			qdel(I)

	if(player.species && player.species.get_bodytype() == BODYTYPE_VOX)
		equip_vox(player)
	else
		player.preEquipOutfit(/datum/outfit/admin/syndicate/raider, FALSE)
		player.equipOutfit(/datum/outfit/admin/syndicate/raider, FALSE)
		player.force_update_limbs()
		player.update_eyes()
		player.regenerate_icons()

	give_codewords(player)

	return 1

/datum/antagonist/raider/proc/equip_vox(var/mob/living/carbon/human/player)

	player.equip_to_slot_or_del(new /obj/item/clothing/shoes/magboots/vox(player), slot_shoes) // REPLACE THESE WITH CODED VOX ALTERNATIVES.
	player.equip_to_slot_or_del(new /obj/item/clothing/gloves/yellow/vox(player), slot_gloves) // AS ABOVE.
	player.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/swat/vox(player), slot_wear_mask)
	player.equip_to_slot_or_del(new /obj/item/tank/nitrogen(player), slot_back)
	player.equip_to_slot_or_del(new /obj/item/device/flashlight(player), slot_r_store)
	player.equip_to_slot_or_del(new /obj/item/device/radio/headset/raider(player), slot_l_ear)
	player.equip_to_slot_or_del(new /obj/item/card/id/syndicate/raider(player), slot_wear_id)

	player.internal = locate(/obj/item/tank) in player.contents
	if(istype(player.internal,/obj/item/tank) && player.internals)
		player.internals.icon_state = "internal1"

	return 1

/datum/antagonist/raider/get_antag_radio()
	return "Raider"