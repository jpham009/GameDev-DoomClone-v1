extends KinematicBody

var health = 1
var player = null
var dead = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var anim_player = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
  anim_player.play("Take 001")


func _play():
  anim_player.play("Take 001")

func _physics_process( delta ) :
    var collision = move_and_collide(Vector3(0,0,0) * 1 * delta)
    if collision:
      if collision.collider.name == "Player":
        collision.collider.heal()
        queue_free()
        
#-----------------------------------------------------------
#func hurt( howMuch = 1 ) :
#  health -= howMuch
#
#  if health <= 0 :
#    dead = true
#    $CollisionShape.disabled = true
#    anim_player.play( 'die' )
#    print( '%s died.' % name )
#    if zombieAudio:
#      zombieAudio._playSound( 'die' )
#    if get_node('../HUD Layer'):
#      get_node('../HUD Layer')._opponentDied()
#
#
#  else :
#    anim_player.play( 'wounded' )
#    print( '%s wounded by %d, now has %d.' % [ name, howMuch, health ] )
#    if zombieAudio:
#      zombieAudio._playSound( 'grunt' )
#
##-----------------------------------------------------------
#func setHealth( hp ) :
#  health =  hp
#
##-----------------------------------------------------------
#func set_player( p ) :
#  player = p
#
##-----------------------------------------------------------
#func areaDamage(origin, radius):
#  var distance = (translation - origin).length()
#  if distance <= radius:
#    health = 0
#    hurt()