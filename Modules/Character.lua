local Character = {};

Character.name = "Character";
Character.normalName = "Character information getter.";
Character.Events = {
    ["CHAT_MSG_ADDON"] = true,
};
Character.Enabled = true;

Character.Stats = {};
Character.Stats.Health  = {};
Character.Stats.Health.Current = 0;
Character.Stats.Health.DiffVal = 0;
Character.Stats.Health.Value = CharacterStatHealthValue;
Character.Stats.Health.BtnPlus = CharacterStatHealthBtnPlus;
Character.Stats.Health.BtnMinus = CharacterStatHealthBtnMinus;
Character.Stats.Health.Diff = CharacterStatHealthDiff;

Character.Stats.Armor   = {};
Character.Stats.Armor.Current = 0;
Character.Stats.Armor.DiffVal = 0;
Character.Stats.Armor.Value = CharacterStatArmorValue;
Character.Stats.Armor.BtnPlus = CharacterStatArmorBtnPlus;
Character.Stats.Armor.BtnMinus = CharacterStatArmorBtnMinus;
Character.Stats.Armor.Diff = CharacterStatArmorDiff;

Character.Stats.Spirit  = {};
Character.Stats.Spirit.Current = 0;
Character.Stats.Spirit.DiffVal = 0;
Character.Stats.Spirit.Value = CharacterStatSpiritValue;
Character.Stats.Spirit.BtnPlus = CharacterStatSpiritBtnPlus;
Character.Stats.Spirit.BtnMinus = CharacterStatSpiritBtnMinus;
Character.Stats.Spirit.Diff = CharacterStatSpiritDiff;

Character.Stats.Mastery = {};
Character.Stats.Mastery.Current = 0;
Character.Stats.Mastery.DiffVal = 0;
Character.Stats.Mastery.Value = CharacterStatMasteryValue;
Character.Stats.Mastery.BtnPlus = CharacterStatMasteryBtnPlus;
Character.Stats.Mastery.BtnMinus = CharacterStatMasteryBtnMinus;
Character.Stats.Mastery.Diff = CharacterStatMasteryDiff;

Character.Stats.Damage  = {};
Character.Stats.Damage.Current = 0;
Character.Stats.Damage.DiffVal = 0;
Character.Stats.Damage.Value = CharacterStatDamageValue;
Character.Stats.Damage.BtnPlus = CharacterStatDamageBtnPlus;
Character.Stats.Damage.BtnMinus = CharacterStatDamageBtnMinus;
Character.Stats.Damage.Diff = CharacterStatDamageDiff;

Character.Stats.Free = {};
Character.Stats.Free.Current = 0;
Character.Stats.Free.DiffVal = 0;
Character.Stats.Free.Value = CharacterStatFree;
Character.Stats.Free.Cache = 0;
Character.Display = {};
Character.Display.Current = {};
Character.Display.Slots = {
    ["EQUIPMENT_SLOT_HEAD"]         = 0,
    ["EQUIPMENT_SLOT_NECK"]         = 1,
    ["EQUIPMENT_SLOT_SHOULDERS"]    = 2,
    ["EQUIPMENT_SLOT_BODY"]         = 3,
    ["EQUIPMENT_SLOT_CHEST"]        = 4,
    ["EQUIPMENT_SLOT_WAIST"]        = 5,
    ["EQUIPMENT_SLOT_LEGS"]         = 6,
    ["EQUIPMENT_SLOT_FEET"]         = 7,
    ["EQUIPMENT_SLOT_WRISTS"]       = 8,
    ["EQUIPMENT_SLOT_HANDS"]        = 9,
    ["EQUIPMENT_SLOT_FINGER1"]      = 10,
    ["EQUIPMENT_SLOT_FINGER2"]      = 11,
    ["EQUIPMENT_SLOT_TRINKET1"]     = 12,
    ["EQUIPMENT_SLOT_TRINKET2"]     = 13,
    ["EQUIPMENT_SLOT_BACK"]         = 14,
    ["EQUIPMENT_SLOT_MAINHAND"]     = 15,
    ["EQUIPMENT_SLOT_OFFHAND"]      = 16,
    ["EQUIPMENT_SLOT_RANGED"]       = 17,
    ["EQUIPMENT_SLOT_TABARD"]       = 18,
};

