--[[

    Comida

--]]

require "palavra"

local function novo()
  
    local comida = {}
    
    comida.x = lmat.random(tela.ct -1)
    comida.y = lmat.random(tela.lt -1)
    comida.c = 32

    function comida:update(cobra)
        if math.floor(self.x) == math.floor(cobra.x) and math.floor(self.y) == math.floor(cobra.y) then
            self.x = lmat.random(tela.ct -1)
            self.y = lmat.random(tela.lt -1)
            return true
        end
        return false
    end

    function comida:draw()
        lgrafico.setColor(rgbByte({255, 0, 0}))
        lgrafico.rectangle("fill", math.floor(self.x) *self.c, math.floor(self.y) *self.c, self.c, self.c, 8)
    end

    return comida
  
  end
  
  comida = {
    novo = novo
  }
  
  print("comida.lua")
  
  return comida