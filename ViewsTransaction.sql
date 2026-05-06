-- =====================================================================
-- EduFácil - Views e Transaction (PostgreSQL)
-- =====================================================================

-- ---------------------------------------------------------------------
-- VIEW 1 — Boletim de situação acadêmica
-- Retorna para cada aluno com matrícula ATIVA:
--   nome, disciplina, média atual, percentual de frequência
-- ---------------------------------------------------------------------
DROP VIEW IF EXISTS vw_boletim_situacao_academica;

CREATE VIEW vw_boletim_situacao_academica AS
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
WHERE m.status = 1   -- 1 = ativa
GROUP BY a.idAluno, a.nome_completo, d.idDisciplina, d.nome
ORDER BY a.nome_completo, d.nome;


-- ---------------------------------------------------------------------
-- VIEW 2 — Carga de trabalho dos professores
-- Para cada professor ATIVO retorna:
--   nome, total de turmas, total de alunos, horas semanais
-- (horas semanais = soma da carga_horaria das disciplinas das turmas / 18 semanas)
-- ---------------------------------------------------------------------
DROP VIEW IF EXISTS vw_carga_professores;

CREATE VIEW vw_carga_professores AS
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
-- TRANSACTION — Trancamento de matrícula
-- =====================================================================
-- Cenário: aluno solicita trancamento.
-- Duas operações que devem acontecer juntas:
--   1. Status da matrícula vira 0 (cancelada) com data atual
--   2. Insere frequência 'justificado' para todas aulas futuras da turma
-- Se qualquer uma falhar, nada persiste.
-- ---------------------------------------------------------------------

-- ===== TESTE 1: Transaction bem-sucedida (COMMIT) =====
-- Trancando a matrícula 1 (Aluno 1 - Joao Pedro Lima na Turma 1 - Logica)

BEGIN;

-- Operação 1: cancelar a matrícula
UPDATE Matricula
SET status = 0,
    data_mastri = CURRENT_TIMESTAMP
WHERE idMatricula = 1;

-- Operação 2: inserir frequências justificadas para aulas futuras
-- (consideramos aulas futuras as datas posteriores a hoje na mesma turma)
INSERT INTO Frequencia (data, status, turma, Matricula_idMatricula)
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

-- Verificação: matrícula deve estar cancelada e frequências futuras inseridas
SELECT 'POS-COMMIT: Matricula 1' AS etapa, status FROM Matricula WHERE idMatricula = 1;
SELECT 'POS-COMMIT: Frequencias justificadas inseridas' AS etapa, COUNT(*) AS total
FROM Frequencia WHERE Matricula_idMatricula = 1 AND status = 'justificado';


-- ===== TESTE 2: Transaction com ROLLBACK forçado =====
-- Trancando matrícula 2 (mesmo aluno, turma 2 - BD)
-- Forçamos uma falha no meio para provar que nada persiste

BEGIN;

-- Operação 1: cancelar matrícula 2
UPDATE Matricula
SET status = 0,
    data_mastri = CURRENT_TIMESTAMP
WHERE idMatricula = 2;

-- Operação 2: inserir frequências
INSERT INTO Frequencia (data, status, turma, Matricula_idMatricula)
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

-- Falha simulada: ROLLBACK explícito (poderia ser uma FK quebrada,
-- violação de constraint, erro de aplicação etc.)
ROLLBACK;

-- Verificação: matrícula 2 deve continuar ATIVA (status = 1)
-- e nenhuma frequência justificada deve ter sido inserida
SELECT 'POS-ROLLBACK: Matricula 2' AS etapa, status FROM Matricula WHERE idMatricula = 2;
SELECT 'POS-ROLLBACK: Frequencias justificadas' AS etapa, COUNT(*) AS total
FROM Frequencia WHERE Matricula_idMatricula = 2 AND status = 'justificado';
