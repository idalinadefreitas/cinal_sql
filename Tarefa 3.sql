-- 1 Projete todos os colaboradores e os seus departamentos;
SELECT departamento.designacao, colaborador.designacao
FROM colaborador, departamento
WHERE departamento.id = colaborador.idDepartamento
-- Done

-- 2 Projete todos os departamentos e os seus diretores;
SELECT departamento.designacao, colaborador.designacao
FROM colaborador, departamento
WHERE departamento.idDiretor = colaborador.id
-- Done

-- 3 Projete todos os projetos e os respetivos departamentos;
SELECT departamento.designacao, projeto.designacao
FROM projeto, departamento
WHERE departamento.id = projeto.idDepartamento

-- 4 Apresente os projetos controlados pelo departamento 1;
SELECT departamento.designacao, projeto.designacao
FROM projeto, departamento
WHERE departamento.id = projeto.idDepartamento
    AND departamento.id = 1


-- 5 Liste o projeto controlado pelo departamento de ‘Transportes’;
SELECT departamento.designacao, projeto.designacao
FROM projeto, departamento
WHERE departamento.id = projeto.idDepartamento
    AND departamento.designacao like 'Transportes'


-- 6 Projete todos os colaboradores que trabalham no projeto VODAFONE e o número de horas que cada um dedicou ao projeto. Ordene pelas horas;
SELECT colaborador.designacao, tarefas.horas
FROM projeto, departamento, colaborador, tarefas
WHERE departamento.id = projeto.idDepartamento
    AND projeto.designacao like 'VODAFONE'
    AND projeto.id = tarefas.idprojeto
    AND colaborador.id = tarefas.idColaborador  
ORDER BY `horas` ASC

-- 7 Liste o número de colaboradores por projeto;
SELECT  projeto.designacao, COUNT(colaborador.id)
FROM projeto, colaborador, tarefas
WHERE tarefas.idColaborador = colaborador.id
    AND  tarefas.idProjeto = projeto.id
GROUP BY  tarefas.idProjeto

-- 8 Liste as horas atribuídas a cada projeto;
SELECT projeto.designacao, SUM(tarefas.horas) AS "totalHoras"
FROM projeto, tarefas 
WHERE tarefas.idProjeto = projeto.id 
GROUP BY tarefas.idProjeto

-- 9 Liste as horas que cada colaborador dedica a cada projeto;
-- Deve ser … 9 Liste as horas que cada colaborador dedica aos seus projetos;
SELECT colaborador.designacao, SUM(tarefas.horas) AS "totalHoras"
FROM colaborador, tarefas 
WHERE colaborador.idProjeto = tarefas.idColaborador
GROUP BY tarefas.idColaborador

-- 10 Liste cada colaborar e o seu superior;
SELECT colaborador.designacao AS 'Inferior', 'Inferior'
FROM colaborador 
    JOIN (SELECT id AS idSperiorHierarquico, designacao AS superior FROM colaborador 
    JOIN (SELECT idSperiorHierarquico FROM colaborador WHERE idSperiorHierarquico IS NOT NULL GROUP by idSperiorHierarquico)AS  a ON colaborador.id = a.idSperiorHierarquico) AS b USING (idSperiorHierarquico)
-- nao sei

-- 11 Liste todos os colaboradores e os seus superiores. Caso um colaborador não tenha um superior mostra o valor NULL;

-- 12 Liste o vencimento mais elevado em cada departamento;
SELECT colaborador.idDepartamento, departamento.designacao, MAX(colaborador.vencimento) AS 'Vencimento MAX'
FROM colaborador, departamento
GROUP BY colaborador.idDepartamento 


-- 13 Liste o vencimento mais elevado da base de dados;
SELECT colaborador.id, colaborador.designacao, MAX(colaborador.vencimento) AS 'Vencimento MAX'
FROM colaborador


-- 14 Apresente a diferença entre o salário mais alto e o salário mais baixo;
SELECT MAX(colaborador.vencimento), MIN(colaborador.vencimento), (MAX(colaborador.vencimento) - MIN(colaborador.vencimento)) AS VALOR_SUBTRACAO
FROM colaborador


-- 15 Liste a diferença entre o vencimento de cada colaborador e seu superior;

-- 16 Apresente a diferença entre o vencimento mais baixo de um colaborador e do seu superior;

-- 17 Liste os departamentos onde a média de vencimentos seja superior a 1300;
SELECT colaborador.idDepartamento, departamento.designacao, AGV(colaborador.vencimento) AS 'Vencimento MAX'
FROM colaborador, departamento
WHERE AGV(colaborador.vencimento) > 1300
GROUP BY colaborador.idDepartamento