function Character:OnInitialize()
    SendCoreMessage("alleria battlesystem info");
    SendCoreMessage("alleria character display");
    Character:InitStatsFrame();
    Character:InitDisplayFrame();
end

function Character:CHAT_MSG_ADDON(...)
    local prefix, msg, type, from, to = ...;
    local array = Explode(":", msg);

    if(prefix == "ALLERIA_CHARACTER") then
    
    end;
    if(prefix == "ALLERIA_DISPLAY") then
        if(array[2] == "CHARACTER") then
            if(tonumber(array[4]) == Character.Display.Slots.EQUIPMENT_SLOT_HEAD) then
                DisplayHeadValue:SetText(array[5]);
                DisplayHeadAppearance:SetText((array[6] or 0));
            end;
            if(tonumber(array[4]) == Character.Display.Slots.EQUIPMENT_SLOT_SHOULDERS)  then
                DisplayShouldersValue:SetText(array[5]);
                DisplayShouldersAppearance:SetText((array[6] or 0));
            end;
            if(tonumber(array[4]) == Character.Display.Slots.EQUIPMENT_SLOT_BODY)       then
                DisplayShirtValue:SetText(array[5]);
                DisplayShirtAppearance:SetText((array[6] or 0));
            end;
            if(tonumber(array[4]) == Character.Display.Slots.EQUIPMENT_SLOT_CHEST)      then
                DisplayChestValue:SetText(array[5]);
                DisplayChestAppearance:SetText((array[6] or 0));
            end;
            if(tonumber(array[4]) == Character.Display.Slots.EQUIPMENT_SLOT_WAIST)      then
                DisplayWaistValue:SetText(array[5]);
                DisplayWaistAppearance:SetText((array[6] or 0));
            end;
            if(tonumber(array[4]) == Character.Display.Slots.EQUIPMENT_SLOT_LEGS)       then
                DisplayLegsValue:SetText(array[5]);
                DisplayLegsAppearance:SetText((array[6] or 0));
            end;
            if(tonumber(array[4]) == Character.Display.Slots.EQUIPMENT_SLOT_FEET)       then
                DisplayFeetValue:SetText(array[5]);
                DisplayFeetAppearance:SetText((array[6] or 0));
            end;
            if(tonumber(array[4]) == Character.Display.Slots.EQUIPMENT_SLOT_WRISTS)     then
                DisplayWristsValue:SetText(array[5]);
                DisplayWristsAppearance:SetText((array[6] or 0));
            end;
            if(tonumber(array[4]) == Character.Display.Slots.EQUIPMENT_SLOT_HANDS)      then
                DisplayHandValue:SetText(array[5]);
                DisplayHandAppearance:SetText((array[6] or 0));
            end;
            if(tonumber(array[4]) == Character.Display.Slots.EQUIPMENT_SLOT_BACK)       then
                DisplayBackValue:SetText(array[5]);
                DisplayBackAppearance:SetText((array[6] or 0));
            end;
            if(tonumber(array[4]) == Character.Display.Slots.EQUIPMENT_SLOT_MAINHAND)   then
                DisplayMainValue:SetText(array[5]);
                DisplayMainAppearance:SetText((array[6] or 0));
            end;
            if(tonumber(array[4]) == Character.Display.Slots.EQUIPMENT_SLOT_OFFHAND)    then
                DisplayOffValue:SetText(array[5]);
                DisplayOffAppearance:SetText((array[6] or 0));
            end;
            if(tonumber(array[4]) == Character.Display.Slots.EQUIPMENT_SLOT_TABARD)     then
                DisplayTabardValue:SetText(array[5]);
                DisplayTabardAppearance:SetText((array[6] or 0));
            end;
        end;
    end;
    if(prefix == "ALLERIA_STATS") then
        --print(msg);
        if(array[3] == "FREE") then
            Character.Stats.Free.Current = tonumber(array[4]);
            Character.Stats.Free.Cache = tonumber(array[4]);
            Character.Stats.Free.Value:SetText(Character.Stats.Free.Current);
        end;
        if(array[3] == "DAMAGE") then
            Character.Stats.Damage.Current = tonumber(array[4]);
            Character.Stats.Damage.Value:SetText(Character.Stats.Damage.Current);
        end;
        if(array[3] == "ARMOR") then
            Character.Stats.Armor.Current = tonumber(array[4]);
            Character.Stats.Armor.Value:SetText(Character.Stats.Armor.Current);
        end;
        if(array[3] == "MASTERY") then
            Character.Stats.Mastery.Current = tonumber(array[4]);
            Character.Stats.Mastery.Value:SetText(Character.Stats.Mastery.Current);
        end;
        if(array[3] == "SPIRIT") then
            Character.Stats.Spirit.Current = tonumber(array[4]);
            Character.Stats.Spirit.Value:SetText(Character.Stats.Spirit.Current);
        end;
        if(array[3] == "HEALTH") then
            Character.Stats.Health.Current = tonumber(array[4]);
            Character.Stats.Health.Value:SetText(Character.Stats.Health.Current);
        end;


    end;
