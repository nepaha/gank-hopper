repeat task.wait(0.5) until game:IsLoaded() task.wait(0.25)

if game.PlaceId ~= 5208655184 then return end
if not _G.Webhook39 then return end

local WebhookLink = _G.Webhook39

local LPlayer = game:GetService("Players").LocalPlayer

local function CheckTool(Tool)
	if Tool:FindFirstChild('Skill') then
		return 'Skill'
	end
end

local function GetTools(Player)
	local Character = Player.Character

	local Backpack = Player.Backpack

	local Skills = {}

	if Character:FindFirstChildOfClass('Tool') then
		local Tool = Character:FindFirstChildOfClass('Tool')

		if Tool then
			local Type = CheckTool(Tool)
      
      if Type == 'Skill' then
			    table.insert(Skills, Tool.Name)
			end
		end
	end

	table.foreach(Backpack:GetChildren(), function(Index, Value)
    if Value:IsA('Tool') then
			local Type = CheckTool(Value)
            
            if Type == 'Skill' then
			    table.insert(Skills, Value.Name)
			end
		end
	end)

	return Skills
end

	local JobId, PlaceId, PlaceVersion, Ping, Date = game.JobId, game.PlaceId, game.PlaceVersion, math.ceil(LPlayer:GetNetworkPing() * 1000), os.date()
	local Players = {}
	local PlayerSkills = {}

	PlayerService = game:GetService("Players")
	for i, player in pairs(PlayerService:GetPlayers()) do
		if player ~= LPLayer then
			if player.Character and player.Backpack then
				local Skills = GetTools(player)

				if #Skills >= 6 then
    				local RSkills = tostring(table.concat(Skills, ', '))
    				Players[i] = player
    				PlayerSkills[i] = ('Skills: '.. RSkills)-- ('\nSkills - : '..table.concat(Skills, ', ')..(#Trinkets > 0 and '\nTrinkets - : '..table.concat(Trinkets, ', ')) or '')
				end
			end
		end
	end

	local Descript = ''

	for I, P in next, Players do
		if P.Character then
			local Tools = PlayerSkills[I]
			local Humanoid = P.Character:FindFirstChildOfClass('Humanoid')

			if not Humanoid then 
				continue 
			end
            local IGN = P.Character:FindFirstChild('FakeHumanoid', true).Parent.Name
			local CurrHp, MaxHP = math.ceil(Humanoid.Health), math.ceil(Humanoid.MaxHealth)
			local ArtifactsFol = P.Character:FindFirstChild('Artifacts')
            local RealArti = ArtifactsFol:FindFirstChildOfClass('Folder').Name or ''
            
			local Name = '\n**' .. P.Name .. '(' .. IGN .. ')'..'**\n'
			local HP = 'Health: ' .. (tostring(CurrHp) .. ' / ' .. tostring(MaxHP))..'\n'
			local Artifact = 'Artifact: ' .. RealArti .. '\n'
            
			local ToAdd = (Name .. HP .. Artifact .. Tools)
			Descript = Descript .. '\n' .. ToAdd
		end
	end

	local Message = {
		["content"] = '',
		["embeds"] = {{
			["type"] = "rich",
			["title"] = "hopper#9156",
			["description"] = Descript,
			["color"] = tonumber(1752220),
			['footer'] = {
			    ['text'] = ('JobId: '.. tostring(JobId) .. ' | Version: ' .. tostring(PlaceVersion) .. ' | ping (maybe): ' .. tostring(Ping) .. ' | date: ' .. tostring(Date))
            }
		}}
	}

	syn.request({
		Url = tostring(WebhookLink),
		Method = 'POST',
		Headers = {
			['Content-Type'] = 'application/json'
		},
		Body = game:GetService('HttpService'):JSONEncode(Message)
	})
	
    --[[do
        task.wait(2.5)
        game:GetService("TeleportService"):Teleport(3016661674, game:GetService("Players").LocalPlayer)
    end]]
