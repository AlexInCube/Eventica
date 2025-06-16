alarm[0] = irandom_range(30, 300)

if (position_meeting(x, y, objEnemyDevil)) exit
if (instance_number(objEnemyDevil) < 5){
    instance_create_layer(x, y, "Game_Instances", objEnemyDevil)
}

