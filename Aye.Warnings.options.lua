local Aye = Aye;
if not Aye.load then return end;

Aye.options.args.Warnings = {
	name = "Warnings",
	type = "group",
	args = {
		header1 = {
			order = 1,
			type = "header",
			name = "Warnings",
		},
		description2 = {
			order = 2,
			type = "description",
			name = "Show conditional warnings on Ready Check and Pull, like when a player is Dead, ex.:\n\n"
				.. "|c" .. RAID_CLASS_COLORS[select(2, UnitClass("player"))].colorStr .. UnitName("player") .. "|r: " .. GetSpellLink(176781) .. " Dead (1): Foo\n"
				.. "|c" .. RAID_CLASS_COLORS[select(2, UnitClass("player"))].colorStr .. UnitName("player") .. "|r: " .. GetSpellLink(176781)
				.. " Not Well Fed (3): Foo, Bar (75), Baz (|cffffffff|Hitem:109147:0:0:0:0:0:0:0:0:0:0|h[Draenic Intellect Flask]|h|r)\n"
			,
		},
		enable = {
			order = 3,
			name = "Enable",
			desc = "Enable Warnings",
			type = "toggle",
			get = function() return Aye.db.global.Warnings.enable end,
			set = function(_, v) Aye.db.global.Warnings.enable = v end,
		},
		execute5 = {
			order = 5,
			type = "execute",
			name = "Disable & Reload",
			func = function() DisableAddOn("Aye.Warnings"); ReloadUI(); end,
			hidden = function() return Aye.db.global.Warnings.enable end,
		},
		description6 = {
			order = 6,
			type = "description",
			name = "This module is currently temporary |cff9d9d9ddisabled|r at will and should no longer work.\n"
				.. "|cff9d9d9dIf you wish to keep this module disabled, you should disable related addon completelly.\n"
				.. "You can always re–enable module by re–enabling related addon addon the same way.\n|r"
			,
			hidden = function() return Aye.db.global.Warnings.enable end,
		},
		execute7 = {
			order = 7,
			type = "execute",
			name = "Default module settings",
			desc = "Reset settings of this module to default.\n\n|cff9d9d9dIf you wish to reset settings of all Aye modules instead, "
				.. "use \"Defaults\" options from left bottom corner of \"Interface\" window, then select \"These Settings\".|r"
			,
			func = function()
				Aye.db.global.Warnings = CopyTable(Aye.default.global.Warnings);
				Aye.libs.ConfigRegistry:NotifyChange("Aye");
			end,
			hidden = function() return not Aye.db.global.Warnings.enable end,
		},
		enableReadyCheck = {
			order = 11,
			name = "|cffe6cc80Enable|r on Ready Check",
			type = "toggle",
			get = function() return Aye.db.global.Warnings.enableReadyCheck end,
			set = function(_, v) Aye.db.global.Warnings.enableReadyCheck = v end,
			disabled = function() return not Aye.db.global.Warnings.enable end,
		},
		enablePull = {
			order = 12,
			name = "|cffe6cc80Enable|r on Pull Timer",
			type = "toggle",
			get = function() return Aye.db.global.Warnings.enablePull end,
			set = function(_, v) Aye.db.global.Warnings.enablePull = v end,
			disabled = function() return not Aye.db.global.Warnings.enable end,
		},
		IgnoreBenched = {
			order = 19,
			name = "|cffe6cc80Ignore|r Benched players |cff9d9d9d(players in Ally Group outside party #1–4/6)|r",
			desc = "|cffe6cc80Ignore|r players in Ally Group |cff9d9d9d(at least half of other members are either friends or guildmates)|r that are outside party"
				.. " #1–4 |cff9d9d9d(on Mythic difficulty)|r or #1–6 |cff9d9d9d(on Normal/Heroic difficulty)|r.\n\n"
				.. "|cffe6cc80Ignore|r|cff9d9d9d causes benched players not to be reported at all.|r"
			,
			type = "toggle",
			width = "full",
			get = function() return Aye.db.global.Warnings.IgnoreBenched end,
			set = function(_, v) Aye.db.global.Warnings.IgnoreBenched = v end,
			disabled = function() return
					not Aye.db.global.Warnings.enable
				or	(
							not Aye.db.global.Warnings.enableReadyCheck
						and	not Aye.db.global.Warnings.enablePull
					)
			end,
		},
		header31 = {
			order = 31,
			type = "header",
			name = "Warning subjects",
		},
		Offline = {
			order = 33,
			name = "|cffe6cc80Report|r Offline",
			type = "toggle",
			get = function() return Aye.db.global.Warnings.Offline end,
			set = function(_, v) Aye.db.global.Warnings.Offline = v end,
			disabled = function() return
					not Aye.db.global.Warnings.enable
				or	(
							not Aye.db.global.Warnings.enableReadyCheck
						and	not Aye.db.global.Warnings.enablePull
					)
			end,
		},
		AFK = {
			order = 34,
			name = "|cffe6cc80Report|r AFK",
			type = "toggle",
			get = function() return Aye.db.global.Warnings.AFK end,
			set = function(_, v) Aye.db.global.Warnings.AFK = v end,
			disabled = function() return
					not Aye.db.global.Warnings.enable
				or	(
							not Aye.db.global.Warnings.enableReadyCheck
						and	not Aye.db.global.Warnings.enablePull
					)
			end,
		},
		Dead = {
			order = 36,
			name = "|cffe6cc80Report|r Dead",
			type = "toggle",
			get = function() return Aye.db.global.Warnings.Dead end,
			set = function(_, v) Aye.db.global.Warnings.Dead = v end,
			disabled = function() return
					not Aye.db.global.Warnings.enable
				or	(
							not Aye.db.global.Warnings.enableReadyCheck
						and	not Aye.db.global.Warnings.enablePull
					)
			end,
		},
		FarAway = {
			order = 37,
			name = "|cffe6cc80Report|r Far away",
			type = "toggle",
			get = function() return Aye.db.global.Warnings.FarAway end,
			set = function(_, v) Aye.db.global.Warnings.FarAway = v end,
			disabled = function() return
					not Aye.db.global.Warnings.enable
				or	(
							not Aye.db.global.Warnings.enableReadyCheck
						and	not Aye.db.global.Warnings.enablePull
					)
			end,
		},
		Sick = {
			order = 39,
			name = "|cffe6cc80Report|r players with " ..GetSpellLink(15007) .." debuff",
			type = "toggle",
			width = "full",
			get = function() return Aye.db.global.Warnings.Sick end,
			set = function(_, v) Aye.db.global.Warnings.Sick = v end,
			disabled = function() return
					not Aye.db.global.Warnings.enable
				or	(
							not Aye.db.global.Warnings.enableReadyCheck
						and	not Aye.db.global.Warnings.enablePull
					)
			end,
		},
		group41 = {
			order = 41,
			type = "group",
			inline = true,
			name = "",
			args = {
				Flask = {
					order = 43,
					name = "|cffe6cc80Report|r No BiS Flask",
					type = "toggle",
					get = function() return Aye.db.global.Warnings.Flask end,
					set = function(_, v) Aye.db.global.Warnings.Flask = v end,
					disabled = function() return
							not Aye.db.global.Warnings.enable
						or	(
									not Aye.db.global.Warnings.enableReadyCheck
								and	not Aye.db.global.Warnings.enablePull
							)
					end,
				},
				Rune = {
					order = 44,
					name = "|cffe6cc80Report|r No Rune",
					type = "toggle",
					get = function() return Aye.db.global.Warnings.Rune end,
					set = function(_, v) Aye.db.global.Warnings.Rune = v end,
					disabled = function() return
							not Aye.db.global.Warnings.enable
						or	(
									not Aye.db.global.Warnings.enableReadyCheck
								and	not Aye.db.global.Warnings.enablePull
							)
					end,
				},
				WellFed = {
					order = 46,
					name = "|cffe6cc80Report|r Not Well Fed",
					type = "toggle",
					get = function() return Aye.db.global.Warnings.WellFed end,
					set = function(_, v) Aye.db.global.Warnings.WellFed = v end,
					disabled = function() return
							not Aye.db.global.Warnings.enable
						or	(
									not Aye.db.global.Warnings.enableReadyCheck
								and	not Aye.db.global.Warnings.enablePull
							)
					end,
				},
				WellFedTier = {
					order = 47,
					name = "Required Well Fed Tier",
					desc = "Minimum required Well Fed Tier\n\nTier 1: +225 stat or |cffffffff|Hitem:133564::::::::110:265::::::|h[Spiced Rib Roast]|h|r\n"
						.. "Tier 2: +300 stat or |cffffffff|Hitem:133569::::::::110:265::::::|h[Drogbar-Style Salmon]|h|r\n"
						.. "Tier 3: +375 stat or |cffffffff|Hitem:133574::::::::110:265::::::|h[Fishbrul Special]|h|r\n"
						.. "Tier 4: +400 stat or +600 stamina\nTier 5: +500 stat or +750 stamina"
					,
					type = "range",
					min = 1,
					max = 5,
					softMin = 1,
					softMax = 5,
					bigStep = 1,
					get = function() return Aye.db.global.Warnings.WellFedTier end,
					set = function(_, v) Aye.db.global.Warnings.WellFedTier = v end,
					disabled = function() return
							(
									not Aye.db.global.Warnings.enable
								or	(
											not Aye.db.global.Warnings.enableReadyCheck
										and	not Aye.db.global.Warnings.enablePull
									)
							)
						or	not Aye.db.global.Warnings.WellFed
					end,
				},
				header51 = {
					order = 51,
					type = "header",
					name = "Minimum Buff Time",
				},
				BuffTimeEnable = {
					order = 53,
					name = "Enable Minimum Buff Time",
					type = "toggle",
					get = function() return Aye.db.global.Warnings.BuffTimeEnable end,
					set = function(_, v) Aye.db.global.Warnings.BuffTimeEnable = v end,
					disabled = function() return
							(
									not Aye.db.global.Warnings.enable
								or	(
											not Aye.db.global.Warnings.enableReadyCheck
										and	not Aye.db.global.Warnings.enablePull
									)
							)
						or	(
									not Aye.db.global.Warnings.Flask
								and	not Aye.db.global.Warnings.Rune
								and	not Aye.db.global.Warnings.WellFed
								and	not Aye.db.global.Warnings.RaidBuffs
							)
					end,
				},
				BuffTime = {
					order = 54,
					name = "Minimum Buff Time |cff9d9d9d(min)|r",
					desc = "Show warning about players with buffs close to expire |cff9d9d9d(with remaining time left ≤ given minutes)|r",
					type = "range",
					min = 0,
					max = 60,
					softMin = 0,
					softMax = 20,
					bigStep = 1,
					get = function() return Aye.db.global.Warnings.BuffTime end,
					set = function(_, v) Aye.db.global.Warnings.BuffTime = v end,
					disabled = function() return
							(
									not Aye.db.global.Warnings.enable
								or	(
											not Aye.db.global.Warnings.enableReadyCheck
										and	not Aye.db.global.Warnings.enablePull
									)
							)
						or	not Aye.db.global.Warnings.BuffTimeEnable
						or	(
									not Aye.db.global.Warnings.Flask
								and	not Aye.db.global.Warnings.Rune
								and	not Aye.db.global.Warnings.WellFed
								and	not Aye.db.global.Warnings.RaidBuffs
							)
					end,
				},
			},
		},
		header71 = {
			order = 71,
			type = "header",
			name = "Instance Filter",
		},
		GuildGroupDisable = {
			order = 73,
			name = "|cffe6cc80Disable|r in Ally Group",
			desc = "|cffe6cc80Disable|r in Ally Group |cff9d9d9d(at least half of other members are either friends or guildmates)|r",
			type = "toggle",
			get = function() return Aye.db.global.Warnings.GuildGroupDisable end,
			set = function(_, v) Aye.db.global.Warnings.GuildGroupDisable = v end,
			disabled = function() return
					(
							not Aye.db.global.Warnings.enable
						or	(
									not Aye.db.global.Warnings.enableReadyCheck
								and	not Aye.db.global.Warnings.enablePull
							)
					)
				or	Aye.db.global.Warnings.GuildGroupForceEnable
			end,
		},
		LFGDisable = {
			order = 74,
			name = "|cffe6cc80Disable|r in LFG group",
			type = "toggle",
			get = function() return Aye.db.global.Warnings.LFGDisable end,
			set = function(_, v) Aye.db.global.Warnings.LFGDisable = v end,
			disabled = function() return
					(
							not Aye.db.global.Warnings.enable
						or	(
									not Aye.db.global.Warnings.enableReadyCheck
								and	not Aye.db.global.Warnings.enablePull
							)
					)
				or	Aye.db.global.Warnings.LFGForceEnable
			end,
		},
		PvPDisable = {
			order = 76,
			name = "|cffe6cc80Disable|r on PvP",
			type = "toggle",
			get = function() return Aye.db.global.Warnings.PvPDisable end,
			set = function(_, v) Aye.db.global.Warnings.PvPDisable = v end,
			disabled = function() return
					(
							not Aye.db.global.Warnings.enable
						or	(
									not Aye.db.global.Warnings.enableReadyCheck
								and	not Aye.db.global.Warnings.enablePull
							)
					)
				or	Aye.db.global.Warnings.PvPForceEnable
			end,
		},
		OutsideInstanceDisable = {
			order = 77,
			name = "|cffe6cc80Disable|r outside Instance",
			type = "toggle",
			get = function() return Aye.db.global.Warnings.OutsideInstanceDisable end,
			set = function(_, v) Aye.db.global.Warnings.OutsideInstanceDisable = v end,
			disabled = function() return
					(
							not Aye.db.global.Warnings.enable
						or	(
									not Aye.db.global.Warnings.enableReadyCheck
								and	not Aye.db.global.Warnings.enablePull
							)
					)
				or	Aye.db.global.Warnings.OutsideInstanceForceEnable
			end,
		},
		header81 = {
			order = 81,
			type = "header",
			name = "Force Enable",
		},
		description82 = {
			order = 82,
			type = "description",
			name = "|cffe6cc80Force Enable|r Warnings independing of Instance Filter.\n",
		},
		GuildGroupForceEnable = {
			order = 83,
			name = "|cffe6cc80Force Enable|r in Ally Group",
			desc = "|cffe6cc80Force Enable|r in Ally Group |cff9d9d9d(at least half of other members are either friends or guildmates)|r",
			type = "toggle",
			get = function() return Aye.db.global.Warnings.GuildGroupForceEnable end,
			set = function(_, v) Aye.db.global.Warnings.GuildGroupForceEnable = v end,
			disabled = function() return
					(
							not Aye.db.global.Warnings.enable
						or	(
									not Aye.db.global.Warnings.enableReadyCheck
								and	not Aye.db.global.Warnings.enablePull
							)
					)
				or	Aye.db.global.Warnings.GuildGroupDisable
			end,
		},
		LFGForceEnable = {
			order = 84,
			name = "|cffe6cc80Force Enable|r in LFG group",
			type = "toggle",
			get = function() return Aye.db.global.Warnings.LFGForceEnable end,
			set = function(_, v) Aye.db.global.Warnings.LFGForceEnable = v end,
			disabled = function() return
					(
							not Aye.db.global.Warnings.enable
						or	(
									not Aye.db.global.Warnings.enableReadyCheck
								and	not Aye.db.global.Warnings.enablePull
							)
					)
				or	Aye.db.global.Warnings.LFGDisable
			end,
		},
		PvPForceEnable = {
			order = 86,
			name = "|cffe6cc80Force Enable|r on PvP",
			type = "toggle",
			get = function() return Aye.db.global.Warnings.PvPForceEnable end,
			set = function(_, v) Aye.db.global.Warnings.PvPForceEnable = v end,
			disabled = function() return
					(
							not Aye.db.global.Warnings.enable
						or	(
									not Aye.db.global.Warnings.enableReadyCheck
								and	not Aye.db.global.Warnings.enablePull
							)
					)
				or	Aye.db.global.Warnings.PvPDisable
			end,
		},
		OutsideInstanceForceEnable = {
			order = 87,
			name = "|cffe6cc80Force Enable|r outside Instance",
			type = "toggle",
			get = function() return Aye.db.global.Warnings.OutsideInstanceForceEnable end,
			set = function(_, v) Aye.db.global.Warnings.OutsideInstanceForceEnable = v end,
			disabled = function() return
					(
							not Aye.db.global.Warnings.enable
						or	(
									not Aye.db.global.Warnings.enableReadyCheck
								and	not Aye.db.global.Warnings.enablePull
							)
					)
				or	Aye.db.global.Warnings.OutsideInstanceDisable
			end,
		},
		header91 = {
			order = 91,
			type = "header",
			name = "Force Disable",
		},
		description92 = {
			order = 92,
			type = "description",
			name = "|cffe6cc80Force Disable|r is most important and overwrites even |cffe6cc80Force Enable|r.\n",
		},
		ForceDisableIfBenched = {
			order = 93,
			name = "|cffe6cc80Force Disable|r if Benched |cff9d9d9d(in Ally Group outside party #1–4/6)|r",
			desc = "|cffe6cc80Force Disable|r in Ally Group |cff9d9d9d(at least half of other members are either friends or guildmates)|r if outside party"
				.. " #1–4 |cff9d9d9d(on Mythic difficulty)|r or #1–6 |cff9d9d9d(on Normal/Heroic difficulty)|r.\n\n"
			,
			type = "toggle",
			width = "full",
			get = function() return Aye.db.global.Warnings.ForceDisableIfBenched end,
			set = function(_, v) Aye.db.global.Warnings.ForceDisableIfBenched = v end,
			disabled = function() return
					not Aye.db.global.Warnings.enable
				or	(
							not Aye.db.global.Warnings.enableReadyCheck
						and	not Aye.db.global.Warnings.enablePull
					)
			end,
		},
		header111 = {
			order = 111,
			type = "header",
			name = "Chat",
		},
		description112 = {
			order = 112,
			type = "description",
			name = "\"|cffe6cc80Raid|r\" means \"|cfff3e6c0Instance|r\" in LFR, or \"|cfff3e6c0Party|r\" if player is not in raid."
				.. "\n\"|cffe6cc80Raid Warning|r\" channel behaves like \"|cffe6cc80Raid|r\" if player cannot Raid Warning."
				.. "\n\"|cffe6cc80Dynamic|r\" is min. channel, where everybody can hear you (\"|cfff3e6c0Say|r\", \"|cfff3e6c0Yell|r\", or \"|cffe6cc80Raid|r\").\n"
			,
		},
		channel = {
			order = 113,
			name = "Chat Channel",
			desc = "The chat channel where message will be sent",
			type = "select",
			values = {
				Print	= "|cff9d9d9dPrint|r",
				Say		= "|cffffffffSay|r",
				Yell	= "|cffffffffYell|r",
				Raid	= "|cffe6cc80Raid|r",
				RW		= "|cffe6cc80Raid Warning|r",
				Dynamic	= "|cffe6cc80Dynamic|r",
				Guild	= "|cffffffffGuild|r",
				Officer	= "|cffffffffOfficer|r",
			},
			get = function() return Aye.db.global.Warnings.channel end,
			set = function(_, v) Aye.db.global.Warnings.channel = v end,
			disabled = function() return
					not Aye.db.global.Warnings.enable
				or	(
							not Aye.db.global.Warnings.enableReadyCheck
						and	not Aye.db.global.Warnings.enablePull
					)
			end,
		},
		forcePrintInGuildGroup = {
			order = 114,
			name = "|cffe6cc80Force Print|r in Ally Group",
			desc = "In Ally Group |cff9d9d9d(at least half of other members are either friends or guildmates)|r prints message instead of sending it on chat",
			type = "toggle",
			get = function() return Aye.db.global.Warnings.forcePrintInGuildGroup end,
			set = function(_, v) Aye.db.global.Warnings.forcePrintInGuildGroup = v end,
			disabled = function() return
					(
							not Aye.db.global.Warnings.enable
						or	(
									not Aye.db.global.Warnings.enableReadyCheck
								and	not Aye.db.global.Warnings.enablePull
							)
					)
				or	Aye.db.global.Warnings.channel == "Print"
			end,
		},
		reportWithAyePrefix = {
			order = 117,
			name = "Add inline |cff9d9d9d\"[|r|cffe6cc80Aye|r|cff9d9d9d] \"|r prefix before report",
			type = "toggle",
			width = "full",
			get = function() return Aye.db.global.Warnings.reportWithAyePrefix end,
			set = function(_, v) Aye.db.global.Warnings.reportWithAyePrefix = v end,
			disabled = function() return
					not Aye.db.global.Warnings.enable
				or	(
							not Aye.db.global.Warnings.enableReadyCheck
						and	not Aye.db.global.Warnings.enablePull
					)
			end,
		},
		reportWithWarningPrefix = {
			order = 118,
			name = "Add inline |cff9d9d9d\"" ..GetSpellLink(176781) .." \"|r prefix before report",
			type = "toggle",
			width = "full",
			get = function() return Aye.db.global.Warnings.reportWithWarningPrefix end,
			set = function(_, v) Aye.db.global.Warnings.reportWithWarningPrefix = v end,
			disabled = function() return
					not Aye.db.global.Warnings.enable
				or	(
							not Aye.db.global.Warnings.enableReadyCheck
						and	not Aye.db.global.Warnings.enablePull
					)
			end,
		},
		header131 = {
			order = 131,
			type = "header",
			name = "Addon integration",
		},
		description132 = {
			order = 132,
			type = "description",
			name = "\"|cffe6cc80Aye.warnings|r\" addon is intergated with some other similiar addons.\n"
				.. "Aye sends, receives and honores addon messages informing about warnings handled.\n"
				.. "This allows to avoid chat spam, sending same information by multiple addons.\n"
				.. "|cff9d9d9dIf some other addon is malfunctioning, you can disable it's intergation.|r\n"
			,
		},
		EnableIntegrationExRT = {
			order = 133,
			name = "ExRT integration",
			desc = "Enable Exorsus Raid Tools addon messages integration",
			type = "toggle",
			get = function() return Aye.db.global.Warnings.EnableIntegrationExRT end,
			set = function(_, v) Aye.db.global.Warnings.EnableIntegrationExRT = v end,
			disabled = function() return
					not Aye.db.global.Warnings.enable
				or	(
							not Aye.db.global.Warnings.enableReadyCheck
						and	not Aye.db.global.Warnings.enablePull
					)
			end,
		},
		EnableIntegrationRSC = {
			order = 134,
			name = "RSC integration",
			desc = "Enable Raid Slack Check addon messages integration",
			type = "toggle",
			get = function() return Aye.db.global.Warnings.EnableIntegrationRSC end,
			set = function(_, v) Aye.db.global.Warnings.EnableIntegrationRSC = v end,
			disabled = function() return
					not Aye.db.global.Warnings.enable
				or	(
							not Aye.db.global.Warnings.enableReadyCheck
						and	not Aye.db.global.Warnings.enablePull
					)
			end,
		},
		header151 = {
			order = 151,
			type = "header",
			name = "Antispam",
		},
		description152 = {
			order = 152,
			type = "description",
			name = "Prevent reporting same warning subjects multiple times within small amount of time.\n\n"
				.. "Once warning subjects are determined on chosen events |cff9d9d9d(like Ready Check or Pull Timer)|r, it is required to pass some time before reporting it, "
				.. "waiting for eventual addon messages from other members saying that they reported certain subjects already, so we will refrain from repeating same subject reports.\n\n"
				.. "|cffe6cc80Warnings Report Delay|r value should be slightly higher than the highest ping of any group member on any time during reports |cff9d9d9d(if unsure, |cffe6cc801000|rms is usually an optimal value)|r.\n"
			,
		},
		antispamCooldown = {
			order = 154,
			name = "Antispam Cooldown |cff9d9d9d(in s)|r",
			desc = "Minimum amount of time |cff9d9d9d(in seconds)|r that must pass before reporting again same subject.",
			type = "range",
			min = 0,
			max = 60,
			softMin = 5,
			softMax = 30,
			bigStep = 5,
			get = function() return Aye.db.global.Warnings.antispamCooldown end,
			set = function(_, v) Aye.db.global.Warnings.antispamCooldown = v end,
			disabled = function() return
					not Aye.db.global.Warnings.enable
				or	(
							not Aye.db.global.Warnings.enableReadyCheck
						and	not Aye.db.global.Warnings.enablePull
					)
			end,
		},
		antispamReportDelay = {
			order = 155,
			name = "Warnings Report Delay |cff9d9d9d(in ms)|r",
			desc = "Warnings Report Delay by specified amount of time |cff9d9d9d(in milliseconds)|r.\n\n",
			type = "range",
			min = 0,
			max = 5000,
			softMin = 0,
			softMax = 3000,
			bigStep = 200,
			get = function() return Aye.db.global.Warnings.antispamReportDelay end,
			set = function(_, v) Aye.db.global.Warnings.antispamReportDelay = v end,
			disabled = function() return
					not Aye.db.global.Warnings.enable
				or	(
							not Aye.db.global.Warnings.enableReadyCheck
						and	not Aye.db.global.Warnings.enablePull
					)
			end,
		},
	},
};