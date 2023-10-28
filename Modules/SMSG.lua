local SMSG = {};

SMSG.name = "SMSG";
SMSG.normalName = "Server Message Sniffer";
SMSG.Events = {
    ["CHAT_MSG_ADDON"] = true,
    ["PLAYER_ENTERING_WORLD"] = true,
};
SMSG.Enabled = true;
function SMSG:OnInitialize()
    SendCoreMessage("alleria online");
end
function SMSG:PLAYER_ENTERING_WORLD(...)

end
function SMSG:CHAT_MSG_ADDON(...)
    local prefix, msg, type, from, to = ...;
    local array = Explode(":", msg);
end
return Alleria:InsertModule(SMSG);