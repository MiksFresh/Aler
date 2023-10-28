GobStruct = {{},{}}; 
GobResetStruct = {{},{}}; 

StructIterator = 1;
isParsingGobjects = false;
enableParsingPlayer = false;


function Build_OnShow()
	print("Build load");
	Build:RegisterEvent("CHAT_MSG_SYSTEM");
	Build:RegisterEvent("CHAT_MSG_ADDON");
	Build:SetScript("OnEvent", function(self, event, prefix, msg, ...)

		if(prefix == "Selected object:") then isParsingGobjects = true; end

		if(isParsingGobjects == true) then
			for token in string.gmatch(prefix, "[a-zA-Z]*: [-]*[0-9]*[.]*[0-9]*") do
				local name, value = strsplit(":", token);
				if(name == "GUID") then GobStruct[1].GUID = value;  GobResetStruct[1].GUID = value;	GobGuidValueText:SetText(value);			end
				if(name == "ID") then GobStruct[1].ID = tonumber(value); GobResetStruct[1].ID = tonumber(value); GobIdValueText:SetText(value); end
				if(name == "X") then GobStruct[1].X = tonumber(value);					   GobResetStruct[1].X = tonumber(value); GobXCoordinate:SetText(value);			end
				if(name == "Y") then GobStruct[1].Y = tonumber(value);					   GobResetStruct[1].Y = tonumber(value); GobYCoordinate:SetText(value);	 		end
				if(name == "Z") then GobStruct[1].Z = tonumber(value);					   GobResetStruct[1].Z = tonumber(value); GobZCoordinate:SetText(value);	   		end
				if(name == "MapId") then GobStruct[1].MapId = tonumber(value);			   GobResetStruct[1].MapId = tonumber(value);		end
				if(name == "Orientation") then GobStruct[1].Orientation = tonumber(value); GobResetStruct[1].Orientation = tonumber(value);	isParsingGobjects = false; end
			end
		end
	end);
	
	StepMoveValueText:SetText("0.1");
	StepSizeValueText:SetText("0.1");
	GobGuidValueText:SetText("Gobject GUID");
	GobIdValueText:SetText("Gobject ID");
	RotaDegX:SetText("0");
	RotaDegY:SetText("0");
	RotaDegZ:SetText("0");
	
	
end


-----------------------------------------------------------------------------------------


function Build_OnMouseDown()
	StepMoveValueText:ClearFocus();
	GobGuidValueText:ClearFocus();
	GobIdValueText:ClearFocus();
	StepSizeValueText:ClearFocus();
end

function GobTarButton_OnClick()
	SendChatMessage(".gob tar");
	GobStruct[1].baseSize = tonumber(1);
end

function GobAddButton_OnClick()
	SendChatMessage(".gob add "..GobIdValueText:GetText());
	SendChatMessage(".gob tar");
end

function GobMoveForward_OnClick()
	GobStruct[1].X = GobStruct[1].X + tonumber(StepMoveValueText:GetText());
	SendChatMessage(".gob move "..GobStruct[1].GUID.." "..tostring(GobStruct[1].X).." "..tostring(GobStruct[1].Y).." "..tostring(GobStruct[1].Z));
	GobXCoordinate:SetText(GobStruct[1].X);
	
end

function GobMoveBackward_OnClick()
	GobStruct[1].X = GobStruct[1].X - tonumber(StepMoveValueText:GetText());
	SendChatMessage(".gob move "..GobStruct[1].GUID.." "..tostring(GobStruct[1].X).." "..tostring(GobStruct[1].Y).." "..tostring(GobStruct[1].Z));
	GobXCoordinate:SetText(GobStruct[1].X);
end

function GobMoveLeft_OnClick()
	GobStruct[1].Y = GobStruct[1].Y + tonumber(StepMoveValueText:GetText());
	SendChatMessage(".gob move "..GobStruct[1].GUID.." "..tostring(GobStruct[1].X).." "..tostring(GobStruct[1].Y).." "..tostring(GobStruct[1].Z));
	GobYCoordinate:SetText(GobStruct[1].Y);
