--[[

    Cobra

    # Tentar a ideia de manter todo o corpo no corpo, ou seja, sem a separação da cabeça e corpo.

--]]

require "palavra"

local function novo()
    local cobra = {}

    cobra.c = 32
    tela.ct, tela.lt = math.floor(tela.c / cobra.c), math.floor(tela.l / cobra.c)
    cobra.x = math.floor(tela.ct / 2)
    cobra.y = math.floor(tela.lt / 2)
    cobra.v = 10
    cobra.vx = 0
    cobra.vy = 0
    cobra.corpo = {}
    cobra.mover = {}
    cobra.parede = true

    function cobra.mover.w()
        cobra.vx = 0
        cobra.vy = cobra.vy <= 0 and -cobra.v or cobra.v
    end

    function cobra.mover.s()
        cobra.vx = 0
        cobra.vy = cobra.vy >= 0 and cobra.v or -cobra.v
    end

    function cobra.mover.a()
        cobra.vx = cobra.vx <= 0 and -cobra.v or cobra.v
        cobra.vy = 0
    end

    function cobra.mover.d()
        cobra.vx = cobra.vx >= 0 and cobra.v or -cobra.v
        cobra.vy = 0
    end

    cobra.mover["up"] = cobra.mover["w"]
    cobra.mover["down"] = cobra.mover["s"]
    cobra.mover["left"] = cobra.mover["a"]
    cobra.mover["right"] = cobra.mover["d"]

    function cobra:controle(tecla)
        if self.mover[tecla] ~= nil and not teclou then
            teclou = true
            self.mover[tecla]()
        end
    end

    function cobra:update(dt)
        local antx, anty = self.x, self.y

        self.x = self.x + self.vx * dt
        self.y = self.y + self.vy * dt

        if self.x < 0 then
            self.x = self.parede and 0 or (tela.ct - 1)
            teclou = false
        elseif self.x > tela.ct then
            self.x = self.parede and (tela.ct - 1) or 0
            teclou = false
        end

        if self.y < 0 then
            self.y = self.parede and 0 or (tela.lt - 1)
            teclou = false
        elseif self.y > tela.lt then
            self.y = self.parede and (tela.lt - 1) or 0
            teclou = false
        end

        for i = 1, #self.corpo do
            if math.floor(self.x) == math.floor(self.corpo[i].x)
                and math.floor(self.y) == math.floor(self.corpo[i].y) then
                teclou = false
                self.x, self.y = antx, anty
                self.vx = 0
                self.vy = 0
                break
            end
        end

        if math.floor(antx) ~= math.floor(self.x) or math.floor(anty) ~= math.floor(self.y) then
            teclou = false
            if #self.corpo > 0 then
                table.remove(self.corpo)
                table.insert(self.corpo, 1, { x = antx, y = anty })
            end
            if corpo then
                table.insert(self.corpo, corpo)
                corpo = nil
            end
        end
    end

    function cobra:updateComida(comida)
        if comida:update(self) then
            if #self.corpo > 0 then
                corpo = { x = self.corpo[#self.corpo].x, y = self.corpo[#self.corpo].y }
            else
                corpo = { x = self.x, y = self.y }
            end
        end
    end

    function cobra:draw()
        for i = 1, #self.corpo do
            lgrafico.setColor(rgbByte({ 138, 43, 226 }))
            lgrafico.rectangle("fill", math.floor(self.corpo[i].x) * self.c, math.floor(self.corpo[i].y)
                * self.c, self.c, self.c, 8)
            lgrafico.setColor(rgbByte({ 0, 0, 0 }))
            lgrafico.rectangle("line", math.floor(self.corpo[i].x) * self.c, math.floor(self.corpo[i].y)
                * self.c, self.c, self.c, 8)
        end
        lgrafico.setColor(rgbByte({ 75, 0, 130 }))
        lgrafico.rectangle("fill", math.floor(self.x) * self.c, math.floor(self.y) * self.c, self.c, self.c, 8)
        lgrafico.setColor(rgbByte({ 0, 0, 0 }))
        lgrafico.rectangle("line", math.floor(self.x) * self.c, math.floor(self.y) * self.c, self.c, self.c, 8)
    end

    return cobra
end

cobra = {
    novo = novo
}

print("cobra.lua")

return cobra