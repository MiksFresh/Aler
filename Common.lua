function Explode(delim, str)
    if(delim == nil or delim == false) then
        return false;
    end;
    if(str == nil or str == false) then
       return false;
    end;
    Array = {};
    local i = 1;
    for s in string.gmatch(str, "[^"..delim.."]+") do
        Array[i] = s;
        i = i + 1;
    end;
    if(#Array == 1) then
        return Array[1];
    else
        return Array;
    end;
    return nil;
end
function MakeMovable(frame)
    frame:SetMovable(true);
    frame:SetScript("OnMouseDown",
        function(self, button)
            if button == "RightButton" then
                self:StartMoving();
            end;
        end
    );
    frame:SetScript("OnMouseUp",
        function(self, button)
            if button == "RightButton" then
                self:StopMovingOrSizing();
            end;
        end
    );
end
function SendCoreMessage(command)
    if(command == nil or command == "") then
        return false;
    end;
    command = "." .. command;
    SendChatMessage(command, "GUILD", "COMMON");
end



function Alleria:InsertModule(ModuleBody)

    Alleria.Modules[ModuleBody.name] = ModuleBody;
end