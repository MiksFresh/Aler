local self = Alleria;
local GM = {};

GM.name = "GM";
GM.normalName = "GM";
GM.Events = {
    ["CHAT_MSG_ADDON"] = true,
    ["PLAYER_ENTERING_WORLD"] = true,
    ["CHAT_MSG_SYSTEM"] = true,
};
GM.Commands = {};

--[[

    ALLERIA_GM_STATE_TEXT
    ALLERIA_GM_STATE_ON
    ALLERIA_GM_STATE_OFF
    ALLERIA_GM_STATE_TOGGLE

]]--
GM.CurrentObjectType = nil;
GM.ServerMask = {
    ["GOB"] = {
        ["GOB_ADD"] = ">> Add Game Object",
        ["GOB_ADD_MASK"] = "GUID: %d+",
    },
};

GM.GUID = {
    ["GOB"] = nil,
    ["NPC"] = nil,
};
GM.PREFIX = {
    "GM Announce", "Announce", "SERVER", "СЕРВЕР",
};
GM.HideNonServerMessage = true;
GM.ProfileTransmition = false;
GM.TransmitionText = "";
GM.TransmitionQueue = {};
GM.Enabled = true;
function GM:OnInitialize()
    -- Message Giving system
    --if(GM.HideNonServerMessage == true) then
    --    ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", function(frame, event, message, sender, ...)
    --        --print(message);
    --        for blackIndex, blackValue in ipairs(GM.PREFIX) do
    --            local findAt, findEnd = string.find(message, blackValue);
    --            --print(findAt, findEnd);
    --            if(findAt ~= nil) then
    --                --return true;
    --                message = message;
    --            else
    --                return true;
    --            end;
    --        end;
    --        return false, message, sender, ...;
    --    end)
    --end;
end
function GM:PLAYER_ENTERING_WORLD()
    if(type(AlleriaCharacter["GM"]) ~= "table") then
        AlleriaCharacter["GM"] = {};
        AlleriaCharacter["GM"]["State"] = false;
        AlleriaCharacter["GM"]["Fly"] = false;
        AlleriaCharacter["GM"]["Invisible"] = false;
        AlleriaCharacter["GM"]["Whispers"] = true;
    else
        
        if(AlleriaCharacter["GM"]["State"] == true) then
            ALLERIA_GM_STATE_TEXT:SetText("|cff00FF00GM|r");
        else
            ALLERIA_GM_STATE_TEXT:SetText("|cffFF0000GM|r");
        end;
    
        if(AlleriaCharacter["GM"]["Fly"] == true) then
            ALLERIA_GM_FLY_TEXT:SetText("|cff00FF00GM Fly|r");
            SendCoreMessage("gm fly on");
        else
            ALLERIA_GM_FLY_TEXT:SetText("|cffFF0000GM Fly|r");
            SendCoreMessage("gm fly off");
        end;

        if(AlleriaCharacter["GM"]["Invisible"] == true) then
            ALLERIA_GM_VISIBLE_TEXT:SetText("|cff00FF00Невид.|r");
            SendCoreMessage("gm visible off");
        else
            ALLERIA_GM_VISIBLE_TEXT:SetText("|cffFF0000Невид.|r");
            SendCoreMessage("gm visible on");
        end;

        if(AlleriaCharacter["GM"]["Whispers"] == true) then
            ALLERIA_GM_WHISPERS_TEXT:SetText("|cff00FF00ЛС|r");
            SendCoreMessage("whispers on");
        else
            ALLERIA_GM_WHISPERS_TEXT:SetText("|cffFF0000ЛС|r");
            SendCoreMessage("whispers off");
        end;

    end;
