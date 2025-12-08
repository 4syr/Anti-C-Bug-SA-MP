#include <YSI_Coding\y_hooks>

enum E_PLAYER_CBUG_DATA {
    bool:pcbug_Detected,
    pcbug_LastShot,
    pcbug_LastDuck,
    pcbug_Warnings,
    pcbug_FreezeTimer,
    pcbug_CrouchCount,
    pcbug_LastCrouchReset
}

static 
    PlayerCBugInfo[MAX_PLAYERS][E_PLAYER_CBUG_DATA];

#define CBUG_DETECTION_TIME   400    // 1 second
#define CBUG_FREEZE_TIME     2000    // 2 seconds
#define CBUG_MAX_WARNINGS    5       // Changed to 5 warnings before kick
#define CROUCH_SPAM_LIMIT    3       // Max crouches within time window
#define CROUCH_RESET_TIME    2000    // Time window for crouch spam (2 seconds)

hook OnPlayerConnect(playerid) {
    ResetCBugData(playerid);
    return 1;
}

hook OnPlayerStateChange(playerid, newstate, oldstate) {
    if(newstate != PLAYER_STATE_ONFOOT) {
        ResetCBugData(playerid);
    }
    return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys) {
    if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return 1;
    
    new weapon = GetPlayerWeapon(playerid);
    if(!IsWeaponCBugable(weapon)) return 1;

    new currentTime = GetTickCount();

    if(currentTime - PlayerCBugInfo[playerid][pcbug_LastCrouchReset] > CROUCH_RESET_TIME) {
        PlayerCBugInfo[playerid][pcbug_CrouchCount] = 0;
        PlayerCBugInfo[playerid][pcbug_LastCrouchReset] = currentTime;
    }

    if((newkeys & KEY_FIRE) && !(oldkeys & KEY_FIRE)) {
        PlayerCBugInfo[playerid][pcbug_LastShot] = currentTime;
    }
    else if((newkeys & KEY_CROUCH) && !(oldkeys & KEY_CROUCH)) {
        PlayerCBugInfo[playerid][pcbug_CrouchCount]++;
        if(PlayerCBugInfo[playerid][pcbug_CrouchCount] > CROUCH_SPAM_LIMIT) {
            HandleCBugViolation(playerid);
            return 1;
        }
        if(!PlayerCBugInfo[playerid][pcbug_Detected]) {
            new timediff = currentTime - PlayerCBugInfo[playerid][pcbug_LastShot];
            if(timediff < CBUG_DETECTION_TIME && timediff > 0) {
                HandleCBugViolation(playerid);
            }
        }
        PlayerCBugInfo[playerid][pcbug_LastDuck] = currentTime;
    }
    return 1;
}

static stock IsWeaponCBugable(weaponid) {
    switch(weaponid) {
        case WEAPON_SNIPER, WEAPON_DEAGLE, WEAPON_SHOTGUN: return 1;
    }
    return 0;
}

static stock HandleCBugViolation(playerid) {
    PlayerCBugInfo[playerid][pcbug_Detected] = true;
    PlayerCBugInfo[playerid][pcbug_Warnings]++;
    
    new string[128];
    format(string, sizeof(string), "~r~C-Bug Detected!~n~~w~Warning: %d/%d", 
        PlayerCBugInfo[playerid][pcbug_Warnings], CBUG_MAX_WARNINGS);
    GameTextForPlayer(playerid, string, 3000, 3);
    
    TogglePlayerControllable(playerid, false);
    
    if(PlayerCBugInfo[playerid][pcbug_FreezeTimer]) {
        KillTimer(PlayerCBugInfo[playerid][pcbug_FreezeTimer]);
    }
    
    PlayerCBugInfo[playerid][pcbug_FreezeTimer] = SetTimerEx("OnCBugFreezeEnd", 
        CBUG_FREEZE_TIME, false, "i", playerid);
        
    if(PlayerCBugInfo[playerid][pcbug_Warnings] >= CBUG_MAX_WARNINGS) {
        Kick(playerid);
    }
}

forward OnCBugFreezeEnd(playerid);
public OnCBugFreezeEnd(playerid) {
    PlayerCBugInfo[playerid][pcbug_Detected] = false;
    TogglePlayerControllable(playerid, true);
    return 1;
}

static stock ResetCBugData(playerid) {
    PlayerCBugInfo[playerid][pcbug_Detected] = false;
    PlayerCBugInfo[playerid][pcbug_LastShot] = 0;
    PlayerCBugInfo[playerid][pcbug_LastDuck] = 0;
    PlayerCBugInfo[playerid][pcbug_Warnings] = 0;
    PlayerCBugInfo[playerid][pcbug_CrouchCount] = 0;
    PlayerCBugInfo[playerid][pcbug_LastCrouchReset] = 0;
    
    if(PlayerCBugInfo[playerid][pcbug_FreezeTimer]) {
        KillTimer(PlayerCBugInfo[playerid][pcbug_FreezeTimer]);
        PlayerCBugInfo[playerid][pcbug_FreezeTimer] = 0;
    }
}
