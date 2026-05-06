-- =====================================================================
-- EduFácil - População de dados (PostgreSQL)
-- Adaptado ao schema com colunas: PROFESSOR_NOME, data_matri, turma_desc
-- =====================================================================
 
-- ---------------------------------------------------------------------
-- CURSOS (3)
-- ---------------------------------------------------------------------
INSERT INTO Curso (nome, dur_semestre, area_conhe) VALUES
('Tecnico em Informatica',     4, 'Tecnologia'),
('Tecnico em Eletronica',      4, 'Engenharia'),
('Tecnico em Administracao',   3, 'Negocios');
 
-- ---------------------------------------------------------------------
-- DISCIPLINAS (8)
-- ---------------------------------------------------------------------
INSERT INTO Disciplina (nome, carga_horaria, ementa) VALUES
('Logica de Programacao',  '80', 'Algoritmos e estruturas de controle'),
('Banco de Dados',         '80', 'Modelagem, SQL e normalizacao'),
('Redes de Computadores',  '60', 'Topologias, protocolos e TCP/IP'),
('Eletronica Analogica',   '80', 'Resistores, capacitores e transistores'),
('Eletronica Digital',     '80', 'Logica booleana e circuitos'),
('Matematica Aplicada',    '60', 'Funcoes, matrizes e estatistica'),
('Gestao de Projetos',     '60', 'PMBOK, agil e cronogramas'),
('Ingles Tecnico',         '40', 'Leitura de textos tecnicos');
 
-- ---------------------------------------------------------------------
-- CURSO_DISC (relacionamento N:N)
-- ---------------------------------------------------------------------
INSERT INTO curso_disc (Disciplina_idDisciplina, Curso_idCurso) VALUES
(1,1),(2,1),(3,1),(6,1),(8,1),
(4,2),(5,2),(6,2),(8,2),
(7,3),(6,3),(8,3);
 
-- ---------------------------------------------------------------------
-- PROFESSORES (6, sendo 1 afastado)
-- ---------------------------------------------------------------------
INSERT INTO Professor (especialidade, status, nome) VALUES
('Programacao',     'ativo',     'Carlos Silva'),
('Banco de Dados',  'ativo',     'Ana Pereira'),
('Redes',           'ativo',     'Roberto Santos'),
('Eletronica',      'ativo',     'Mariana Costa'),
('Matematica',      'ativo',     'Fernando Oliveira'),
('Gestao',          'afastado',  'Juliana Almeida');
 
-- ---------------------------------------------------------------------
-- ALUNOS (30, sendo 3 nao-ativos)
-- ---------------------------------------------------------------------
INSERT INTO Aluno (nome_completo, cpf, data_nasc, contato, status) VALUES
('Joao Pedro Lima',         '111.111.111-01', '2003-03-15', '79988880001', 'ativo'),
('Maria Eduarda Rocha',     '111.111.111-02', '2002-07-22', '79988880002', 'ativo'),
('Lucas Henrique Souza',    '111.111.111-03', '2004-01-10', '79988880003', 'ativo'),
('Beatriz Andrade',         '111.111.111-04', '2003-11-05', '79988880004', 'ativo'),
('Gabriel Martins',         '111.111.111-05', '2002-05-18', '79988880005', 'ativo'),
('Larissa Mendes',          '111.111.111-06', '2003-09-30', '79988880006', 'ativo'),
('Rafael Carvalho',         '111.111.111-07', '2004-02-14', '79988880007', 'ativo'),
('Camila Ribeiro',          '111.111.111-08', '2003-06-25', '79988880008', 'ativo'),
('Thiago Barbosa',          '111.111.111-09', '2002-12-08', '79988880009', 'ativo'),
('Juliana Ferreira',        '111.111.111-10', '2003-04-19', '79988880010', 'ativo'),
('Pedro Henrique Alves',    '111.111.111-11', '2004-08-03', '79988880011', 'ativo'),
('Amanda Cardoso',          '111.111.111-12', '2003-10-27', '79988880012', 'ativo'),
('Bruno Nascimento',        '111.111.111-13', '2002-01-12', '79988880013', 'ativo'),
('Leticia Gomes',           '111.111.111-14', '2003-07-07', '79988880014', 'ativo'),
('Felipe Araujo',           '111.111.111-15', '2004-03-21', '79988880015', 'ativo'),
('Isabela Pinto',           '111.111.111-16', '2003-05-09', '79988880016', 'ativo'),
('Matheus Correia',         '111.111.111-17', '2002-11-16', '79988880017', 'ativo'),
('Gabriela Moreira',        '111.111.111-18', '2003-08-23', '79988880018', 'ativo'),
('Vinicius Ramos',          '111.111.111-19', '2004-04-11', '79988880019', 'ativo'),
('Sofia Cavalcanti',        '111.111.111-20', '2003-02-28', '79988880020', 'ativo'),
('Daniel Teixeira',         '111.111.111-21', '2002-09-04', '79988880021', 'ativo'),
('Natalia Dias',            '111.111.111-22', '2003-12-17', '79988880022', 'ativo'),
('Eduardo Pires',           '111.111.111-23', '2004-06-29', '79988880023', 'ativo'),
('Fernanda Lopes',          '111.111.111-24', '2003-01-08', '79988880024', 'ativo'),
('Henrique Vieira',         '111.111.111-25', '2002-04-13', '79988880025', 'ativo'),
('Patricia Monteiro',       '111.111.111-26', '2003-10-02', '79988880026', 'ativo'),
('Rodrigo Castro',          '111.111.111-27', '2004-07-26', '79988880027', 'ativo'),
('Carolina Freitas',        '111.111.111-28', '2001-03-14', '79988880028', 'trancado'),
('Marcelo Duarte',          '111.111.111-29', '2000-08-19', '79988880029', 'trancado'),
('Patricia Sales',          '111.111.111-30', '1999-05-22', '79988880030', 'formado');
 
