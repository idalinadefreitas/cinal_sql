-- 1 Apresente os pescadores que saíram para pescar na data 2017-1-3
SELECT pescador_pescaria.idPescador, pescador.nome
FROM pescador_pescaria, pescaria, pescador
WHERE pescador_pescaria.idPescaria = pescaria.idPescaria AND pescador_pescaria.idPescador = pescador.idPescador AND pescaria.dataReg LIKE '2017-1-3'

-- 2 Apresente as espécies de peixe pescadas na data 2017-1-3
SELECT DISTINCT(pescado.idPeixe), peixe.nome
FROM pescaria, pescado, peixe
WHERE pescaria.idPescaria = pescado.idPescaria AND pescado.idPeixe = peixe.idPeixe AND pescaria.dataReg LIKE '2017-1-3'


-- 3 Projete o número de pescarias realizadas no dia 2 de janeiro de 2017.
SELECT count(idPescaria) AS 'Total'
FROM pescaria
WHERE dataReg LIKE '2017-1-2' 


-- 4 Apresente o número total de barcos que suportem um peso máximo superior a 35.00 kg
SELECT count(idBarco) AS 'Total'
FROM barco
WHERE pesoMaximo > 3500

-- erro

-- 5 Apresente o número de pescadores que saíram por viagem.
SELECT pescador_pescaria.idPescaria, dataReg, count(pescador_pescaria.idPescaria) AS 'numero'
FROM pescaria, pescador_pescaria
WHERE pescaria.idPescaria = pescador_pescaria.idPescaria
GROUP BY pescador_pescaria.idPescaria

-- 6 Projete o número de espécies de peixe diferente capturados em cada pescaria.
SELECT  pescado.idPescaria, dataReg, count(pescado.idPescaria) AS 'numero'
FROM pescaria, pescado
WHERE pescaria.idPescaria =  pescado.idPescaria
GROUP BY  pescado.idPescaria

-- 7 Projete as pescarias cujo o peso total de peixes capturados excedeu os 10.000 kg
SELECT  pescado.idPescaria, dataReg
FROM pescaria, pescado
WHERE pescaria.idPescaria =  pescado.idPescaria AND pescado.peso > 10000 
GROUP BY  pescado.idPescaria

-- 8 Projete as pescarias nas quais a idade média dos pescadores foi superior a 50 anos de idade?
SELECT  pescaria.idPescaria, dataReg, pescador.idade
FROM pescaria, pescador_pescaria, pescador
WHERE pescaria.idPescaria = pescador_pescaria.idPescaria AND pescador_pescaria.idPescador = pescador.idPescador AND pescador.idade > 50
GROUP BY  pescaria.idPescaria

-- erro

-- 9 Projete os barcos que nunca capturaram Atum
SELECT DISTINCT(barco.idBarco), barco.nome
FROM barco, pescaria, pescado
WHERE pescado.idPeixe = (SELECT  idPeixe FROM peixe WHERE nome LIKE "Atum") 
    AND pescado.idPescaria = pescaria.idPescaria 
    AND pescaria.idBarco = barco.idBarco

-- 10 Projete os barcos nos quais  ‘Paulo Trindade’ nunca pescou?
SELECT DISTINCT(barco.idBarco), barco.nome 
FROM pescador, pescador_pescaria, pescaria, barco 
WHERE pescador_pescaria.idPescador = pescador.idPescador 
    AND pescaria.idPescaria = pescador_pescaria.idPescaria 
    AND pescaria.idBarco = barco.idBarco 
    AND pescador.nome 
NOT LIKE "Paulo Trindade"

-- 11 Projete o número de pescarias feitas por cada pescador? Considere que alguns pescadores podem nunca ter feito uma viagem
SELECT pescador.idPescador, pescador.nome, COUNT(pescador_pescaria.idPescador) AS 'numero'
FROM pescador, pescador_pescaria
WHERE pescador_pescaria.idPescador = pescador.idPescador 
group by  pescador.idPescador 
order by COUNT(pescador_pescaria.idPescador)


-- 12 Quantas vezes cada espécie de peixe foi capturado? Considere que algumas espécies de peixe podem nunca ter sido capturados.
SELECT peixe.idPeixe, peixe.nome, COUNT(pescado.idPeixe) AS 'numero'
FROM peixe, pescado
WHERE peixe.idPeixe = pescado.idPeixe 
group by  pescado.idPeixe
order by COUNT(pescado.idPeixe) DESC

-- 13 Em qual pescaria, ou pescarias, se verificou a tripulação mais nova?
SELECT pescaria.idPescaria, pescaria.dataReg,  avg(pescador.idade) AS 'media'
FROM pescaria, pescador, pescador_pescaria
where  pescaria.idPescaria = pescador_pescaria.idPescaria
    AND pescador_pescaria.idPescador = pescador.idPescador
    AND avg(pescador.idade) = 40
group by  pescaria.idPescaria


-- 14 Em qual ou quais pescarias foi pescada a menor quantidade de peixe?
SELECT pescado.idPescaria, pescaria.dataReg, min(pescado.peso) AS 'peso'
FROM pescaria, pescado 
where pescaria.idPescaria = pescado.idPescaria


-- 15 Quais pescadores fizeram pescarias em que o limite de peso do barco foi ultrapassado?
SELECT pescador.idPescador, pescador.nome, pescado.idPescaria, pescado.peso, barco.pesoMaximo
FROM barco, pescado, pescador, pescador_pescaria, pescaria
where  barco.pesoMaximo < pescado.peso
    AND pescador_pescaria.idPescaria = pescado.idPescaria 
    AND pescador.idPescador = pescador_pescaria.idPescador
    AND pescaria.idBarco = barco.idBarco


-- 16 Quais peixes foram capturados em pescarias em que o limite de peso do barco foi ultrapassado?
SELECT DISTINCT(pescado.idPescaria), peixe.nome, pescado.idPeixe, pescado.peso, barco.pesoMaximo
FROM barco, pescado, pescador, pescador_pescaria, pescaria, peixe
where  barco.pesoMaximo < pescado.peso
    AND pescador_pescaria.idPescaria = pescado.idPescaria 
    AND pescado.idPeixe = peixe.idPeixe
    AND pescaria.idBarco = barco.idBarco