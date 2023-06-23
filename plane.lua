-- Avião de Papel
imgPlane = love.graphics.newImage( "imagem/plane.png" )
setaDireita = 0
setaEsquerda = 0
setaBaixo = 0
sobe = 0 

plane = {
	posX = larguraTela / 10,
	posY = alturaTela / 10,
	velocidade = 300
}
-- Avião de Papel
-- Sombra do Avião
imgSombra = love.graphics.newImage( "imagem/sombra.png" )
sombra = {
	posX = larguraTela / 10,
	posY = 590,
}	
-- Sombra do Avião
i = 800
molhou  = false
-- Movimentos do Avião de Papel --
function movPlane( dt )
	veloc = 15 * dt
	angulo = 0 -- Faz voltar à posição original do Avião de Papel
	plane.posY = plane.posY + veloc
	if life <= 0 then -- condicao para o aviao comecar a cair
		plane.posY = plane.posY + (plane.velocidade - 40) * dt
	end
	if love.keyboard.isDown( "right" ) then
		setaDireita = 1
		if plane.posX < ( larguraTela - imgPlane:getWidth() / 3.5 ) then
			plane.posX = plane.posX + (plane.velocidade + 100) * dt -- aumenta a velocidade em 100 unidades para frente
		end
	end
	if love.keyboard.isDown( "left" ) then
		setaEsquerda = 1
		if plane.posX > ( 0 + imgPlane:getWidth() / 3.5 ) then
			plane.posX = plane.posX - (plane.velocidade - 50) * dt -- diminue a velocidade em 50 unidades para trás
		    angulo = 50
		end
	end
	if sobe == 1 then
		if plane.posY > ( 0 + imgPlane:getHeight() / 2.5 ) then
			plane.posY = plane.posY - (plane.velocidade) * dt -- diminue a velocidade em 50 unidades na subida
			angulo = 50
			sobe = 0
		end
	end
	if love.keyboard.isDown( "down" ) then
		setaBaixo = 1
		if plane.posY < ( alturaTela - imgPlane:getHeight() / 2 ) then
			plane.posY = plane.posY + (plane.velocidade + 100) * dt -- aumenta a velocidade em 100 unidades na descida
			angulo = -50
			sobe = 0 
		end
	end
	
-- Movimentar Sombra do Avião
	sombra.posX = plane.posX
	sombra.posY = agua.posicY + 60
-- Movimentar Sombra do Avião-
	end
-- Movimentos do Avião de Papel --

-- Colisão Avião x Água
function colisaoAgua( dt )
	
	if checaColisaoAgua( agua.posicY, imgAgua:getHeight(), plane.posY, imgPlane:getHeight() ) and estaSeco then
		explodeNave:play()
		estaSeco = false
		abreTela = false
		gameOver = true
		somGameOver:play()
		somGameOver:setLooping( false )
	end
	
	if plane.posY > agua.posicY - 40 then
		alarmPlane:play() -- Emite o som de alerta caso o avião esteja próximo da agua em 0 - 20 unidades
		alarmPlane:setLooping( false )
	end	
end

function checaColisaoAgua( y1, h1, y2, h2 )
	return y1 < y2 - h2/20 or y2 > y1 + h2/20
end
-- Colisão Avião x Água
