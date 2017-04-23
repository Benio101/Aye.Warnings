local Aye = Aye;
if not Aye.addModule("Aye.Warnings") then return end;

Aye.modules.Warnings.OnEnable = function()
	-- register addon prefixes
	RegisterAddonMessagePrefix("Aye");			-- Aye
	RegisterAddonMessagePrefix("D4");			-- DBM
	RegisterAddonMessagePrefix("raidcheck");	-- ExRT
	RegisterAddonMessagePrefix("RSCaddon");		-- RSC
	
	-- list of subjects that won't be checked
	-- considering others made it already
	-- aka anti chat spam system
	Aye.modules.Warnings.antispam = {
		Offline	= {cooldown = false},
		AFK		= {cooldown = false},
		Dead	= {cooldown = false},
		FarAway	= {cooldown = false},
		Sick	= {cooldown = false},
		Flask	= {cooldown = false},
		Rune	= {cooldown = false},
		WellFed	= {cooldown = false},
	};
end;

Aye.modules.Warnings.events.READY_CHECK = function(...)
	if
			Aye.db.global.Warnings.enable
		and	Aye.db.global.Warnings.enableReadyCheck
	then
		if Aye.modules.Warnings.timer then Aye.modules.Warnings.timer:Cancel() end;
		Aye.modules.Warnings.timer = C_Timer.NewTimer(Aye.db.global.Warnings.antispamReportDelay /1000, Aye.modules.Warnings.warn);
	end;
end;

