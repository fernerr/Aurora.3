/obj/item/gun/energy/gun
	name = "energy carbine"
	desc = "A Nanotrasen designed energy-based carbine with two settings: Stun and kill."
	description_fluff = "The NT EC-4 is an energy carbine developed and produced by Nanotrasen.  Compact, light and durable, used by security forces and law enforcement for its ability to fire stun or lethal beams, depending on selection. It is widely sold and distributed across the galaxy."
	icon_state = "energystun100"
	item_state = null	// so the human update icon uses the icon_state instead.
	fire_sound = 'sound/weapons/Taser.ogg'
	slot_flags = SLOT_BELT
	accuracy = 1
	max_shots = 10
	can_turret = 1
	secondary_projectile_type = /obj/item/projectile/beam
	secondary_fire_sound = 'sound/weapons/Laser.ogg'
	can_switch_modes = 1
	turret_is_lethal = 0

	projectile_type = /obj/item/projectile/beam/stun
	origin_tech = list(TECH_COMBAT = 3, TECH_MAGNET = 2)
	modifystate = "energystun"

	firemodes = list(
		list(mode_name="stun", projectile_type=/obj/item/projectile/beam/stun, modifystate="energystun", fire_sound='sound/weapons/Taser.ogg'),
		list(mode_name="lethal", projectile_type=/obj/item/projectile/beam, modifystate="energykill", fire_sound='sound/weapons/Laser.ogg')
		)

	var/crit_fail = 0 //Added crit_fail as a local variable

/obj/item/gun/energy/gun/mounted
	name = "mounted energy gun"
	self_recharge = 1
	use_external_power = 1
	can_turret = 0

/obj/item/gun/energy/gun/nuclear
	name = "advanced energy gun"
	desc = "An energy gun with an experimental miniaturized reactor."
	icon_state = "nucgun"
	origin_tech = list(TECH_COMBAT = 3, TECH_MATERIAL = 5, TECH_POWER = 3)
	slot_flags = SLOT_BELT
	force = 8 //looks heavier than a pistol
	self_recharge = 1
	modifystate = null
	reliability = 95
	turret_sprite_set = "nuclear"
	charge_failure_message = "'s charging socket was removed to make room for a minaturized reactor."

	firemodes = list(
		list(mode_name="stun", projectile_type=/obj/item/projectile/beam/stun, fire_sound='sound/weapons/Taser.ogg'),
		list(mode_name="lethal", projectile_type=/obj/item/projectile/beam, fire_sound='sound/weapons/Laser.ogg')
		)

	var/lightfail = 0

/obj/item/gun/energy/gun/nuclear/get_cell()
	return DEVICE_NO_CELL

/obj/item/gun/energy/gun/nuclear/small_fail(var/mob/user)
	for (var/mob/living/M in range(0,src)) //Only a minor failure, enjoy your radiation if you're in the same tile or carrying it
		if (M == user)
			to_chat(M, "<span class='warning'>Your gun feels pleasantly warm for a moment.</span>")
		else
			to_chat(M, "<span class='warning'>You feel a warm sensation.</span>")
		M.apply_effect(rand(3,120), IRRADIATE)
	return

/obj/item/gun/energy/gun/nuclear/medium_fail(var/mob/user)
	if(prob(50))
		critical_fail(user)
	else
		small_fail(user)
	return

/obj/item/gun/energy/gun/nuclear/critical_fail(var/mob/user)
	to_chat(user, "<span class='danger'>Your gun's reactor overloads!</span>")
	for (var/mob/living/M in range(rand(1,4),src))
		to_chat(M, "<span class='warning'>You feel a wave of heat wash over you.</span>")
		M.apply_effect(300, IRRADIATE)
	crit_fail = 1 //break the gun so it stops recharging
	self_recharge = FALSE
	update_icon()
	return

/obj/item/gun/energy/gun/nuclear/proc/update_charge()
	if (crit_fail)
		add_overlay("nucgun-whee")
		return
	var/ratio = power_supply.charge / power_supply.maxcharge
	ratio = round(ratio, 0.25) * 100
	add_overlay("nucgun-[ratio]")

