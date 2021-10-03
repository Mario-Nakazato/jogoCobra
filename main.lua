--[[

    Jogo Cobra

    # Tentar a ideia de manter todo o corpo no corpo, ou seja, sem a separação da cabeça e corpo.

]]--

function love.load(arg)

    if arg[#arg] == "-debug" then require("mobdebug").start() end -- Debug para ZeroBrane Studio IDE Utilize; Argumento - arg esta disponivel global.

    lgrafico = love.graphics
    lmat = love.math

    rgbByte = lmat.colorFromBytes

    update = true

    tela = {}
    tela.c, tela.l = lgrafico.getDimensions()

    mover = {}
    
    function mover.w(self)
        self.vx = 0
        self.vy = self.vy <= 0 and -self.v or self.v
    end

    function mover.s(self)
        self.vx = 0
        self.vy = self.vy >= 0 and self.v or -self.v
    end

    function mover.a(self)
        self.vx = self.vx <= 0 and -self.v or self.v
        self.vy = 0
    end

    function mover.d(self)
        self.vx = self.vx >= 0 and self.v or -self.v
        self.vy = 0
    end

    mover["up"] = mover["w"]
    mover["down"] = mover["s"]
    mover["left"] = mover["a"]
    mover["right"] = mover["d"]

    cobra = {}
    
    cobra.c = 32
    tela.ct, tela.lt = tela.c /cobra.c, tela.l /cobra.c
    cobra.x = tela.ct /2
    cobra.y = tela.lt /2
    cobra.v = 8
    cobra.vx = 0
    cobra.vy = 0

    cobra.corpo = {}

    function cobra:controle(tecla)
        if mover[tecla] ~= nil then
            mover[tecla](self)
        end
    end

    function cobra:update(dt)

        local antx, anty = self.x, self.y

        self.x = self.x +self.vx *dt
        self.y = self.y +self.vy *dt
        
        if self.x < 0 then
            self.x = 0
            self.vx = 0
        elseif self.x > tela.ct -1 then
            self.x = tela.ct -1
            self.vx = 0
        end
        
        if self.y < 0 then
            self.y = 0
            self.vy = 0
        elseif self.y > tela.lt -1 then
            self.y = tela.lt -1
            self.vy = 0
        end

        if #self.corpo > 0 then
            if math.floor(antx) ~= math.floor(self.x) then
                table.remove(self.corpo)
                table.insert(self.corpo, 1, {x = antx, y = anty})
            end
            if math.floor(anty) ~= math.floor(self.y) then
                table.remove(self.corpo)
                table.insert(self.corpo, 1, {x = antx, y = anty})
            end
        end

    end

    function cobra:draw()
        lgrafico.setColor(rgbByte({0, 255, 0}))
        lgrafico.rectangle("fill", math.floor(self.x) *self.c, math.floor(self.y) *self.c, self.c, self.c, 8)
        lgrafico.setColor(rgbByte({0, 255, 0, 64}))
        for i = 1, #self.corpo do
            lgrafico.rectangle("fill", math.floor(self.corpo[i].x) *self.c, math.floor(self.corpo[i].y) *self.c, self.c, self.c, 8)
        end
    end

    comida = {}
    comida.x = lmat.random(tela.ct -1)
    comida.y = lmat.random(tela.lt -1)
    comida.c = 32

    function comida:update(cobra)

        if math.floor(self.x) == math.floor(cobra.x) and math.floor(self.y) == math.floor(cobra.y) then
            self.x = lmat.random(tela.ct -1)
            self.y = lmat.random(tela.lt -1)
            
            if #cobra.corpo > 0 then
                table.insert(cobra.corpo, {x = cobra.corpo[#cobra.corpo].x, y = cobra.corpo[#cobra.corpo].y})
            else
                table.insert(cobra.corpo, {x = self.x, y = self.y})
            end
        end

    end

    function comida:draw()
        lgrafico.setColor(rgbByte({255, 0, 0}))
        lgrafico.rectangle("fill", math.floor(self.x) *self.c, math.floor(self.y) *self.c, self.c, self.c, 8)
    end

end

function love.update(dt)

    if not update then
        return
    end

    cobra:update(dt)
    comida:update(cobra)

end

function love.draw()

    comida:draw()
    cobra:draw()

end

function love.keypressed(tecla, cod, repeticao)

    if tecla == "f1" then
        update = not update
    elseif tecla == "f5" then
        love.load(arg)
    end

    cobra:controle(tecla)

end

function love.keyreleased(tecla, cod)



end

function love.mousepressed(x, y, botao, toque, repeticao)



end

function love.mousereleased(x, y, botao, toque, repeticao)



end

function love.mousemoved(x, y, dx, dy, toque)



end

function love.wheelmoved(x, y)



end

function love.mousefocus(foco)



end

function love.resize(c, l)



end

function love.focus(foco)



end

function love.quit()



end
--[[
function inicioContato(a, b, contato)



end

function fimContato(a, b, contato)



end

function preContato(a, b, contato)



end

--function posContato(a, b, contato, normalImpulso, tangenteImpulso, normalImpulso1, tangenteImpulso1)
function posContato(a, b, contato, normalImpulso, tangenteImpulso)



end

function love.touchpressed(id, x, y, dx, dy, pressao)



end

function love.touchreleased(id, x, y, dx, dy, pressao)



end

function love.touchmoved(id, x, y, dx, dy, pressao)



end

function love.displayrotated(indice, orientacao)



end

function love.textedited(texto, inicio, tamanho)



end

function love.textinput(texto)



end

function love.directorydropped(caminho)



end

function love.filedropped(arquivo)



end

function love.errorhandler(erro)



end

function love.lowmemory()



end

function love.threaderror(thread, erro)



end

function love.visible(visivel)-- Esta funcao CallBack não funciona, utilize visivel = love.window.isMinimized()
end
--]]