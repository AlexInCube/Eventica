__counter = 0
name = "i am instance listener"

counterUp = function(){
    __counter++
}

counterReset = function(){
    __counter = 0
}

counterGetValue = function(){
    return __counter
}