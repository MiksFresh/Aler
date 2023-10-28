local Economics = {};

Economics.name = "Economics";
Economics.normalName = "Economics";
Economics.Events = {
    ["PLAYER_ENTERING_WORLD"] = true,
    ["CHAT_MSG_ADDON"] = true,
};
Economics.Initialized = false;
Economics.Enabled = true;
Economics.EconomicsUI = false;
Economics.HBD = Alleria.HBD;
Economics.HBDPins = Alleria.HBD.Pins;
Economics.SelectedID = 0;
Economics.MustShowUI = false;
Economics.Cache = {};
--[[
    Economics.WorldPins[1]                        = {};
    Economics.WorldPins[1].Frame                  = {};
    Economics.WorldPins[1].Frame.Tooltip          = {};
    Economics.WorldPins[1].Frame.Tooltip.name     = {};
    Economics.WorldPins[1].Frame.Tooltip.desc     = {};
    Economics.WorldPins[1].Frame.Tooltip.creature = {};
    Economics.WorldPins[1].Frame.Tooltip.level    = {};
    Economics.WorldPins[1].Frame.Tooltip.owner    = {};
]]--
Economics.WorldPins = {};
--[[
    Economics.MapPins[1]                        = {};
    Economics.MapPins[1].Frame                  = {};
    Economics.MapPins[1].Frame.Tooltip          = {};
    Economics.MapPins[1].Frame.Tooltip.name     = {};
    Economics.MapPins[1].Frame.Tooltip.creature = {};
    Economics.MapPins[1].Frame.Tooltip.level    = {};
    Economics.MapPins[1].Frame.Tooltip.owner    = {};
]]--
Economics.MapPins = {};

Economics.IsTrasnimiting = false;
Economics.POI                 = {};
Economics.POI.ID              = 0;
Economics.POI.Icon            = 0;
Economics.POI.Name            = nil;
Economics.POI.X               = 0;
Economics.POI.Y               = 0;
Economics.POI.M               = 0;
Economics.POI.Description     = nil;
Economics.POI.Creatures       = 0;
Economics.POI.Level           = 1;
Economics.POI.Owner           = "NightWatch";
function Economics:OnInitialize()
    Economics:ScrollPOIIcons();
end
function Economics:Print(...)
    print("|cffFFFFFF[|rAlleria.Economics|cffFFFFFF]:|r", ...);
end
function Economics:GetWorldPOI(id)
    if(Economics.WorldPins[id] ~= nil) then
        return Economics.WorldPins[id];
    end;

    local frame = CreateFrame("Button", "AlleriaWorldPoi" .. id, WorldMapButton, "AlleriaPOITemplate");
    local frameTooltip = _G["AlleriaWorldPoi" .. id .. "Tooltip"];
    return frame, frameTooltip;
end
function Economics:GetMapPOI(id)
    if(Economics.MapPins[id] ~= nil) then
        return Economics.MapPins[id];
    end;

    local frame = CreateFrame("Button", "AlleriaMiniPoi" .. id, WorldMapButton, "AlleriaPOIMiniTemplate");
    local frameTooltip = _G["AlleriaMiniPoi" .. id .. "Tooltip"];
    return frame, frameTooltip;
