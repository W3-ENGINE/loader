--[[

                                                              
                 ▄▄▄▄▄      ▄▄▄▄▄▄▄                           
                ██▀▀▀██    █▀██▀▀▀                            
                ▀   ▄█▀      ██     ▄        ▄▄ ▀▀ ▄          
▀█▄ █▄ ██▀        ▀▀▀█▄      ████   ████▄ ▄████ ██ ████▄ ▄█▀█▄
 ██▄██▄██  ▀▀▀▀ ▄    ██      ██     ██ ██ ██ ██ ██ ██ ██ ██▄█▀
  ▀██▀██▀       ▀█████▀      ▀█████▄██ ▀█▄▀████▄██▄██ ▀█▄▀█▄▄▄
                                             ██               
                                           ▀▀▀               
        W-3 on top
]]--

if not game:IsLoaded() then game.Loaded:Wait() end

local lp = game:GetService("Players").LocalPlayer
local muerto = "https://raw.githubusercontent.com/W3-ENGINE/Games/refs/heads/main/Muerto-County-Massacre/main.lua"

local games = {
	[93978595733734] = "https://raw.githubusercontent.com/W3-ENGINE/Games/refs/heads/main/Violence-District/main.lua",
	[17625359962]    = "https://raw.githubusercontent.com/W3-ENGINE/Games/refs/heads/main/Rivals/main.lua",

	[79931861025666] = muerto,
	[9933703300]     = muerto,
	[137064506717617]= muerto,
}

local url = games[game.PlaceId]

if not url then
	pcall(lp.Kick, lp, "wrong game bro")
	return
end

local ok, src = pcall(game.HttpGet, game, url)

if not ok or not src or #src < 10 then
	pcall(lp.Kick, lp, "failed to load")
	return
end

local fn = loadstring(src)
if fn then pcall(fn) end