end

function GobMoveRight_OnClick()
	GobStruct[1].Y = GobStruct[1].Y - tonumber(StepMoveValueText:GetText());
	SendChatMessage(".gob move "..GobStruct[1].GUID.." "..tostring(GobStruct[1].X).." "..tostring(GobStruct[1].Y).." "..tostring(GobStruct[1].Z));
	GobYCoordinate:SetText(GobStruct[1].Y);
	
	
end

function GobCloneButton_OnClick()
	SendChatMessage(".gob add clone "..GobStruct[1].GUID);
end

function TeleToGobjet_OnClick()
	SendChatMessage(".go xyz "..tostring(GobStruct[1].X).." "..tostring(GobStruct[1].Y).." "..tostring(GobStruct[1].Z).." "..tostring(GobStruct[1].MapId));
end

function GobSumon_OnClick()
	SendChatMessage(".gob move "..GobStruct[1].GUID);
	SendChatMessage(".gob tar");
	SendChatMessage(".gob tar");
end

function GobRotateLeft_OnClick()
	GobStruct[1].Orientation = GobStruct[1].Orientation - tonumber(StepMoveValueText:GetText());
	SendChatMessage(".gob turn"..GobStruct[1].GUID.." "..GobStruct[1].Orientation);	
end

function GobRotateRight_OnClick()
	GobStruct[1].Orientation = GobStruct[1].Orientation + tonumber(StepMoveValueText:GetText());
	SendChatMessage(".gob turn "..GobStruct[1].GUID.." "..GobStruct[1].Orientation);
end

function GobResetButton_OnClick()
	SendChatMessage(".gob add xyz "..tostring(GobResetStruct[1].X).." "..tostring(GobResetStruct[1].Y).." "..tostring(GobResetStruct[1].Z).." "
							..tostring(GobResetStruct[1].ID).." "..tostring(GobResetStruct[1].Orientation).." "..tostring(GobResetStruct[1].Size));

	GobStruct[1].X = GobResetStruct[1].X;
	GobStruct[1].Y = GobResetStruct[1].Y;
	GobStruct[1].Z = GobResetStruct[1].Z;
	GobStruct[1].Orientation = GobResetStruct[1].Orientation;
	GobStruct[1].size = GobResetStruct[1].Size;
end

function GobUp_OnClick()
	GobStruct[1].Z = GobStruct[1].Z + tonumber(StepMoveValueText:GetText());
	SendChatMessage(".gob move "..GobStruct[1].GUID.." "..tostring(GobStruct[1].X).." "..tostring(GobStruct[1].Y).." "..tostring(GobStruct[1].Z));
	GobZCoordinate:SetText(GobStruct[1].Z);
end

function GobDown_OnClick()
	GobStruct[1].Z = GobStruct[1].Z - tonumber(StepMoveValueText:GetText());
	SendChatMessage(".gob move "..GobStruct[1].GUID.." "..tostring(GobStruct[1].X).." "..tostring(GobStruct[1].Y).." "..tostring(GobStruct[1].Z));
	GobZCoordinate:SetText(GobStruct[1].Z);
end

function GobPlusSize_OnClick()
	GobStruct[1].size = GobStruct[1].baseSize + tonumber(StepSizeValueText:GetText());
	SendChatMessage(".gob set scale "..GobResetStruct[1].GUID.." "..tostring(GobStruct[1].size));
	GobStruct[1].baseSize = GobStruct[1].size;
end

function GobMinusSize_OnClick()
	GobStruct[1].size = GobStruct[1].baseSize - tonumber(StepSizeValueText:GetText());
	SendChatMessage(".gob set scale "..GobResetStruct[1].GUID.." "..tostring(GobStruct[1].size));
	GobStruct[1].baseSize = GobStruct[1].size;
end

function GobDelButton_OnClick()
	SendChatMessage(".gob del "..GobResetStruct[1].GUID);
