-- ---------------------------------------------------------------------
1. Quais turmas estão em andamento neste semestre? Mostre a disciplina, o professor
responsável, a sala e o horário 
nome: Ivan
-- ---------------------------------------------------------------------
select
  t.idturma,
  t.horario,
  t.sala,
  t.professor_nome,
  d.nome
from
  turma t
  inner join disciplina d on t.disciplina_iddisciplina = d.iddisciplina


-- ---------------------------------------------------------------------
2. Quantos alunos estão matriculados em cada turma? Mostre apenas turmas com pelo
menos 5 alunos ativos. Ordene da turma com mais alunos para a com menos.
nome: Ivan
-- ---------------------------------------------------------------------
select
  t.idturma,
  t.horario,
  t.sala,
  t.professor_nome,
  d.nome
from
  turma t
  inner join disciplina d on t.disciplina_iddisciplina = d.iddisciplina

-- ---------------------------------------------------------------------
3. Qual a média de notas por aluno em cada turma? Mostre o nome do aluno, a disciplina e
a média arredondada para 1 casa decimal. Ordene por disciplina e, dentro de cada
disciplina, da maior média para a menor.
nome: Ivan
-- ---------------------------------------------------------------------
SELECT a.nome_completo AS aluno, d.nome AS disciplina,
       ROUND(AVG(CAST(n.valor AS NUMERIC)), 1) AS media
FROM Nota n
INNER JOIN Matricula  m ON m.idMatricula = n.Matricula_idMatricula
INNER JOIN Aluno      a ON a.idAluno = m.Aluno_idAluno
INNER JOIN Turma      t ON t.idTurma = m.Turma_idTurma
INNER JOIN Disciplina d ON d.idDisciplina = t.Disciplina_idDisciplina
GROUP BY a.idAluno, a.nome_completo, d.idDisciplina, d.nome
ORDER BY d.nome ASC, media DESC;

-- ---------------------------------------------------------------------
4. Quais alunos têm frequência abaixo de 75% em pelo menos uma turma? Mostre o nome
do aluno, a disciplina e o percentual de presença. A escola considera ausente qualquer aula
sem registro de presença ou justificativa.
nome: 
-- ---------------------------------------------------------------------
SELECT
    a.nome_completo AS aluno,
    d.nome          AS disciplina,
    ROUND(
        100.0 * SUM(CASE WHEN f.status IN ('presente','justificado') THEN 1 ELSE 0 END)
              / COUNT(f.idFrequencia),
        1
    ) AS percentual_presenca
FROM Frequencia f
INNER JOIN Matricula  m ON m.idMatricula     = f.Matricula_idMatricula
INNER JOIN Aluno      a ON a.idAluno         = m.Aluno_idAluno
INNER JOIN Turma      t ON t.idTurma         = m.Turma_idTurma
INNER JOIN Disciplina d ON d.idDisciplina    = t.Disciplina_idDisciplina
GROUP BY a.idAluno, a.nome_completo, d.idDisciplina, d.nome
HAVING ROUND(
        100.0 * SUM(CASE WHEN f.status IN ('presente','justificado') THEN 1 ELSE 0 END)
              / COUNT(f.idFrequencia),
        1
    ) < 75
ORDER BY percentual_presenca ASC;



-- ---------------------------------------------------------------------
5. Quais professores estão responsáveis por mais de uma turma ativa? Mostre o nome do
professor e a contagem de turmas.
nome: Brendo
-- ---------------------------------------------------------------------

select
  p.nome,
  COUNT(t.idturma) as total_turmas
from
  professor p
  inner join turma t on p.idprofessor = t.professor_idprofessor
group by
  p.idprofessor,
  p.nome
having
  COUNT(t.idturma) > 1;

-- ---------------------------------------------------------------------
6. Quais alunos nunca tiveram nenhuma matrícula cancelada? Mostre o nome completo e o
status atual.
nome: 
-- ---------------------------------------------------------------------

select
  a.nome_completo,
  a.status
from
  aluno a
  left join matricula m on a.idaluno = m.aluno_idaluno
  and m.status = 0
where
  m.idmatricula is null;

-- ---------------------------------------------------------------------
7. Qual a disciplina com maior número de reprovações? Considere reprovado o aluno com
média abaixo de 6.0. Mostre o nome da disciplina e a contagem de reprovações.
nome: 
-- ---------------------------------------------------------------------
SELECT
    d.nome AS disciplina,
    COUNT(*) AS total_reprovacoes