end
function Character:InitStatsFrame()
    Character.Stats.Health.Value:SetText(Character.Stats.Health.Current);
    Character.Stats.Armor.Value:SetText(Character.Stats.Armor.Current);
    Character.Stats.Spirit.Value:SetText(Character.Stats.Spirit.Current);
    Character.Stats.Mastery.Value:SetText(Character.Stats.Mastery.Current);
    Character.Stats.Damage.Value:SetText(Character.Stats.Damage.Current);

    CharacterStatHealthDescription.Name           = "|cff00FF88Здоровье|r";
    CharacterStatHealthDescription.Description    = "За каждый новый уровень вы получаете +4 к здоровью.|nКаждое очко, вложенное в эту характеристику даёт +8 к здоровью.";
    CharacterStatArmorDescription.Name            = "|cff00FF88Защита|r";
    CharacterStatArmorDescription.Description     = "Уменьшает входящий по Вам урон. Если Вы хотите защищать|nВаших союзников - стоит прокачивать эту характеристику + мастерство.";
    CharacterStatSpiritDescription.Name           = "|cff00FF88Дух|r";
    CharacterStatSpiritDescription.Description    = "Усиливает исходящее исцеление.";
    CharacterStatMasteryDescription.Name          = "|cff00FF88Мастерство|r";
    CharacterStatMasteryDescription.Description   = "Усиливает сопротивляемость к атакам других, а также усиливает|nВаш урон по другим существам. Усиливает количество исцеляемого здоровья.";
    CharacterStatDamageDescription.Name           = "|cff00FF88Атака|r";
    CharacterStatDamageDescription.Description    = "Увеличивает Вашу атаку по другим. Если Вы хотите наносить больше урона,|nстоит прокачитвать именно эту характеристику + мастерство.";

    -- -----------------------------------------------------------------------------------
    -- Здоровье
    -- -----------------------------------------------------------------------------------
    Character.Stats.Health.BtnPlus:SetScript(
        "OnClick",  function() Character:StatBtnPlus("Health") end
    );
    Character.Stats.Health.BtnMinus:SetScript(
        "OnClick", function() Character:StatBtnMinus("Health") end
    );

    -- -----------------------------------------------------------------------------------
    -- Броня
    -- -----------------------------------------------------------------------------------
    Character.Stats.Armor.BtnPlus:SetScript(
        "OnClick",  function() Character:StatBtnPlus("Armor") end
    );
    Character.Stats.Armor.BtnMinus:SetScript(
        "OnClick", function() Character:StatBtnMinus("Armor") end
    );

    -- -----------------------------------------------------------------------------------
    -- Дух
    -- -----------------------------------------------------------------------------------
    Character.Stats.Spirit.BtnPlus:SetScript(
        "OnClick",  function() Character:StatBtnPlus("Spirit") end
    );
    Character.Stats.Spirit.BtnMinus:SetScript(
        "OnClick", function() Character:StatBtnMinus("Spirit") end
    );

    -- -----------------------------------------------------------------------------------
    -- Мастерство
    -- -----------------------------------------------------------------------------------
    Character.Stats.Mastery.BtnPlus:SetScript(
        "OnClick",  function() Character:StatBtnPlus("Mastery") end
    );
    Character.Stats.Mastery.BtnMinus:SetScript(
        "OnClick", function() Character:StatBtnMinus("Mastery") end
    );

    -- -----------------------------------------------------------------------------------
    -- Урон/Атака
    -- -----------------------------------------------------------------------------------
    Character.Stats.Damage.BtnPlus:SetScript(
        "OnClick",  function() Character:StatBtnPlus("Damage") end
    );
    Character.Stats.Damage.BtnMinus:SetScript(
        "OnClick", function() Character:StatBtnMinus("Damage") end
    );

