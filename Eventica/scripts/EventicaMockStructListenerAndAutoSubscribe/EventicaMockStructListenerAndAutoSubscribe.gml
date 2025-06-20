function EventicaMockStructListenerAndAutoSubscribe() constructor {
    __counter = 0
    name = "i am struct listener"
    
    static counterUp = function(){
        __counter++
    }
    
    static counterReset = function(){
        __counter = 0
    }
    
    static counterGetValue = function(){
        return __counter
    }
    
    static counterUpBy = function(_number){
        __counter += _number
    }
    
    EVENTICA_HANDLER.once("struct auto subscribe", counterUp)
}