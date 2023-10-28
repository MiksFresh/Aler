local Emotes = {};

Emotes.name = "Emotes";
Emotes.normalName = "Emotes Module";
Emotes.Enabled = true;
Emotes.Cache = {};
Emotes.Stock = {};
Emotes.NowSearch = false;
function Emotes.OnInitialize()
    if(AlleriaCharacter.Emotes == nil) then
        AlleriaCharacter.Emotes = {};
        for index, value in ipairs(Alleria.Emotes) do
            AlleriaCharacter.Emotes[index] = false;
        end;
        AlleriaCharacter.OnlyFavorite = false;
    end;
    if(AlleriaCharacter.OnlyFavorite == true) then
        AlleriaEmotesFrameOnlyFavorite:SetChecked(true);
    end;
    for index, value in ipairs(Alleria.Emotes) do
        if(value[5] == nil or not(string.find(string.lower(value[3]), "пропущено"))) then
            table.insert(Emotes.Stock, value);
        end;
    end
end
function Emotes:ScrollEmotesList()
    if(Emotes.NowSearch == true) then Emotes:ScrollSearchResult(); return; end;
    if(AlleriaCharacter.OnlyFavorite == true) then Emotes:ScrollFavoriteEmotsList(); return; end;
    local ButtonNum = 1; -- 1 through 5 of our window to scroll
    local ScrollOffset = 9; -- an index into our data calculated from the scroll offset
    local ScrollElement = _G["AlleriaEmotesFrameScroll"];
    
    
    FauxScrollFrame_Update(ScrollElement, #Emotes.Stock, 6, 32);
    for ButtonNum = 1, 9 do
        ScrollOffset = ButtonNum + FauxScrollFrame_GetOffset(ScrollElement);
        ButtonLink = _G["AlleriaEmotesButton" .. ButtonNum];
        if ScrollOffset <= #Emotes.Stock then
            ButtonLink:SetText( Alleria.Emotes[ScrollOffset][3]);
            ButtonLink.EmoteNum = Alleria.Emotes[ScrollOffset][2];
            ButtonLink.EmoteId = Alleria.Emotes[ScrollOffset][1];
            ButtonLink.EmoteDescription = Alleria.Emotes[ScrollOffset][4];
            _G["AlleriaEmotesButton" .. ButtonNum .. "IsFavorite"].LocalID = ScrollOffset;
            if(AlleriaCharacter.Emotes[ScrollOffset] == true) then
                _G["AlleriaEmotesButton" .. ButtonNum .. "IsFavoriteTexture"]:Show();
            else
                _G["AlleriaEmotesButton" .. ButtonNum .. "IsFavoriteTexture"]:Hide();
            end;
            ButtonLink:Show();
        else
            ButtonLink:Hide();
        end;
    end;
end
function Emotes:ScrollFavoriteEmotsList()
    local ButtonNum = 1; -- 1 through 5 of our window to scroll
    local ScrollOffset = 9; -- an index into our data calculated from the scroll offset
    local ScrollElement = _G["AlleriaEmotesFrameScroll"];
    Emotes.Cache = {};
    for index, value in ipairs(Emotes.Stock) do
        if(AlleriaCharacter.Emotes[index] == true) then
            local tempArray = Alleria.Emotes[index];
            table.insert(tempArray, index);
            table.insert(tempArray, true);
            table.insert(Emotes.Cache, tempArray);
        end;
    end
    FauxScrollFrame_Update(ScrollElement, #Emotes.Cache, 6, 32);
    for ButtonNum = 1, 9 do
        ScrollOffset = ButtonNum + FauxScrollFrame_GetOffset(ScrollElement);
        ButtonLink = _G["AlleriaEmotesButton" .. ButtonNum];
        if ScrollOffset <= #Emotes.Cache then
            ButtonLink:SetText(Emotes.Cache[ScrollOffset][3]);
            ButtonLink.EmoteNum = Emotes.Cache[ScrollOffset][2];
            ButtonLink.EmoteId = Emotes.Cache[ScrollOffset][1];
            ButtonLink.EmoteDescription = Emotes.Cache[ScrollOffset][4];
            _G["AlleriaEmotesButton" .. ButtonNum .. "IsFavorite"].LocalID = Emotes.Cache[ScrollOffset][5];
            _G["AlleriaEmotesButton" .. ButtonNum .. "IsFavoriteTexture"]:Show();
            ButtonLink:Show();
        else
            ButtonLink:Hide();
        end;
    end;
end
function Emotes:ToggleFavorite(name, emoteTableId)
    if(AlleriaCharacter.Emotes[emoteTableId] == true) then
        AlleriaCharacter.Emotes[emoteTableId] = false;
        _G[name .. "Texture"]:Hide();
    else
        AlleriaCharacter.Emotes[emoteTableId] = true;
        _G[name .. "Texture"]:Show();
    end;
    if(AlleriaCharacter.OnlyFavorite == true) then Emotes:ScrollFavoriteEmotsList(); return; end;
end
function Emotes:Search()
    local pattern = AlleriaEmotesFrameSearch:GetText();
    if(pattern == "" or pattern == nil or pattern == false) then Emotes.NowSearch = false; Emotes:ScrollEmotesList(); return; end;
    Emotes.NowSearch = true;
    Emotes.Cache = {};
    for localId, array in ipairs(Alleria.Emotes) do
        if(string.find(string.lower(array[3]), pattern) or string.find(string.lower(array[4]), pattern)) then
            local tempArray = Alleria.Emotes[localId];
            table.insert(tempArray, localId);
            if(AlleriaCharacter.Emotes[localId] == true) then
                table.insert(tempArray, true);
            else
                table.insert(tempArray, false);
            end;

            table.insert(Emotes.Cache, tempArray);
        end;
    end;
    Emotes:ScrollSearchResult();
end
function Emotes:ScrollSearchResult()
    local ButtonNum = 1; -- 1 through 5 of our window to scroll
    local ScrollOffset = 9; -- an index into our data calculated from the scroll offset
    local ScrollElement = _G["AlleriaEmotesFrameScroll"];
    FauxScrollFrame_Update(ScrollElement, #Emotes.Cache, 6, 32);
    for ButtonNum = 1, 9 do
        ScrollOffset = ButtonNum + FauxScrollFrame_GetOffset(ScrollElement);
        ButtonLink = _G["AlleriaEmotesButton" .. ButtonNum];
        if ScrollOffset <= #Emotes.Cache then
            ButtonLink:SetText(Emotes.Cache[ScrollOffset][3]);
            ButtonLink.EmoteNum = Emotes.Cache[ScrollOffset][2];
            ButtonLink.EmoteId = Emotes.Cache[ScrollOffset][1];
            ButtonLink.EmoteDescription = Emotes.Cache[ScrollOffset][4];
            _G["AlleriaEmotesButton" .. ButtonNum .. "IsFavorite"].LocalID = Emotes.Cache[ScrollOffset][5];
            if(Emotes.Cache[ScrollOffset][6] == true) then
                _G["AlleriaEmotesButton" .. ButtonNum .. "IsFavoriteTexture"]:Show();
            else
                _G["AlleriaEmotesButton" .. ButtonNum .. "IsFavoriteTexture"]:Hide();
            end;
            ButtonLink:Show();
        else
            ButtonLink:Hide();
        end;
    end;
end
return Alleria:InsertModule(Emotes);