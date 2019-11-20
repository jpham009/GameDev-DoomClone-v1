extends Spatial

export var rotationRate = 100
export var quantity     = 20
onready var raycast = $RayCast

#-----------------------------------------------------------
func _process( delta ) :
  var rot_speed = deg2rad( rotationRate )
  rotate_y( rot_speed*delta )
#-----------------------------------------------------------
func _physics_process(delta):  
  if raycast.is_colliding() :
    var coll = raycast.get_collider()
    if coll != null and coll.name == 'Player' :
      coll.hurt()
#-----------------------------------------------------------
func setQuantity( qty ) :
  quantity = qty

#-----------------------------------------------------------
