/obj/effect/decal/tesla_act()
	return

/obj/effect/decal/point
	name = "arrow"
	desc = "It's an arrow hanging in mid-air. There may be a wizard about."
	icon = 'icons/mob/screen/generic.dmi'
	icon_state = "arrow"
	layer = 16.0
	anchored = 1
	mouse_opacity = 0

// Used for spray that you spray at walls, tables, hydrovats etc
/obj/effect/decal/spraystill
	density = 0
	anchored = 1
	layer = 50

//Used for imitating an object's sprite for decorative purposes.
/obj/effect/decal/fake_object
	name = "object"
	icon = 'icons/obj/structures.dmi'
	icon_state = "ladder11"
	density = 0
	anchored = 1
	layer = 3

/obj/effect/decal/fake_object/fusion_reactor
	name = "fusion reactor"
	desc = "A fusion reactor of skrell design. Can reliably power a medium-sized spacefaring vessel or a small city."
	icon = 'icons/obj/machines/skrell_reactor.dmi'
	icon_state = "reactor"
	density = 1
	pixel_x = -32

/obj/effect/decal/fake_object/fusion_reactor/Initialize()
	.=..()
	set_light(4,2,LIGHT_COLOR_CYAN)