end
function Character:StatBtnPlus(stat)
    if(IsShiftKeyDown()) then
        if((Character.Stats.Free.Cache - 5) <= 0) then
            Character.Stats[stat].DiffVal = Character.Stats[stat].DiffVal + Character.Stats.Free.Cache;
            Character.Stats.Free.Cache = 0;
        else
            Character.Stats.Free.Cache = Character.Stats.Free.Cache - 5;
            Character.Stats[stat].DiffVal = Character.Stats[stat].DiffVal + 5;
        end;
    elseif(IsControlKeyDown()) then
        if((Character.Stats.Free.Cache - 10) <= 0) then
            Character.Stats[stat].DiffVal = Character.Stats[stat].DiffVal + Character.Stats.Free.Cache;
            Character.Stats.Free.Cache = 0;
        else
            Character.Stats.Free.Cache = Character.Stats.Free.Cache - 10;
            Character.Stats[stat].DiffVal = Character.Stats[stat].DiffVal + 10;
        end;
    else
        if((Character.Stats.Free.Cache - 1) <= 0) then
            Character.Stats[stat].DiffVal = Character.Stats[stat].DiffVal + Character.Stats.Free.Cache;
            Character.Stats.Free.Cache = 0;
        else
            Character.Stats.Free.Cache = Character.Stats.Free.Cache - 1;
            Character.Stats[stat].DiffVal = Character.Stats[stat].DiffVal + 1;
        end;
    end;
    
    if(Character.Stats[stat].DiffVal >= 1) then
        Character.Stats[stat].Diff:SetText("|cff00FF00+" .. Character.Stats[stat].DiffVal .. "|r");
    elseif(Character.Stats[stat].DiffVal == 0) then
        Character.Stats[stat].Diff:SetText(Character.Stats[stat].DiffVal .. "|r");
    else
        Character.Stats[stat].Diff:SetText("|cffFF0000" .. Character.Stats[stat].DiffVal .. "|r");
    end;
    Character.Stats.Free.Value:SetText(Character.Stats.Free.Cache);
end
function Character:StatBtnMinus(stat)
    if(Character.Stats[stat].DiffVal == 0) then return; end;
    if(IsShiftKeyDown()) then
        if((Character.Stats.Free.Cache + 5) <= Character.Stats.Free.Current) then
            Character.Stats[stat].DiffVal = Character.Stats[stat].DiffVal - 5;
            Character.Stats.Free.Cache = Character.Stats.Free.Cache + 5;
        else
            Character.Stats[stat].DiffVal = Character.Stats.Free.Cache;
            Character.Stats.Free.Cache = 0;
        end;
        
    elseif(IsControlKeyDown()) then
        if((Character.Stats.Free.Cache + 10) <= Character.Stats.Free.Current) then
            Character.Stats[stat].DiffVal = Character.Stats[stat].DiffVal - 10;
            Character.Stats.Free.Cache = Character.Stats.Free.Cache + 10;
        else
            Character.Stats[stat].DiffVal = Character.Stats.Free.Cache;
            Character.Stats.Free.Cache = 0;
        end;
    else
        if((Character.Stats.Free.Cache + 1) <= Character.Stats.Free.Current) then
            Character.Stats[stat].DiffVal = Character.Stats[stat].DiffVal - 1;
            Character.Stats.Free.Cache = Character.Stats.Free.Cache + 1;
        end;
    end;
    if(Character.Stats[stat].DiffVal < 0) then Character.Stats[stat].DiffVal = 0; end;
    if(Character.Stats[stat].DiffVal >= 1) then
        Character.Stats[stat].Diff:SetText("|cff00FF00+" .. Character.Stats[stat].DiffVal .. "|r");
    elseif(Character.Stats[stat].DiffVal == 0) then
        Character.Stats[stat].Diff:SetText(Character.Stats[stat].DiffVal .. "|r");
    else
        Character.Stats[stat].Diff:SetText("|cffFF0000" .. Character.Stats[stat].DiffVal .. "|r");
    end;
    Character.Stats.Free.Value:SetText(Character.Stats.Free.Cache);
