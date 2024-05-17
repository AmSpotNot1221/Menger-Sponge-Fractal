local repStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local box = require(script.Box)

local function sponge(size,iter,position,color)
	local newBox = box.New(Vector3.new(size,size,size), position)
	
	local model = Instance.new("Model",workspace)
	model.Name = "MengerSponge"
	
	newBox:Subdivide(iter,iter)
	
	for _,cube in newBox:GetCurrentMesh() do
		local part = ServerStorage.BoxMesh:Clone()
		part.Parent = model
		part.Position = cube.Position
		part.Size = cube.Size
		part.BrickColor = color or BrickColor.new("Dark green")
	end
end

repStorage.GenerateFractal.OnServerEvent:Connect(function(player,color,iterations)
	if workspace:FindFirstChild("MengerSponge") then
		workspace.MengerSponge:Destroy()
	end
	sponge(81,tonumber(iterations),Vector3.zero,BrickColor.new(color))
end)

sponge(81,1,Vector3.zero)
