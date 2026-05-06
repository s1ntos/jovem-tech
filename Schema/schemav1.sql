DROP DATABASE IF EXISTS edufacil;
CREATE DATABASE edufacil CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE edufacil;

CREATE TABLE Curso (
    idCurso         INT AUTO_INCREMENT PRIMARY KEY,
    nome            VARCHAR(45) NOT NULL,
    dur_semestre    INT NOT NULL,
    area_conhe      VARCHAR(45) NOT NULL
);

CREATE TABLE Disciplina (
    idDisciplina    INT AUTO_INCREMENT PRIMARY KEY,
    nome            VARCHAR(45) NOT NULL,
    carga_horaria   VARCHAR(45) NOT NULL,
    ementa          VARCHAR(255)
);

CREATE TABLE Professor (
    idProfessor     INT AUTO_INCREMENT PRIMARY KEY,
    especialidade   VARCHAR(45),
    status          VARCHAR(45) NOT NULL DEFAULT 'ativo',
                    -- valores: 'ativo', 'afastado'
    nome            VARCHAR(45) NOT NULL
);
CREATE TABLE Aluno (
    idAluno         INT AUTO_INCREMENT PRIMARY KEY,
    nome_completo   VARCHAR(45) NOT NULL,
    cpf             VARCHAR(45) UNIQUE NOT NULL,
    data_nasc       DATETIME NOT NULL,
    contato         VARCHAR(45),
    status          VARCHAR(45) NOT NULL DEFAULT 'ativo'
                    -- valores: 'ativo', 'trancado', 'formado'
);

CREATE TABLE curso_disc (
    Disciplina_idDisciplina INT NOT NULL,
    Curso_idCurso           INT NOT NULL,
    PRIMARY KEY (Disciplina_idDisciplina, Curso_idCurso),
    FOREIGN KEY (Disciplina_idDisciplina) REFERENCES Disciplina(idDisciplina),
    FOREIGN KEY (Curso_idCurso) REFERENCES Curso(idCurso)
);

CREATE TABLE Turma (
    idTurma                 INT AUTO_INCREMENT PRIMARY KEY,
    horario                 DATETIME,
    SALA                    VARCHAR(45),
    PROFESSOR               VARCHAR(45),  -- campo descritivo conforme diagrama
    Professor_idProfessor   INT NOT NULL,
    Disciplina_idDisciplina INT NOT NULL,
    Curso_idCurso           INT NOT NULL,
    FOREIGN KEY (Professor_idProfessor) REFERENCES Professor(idProfessor),
    FOREIGN KEY (Disciplina_idDisciplina) REFERENCES Disciplina(idDisciplina),
    FOREIGN KEY (Curso_idCurso) REFERENCES Curso(idCurso)
);

CREATE TABLE Matricula (
    idMatricula     INT AUTO_INCREMENT PRIMARY KEY,
    data_mastri     DATETIME NOT NULL,
    status          TINYINT NOT NULL,
                    -- 0 = cancelada, 1 = ativa, 2 = concluida
    Aluno_idAluno   INT NOT NULL,
    Turma_idTurma   INT NOT NULL,
    UNIQUE KEY uk_aluno_turma (Aluno_idAluno, Turma_idTurma),
    FOREIGN KEY (Aluno_idAluno) REFERENCES Aluno(idAluno),
    FOREIGN KEY (Turma_idTurma) REFERENCES Turma(idTurma)
);

CREATE TABLE Nota (
    idNota                  INT AUTO_INCREMENT PRIMARY KEY,
    valor                   VARCHAR(45) NOT NULL,
    data                    DATETIME NOT NULL,
    tipo_avalia             VARCHAR(45) NOT NULL,
    Matricula_idMatricula   INT NOT NULL,
    FOREIGN KEY (Matricula_idMatricula) REFERENCES Matricula(idMatricula)
);

CREATE TABLE Frequencia (
    idFrequencia            INT AUTO_INCREMENT PRIMARY KEY,
    data                    VARCHAR(45) NOT NULL,
    status                  VARCHAR(45) NOT NULL,
                            -- valores: 'presente', 'ausente', 'justificado'
    turma                   VARCHAR(45),
    Matricula_idMatricula   INT NOT NULL,
    FOREIGN KEY (Matricula_idMatricula) REFERENCES Matricula(idMatricula)
);