end
function Character:StatsLearn()
    SendCoreMessage("alleria battlesystem learn 1 " .. Character.Stats.Damage.DiffVal);
    SendCoreMessage("alleria battlesystem learn 2 " .. Character.Stats.Armor.DiffVal);
    SendCoreMessage("alleria battlesystem learn 3 " .. Character.Stats.Mastery.DiffVal);
    SendCoreMessage("alleria battlesystem learn 4 " .. Character.Stats.Spirit.DiffVal);
    SendCoreMessage("alleria battlesystem learn 5 " .. Character.Stats.Health.DiffVal);

    Character.Stats.Health.DiffVal = 0;
    Character.Stats.Armor.DiffVal = 0;
    Character.Stats.Spirit.DiffVal = 0;
    Character.Stats.Mastery.DiffVal = 0;
    Character.Stats.Damage.DiffVal = 0;

    Character.Stats.Health.Diff:SetText(Character.Stats.Health.DiffVal);
    Character.Stats.Armor.Diff:SetText(Character.Stats.Armor.DiffVal);
    Character.Stats.Spirit.Diff:SetText(Character.Stats.Spirit.DiffVal);
    Character.Stats.Mastery.Diff:SetText(Character.Stats.Mastery.DiffVal);
    Character.Stats.Damage.Diff:SetText(Character.Stats.Damage.DiffVal);
    Character.Stats.Free.Value:SetText(Character.Stats.Free.Current);
end
function Character:StatsCancel()
    Character.Stats.Health.DiffVal = 0;
    Character.Stats.Armor.DiffVal = 0;
    Character.Stats.Spirit.DiffVal = 0;
    Character.Stats.Mastery.DiffVal = 0;
    Character.Stats.Damage.DiffVal = 0;
    Character.Stats.Free.Cache = Character.Stats.Free.Current;

    Character.Stats.Health.Diff:SetText(Character.Stats.Health.DiffVal);
    Character.Stats.Armor.Diff:SetText(Character.Stats.Armor.DiffVal);
    Character.Stats.Spirit.Diff:SetText(Character.Stats.Spirit.DiffVal);
    Character.Stats.Mastery.Diff:SetText(Character.Stats.Mastery.DiffVal);
    Character.Stats.Damage.Diff:SetText(Character.Stats.Damage.DiffVal);
    Character.Stats.Free.Value:SetText(Character.Stats.Free.Current);
end

function Character:ChangeWindow(name)
    local ChildFrames = { AlleriaCharacterFrame:GetChildren() };
    for index, child in pairs(ChildFrames) do
        local childName = child:GetName();
        if(childName ~= "AlleriaCharacterFrameMenu" and childName ~= "AlleriaCharacterFrameClose") then
            child:Hide();
            if(name ~= nil) then
                _G["AlleriaCharacterFrame" .. name]:Show();
            end;
        end;
    end
    
end

function Character:InitDisplayFrame()
    DisplayHeadTitle:SetText("Голова");
    DisplayShouldersTitle:SetText("Плечи");
    DisplayBackTitle:SetText("Плащ");
    DisplayChestTitle:SetText("Грудь");
    DisplayShirtTitle:SetText("Рубашка");
    DisplayTabardTitle:SetText("Накидка");
    DisplayWristsTitle:SetText("Наручи");
    DisplayHandTitle:SetText("Перчатки");
    DisplayWaistTitle:SetText("Пояс");
    DisplayLegsTitle:SetText("Ноги");
    DisplayFeetTitle:SetText("Ботинки");
    DisplayMainTitle:SetText("Правая рука");
    DisplayOffTitle:SetText("Левая рука");
end

