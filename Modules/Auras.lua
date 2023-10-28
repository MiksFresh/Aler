local Auras = {};

Auras.name = "Auras";
Auras.normalName = "Auras Module";
Auras.Enabled = true;
Auras.IsInitialized = false;
Auras.Events = {
    ["PLAYER_ENTERING_WORLD"] = true,
    ["CHAT_MSG_ADDON"] = true,
};
Auras.CurrentCategory = 0;
function Auras.OnInitialize()
    if(AlleriaGlobal.Auras == nil) then
        AlleriaGlobal.Auras = {};
    end;
    Auras:InitCategoryButtons();
    Auras:InitAurasButtons();
end
function Auras:PLAYER_ENTERING_WORLD()
    if(Auras.IsInitialized == false) then
        if(#AlleriaGlobal.Auras == 0) then
            SendCoreMessage("rps load auras");
        end;
        
        Auras.IsInitialized = true;
    end;
end
function Auras:CHAT_MSG_ADDON(...)
    local prefix, msg, t, from, to = ...;
    local array = Explode(":", msg);
    if(prefix == "NW.AURA") then
        Category = Explode(",", tostring(array[6]));
        if(type(Category) == "table") then
            for Num, Array in ipairs(Category) do
                CatNum = tonumber(Category);
                CatENum = Alleria.AurasDatasheetEnum[CatNum];
                
                if(not(AlleriaGlobal.Auras[CatENum])) then
                    if(CatENum ~= nil) then
                        AlleriaGlobal.Auras[CatENum] = {};
                    end;
                end;
                if(AlleriaGlobal.Auras[CatENum] ~= nil) then
                    AuraCount = #AlleriaGlobal.Auras[CatENum];
                    AlleriaGlobal.Auras[CatENum][(AuraCount + 1)] = { array[4], array[5] };
                end;
            end;
        else
            CatNum = tonumber(Category);
            CatENum = Alleria.AurasDatasheetEnum[CatNum];
            if(not(AlleriaGlobal.Auras[CatENum])) then
                if(CatENum ~= nil) then
                    AlleriaGlobal.Auras[CatENum] = {};
                end;
            end;
            if(AlleriaGlobal.Auras[CatENum] ~= nil) then
                AuraCount = #AlleriaGlobal.Auras[CatENum];
                AlleriaGlobal.Auras[CatENum][(AuraCount + 1)] = { array[4], array[5] };
            end;
        end;
    end;
end
function Auras:Debug()
    for index, value in ipairs(AlleriaGlobal.Auras) do
        print(index .. " - " .. Alleria.AurasCategoriesNames[index][1]);
        --for id, name in ipairs(value) do
        --    print(id .. " - " .. name[1] .. " - " .. name[2]);
        --end;
    end;
end
function Auras:InitCategoryButtons()
    for ButtonNum = 1, 9 do
        ButtonLink = _G["AlleriaAurasCategoryButton" .. ButtonNum];
        ButtonLink.CategoryNum = 0;
        ButtonLink:SetScript(
            "OnClick", function(self)
                if(self.CategoryNum > 0) then
                    Auras.CurrentCategory = AlleriaGlobal.Auras[self.CategoryNum];
                    Auras:ScrollAuras();
                    AlleriaAurasSubFrame:Show();
                end;
            end
        );
    end;
end
function Auras:ScrollCategoryList()
    --if(Emotes.NowSearch == true) then Emotes:ScrollSearchResult(); return; end;
    --if(AlleriaCharacter.OnlyFavorite == true) then Emotes:ScrollFavoriteEmotsList(); return; end;
    local ButtonNum = 1; -- 1 through 5 of our window to scroll
    local ScrollOffset = 9; -- an index into our data calculated from the scroll offset
    local ScrollElement = _G["AlleriaAurasFrameScroll"];
    
    
    FauxScrollFrame_Update(ScrollElement, #AlleriaGlobal.Auras, 6, 32);
    for ButtonNum = 1, 9 do
        ScrollOffset = ButtonNum + FauxScrollFrame_GetOffset(ScrollElement);
        ButtonLink = _G["AlleriaAurasCategoryButton" .. ButtonNum];
        if ScrollOffset <= #AlleriaGlobal.Auras then
            ButtonLink.CategoryNum = ScrollOffset;
            ButtonLink:SetText( Alleria.AurasCategoriesNames[ScrollOffset][1] );
            --ButtonLink.EmoteNum = Alleria.Emotes[ScrollOffset][2];
            --ButtonLink.EmoteId = Alleria.Emotes[ScrollOffset][1];
            --ButtonLink.EmoteDescription = Alleria.Emotes[ScrollOffset][4];
            --_G["AlleriaEmotesButton" .. ButtonNum .. "IsFavorite"].LocalID = ScrollOffset;
            ButtonLink:Show();
        else
            ButtonLink.CategoryNum = 0;
            ButtonLink:Hide();
        end;
    end;
end
function Auras:InitAurasButtons()
    for ButtonNum = 1, 9 do
        ButtonLink = _G["AlleriaAuraButton" .. ButtonNum];
        ButtonLink.SpellID = 0;
        ButtonLink:SetScript(
            "OnClick", function(self)
                if(self.SpellID > 0) then
                    SendCoreMessage("rps aura " .. self.SpellID);
                    --Auras.CurrentCategory = self.CategoryNum;
                    --AlleriaAurasSubFrame:Show();
                end;
            end
        );
    end;
end
function Auras:ScrollAuras()
    local ButtonNum = 1; -- 1 through 5 of our window to scroll
    local ScrollOffset = 9; -- an index into our data calculated from the scroll offset
    local ScrollElement = _G["AlleriaAurasSubFrameScroll"];
    
    
    FauxScrollFrame_Update(ScrollElement, #Auras.CurrentCategory, 6, 32);
    for ButtonNum = 1, 9 do
        ScrollOffset = ButtonNum + FauxScrollFrame_GetOffset(ScrollElement);
        ButtonLink = _G["AlleriaAuraButton" .. ButtonNum];
        if ScrollOffset <= #Auras.CurrentCategory then
            ButtonLink.SpellID = tonumber(Auras.CurrentCategory[ScrollOffset][1]);
            ButtonLink:SetText( Auras.CurrentCategory[ScrollOffset][2] );
            --ButtonLink.EmoteNum = Alleria.Emotes[ScrollOffset][2];
            --ButtonLink.EmoteId = Alleria.Emotes[ScrollOffset][1];
            --ButtonLink.EmoteDescription = Alleria.Emotes[ScrollOffset][4];
            --_G["AlleriaEmotesButton" .. ButtonNum .. "IsFavorite"].LocalID = ScrollOffset;
            ButtonLink:Show();
        else
            ButtonLink.SpellID = 0;
            ButtonLink:Hide();
        end;
    end;
end
return Alleria:InsertModule(Auras);