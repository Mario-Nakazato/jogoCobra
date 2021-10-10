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
        if self.x == math.floor(cobra.x) and self.y == math.floor(cobra.y) and tela.ct *tela.lt > #cobra.corpo +1 then
            repeat
                self.x = lmat.random(tela.ct -1)
                self.y = lmat.random(tela.lt -1)
                mudar = false
                
                if self.x == math.floor(cobra.x) and self.y == math.floor(cobra.y) then
                    mudar = true
                else
                    for i = 1, #cobra.corpo do
                        if self.x == math.floor(cobra.corpo[i].x) and self.y == math.floor(cobra.corpo[i].y) then
                            mudar = true
                            break
                        end
                    end
                end

            until not mudar
            return true
        end
        return false
    end

    function comida:draw()
        lgrafico.setColor(rgbByte({220, 20, 60}))
        lgrafico.rectangle("fill", self.x *self.c, self.y *self.c, self.c, self.c, 8)
        lgrafico.setColor(rgbByte({0, 0, 0}))
        lgrafico.rectangle("line", self.x *self.c, self.y *self.c, self.c, self.c, 8)
    end

    return comida
  
  end
  
  comida = {
    novo = novo
  }
  
  print("comida.lua")
  
  return comida