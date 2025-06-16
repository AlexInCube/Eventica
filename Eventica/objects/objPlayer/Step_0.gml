depth = -bbox_bottom

var _hor = keyboard_check((ord("D"))) - keyboard_check((ord("A")))
var _ver = keyboard_check((ord("S"))) - keyboard_check((ord("W")))

move_and_collide(_hor * moveSpeed, _ver * moveSpeed, objWall)

if (_hor != 0 || _ver != 0) {
    if (_ver > 0) dir = move_dir.down
    if (_ver < 0) dir = move_dir.up
    if (_hor > 0) dir = move_dir.right
    if (_hor < 0) dir = move_dir.left
    sprite_index = walkSprites[dir]  
    facing = point_direction(0, 0, _hor, _ver)       
} else {
    sprite_index = idleSprites[dir]     
}

if (keyboard_check_pressed(vk_space)) {
    var _inst = instance_create_depth(x, y, depth, objAttack)
    _inst.image_angle = facing
}