end

function PlayerSnap_OnClick()
	SendChatMessage(".gomove 11", "WHISPER", nil, UnitName("player"));
end

function SPAWNSPELL()

	SendChatMessage(".gomove 27 0 "..SPELLENTRY:GetText(), "WHISPER", nil, UnitName("player"));
end




function RotaXP()
	RotaX = string.format("%.4f",(((RotaDegX:GetText()) + (5)) * (math.pi / 180)));
	RotaY = string.format("%.4f",(RotaDegY:GetText() * (math.pi / 180)));
	RotaZ = string.format("%.4f",(RotaDegZ:GetText() * (math.pi / 180)));
	SendChatMessage(".gob turn "..GobStruct[1].GUID.." "..tostring(RotaZ).." "..tostring(RotaY).." "..tostring(RotaX));
	RotaDegX:SetText(tonumber((RotaDegX:GetText()) + (5)));
end

function RotaXM()
	RotaX = string.format("%.4f",(((RotaDegX:GetText()) - (5)) * (math.pi / 180)));
	RotaY = string.format("%.4f",(RotaDegY:GetText() * (math.pi / 180)));
	RotaZ = string.format("%.4f",(RotaDegZ:GetText() * (math.pi / 180)));
	SendChatMessage(".gob turn "..GobStruct[1].GUID.." "..tostring(RotaZ).." "..tostring(RotaY).." "..tostring(RotaX));
	RotaDegX:SetText(tonumber((RotaDegX:GetText()) - (5)));
end

function RotaYP()
	RotaX = string.format("%.4f",(RotaDegX:GetText() * (math.pi / 180)));
	RotaY = string.format("%.4f",(((RotaDegY:GetText()) + (5)) * (math.pi / 180)));
	RotaZ = string.format("%.4f",(RotaDegZ:GetText() * (math.pi / 180)));
	SendChatMessage(".gob turn "..GobStruct[1].GUID.." "..tostring(RotaZ).." "..tostring(RotaY).." "..tostring(RotaX));
	RotaDegY:SetText(tonumber((RotaDegY:GetText()) + (5)));
end

function RotaYM()
	RotaX = string.format("%.4f",(RotaDegX:GetText() * (math.pi / 180)));
	RotaY = string.format("%.4f",(((RotaDegY:GetText()) - (5)) * (math.pi / 180)));
	RotaZ = string.format("%.4f",(RotaDegZ:GetText() * (math.pi / 180)));
	SendChatMessage(".gob turn "..GobStruct[1].GUID.." "..tostring(RotaZ).." "..tostring(RotaY).." "..tostring(RotaX));
	RotaDegY:SetText(tonumber((RotaDegY:GetText()) - (5)));
end

function RotaZP()
	RotaX = string.format("%.4f",(RotaDegX:GetText() * (math.pi / 180)));
	RotaY = string.format("%.4f",(RotaDegY:GetText() * (math.pi / 180)));
	RotaZ = string.format("%.4f",(((RotaDegZ:GetText()) + (5)) * (math.pi / 180)));
	SendChatMessage(".gob turn "..GobStruct[1].GUID.." "..tostring(RotaZ).." "..tostring(RotaY).." "..tostring(RotaX));
	RotaDegZ:SetText(tonumber((RotaDegZ:GetText()) + (5)));
end

function RotaZM()
	RotaX = string.format("%.4f",(RotaDegX:GetText() * (math.pi / 180)));
	RotaY = string.format("%.4f",(RotaDegY:GetText() * (math.pi / 180)));
	RotaZ = string.format("%.4f",(((RotaDegZ:GetText()) - (5)) * (math.pi / 180)));
	SendChatMessage(".gob turn "..GobStruct[1].GUID.." "..tostring(RotaZ).." "..tostring(RotaY).." "..tostring(RotaX));
	RotaDegZ:SetText(tonumber((RotaDegZ:GetText()) - (5)));
end
