extends Spatial

const DEFAULT_MAX_AMMO = 10

#-----------------------------------------------------------
func _ready() :
  get_tree().paused = false

  var levelData = _getLevelData( 1 )

  var ammo = levelData.get( 'AMMO', null )
  if ammo != null :
    _addAmmo( ammo.get( 'tscn', null ), ammo.get( 'instances', [] ) )

  var zombies = levelData.get( 'ZOMBIES', null )
  if zombies != null :
    _addZombies( zombies.get( 'tscn', null ), zombies.get( 'instances', [] ) )

  get_node( 'HUD Layer' )._resetAmmo( levelData.get( 'maxAmmo', DEFAULT_MAX_AMMO ) )
  get_node( 'HUD Layer' )._resetHealth(3)
#-----------------------------------------------------------
func _input( __ ) :    # Not using event so don't name it.
  if Input.is_action_just_pressed( 'maximize' ) :
    OS.window_fullscreen = not OS.window_fullscreen

#-----------------------------------------------------------
func _addAmmo( model, instances ) :
  var inst
  var index = 0

  if model == null :
    print( 'There were %d ammo but no model?' % len( instances ) )
    return

  var ammoScene = load( model )

  for instInfo in instances :
    index += 1

    var pos = instInfo[ 0 ]
    var amount  = Utils.dieRoll( instInfo[ 1 ] )

    inst = ammoScene.instance()
    inst.name = 'Ammo-%02d' % index
    inst.translation = Vector3( pos[0], pos[1], pos[2] )
    inst.setQuantity( amount )
    print( '%s at %s, %d rounds.' % [ inst.name, str( pos ), amount ] )

    get_node( '.' ).add_child( inst )

#-----------------------------------------------------------
func _addZombies( model, instances ) :
  var inst
  var index = 0

  if model == null :
    print( 'There were %d zombie but no model?' % len( instances ) )
    return

  var zombieScene = load( model )

  get_node( 'HUD Layer' )._resetOpponents( len( instances ) )

  for instInfo in instances :
    index += 1

    var pos = instInfo[ 0 ]
    var hp  = Utils.dieRoll( instInfo[ 1 ] )

    inst = zombieScene.instance()
    inst.name = 'Zombie-%02d' % index
    inst.translation = Vector3( pos[0], pos[1], pos[2] )
    inst.setHealth( hp )
    print( '%s at %s, %d hp' % [ inst.name, str( pos ), hp ] )

    get_node( '.' ).add_child( inst )

#-----------------------------------------------------------
func _getLevelData( levelNumber ) :
  var levelData = {}

  var fName = 'res://Levels/Level-%02d.json' % levelNumber

  var file = File.new()
  if file.file_exists( fName ) :
    file.open( fName, file.READ )
    var text_data = file.get_as_text()
    var result_json = JSON.parse( text_data )

    if result_json.error == OK:  # If parse OK
      levelData = result_json.result

    else :
      print( 'Error        : ', result_json.error)
      print( 'Error Line   : ', result_json.error_line)
      print( 'Error String : ', result_json.error_string)

  else :
    print( 'Level %d config file did not exist.' % levelNumber )

  return levelData

#-----------------------------------------------------------
