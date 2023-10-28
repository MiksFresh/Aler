Alleria = {};
Alleria.Title, Alleria.self = ...;
Alleria.G = _G;
Alleria.Folder = Alleria.Title;
Alleria.Version = GetAddOnMetadata(Alleria.Folder, "version");

Alleria.Frame = CreateFrame("Frame");

Alleria.Core = LibStub("AceAddon-3.0"):NewAddon(Alleria.Frame, Alleria.Title, "AceHook-3.0");
Alleria.HBD = LibStub("HereBeDragons-2.0.1");
Alleria.HBD.Pins = LibStub("HereBeDragons-Pins-2.0");

Alleria.Modules = {};

if(AlleriaGlobal == nil) then
    AlleriaGlobal = {};
    AlleriaGlobal.Debug = false;
else
    Alleria.FirstRun = false;
end;

if(AlleriaCharacter == nil) then
    AlleriaCharacter = {};
else

end;

function Alleria.Core:Debug(...)
    if(AlleriaGlobal.Debug == false) then return 0; end;
    local msg;
    if(type(...) == "string") then
        print("[Alleria System]:", ...);
    else
        for index, part in pairs(...) do
            print(index, part);
            msg = msg .. " " .. msg;
        end;
        print("[Alleria System]:", msg);
    end;
end

Alleria.SayTyping = false;
Alleria.EmoteTyping = false;
Alleria.ChatMaxLetters = 254;
Alleria.TabSpaces = "    ";
Alleria.SplitMsg = {};

Alleria.Stats = {};
Alleria.Stats.PVP_FREE = 0;
Alleria.Stats.PVP_DAMAGE = 0;
Alleria.Stats.PVP_ARMOR = 0;
Alleria.Stats.PVP_CRITICAL = 0;
Alleria.Stats.PVP_HEAL = 0;
Alleria.Stats.PVE_FREE = 0;
Alleria.Stats.PVE_ATTACK_MELEE = 0;
Alleria.Stats.PVE_ATTACK_RANGED = 0;
Alleria.Stats.PVE_ATTACK_MAGIC = 0;
Alleria.Stats.PVE_DEFENSE_MELEE = 0;
Alleria.Stats.PVE_DEFENSE_RANGED = 0;
Alleria.Stats.PVE_DEFENSE_MAGIC = 0;
Alleria.Stats.PVE_HEAL = 0;

Alleria.Display = {
    [0]  = "1 0", -- Head
    [1]  = "1 0", -- Neck
    [2]  = "1 0", -- Shoulders
    [3]  = "1 0", -- Body
    [4]  = "1 0", -- Chest
    [5]  = "1 0", -- Waist
    [6]  = "1 0", -- Legs
    [7]  = "1 0", -- Feet
    [8]  = "1 0", -- Wrists
    [9]  = "1 0", -- Hands
    [10] = nil, -- Finger1
    [11] = nil, -- Finger2
    [12] = nil, -- Trinket1
    [13] = nil, -- Trinket2
    [14] = "1 0", -- Back
    [15] = "1 0", -- Mainhand
    [16] = "1 0", -- Offhand
    [17] = "1 0", -- Ranged
    [18] = "1 0", -- Tabard
};

-- ------------------------------------------
-- InGame variables
-- ------------------------------------------
AFK = "Вне роли";
CHAT_AFK_GET = "%s <Вне роли>:\32";
CLEARED_AFK = "Вы вышли из режима \"Вне роли\".";
MARKED_AFK = "Вы находитесь вне роли.";
CHAT_FLAG_AFK = "<Вне роли>";
CHAT_MSG_AFK = "Вне роли";

-- Maail
GM_EMAIL_NAME  = "NightWatch";

-- GM
CHAT_FLAG_GM = "<NightWatch Team>";

-- Stats

-- PRIMARY_STAT1_TOOLTIP_NAME = "Strength";
-- PRIMARY_STAT2_TOOLTIP_NAME = "Agility";
-- PRIMARY_STAT3_TOOLTIP_NAME = "Stamina";
-- PRIMARY_STAT4_TOOLTIP_NAME = "Intellect";

-- SPELL_STAT1_NAME = "Strength";
-- SPELL_STAT2_NAME = "Agility";
-- SPELL_STAT3_NAME = "Stamina";
-- SPELL_STAT4_NAME = "Intellect";
-- SPELL_STAT5_NAME = "Spirit";

-- ITEM_MOD_STAMINA_SHORT = " Maybe this";
-- --------------------------------------------------------------