extends RigidBody

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var raycast = $RayCast
onready var anim_player = $AnimationPlayer

var player = null
var zombie = null
var dead = false
var health = 3
var radius = 10 
var damage = 1


const explosion = preload("res://Meshes/Particles.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
  pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
  pass

onready var timer = get_node('Timer')
#var delay = false

func _physics_process( delta ) :
  if dead :
    return

  if player == null :
    return
  if zombie == null :
    return

func set_player( p ) :
  player = p

func set_zombie( z ) :
  zombie = z
  
func kill() :
  get_tree().call_group('zombies', 'areaDamage', translation, radius)
  get_tree().call_group('player', 'areaDamage', translation, radius)

  
func hurt( howMuch = 1 ) :
  health -= howMuch
  print ('barrel hit!')

  if health <= 0 :
    dead = true    
    $CollisionShape.disabled = true
    var explode = explosion.instance()
    self.add_child(explode)
    kill()
    print("boom")
    get_node('barrell').visible = false
    timer.start()
    yield(timer, "timeout")
    queue_free()
    



## Called when the node enters the scene tree for the first time.
#func _ready():
#	add_to_group('barrell')

#func _physics_process( delta ) :
#  if dead :
#    return
#
#  if player == null :
#    return
#  if zombie == null :
#    return
#
#func set_player( p ) :
#  player = p
#
#func set_zombie( z ) :
#  zombie = z
##-------------------------------------------------------
#func kill() :
#
#	player.areaDamage(translation, radius, damage)
#	get_tree().call_group('zombies', 'areaDamage', translation, radius, damage)
#	get_tree().call_group('player', 'areaDamage', translation, radius, damage)
#	queue_free()
##----------------------
#func hurt( howMuch = 1 ) :
#  health -= howMuch
#
#  if health <= 0 :
#    dead = true
#    $CollisionShape.disabled = true
#    kill()
#
#
#
#func setHealth( hp ) :
#  health =  hp

#-----------------------------------------------------------


#-----------------------------------------------------------
