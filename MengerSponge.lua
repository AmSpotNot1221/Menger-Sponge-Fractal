local box = {}
box.__index = box

local ServerStorage = game:GetService("ServerStorage")
local boxMesh = ServerStorage.BoxMesh

local currentMesh = {}

function box.New(size,pos)
	local newBox = {}
	setmetatable(newBox,box)
	
	newBox.Mesh = {Position = nil, Size = nil}
	newBox.Mesh.Size = size
	newBox.Mesh.Position = pos
	
	newBox.subdivided = false
	
	return newBox
end

function box:Subdivide(iter,max)
	if self.subdivided then return end
	
	local divisionSize = self.Mesh.Size/3
	
	self.subdivided = true	
	
	print(1)
	
	for x = -1,1 do
		for y = -1,1 do
			for z = -1,1 do
				if math.abs(x) + math.abs(y) + math.abs(z) >= 2 then
					if iter-1 > 0 then
						local subdividedBox = box.New(divisionSize,self.Mesh.Position + divisionSize * Vector3.new(x,y,z))
						subdividedBox:Subdivide(iter-1,max)
					else
						table.insert(currentMesh,{Position = self.Mesh.Position + divisionSize * Vector3.new(x,y,z), Size = divisionSize})
					end
				end
			end
		end
	end
end

function box:GetCurrentMesh()
	local toReturn = currentMesh
	currentMesh = {}
	return toReturn
end

return box
