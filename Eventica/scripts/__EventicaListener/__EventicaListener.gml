/// @param {Id.Instance|Struct} _scope
/// @param {function} _callback
/// @param {real} _repetitions
function __EventicaListener(_scope, _callback, _repetitions) constructor {
    scope = is_struct(_scope) ? weak_ref_create(_scope) : _scope.id
    callback = _callback
    repetitions = _repetitions
    
    /// @return {bool}
    static ScopeIsAlive = function(){
        if (is_struct(scope)) {
            if (weak_ref_alive(scope)) {
                return true
            }
        } else if (instance_exists(scope)) {
            return true
        }
        
        return false
    }
    
    /// @param {Id.Instance|Struct} _other_scope
    /// @param {function} _callback
    /// @param {real} _repetitions
    /// @return {bool}
    static ScopeIsEqual = function(_other_scope){
        if (is_struct(scope)) {
            if (weak_ref_alive(scope)) {
                return scope.ref == _other_scope
            }
        } else if (instance_exists(scope)) {
            return scope.id == _other_scope.id
        }
        
        return false
    }
    
    /// @param {Id.Instance|Struct}
    static ScopeGetPointer = function(){
        if (is_struct(scope)) {
            return scope.ref
        } else {
            return scope
        }
    }
}