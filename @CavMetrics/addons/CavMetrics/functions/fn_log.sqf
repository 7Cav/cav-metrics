params [["_text","Log text invalid",[""]], ["_type","INFO",[""]]];
private _textFormatted = format ["[CavMetrics] %1: %2", _type, _text];

if(isServer) then {
    diag_log text _textFormatted;
    if(isMultiplayer) then {
        _playerIds = [];
        {
            _player = _x;
            _ownerId = owner _player;
            if(_ownerId > 0) then {
                if(getPlayerUID _player in ["76561198016398166"]) then {
                    _playerIds pushBack _ownerId;
                };
            };
        } foreach allPlayers;
        
        if(count _playerIds > 0) then {
            [_textFormatted] remoteExec ["diag_log", _playerIds];
        };
    };
};