/obj/item/gun/energy/gun/nuclear/proc/update_reactor()
	if(crit_fail)
		add_overlay("nucgun-crit")
		return
	if(lightfail)
		add_overlay("nucgun-medium")
	else if ((power_supply.charge/power_supply.maxcharge) <= 0.5)
		add_overlay("nucgun-light")
	else
		add_overlay("nucgun-clean")

/obj/item/gun/energy/gun/nuclear/proc/update_mode()
	var/datum/firemode/current_mode = firemodes[sel_mode]
	switch(current_mode.name)
		if("stun")
			add_overlay("nucgun-stun")
		if("lethal")
			add_overlay("nucgun-kill")
/*
/obj/item/gun/energy/gun/nuclear/emp_act(severity)
	..()
	reliability -= round(15/severity)
*/
/obj/item/gun/energy/gun/nuclear/update_icon()
	cut_overlays()
	update_charge()
	update_reactor()
	update_mode()

/obj/item/gun/energy/pistol
	name = "energy pistol"
	desc = "A Nanotrasen energy-based pistol gun with two settings: Stun and kill."
	description_fluff = "The NT EP-3 is an energy sidearm developed and produced by Nanotrasen. Compact, light and durable, used by security forces and law enforcement for its ability to fire stun or lethal beams, depending on selection. It is widely sold and distributed across the galaxy."
	icon_state = "epistolstun100"
	item_state = null	//so the human update icon uses the icon_state instead.
	fire_sound = 'sound/weapons/Taser.ogg'
	slot_flags = SLOT_BELT|SLOT_HOLSTER
	max_shots = 7
	fire_delay = 4
	can_turret = 1
	secondary_projectile_type = /obj/item/projectile/beam/pistol
	secondary_fire_sound = 'sound/weapons/Laser.ogg'
	can_switch_modes = 1
	turret_sprite_set = "carbine"
	turret_is_lethal = 0

	projectile_type = /obj/item/projectile/beam/stun
	origin_tech = list(TECH_COMBAT = 3, TECH_MAGNET = 2)
	modifystate = "epistolstun"

	firemodes = list(
		list(mode_name="stun", projectile_type=/obj/item/projectile/beam/stun, modifystate="epistolstun", fire_sound='sound/weapons/Taser.ogg'),
		list(mode_name="lethal", projectile_type=/obj/item/projectile/beam/pistol, modifystate="epistolkill", fire_sound='sound/weapons/Laser.ogg')
		)

/obj/item/gun/energy/pistol/hegemony
	name = "hegemony energy pistol"
	desc = "An upgraded variant of the standard energy pistol with two settings: Incapacitate and Smite"
	icon_state = "hegemony_pistol"
	item_state = "hegemony_pistol"
	fire_sound = 'sound/weapons/Taser.ogg'
	slot_flags = SLOT_BELT|SLOT_HOLSTER
	max_shots = 10
	fire_delay = 3
	can_turret = FALSE
	secondary_projectile_type = /obj/item/projectile/beam/pistol/hegemony
	secondary_fire_sound = 'sound/weapons/Laser.ogg'
	can_switch_modes = TRUE
 
	projectile_type = /obj/item/projectile/beam/stun
	origin_tech = list(TECH_COMBAT = 4, TECH_MAGNET = 3)
	modifystate = "hegemony_pistol"
 
	firemodes = list(
		list(mode_name="incapacitate", projectile_type=/obj/item/projectile/beam/stun, modifystate="hegemony_pistol", fire_sound='sound/weapons/Taser.ogg'),
		list(mode_name="smite", projectile_type=/obj/item/projectile/beam/pistol/hegemony, modifystate="hegemony_pistol", fire_sound='sound/weapons/Laser.ogg')
		)

/obj/item/gun/energy/gun/skrell
	self_recharge = 1
	fire_sound = 'sound/weapons/Laser2.ogg'
	modifystate = null
	charge_failure_message = "'s charging socket was removed to make room for a recharger."
	secondary_fire_sound = 'sound/weapons/Laser3.ogg'

/obj/item/gun/energy/skrell/emp_act(severity)
	return //Fuck robots.

