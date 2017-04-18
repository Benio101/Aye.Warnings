local Aye = Aye;
if not Aye.load then return end;

Aye.default.global.Warnings = {
	enable = true,						-- Enable
	enableReadyCheck = true,			-- Enable on Ready Check
	enablePull = true,					-- Enable on Pull
	Offline = true,						-- Show warning about Offline players
	Dead = true,						-- Show warning about Dead players
	FarAway = true,						-- Show warning about Far Away players
	Flask = true,						-- Show warning about players with no BiS flask
	Rune = false,						-- Show warning about players with no BiS rune
	WellFed = true,						-- Show warning about players with no BiS Well Fed buff
	WellFedTier = 3,					-- Minimum required Well Fed Tier (5 is BiS only)
	BuffTimeEnable = true,				-- Enable Minimum Buff Time setting
	BuffTime = 10,						-- Show warning about players with buffs close to expire (with remaining time left ≤ given minutes)
	ForceDisableIfMythicBenched = true,	-- Force Disable if Mythic Benched
	GuildGroupDisable = false,			-- Disable in Guild group
	LFGDisable = false,					-- Disable in LFG group
	PvPDisable = true,					-- Disable on PvP (arena, battleground)
	OutsideInstanceDisable = false,		-- Disable outside Instance
	GuildGroupForceEnable = true,		-- Force Enable in Guild group
	LFGForceEnable = false,				-- Force Enable in LFG group
	PvPForceEnable = false,				-- Force Enable on PvP (arena, battleground)
	OutsideInstanceForceEnable = false,	-- Force Enable outside Instance
	channel = "Raid",					-- The chat channel where message will be sent
	forcePrintInGuildGroup = false,		-- In Guild group prints message instead of sending it on chat
	EnableIntegrationExRT = true,		-- Enable Exorsus Raid Tools addon messages integration
	EnableIntegrationRSC = true,		-- Enable Raid Slack Check addon messages integration
};