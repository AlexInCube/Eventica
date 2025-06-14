/// @desc Core of the Eventica
function EventicaHandler() constructor {
    /// @desc Emit "__EventicaAny" event when any event is emitted (except "__EventicaAny")
    option_event_any = true
    
    /// @desc Emit "__EventicaAddListener" event when someone subscribes to handler
    option_event_add_listener = true
    
    /// @desc Emit "__EventicaRemoveListener" event when someone unsubscribes from event
    option_event_remove_listener = true
    
    /// @desc Set to -1 for infinite count of listeners. 
    /// When count of listeners for one event is exceed maxListeners, the warning are printed in console.
    maxListeners = 10
    
    __events = {}

    /// @param {string} _event Event you want to emit
    /// @param {any} _args There can be a multiple args like: emit(value1, value2, value3, ...)
    static emit = function(_event, _args = undefined){
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
        
        __EmitEvent(_event, _args)
    }
    
    /// @desc Subscribe the current object or struct to event.
    /// @param {string} _event Event you want to subscribe
    /// @param {function} _callback Function that will be executed when event is emitted
    /// @return {any} Returns listener
    static on = function(_event, _callback) {
        return __AddListener(other, _event, _callback)
    }
    
    /// @desc Subscribe the current object or struct to event. Once script is executed, the listener automatically unsubscribe from event.
    /// @param {string} _event Event you want to subscribe
    /// @param {function} _callback Function that will be executed when event is emitted
    /// @return {any} Returns listener
    static once = function(_event, _callback){
        return __AddListener(other, _event, _callback, 1)
    }
    
    /// @desc Subscribe the current object or struct to event. When script is executed _n times, the listener automatically unsubscribe from event.
    /// @param {string} _event Event you want to subscribe
    /// @param {function} _callback Function that will be executed when event is emitted
    /// @param {real} _n How many times function need to be executed
    /// @return {any} Returns listener
    static many = function(_event, _callback, _n){
        return __AddListener(other, _event, _callback, _n)
    }
    
    /// @desc Unsubscribe the current object or struct to event from listening the event
    /// @param {string} _event
    static off = function(_event){
        __RemoveListener(other, _event)
    }
    
    /// @desc Remove all listeners if _event is not provided or remove all _event listeners
    /// @param {string} _event Event you want to subscribe
    static removeAllListeners = function(_event = undefined){
        if (is_undefined(_event)){
            delete __events
            __events = {}
        } else {
            struct_remove(__events, _event)
        }
    }
    
    /// @param {Id.Instance|Struct} _scope
    /// @param {string} _event
    /// @param {function} _callback
    /// @param {real} _repetitions
    /// @return {any} Returns listener
    static __AddListener = function(_scope, _event, _callback, _repetitions = -1){
        if (!is_struct(_scope) && !instance_exists(_scope)) {
            __EventicaError("Listener must be alive instance or struct")
            exit
        }
        
        if (!is_callable(_callback)){
            __EventicaError("Listener callback must be method or function")
            exit
        }
        
        var _listeners = __events[$ _event]
        
        if (!is_array(_listeners)){
            _listeners = []
            __events[$ _event] = _listeners
        }
        
        array_push(_listeners, new __EventicaListener(_scope, _callback, _repetitions))
        
        if (maxListeners != -1 && array_length(_listeners) > maxListeners) __EventicaError($"Max listeners for event \"{_event}\" is exceed {maxListeners} listeners, propably you have memory leak?")
        
        if (option_event_add_listener) __EmitEvent(__EVENTICA_EVENT_ADD_LISTENER, [_scope, _event])

        return _scope
    }
    
    /// @param {Id.Instance|Struct} _scope
    /// @param {string} _event
    static __RemoveListener = function(_scope, _event){
        var _listeners = __events[$ _event]
        if (is_undefined(_listeners)) exit 
        if (option_event_remove_listener) __EmitEvent(__EVENTICA_EVENT_REMOVE_LISTENER, [_scope, _event])

        var _i = 0; repeat(array_length(_listeners)) {
            if (_listeners[_i].ScopeIsEqual(_scope)){
                array_delete(_listeners, _i, 1)
                break
            }
            
            _i++
        }

        // If we don`t have any listener on event, remove event
        if (array_length(__events[$ _event]) == 0){
            struct_remove(__events, _event)
        }
    }
    
    /// @param {string} _event
    /// @param {Array.Any} _args
    static __EmitEvent = function(_event, _args = []){
        var _listeners = __events[$ _event]
        if (is_undefined(_listeners)) exit 
        if (option_event_any && _event != __EVENTICA_EVENT_ANY) __EmitEvent(__EVENTICA_EVENT_ANY, [_event, _args])
        
        var _i = 0; repeat(array_length(_listeners)) {
            var _listener = _listeners[_i]
            // We must prove, the listener are still exists
            var _auto_unsubscribe = !_listener.ScopeIsAlive()
            var _scope = _listener.ScopeGetPointer()
            
            // If _scope exists, execute callback
            if (!is_undefined(_scope)){
                with (_scope) {
                    script_execute_ext(_listener.callback, _args)
                }
                
                if (_listener.repetitions >= 0) {
                    _listener.repetitions--
                    
                    if (_listener.repetitions == 0){
                        _auto_unsubscribe = true
                    }
                }
            }
           
            // If listener struct or instance is not exists or repetitions is zero then delete listener
            if (_auto_unsubscribe) {
                array_delete(__events[$ _event], _i, 1)
                
                // If we don`t have any listener on event, remove event
                if (array_length(_listeners) == 0){
                    struct_remove(__events, _event)
                }
                
                _i--
            }
            
            _i++
        }
    }
    
    self.__garbage_collector_timer = time_source_create(
        time_source_global, 
        10, 
        time_source_units_seconds, 
        method(self, function(){
            self.__GarbageCollect()
        }), [], -1)
    
    
    time_source_start(__garbage_collector_timer)
    
    static GarbageCollectDisable = function(){
        time_source_pause(__garbage_collector_timer)
    }
    
    static GarbageCollectEnable = function(){
        time_source_resume(__garbage_collector_timer)
    }
    
    static __GarbageCollect = function(){
        var _events_names = struct_get_names(__events)
        
        var _i = 0; repeat (array_length(_events_names)) {
            var _listeners = __events[$ _events_names[_i]]
            
        	var _l = 0; repeat (array_length(_listeners)) {
            	var _listener = _listeners[_l]
                
                var _auto_unsubscribe = !_listener.ScopeIsAlive()

                // If listener struct or instance is not exists or repetitions is zero then delete listener
                if (_auto_unsubscribe) {
                    array_delete(_listeners, _l, 1)
                    
                    // If we don`t have any listener on event, remove event
                    if (array_length(_listeners) == 0){
                        struct_remove(__events, _events_names[_i])
                    }
                     
                    _l--
                }
                
                _l++
            }
            
            _i++
        }
    }
}


