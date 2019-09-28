
//--Walls--//

/turf/simulated/wall/shuttle
	icon = 'icons/turf/smooth/shuttle_wall.dmi'
	icon_state = "map-shuttle"
	roof_flags = ROOF_CLEANUP
	smooth = SMOOTH_MORE|SMOOTH_DIAGONAL
	use_standard_smoothing = 1
	canSmoothWith = list(
		/turf/simulated/wall/shuttle,
		/obj/structure/window/shuttle,
		/obj/machinery/door/airlock,
		/obj/machinery/door/unpowered/shuttle,
		/obj/structure/shuttle/engine/propulsion
	)
/turf/simulated/wall/shuttle/Initialize(mapload)
	. = ..(mapload,"shuttle")

/turf/simulated/wall/shuttle/attackby(obj/item/weapon/W as obj, mob/user as mob)
	user.setClickCooldown(DEFAULT_ATTACK_COOLDOWN)
	if (!user.)
		to_chat(user, "<span class='warning'>You don't have the dexterity to do this!</span>")
		return

	if(!istype(user.loc, /turf))
		return

	if(locate(/obj/effect/overlay/wallrot) in src)
		if(W.iswelder() )
			var/obj/item/weapon/weldingtool/WT = W
			if( WT.remove_fuel(0,user) )
				to_chat(user, "<span class='notice'>You burn away the fungi with \the [WT].</span>")
				playsound(src, 'sound/items/Welder.ogg', 10, 1)
				for(var/obj/effect/overlay/wallrot/WR in src)
					qdel(WR)
				return
		else if(!is_sharp(W) && W.force >= 10 || W.force >= 20)
			to_chat(user, "<span class='notice'>\The [src] crumbles away under the force of your [W.name].</span>")
			src.dismantle_wall(1)
			return

	if(thermite)
		if(W.iswelder() )
			var/obj/item/weapon/weldingtool/WT = W
			if( WT.remove_fuel(0,user) )
				thermitemelt(user)
				return

		else if(istype(W, /obj/item/weapon/gun/energy/plasmacutter))
			thermitemelt(user)
			return

		else if( istype(W, /obj/item/weapon/melee/energy/blade) )
			var/obj/item/weapon/melee/energy/blade/EB = W

			spark(EB, 5)
			to_chat(user, "<span class='notice'>You slash \the [src] with \the [EB]; the thermite ignites!</span>")
			playsound(src, "sparks", 50, 1)
			playsound(src, 'sound/weapons/blade.ogg', 50, 1)

			thermitemelt(user)
			return

	if(!istype(W, /obj/item/weapon/reagent_containers))
		return attack_hand(user)

/turf/simulated/wall/shuttle/dark
	icon = 'icons/turf/smooth/shuttle_wall_dark.dmi'
	canSmoothWith = null

/turf/simulated/wall/shuttle/dark/cardinal
	icon = 'icons/turf/smooth/shuttle_wall_dark.dmi'
	smooth = SMOOTH_TRUE
	canSmoothWith = null

/turf/simulated/wall/shuttle/dark/corner
	icon = 'icons/turf/shuttle.dmi'
	icon_state = "wall3"
	use_set_icon_state = 1
	smooth = null
	canSmoothWith = null

/turf/simulated/wall/shuttle/legion
	icon = 'icons/turf/smooth/shuttle_wall_legion.dmi'


//--Floors--//

/decl/flooring/shuttle
	name = "shuttle floor"
	desc = "Typical shuttle flooring."
	icon = 'icons/turf/shuttle.dmi'
	icon_base = "floor"
	flags = TURF_ACID_IMMUNE
	apply_thermal_conductivity = 0.025
	apply_heat_capacity = 325000
	can_paint = 1

/decl/flooring/shuttle/yellow
	icon_base = "floor2"

/turf/simulated/floor/shuttle
	name = "shuttle floor"
	icon = 'icons/turf/shuttle.dmi'
	icon_state = "floor"
	initial_flooring = /decl/flooring/shuttle
	footstep_sound = "concretestep"

/turf/simulated/floor/shuttle/yellow
	icon_state = "floor2"
	initial_flooring = /decl/flooring/shuttle/yellow

/turf/simulated/floor/shuttle/white
	icon_state = "floor3"
	initial_flooring = /decl/flooring/shuttle/white

/turf/simulated/floor/shuttle/red
	icon_state = "floor4"
	initial_flooring = /decl/flooring/shuttle/red

/turf/simulated/floor/shuttle/dark_red
	icon_state = "floor6"
	initial_flooring = /decl/flooring/shuttle/dark_red

/turf/simulated/floor/shuttle/black
	icon_state = "floor7"
	initial_flooring = /decl/flooring/shuttle/black