end
function Economics:ProcessPOI()
    local poiID = tonumber(Economics.POI.ID);
    local poiIcon = Economics.POI.Icon;
    local poiName = Economics.POI.Name;
    local poiX = tonumber(Economics.POI.X);
    local poiY = tonumber(Economics.POI.Y);
    local poiM = tonumber(Economics.POI.M);
    local poiDescription = Economics.POI.Description;
    local poiCreatures = Economics.POI.Creatures;
    local poiLevel = Economics.POI.Level;
    local poiOwner = Economics.POI.Owner;
    local cache = {
        poiID,                                    -- 1    ? Index in DB
        poiIcon,                                  -- 2    ? Icon Index from poi.lua
        poiName or "Untitled",                    -- 3    ? name of poi
        poiX,                                     -- 4    ? x
        poiY,                                     -- 5    ? y
        poiM,                                     -- 6    ? MapID
        poiDescription or "No description",       -- 7    ? description
        poiCreatures,                             -- 8    ? Num of creatures
        poiLevel,                                 -- 9    ? Level
        poiOwner,                                 -- 10   ? name of owner
    };
    table.insert(Economics.Cache, cache);
    local WorldPin, WorldPinTooltip = Economics:GetWorldPOI(poiID);
    local MapPin, MapPinTooltip = Economics:GetMapPOI(poiID);

    if(poiIcon > 0) then
        _G[WorldPin:GetName() .. "Texture"]:SetAtlas(Alleria.POI[poiIcon]);
    end;
    WorldPinTooltip.name = poiName;
    WorldPinTooltip.desc = poiDescription;
    WorldPinTooltip.creatures = "Количество существ: |cff00FF88" .. poiCreatures .. "|r";
    WorldPinTooltip.level = "Уровень: |cff00FF88" .. poiLevel .. "|r";
    WorldPinTooltip.owner = "Владелец: |cffFF8800" .. poiOwner .. "|r";

    if(poiIcon > 0) then
        _G[MapPin:GetName() .. "Texture"]:SetAtlas(Alleria.POI[poiIcon]);
    end;
    MapPinTooltip.name = poiName;
    MapPinTooltip.desc = poiDescription;
    MapPinTooltip.creatures = "Количество существ: |cff00FF88" .. poiCreatures .. "|r";
    MapPinTooltip.level = "Уровень: |cff00FF88" .. poiLevel .. "|r";
    MapPinTooltip.owner = "Владелец: |cffFF8800" .. poiOwner .. "|r";

    Alleria.HBD.Pins:AddWorldMapIconWorld(Alleria, WorldPin, tonumber(poiM), tonumber(poiY), tonumber(poiX));
    Alleria.HBD.Pins:AddMinimapIconWorld(Alleria, MapPin, tonumber(poiM), tonumber(poiY), tonumber(poiX));
end
function Economics:PLAYER_ENTERING_WORLD()
    -- ? Preventing multi sending command for load data from server
    if(Economics.Initialized == false) then
        
        SendCoreMessage("alleria economics");
        SendCoreMessage("alleria economics poi load");
        Economics.Initialized = true;
    end;
end
function Economics:UpdateName(id, name)
    local WorldPin, WorldPinTooltip = Economics:GetWorldPOI(id);
    local MapPin, MapPinTooltip = Economics:GetMapPOI(id);
    WorldPinTooltip.name = name;
    MapPinTooltip.name = name;
    for index, data in ipairs(Economics.Cache) do
        if(tonumber(id) == data[1]) then
            Economics.Cache[index][3] = name;
        end;
    end;
    Economics:ScrollPOI();
end
function Economics:UpdateDesc(id, desc)
    local WorldPin, WorldPinTooltip = Economics:GetWorldPOI(id);
    local MapPin, MapPinTooltip = Economics:GetMapPOI(id);
    WorldPinTooltip.desc = desc;
    MapPinTooltip.desc = desc;
    for index, data in ipairs(Economics.Cache) do
        if(tonumber(id) == data[1]) then
            Economics.Cache[index][7] = desc;
        end;
    end;
    Economics:ScrollPOI();
end
function Economics:UpdateIcon(id, icon)
    local WorldPin, WorldPinTooltip = Economics:GetWorldPOI(id);
    local MapPin, MapPinTooltip = Economics:GetMapPOI(id);
    icon = tonumber(icon);
    _G[WorldPin:GetName() .. "Texture"]:SetAtlas(Alleria.POI[icon]);
    _G[MapPin:GetName() .. "Texture"]:SetAtlas(Alleria.POI[icon]);
    for index, data in ipairs(Economics.Cache) do
        if(tonumber(id) == data[1]) then
            Economics.Cache[index][2] = icon;
        end;
    end;
    Economics:ScrollPOI();
