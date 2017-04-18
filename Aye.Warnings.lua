local Aye = Aye;
if not Aye.addModule("Aye.Warnings") then return end;

Aye.modules.Warnings.OnEnable = function()
	-- start profiling (used to get ms precision)
	if debugprofilestop() == nil then
		debugprofilestart();
	end;
	
	RegisterAddonMessagePrefix("Aye");			-- Aye
	RegisterAddonMessagePrefix("D4");			-- DBM
	RegisterAddonMessagePrefix("raidcheck");	-- ExRT
	RegisterAddonMessagePrefix("RSCaddon");		-- RSC
	
	-- list of subjects that won't be checked
	-- considering others made it already
	-- aka anti chat spam system
	Aye.modules.Warnings.disableNotify = {};
end;

Aye.modules.Warnings.events.READY_CHECK = function(...)
	if
			Aye.db.global.Warnings.enable
		and	Aye.db.global.Warnings.enableReadyCheck
	then
		Aye.modules.Warnings.warn();
	end;
end;

Aye.modules.Warnings.events.CHAT_MSG_ADDON = function(...)
	local prefix, message, _, sender = ...;
	
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
	-- |         Dead | Player is Dead                                 |
	-- |      FarAway | Player is Far Awar (not UnitIsVisible)         |
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
		and	message ~= nil
		and not UnitIsUnit(sender, "player")
	then
		local subject = message:match("^Warnings%.(.+)");
		
		if
				subject == "Offline"
			and	(
						Aye.modules.Warnings.disableNotify.Offline == nil
					or	Aye.modules.Warnings.disableNotify.Offline +10000 >= debugprofilestop()
				)
		then
			Aye.modules.Warnings.disableNotify.Offline = debugprofilestop();
		end;
		if
				subject == "Dead"
			and	(
						Aye.modules.Warnings.disableNotify.Dead == nil
					or	Aye.modules.Warnings.disableNotify.Dead +10000 >= debugprofilestop()
				)
		then
			Aye.modules.Warnings.disableNotify.Dead = debugprofilestop();
		end;
		if
				subject == "FarAway"
			and	(
						Aye.modules.Warnings.disableNotify.FarAway == nil
					or	Aye.modules.Warnings.disableNotify.FarAway +10000 >= debugprofilestop()
				)
		then
			Aye.modules.Warnings.disableNotify.FarAway = debugprofilestop();
		end;
		if
				subject == "Flask"
			and	(
						Aye.modules.Warnings.disableNotify.Flask == nil
					or	Aye.modules.Warnings.disableNotify.Flask +10000 >= debugprofilestop()
				)
		then
			Aye.modules.Warnings.disableNotify.Flask = debugprofilestop();
		end;
		if
				subject == "Rune"
			and	(
						Aye.modules.Warnings.disableNotify.Rune == nil
					or	Aye.modules.Warnings.disableNotify.Rune +10000 >= debugprofilestop()
				)
		then
			Aye.modules.Warnings.disableNotify.Rune = debugprofilestop();
		end;
		if
				subject == "WellFed"
			and	(
						Aye.modules.Warnings.disableNotify.WellFed == nil
					or	Aye.modules.Warnings.disableNotify.WellFed +10000 >= debugprofilestop()
				)
		then
			Aye.modules.Warnings.disableNotify.WellFed = debugprofilestop();
		end;
	end;
	
	-- DBM Pull Time broadcast handle
	if
			prefix == "D4"
		and	message ~= nil
		and	(
					UnitIsGroupLeader(sender)
				or	UnitIsGroupAssistant(sender)
			)
	then
		local seconds = message:match("^PT\t(%d+)");
		if seconds ~= nil then
			seconds = tonumber(seconds);
			if seconds >0 then
				-- DBM Pull
				if
						Aye.db.global.Warnings.enable
					and	Aye.db.global.Warnings.enablePull
				then
					Aye.modules.Warnings.warn();
				end;
			end;
		end;
	end;
	
	-- ExRT raidcheck broadcast handle
	if
			prefix == "raidcheck"
		and	Aye.db.global.Warnings.EnableIntegrationExRT
	then
		if
				message == "FOOD"
			and	(
						Aye.modules.Warnings.disableNotify.WellFed == nil
					or	Aye.modules.Warnings.disableNotify.WellFed +10000 >= debugprofilestop()
				)
		then
			Aye.modules.Warnings.disableNotify.WellFed = debugprofilestop();
		end;
		if
				message == "FLASK"
			and	(
						Aye.modules.Warnings.disableNotify.Flask == nil
					or	Aye.modules.Warnings.disableNotify.Flask +10000 >= debugprofilestop()
				)
		then
			Aye.modules.Warnings.disableNotify.Flask = debugprofilestop();
		end;
		if
				message == "RUNES"
			and	(
						Aye.modules.Warnings.disableNotify.Rune == nil
					or	Aye.modules.Warnings.disableNotify.Rune +10000 >= debugprofilestop()
				)
		then
			Aye.modules.Warnings.disableNotify.Rune = debugprofilestop();
		end;
	end;
	
	-- RSC raidcheck broadcast handle
	if
			prefix == "RSCaddon"
		and	message == "a50"
		and	Aye.db.global.Warnings.EnableIntegrationRSC
	then
		if (
				Aye.modules.Warnings.disableNotify.WellFed == nil
			or	Aye.modules.Warnings.disableNotify.WellFed +10000 >= debugprofilestop()
		)
		then
			Aye.modules.Warnings.disableNotify.WellFed = debugprofilestop();
		end;
		if (
				Aye.modules.Warnings.disableNotify.Flask == nil
			or	Aye.modules.Warnings.disableNotify.Flask +10000 >= debugprofilestop()
		)
		then
			Aye.modules.Warnings.disableNotify.Flask = debugprofilestop();
		end;
		if (
				Aye.modules.Warnings.disableNotify.Rune == nil
			or	Aye.modules.Warnings.disableNotify.Rune +10000 >= debugprofilestop()
		)
		then
			Aye.modules.Warnings.disableNotify.Rune = debugprofilestop();
		end;
	end;
