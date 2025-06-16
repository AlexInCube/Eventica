if (alarm[0] <= 0){
    hp -= other.damage
    alarm[0] = 10
}

if (hp <= 0) {
    instance_destroy()
}