-- ---------------------------------------------------------------------
-- TURMAS (10) - usa PROFESSOR_NOME (não mais PROFESSOR)
-- ---------------------------------------------------------------------
INSERT INTO Turma (horario, SALA, PROFESSOR_NOME, Professor_idProfessor, Disciplina_idDisciplina, Curso_idCurso) VALUES
('2026-02-02 19:00:00', 'Sala 101', 'Carlos Silva',      1, 1, 1),
('2026-02-03 19:00:00', 'Sala 102', 'Ana Pereira',       2, 2, 1),
('2026-02-02 21:00:00', 'Sala 103', 'Roberto Santos',    3, 3, 1),
('2026-02-03 19:00:00', 'Sala 201', 'Mariana Costa',     4, 4, 2),
('2026-02-02 19:00:00', 'Sala 202', 'Mariana Costa',     4, 5, 2),
('2026-02-06 19:00:00', 'Sala 301', 'Fernando Oliveira', 5, 6, 3),
('2026-02-03 21:00:00', 'Sala 104', 'Fernando Oliveira', 5, 6, 1),
('2025-08-04 19:00:00', 'Sala 101', 'Carlos Silva',      1, 1, 1),
('2025-08-05 19:00:00', 'Sala 102', 'Ana Pereira',       2, 2, 1),
('2025-08-08 19:00:00', 'Sala 301', 'Juliana Almeida',   6, 7, 3);
 
-- ---------------------------------------------------------------------
-- MATRICULAS - usa data_matri (não mais data_mastri)
-- status SMALLINT: 0=cancelada, 1=ativa, 2=concluida
-- ---------------------------------------------------------------------
 
-- T1 (10 ativas + 1 cancelada)
INSERT INTO Matricula (data_matri, status, Aluno_idAluno, Turma_idTurma) VALUES
('2026-02-01', 1, 1, 1),('2026-02-01', 1, 2, 1),('2026-02-01', 1, 3, 1),
('2026-02-01', 1, 4, 1),('2026-02-01', 1, 5, 1),('2026-02-01', 1, 6, 1),
('2026-02-01', 1, 7, 1),('2026-02-01', 1, 8, 1),('2026-02-01', 1, 9, 1),
('2026-02-01', 1, 10, 1),('2026-02-15', 0, 12, 1);
 