end;

Aye.modules.Warnings.slash = function()
	Aye.modules.Warnings.disableNotify = {};
	Aye.modules.Warnings.warn();
end;

-- Check group and eventually warn about failings
--
-- @noparam
-- @noreturn
Aye.modules.Warnings.warn = function()
	local members = max(1, GetNumGroupMembers());
	
	-- table of subjects to check
	-- every subject contains:
	-- 	t		-- 				table of players that met criteria, ex. list of Dead Players for Dead subject
	-- 	name	-- 				name of subject to report, ex. "No BiS Rune" for Rune subject
	--
	-- Every .t and contains table:
	--	name	--				name of player
	--	note	-- optional,	additional note to display for player
	local t = {
		Offline		= {t = {}, name = "Offline"},
		Dead		= {t = {}, name = "Dead"},
		FarAway		= {t = {}, name = "Far Away"},
		Flask		= {t = {}, name = "No BiS Flask"},
		Rune		= {t = {}, name = "No Rune"},
		WellFed		= {t = {}, name = "Not Well Fed"},
	};
	
	-- check subjects
	for i = 1, members do
		-- in raid, every player have "raidX" id where id begins from 1 and ends with member number
		-- in party, there is always "player" and every NEXT members are "partyX" where X begins from 1
		-- especially, in full party, there are: "player", "party1", "party2", "party3", "party4" and NO "party5"
		local unitID = UnitInRaid("player") ~= nil and "raid" ..i or (i == 1 and "player" or "party" ..(i -1));
		local name = UnitName(unitID);
		
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
			and	(
						Aye.modules.Warnings.disableNotify.Offline == nil
					or	Aye.modules.Warnings.disableNotify.Offline +10000 >= debugprofilestop()
				)
			and	not	UnitIsConnected(unitID)
		then
			table.insert(t.Offline.t, {["name"] = name});
		end;
		
		if UnitIsConnected(unitID) then
		if
				Aye.db.global.Warnings.Dead
			and	(
						Aye.modules.Warnings.disableNotify.Dead == nil
					or	Aye.modules.Warnings.disableNotify.Dead +10000 >= debugprofilestop()
				)
			and	UnitIsDeadOrGhost(unitID)
		then
			table.insert(t.Dead.t, {["name"] = name});
		end;
		
		if not UnitIsDeadOrGhost(unitID) then
		if
				Aye.db.global.Warnings.FarAway
			and	(
						Aye.modules.Warnings.disableNotify.FarAway == nil
					or	Aye.modules.Warnings.disableNotify.FarAway +10000 >= debugprofilestop()
				)
			and	not	UnitIsVisible(unitID)
		then
			table.insert(t.FarAway.t, {["name"] = name});
		end;
		
		if UnitIsVisible(unitID) then -- credits for checking function to: Vlad#WoWUIDev and nebula#WoWUIDev
			for k, v in pairs({
				-- ["c"]ondition setting
				-- ["f"]unction to check condition
				-- ["2"]nd function argument
				-- ["t"]able to insert players
				{
					["c"] =
							(
									Aye.modules.Warnings.disableNotify.Flask == nil
								or	Aye.modules.Warnings.disableNotify.Flask +10000 >= debugprofilestop()
							)
						and	Aye.db.global.Warnings.Flask,
					["f"] = Aye.utils.Buffs.UnitHasFlask,
					["2"] = nil,
					["t"] = t.Flask.t
				},
				{
					["c"] =
							(
									Aye.modules.Warnings.disableNotify.Rune == nil
								or	Aye.modules.Warnings.disableNotify.Rune +10000 >= debugprofilestop()
							)
						and	Aye.db.global.Warnings.Rune,
					["f"] = Aye.utils.Buffs.UnitHasRune,
					["2"] = nil,
					["t"] = t.Rune.t
				},
				{
					["c"] =
							(
									Aye.modules.Warnings.disableNotify.WellFed == nil
								or	Aye.modules.Warnings.disableNotify.WellFed +10000 >= debugprofilestop()
							)
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
	
	-- Force Disable if Mythic Benched
	if
			Aye.db.global.Warnings.ForceDisableIfMythicBenched
		and	Aye.utils.Player.IsMythicBenched()
	then return end;
	
	if (
			-- Force enable
			(
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
			-- Disable
		or	not (
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
	) then
		-- report subjects
		for k, v in pairs(t) do
			if Aye.db.global.Warnings[k] and #v.t >0 then Aye.modules.Warnings.report(v.t, v.name) end;
		end;
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
	local m = "";
	for i, o in pairs(t) do
		if m ~= "" then
			m = m ..", ";
		end;
		
		m = m ..o.name;
		if type(o.note) == "number" or type(o.note) == "string" then
			m = m .." (" ..o.note ..")";
		end;
	end;
	
	m = "[Aye] ".. GetSpellLink(176781) -- "WARNING!" spell
		.." " ..subject .." (" ..#t .."): " ..m;
	
	if
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
	then
		print(m);
	elseif Aye.db.global.Warnings.channel == "Dynamic" then
		Aye.utils.Chat.SendChatMessage(m);
	elseif Aye.db.global.Warnings.channel == "RW" then
		SendChatMessage(m, Aye.utils.Chat.GetGroupChannel(true));
	elseif Aye.db.global.Warnings.channel == "Raid" then
		SendChatMessage(m, Aye.utils.Chat.GetGroupChannel(false));
	else
		SendChatMessage(m, Aye.db.global.Warnings.channel);
	end;
	
	if
			IsInGroup()
		and	Aye.db.global.Warnings.channel ~= "Print"
	then
		-- prepare subject for addon message
		--if subject == "Offline"		then subject = "Offline"	end;
		--if subject == "Dead"			then subject = "Dead"		end;
		if subject == "Far Away"		then subject = "FarAway"	end;
		if subject == "No BiS Flask"	then subject = "Flask"		end;
		if subject == "No Rune"			then subject = "Rune"		end;
		if subject == "Not Well Fed"	then subject = "WellFed"	end;
		
		-- tell other Aye users that we handled event already
		SendAddonMessage("Aye", "Warnings." ..subject, "RAID");
		
		-- tell ExRT that Aye handled raidcheck buffs already and instruct him not to do it too
		-- for some incomprehensible reson, ExRT shall listen us only if our nick is… earlier in alphabetical order than message recipient's name,
		-- and only if recipient isn't group leader or assistant. finally, if we are group leader or assistant, and recipient not,
		-- ExRT shall listen to us even if our name is later in alphabetical order than message recipient's name.
		-- this unreliable spam preventing depends on character name and needs to be fixed in ExRT
		if subject == "Flask"	then SendAddonMessage("raidcheck", "FOOD",	"RAID") end;
		if subject == "Rune"	then SendAddonMessage("raidcheck", "FLASK",	"RAID") end;
		if subject == "WellFed"	then SendAddonMessage("raidcheck", "RUNES",	"RAID") end;
		
		-- tell RBS that Aye handled raidcheck buffs already and instruct him not to do it too
		-- for some incomprehensible reson, ExRT won't listen uf recipient nick is… Шуршик, Шурши or Шурш,
		-- or if recipient is group leader or assistant. finally, RSC packs Flask, Rune and WellFed checks in one, single message (a50)
		SendAddonMessage("RSCaddon", "a50", "RAID");
	end;
end;