Aye.modules.Warnings.events.CHAT_MSG_ADDON = function(...)
	local prefix, message, _, sender = ...;
	sender = sender:match("^([^%-]+)-") or sender;
	
	-- Aye Warnings broadcast handle
	--
	-- @prefix = Aye
	-- @message begins with "Warnings."
	-- rest of message is subject of message (thing not to report)
	-- list of valid subjects:
	--
	-- +--------------+------------------------------------------------+
	-- | subject name | subject description                            |
	-- +--------------+------------------------------------------------+
	-- |      Offline | Player is Offline                              |
	-- |          AFK | Player is marked Away From Keyboard            |
	-- |         Dead | Player is Dead                                 |
	-- |      FarAway | Player is Far Awar (not UnitIsVisible)         |
	-- |         Sick | Player has Resurrection Sickness debuff        |
	-- |        Flask | Player have no BiS flask                       |
	-- |         Rune | Player have no rune                            |
	-- |      WellFed | Player have no BiS Well Fed buff (aka no food) |
	-- +--------------+------------------------------------------------+
	--
	-- @example:
	--|	prefix = Aye
	--|	message = Warnings.Flask
	-->	-- ignore flask (reported by some other user by Aye.Warnings already)
	if
			prefix == "Aye"
		and	message
	then
		local subject = message:match("^Warnings%.(.+)");
		
		if subject == "Offline" then
			Aye.modules.Warnings.antispam.Offline.cooldown = true;
			if Aye.modules.Warnings.antispam.Offline.timer then Aye.modules.Warnings.antispam.Offline.timer:Cancel() end;
			Aye.modules.Warnings.antispam.Offline.timer = C_Timer.NewTimer(Aye.db.global.Warnings.antispamCooldown, function()
				Aye.modules.Warnings.antispam.Offline.cooldown = false;
			end);
		end;
		
		if subject == "AFK" then
			Aye.modules.Warnings.antispam.AFK.cooldown = true;
			if Aye.modules.Warnings.antispam.AFK.timer then Aye.modules.Warnings.antispam.AFK.timer:Cancel() end;
			Aye.modules.Warnings.antispam.AFK.timer = C_Timer.NewTimer(Aye.db.global.Warnings.antispamCooldown, function()
				Aye.modules.Warnings.antispam.AFK.cooldown = false;
			end);
		end;
		
		if subject == "Dead" then
			Aye.modules.Warnings.antispam.Dead.cooldown = true;
			if Aye.modules.Warnings.antispam.Dead.timer then Aye.modules.Warnings.antispam.Dead.timer:Cancel() end;
			Aye.modules.Warnings.antispam.Dead.timer = C_Timer.NewTimer(Aye.db.global.Warnings.antispamCooldown, function()
				Aye.modules.Warnings.antispam.Dead.cooldown = false;
			end);
		end;
		
		if subject == "FarAway" then
			Aye.modules.Warnings.antispam.FarAway.cooldown = true;
			if Aye.modules.Warnings.antispam.FarAway.timer then Aye.modules.Warnings.antispam.FarAway.timer:Cancel() end;
			Aye.modules.Warnings.antispam.FarAway.timer = C_Timer.NewTimer(Aye.db.global.Warnings.antispamCooldown, function()
				Aye.modules.Warnings.antispam.FarAway.cooldown = false;
			end);
		end;
		
		if subject == "Sick" then
			Aye.modules.Warnings.antispam.Sick.cooldown = true;
			if Aye.modules.Warnings.antispam.Sick.timer then Aye.modules.Warnings.antispam.Sick.timer:Cancel() end;
			Aye.modules.Warnings.antispam.Sick.timer = C_Timer.NewTimer(Aye.db.global.Warnings.antispamCooldown, function()
				Aye.modules.Warnings.antispam.Sick.cooldown = false;
			end);
		end;
		
		if subject == "Flask" then
			Aye.modules.Warnings.antispam.Flask.cooldown = true;
			if Aye.modules.Warnings.antispam.Flask.timer then Aye.modules.Warnings.antispam.Flask.timer:Cancel() end;
			Aye.modules.Warnings.antispam.Flask.timer = C_Timer.NewTimer(Aye.db.global.Warnings.antispamCooldown, function()
				Aye.modules.Warnings.antispam.Flask.cooldown = false;
			end);
		end;
		
		if subject == "Rune" then
			Aye.modules.Warnings.antispam.Rune.cooldown = true;
			if Aye.modules.Warnings.antispam.Rune.timer then Aye.modules.Warnings.antispam.Rune.timer:Cancel() end;
			Aye.modules.Warnings.antispam.Rune.timer = C_Timer.NewTimer(Aye.db.global.Warnings.antispamCooldown, function()
				Aye.modules.Warnings.antispam.Rune.cooldown = false;
			end);
		end;
		
		if subject == "WellFed" then
			Aye.modules.Warnings.antispam.WellFed.cooldown = true;
			if Aye.modules.Warnings.antispam.WellFed.timer then Aye.modules.Warnings.antispam.WellFed.timer:Cancel() end;
			Aye.modules.Warnings.antispam.WellFed.timer = C_Timer.NewTimer(Aye.db.global.Warnings.antispamCooldown, function()
				Aye.modules.Warnings.antispam.WellFed.cooldown = false;
			end);
		end;
	end;
	
	-- DBM Pull Time broadcast handle
	if
			prefix == "D4"
		and	message
		and sender
		and	(
					UnitIsGroupLeader(sender, IsInInstance() and LE_PARTY_CATEGORY_INSTANCE or LE_PARTY_CATEGORY_HOME)
				or	UnitIsGroupAssistant(sender, IsInInstance() and LE_PARTY_CATEGORY_INSTANCE or LE_PARTY_CATEGORY_HOME)
				or	UnitIsUnit(sender, "player")
			)
	then
		local seconds = message:match("^PT\t(%d+)");
		if seconds then
			seconds = tonumber(seconds);
			if seconds >0 then
				-- DBM Pull
				if
						Aye.db.global.Warnings.enable
					and	Aye.db.global.Warnings.enablePull
				then
					if Aye.modules.Warnings.timer then Aye.modules.Warnings.timer:Cancel() end;
					Aye.modules.Warnings.timer = C_Timer.NewTimer(Aye.db.global.Warnings.antispamReportDelay /1000, Aye.modules.Warnings.warn);
				end;
			end;
		end;
	end;
	
	-- ExRT raidcheck broadcast handle
	if
			prefix == "raidcheck"
		and	message
		and	Aye.db.global.Warnings.EnableIntegrationExRT
	then
		if message == "FOOD" then
			Aye.modules.Warnings.antispam.WellFed.cooldown = true;
			if Aye.modules.Warnings.antispam.WellFed.timer then Aye.modules.Warnings.antispam.WellFed.timer:Cancel() end;
			Aye.modules.Warnings.antispam.WellFed.timer = C_Timer.NewTimer(Aye.db.global.Warnings.antispamCooldown, function()
				Aye.modules.Warnings.antispam.WellFed.cooldown = false;
			end);
		end;
		
		if message == "FLASK" then
			Aye.modules.Warnings.antispam.Flask.cooldown = true;
			if Aye.modules.Warnings.antispam.Flask.timer then Aye.modules.Warnings.antispam.Flask.timer:Cancel() end;
			Aye.modules.Warnings.antispam.Flask.timer = C_Timer.NewTimer(Aye.db.global.Warnings.antispamCooldown, function()
				Aye.modules.Warnings.antispam.Flask.cooldown = false;
			end);
		end;
		
		if message == "RUNES" then
			Aye.modules.Warnings.antispam.Rune.cooldown = true;
			if Aye.modules.Warnings.antispam.Rune.timer then Aye.modules.Warnings.antispam.Rune.timer:Cancel() end;
			Aye.modules.Warnings.antispam.Rune.timer = C_Timer.NewTimer(Aye.db.global.Warnings.antispamCooldown, function()
				Aye.modules.Warnings.antispam.Rune.cooldown = false;
			end);
		end;
	end;
	
	-- RSC raidcheck broadcast handle
	if
			prefix == "RSCaddon"
		and	message
		and	message == "a50"
		and	Aye.db.global.Warnings.EnableIntegrationRSC
	then
		Aye.modules.Warnings.antispam.WellFed.cooldown = true;
		if Aye.modules.Warnings.antispam.WellFed.timer then Aye.modules.Warnings.antispam.WellFed.timer:Cancel() end;
		Aye.modules.Warnings.antispam.WellFed.timer = C_Timer.NewTimer(Aye.db.global.Warnings.antispamCooldown, function()
			Aye.modules.Warnings.antispam.WellFed.cooldown = false;
		end);
		
		Aye.modules.Warnings.antispam.Flask.cooldown = true;
		if Aye.modules.Warnings.antispam.Flask.timer then Aye.modules.Warnings.antispam.Flask.timer:Cancel() end;
		Aye.modules.Warnings.antispam.Flask.timer = C_Timer.NewTimer(Aye.db.global.Warnings.antispamCooldown, function()
			Aye.modules.Warnings.antispam.Flask.cooldown = false;
		end);
		
		Aye.modules.Warnings.antispam.Rune.cooldown = true;
		if Aye.modules.Warnings.antispam.Rune.timer then Aye.modules.Warnings.antispam.Rune.timer:Cancel() end;
		Aye.modules.Warnings.antispam.Rune.timer = C_Timer.NewTimer(Aye.db.global.Warnings.antispamCooldown, function()
			Aye.modules.Warnings.antispam.Rune.cooldown = false;
		end);
	end;
