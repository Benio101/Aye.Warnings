local Aye = Aye;
if not LibStub:NewLibrary("Aye.utils.Player", 2) then return end;
Aye.utils.Player = Aye.utils.Player or {};

-- @noparam
-- @return {bool} IsOnPvP if player is on PvP (arena or battleground)
Aye.utils.Player.IsOnPvP = function()
	local _, instanceType = IsInInstance();
	if
			instanceType == "arena"
		or	instanceType == "pvp"
	then
		return true;
	end;
	
	return false;
end;