end
function GM:InitializeXML()

    ALLERIA_GM_STATE_ON:SetScript(
        "OnClick",
        function()
            SendCoreMessage("gm on");
            AlleriaCharacter["GM"]["State"] = true;
            ALLERIA_GM_STATE_TEXT:SetText("|cff00FF00GM|r");
        end
    );
    ALLERIA_GM_STATE_OFF:SetScript(
        "OnClick",
        function()
            SendCoreMessage("gm off");
            AlleriaCharacter["GM"]["State"] = false;
            ALLERIA_GM_STATE_TEXT:SetText("|cffFF0000GM|r");
        end
    );
    ALLERIA_GM_STATE_TOGGLE:SetScript(
        "OnClick",
        function()
            if(AlleriaCharacter["GM"]["State"] == true) then
                AlleriaCharacter["GM"]["State"] = false;
                SendCoreMessage("gm off");
                ALLERIA_GM_STATE_TEXT:SetText("|cffFF0000GM|r");
            else
                AlleriaCharacter["GM"]["State"] = true;
                SendCoreMessage("gm on");
                ALLERIA_GM_STATE_TEXT:SetText("|cff00FF00GM|r");
            end;
        end
    );

    ALLERIA_GM_FLY_ON:SetScript(
        "OnClick",
        function()
            SendCoreMessage("gm fly on");
            AlleriaCharacter["GM"]["Fly"] = true;
            ALLERIA_GM_FLY_TEXT:SetText("|cff00FF00GM Fly|r");
        end
    );
    ALLERIA_GM_FLY_OFF:SetScript(
        "OnClick",
        function()
            SendCoreMessage("gm fly off");
            AlleriaCharacter["GM"]["Fly"] = false;
            ALLERIA_GM_FLY_TEXT:SetText("|cffFF0000GM Fly|r");
        end
    );
    ALLERIA_GM_FLY_TOGGLE:SetScript(
        "OnClick",
        function()
            if(AlleriaCharacter["GM"]["Fly"] == true) then
                AlleriaCharacter["GM"]["Fly"] = false;
                SendCoreMessage("gm fly off");
                ALLERIA_GM_FLY_TEXT:SetText("|cffFF0000GM Fly|r");
            else
                AlleriaCharacter["GM"]["Fly"] = true;
                SendCoreMessage("gm fly on");
                ALLERIA_GM_FLY_TEXT:SetText("|cff00FF00GM Fly|r");
            end;
        end
    );

    ALLERIA_GM_VISIBLE_ON:SetScript(
        "OnClick",
        function()
            SendCoreMessage("gm visible off");
            AlleriaCharacter["GM"]["Invisible"] = true;
            ALLERIA_GM_VISIBLE_TEXT:SetText("|cff00FF00Невид.|r");
        end
    );
    ALLERIA_GM_VISIBLE_OFF:SetScript(
        "OnClick",
        function()
            SendCoreMessage("gm visible on");
            AlleriaCharacter["GM"]["Invisible"] = false;
            ALLERIA_GM_VISIBLE_TEXT:SetText("|cffFF0000Невид.|r");
        end
    );
    ALLERIA_GM_VISIBLE_TOGGLE:SetScript(
        "OnClick",
        function()
            if(AlleriaCharacter["GM"]["Invisible"] == true) then
                AlleriaCharacter["GM"]["Invisible"] = false;
                SendCoreMessage("gm visible on");
                ALLERIA_GM_VISIBLE_TEXT:SetText("|cffFF0000Невид.|r");
            else
                AlleriaCharacter["GM"]["Invisible"] = true;
                SendCoreMessage("gm visible off");
                ALLERIA_GM_VISIBLE_TEXT:SetText("|cff00FF00Невид.|r");
            end;
        end
    );

    ALLERIA_GM_WHISPER_ON:SetScript(
        "OnClick",
        function()
            SendCoreMessage("whispers on");
            AlleriaCharacter["GM"]["Whispers"] = true;
            ALLERIA_GM_WHISPERS_TEXT:SetText("|cff00FF00ЛС|r");
        end
    );
    ALLERIA_GM_WHISPER_OFF:SetScript(
        "OnClick",
        function()
            SendCoreMessage("whispers off");
            AlleriaCharacter["GM"]["Whispers"] = false;
            ALLERIA_GM_WHISPERS_TEXT:SetText("|cffFF0000ЛС|r");
        end
    );
    ALLERIA_GM_WHISPER_TOGGLE:SetScript(
        "OnClick",
        function()
            if(AlleriaCharacter["GM"]["Whispers"] == true) then
                AlleriaCharacter["GM"]["Whispers"] = false;
                SendCoreMessage("whispers off");
                ALLERIA_GM_WHISPERS_TEXT:SetText("|cffFF0000ЛС|r");
            else
                AlleriaCharacter["GM"]["Whispers"] = true;
                SendCoreMessage("whispers on");
                ALLERIA_GM_WHISPERS_TEXT:SetText("|cff00FF00ЛС|r");
            end;
        end
    );
    --[[ -------------------------------------------------- ]]--
    --[[ Gobject System ]]--
    --[[ -------------------------------------------------- ]]--
    --[[ALLERIA_GM_GOB_ADD:SetScript(
        "OnClick",
        --function()
            local entry = ALLERIA_GM_GOB_ENTRY:GetText();
            ALLERIA_GM_GOB_ENTRY:SetText("");
            SendCoreMessage("gob add " .. entry);
        end
    );
    ALLERIA_GM_GOB_DEL:SetScript(
        "OnClick",
        function()
            if(GM.GUID["GOB"] == nil) then
                Alleria:error("GUID не было захвачено. Попробуйте `.gob tar`.");
            else
                ALLERIA_GM_GOB_GUID:SetText("");
                SendCoreMessage("gob del " .. GM.GUID["GOB"]);
            end;
            --local entry = ALLERIA_GM_GOB_ENTRY:GetText();
            --SendCoreMessage("gob add " .. entry);
        end
    );]]--
    --[[ -------------------------------------------------- ]]--
    --[[ End of Gobject System ]]--
    --[[ -------------------------------------------------- ]]--
	
