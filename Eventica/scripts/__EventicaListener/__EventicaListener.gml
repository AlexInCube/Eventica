/// @param {Id.Instance|Struct} _scope
/// @param {function} _callback
/// @param {real} _repetitions
function __EventicaListener(_scope, _callback, _repetitions) constructor {
    scope = is_struct(_scope) ? weak_ref_create(_scope) : _scope.id
    callback = _callback
    repetitions = _repetitions
}