end;

Aye.modules.Warnings.slash = function()
	Aye.modules.Warnings.antispam.Offline.cooldown = false;
	Aye.modules.Warnings.antispam.AFK.cooldown = false;
	Aye.modules.Warnings.antispam.Dead.cooldown = false;
	Aye.modules.Warnings.antispam.FarAway.cooldown = false;
	Aye.modules.Warnings.antispam.Sick.cooldown = false;
	Aye.modules.Warnings.antispam.Flask.cooldown = false;
	Aye.modules.Warnings.antispam.Rune.cooldown = false;
	Aye.modules.Warnings.antispam.WellFed.cooldown = false;
	
	if Aye.modules.Warnings.timer then Aye.modules.Warnings.timer:Cancel() end;
	Aye.modules.Warnings.warn();
end;

-- Check group and eventually warn about failings
--
-- @noparam
-- @noreturn
Aye.modules.Warnings.warn = function()
	-- Check if reporting is enabled
	if not Aye.db.global.Warnings.enable then return end;
	
	-- Check reporting conditions
	if (
			-- Disable
			(
					(
							Aye.db.global.Warnings.GuildGroupDisable
						and	Aye.utils.Player.InAllyGroup()
					)
				or	(
							Aye.db.global.Warnings.LFGDisable
						and	IsPartyLFG()
					)
				or	(
							Aye.db.global.Warnings.PvPDisable
						and	Aye.utils.Player.IsOnPvP()
					)
				or	(
							Aye.db.global.Warnings.OutsideInstanceDisable
						and	not IsInInstance()
					)
			)
			-- Force enable
		and	not (
					(
							Aye.db.global.Warnings.GuildGroupForceEnable
						and	Aye.utils.Player.InAllyGroup()
					)
				or	(
							Aye.db.global.Warnings.LFGForceEnable
						and	IsPartyLFG()
					)
				or	(
							Aye.db.global.Warnings.PvPForceEnable
						and	Aye.utils.Player.IsOnPvP()
					)
				or	(
							Aye.db.global.Warnings.OutsideInstanceForceEnable
						and	not IsInInstance()
					)
			)
	) then return end;
	
	-- Force Disable if Mythic Benched
	if
			Aye.db.global.Warnings.ForceDisableIfMythicBenched
		and	Aye.utils.Player.IsMythicBenched()
	then return end;
	
	
	-- table of subjects to check
	-- every subject contains:
	-- 	t		-- 				table of players that met criteria, ex. list of Dead Players for Dead subject
	-- 	name	-- 				name of subject to report, ex. "No BiS Rune" for Rune subject
	--
	-- Every .t and contains table:
	--	name	--				name of player
	--	note	-- optional,	additional note to display for player
	local t = {
		Offline	= {t = {}, name = "Offline"},
		AFK		= {t = {}, name = "AFK"},
		Dead	= {t = {}, name = "Dead"},
		FarAway	= {t = {}, name = "Far Away"},
		Sick	= {t = {}, name = GetSpellLink(15007)},
		Flask	= {t = {}, name = "No BiS Flask"},
		Rune	= {t = {}, name = "No Rune"},
		WellFed	= {t = {}, name = "Not Well Fed"},
	};
	
	-- group members
	local members = max(1, GetNumGroupMembers());
	
	-- check subjects
	for i = 1, members do
		-- in raid, every player have "raidX" id where id begins from 1 and ends with member number
		-- in party, there is always "player" and every NEXT members are "partyX" where X begins from 1
		-- especially, in full party, there are: "player", "party1", "party2", "party3", "party4" and NO "party5"
		local unitID = UnitInRaid("player") ~= nil and "raid" ..i or (i == 1 and "player" or "party" ..(i -1));
		local name = UnitName(unitID);
		
		-- ignore benched players
		if
				Aye.db.global.Warnings.IgnoreMythicBenched
			and	UnitInRaid(unitID)
			and	not IsPartyLFG()
			and	GetRaidDifficultyID() == DIFFICULTY_PRIMARYRAID_MYTHIC
		then
			local _, _, pid = GetRaidRosterInfo(i);
			if pid >4 then return end;
		end;
		
		if name then
		if
				Aye.db.global.Warnings.Offline
			and	not Aye.modules.Warnings.antispam.Offline.cooldown
			and	not	UnitIsConnected(unitID)
		then
			table.insert(t.Offline.t, {["name"] = name});
		end;
		
		if UnitIsConnected(unitID) then
		if
				Aye.db.global.Warnings.AFK
			and	not Aye.modules.Warnings.antispam.AFK.cooldown
			and	UnitIsAFK(unitID)
		then
			table.insert(t.AFK.t, {["name"] = name});
		end;
		
		if
				Aye.db.global.Warnings.Dead
			and	not Aye.modules.Warnings.antispam.Dead.cooldown
			and	UnitIsDeadOrGhost(unitID)
		then
			table.insert(t.Dead.t, {["name"] = name});
		end;
		
		if not UnitIsDeadOrGhost(unitID) then
		if
				Aye.db.global.Warnings.FarAway
			and	not Aye.modules.Warnings.antispam.FarAway.cooldown
			and	not	UnitIsVisible(unitID)
		then
			table.insert(t.FarAway.t, {["name"] = name});
		end;
		
		if UnitIsVisible(unitID) then -- credits for checking function to: Vlad#WoWUIDev and nebula#WoWUIDev
			if
					Aye.db.global.Warnings.ResurrectionSickness
				and	not Aye.modules.Warnings.antispam.Sick.cooldown
				and	not	UnitAura(unitID, "Resurrection Sickness")
			then
				local _, _, _, _, _, _, expires = UnitDebuff(unitID, GetSpellInfo(15007));
				if type(expires) =="number" and expires >0 then
					local note = floor(.5+ (expires -GetTime()) /60);
					table.insert(t.Sick.t, {["name"] = name, ["note"] = note});
				end;
			end;
			
			for k, v in pairs({
				-- ["c"]ondition setting
				-- ["f"]unction to check condition
				-- ["2"]nd function argument
				-- ["t"]able to insert players
				{
					["c"] =
							not Aye.modules.Warnings.antispam.Flask.cooldown
						and	Aye.db.global.Warnings.Flask,
					["f"] = Aye.utils.Buffs.UnitHasFlask,
					["2"] = nil,
					["t"] = t.Flask.t
				},
				{
					["c"] =
							not Aye.modules.Warnings.antispam.Rune.cooldown
						and	Aye.db.global.Warnings.Rune,
					["f"] = Aye.utils.Buffs.UnitHasRune,
					["2"] = nil,
					["t"] = t.Rune.t
				},
				{
					["c"] =
							not Aye.modules.Warnings.antispam.WellFed.cooldown
						and	Aye.db.global.Warnings.WellFed,
					["f"] = Aye.utils.Buffs.UnitIsWellFed,
					["2"] = Aye.db.global.Warnings.WellFedTier,
					["t"] = t.WellFed.t
				},
			}) do
				if v.c then
					-- buff checking function return, table:
					-- 	buff = uint, one of:
					-- 		0 = no buff and not eating
					-- 		1 = BiS buff (even if few time is left)
					-- 		2 = not BiS buff
					-- 		3 = no buff, but eating
					-- 	note = additional note (not present if buff is 0), either:
					--			time left on buff (in min) if buff is 1
					-- 			additional note attached to display if buff is 2 or 3
					--
					-- ex.:
					--	{buff = 0}				-- no buff at all
					--	{buff = 1, note = 3}	-- buff is up and 3 minutes left
					--	{buff = 2, note = 75}	-- buff is not BiS, display it's note (ex. link or value2)
					--	{buff = 3, note = "E"}	-- buff is not ready, but unit is "E"ating, display "E" as note, ex:
					--
					-- WARNING! Not Well Fed (1): Foo (E)
					local buff, note = v.f(unitID, v["2"]);
					
					-- No buff and not eating
					if buff == 0 then
						table.insert(v.t, {["name"] = name});
					
					-- BiS buff with time left passed in note
					elseif buff == 1 and Aye.db.global.Warnings.BuffTimeEnable and note <= Aye.db.global.Warnings.BuffTime then
						table.insert(v.t, {["name"] = name, ["note"] = note});
					
					-- Buff with issues other than few time left with note attached
					elseif buff >= 2 then
						table.insert(v.t, {["name"] = name, ["note"] = note});
					end;
				end;
			end;
		end;
		end;
		end;
		end;
	end;
	
	-- if amount of Far Away players exceedes half of group, it means that propably we are away from group
	if Aye.db.global.Warnings.FarAway and #t.FarAway.t > members /2 then
		-- wipe players and replace them with "player" name only
		t.FarAway.t = {{["name"] = UnitName("player")}};
	end;
	
	-- remove group subject entries with no issues
	for k0, v0 in pairs(t) do
		for k = #v0.t, 1, -1 do
			if v0.t[k].buff ~= nil and #v0.t[k].t ==0 then
				table.remove(t[k0].t, k);
			end;
		end;
	end;
	
	-- report subjects
	for k, v in pairs(t) do
		if Aye.db.global.Warnings[k] and #v.t >0 then Aye.modules.Warnings.report(v.t, v.name) end;
	end;
