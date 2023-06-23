png = require( "pingo" ) 
-- Estrela
delayEstrela = 1
tempoCriarEstrela = delayEstrela
imgEstrela = love.graphics.newImage( "imagem/moeda.png" )
estrelas = {}
velocidadeEstrela = 150
naoSobe = 0
subiu = 0
-- Estrela

-- Criar Estrela
function start( dt )
	tempoCriarEstrela = tempoCriarEstrela - ( 0.5 * dt )	
	if tempoCriarEstrela < 0 then
		tempoCriarEstrela = 2*delayEstrela
		numeroAleatorio = math.random( 10, agua.posicY - 50 )
		novoEstrela = { x = larguraTela, y = numeroAleatorio, img = imgEstrela }
		table.insert( estrelas, novoEstrela )
	end	

	-- Remover Estrela da Tabela	
	for i, estrela in ipairs( estrelas ) do
		estrela.x = estrela.x - ( velocidadeEstrela* dt ) -- velocidade de deslocamento da moeda
		if estrela.x < -250 or estrela.y > alturaTela  then
			table.remove( estrelas, i )
		end
	end
	-- Remover Estrela da Tabela	
end
-- Criar Estrela

-- Colisão com Estrela
function colisaoEstrela( dt )
	-- COLISÃO NAVE X ESTRELA --
	for i, estrela in ipairs( estrelas ) do
		if checaColisaoEstrela( estrela.x, estrela.y, imgEstrela:getWidth(), imgEstrela:getHeight(), plane.posX, plane.posY, imgPlane:getWidth(), imgPlane:getHeight() ) then
			table.remove( estrelas, i )
			pegaEstrela:stop()
			pegaEstrela:play()
			pontos = pontos + 1	
			molhou = true
			if naoSobe == 0 then
				subiu = 1
			end
			velocidadeCriarPingo = velocidadeCriarPingo + 0.3 * dt
		end
	end
	-- COLISÃO NAVE X ESTRELA --
	
	-- COLISÃO ESTRELA X ÁGUA --
	for i, estrela in ipairs( estrelas ) do
		if checaEstrelaAgua( estrela.y, imgEstrela:getHeight(), agua.posicY, imgAgua:getHeight() ) then
			--[[ ***************************** PAROU AQUI ***************************** ]]--
			if estrela.y >= agua.posicY + imgEstrela:getHeight()/10 and estrela.y < agua.posicY + imgEstrela:getHeight()/5 then
			    estrelaAgua:stop()
				estrelaAgua:play()
			end
			
			estrela.y = estrela.y + ( 40 * dt ) -- aumenta em 30 unidade a velocidade de descida após contato com a água
			estrela.x = estrela.x + ( 15 * dt )	-- diminue em 15 unidades a velocidade horizontal de deslocamento após contato com a água
		end
	end
	-- COLISÃO ESTRELA X ÁGUA --
end

-- COLISÃO NAVE X ESTRELA --
function checaColisaoEstrela( x1, y1, w1, h1, x2, y2, w2, h2 )
	return x1 < x2 + w2/10 and x2 < x1 + w1/5 and y1 < y2 + h2/10 and y2 < y1 + h1/5
end
-- COLISÃO NAVE X ESTRELA --

-- COLISÃO ESTRELA X ÁGUA --
function checaEstrelaAgua( y1, h1, y2, h2 )
	return y1 > y2 + h1/10 or y2 < y1 + h1/10
end
-- COLISÃO ESTRELA X ÁGUA --