function Character:TryDress()
    local headId, headAppearance     = DisplayHeadValue:GetText(),          DisplayHeadAppearance:GetText();
    local shoulId, shoulAppearance   = DisplayShouldersValue:GetText(),     DisplayShouldersAppearance:GetText();
    local backId, backAppearance     = DisplayBackValue:GetText(),          DisplayBackAppearance:GetText();
    local chestId, chestAppearance   = DisplayChestValue:GetText(),         DisplayChestAppearance:GetText();
    local shirtId, shirtAppearance   = DisplayShirtValue:GetText(),         DisplayShirtAppearance:GetText();
    local tabardId, tabardAppearance = DisplayTabardValue:GetText(),        DisplayTabardAppearance:GetText();
    local wristsId, wirstsAppearance = DisplayWristsValue:GetText(),        DisplayWristsAppearance:GetText();
    local handId, handAppearance     = DisplayHandValue:GetText(),          DisplayHandAppearance:GetText();
    local waistId, waistAppearance   = DisplayWaistValue:GetText(),         DisplayWaistAppearance:GetText();
    local legsId, legsAppearance     = DisplayLegsValue:GetText(),          DisplayLegsAppearance:GetText();
    local feetId, feetAppearance     = DisplayFeetValue:GetText(),          DisplayFeetAppearance:GetText();
    local mainId, mainAppearance     = DisplayMainValue:GetText(),          DisplayMainAppearance:GetText();
    local offId, offAppearance       = DisplayOffValue:GetText(),           DisplayOffAppearance:GetText();
    
    local head = Character:ToStringItem(headId, headAppearance);
    local shoul = Character:ToStringItem(shoulId, shoulAppearance);
    local back = Character:ToStringItem(backId, backAppearance);
    local chest = Character:ToStringItem(chestId, chestAppearance);
    local shirt = Character:ToStringItem(shirtId, shirtAppearance);
    local tabard = Character:ToStringItem(tabardId, tabardAppearance);
    local wrists = Character:ToStringItem(wristsId, wirstsAppearance);
    local hand = Character:ToStringItem(handId, handAppearance);
    local waist = Character:ToStringItem(waistId, waistAppearance);
    local legs = Character:ToStringItem(legsId, legsAppearance);
    local feet = Character:ToStringItem(feetId, feetAppearance);
    local main = Character:ToStringItem(mainId, mainAppearance);
    local off = Character:ToStringItem(offId, offAppearance);
    local DisplayMap = { head, shoul, back, chest, shirt, tabard, wrists, hand, waist, legs, feet, main, off };

    for displayMapIndex, displayMapLink in ipairs(DisplayMap) do
        if(displayMapLink ~= nil) then
            DisplayModel:TryOn(displayMapLink);
        end;
        --
    end;
    --
end

function Character:ToStringItem(id, bonus, diff)
    if(id == 0) then
        return nil;
    end;
    local itemStringShort = "item:%d:0";
    local itemStringLong = "item:%d:0::::::::::%d:1:%d";
    local itemStringPattern = "item:(%d+):%d*:%d*:%d*:%d*:%d*:%d*:%d*:%d*:%d*:%d*:(%d*):%d*:([%d:]+)";
	-- itemID, enchantID, instanceDifficulty, numBonusIDs, bonusID1
	if (bonus and bonus ~= 0) or (diff and diff ~= 0) then
		return format(itemStringLong, id, diff or 0, bonus or 0);
	else
		return format(itemStringShort, id);
	end
end