/obj/item/gun/energy/gun/skrell/pistol
	name = "jargon particle pistol"
	desc = "A Jargon Federation particle-beam pistol with two settings: Disable and Lethal."
	icon_state = "particlepistol"
	item_state = "particlepistol"
	slot_flags = SLOT_BELT|SLOT_HOLSTER
	force = 5
	projectile_type = /obj/item/projectile/beam/stun/skrell
	secondary_projectile_type = /obj/item/projectile/beam/pulse/skrell

	firemodes = list(
		list(mode_name="disable", projectile_type=/obj/item/projectile/beam/stun/skrell, fire_sound='sound/weapons/Laser2.ogg'),
		list(mode_name="lethal", projectile_type=/obj/item/projectile/beam/pulse/skrell, fire_sound='sound/weapons/Laser3.ogg')
		)

/obj/item/gun/energy/gun/skrell/smg
	name = "jargon particle submachinegun"
	desc = "A Jargon Federation particle-beam submachine gun with two settings: Disable and Lethal."
	icon_state = "particlesmg"
	item_state = "particlesmg"
	slot_flags = SLOT_BELT|SLOT_HOLSTER|SLOT_BACK
	max_shots = 14
	force = 7
	projectile_type = /obj/item/projectile/beam/stun/skrell
	secondary_projectile_type = /obj/item/projectile/beam/pulse/skrell

	firemodes = list(
		list(mode_name="disable", projectile_type=/obj/item/projectile/beam/stun/skrell, fire_sound='sound/weapons/Laser2.ogg'),
		list(mode_name="lethal", projectile_type=/obj/item/projectile/beam/pulse/skrell, fire_sound='sound/weapons/Laser3.ogg', burst = 2, burst_delay = 2)
		)

/obj/item/gun/energy/gun/skrell/special
	can_switch_modes = FALSE
	is_wieldable = TRUE
	firemodes = list()

/obj/item/gun/energy/gun/skrell/special/special_check(mob/user)
	if(!wielded)
		to_chat(user, "<span class='warning'>You can't fire without stabilizing \the [src]!</span>")
		return 0
	return ..()

/obj/item/gun/energy/gun/skrell/special/disruptor
	name = "jargon particle disruptor"
	desc = "A Jargon Federation... rifle? This looks heavy and complicated."
	icon_state = "disruptor"
	item_state = "disruptor"
	fire_sound = 'sound/weapons/resonator_blast.ogg'
	slot_flags = SLOT_HOLSTER|SLOT_BACK
	can_switch_modes = FALSE
	max_shots = 16
	force = 10 //Bulky stock.
	projectile_type = /obj/item/projectile/beam/pulse/skrell/disrupt

	fire_delay_wielded = 1
	accuracy_wielded = 2
	is_wieldable = TRUE

	firemodes = list()

/obj/item/gun/energy/gun/skrell/special/disintegrator
	name = "jargon disintegrator"
	desc = "A very bulky... cannon? This doesn't look safe to use at all."
	icon_state = "disintegrator"
	item_state = "disintegrator"
	slot_flags = SLOT_BACK
	max_shots = 2
	fire_delay = 30
	self_recharge = 0
	force = 12 //Do NOT get hit by this. Seriously.
	projectile_type = /obj/item/projectile/disintegrator
	secondary_projectile_type = /obj/item/projectile/ion/skrell
	is_wieldable = TRUE
	can_switch_modes = TRUE

	firemodes = list(
		list(mode_name = "mindstrike", projectile_type = /obj/item/projectile/disintegrator, fire_sound = 'sound/magic/LightningShock.ogg'),
		list(mode_name = "pulsar", projectile_type = /obj/item/projectile/ion/skrell, fire_sound = 'sound/effects/psi/power_feedback.ogg')
	)

/obj/item/gun/energy/gun/skrell/special/disintegrator/special_check(mob/user)
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(!H.psi)
			to_chat(H, "<span class='danger'>You press the trigger, and a sudden shock courses through you!</span>")
			playsound(src.loc, 'sound/weapons/psisword.ogg', 100, 1)
			H.adjustHalLoss(65)
			H.Weaken(10)
			H.stuttering = max(H.stuttering, 10)
			H.drop_item()
			return 0
		else
			if(!wielded)
				to_chat(user, "<span class='warning'>You can't fire without stabilizing \the [src]!</span>")
				return 0
			else
				return ..()

	