end;

-- Reports given @subject as a warning
--
-- @param {object} t
-- 		{string} t.name player nick
-- 		{string|uint} [t.note] additional note to display, ex. Rune Buff time left, ex. "E" on "Well Fed" for "E"ating
--
-- @param {string} subject subject to report, ex. "Dead" or "No BiS Rune"
--
-- @example
--| table.insert(t, {["name"] = NICK});						-- WARNING! subject (X): NICK
--| table.insert(t, {["name"] = NICK, ["note"] = NOTE});	-- WARNING! subject (X): NICK (NOTE)
--
-- @example input
--| local t;
--| table.insert(t, {["name"] = "Foo"});
--| table.insert(t, {["name"] = "Bar", ["note"] = 5});
--| table.insert(t, {["name"] = "Baz"});
--| Aye.modules.Warnings.report(t, "No BiS Rune");
--
-- @example output
--> WARNING! No BiS Rune (3): Foo, Bar (5), Baz
Aye.modules.Warnings.report = function(t, subject)
	-- message to report
	local message = "";
	
	for _, o in pairs(t) do
		if message ~= "" then
			message = message ..", ";
		end;
		
		message = message ..o.name;
		if type(o.note) == "number" or type(o.note) == "string" then
			message = message .." (" ..o.note ..")";
		end;
	end;
	
	-- if message should be printed instead of sent
	local bPrint = (
			Aye.db.global.Warnings.channel == "Print"
		or	(
					(
							Aye.db.global.Warnings.channel == "RW"
						or	Aye.db.global.Warnings.channel == "Raid"
					)
				and	not IsInGroup()
			)
		or	(
					(
							Aye.db.global.PullTime.channel == "Guild"
						or	Aye.db.global.PullTime.channel == "Officer"
					)
				and	not IsInGuild()
			)
		or	(
					Aye.db.global.Warnings.forcePrintInGuildGroup
				and	Aye.utils.Player.InAllyGroup()
			)
	);
	
	-- prefix of message
	local prefix = "";
	if Aye.db.global.Warnings.reportWithAyePrefix then
		prefix = prefix ..(bPrint and "|cff9d9d9d[|r|cffe6cc80Aye|r|cff9d9d9d]|r " or "[Aye] ");
	end;
	if Aye.db.global.Warnings.reportWithWarningPrefix then
		-- "WARNING!" spell
		prefix = prefix ..GetSpellLink(176781) .." ";
	end;
	
	message = prefix ..subject .." (" ..#t .."): " ..message;
	
	if bPrint then
		print(message);
	elseif Aye.db.global.Warnings.channel == "Dynamic" then
		Aye.utils.Chat.SendChatMessage(message);
	elseif Aye.db.global.Warnings.channel == "RW" then
		SendChatMessage(message, Aye.utils.Chat.GetGroupChannel(true));
	elseif Aye.db.global.Warnings.channel == "Raid" then
		SendChatMessage(message, Aye.utils.Chat.GetGroupChannel(false));
	else
		SendChatMessage(message, Aye.db.global.Warnings.channel);
	end;
	
	if
			IsInGroup()
		and	Aye.db.global.Warnings.channel ~= "Print"
	then
		-- prepare subject for addon message
		--if subject == "Offline"			then subject = "Offline"	end;
		--if subject == "AFK"				then subject = "AFK"		end;
		--if subject == "Dead"				then subject = "Dead"		end;
		if subject == "Far Away"			then subject = "FarAway"	end;
		if subject == GetSpellLink(15007)	then subject = "Sick"		end;
		if subject == "No BiS Flask"		then subject = "Flask"		end;
		if subject == "No Rune"				then subject = "Rune"		end;
		if subject == "Not Well Fed"		then subject = "WellFed"	end;
		
		-- tell other Aye users that we handled event already
		SendAddonMessage("Aye", "Warnings." ..subject, Aye.utils.Chat.GetGroupChannel(false));
		
		-- tell ExRT that Aye handled raidcheck buffs already and instruct him not to do it too
		-- for some incomprehensible reson, ExRT shall listen us only if our nick is… earlier in alphabetical order than message recipient's name,
		-- and only if recipient isn't group leader or assistant. finally, if we are group leader or assistant, and recipient not,
		-- ExRT shall listen to us even if our name is later in alphabetical order than message recipient's name.
		-- this unreliable spam preventing depends on character name and needs to be fixed in ExRT
		if subject == "Flask"	then SendAddonMessage("raidcheck", "FOOD",	Aye.utils.Chat.GetGroupChannel(false)) end;
		if subject == "Rune"	then SendAddonMessage("raidcheck", "FLASK",	Aye.utils.Chat.GetGroupChannel(false)) end;
		if subject == "WellFed"	then SendAddonMessage("raidcheck", "RUNES",	Aye.utils.Chat.GetGroupChannel(false)) end;
		
		-- tell RBS that Aye handled raidcheck buffs already and instruct him not to do it too
		-- for some incomprehensible reson, RBS won't listen if recipient nick is… Шуршик, Шурши or Шурш,
		-- or if recipient is group leader or assistant. finally, RSC packs Flask, Rune and WellFed checks in one, single message (a50)
		SendAddonMessage("RSCaddon", "a50", Aye.utils.Chat.GetGroupChannel(false));
	end;
end;