function Alleria.Core:OnInitialize()
    
    self:Debug("Загрузка...");

    for Name, functions in pairs(Alleria.Modules) do
       
        if(Alleria.Modules[Name].Enabled == true) then
            Alleria.Core:Debug("Интеграция модуля", Alleria.Modules[Name].normalName, "...");
            if(type(Alleria.Modules[Name].OnInitialize) == "function") then
                Alleria.Modules[Name].OnInitialize();
            end;
            if(type(Alleria.Modules[Name].Events) == "table") then
                for EventName, Enabled in pairs(Alleria.Modules[Name].Events) do
                    if(Enabled == true) then
                        self:Debug("Установил триггер", EventName, "для", Name);
                        Alleria.Frame:RegisterEvent(EventName);
                    end;
                end;
            end;
        else
            Alleria.Core:Debug("Модуль", Alleria.Modules[Name].normalName, "|cffFF0000отключен|r!");
        end;
    end;

    Alleria.Frame:SetScript(
        "OnEvent",
        function(me, ...)
            local eventName = ...;
            for Name, functions in pairs(Alleria.Modules) do
                if(type(Alleria.Modules[Name][eventName]) == "function") then
                    Alleria.Modules[Name][eventName](...);
                end;
            end;
        end
    );
end

