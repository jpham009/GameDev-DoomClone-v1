extends RigidBody

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var player = null
var dead = false
var health = 3

const explosion = preload("res://Meshes/Particles.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
  pass

onready var timer = get_node('Timer')
#var delay = false

func hurt( howMuch = 1 ) :
  health -= howMuch
  print ('barrel hit!')

  if health <= 0 :
    dead = true    
    $CollisionShape.disabled = true
    var explode = explosion.instance()
    self.add_child(explode)
    print("boom")
    get_node('barrell').visible = false
    timer.start()
    yield(timer, "timeout")
    queue_free()
    