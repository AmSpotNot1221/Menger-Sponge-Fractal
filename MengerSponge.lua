local repStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local box = require(script.Box)

local function greedyMesh(mesh,subdivisions)
	print(mesh)
	local blocks = {}
	local offset = math.floor(subdivisions/2) + 1
	
	local toDelete = {}
	
	for i, part in mesh do
		local x = part.Position.X + offset
		local y = part.Position.Y + offset
		local z = part.Position.Z + offset
		
		if blocks[x] then
			if blocks[x][z] then
				if blocks[x][z][y] then
					table.insert(toDelete,i)
					continue
				end
				blocks[x][z][y] = 1
			else
				blocks[x][z] = {}
				blocks[x][z][y] = 1
			end
		else
			blocks[x] = {}
			blocks[x][z] = {}
			blocks[x][z][y] = 1
		end
	end
	
	--reverse table toDelete so that we can remove elements without messing up the index
	table.sort(toDelete, function(a,b) return a > b end)
	
	for _, i in ipairs(toDelete) do
		table.remove(mesh,i)
	end
	
	return mesh
end

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
