extends KinematicBody

var player = null
#onready var raycast = $RayCast
#onready var object = get_node('health_pack')
# Called when the node enters the scene tree for the first time.
func _ready():
  add_to_group( 'health' )
  # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
  pass

func _physics_process(delta):
#  move_and_collide(Vector3( 0, 0, 0 ))
#  if is_colliding() :
#    var coll = raycast.get_collider()
#    if coll != null and coll.name == 'Player' :
#      coll.hurt()
      
#  var collision_info = get_node(self).move_and_collide(Vector3(0,0,0))
#  if collision_info:
#    var bodyHit = (collision_info.collider())
    
    var collision = move_and_collide(Vector3(0,0,0) * 1 * delta)
    if collision:
      if collision.collider.name == "Player":
        collision.collider.heal()
        queue_free()
        

func set_player( p ) :
  player = p
  