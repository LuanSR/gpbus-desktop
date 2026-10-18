-- Migração para bancos criados com a versão anterior do schema.sql.
-- Aumenta a coluna de senha para caber o hash PBKDF2.
USE gpbus;
ALTER TABLE TCC_Administrador MODIFY `SenhaADM` varchar(255) DEFAULT NULL;
