-- 1) Projete o nome e a cidade de todos os aeroportos existentes em Portugal
SELECT nome, cidade
FROM aeroporto
WHERE pais LIKE 'Portugal'


-- 2) Projete o nome dos aviões cujo a versão do modelo seja DC-10 
SELECT nome
FROM aviao, modelo
WHERE aviao.idModelo = modelo.idModelo AND versao LIKE  'DC-10'


-- 3) Projete o número de motores de cada avião
SELECT nome, numMotores
FROM aviao, modelo
WHERE aviao.idModelo = modelo.idModelo


-- 4) Projete o total de voos com a duração de duas ou três horas.
SELECT count(idvoo) AS 'Total'
FROM voo
WHERE duracao = 2 OR duracao = 3


-- 5 Projete o idModelo e a versão do modelo de avião cuja versão começa por ‘A3’
SELECT idModelo, versao
FROM  modelo
WHERE versao LIKE 'A3%'


-- 6) Projete o código e a duração de todos os voos.  Ordene pelo voo mais longo para o mais curto.
SELECT idVoo, duracao
FROM  voo
ORDER BY duracao DESC, idvoo ASC


-- 7) Sabendo que não há voos diretos do Porto para Londres, projete os voos que permitem essa ligação. Dica: Use os códigos do aeroporto (1 e 12) ao invés do nome do aeroporto.
-- SELECT idAeroporto
-- FROM aeroporto
-- WHERE cidade LIKE 'Londres'

CREATE VIEW Chega_Londes AS
SELECT idAeroportoChegada, idAeroportoPartida , idVoo 
FROM  voo
WHERE idAeroportoChegada = 11 OR idAeroportoChegada = 12

-- SELECT idAeroporto
-- FROM aeroporto
-- WHERE cidade LIKE 'Porto'

CREATE VIEW Parte_Porto AS
SELECT idAeroportoChegada, idAeroportoPartida, idVoo 
FROM  voo
WHERE idAeroportoPartida = 1 

SELECT parte_porto.idVoo , chega_londes.idVoo, parte_porto.idAeroportoChegada
FROM parte_porto, chega_londes
WHERE parte_porto.idAeroportoChegada = chega_londes.idAeroportoPartida


-- 8) Projete o total de aeroportos por país? Ordene do menor para o maior número.
SELECT count(idAeroporto) AS 'Total', pais
FROM aeroporto
GROUP BY pais 
order by count(idAeroporto) ASC


-- 9) Projete o código de cada voo com a cidade de origem e a cidade de destino de cada voo.
SELECT partida.idVoo, cidadePartida, cidadeChegada 
FROM 
(SELECT idVoo, cidade AS cidadePartida FROM aeroporto JOIN voo ON idAeroporto=idAeroportoPartida)
 as partida JOIN
(SELECT idVoo, cidade AS cidadeChegada FROM aeroporto JOIN voo ON idAeroporto=idAeroportoChegada) 
as chegada USING(idVoo);


-- 10) Projete o código dos voos que partem do Porto em direção a Lisboa. Dica: Use os nomes das cidades ao invés dos códigos do aeroporto.
SELECT idvoo
FROM voo
WHERE idAeroportoChegada = 3 AND idAeroportoPartida = 1


-- 11) Projete o nome do país e total de aeroportos dos países onde existam mais do que 2 aeroportos.
SELECT count(idAeroporto) AS 'Total', pais
FROM aeroporto
GROUP BY pais 
HAVING count(idAeroporto) > 2


-- 12) Projete o país ou países que têm o menor número de aeroportos?
-- Nao esta certo
SELECT Min(y.total) AS 'Total', pais
FROM (SELECT count(idAeroporto) AS total, pais
        FROM aeroporto
        GROUP BY pais ) y


-- 13) Projete o país ou países que têm o maior número de aeroportos?
-- Nao esta certo
SELECT MAX(y.total) AS 'Total', pais
FROM (SELECT count(idAeroporto) AS total, pais
        FROM aeroporto
        GROUP BY pais ) y


-- 14) Projete o total de aviões existentes para cada modelo.
SELECT fabricante, versao, count(idAviao) AS 'Total' 
FROM modelo , aviao 
WHERE aviao.idModelo = modelo.idModelo 
GROUP BY aviao.idModelo


-- 15) Projete o total de aviões existentes para cada modelo. Inclua os modelos de avião mesmo não existindo avião.
SELECT fabricante, versao, count(idAviao) AS 'Total' 
FROM modelo LEFT JOIN aviao 
ON aviao.idModelo = modelo.idModelo 
GROUP BY aviao.idModelo