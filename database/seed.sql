-- GPbuS: dados fictícios para testar o app desktop.
-- Execute depois de schema.sql.
-- Login de teste: admin@gpbus.dev / senha: gpbus123 (CPF para recuperar senha: 000.000.000-00)
-- A senha é salva como hash PBKDF2-SHA256.

USE gpbus;

-- Limpa os dados de teste para o script poder ser rodado mais de uma vez.
SET FOREIGN_KEY_CHECKS = 0;
DELETE FROM TCC_Motorista;
DELETE FROM TCC_Linha;
DELETE FROM TCC_Administrador WHERE EmailADM = 'admin@gpbus.dev';
DELETE FROM TCC_Analytics WHERE Company = 'GPbuS';
DELETE FROM TCC_Grafico WHERE Company = 32;
SET FOREIGN_KEY_CHECKS = 1;

INSERT INTO TCC_Administrador (NomeADM, DataNascADM, EmailADM, SenhaADM, CelularADM, CPFADM, CidadeADM, EstadoADM, EnderecoADM, CEPADM, NomeUsuarioADM) VALUES
('Administrador Teste', '01/01/2000', 'admin@gpbus.dev', 'pbkdf2$100000$k+dw1K7cyy9vsSE19G8ceg==$Jga11685cx5FolGtZUgibBJhimq1tNWbIW+wOGKmwUc=', '(19) 90000-0000', '000.000.000-00', 'Limeira', 'SP', 'Rua Exemplo, 100', '13480-000', 'admin');

INSERT INTO TCC_Linha (NumeroLINHA, NomeLINHA, EmpresaLINHA, Sentido1LINHA, Sentido2LINHA, TipoLINHA, HrPartidaS1LINHA, HrPartidaS2LINHA) VALUES
(101, 'Centro / Jardim Primavera', 'Viação Exemplo', 'Centro', 'Jardim Primavera', 'Urbano', '06:00', '06:40'),
(202, 'Terminal / Universidade', 'Viação Exemplo', 'Terminal', 'Universidade', 'Urbano', '07:15', '07:55'),
(303, 'Rodoviária / Distrito Industrial', 'Transportes Modelo', 'Rodoviária', 'Distrito Industrial', 'Fretado', '05:30', '17:10');

INSERT INTO TCC_Motorista (NomeMOTO, DataNascMOTO, CNHMOTO, EmailMOTO, NumeroOnibusMOTO, CelularMOTO, EstadoMOTO, CidadeMOTO, EnderecoMOTO, CEPMOTO, AvaliacaoMOTO) VALUES
('Carlos Exemplo', '10/03/1985', '00000000001', 'carlos@exemplo.dev', 101, '(19) 90000-0001', 'SP', 'Limeira', 'Rua A, 10', '13480-001', '4.8'),
('Mariana Teste', '22/07/1990', '00000000002', 'mariana@exemplo.dev', 202, '(19) 90000-0002', 'SP', 'Limeira', 'Rua B, 20', '13480-002', '4.6'),
('João Modelo', '05/11/1978', '00000000003', 'joao@exemplo.dev', 303, '(19) 90000-0003', 'SP', 'Campinas', 'Rua C, 30', '13083-000', '4.9');

-- O app lê os indicadores da empresa "GPbuS".
INSERT INTO TCC_Analytics (Earings, Downloads, Costumers, Managers, Drivers, Bosses, MonthlyGoal, Company) VALUES
(285000, 1240, 860, 12, 45, 3, 57, 'GPbuS');

-- O app lê o gráfico da linha com Company = 32.
INSERT INTO TCC_Grafico (Company, Earning1, Earning2, Earning3, Earning4, Earning5, Earning6, Earning7, Earning8, Earning9, Earning10,
 Earning11, Earning12, Earning13, Earning14, Earning15, Earning16, Earning17, Earning18, Earning19, Earning20,
 Earning21, Earning22, Earning23, Earning24, Earning25, Earning26, Earning27, Earning28, Earning29, Earning30, Earning31) VALUES
(32, 8200, 9100, 8700, 9600, 10400, 7200, 6800, 8900, 9300, 9800,
 10100, 10900, 7600, 7100, 9000, 9500, 9900, 10600, 11200, 7900,
 7300, 9400, 9700, 10200, 10800, 11500, 8100, 7500, 9600, 10300, 11000);