-- T2 (10 ativas)
INSERT INTO Matricula (data_matri, status, Aluno_idAluno, Turma_idTurma) VALUES
('2026-02-01', 1, 1, 2),('2026-02-01', 1, 2, 2),('2026-02-01', 1, 3, 2),
('2026-02-01', 1, 4, 2),('2026-02-01', 1, 5, 2),('2026-02-01', 1, 13, 2),
('2026-02-01', 1, 14, 2),('2026-02-01', 1, 15, 2),('2026-02-01', 1, 16, 2),
('2026-02-01', 1, 17, 2);
 
-- T3 (10 ativas + 1 cancelada)
INSERT INTO Matricula (data_matri, status, Aluno_idAluno, Turma_idTurma) VALUES
('2026-02-01', 1, 1, 3),('2026-02-01', 1, 7, 3),('2026-02-01', 1, 8, 3),
('2026-02-01', 1, 9, 3),('2026-02-01', 1, 10, 3),('2026-02-01', 1, 11, 3),
('2026-02-01', 1, 13, 3),('2026-02-01', 1, 14, 3),('2026-02-01', 1, 15, 3),
('2026-02-01', 1, 16, 3),('2026-02-20', 0, 18, 3);
 
-- T4 (10 ativas)
INSERT INTO Matricula (data_matri, status, Aluno_idAluno, Turma_idTurma) VALUES
('2026-02-01', 1, 18, 4),('2026-02-01', 1, 19, 4),('2026-02-01', 1, 20, 4),
('2026-02-01', 1, 21, 4),('2026-02-01', 1, 22, 4),('2026-02-01', 1, 23, 4),
('2026-02-01', 1, 24, 4),('2026-02-01', 1, 25, 4),('2026-02-01', 1, 26, 4),
('2026-02-01', 1, 27, 4);
 
-- T5 (10 ativas + 1 cancelada)
INSERT INTO Matricula (data_matri, status, Aluno_idAluno, Turma_idTurma) VALUES
('2026-02-01', 1, 18, 5),('2026-02-01', 1, 19, 5),('2026-02-01', 1, 20, 5),
('2026-02-01', 1, 21, 5),('2026-02-01', 1, 22, 5),('2026-02-01', 1, 23, 5),
('2026-02-01', 1, 24, 5),('2026-02-01', 1, 25, 5),('2026-02-01', 1, 26, 5),
('2026-02-01', 1, 27, 5),('2026-02-25', 0, 17, 5);
 
-- T6 (10 ativas)
INSERT INTO Matricula (data_matri, status, Aluno_idAluno, Turma_idTurma) VALUES
('2026-02-01', 1, 12, 6),('2026-02-01', 1, 13, 6),('2026-02-01', 1, 14, 6),
('2026-02-01', 1, 15, 6),('2026-02-01', 1, 16, 6),('2026-02-01', 1, 17, 6),
('2026-02-01', 1, 19, 6),('2026-02-01', 1, 20, 6),('2026-02-01', 1, 21, 6),
('2026-02-01', 1, 22, 6);
 
-- T7 (10 ativas + 1 cancelada)
INSERT INTO Matricula (data_matri, status, Aluno_idAluno, Turma_idTurma) VALUES
('2026-02-01', 1, 1, 7),('2026-02-01', 1, 2, 7),('2026-02-01', 1, 3, 7),
('2026-02-01', 1, 4, 7),('2026-02-01', 1, 5, 7),('2026-02-01', 1, 6, 7),
('2026-02-01', 1, 7, 7),('2026-02-01', 1, 8, 7),('2026-02-01', 1, 9, 7),
('2026-02-01', 1, 10, 7),('2026-03-01', 0, 11, 7);
 
-- T8 (10 concluidas)
INSERT INTO Matricula (data_matri, status, Aluno_idAluno, Turma_idTurma) VALUES
('2025-08-01', 2, 13, 8),('2025-08-01', 2, 14, 8),('2025-08-01', 2, 15, 8),
('2025-08-01', 2, 16, 8),('2025-08-01', 2, 17, 8),('2025-08-01', 2, 18, 8),
('2025-08-01', 2, 19, 8),('2025-08-01', 2, 20, 8),('2025-08-01', 2, 21, 8),
('2025-08-01', 2, 30, 8);
 
