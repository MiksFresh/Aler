local UI = {};

UI.name = "UI";
UI.normalName = "UI UI Worker";
UI.Events = {
};
UI.Enabled = true;
function UI:OnInitialize()
    print("[Alleria System]: Для открытия меню быстрого доступа, удерживайте клавишу CTRL.");
    print("[Alleria System]: For open fast-access menu, hold CTRL button.");
    UIParent:SetScript(
        "OnUpdate",
        function(...)
            -- MainMenuBarArtFrame
            
            if(IsControlKeyDown()) then
                if(AlleriaOptionsFrame:IsVisible() == false) then
                    -- В случае, если какое-либо из окон уже открыто - не показываем меню.
                    if(
                        AlleriaCharacterFrame:IsVisible()
                       --or AlleriaEconomicsFrame:IsVisible()
                    ) then
                    else
                        AlleriaOptionsFrame:Show();
                    end;
                end;
                
            else
                if(AlleriaOptionsFrame:IsVisible() == true) then
                    AlleriaOptionsFrame:Hide();
                    AlleriaOptionsSubFrame:Hide();
                end;
                local scale, x, y = AlleriaOptionsFrame:GetEffectiveScale(),GetCursorPosition();
                AlleriaOptionsFrame:SetPoint("CENTER", nil, "BOTTOMLEFT", x/scale, y/scale);
            end;
        end
    );

    CharacterName:SetText(UnitName("player"));
    CharacterInfo:SetText(UnitRace("player") .. ", " .. UnitLevel("player") .. " уровень");
    local faction = UnitFactionGroup("player");
    if(faction == "Horde") then
        CharacterTeamHorde:Show();
    else
        CharacterTeamAlliance:Show();
    end

    CharacterStatHealthIcon:SetTexture("Interface\\Icons\\petbattle_health");
    CharacterStatArmorIcon:SetTexture("Interface\\Icons\\spell_nature_enchantarmor");
    CharacterStatSpiritIcon:SetTexture("Interface\\Icons\\spell_holy_holyprotection");
    CharacterStatMasteryIcon:SetTexture("Interface\\Icons\\spell_arcane_mindmastery");
    CharacterStatDamageIcon:SetTexture("Interface\\Icons\\Ability_warrior_strengthofarms");

    CharacterStatHealthName:SetText("Здоровье");
    CharacterStatArmorName:SetText("Броня");
    CharacterStatSpiritName:SetText("Дух");
    CharacterStatMasteryName:SetText("Мастерство");
    CharacterStatDamageName:SetText("Атака");
end
function UI:PLAYER_TARGET_CHANGED(...)
    --if(UnitIsPlayer("target") == false and UnitPlayerControlled("target") == false) then
    --    if(IsControlKeyDown() == true and UnitName("target") ~= nil) then
    --        SendCoreMessage("alleria info npc");
    --    end;
    --end;
end
return Alleria:InsertModule(UI);