/*
 ProjetoHosp - Modelo relacional de referencia (SQL Server)
 A aplicacao Flutter utiliza Cloud Firestore como banco operacional.
 Este script documenta entidades e pode apoiar uma migracao de legado.
 Use somente dados ficticios em desenvolvimento.
*/
IF DB_ID(N'ProjetoHosp') IS NULL CREATE DATABASE ProjetoHosp;
GO
USE ProjetoHosp;
GO

IF OBJECT_ID('dbo.Setores','U') IS NULL
CREATE TABLE dbo.Setores (
  SetorId INT IDENTITY(1,1) PRIMARY KEY,
  Nome NVARCHAR(100) NOT NULL,
  Descricao NVARCHAR(300) NULL
);
GO

IF OBJECT_ID('dbo.Funcionarios','U') IS NULL
CREATE TABLE dbo.Funcionarios (
  FuncionarioId INT IDENTITY(1,1) PRIMARY KEY,
  Nome NVARCHAR(150) NOT NULL,
  Cargo NVARCHAR(100) NOT NULL,
  SetorId INT NULL REFERENCES dbo.Setores(SetorId),
  Ativo BIT NOT NULL DEFAULT 1
);
GO

IF OBJECT_ID('dbo.Pacientes','U') IS NULL
CREATE TABLE dbo.Pacientes (
  PacienteId INT IDENTITY(1,1) PRIMARY KEY,
  Nome NVARCHAR(150) NOT NULL,
  DataNascimento DATE NULL,
  Telefone NVARCHAR(30) NULL,
  CriadoEm DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);
GO

IF OBJECT_ID('dbo.Leitos','U') IS NULL
CREATE TABLE dbo.Leitos (
  LeitoId INT IDENTITY(1,1) PRIMARY KEY,
  Codigo NVARCHAR(20) NOT NULL UNIQUE,
  SetorId INT NOT NULL REFERENCES dbo.Setores(SetorId),
  Status NVARCHAR(30) NOT NULL DEFAULT N'Disponivel'
);
GO

IF OBJECT_ID('dbo.Internacoes','U') IS NULL
CREATE TABLE dbo.Internacoes (
  InternacaoId INT IDENTITY(1,1) PRIMARY KEY,
  PacienteId INT NOT NULL REFERENCES dbo.Pacientes(PacienteId),
  LeitoId INT NOT NULL REFERENCES dbo.Leitos(LeitoId),
  DataEntrada DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
  DataSaida DATETIME2 NULL,
  Status NVARCHAR(30) NOT NULL DEFAULT N'Ativa'
);
GO

IF OBJECT_ID('dbo.Atendimentos','U') IS NULL
CREATE TABLE dbo.Atendimentos (
  AtendimentoId INT IDENTITY(1,1) PRIMARY KEY,
  PacienteId INT NOT NULL REFERENCES dbo.Pacientes(PacienteId),
  FuncionarioId INT NULL REFERENCES dbo.Funcionarios(FuncionarioId),
  DataAtendimento DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
  Tipo NVARCHAR(50) NOT NULL,
  Observacao NVARCHAR(1000) NULL
);
GO

IF OBJECT_ID('dbo.Exames','U') IS NULL
CREATE TABLE dbo.Exames (
  ExameId INT IDENTITY(1,1) PRIMARY KEY,
  PacienteId INT NOT NULL REFERENCES dbo.Pacientes(PacienteId),
  NomeExame NVARCHAR(150) NOT NULL,
  DataSolicitacao DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
  Status NVARCHAR(30) NOT NULL DEFAULT N'Solicitado'
);
GO

CREATE INDEX IX_Internacoes_Paciente ON dbo.Internacoes(PacienteId);
CREATE INDEX IX_Atendimentos_Paciente_Data ON dbo.Atendimentos(PacienteId, DataAtendimento);
CREATE INDEX IX_Exames_Paciente_Data ON dbo.Exames(PacienteId, DataSolicitacao);
GO
