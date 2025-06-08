function EventicaHandler() constructor {
    __namespace_delimiter = EVENTICA_DEFAULT_DELIMITER
    __newListener = EVENTICA_DEFAULT_NEW_LISTENER
    __removeListener = EVENTICA_DEFAULT_REMOVE_LISTENER
    __wildcardEnable = EVENTICA_DEFAULT_ENABLE_WILDCARD
    __maxListeners = 10
    
    //__listeners = {}
    __events = {}
    
    /// @param {string} _namespace Event you want to emit
    /// @param {any} _args There can be a multiple args like: emit(value1, value2, value3, ...)
    static emit = function(_namespace, _args = undefined){
        // Wrap args into executable form for script_execute_ext()
        if (!is_undefined(_args)){
            var _args_array = []
           
            var _i = 1; repeat(argument_count - 1)
            {
                array_push(_args_array, argument[_i]) 
                _i++
            }
            
            _args = _args_array
        }
        
        __EmitEvent(_namespace, _args)
    }
    
    /// @desc Subscribe the current object or struct to event.
    /// @param {string} _namespace Event you want to subscribe
    /// @param {function} _callback Function that will be executed when event is emitted
    /// @return {any} Returns listener
    static on = function(_namespace, _callback) {
        return __AddListener(other, _namespace, _callback)
    }
    
    /// @desc Subscribe the current object or struct to event. Once script is executed, the listener automatically unsubscribe from event.
    /// @param {string} _namespace Event you want to subscribe
    /// @param {function} _callback Function that will be executed when event is emitted
    /// @return {any} Returns listener
    static once = function(_namespace, _callback){
        return __AddListener(other, _namespace, _callback, 1)
    }
    
    /// @desc Subscribe the current object or struct to event. When script is executed _n times, the listener automatically unsubscribe from event.
    /// @param {string} _namespace Event you want to subscribe
    /// @param {function} _callback Function that will be executed when event is emitted
    /// @param {real} _n How many times function need to be executed
    /// @return {any} Returns listener
    static many = function(_namespace, _callback, _n){
        return __AddListener(other, _namespace, _callback, _n)
    }
    
    static off = function(){
        show_debug_message("not implemented")
    }
    
    static onAny = function(){
        show_debug_message("not implemented")
    }
    
    static offAny = function(){
        show_debug_message("not implemented")
    }
    
    static removeAllListeners = function(){
        show_debug_message("not implemented")
    }
    
    static setMaxListeners = function(){
        show_debug_message("not implemented")
    }
    
    static getMaxListeners = function(){
        show_debug_message("not implemented")
    }
    
    /// @param {Id.Instance|Struct} _scope
    /// @param {string} _namespace
    /// @param {function} _callback
    /// @param {real} _repetitions
    /// @return {any} Returns listener
    static __AddListener = function(_scope, _namespace, _callback, _repetitions = -1){
        if (!is_struct(_scope) && !instance_exists(_scope)) {
            __EventicaError("Listener must be instance or struct")
            exit
        }
        
        if (!is_array(__events[$ _namespace])){
            __events[$ _namespace] = []
        }
        
        array_push(__events[$ _namespace], {
            scope: is_struct(_scope) ? weak_ref_create(_scope) : _scope.id,
            callback: _callback,
            repetitions: _repetitions
        })

        return _scope
    }
    
    static __RemoveListener = function(_scope){
        if (!is_struct(_scope) && !instance_exists(_scope)) {
            __EventicaError("Listener must be instance or struct")
            exit
        }
        
        
    }
    
    /// @param {string} _namespace
    /// @param {Array.Any} _args
    static __EmitEvent = function(_namespace, _args){
        var _event = __events[$ _namespace]
        if (is_undefined(_event)) exit
        
        var _i = 0; repeat(array_length(_event)) {
            var _listener = _event[_i]
            var ref_is_alive = false

            if (weak_ref_alive(_listener.scope)){
                ref_is_alive = true
                
                with (_listener.scope.ref) {
                    script_execute_ext(_listener.callback, _args)
                }
                
                continue
            }
            
            if (instance_exists(_listener.scope)){
                ref_is_alive = true
                
                with (_listener.scope) {
                    script_execute_ext(_listener.callback, _args)
                }
            }
            
            // If listener struct or instance is not exists, delete listener
            if (!ref_is_alive) {
                array_delete(__events[$ _namespace], _i, 1)
                
                if (array_length(__events[$ _namespace]) == 0){
                    struct_remove(__events, _namespace)
                }
                
                _i--
            }
            
            _i++
        }
    }
}
