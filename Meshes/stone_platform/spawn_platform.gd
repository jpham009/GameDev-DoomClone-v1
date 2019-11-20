extends Spatial

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var time = null
onready var pos = get_node('../spawn_platform')
# Called when the node enters the scene tree for the first time.
func _ready():
  pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
  if time == null: 
    time = delta
  if (delta - time >= 3):
    var zombieSpawn = load("res://Zombie/Zombie.tscn")
    var zombie = zombieSpawn.instance()
    #var pos = Vector3(0,0,0)
    zombie.translation = pos
#get_node("“/root/spawn_platform")