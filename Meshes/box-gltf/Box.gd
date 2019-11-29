extends KinematicBody

export var rotationRate = 100
export var quantity     = 20

#-----------------------------------------------------------
func _process( delta ) :
  var rot_speed = deg2rad( rotationRate )
  rotate_y( rot_speed*delta )
  pass
#-----------------------------------------------------------
func _physics_process(delta):  
#  if raycast.is_colliding() :
#    var coll = raycast.get_collider()
#    if coll != null and coll.name == 'Player' :
#      coll.hurt()
  var collision = move_and_collide(Vector3(0,0,0) * 10 * delta)
  if collision:
    if collision.collider.name == "Player":
      collision.collider.reload()
      queue_free()
#-----------------------------------------------------------
func setQuantity( qty ) :
  quantity = qty

#-----------------------------------------------------------