FROM (
    SELECT
        m.idMatricula,
        m.Turma_idTurma,
        AVG(CAST(n.valor AS NUMERIC)) AS media
    FROM Matricula m
    INNER JOIN Nota n ON n.Matricula_idMatricula = m.idMatricula
    WHERE m.status IN (1, 2)
    GROUP BY m.idMatricula, m.Turma_idTurma
    HAVING AVG(CAST(n.valor AS NUMERIC)) < 6.0
) reprovados
INNER JOIN Turma      t ON t.idTurma      = reprovados.Turma_idTurma
INNER JOIN Disciplina d ON d.idDisciplina = t.Disciplina_idDisciplina
GROUP BY d.idDisciplina, d.nome
ORDER BY total_reprovacoes DESC
LIMIT 1;


-- ---------------------------------------------------------------------
8. Liste todos os alunos matriculados em mais de uma turma no semestre atual. Mostre o
nome e a contagem de matrículas ativas.
nome: 
-- ---------------------------------------------------------------------
SELECT
    a.nome_completo,
    COUNT(m.idMatricula) AS total_matriculas_ativas
FROM Aluno a
INNER JOIN Matricula m ON m.Aluno_idAluno = a.idAluno
INNER JOIN Turma     t ON t.idTurma       = m.Turma_idTurma
WHERE m.status = 1
  AND t.horario >= '2026-01-01'
  AND t.horario <  '2026-07-01'
GROUP BY a.idAluno, a.nome_completo
HAVING COUNT(m.idMatricula) > 1
ORDER BY total_matriculas_ativas DESC;


-- ---------------------------------------------------------------------
9. Qual o professor com maior número de alunos sob sua responsabilidade (somando todos
os alunos de todas as suas turmas ativas)? Mostre o nome e o total de alunos.
nome: 
-- ---------------------------------------------------------------------
SELECT
    p.nome AS professor,
    COUNT(m.idMatricula) AS total_alunos
FROM Professor p
INNER JOIN Turma     t ON t.Professor_idProfessor = p.idProfessor
INNER JOIN Matricula m ON m.Turma_idTurma         = t.idTurma
WHERE t.horario >= '2026-01-01'
  AND t.horario <  '2026-07-01'
  AND m.status = 1
GROUP BY p.idProfessor, p.nome
ORDER BY total_alunos DESC
LIMIT 1;


-- ---------------------------------------------------------------------
10. Quais alunos estão com status ativo mas não têm nenhuma matrícula ativa? O time de
coordenação quer verificar se há inconsistência no cadastro.
nome: 
-- ---------------------------------------------------------------------
SELECT
    a.idAluno,
    a.nome_completo,
    a.status
FROM Aluno a
WHERE a.status = 'ativo'
  AND a.idAluno NOT IN (
      SELECT m.Aluno_idAluno
      FROM Matricula m
      WHERE m.status = 1
  );


-- ---------------------------------------------------------------------
11. Qual o percentual médio de frequência por curso? Considere todos os alunos
matriculados em turmas de cada curso. Ordene do curso com maior frequência média para
o com menor.
nome: 
-- ---------------------------------------------------------------------
SELECT
    c.nome AS curso,
    ROUND(
        100.0 * SUM(CASE WHEN f.status IN ('presente','justificado') THEN 1 ELSE 0 END)
              / COUNT(f.idFrequencia),
        1
    ) AS percentual_medio_frequencia
FROM Frequencia f
INNER JOIN Matricula m ON m.idMatricula = f.Matricula_idMatricula
INNER JOIN Turma     t ON t.idTurma     = m.Turma_idTurma
INNER JOIN Curso     c ON c.idCurso     = t.Curso_idCurso
GROUP BY c.idCurso, c.nome
ORDER BY percentual_medio_frequencia DESC;


-- ---------------------------------------------------------------------
12. Liste os 5 alunos com a maior média geral — calculada sobre todas as notas de todas
as turmas em que estão ou estiveram matriculados. Mostre o nome e a média geral
arredondada para 2 casas decimais.
nome: 
-- ---------------------------------------------------------------------
SELECT
    a.nome_completo,
    ROUND(AVG(CAST(n.valor AS NUMERIC)), 2) AS media_geral
