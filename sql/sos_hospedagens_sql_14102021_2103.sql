-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           10.4.14-MariaDB - mariadb.org binary distribution
-- OS do Servidor:               Win64
-- HeidiSQL Versão:              11.3.0.6337
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Copiando estrutura do banco de dados para db_cliente_soshospedagens
DROP DATABASE IF EXISTS `db_cliente_soshospedagens`;
CREATE DATABASE IF NOT EXISTS `db_cliente_soshospedagens` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `db_cliente_soshospedagens`;

-- Copiando estrutura para tabela db_cliente_soshospedagens.configuracoes
DROP TABLE IF EXISTS `configuracoes`;
CREATE TABLE IF NOT EXISTS `configuracoes` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `titulo_site` text DEFAULT NULL,
  `meta_autores` text DEFAULT NULL,
  `meta_descricao` text DEFAULT NULL,
  `meta_palavraschaves` text DEFAULT NULL,
  `meta_charset` text DEFAULT NULL,
  `meta_nome` text DEFAULT NULL,
  `meta_idioma` text DEFAULT NULL,
  `meta_criador` text DEFAULT NULL,
  `meta_layout` text DEFAULT NULL,
  `juno_clientId` text DEFAULT NULL,
  `juno_clientSecret` text DEFAULT NULL,
  `juno_resourceToken` text DEFAULT NULL,
  `link_uri_picpay` text DEFAULT NULL,
  `data_cadastro` date NOT NULL,
  `horario_cadastro` time NOT NULL,
  `data_atualizacao` date DEFAULT NULL,
  `horario_atualizacao` time DEFAULT NULL,
  `cod_situacao` int(11) NOT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela db_cliente_soshospedagens.configuracoes: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `configuracoes` DISABLE KEYS */;
/*!40000 ALTER TABLE `configuracoes` ENABLE KEYS */;

-- Copiando estrutura para tabela db_cliente_soshospedagens.contato
DROP TABLE IF EXISTS `contato`;
CREATE TABLE IF NOT EXISTS `contato` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `cod_leading` int(11) NOT NULL,
  `nome` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `telefone` varchar(30) NOT NULL,
  `assunto` varchar(255) NOT NULL,
  `mensagem` text NOT NULL,
  `data_cadastro` date NOT NULL,
  `horario_cadastro` time NOT NULL,
  `data_atualizacao` date DEFAULT NULL,
  `horario_atualizacao` time DEFAULT NULL,
  `cod_situacao` int(11) NOT NULL,
  PRIMARY KEY (`codigo`),
  KEY `fk_c_leading` (`cod_leading`),
  CONSTRAINT `fk_c_leading` FOREIGN KEY (`cod_leading`) REFERENCES `leadings` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela db_cliente_soshospedagens.contato: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `contato` DISABLE KEYS */;
/*!40000 ALTER TABLE `contato` ENABLE KEYS */;

-- Copiando estrutura para tabela db_cliente_soshospedagens.juno_autenticacao
DROP TABLE IF EXISTS `juno_autenticacao`;
CREATE TABLE IF NOT EXISTS `juno_autenticacao` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `access_token` text NOT NULL,
  `token_type` text NOT NULL,
  `expires_in` int(11) NOT NULL,
  `scope` text NOT NULL,
  `user_name` text NOT NULL,
  `jti` text NOT NULL,
  `data_expiracao` date NOT NULL,
  `horario_expiracao` time NOT NULL,
  `data_atualizacao` date DEFAULT NULL,
  `horario_atualizacao` time DEFAULT NULL,
  `data_cadastro` date NOT NULL,
  `horario_cadastro` time NOT NULL,
  `cod_situacao` int(11) NOT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela db_cliente_soshospedagens.juno_autenticacao: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `juno_autenticacao` DISABLE KEYS */;
/*!40000 ALTER TABLE `juno_autenticacao` ENABLE KEYS */;

-- Copiando estrutura para tabela db_cliente_soshospedagens.leadings
DROP TABLE IF EXISTS `leadings`;
CREATE TABLE IF NOT EXISTS `leadings` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `cpf_cnpj` varchar(30) DEFAULT NULL,
  `nome` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `telefone` varchar(30) DEFAULT NULL,
  `cep` varchar(15) DEFAULT NULL,
  `bairro` varchar(255) DEFAULT NULL,
  `cidade` varchar(255) DEFAULT NULL,
  `uf` varchar(2) DEFAULT NULL,
  `logradouro` varchar(255) DEFAULT NULL,
  `numero` varchar(10) DEFAULT NULL,
  `ip` varchar(20) NOT NULL,
  `navegou_site` int(11) DEFAULT NULL,
  `navegou_contato` int(11) DEFAULT NULL,
  `navegou_hospedagem` int(11) DEFAULT NULL,
  `data_cadastro` date NOT NULL,
  `horario_cadastro` time NOT NULL,
  `data_atualizacao` date DEFAULT NULL,
  `horario_atualizacao` time DEFAULT NULL,
  `cod_situacao` int(11) NOT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela db_cliente_soshospedagens.leadings: ~17 rows (aproximadamente)
/*!40000 ALTER TABLE `leadings` DISABLE KEYS */;
/*!40000 ALTER TABLE `leadings` ENABLE KEYS */;

-- Copiando estrutura para tabela db_cliente_soshospedagens.ordens_servico
DROP TABLE IF EXISTS `ordens_servico`;
CREATE TABLE IF NOT EXISTS `ordens_servico` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `cod_leading` int(11) NOT NULL,
  `cod_servico` int(11) NOT NULL,
  `forma_pagamento` varchar(150) NOT NULL,
  `valor_total` float(10,2) NOT NULL,
  `vencimento` datetime NOT NULL,
  `status` varchar(150) NOT NULL,
  `link_pagamento` text DEFAULT NULL,
  `data_cadastro` date NOT NULL,
  `horario_cadastro` time NOT NULL,
  `data_atualizacao` date DEFAULT NULL,
  `horario_atualizacao` time DEFAULT NULL,
  `cod_situacao` int(11) NOT NULL,
  PRIMARY KEY (`codigo`),
  KEY `fk_os_leading` (`cod_leading`),
  KEY `fk_os_servico` (`cod_servico`),
  CONSTRAINT `fk_os_leading` FOREIGN KEY (`cod_leading`) REFERENCES `leadings` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_os_servico` FOREIGN KEY (`cod_servico`) REFERENCES `ordens_servico` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela db_cliente_soshospedagens.ordens_servico: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `ordens_servico` DISABLE KEYS */;
/*!40000 ALTER TABLE `ordens_servico` ENABLE KEYS */;

-- Copiando estrutura para tabela db_cliente_soshospedagens.servicos
DROP TABLE IF EXISTS `servicos`;
CREATE TABLE IF NOT EXISTS `servicos` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `descricao` text NOT NULL,
  `valor` float(10,2) NOT NULL,
  `data_cadastro` date NOT NULL,
  `horario_cadastro` time NOT NULL,
  `data_atualizacao` date DEFAULT NULL,
  `horario_atualizacao` time DEFAULT NULL,
  `cod_situacao` int(11) NOT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela db_cliente_soshospedagens.servicos: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `servicos` DISABLE KEYS */;
/*!40000 ALTER TABLE `servicos` ENABLE KEYS */;

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
