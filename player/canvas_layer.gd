extends CanvasLayer

# "translating" a position in the 2d space to the canvas space for UI elements
#
# Related forum post 
# https://forum.godotengine.org/t/static-function-to-translate-a-position-in-2d-space-to-a-position-on-the-canvaslayer/70485
#
# TODO: MOVE THIS TO A SINGLETON LATER!!!! MORE SCENES MIGHT NEED THIS FUNCTION

func node_to_canvas_position(node: Node2D) -> Vector2:
	var root = get_viewport()
	var final_transform = root.get_final_transform()
	var global_transform = node.get_global_transform_with_canvas()
	var canvas_position = (final_transform * global_transform).origin
	return canvas_position
