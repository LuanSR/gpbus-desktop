-- GPbuS: estrutura do banco de dados (MySQL)
-- Exportado do banco original do TCC (Cotil-Unicamp, 2023), somente estrutura.
-- Uso: execute este arquivo e depois seed.sql no MySQL Workbench.

CREATE DATABASE IF NOT EXISTS gpbus CHARACTER SET utf8mb4;
USE gpbus;

SET FOREIGN_KEY_CHECKS = 0;

--
-- Table structure for table `TCC_Administrador`
--

DROP TABLE IF EXISTS `TCC_Administrador`;
CREATE TABLE `TCC_Administrador` (
  `NomeADM` varchar(45) DEFAULT NULL,
  `DataNascADM` varchar(45) DEFAULT NULL,
  `EmailADM` varchar(45) DEFAULT NULL,
  `SenhaADM` varchar(255) DEFAULT NULL,
  `CelularADM` varchar(45) DEFAULT NULL,
  `CPFADM` varchar(45) DEFAULT NULL,
  `FotoPerfilADM` longblob,
  `BusBucksADM` varchar(45) DEFAULT NULL,
  `CidadeADM` varchar(45) DEFAULT NULL,
  `EstadoADM` varchar(45) DEFAULT NULL,
  `EnderecoADM` varchar(45) DEFAULT NULL,
  `CEPADM` varchar(45) DEFAULT NULL,
  `NomeUsuarioADM` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Table structure for table `TCC_Analytics`
--

DROP TABLE IF EXISTS `TCC_Analytics`;
CREATE TABLE `TCC_Analytics` (
  `Earings` double DEFAULT NULL,
  `Downloads` int(11) DEFAULT NULL,
  `Costumers` int(11) DEFAULT NULL,
  `Managers` int(11) DEFAULT NULL,
  `Drivers` int(11) DEFAULT NULL,
  `Bosses` int(11) DEFAULT NULL,
  `MonthlyGoal` int(11) DEFAULT NULL,
  `Company` varchar(45) NOT NULL,
  PRIMARY KEY (`Company`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Table structure for table `TCC_Cliente`
--

DROP TABLE IF EXISTS `TCC_Cliente`;
CREATE TABLE `TCC_Cliente` (
  `Codigo` int(11) NOT NULL AUTO_INCREMENT,
  `Nome` varchar(45) DEFAULT NULL,
  `Senha` varchar(45) DEFAULT NULL,
  `Email` varchar(45) DEFAULT NULL,
  `Busbucks` double DEFAULT NULL,
  `Plano` int(11) DEFAULT NULL,
  PRIMARY KEY (`Codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Table structure for table `TCC_Grafico`
--

DROP TABLE IF EXISTS `TCC_Grafico`;
CREATE TABLE `TCC_Grafico` (
  `Earning1` double DEFAULT NULL,
  `Earning2` double DEFAULT NULL,
  `Earning3` double DEFAULT NULL,
  `Earning4` double DEFAULT NULL,
  `Earning5` double DEFAULT NULL,
  `Earning6` double DEFAULT NULL,
  `Earning7` double DEFAULT NULL,
  `Earning8` double DEFAULT NULL,
  `Earning9` double DEFAULT NULL,
  `Earning10` double DEFAULT NULL,
  `Earning11` double DEFAULT NULL,
  `Earning12` double DEFAULT NULL,
  `Earning13` double DEFAULT NULL,
  `Earning14` double DEFAULT NULL,
  `Earning15` double DEFAULT NULL,
  `Earning16` double DEFAULT NULL,
  `Earning17` double DEFAULT NULL,
  `Earning18` double DEFAULT NULL,
  `Earning19` double DEFAULT NULL,
  `Earning20` double DEFAULT NULL,
  `Earning21` double DEFAULT NULL,
  `Earning22` double DEFAULT NULL,
  `Earning23` double DEFAULT NULL,
  `Earning24` double DEFAULT NULL,
  `Earning25` double DEFAULT NULL,
  `Earning26` double DEFAULT NULL,
  `Earning27` double DEFAULT NULL,
  `Earning28` double DEFAULT NULL,
  `Earning29` double DEFAULT NULL,
  `Earning30` double DEFAULT NULL,
  `Earning31` double DEFAULT NULL,
  `Company` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`Company`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Table structure for table `TCC_Linha`
--

DROP TABLE IF EXISTS `TCC_Linha`;
CREATE TABLE `TCC_Linha` (
  `CodigoLINHA` int(11) NOT NULL AUTO_INCREMENT,
  `NumeroLINHA` int(11) DEFAULT NULL,
  `NomeLINHA` varchar(60) DEFAULT NULL,
  `EmpresaLINHA` varchar(45) DEFAULT NULL,
  `Sentido1LINHA` varchar(45) DEFAULT NULL,
  `Sentido2LINHA` varchar(45) DEFAULT NULL,
  `TipoLINHA` varchar(45) DEFAULT NULL,
  `HrPartidaS1LINHA` varchar(45) DEFAULT NULL,
  `HrPartidaS2LINHA` varchar(45) DEFAULT NULL,
  `latitude` double DEFAULT NULL,
  `longitude` double DEFAULT NULL,
  `lotacao` int(11) DEFAULT NULL,
  `lotacaoTot` int(11) DEFAULT NULL,
  PRIMARY KEY (`CodigoLINHA`),
  UNIQUE KEY `NumeroLINHA_UNIQUE` (`NumeroLINHA`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Table structure for table `TCC_Motorista`
--

DROP TABLE IF EXISTS `TCC_Motorista`;
CREATE TABLE `TCC_Motorista` (
  `NomeMOTO` varchar(45) DEFAULT NULL,
  `DataNascMOTO` varchar(15) DEFAULT NULL,
  `CNHMOTO` varchar(15) NOT NULL,
  `EmailMOTO` varchar(45) DEFAULT NULL,
  `NumeroOnibusMOTO` int(11) DEFAULT NULL,
  `FotoPerfilMOTO` longblob,
  `CelularMOTO` varchar(45) DEFAULT NULL,
  `EstadoMOTO` varchar(45) DEFAULT NULL,
  `CidadeMOTO` varchar(45) DEFAULT NULL,
  `EnderecoMOTO` varchar(45) DEFAULT NULL,
  `CEPMOTO` varchar(45) DEFAULT NULL,
  `AvaliacaoMOTO` varchar(45) DEFAULT NULL,
  `estrelas` int(11) DEFAULT NULL,
  `motorista` longblob,
  `linha` int(11) DEFAULT NULL,
  PRIMARY KEY (`CNHMOTO`),
  KEY `FK_CodOnibus_idx` (`NumeroOnibusMOTO`),
  CONSTRAINT `FK_NumeroOnibus` FOREIGN KEY (`NumeroOnibusMOTO`) REFERENCES `TCC_Linha` (`NumeroLINHA`) ON DELETE SET NULL ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Table structure for table `TCC_Passageiro`
--

DROP TABLE IF EXISTS `TCC_Passageiro`;
CREATE TABLE `TCC_Passageiro` (
  `NomePass` varchar(15) DEFAULT NULL,
  `DataNascPass` varchar(45) DEFAULT NULL,
  `EmailPass` varchar(45) DEFAULT NULL,
  `SenhaPass` varchar(45) DEFAULT NULL,
  `OcupacaoPass` varchar(45) DEFAULT NULL,
  `CelularPass` varchar(45) DEFAULT NULL,
  `CPFPass` varchar(45) NOT NULL,
  `FotoPerfilPass` longblob,
  `BusBuscksPass` varchar(45) DEFAULT NULL,
  `CidadePass` varchar(45) DEFAULT NULL,
  `EstadoPass` varchar(45) DEFAULT NULL,
  `CEPPass` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`CPFPass`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Table structure for table `TCC_Produtos`
--

DROP TABLE IF EXISTS `TCC_Produtos`;
CREATE TABLE `TCC_Produtos` (
  `Id` int(11) NOT NULL,
  `Nome` varchar(45) DEFAULT NULL,
  `Preco` double DEFAULT NULL,
  `Custo` double DEFAULT NULL,
  `Tipo` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Table structure for table `TCC_Venda`
--

DROP TABLE IF EXISTS `TCC_Venda`;
CREATE TABLE `TCC_Venda` (
  `Id` int(11) NOT NULL,
  `Quantidade` int(11) DEFAULT NULL,
  `Data` date DEFAULT NULL,
  `Produto_ID` int(11) DEFAULT NULL,
  `Cliente_ID` int(11) DEFAULT NULL,
  `Lucro_Bruto` double DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `Cliente_Id_idx` (`Cliente_ID`),
  KEY `FK_ProdutoID_idx` (`Produto_ID`),
  CONSTRAINT `FK_ClienteID` FOREIGN KEY (`Cliente_ID`) REFERENCES `TCC_Cliente` (`Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_ProdutoID` FOREIGN KEY (`Produto_ID`) REFERENCES `TCC_Produtos` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Table structure for table `TCC_avMotorista`
--

DROP TABLE IF EXISTS `TCC_avMotorista`;
CREATE TABLE `TCC_avMotorista` (
  `codigoDaAvaliacao` int(11) NOT NULL AUTO_INCREMENT,
  `estrelas` double DEFAULT NULL,
  `avaliacao` varchar(45) DEFAULT NULL,
  `numeroLinha` int(11) DEFAULT NULL,
  PRIMARY KEY (`codigoDaAvaliacao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Table structure for table `TCC_avOnibus`
--

DROP TABLE IF EXISTS `TCC_avOnibus`;
CREATE TABLE `TCC_avOnibus` (
  `codigoDaAvaliacao` int(11) NOT NULL AUTO_INCREMENT,
  `estrelas` double DEFAULT NULL,
  `avaliacao` varchar(45) DEFAULT NULL,
  `numeroLinha` int(11) DEFAULT NULL,
  PRIMARY KEY (`codigoDaAvaliacao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Table structure for table `TCC_likes`
--

DROP TABLE IF EXISTS `TCC_likes`;
CREATE TABLE `TCC_likes` (
  `Codigo` int(11) NOT NULL AUTO_INCREMENT,
  `Data` varchar(45) NOT NULL,
  `Dislike` int(11) NOT NULL,
  `Bus` int(11) NOT NULL,
  `CdgAv` int(11) NOT NULL,
  `CdgConta` int(11) NOT NULL,
  PRIMARY KEY (`Codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

SET FOREIGN_KEY_CHECKS = 1;