end
function Economics:UpdateCreatures(id, creatures)
    local WorldPin, WorldPinTooltip = Economics:GetWorldPOI(id);
    local MapPin, MapPinTooltip = Economics:GetMapPOI(id);
    creatures = tonumber(creatures);
    WorldPinTooltip.creatures = "Существа: |cffFF8800" .. creatures .. "|r";
    MapPinTooltip.creatures = "Существа: |cffFF8800" .. creatures .. "|r";
    for index, data in ipairs(Economics.Cache) do
        if(tonumber(id) == data[1]) then
            Economics.Cache[index][10] = creatures;
        end;
    end;
    Economics:ScrollPOI();
end
function Economics:UpdateLevel(id, level)
    local WorldPin, WorldPinTooltip = Economics:GetWorldPOI(id);
    local MapPin, MapPinTooltip = Economics:GetMapPOI(id);
    WorldPinTooltip.level = "Уровень: |cff00FF88" .. level .. "|r";
    MapPinTooltip.level = "Уровень: |cff00FF88" .. level .. "|r";
    level = tonumber(level);
    for index, data in ipairs(Economics.Cache) do
        if(tonumber(id) == data[1]) then
            Economics.Cache[index][9] = level;
        end;
    end;
    Economics:ScrollPOI();
end
function Economics:UpdateOwner(id, owner)
    local WorldPin, WorldPinTooltip = Economics:GetWorldPOI(id);
    local MapPin, MapPinTooltip = Economics:GetMapPOI(id);
    WorldPinTooltip.owner = "Владелец: |cffFF8800" .. owner .. "|r";
    MapPinTooltip.owner = "Владелец: |cffFF8800" .. owner .. "|r";
    for index, data in ipairs(Economics.Cache) do
        if(tonumber(id) == data[1]) then
            Economics.Cache[index][10] = owner;
        end;
    end;
    Economics:ScrollPOI();
