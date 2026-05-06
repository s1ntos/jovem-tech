-- Prevenção de duplicar telas
DROP TABLE IF EXISTS Frequencia;
DROP TABLE IF EXISTS Nota;
DROP TABLE IF EXISTS Matricula;
DROP TABLE IF EXISTS Turma;
DROP TABLE IF EXISTS curso_disc;
DROP TABLE IF EXISTS Aluno;
DROP TABLE IF EXISTS Professor;
DROP TABLE IF EXISTS Disciplina;
DROP TABLE IF EXISTS Curso;

CREATE TABLE Curso (
    idCurso       SERIAL PRIMARY KEY,
    nome          VARCHAR(45) NOT NULL,
    dur_semestre  INT NOT NULL,
    area_conhe    VARCHAR(45) NOT NULL
);

CREATE TABLE Disciplina (
    idDisciplina  SERIAL PRIMARY KEY,
    nome          VARCHAR(45) NOT NULL,
    carga_horaria VARCHAR(45) NOT NULL,
    ementa        VARCHAR(255)
);

CREATE TABLE Professor (
    idProfessor   SERIAL PRIMARY KEY,
    especialidade VARCHAR(45),
    status        VARCHAR(45) NOT NULL DEFAULT 'ativo', -- 'ativo', 'afastado'
    nome          VARCHAR(45) NOT NULL
);

CREATE TABLE Aluno (
    idAluno       SERIAL PRIMARY KEY,
    nome_completo VARCHAR(45) NOT NULL,
    cpf           VARCHAR(45) UNIQUE NOT NULL,
    data_nasc     TIMESTAMP NOT NULL,
    contato       VARCHAR(45),
    status        VARCHAR(45) NOT NULL DEFAULT 'ativo' -- 'ativo', 'trancado', 'formado'
);

CREATE TABLE curso_disc (
    Disciplina_idDisciplina INT NOT NULL,
    Curso_idCurso           INT NOT NULL,
    PRIMARY KEY (Disciplina_idDisciplina, Curso_idCurso),
    FOREIGN KEY (Disciplina_idDisciplina) REFERENCES Disciplina(idDisciplina),
    FOREIGN KEY (Curso_idCurso) REFERENCES Curso(idCurso)
);

CREATE TABLE Turma (
    idTurma                 SERIAL PRIMARY KEY,
    horario                 TIMESTAMP,
    SALA                    VARCHAR(45),
    PROFESSOR_NOME          VARCHAR(45), -- Alterado de 'PROFESSOR' para evitar conflito de nome
    Professor_idProfessor   INT NOT NULL,
    Disciplina_idDisciplina INT NOT NULL,
    Curso_idCurso           INT NOT NULL,
    FOREIGN KEY (Professor_idProfessor) REFERENCES Professor(idProfessor),
    FOREIGN KEY (Disciplina_idDisciplina) REFERENCES Disciplina(idDisciplina),
    FOREIGN KEY (Curso_idCurso) REFERENCES Curso(idCurso)
);

CREATE TABLE Matricula (
    idMatricula     SERIAL PRIMARY KEY,
    data_matri      TIMESTAMP NOT NULL,
    status          SMALLINT NOT NULL, -- 0 = cancelada, 1 = ativa, 2 = concluida
    Aluno_idAluno   INT NOT NULL,
    Turma_idTurma   INT NOT NULL,
    CONSTRAINT uk_aluno_turma UNIQUE (Aluno_idAluno, Turma_idTurma),
    FOREIGN KEY (Aluno_idAluno) REFERENCES Aluno(idAluno),
    FOREIGN KEY (Turma_idTurma) REFERENCES Turma(idTurma)
);

CREATE TABLE Nota (
    idNota                 SERIAL PRIMARY KEY,
    valor                  VARCHAR(45) NOT NULL,
    data                   TIMESTAMP NOT NULL,
    tipo_avalia            VARCHAR(45) NOT NULL,
    Matricula_idMatricula  INT NOT NULL,
    FOREIGN KEY (Matricula_idMatricula) REFERENCES Matricula(idMatricula)
);

CREATE TABLE Frequencia (
    idFrequencia           SERIAL PRIMARY KEY,
    data                   VARCHAR(45) NOT NULL,
    status                 VARCHAR(45) NOT NULL, -- 'presente', 'ausente', 'justificado'
    turma_desc             VARCHAR(45),
    Matricula_idMatricula  INT NOT NULL,
    FOREIGN KEY (Matricula_idMatricula) REFERENCES Matricula(idMatricula)
);
