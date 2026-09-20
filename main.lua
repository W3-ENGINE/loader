--[[

                                                              
                 ▄▄▄▄▄      ▄▄▄▄▄▄▄                           
                ██▀▀▀██    █▀██▀▀▀                            
                ▀   ▄█▀      ██     ▄        ▄▄ ▀▀ ▄          
▀█▄ █▄ ██▀        ▀▀▀█▄      ████   ████▄ ▄████ ██ ████▄ ▄█▀█▄
 ██▄██▄██  ▀▀▀▀ ▄    ██      ██     ██ ██ ██ ██ ██ ██ ██ ██▄█▀
  ▀██▀██▀       ▀█████▀      ▀█████▄██ ▀█▄▀████▄██▄██ ▀█▄▀█▄▄▄
                                             ██               
                                           ▀▀▀               
]]--

cloneref = cloneref or function(x) return x end

repeat task.wait() until game:IsLoaded() and cloneref(game:GetService("ContentProvider")).RequestQueueSize <= 10

cloneref(game:GetService("Players")).LocalPlayer.Idled:Connect(function()
    cloneref(game:GetService("VirtualUser")):ClickButton2(Vector2.new())
end)

local shared = {
    version = "V1.0.0",
    folders = {
        main   = "W3",
        games  = "W3/Games",
        assets = "W3/Assets",
    };
}

for _, folder in shared.folders do
    if not isfolder(folder) then
        makefolder(folder)
    end
end

if isfile("W3/Version.txt") and readfile("W3/Version.txt") ~= shared.version then
    delfolder("W3")
    for _, folder in shared.folders do
        if not isfolder(folder) then makefolder(folder) end
    end
end

writefile("W3/Version.txt", shared.version)

local lp = cloneref(game:GetService("Players")).LocalPlayer
local uis = cloneref(game:GetService("UserInputService"))

local is_mobile = uis.TouchEnabled and not uis.KeyboardEnabled and not uis.MouseEnabled

local library = "https://raw.githubusercontent.com/W3-ENGINE/Libraries/refs/heads/main/Nebula/library.lua"

local muerto = "https://raw.githubusercontent.com/W3-ENGINE/Games/refs/heads/main/Muerto-County-Massacre/main.lua"

local VD_PC     = "https://raw.githubusercontent.com/W3-ENGINE/Games/refs/heads/main/Violence-District/main.lua"
local VD_MOBILE = "https://raw.githubusercontent.com/W3-ENGINE/Games/refs/heads/main/Violence-District/mobile.lua"

local games = {
    [{93978595733734}]                              = is_mobile and VD_MOBILE or VD_PC,
    [{17625359962}]                                 = "https://raw.githubusercontent.com/W3-ENGINE/Games/refs/heads/main/Rivals/main.lua",
    [{79931861025666, 9933703300, 137064506717617}] = muerto,
}

local url
for ids, u in games do
    if table.find(ids, game.PlaceId) then
        url = u
        break
    end
end

if not url then
    pcall(function() lp:Kick("wrong game bro") end)
    return
end

local ok_lib, lib_src = pcall(function() return game:HttpGet(library) end)
if typeof(lib_src) == "Instance" and lib_src:IsA("StringValue") then lib_src = lib_src.Value end
if ok_lib and type(lib_src) == "string" and #lib_src >= 10 then
    local lib_fn = loadstring(lib_src, "@W3/library")
    if lib_fn then pcall(lib_fn) end
end

local ok, src = pcall(function() return game:HttpGet(url) end)
if typeof(src) == "Instance" and src:IsA("StringValue") then src = src.Value end
if not ok or type(src) ~= "string" or #src < 10 then
    pcall(function() lp:Kick("failed to load") end)
    return
end

local fn = loadstring(src, "@W3/" .. game.PlaceId)
if not fn then
    pcall(function() lp:Kick("compile error") end)
    return
end

pcall(fn)
