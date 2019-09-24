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