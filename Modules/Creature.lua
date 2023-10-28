local Creature = {};

Creature.name = "Creature";
Creature.normalName = "Creature information getter";
Creature.Events = {
    ["PLAYER_TARGET_CHANGED"] = true,
    ["CHAT_MSG_ADDON"] = true,
};
Creature.Enabled = true;

Creature.currentGUID = 0;
Creature.oldmodel = 0;
Creature.currentmodel = 0;
Creature.oldfaction = 0;
Creature.currentfaction = 0;
Creature.Emotes = {};
function Creature:OnInitialize()
    for index, value in ipairs(Alleria.Emotes) do
        if( not( string.find(string.lower(value[3]), "пропущено") ) ) then
            table.insert(Creature.Emotes, value);
        end;
    end;

    for ButtonNum = 1, 9 do
        ButtonLink = _G["AlleriaCreatureEmotesButton" .. ButtonNum];
        ButtonLink:SetScript(
            "OnClick", function (self, button, down)
                if(button ~= "RightButton") then
                    SendCoreMessage("npc playemote " .. self.EmoteId);
                else
                    CreaturesEmotesPreview:Show();
                    CreatureEmotesPreviewModel:SetAnimation(self.EmoteNum);
                end;
            end
        );
        ButtonLink:SetScript(
            "OnLeave", function()
                GameTooltip:Hide();
                CreaturesEmotesPreview:Hide();
            end
        );
    end;
end

function Creature:ScrollEmotesList()
    local ButtonNum = 1; -- 1 through 5 of our window to scroll
    local ScrollOffset = 9; -- an index into our data calculated from the scroll offset
    local ScrollElement = _G["AlleriaCreatureEmotesScroll"];
    
    
    FauxScrollFrame_Update(ScrollElement, #Creature.Emotes, 6, 32);
    for ButtonNum = 1, 9 do
        ScrollOffset = ButtonNum + FauxScrollFrame_GetOffset(ScrollElement);
        ButtonLink = _G["AlleriaCreatureEmotesButton" .. ButtonNum];
        if ScrollOffset <= #Creature.Emotes then
            ButtonLink:SetText( Creature.Emotes[ScrollOffset][3]);
            ButtonLink.EmoteNum = Creature.Emotes[ScrollOffset][2];
            ButtonLink.EmoteId = Creature.Emotes[ScrollOffset][1];
            ButtonLink.EmoteDescription = Creature.Emotes[ScrollOffset][4];
            _G["AlleriaCreatureEmotesButton" .. ButtonNum .. "IsFavorite"]:Hide();
            ButtonLink:Show();
        else
            ButtonLink:Hide();
        end;
    end;
end
function Creature:PLAYER_TARGET_CHANGED(...)
    if(UnitIsPlayer("target") == false and UnitPlayerControlled("target") == false) then
        if(IsShiftKeyDown() == true or AlleriaCreatureInfo:IsShown()) then
            SendCoreMessage("alleria creature info");
            CreatureEmotesPreviewModel:SetUnit("target");
        end;
    end;
end
function Creature:CHAT_MSG_ADDON(...)
    local prefix, msg, type, from, to = ...;
    local array = Explode(":", msg);
    if(prefix == "ALLERIA_CREATURE") then
        if(array[2] == "CREATURE") then
            if(array[3] == "NAME") then
                CreatureTargetName:SetText("Имя: " .. array[4]);
            end;
            if(array[3] == "SPAWNID") then
                Creature.currentGUID = array[4];
                CreatureGuid:SetText("GUID: " .. array[4]);
            end;
            if(array[3] == "DISPLAYID") then
                DisplayID:SetText(array[4]);
                Creature.oldmodel = array[4];
                Creature.currentmodel = array[4];
                
            end;
            if(array[3] == "NATIVEID") then
                CreatureTargetNativeID:SetText("NativeID: " .. array[4]);
            end;
            if(array[3] == "ENTRY") then
                CreatureEntry:SetText("Entry: " .. array[4]);
            end;
            if(array[3] == "FACTION") then
                Creature.oldfaction = array[4];
                Creature.currentfaction = array[4];
                FactionID:SetText(array[4]);
            end;
        end;
        if(array[3] == "INFO") then
            if(array[4] == "END") then
                AlleriaCreatureInfo:Show();
            end;
        end;
    end;
end
function Creature:SetNewModel()
    Creature.currentmodel = DisplayID:GetText();
    SendCoreMessage("npc set model " .. Creature.currentmodel);
end
function Creature:RevertNewModel()
    DisplayID:SetText(Creature.oldmodel);
    Creature.currentmodel = Creature.oldmodel;
    SendCoreMessage("npc set model " .. Creature.oldmodel);
end

function Creature:SetNewFaction()
    Creature.currentfaction = FactionID:GetText();
    SendCoreMessage("npc set faction " .. Creature.currentfaction);
end
function Creature:RevertNewFaction()
    FactionID:SetText(Creature.oldfaction);
    Creature.currentfaction = Creature.oldfaction;
    SendCoreMessage("npc set faction " .. Creature.currentfaction);
end
return Alleria:InsertModule(Creature);