FROM Aluno a
INNER JOIN Matricula m ON m.Aluno_idAluno         = a.idAluno
INNER JOIN Nota      n ON n.Matricula_idMatricula = m.idMatricula
GROUP BY a.idAluno, a.nome_completo
ORDER BY media_geral DESC
LIMIT 5;


-- =====================================================================
-- VIEW 1 — Boletim de situação acadêmica (consulta direta)
-- =====================================================================
SELECT
    a.nome_completo                                        AS aluno,
    d.nome                                                 AS disciplina,
    ROUND(AVG(CAST(n.valor AS NUMERIC)), 1)                AS media_atual,
    ROUND(
        100.0 * SUM(CASE WHEN f.status IN ('presente','justificado') THEN 1 ELSE 0 END)
              / NULLIF(COUNT(f.idFrequencia), 0),
        1
    )                                                      AS percentual_frequencia
FROM Matricula m
JOIN Aluno      a ON a.idAluno = m.Aluno_idAluno
JOIN Turma      t ON t.idTurma = m.Turma_idTurma
JOIN Disciplina d ON d.idDisciplina = t.Disciplina_idDisciplina
LEFT JOIN Nota       n ON n.Matricula_idMatricula = m.idMatricula
LEFT JOIN Frequencia f ON f.Matricula_idMatricula = m.idMatricula
WHERE m.status = 1
GROUP BY a.idAluno, a.nome_completo, d.idDisciplina, d.nome
ORDER BY a.nome_completo, d.nome;


-- =====================================================================
-- VIEW 2 — Carga de trabalho dos professores (consulta direta)
-- =====================================================================
SELECT
    p.nome                                  AS professor,
    COUNT(DISTINCT t.idTurma)               AS total_turmas,
    COUNT(DISTINCT m.Aluno_idAluno)         AS total_alunos,
    ROUND(
        SUM(CAST(d.carga_horaria AS NUMERIC)) / 18.0,
        1
    )                                       AS horas_semanais
FROM Professor p
LEFT JOIN Turma      t ON t.Professor_idProfessor = p.idProfessor
LEFT JOIN Disciplina d ON d.idDisciplina = t.Disciplina_idDisciplina
LEFT JOIN Matricula  m ON m.Turma_idTurma = t.idTurma AND m.status = 1
WHERE p.status = 'ativo'
GROUP BY p.idProfessor, p.nome
ORDER BY total_alunos DESC;


-- =====================================================================
-- TRANSACTION TESTE 1 — COMMIT (trancando matrícula 1)
-- =====================================================================
BEGIN;

UPDATE Matricula
SET status = 0,
    data_matri = CURRENT_TIMESTAMP
WHERE idMatricula = 1;

INSERT INTO Frequencia (data, status, turma_desc, Matricula_idMatricula)
SELECT
    TO_CHAR(d::date, 'YYYY-MM-DD'),
    'justificado',
    'T1',
    1
FROM generate_series(
    CURRENT_DATE,
    DATE '2026-06-30',
    INTERVAL '7 days'
) d;

COMMIT;

-- Verificação
SELECT 'POS-COMMIT: Matricula 1' AS etapa, status FROM Matricula WHERE idMatricula = 1;
SELECT 'POS-COMMIT: Frequencias justificadas inseridas' AS etapa, COUNT(*) AS total
FROM Frequencia WHERE Matricula_idMatricula = 1 AND status = 'justificado';


-- =====================================================================
-- TRANSACTION TESTE 2 — ROLLBACK forçado (trancando matrícula 2)
-- =====================================================================
BEGIN;

UPDATE Matricula
SET status = 0,
    data_matri = CURRENT_TIMESTAMP
WHERE idMatricula = 2;

INSERT INTO Frequencia (data, status, turma_desc, Matricula_idMatricula)
SELECT
    TO_CHAR(d::date, 'YYYY-MM-DD'),
    'justificado',
    'T2',
    2
FROM generate_series(
    CURRENT_DATE,
    DATE '2026-06-30',
    INTERVAL '7 days'
) d;

ROLLBACK;

-- Verificação: matrícula 2 deve continuar ativa (status = 1)
SELECT 'POS-ROLLBACK: Matricula 2' AS etapa, status FROM Matricula WHERE idMatricula = 2;
SELECT 'POS-ROLLBACK: Frequencias justificadas' AS etapa, COUNT(*) AS total
FROM Frequencia WHERE Matricula_idMatricula = 2 AND status = 'justificado';
