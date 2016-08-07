local Aye = Aye;
Aye.utils.Buffs = Aye.utils.Buffs or {};

-- Check if @unitID has rune
--
-- @param	{uint}		unitID	@unitID should be visible (UnitIsVisible)
-- @return	{0|1}		buff	if unit have Rune
-- @return	{uint}		[note]	Buff Time left (if @buff is =1)
-- @example
--| local buff, note = Aye.utils.Buffs.UnitHasRune("player");
--| 
--| if buff then
--| 	print("player have rune, time left: " ..note .."min");
--| else
--| 	print("player have no rune");
--| end;
Aye.utils.Buffs.UnitHasRune = Aye.utils.Buffs.UnitHasRune or function(unitID)
	-- Rune
	for _, buffID in pairs({
		175457, -- 50 int
		175456, -- 50 agi
		175439, -- 50 str
	}) do
		local _, _, _, _, _, _, expires = UnitBuff(unitID, GetSpellInfo(buffID));
		
		if type(expires) =="number" and expires >0 then
			return 1, floor(.5+ (expires -GetTime()) /60);
		end;
	end;
	
	-- No Rune
	return 0;
end;

-- Check if @unitID has flask
--
-- @param		{uint}		unitID	@unitID should be visible (UnitIsVisible)
-- @return		{0|1|2}		buff	extended buff status:
--
-- +------+-------+-----+
-- | buff | flask | BiS |
-- +------+-------+-----+
-- |    0 |    no |     |
-- |    1 |   yes | yes |
-- |    2 |   yes |  no |
-- +------+-------+-----+
--
-- @return		{uint}		[note]	Buff Time left		(if @buff is =1)
-- 			or	{string}	[note]	Formatted Buff Link	(if @buff is =2)
--
-- @example
--| local buff, note = Aye.utils.Buffs.UnitHasFlask("player");
--| 
--| if not buff		then print("player have no flask") end;
--| if buff == 1	then print("player have BiS flask, time left: " ..note .."min") end;
--| if buff == 2	then print("player have old flask: " ..note) end;
Aye.utils.Buffs.UnitHasFlask = Aye.utils.Buffs.UnitHasFlask or function(unitID)
	-- BiS Flask: 250
	for _, buffID in pairs({
		156079, -- 250 int, Greater Draenic Intellect Flask
		156064, -- 250 agi, Greater Draenic Agility Flask
		156080, -- 250 str, Greater Draenic Strength Flask
		156084, -- 250 sta, Greater Draenic Stamina Flask
	}) do
		local _, _, _, _, _, _, expires = UnitBuff(unitID, GetSpellInfo(buffID));
		
		if type(expires) =="number" and expires >0 then
			return 1, floor(.5+ (expires -GetTime()) /60);
		end;
	end;
	
	-- Not BiS Flask: 200
	for _, buffID in pairs({
		156070, -- 200 int, Draenic Intellect Flask
		156073, -- 200 agi, Draenic Agility Flask
		156071, -- 200 str, Draenic Strength Flask
		156077, -- 200 sta, Draenic Stamina Flask
	}) do
		local _, _, _, _, _, _, expires = UnitBuff(unitID, GetSpellInfo(buffID));
		
		if type(expires) =="number" and expires >0 then
			return 2, GetSpellLink(buffID);
		end;
	end;
	
	-- No Flask
	return 0;
end;

-- Check if @unitID is Well Fed
--
-- @param		{uint}		unitID	@unitID should be visible (UnitIsVisible)
-- @return		{0|1|2|3}	buff	extended buff status:
--
-- +------+----------+-----+--------+
-- | buff | Well Fed | BiS | Eating |
-- +------+----------+-----+--------+
-- |    0 |       no |     |     no |
-- |    1 |      yes | yes |        |
-- |    2 |      yes |  no |        |
-- |    3 |       no |     |    yes |
-- +------+----------+-----+--------+
--
-- @return		{uint}		[note]	Buff Time left		(if @buff is =1)
-- 			or	{string}	[note]	Formatted Buff Link	(if @buff is =2 and value2 is =0)
-- 			or	{uint}		[note]	Buff value2			(if @buff is =2 and value2 is >0)
-- 			or	"E"			[note]						(if @buff is =3)
--
-- @example
--| local buff, note = Aye.utils.Buffs.UnitIsWellFed("player");
--| 
--| if not buff		then print("player is not Well Fed") end;							-- No "Well Fed" buff and not eating
--| if buff == 1	then print("player is Well Fed, time left: " ..note .."min") end;	-- BiS "Well Fed" buff, note contains buff time left
--| if buff == 2	then print("player is Poor Fed: " ..note) end;						-- "Well Fed" buff is not BiS, aka "Poor Fed", note is buff value2 or link to "Well Fed" buff
--| if buff == 3	then print("player is eating.") end;								-- No "Well Fed" buff, but @unitID is eating, note is "E"
Aye.utils.Buffs.UnitIsWellFed = Aye.utils.Buffs.UnitIsWellFed or function(unitID)
	-- expires	= time at which the aura will expire
	-- spellID	= spellID of the aura, used to identify Well Fed buff
	-- value2	= how much stat is applied on buff, ex. 125 for +125 mastery
	local _, _, _, _, _, _, expires, _, _, _, spellID, _, _, _, value2 = UnitBuff(unitID, "Well Fed");
	
	-- Well Fed
	for _, buffID in pairs({
		180750, -- 125 mast
		180748, -- 125 hast
		180745, -- 125 crit
		180749, -- 125 mult
		180746, -- 125 vers
		180747, -- 125 stam
		188534, -- fel lash
	}) do
		if type(spellID) =="number" and buffID == spellID then
			return 1, floor(.5+ (expires -GetTime()) /60);
		end;
	end;
	
	-- Eating
	local _, _, _, _, _, _, eating = UnitBuff(unitID, GetSpellInfo(433)); -- eating
	if type(eating) =="number" and eating >0 then
		return 3, "E";
	end
	
	-- Poor Fed
	if type(expires) =="number" and expires >0 and type(value2) =="number" and value2 >=0 then
		return 2, value2 ==0 and GetSpellLink(spellID) or value2;
	end;
	
	-- Not Well Fed
	return 0;
end;