extends KinematicBody

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var anim_player = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
  var anim = get_node("AnimationPlayer").get_animation("Take 01")
  anim.set_loop(true)
  get_node("AnimationPlayer").play("Take 01")
  
  
  
export var rotationRate = 50

#-----------------------------------------------------------
func _process( delta ) :
  var rot_speed = deg2rad( rotationRate )
  rotate_y( rot_speed*delta )
  
func _physics_process( delta ) :
    var collision = move_and_collide(Vector3(0,0,0) * 1 *  delta)
    if collision:
      if collision.collider.name == "Player":
        collision.collider.heal()
        queue_free()