function Character:CreateDisplayMacros()
    local headId, headAppearance     = DisplayHeadValue:GetText(),          DisplayHeadAppearance:GetText();
    local shoulId, shoulAppearance   = DisplayShouldersValue:GetText(),     DisplayShouldersAppearance:GetText();
    local backId, backAppearance     = DisplayBackValue:GetText(),          DisplayBackAppearance:GetText();
    local chestId, chestAppearance   = DisplayChestValue:GetText(),         DisplayChestAppearance:GetText();
    local shirtId, shirtAppearance   = DisplayShirtValue:GetText(),         DisplayShirtAppearance:GetText();
    local tabardId, tabardAppearance = DisplayTabardValue:GetText(),        DisplayTabardAppearance:GetText();
    local wristsId, wirstsAppearance = DisplayWristsValue:GetText(),        DisplayWristsAppearance:GetText();
    local handId, handAppearance     = DisplayHandValue:GetText(),          DisplayHandAppearance:GetText();
    local waistId, waistAppearance   = DisplayWaistValue:GetText(),         DisplayWaistAppearance:GetText();
    local legsId, legsAppearance     = DisplayLegsValue:GetText(),          DisplayLegsAppearance:GetText();
    local feetId, feetAppearance     = DisplayFeetValue:GetText(),          DisplayFeetAppearance:GetText();
    local mainId, mainAppearance     = DisplayMainValue:GetText(),          DisplayMainAppearance:GetText();
    local offId, offAppearance       = DisplayOffValue:GetText(),           DisplayOffAppearance:GetText();
    if(headId == nil or headId == 0 or headId == "") then headId = 0; end;
    if(headAppearance == nil or headAppearance == 0 or headAppearance == "") then headAppearance = 0; end;
    if(shoulId == nil or shoulId == 0 or shoulId == "") then shoulId = 0; end;
    if(shoulAppearance == nil or shoulAppearance == 0 or shoulAppearance == "") then shoulAppearance = 0; end;
    if(backId == nil or backId == 0 or backId == "") then backId = 0; end;
    if(backAppearance == nil or backAppearance == 0 or backAppearance == "") then backAppearance = 0; end;
    if(chestId == nil or chestId == 0 or chestId == "") then chestId = 0; end;
    if(chestAppearance == nil or chestAppearance == 0 or chestAppearance == "") then chestAppearance = 0; end;
    if(shirtId == nil or shirtId == 0 or shirtId == "") then shirtId = 0; end;
    if(shirtAppearance == nil or shirtAppearance == 0 or shirtAppearance == "") then shirtAppearance = 0; end;
    if(tabardId == nil or tabardId == 0 or tabardId == "") then tabardId = 0; end;
    if(tabardAppearance == nil or tabardAppearance == 0 or tabardAppearance == "") then tabardAppearance = 0; end;
    if(wristsId == nil or wristsId == 0 or wristsId == "") then wristsId = 0; end;
    if(wirstsAppearance == nil or wirstsAppearance == 0 or wirstsAppearance == "") then wirstsAppearance = 0; end;
    if(handId == nil or handId == 0 or handId == "") then handId = 0; end;
    if(handAppearance == nil or handAppearance == 0 or handAppearance == "") then handAppearance = 0; end;
    if(waistId == nil or waistId == 0 or waistId == "") then waistId = 0; end;
    if(waistAppearance == nil or waistAppearance == 0 or waistAppearance == "") then waistAppearance = 0; end;
    if(legsId == nil or legsId == 0 or legsId == "") then legsId = 0; end;
    if(legsAppearance == nil or legsAppearance == 0 or legsAppearance == "") then legsAppearance = 0; end;
    if(feetId == nil or feetId == 0 or feetId == "") then feetId = 0; end;
    if(feetAppearance == nil or feetAppearance == 0 or feetAppearance == "") then feetAppearance = 0; end;
    if(mainId == nil or mainId == 0 or mainId == "") then mainId = 0; end;
    if(mainAppearance == nil or mainAppearance == 0 or mainAppearance == "") then mainAppearance = 0; end;
    if(offId == nil or offId == 0 or offId == "") then offId = 0; end;
    if(offAppearance   == nil or offAppearance   == 0 or offAppearance   == "") then offAppearance = 0; end;
    local text = ".disp hea " .. headId .. " " .. headAppearance .. "\n";
    text = text .. ".disp sho " .. shoulId .. " " .. shoulAppearance .. "\n";
    text = text .. ".disp bac " .. backId .. " " .. backAppearance .. "\n";
    text = text .. ".disp che " .. chestId .. " " .. chestAppearance .. "\n";
    text = text .. ".disp shi " .. shirtId .. " " .. shirtAppearance .. "\n";
    text = text .. ".disp tab " .. tabardId .. " " .. tabardAppearance .. "\n";
    text = text .. ".disp wri " .. wristsId .. " " .. wirstsAppearance .. "\n";
    text = text .. ".disp han " .. handId .. " " .. handAppearance .. "\n";
    text = text .. ".disp wai " .. waistId .. " " .. waistAppearance .. "\n";
    text = text .. ".disp leg " .. legsId .. " " .. legsAppearance .. "\n";
    text = text .. ".disp fee " .. feetId .. " " .. feetAppearance .. "\n";
    text = text .. ".disp mai " .. mainId .. " " .. mainAppearance .. "\n";
    text = text .. ".disp off " .. offId .. " " .. offAppearance;

    CharacterDisplayBox:SetText(text);
    DisplayModelMacros:Show();
end
return Alleria:InsertModule(Character);