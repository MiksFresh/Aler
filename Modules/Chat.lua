local Chat = {};

Chat.name = "Chat";
Chat.normalName = "Chat Worker";
Chat.Enabled = true;

function Chat:OnInitialize()
    for ChatIndex = 1, NUM_CHAT_WINDOWS do
        local CHAT_FRAME = _G["ChatFrame" .. ChatIndex .. "EditBox"];

        Alleria.Core:SecureHookScript(CHAT_FRAME, "OnTextChanged", "UpdateTypingStatus");
        Alleria.Core:SecureHookScript(CHAT_FRAME, "OnEscapePressed", "UpdateTypingStatus");
        Alleria.Core:SecureHookScript(CHAT_FRAME, "OnEnterPressed", "UpdateTypingStatus");
        Alleria.Core:SecureHookScript(CHAT_FRAME, "OnHide", "UpdateTypingStatus");
        CHAT_FRAME:SetMaxLetters(0);
        CHAT_FRAME:SetMaxBytes(0);

        if CHAT_FRAME.SetVisibleTextByteLimit then
			CHAT_FRAME:SetVisibleTextByteLimit( 0 )
		end 
    end;
    Alleria.Core:RawHook("SendChatMessage", "SendLongChatMessage", true);
end;
function Alleria.Core:UpdateTypingStatus(EditBoxLink)
    local chatType = EditBoxLink:GetAttribute("chatType");
	local text = EditBoxLink:GetText();
	local firstChar = text:sub(1, 1);
    if (
        EditBoxLink:IsShown() and text:len() > 0 and 
        firstChar ~= "/" and firstChar ~= "." and 
        firstChar ~= "!" and firstChar ~= "#" and 
        (chatType == "SAY" or chatType == "YELL" or chatType == "EMOTE")
    ) then
        if(Alleria.SayTyping == false) then
            Alleria.SayTyping = true;
            SendCoreMessage("rps typing on");
        end;
    else
        if(Alleria.SayTyping == true) then
            Alleria.SayTyping = false;
            SendCoreMessage("rps typing off");
        end;
	end;
end
local function chsize(char)
    if not char then
        return 0
    elseif char > 240 then
        return 4
    elseif char > 225 then
        return 3
    elseif char > 192 then
        return 2
    else
        return 1
    end
end
local function utf8sub(str, startByte, numBytes)
    local currentIndex = startByte
    local returnedBytes = 0;
   
    while numBytes > 0 and currentIndex <= #str do
      local char = string.byte(str, currentIndex)
      currentIndex = currentIndex + chsize(char)
      numBytes = numBytes - chsize(char)
      returnedBytes = returnedBytes + chsize(char)
    end
    return str:sub(startByte, currentIndex - 1), returnedBytes
  end

local table_getn = _G.table.getn;
local table_insert = _G.table.insert;
local tostring_ = _G.tostring;
local tonumber_ = _G.tonumber;

local function paddString(str, paddingChar, minLength, paddRight)
    str = tostring_(str or "");
    paddingChar = tostring_(paddingChar or " ");
    minLength = tonumber_(minLength or 0);
    while(str:len() < minLength) do
        if(paddRight) then
            str = str..paddingChar;
        else
            str = paddingChar..str;
        end
    end
    return str;
end


local function GetShorterString(longMsg)
    local shortText, sizeBytes = utf8sub(longMsg, 1, Alleria.ChatMaxLetters - 1)
    local remainingPart = longMsg:sub(sizeBytes + 1, longMsg:len())
    return shortText, remainingPart;
end

_G.ChatThrottle = { SendChatMessage = function(...) Alleria.Core.hooks.SendChatMessage(unpack({...}, 3)) end }; -- That was funny to uncode this string ;)
local function SplitIntoChunks(longMsg)
    local splitMessageLinks = {};
    
    --Replace links with long strings of zeroes.
    longMsg, results = longMsg:gsub( "(|H[^|]+|h[^|]+|h)", function(theLink)
            table_insert(splitMessageLinks, theLink);
            return "\001\002"..paddString(#splitMessageLinks, "0", theLink:len()-4).."\003\004";
    end);
    
    --WoW replaces tabs with 4 spaces, lets replace 4 spaces with '$tab' so that our splitting of words doesn't remove the tab spaces.
    if longMsg:find(Alleria.TabSpaces) then
        while longMsg:find(Alleria.TabSpaces) do
            longMsg = longMsg:gsub(Alleria.TabSpaces, "$tab");
        end
    end
    
    local words = {}
    for v in longMsg:gmatch("[^ ]+") do
        --Check if 'word' is longer then 254 characters. (wtf?) anyway split long string at the 254 char mark.
        if v:len() > Alleria.ChatMaxLetters then
            local shortPart, remainingPart = nil, v;
            local i=1;
            while remainingPart and remainingPart:len() > 0 do
                shortPart, remainingPart = GetShorterString(remainingPart);
                if shortPart and shortPart ~= "" then
                    table_insert(words, shortPart)
                end
                
                if i>10 then break; end
                i=i+1;
            end
        else
            table_insert(words, v)
        end
    end

    local temp = "";
    local chunks = {}
    for i=1, table_getn(words) do 
        if temp:len() + words[i]:len() <= (Alleria.ChatMaxLetters - 6) then
            if temp:len() > 0 then
                temp = temp.." "..words[i];
            else
                temp = words[i];
            end
            
        else
            temp = temp:gsub("\001\002%d+\003\004", function(link)
                local index = tonumber_(link:match("(%d+)"));
                return splitMessageLinks[index] or link;
            end);
            
            if temp:find("$tab") then
                while temp:find("$tab") do
                    temp = temp:gsub("$tab", Alleria.TabSpaces);
                end
            end
            
            table_insert(chunks, temp);
            temp = words[i];
        end
    end

    if temp:len() > 0 then
        temp = temp:gsub("\001\002%d+\003\004", function(link)
            local index = tonumber_(link:match("(%d+)"));
            return splitMessageLinks[index] or link;
        end);
        
        if temp:find("$tab") then
            while temp:find("$tab") do
                temp = temp:gsub("$tab", Alleria.TabSpaces);
            end
        end
            
        table_insert(chunks, temp);
    end
    
    return chunks;
end

function Alleria.Core:SendLongChatMessage(...)
    local msg, chatType, language, channel = ...;

    if (string.len(msg) > Alleria.ChatMaxLetters) then
        local chunks = SplitIntoChunks(msg);
        for i=1, table_getn(chunks) do
            _G.ChatThrottle.SendChatMessage("ALERT", "UCM", chunks[i], chatType, language, channel);
        end
        return;
    end
    Alleria.Core.hooks.SendChatMessage(msg, chatType ,language ,channel);
end
return Alleria:InsertModule(Chat);