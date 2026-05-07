-- ---------------------------------------------------------------------
1. Quais turmas estão em andamento neste semestre? Mostre a disciplina, o professor
responsável, a sala e o horário 
nome: 
-- ---------------------------------------------------------------------



-- ---------------------------------------------------------------------
2. Quantos alunos estão matriculados em cada turma? Mostre apenas turmas com pelo
menos 5 alunos ativos. Ordene da turma com mais alunos para a com menos.
nome: 
-- ---------------------------------------------------------------------


-- ---------------------------------------------------------------------
3. Qual a média de notas por aluno em cada turma? Mostre o nome do aluno, a disciplina e
a média arredondada para 1 casa decimal. Ordene por disciplina e, dentro de cada
disciplina, da maior média para a menor.
nome: 
-- ---------------------------------------------------------------------


-- ---------------------------------------------------------------------
4. Quais alunos têm frequência abaixo de 75% em pelo menos uma turma? Mostre o nome
do aluno, a disciplina e o percentual de presença. A escola considera ausente qualquer aula
sem registro de presença ou justificativa.
nome: 
-- ---------------------------------------------------------------------



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



-- ---------------------------------------------------------------------
8. Liste todos os alunos matriculados em mais de uma turma no semestre atual. Mostre o
nome e a contagem de matrículas ativas.
nome: 
-- ---------------------------------------------------------------------



-- ---------------------------------------------------------------------
9. Qual o professor com maior número de alunos sob sua responsabilidade (somando todos
os alunos de todas as suas turmas ativas)? Mostre o nome e o total de alunos.
nome: 
-- ---------------------------------------------------------------------



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
