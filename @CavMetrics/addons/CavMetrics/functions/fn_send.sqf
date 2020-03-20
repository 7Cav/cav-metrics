params ["_metric", "_value", ["_global", false]];

private _profileName = profileName;
private _prefix = "GameServers.Arma3";

private _metricPath = [format["%1.%2.%3.%4", _prefix, _profileName, "hosts", profileName], format["%1.%2.%3", _prefix, _profileName, "global"]] select _global;

private _extSend = format["%1|%2", format["%1.%2", _metricPath, _metric], _value];

if(missionNamespace getVariable ["CavMetrics_debug",false]) then {
    [format ["Sending a3Graphite data: %1", _extSend], "DEBUG"] call CavMetrics_fnc_log;
};

// send the data
private _return = "a3graphite" callExtension _extSend;

// shouldn't be possible, the extension should always return even if error
if(isNil "_return") exitWith {
    [format ["return was nil (%1)", _extSend], "ERROR"] call CavMetrics_fnc_log;
    false
};

// extension error codes
if(_return in ["invalid metric value","malformed, could not find separator"] ) exitWith {
    [format ["%1 (%2)", _return, _extSend], "ERROR"] call CavMetrics_fnc_log;
    false
};

// success, only show if debug is set
if(missionNamespace getVariable ["CavMetrics_debug",false]) then {
    _returnArgs = _return splitString (toString [10,32]);
    [format ["a3Graphite return data: %1",_returnArgs], "DEBUG"] call CavMetrics_fnc_log;
};

true
