-- MySQL dump 10.13  Distrib 5.7.36, for Linux (x86_64)
--
-- Host: localhost    Database: universidade
-- ------------------------------------------------------
-- Server version	5.7.36

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `aluno`
--

DROP TABLE IF EXISTS `aluno`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aluno` (
  `cpf` char(14) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `telefone` varchar(13) NOT NULL,
  `address` varchar(50) NOT NULL,
  `ativo` char(1) NOT NULL,
  PRIMARY KEY (`cpf`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aluno`
--

LOCK TABLES `aluno` WRITE;
/*!40000 ALTER TABLE `aluno` DISABLE KEYS */;
INSERT INTO `aluno` VALUES ('000.000.000-00','Giovanna Perez','00 00000-0000','rua abc n123','s'),('010.100.101-01','Pedro Henrique','21 98124-2312','Rua roberto carlos n90','s'),('010.100.202-12','José Carlos Perez','21 99356-4518','Rua general mitre n250','s'),('070.597.765-40','Raíssa Moreira','21 98597-4578','Rua do não aguento mais n001','s'),('111.111.111-11','Andrea Motta','11 11111-1111','rua def n456','s'),('179.234.987-07','Giovanna Schaffer','21 994393037','Av Deodoro Vaz n678','s'),('234.432.097-00','Joaquim Borges','24 98293-1290','Rua castelo branco n345','s'),('245.765.345-20','Mariana Cruz','21 99789-5423','Rua brigadeiro silva n097','s'),('456.124.345-13','Bernardo Guara','21 99467-1213','Rua do imperador n888','s'),('456.124.785-09','Bianca Guaraná','24 98976-0910','Rua do imperador n987','s'),('556.789.123-23','Maique Pereira','21 99349-1254','Av. roberto carlos n900','s'),('667.899.012-11','Margot Perez','21 99878-9800','Rua 15 n200','s');
/*!40000 ALTER TABLE `aluno` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `curso`
--

DROP TABLE IF EXISTS `curso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `curso` (
  `cod_curso` int(4) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `ano_inicio` int(4) NOT NULL,
  PRIMARY KEY (`cod_curso`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `curso`
--

LOCK TABLES `curso` WRITE;
/*!40000 ALTER TABLE `curso` DISABLE KEYS */;
INSERT INTO `curso` VALUES (1,'Engenharia de computação',2013),(2,'Física',2013),(3,'Matemática',2021),(4,'História',2014),(5,'Turismo',2021);
/*!40000 ALTER TABLE `curso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `disciplina`
--

DROP TABLE IF EXISTS `disciplina`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `disciplina` (
  `cod_disc` int(4) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `cpf_prof` char(14) NOT NULL,
  `cod_curso` int(4) NOT NULL,
  PRIMARY KEY (`cod_disc`),
  KEY `cpf_prof` (`cpf_prof`),
  KEY `cod_curso` (`cod_curso`),
  CONSTRAINT `disciplina_ibfk_1` FOREIGN KEY (`cpf_prof`) REFERENCES `professor` (`cpf`),
  CONSTRAINT `disciplina_ibfk_2` FOREIGN KEY (`cod_curso`) REFERENCES `curso` (`cod_curso`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `disciplina`
--

LOCK TABLES `disciplina` WRITE;
/*!40000 ALTER TABLE `disciplina` DISABLE KEYS */;
INSERT INTO `disciplina` VALUES (8,'Cálculo II','622.920.777-23',1),(9,'ICC','567.987.123-00',1),(10,'Astronomia','567.987.123-00',2),(11,'História geral','256.823.111-11',4),(12,'Mecânica Clássica','256.823.111-11',2),(13,'Álgebra I','167.876.234-66',3),(14,'Banco de dados','019.629.443-54',1);
/*!40000 ALTER TABLE `disciplina` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `funcionario`
--

DROP TABLE IF EXISTS `funcionario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `funcionario` (
  `cpf` char(14) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `address` varchar(50) NOT NULL,
  `salario` double(7,2) DEFAULT NULL,
  `cod_setor` int(4) NOT NULL,
  PRIMARY KEY (`cpf`),
  KEY `cod_setor` (`cod_setor`),
  CONSTRAINT `funcionario_ibfk_1` FOREIGN KEY (`cod_setor`) REFERENCES `setor` (`cod_setor`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `funcionario`
--

LOCK TABLES `funcionario` WRITE;
/*!40000 ALTER TABLE `funcionario` DISABLE KEYS */;
INSERT INTO `funcionario` VALUES ('333.179.667-29','Juliana Rosa','Rua estrada campos n667',0.00,11),('344.444.613-90','Washington Antunes','rua joão da silva n45',5000.00,9),('344.666.777-88','Roberto Silva','rua das flores n1000',5000.00,2),('784.658.124-89','José Bezerra','Rua Campos Filho n10',8000.00,4),('784.965.258-89','Eduarda Sodré','Rua Paulo Sá n400',8000.00,4),('987.654.321-00','Carlos Eduardo Souza','rua do imperador 111',100.00,4);
/*!40000 ALTER TABLE `funcionario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inscricao`
--

DROP TABLE IF EXISTS `inscricao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inscricao` (
  `cpf_aluno` varchar(14) NOT NULL,
  `cod_disc` int(4) NOT NULL,
  `cod_curso` int(4) NOT NULL,
  `cod_turma` int(4) NOT NULL,
  PRIMARY KEY (`cpf_aluno`,`cod_disc`),
  KEY `cod_disc` (`cod_disc`),
  KEY `cod_curso` (`cod_curso`),
  KEY `cod_turma` (`cod_turma`),
  CONSTRAINT `inscricao_ibfk_1` FOREIGN KEY (`cpf_aluno`) REFERENCES `aluno` (`cpf`),
  CONSTRAINT `inscricao_ibfk_2` FOREIGN KEY (`cod_disc`) REFERENCES `disciplina` (`cod_disc`),
  CONSTRAINT `inscricao_ibfk_3` FOREIGN KEY (`cod_curso`) REFERENCES `curso` (`cod_curso`),
  CONSTRAINT `inscricao_ibfk_4` FOREIGN KEY (`cod_turma`) REFERENCES `turma` (`cod_turma`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inscricao`
--

LOCK TABLES `inscricao` WRITE;
/*!40000 ALTER TABLE `inscricao` DISABLE KEYS */;
INSERT INTO `inscricao` VALUES ('000.000.000-00',8,1,7),('000.000.000-00',12,4,11),('010.100.101-01',10,2,9),('010.100.101-01',12,2,11),('111.111.111-11',12,4,11),('234.432.097-00',14,1,13),('245.765.345-20',9,1,8),('456.124.345-13',11,4,10),('456.124.345-13',12,2,11);
/*!40000 ALTER TABLE `inscricao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notas`
--

DROP TABLE IF EXISTS `notas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notas` (
  `cpf_aluno` varchar(14) NOT NULL,
  `cod_disc` int(4) NOT NULL,
  `nota` double(3,1) DEFAULT NULL,
  `situacao` char(1) DEFAULT NULL,
  PRIMARY KEY (`cpf_aluno`,`cod_disc`),
  KEY `cod_disc` (`cod_disc`),
  CONSTRAINT `notas_ibfk_1` FOREIGN KEY (`cpf_aluno`) REFERENCES `aluno` (`cpf`),
  CONSTRAINT `notas_ibfk_2` FOREIGN KEY (`cod_disc`) REFERENCES `disciplina` (`cod_disc`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notas`
--

LOCK TABLES `notas` WRITE;
/*!40000 ALTER TABLE `notas` DISABLE KEYS */;
INSERT INTO `notas` VALUES ('000.000.000-00',8,7.5,'A'),('000.000.000-00',12,8.0,'A'),('010.100.101-01',10,9.0,'A'),('010.100.101-01',12,5.0,'A'),('111.111.111-11',12,10.0,'A'),('234.432.097-00',14,7.0,'A'),('245.765.345-20',9,4.5,'R'),('456.124.345-13',11,9.7,'R'),('456.124.345-13',12,3.0,'R');
/*!40000 ALTER TABLE `notas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `professor`
--

DROP TABLE IF EXISTS `professor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `professor` (
  `cpf` char(14) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `telefone` varchar(13) NOT NULL,
  `address` varchar(50) NOT NULL,
  `data_contratacao` date NOT NULL,
  `salario` double(7,2) DEFAULT NULL,
  `ativo` char(1) NOT NULL,
  `cod_curso` int(4) NOT NULL,
  PRIMARY KEY (`cpf`),
  KEY `cod_curso` (`cod_curso`),
  CONSTRAINT `professor_ibfk_1` FOREIGN KEY (`cod_curso`) REFERENCES `curso` (`cod_curso`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `professor`
--

LOCK TABLES `professor` WRITE;
/*!40000 ALTER TABLE `professor` DISABLE KEYS */;
INSERT INTO `professor` VALUES ('019.629.443-54','Abreu Tenório','21 99123-9023','rua da passagem n99','2011-04-27',15000.00,'s',5),('167.876.234-66','Aizawa Santos','21 99766-5643','Rua do lacre n40','1999-02-20',30000.00,'s',2),('256.823.111-11','Roberto Justus','21 99766-0056','Rua professor fulano n55','1998-01-30',27000.00,'s',3),('567.987.123-00','Fulano Santos','21 99999-9999','rua aaaaaaaaaaaaaaaa 123','2016-04-23',5000.00,'s',2),('622.920.777-23','José Santos','21 33333-3333','rua hsgshghs 23','2014-04-24',9000.00,'s',1),('765.190.399-99','Alvo Dumbledore','21 96787-2356','Rua hogwarts n500','1999-02-20',30000.00,'n',4);
/*!40000 ALTER TABLE `professor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `setor`
--

DROP TABLE IF EXISTS `setor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `setor` (
  `cod_setor` int(4) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  PRIMARY KEY (`cod_setor`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `setor`
--

LOCK TABLES `setor` WRITE;
/*!40000 ALTER TABLE `setor` DISABLE KEYS */;
INSERT INTO `setor` VALUES (2,'Centro Academico'),(4,'Secretaria'),(9,'Recursos humanos'),(10,'TI'),(11,'Atlética');
/*!40000 ALTER TABLE `setor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `turma`
--

DROP TABLE IF EXISTS `turma`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `turma` (
  `cod_turma` int(4) NOT NULL AUTO_INCREMENT,
  `cod_disc` int(4) NOT NULL,
  PRIMARY KEY (`cod_turma`),
  KEY `cod_disc` (`cod_disc`),
  CONSTRAINT `turma_ibfk_1` FOREIGN KEY (`cod_disc`) REFERENCES `disciplina` (`cod_disc`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `turma`
--

LOCK TABLES `turma` WRITE;
/*!40000 ALTER TABLE `turma` DISABLE KEYS */;
INSERT INTO `turma` VALUES (7,8),(8,9),(9,10),(10,11),(11,12),(12,13),(13,14);
/*!40000 ALTER TABLE `turma` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-10-26 19:07:05
