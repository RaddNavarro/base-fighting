Map = {}
Map.__index = Map


function Map:New(data, width, height)
	local this = {
		tiles = data,
		width = width,
		height = height,
		cellSize = 64,
	}
	setmetatable(this, self)

	return this
end

function Map:Render()
  for row = 0, self.height - 1 do
    for col = 0, self.width - 1 do
      local spriteX = col * self.cellSize
      local spriteY = row * self.cellSize
      local tile = self.tiles[row * self.width + col + 1]
      if tile == 1 then
        love.graphics.rectangle("fill", spriteX, spriteY, self.cellSize, self.cellSize)
      else
        love.graphics.rectangle("line", spriteX, spriteY, self.cellSize, self.cellSize)
      end
    end
  end
end