end
function Economics:CHAT_MSG_ADDON(...)
    local prefix, msg, type, from, to = ...;
    local array = Explode(":", msg);
    if(array[2] == "ECONOMICS") then
        if(array[3] == "UI") then
            if(array[4] == "ACTIVATE") then
                Economics.EconomicsUI = true;
                EconomicsMenuButton:Show();
            end;
        end;
    end;
    if(prefix == "ALLERIA_ECONOMICS") then
        
        if(array[4] == "TRANSMITION") then
            if(array[5] == "START") then
                Economics.IsTrasnimiting = true;
            end;
            if(array[5] == "END") then
                Economics:ProcessPOI();
                Economics.IsTrasnimiting = false;
                Economics.POI                 = {};
                Economics.POI.ID              = 0;
                Economics.POI.Icon            = 0;
                Economics.POI.Name            = nil;
                Economics.POI.X               = 0;
                Economics.POI.Y               = 0;
                Economics.POI.M               = 0;
                Economics.POI.Description     = nil;
                Economics.POI.Creatures       = 0;
                Economics.POI.Level           = 1;
                Economics.POI.Owner           = "NightWatch";
            end;
        end;
        if(Economics.IsTrasnimiting == true) then
            if(array[4] == "ID") then
                Economics.POI.ID = array[5];
            end;
            if(array[4] == "ICON") then
                Economics.POI.Icon = tonumber(array[5]);
            end;
            if(array[4] == "NAME") then
                Economics.POI.Name = array[5];
            end;
            if(array[4] == "X") then
                Economics.POI.X = array[5];
            end;
            if(array[4] == "Y") then
                Economics.POI.Y = array[5];
            end;
            if(array[4] == "M") then
                Economics.POI.M = array[5];
            end;
            if(array[4] == "DESC") then
                Economics.POI.Description = array[5];
            end;
            if(array[4] == "CREATURES") then
                Economics.POI.Creatures = array[5];
            end;
            if(array[4] == "LEVEL") then
                Economics.POI.Level = array[5];
            end;
            if(array[4] == "OWNER") then
                Economics.POI.Owner = array[5];
            end;
        end;
        if(array[4] == "NEW") then
            if(array[5] == "ID") then
                Economics.IsTrasnimiting = true;
                Economics.POI.ID              = array[6];
                if(array[7] == UnitName("player")) then
                    Economics.MustShowUI = true;
                    Economics.SelectedID = array[6]
                end;
            end;
            if(array[5] == "X" and Economics.IsTrasnimiting == true) then
                Economics.POI.X               = array[6];
            end;
            if(array[5] == "Y" and Economics.IsTrasnimiting == true) then
                Economics.POI.Y               = array[6];
            end;
            if(array[5] == "M" and Economics.IsTrasnimiting == true) then
                Economics.POI.M               = array[6];
                Economics:ProcessPOI();
                Economics:ScrollPOIIcons();
                Economics.IsTrasnimiting = false;

                if(Economics.MustShowUI == true) then
                    AlleriaEconomicsFrame:Show();
                    Economics:Print("|cff00FF00Добавлена новая точка интереса с номером", Economics.SelectedID, ", открываю интерфейс для дальнейшей работы с ней...|r");
                    Economics.MustShowUI = false;
                end;

                Economics.POI                 = {};
                Economics.POI.ID              = 0;
                Economics.POI.Icon            = 0;
                Economics.POI.Name            = nil;
                Economics.POI.X               = 0;
                Economics.POI.Y               = 0;
                Economics.POI.M               = 0;
                Economics.POI.Description     = nil;
                Economics.POI.Creatures       = 0;
                Economics.POI.Level           = 1;
                Economics.POI.Owner           = "NightWatch";
            end;
        end;
        if(array[4] == "UPDATE") then
            if(array[5] == "NAME") then
                --print("Updaeting", array[6], array[7]);
                Economics:UpdateName(array[6], array[7]);
            end;
            if(array[5] == "DESC") then
                --print("Updaeting", array[6], array[7]);
                Economics:UpdateDesc(array[6], array[7]);
            end;
            if(array[5] == "ICON") then
                --print("Updaeting", array[6], array[7]);
                Economics:UpdateIcon(array[6], array[7]);
            end;
            if(array[5] == "CREATURES") then
                --print("Updaeting", array[6], array[7]);
                Economics:UpdateCreatures(array[6], array[7]);
            end;
            if(array[5] == "LEVEL") then
                --print("Updaeting", array[6], array[7]);
                Economics:UpdateLevel(array[6], array[7]);
            end;
            if(array[5] == "OWNER") then
                --print("Updaeting", array[6], array[7]);
                Economics:UpdateOwner(array[6], array[7]);
            end;
        end;
    end;
end

