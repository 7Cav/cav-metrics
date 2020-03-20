
// function adapted from YAINA by MartinCo at http://yaina.eu

params ["_args"];
_args params [["_cba",false,[true]]];

if(missionNamespace getVariable ["CavMetrics_run",false]) then {
    private _startTime = diag_tickTime;
    // Number of local units
    ["count.units", { local _x } count allUnits] call CavMetrics_fnc_send;
    ["count.groups", { local _x } count allGroups] call CavMetrics_fnc_send;
    ["count.vehicles", { local _x} count vehicles] call CavMetrics_fnc_send;
    
    // Server Stats
    ["stats.fps", round diag_fps] call CavMetrics_fnc_send;
    ["stats.fpsMin", round diag_fpsMin] call CavMetrics_fnc_send;
    ["stats.uptime", round diag_tickTime] call CavMetrics_fnc_send;
    ["stats.missionTime", round time] call CavMetrics_fnc_send;
    
    // Scripts
    private _activeScripts = diag_activeScripts;
    ["scripts.spawn", _activeScripts select 0] call CavMetrics_fnc_send;
    ["scripts.execVM", _activeScripts select 1] call CavMetrics_fnc_send;
    ["scripts.exec", _activeScripts select 2] call CavMetrics_fnc_send;
    ["scripts.execFSM", _activeScripts select 3] call CavMetrics_fnc_send;
    
    private _pfhCount = if(_cba) then {count CBA_common_perFrameHandlerArray} else {0};
    ["scripts.pfh", _pfhCount] call CavMetrics_fnc_send;
    
    // Globals if server
    if (isServer) then {
        // Number of local units
        ["count.units", count allUnits, true] call CavMetrics_fnc_send;
        ["count.groups", count allGroups, true] call CavMetrics_fnc_send;
        ["count.vehicles", count vehicles, true] call CavMetrics_fnc_send;
        ["count.players", count allPlayers, true] call CavMetrics_fnc_send;
    };
    
    // log the runtime and switch off debug so it doesn't flood the log
    if(missionNamespace getVariable ["CavMetrics_debug",false]) then {
        [format ["Run time: %1", diag_tickTime - _startTime], "DEBUG"] call CavMetrics_fnc_log;
        missionNamespace setVariable ["CavMetrics_debug",false];
    };
};
