extends KinematicBody

var MOVE_SPEED =   8
const MOUSE_SENS =   0.5
const MAX_ANGLE  =  88
const MIN_ANGLE  = -45
var numHealth = 3

# FOV for when we zoom using "telescopic sight".
const FOV_NORMAL = 70
const FOV_ZOOM   = 6

var zoomed = false

onready var anim_player = $AnimationPlayer
onready var raycast = $RayCast
onready var timer = get_node('Timer')
var delay = false

#-----------------------------------------------------------
func _ready():
  Input.set_mouse_mode( Input.MOUSE_MODE_CAPTURED )

  yield( get_tree(), 'idle_frame' )
  
  add_to_group('player')
  get_tree().call_group( 'zombies', 'set_player', self )
  get_tree().call_group( 'health', 'set_player', self )
  
#-----------------------------------------------------------
func _input( event ) :
  if Input.is_action_just_pressed( 'zoom' ) :
    zoomed = not zoomed

  if zoomed :
    get_node( 'Camera' ).fov = FOV_ZOOM
    get_node( 'View/Crosshair' ).visible = false
    get_node( 'View/Scopesight' ).visible = true

  else :
    get_node( 'Camera' ).fov = FOV_NORMAL
    get_node( 'View/Crosshair' ).visible = true
    get_node( 'View/Scopesight' ).visible = false

  if event is InputEventMouseMotion :
    rotation_degrees.y -= MOUSE_SENS * event.relative.x

    rotation_degrees.x -= MOUSE_SENS * event.relative.y
    rotation_degrees.x = min( MAX_ANGLE, max( MIN_ANGLE, rotation_degrees.x ) )
    
    
  if Input.is_action_just_pressed( 'run' ): 
    MOVE_SPEED = 15
  
  if Input.is_action_just_released( 'run' ):
    MOVE_SPEED = 8

#-----------------------------------------------------------
func _process( __ ) :    # Not using delta so don't name it.
  if Input.is_action_pressed( 'restart' ) :
    kill()

#-----------------------------------------------------------
func _physics_process( delta ) :
  var move_vec = Vector3()

  if Input.is_action_pressed( 'move_forwards' ) :
    move_vec.z -= 1

  if Input.is_action_pressed( 'move_backwards' ) :
    move_vec.z += 1

  if Input.is_action_pressed( 'move_left' ) :
    move_vec.x -= 1

  if Input.is_action_pressed( 'move_right' ) :
    move_vec.x += 1

  move_vec = move_vec.normalized()
  move_vec = move_vec.rotated( Vector3( 0, 1, 0 ), rotation.y )

  # warning-ignore:return_value_discarded
  move_and_collide( move_vec * MOVE_SPEED * delta )

  if Input.is_action_just_pressed( 'shoot' ) and !anim_player.is_playing() :
    if $'../HUD Layer'._ammoUsed() :
      anim_player.play( 'shoot' )
      $'../Player Audio'._playSound( 'shoot' )

      var coll = raycast.get_collider()
      if raycast.is_colliding() and coll.has_method( 'hurt' ) :
        coll.hurt()

    else :
      $'../Player Audio'._playSound( 'empty' )

#-----------------------------------------------------------
func kill() :
  var timeStr = $'../HUD Layer'.getTimeStr()

  print( 'Player died at %s.' % timeStr )

  $'../Message Layer/Message'.activate( 'Player Died\n%s' % timeStr )

#-----------------------------------------------------------

func hurt() :
    if delay == false: 
      timer.start() # Start the Timer counting down
      numHealth -= 1
      if numHealth <= 0:
        get_node( '../HUD Layer' )._playerHurt(numHealth)
        kill()
      delay = true
      yield(timer, "timeout") # Wait for the timer to wind down
      delay = false

    get_node( '../HUD Layer' )._playerHurt(numHealth)
  
#-----------------------------------------------------------
func heal() :
  get_node( '../HUD Layer' )._resetHealth(3)
  
#-----------------------------------------------------------
func reload() :
  get_node( '../HUD Layer' )._resetAmmo(40)
  
#-----------------------------------------------------------
func areaDamage(origin, radius):
  var distance = (translation - origin).length()
  if distance <= radius:
    hurt()
