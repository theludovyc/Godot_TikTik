extends Sprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TileMap_cursor_moveDown():
	position.y+=48
	pass # Replace with function body.


func _on_TileMap_cursor_moveLeft():
	position.x-=48
	pass # Replace with function body.


func _on_TileMap_cursor_moveRight():
	position.x+=48
	pass # Replace with function body.


func _on_TileMap_cursor_moveUp():
	position.y-=48
	pass # Replace with function body.


func _on_TileMap_cursor_color(frame):
	self.frame=frame
	pass # Replace with function body.
