extends TileMap

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal addTik(s_tik)

signal cursor_moveLeft()
signal cursor_moveRight()

signal cursor_moveUp()
signal cursor_moveDown()

signal cursor_color(frame)

var m_cursor := Vector2(0, 0)

var m_popTile_id := 1

var m_tik := 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func add_tik():
	m_tik+=1
	emit_signal("addTik", m_tik)
	
func move_tile(o_x:int, o_y:int, d_x:int, d_y:int):
	var _cellId = get_cell(o_x, o_y)
	
	match get_cell(d_x, d_y):
		INVALID_CELL:
			set_cell(o_x, o_y, INVALID_CELL)
			set_cell(d_x, d_y, _cellId)
			return false
			
		0:
			if _cellId==0:
				set_cell(o_x, o_y, INVALID_CELL)
				set_cell(d_x, d_y, 3)
				add_tik()
				return true
				
		1:
			if _cellId==1:
				set_cell(o_x, o_y, INVALID_CELL)
				set_cell(d_x, d_y, 2)
				add_tik()
				return true
		
		2:	
			if _cellId==2:
				set_cell(o_x, o_y, INVALID_CELL)
				set_cell(d_x, d_y, 1)
				add_tik()
				return true
				
		3:
			if _cellId==3:
				set_cell(o_x, o_y, INVALID_CELL)
				set_cell(d_x, d_y, 0)
				add_tik()
				return true
	return false

func move_tiles_x(o_x0:int, d_x0:int, o_x1:int, d_x1:int):
	var f_b0 := 0
	var f_b1 := 0
	
	for y in range(3):
		f_b0 += 1 if move_tile(o_x0, y, d_x0, y) else 0
		f_b1 += 1 if move_tile(o_x1, y, d_x1, y) else 0
		
	if f_b0>0 or f_b1>0:
		return true

	return false
	
func move_tiles_y(o_y0:int, d_y0:int, o_y1:int, d_y1:int):
	var f_b0 := 0
	var f_b1 := 0
	
	for x in range(3):
		f_b0 += 1 if move_tile(x, o_y0, x, d_y0) else 0
		f_b1 += 1 if move_tile(x, o_y1, x, d_y1) else 0
		
	if f_b0>0 or f_b1>0:
		return true

	return false

func swap_pop_color():
	m_popTile_id += 1
	
	if m_popTile_id > 3:
		m_popTile_id=0
	
	emit_signal("cursor_color", m_popTile_id)

func pop_tile():
	if get_cell(m_cursor.x, m_cursor.y) == INVALID_CELL:
		set_cell(m_cursor.x, m_cursor.y, m_popTile_id)
		swap_pop_color()

func _process(delta):
	if Input.is_action_just_pressed("ui_up"):
		#move and/or tile fusion
		if move_tiles_y(1, 0, 2, 1) && m_cursor.y>0 :
			emit_signal("cursor_moveUp")
			m_cursor.y-=1
			
		#check pop and pop tile and swap color
		pop_tile()
		
	if Input.is_action_just_pressed("ui_down"):
		if move_tiles_y(1, 2, 0, 1) && m_cursor.y<2:
			emit_signal("cursor_moveDown")
			m_cursor.y+=1
			
		#check pop and pop tile and swap color
		pop_tile()
		
	if Input.is_action_just_pressed("ui_left"):
		if move_tiles_x(1, 0, 2, 1) && m_cursor.x>0 :
			emit_signal("cursor_moveLeft")
			m_cursor.x-=1
			
		#check pop and pop tile and swap color
		pop_tile()
		
	if Input.is_action_just_pressed("ui_right"):
		if move_tiles_x(1, 2, 0, 1) && m_cursor.x<2 :
			emit_signal("cursor_moveRight")
			m_cursor.x+=1
			
		#check pop and pop tile and swap color
		pop_tile()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