end

function GM:CHAT_MSG_SYSTEM(...)
    local message, playerName, languageName, ChannelName,
          playerName2, specialFlags, zoneChannelID, channeIndex,
          channelBaseName, languageID, lineID, guid, bnSenderID, isMobile,
          isSubtitle, hideSenderInLetterbox, supressRaidIcons = ...;
    --print("Triggered", message, "Prefix", playerName, "Line", lineID);
    
    --local start = 
    for index, objectTable in pairs(GM.ServerMask) do
        for objectIndex, objectMask in pairs(objectTable) do
            local findedAt, findedEnd = string.find(message, objectMask);
            --print(objectIndex, findedAt, findedEnd);
            if(findedAt == 1) then
                GM.CurrentObjectType = index;
            end;
        end;
    end;
    if(GM.CurrentObjectType ~= nil) then
        for searchMaskIndex, searchMask in pairs(GM.ServerMask[GM.CurrentObjectType]) do
            for value in string.gmatch(message, searchMask) do
                if(string.find(value, "GUID: ")) then
                    local id = string.gsub(value, "GUID: ", "");
                    GM.GUID[GM.CurrentObjectType] = id;
                end;
            end;
        end;

        local frameName = "ALLERIA_GM_" .. GM.CurrentObjectType .. "_FRAME";
        local guidInput = "ALLERIA_GM_" .. GM.CurrentObjectType .. "_GUID";

        if(_G[frameName]:IsVisible() == false) then
            _G[frameName]:Show();
        end;

        _G[guidInput]:SetText(GM.GUID[GM.CurrentObjectType]);
    end;
    
    --print("GUID", GM.GUID[GM.CurrentObjectType]);
    GM.CurrentObjectType = nil;
end

function GM:CHAT_MSG_ADDON(...)
    local prefix, message = ...;
    --print(prefix, message);
    -- Server Transmition
    if(prefix == "NW") then
        local msg = Explode(":", message);
        if(msg[1] == "SMSG") then
            if(msg[2] == "ANNOUNCE") then

                if(msg[3] == "STARTTRANSMITION") then
                    table.wipe(GM.TransmitionQueue);
                    GM.ProfileTransmition = true;
                end;

                if(msg[3] == "ENDOFTRANSMITION") then
                    GM.TransmitionText = table.concat(GM.TransmitionQueue, " ");
                    _G["Alleria_ProfileForm"]:Show();
                    _G["Alleria_ProfileInfoString"]:SetText(GM.TransmitionText);
                    GM.ProfileTransmition = false;
                end;

                if(msg[3] == "CHUNK") then
                    if(GM.ProfileTransmition == true) then
                        table.insert(GM.TransmitionQueue, msg[4]);
                    end;
                end;
            end;
        end;
    end;
end

return Alleria:InsertModule(GM);