-- T9 (10 concluidas + 1 cancelada)
INSERT INTO Matricula (data_matri, status, Aluno_idAluno, Turma_idTurma) VALUES
('2025-08-01', 2, 22, 9),('2025-08-01', 2, 23, 9),('2025-08-01', 2, 24, 9),
('2025-08-01', 2, 25, 9),('2025-08-01', 2, 26, 9),('2025-08-01', 2, 27, 9),
('2025-08-01', 2, 28, 9),('2025-08-01', 2, 29, 9),('2025-08-01', 2, 30, 9),
('2025-08-01', 2, 11, 9),('2025-08-15', 0, 19, 9);
 
-- T10 (10 concluidas)
INSERT INTO Matricula (data_matri, status, Aluno_idAluno, Turma_idTurma) VALUES
('2025-08-01', 2, 12, 10),('2025-08-01', 2, 13, 10),('2025-08-01', 2, 14, 10),
('2025-08-01', 2, 15, 10),('2025-08-01', 2, 16, 10),('2025-08-01', 2, 17, 10),
('2025-08-01', 2, 28, 10),('2025-08-01', 2, 29, 10),('2025-08-01', 2, 22, 10),
('2025-08-01', 2, 23, 10);
 
-- ---------------------------------------------------------------------
-- NOTAS - 2 por matricula nao-cancelada (P1 + P2)
-- ---------------------------------------------------------------------
INSERT INTO Nota (valor, data, tipo_avalia, Matricula_idMatricula)
SELECT
    ROUND((4 + (m.idMatricula * 7 % 60) / 10.0)::numeric, 1)::text,
    '2026-04-15'::timestamp,
    'P1',
    m.idMatricula
FROM Matricula m
WHERE m.status IN (1, 2);
 
INSERT INTO Nota (valor, data, tipo_avalia, Matricula_idMatricula)
SELECT
    ROUND((5 + (m.idMatricula * 11 % 50) / 10.0)::numeric, 1)::text,
    '2026-05-15'::timestamp,
    'P2',
    m.idMatricula
FROM Matricula m
WHERE m.status IN (1, 2);
 
-- ---------------------------------------------------------------------
-- FREQUENCIA - 6 datas por matricula (atende mínimo de 5)
-- usa turma_desc (não mais turma)
-- ---------------------------------------------------------------------
INSERT INTO Frequencia (data, status, turma_desc, Matricula_idMatricula)
SELECT '2026-03-02', 'presente', 'T'||m.Turma_idTurma, m.idMatricula
FROM Matricula m WHERE m.status IN (1, 2);
 
INSERT INTO Frequencia (data, status, turma_desc, Matricula_idMatricula)
SELECT '2026-03-09',
       CASE WHEN m.idMatricula % 7 = 0 THEN 'ausente' ELSE 'presente' END,
       'T'||m.Turma_idTurma, m.idMatricula
FROM Matricula m WHERE m.status IN (1, 2);
 
INSERT INTO Frequencia (data, status, turma_desc, Matricula_idMatricula)
SELECT '2026-03-16',
       CASE WHEN m.idMatricula % 5 = 0 THEN 'ausente' ELSE 'presente' END,
       'T'||m.Turma_idTurma, m.idMatricula
FROM Matricula m WHERE m.status IN (1, 2);
 
INSERT INTO Frequencia (data, status, turma_desc, Matricula_idMatricula)
SELECT '2026-03-23',
       CASE WHEN m.idMatricula % 6 = 0 THEN 'justificado' ELSE 'presente' END,
       'T'||m.Turma_idTurma, m.idMatricula
FROM Matricula m WHERE m.status IN (1, 2);
 
INSERT INTO Frequencia (data, status, turma_desc, Matricula_idMatricula)
SELECT '2026-03-30',
       CASE WHEN m.idMatricula % 4 = 0 THEN 'ausente' ELSE 'presente' END,
       'T'||m.Turma_idTurma, m.idMatricula
FROM Matricula m WHERE m.status IN (1, 2);
 
INSERT INTO Frequencia (data, status, turma_desc, Matricula_idMatricula)
SELECT '2026-04-06',
       CASE WHEN m.idMatricula % 3 = 0 THEN 'ausente' ELSE 'presente' END,
       'T'||m.Turma_idTurma, m.idMatricula
FROM Matricula m WHERE m.status IN (1, 2);