function Economics:ScrollPOI()
    local ButtonNum = 1; -- 1 through 5 of our window to scroll
    local ScrollOffset = 9; -- an index into our data calculated from the scroll offset
    local ScrollElement = _G["POIListScroll"];
    
    
    FauxScrollFrame_Update(ScrollElement, #Economics.Cache, 8, 32);
    for ButtonNum = 1, 9 do
        ScrollOffset = ButtonNum + FauxScrollFrame_GetOffset(ScrollElement);
        ButtonLink = _G["POIListButton" .. ButtonNum];
        if ScrollOffset <= #Economics.Cache then
            ButtonLink:SetText("Точка интереса №" .. Economics.Cache[ScrollOffset][1]);
            ButtonLink.cacheID        = ScrollOffset;
            ButtonLink.poiID          = Economics.Cache[ScrollOffset][1];
            ButtonLink.poiName        = Economics.Cache[ScrollOffset][3];
            ButtonLink.poiDescription = Economics.Cache[ScrollOffset][7];
            _G["POIListButton" .. ButtonNum .. "Icon"]:SetAtlas(Alleria.POI[Economics.Cache[ScrollOffset][2]]);
            ButtonLink:Show();
        else
            ButtonLink.name = false;
            ButtonLink.description = false;
            ButtonLink:Hide();
        end;
    end;
end
function Economics:SelectPOI(id)
    -- ? ID User as Index of Cache
    EconomicsUIPOIName:SetText(Economics.Cache[id][3]);
    EconomicsUIDescription:SetText(Economics.Cache[id][7]);
    EconomicsUIPOILevel:SetText(Economics.Cache[id][9]);
    EconomicsUIPOICreatures:SetText(Economics.Cache[id][8]);
    EconomicsUIPOIOwner:SetText(Economics.Cache[id][10]);

    Economics.SelectedID = Economics.Cache[id][1];
end
function Economics:ResetPOI()
    -- ? ID User as Index of Cache
    EconomicsUIPOIName:SetText("");
    EconomicsUIDescription:SetText("");
    EconomicsUIPOILevel:SetText("");
    EconomicsUIPOICreatures:SetText("");
    EconomicsUIPOIOwner:SetText("");

    Economics.SelectedID = 0;
end
function Economics:UpdatePOI()
    if(Economics.SelectedID == 0) then
        SendCoreMessage("alleria economics poi add");
    else
        local name          = EconomicsUIPOIName:GetText();
        local desc          = EconomicsUIDescription:GetText();
        local level         = EconomicsUIPOILevel:GetText();
        local creatures     = EconomicsUIPOICreatures:GetText();
        local owner         = EconomicsUIPOIOwner:GetText();

        SendCoreMessage('alleria economics poi edit name '      .. Economics.SelectedID .. ' "' .. name .. '"');
        SendCoreMessage('alleria economics poi edit desc '      .. Economics.SelectedID .. ' "' .. desc .. '"')
        SendCoreMessage('alleria economics poi edit level '     .. Economics.SelectedID .. ' '  .. level);
        SendCoreMessage('alleria economics poi edit creatures ' .. Economics.SelectedID .. ' '  .. creatures);
        SendCoreMessage('alleria economics poi edit owner '     .. Economics.SelectedID .. ' "' .. owner .. '"');
    end;
    
end
function Economics:UpdateCPOIIcon(id)
    if(id <= 0 and Economics.SelectedID > 0) then return; end;
    SendCoreMessage('alleria economics poi edit icon '     .. Economics.SelectedID .. ' ' .. id);
end
function Economics:ScrollPOIIcons()
    local ButtonNum = 1; -- 1 through 5 of our window to scroll
    local ScrollOffset = 9; -- an index into our data calculated from the scroll offset
    local ScrollElement = _G["POIIconListScroll"];
    
    
    FauxScrollFrame_Update(ScrollElement, #Alleria.POI, 9, 32);
    for ButtonNum = 1, 9 do
        ScrollOffset = ButtonNum + FauxScrollFrame_GetOffset(ScrollElement);
        ButtonLink = _G["POIIconListButton" .. ButtonNum];
        if ScrollOffset <= #Alleria.POI then
            ButtonLink.IconID = ScrollOffset;
            ButtonLink:SetText("Иконка #" .. ScrollOffset);
            _G["POIIconListButton" .. ButtonNum .. "Icon"]:SetAtlas(Alleria.POI[ScrollOffset]);
            _G["POIIconListButton" .. ButtonNum .. "Icon"]:SetAtlas(Alleria.POI[ScrollOffset]);
            ButtonLink:Show();
        else
            ButtonLink.IconID = 0;
            ButtonLink:Hide();
        end;
    end;
end

return Alleria:InsertModule(Economics);