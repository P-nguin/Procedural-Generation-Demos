extends TileMap

@onready var character = %Character

var moisture = FastNoiseLite.new()
var temperature = FastNoiseLite.new()
var altitude = FastNoiseLite.new()

var height = 150
var width = 150

# Called when the node enters the scene tree for the first time.
func _ready():
	moisture.seed = randi()
	temperature.seed = randi()
	altitude.frequency = 0.005
	altitude.seed = randi()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_cell_source_id(0, character.position) == -1:
		generate_chunk(character.position)

func generate_chunk(position):
	var tile_pos = local_to_map(position)
	for x in range(width):
		for y in range(height):
			var moist = moisture.get_noise_2d(tile_pos.x - width/2 + x, tile_pos.y - height/2 + y)*10
			var temp = temperature.get_noise_2d(tile_pos.x - width/2 + x, tile_pos.y -height/2 + y)*10
			var alt = altitude.get_noise_2d(tile_pos.x - width/2 + x, tile_pos.y - height/2 + y)
			set_cell(0, Vector2i(tile_pos.x - width/2 + x, tile_pos.y - height/2 + y), 0, Vector2i(round((moist+10)/5),round((temp+10)/5)))
