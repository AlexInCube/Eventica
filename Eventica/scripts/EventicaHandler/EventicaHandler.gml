/// @desc Core of the Eventica
function EventicaHandler() constructor {
    /// @desc Emit “addListener” event when someone subscribes to handler
    option_event_add_listener = true
    
    /// @desc Emit "__EventicaRemoveListener" event when someone unsubscribes from event
    option_event_remove_listener = true
    
    /// @desc Set to -1 for infinite count of listeners. 
    /// When count of listeners for one event is exceed maxListeners, the warning are printed in console.
    maxListeners = 10
    
    /// @desc The delimiter used to segment namespaces
    option_namespace_delimiter = "."
    
    /// @desc Enable or disable using of * in event listeners.
    option_wildcard_enable = true
    
    /// @desc Dont touch it!!!
    __events = {}
    
    /// @param {string} _namespace Event you want to emit
    /// @param {any} _args There can be a multiple args like: emit(value1, value2, value3, ...)
    static emit = function(_namespace, _args = undefined){
        // Wrap args into executable form for script_execute_ext()
        if (!is_undefined(_args)){
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
    
    /// @desc Unsubscribe the current object or struct to event from listening the event
    /// @param {string} _namespace
    static off = function(_namespace){
        __RemoveListener(other, _namespace)
    }
    
    /// @desc Remove all listeners if _namespace is not provided or remove all namespace listeners
    /// @param {string} _namespace Event you want to subscribe
    static removeAllListeners = function(_namespace = undefined){
        if (is_undefined(_namespace)){
            delete __events
            __events = {}
        }
    }
    
    /// @param {Id.Instance|Struct} _scope
    /// @param {string} _namespace
    /// @param {function} _callback
    /// @param {real} _repetitions
    /// @return {any} Returns listener
    static __AddListener = function(_scope, _namespace, _callback, _repetitions = -1){
        if (!is_struct(_scope) && !instance_exists(_scope)) {
            __EventicaError("Listener must be alive instance or struct")
            exit
        }
        
        if (!is_callable(_callback)){
            __EventicaError("Listener callback must be method or function")
            exit
        }
        
        var _namespace_parts = string_split(_namespace, option_namespace_delimiter)
        
        var _current_pointer = __events
        
        // We need to find array of listeners or create array if not exists
        var i = 0; var _namespace_parts_len = array_length(_namespace_parts); repeat(_namespace_parts_len) {
            var _current_namespace_part = _namespace_parts[i]
            
            if (!variable_struct_exists(_current_pointer, _current_namespace_part)){
                _current_pointer[$ _current_namespace_part] = {}
            }
            
            if (i == _namespace_parts_len - 1){
                _current_pointer[$ _current_namespace_part] = []
                _current_pointer = _current_pointer[$ _current_namespace_part]
                break
            }
            
            _current_pointer = _current_pointer[$ _current_namespace_part]

            i++
        }
        
        // _current_pointer at this point always must be array
        array_push(_current_pointer, new __EventicaListener(_scope, _callback, _repetitions))
        
        if (maxListeners != -1 && array_length(__events[$ _namespace_parts[i]]) > maxListeners) __EventicaError($"Max listeners for event \"{_namespace}\" is exceed {maxListeners} listeners, propably you have memory leak?")
        
        if (option_event_add_listener) __EmitEvent(__EVENTICA_EVENT_ADD_LISTENER, [_scope, _namespace])

        return _scope
    }
    
    /// @param {Id.Instance|Struct} _scope
    /// @param {string} _namespace
    static __RemoveListener = function(_scope, _namespace){
        var _listeners = __FindListenersArray(_namespace)
        if (is_undefined(_listeners)) exit 
        if (option_event_remove_listener) __EmitEvent(__EVENTICA_EVENT_REMOVE_LISTENER, [_scope, _namespace])

        if (is_struct(_scope)){ // If we have struct listener
            var _i = 0; repeat(array_length(_listeners)) {
                if (_listeners[_i].scope.ref == _scope){
                    array_delete(_listeners, _i, 1)
                    break
                }
                
                _i++
            }
        } else if (instance_exists(_scope)){ // If we have instance listener
            var _i = 0; repeat(array_length(_listeners)) {
                if (_listeners[_i].scope.id == _scope.id){
                    array_delete(_listeners, _i, 1)
                    break
                }
                
                _i++
            }
        } else {
            __EventicaError("Listener must be alive instance or struct")
            exit
        }
        
        // If we don`t have any listener on event, remove event
        __RemoveNamespaceIfEmpty(_namespace)
    }
    
    /// @param {string} _namespace
    /// @param {Array.Any} _args
    static __EmitEvent = function(_namespace, _args = []){
        var _listeners = __FindListenersArray(_namespace)
        if (is_undefined(_listeners)) exit 
        if (_namespace != __EVENTICA_EVENT_ANY) __EmitEvent(__EVENTICA_EVENT_ANY, [_namespace, _args])
        
        var _i = 0; repeat(array_length(_listeners)) {
            var _listener = _listeners[_i]
            // We must prove, the listener are still exists
            var _auto_unsubscribe = true
            var _scope = undefined;
            
            if (is_struct(_listener.scope)) {
                if (weak_ref_alive(_listener.scope)) {
                    _auto_unsubscribe = false
                    
                    _scope = _listener.scope.ref
                }
            } else if (instance_exists(_listener.scope)) {
                _auto_unsubscribe = false
                
                _scope = _listener.scope
            }

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
                array_delete(__events[$ _namespace], _i, 1)
                
                // If we don`t have any listener on event, remove event
                __RemoveNamespaceIfEmpty(_namespace)
                
                _i--
            }
            
            _i++
        }
    }
    
    /// @param {string} _namespace
    /// @return {Array.__EventicaListener|undefined}
    static __FindListenersArray = function(_namespace){
        var _namespace_parts = string_split(_namespace, option_namespace_delimiter);
        
        var _current = __events // just pointer
        
        var i = 0; repeat (array_length(_namespace_parts)) {
        	var _key = _namespace_parts[i]
            
            if (!variable_struct_exists(_current, _key)){
                return undefined
            }
            
            _current = _current[$ _key]
            
            i++
        }
        
        return _current
    }
    
    /// @param {string} _namespace
    static __RemoveNamespaceIfEmpty = function(_namespace){
        var _namespace_parts = string_split(_namespace, option_namespace_delimiter);
        
        var _namespace_pointer = __events // just pointer
        
        var _delete_stack = [];
        
        // Collect path for possible deletion
        var i = 0; repeat (array_length(_namespace_parts)) {
            var _key = _namespace_parts[i]
            
            if (!variable_struct_exists(_namespace_pointer, _key)){
                return;
            }
            
            array_push(_delete_stack, [_key, _namespace_pointer]) // Add field name of namespace struct and pointer to that struct
            _namespace_pointer = _namespace_pointer[$ _key]
            
            i++
        }
        
        // Delete empty structs
        while(array_length(_delete_stack) > 0){
            var _entry = array_pop(_delete_stack)
            var _key = _entry[0]
            var _pointer = _entry[1]
            
            if (is_struct(_pointer[$ _key])) {
                var _struct = _pointer[$ _key]
                if (struct_names_count(_struct) == 0){
                    struct_remove(_pointer, _key)
                }
            }
            
            if (is_array(_pointer[$ _key])) {
                if (array_length(_pointer[$ _key]) == 0){
                    struct_remove(_pointer, _key)
                }
            }
        }
    }
    
    static __GarbageCollect = function(){
        
    }
}
