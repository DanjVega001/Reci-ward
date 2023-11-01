-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: reciward
-- ------------------------------------------------------
-- Server version	8.0.32

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `administrador`
--

DROP TABLE IF EXISTS `administrador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `administrador` (
  `idAdministrador` int NOT NULL AUTO_INCREMENT,
  `nombreAdmin` varchar(45) NOT NULL,
  `correoAdmin` varchar(45) NOT NULL,
  `claveAccesoAdmin` int NOT NULL,
  PRIMARY KEY (`idAdministrador`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `administrador`
--

LOCK TABLES `administrador` WRITE;
/*!40000 ALTER TABLE `administrador` DISABLE KEYS */;
INSERT INTO `administrador` VALUES (1,'Cesar Hernandez','cecar@12345@gmail.com',1),(2,'Anderson Gomez','anderson1234@gmail.com',2),(3,'Daniel Vega','daniel12345@gmail.com',3),(4,'Oscar Reatiga','oscar12345@gmail.com',4),(5,'Cesar Hernandez','cecar@12345@gmail.com',1),(6,'Anderson Gomez','anderson1234@gmail.com',2),(7,'Daniel Vega','daniel12345@gmail.com',3),(8,'Oscar Reatiga','oscar12345@gmail.com',4),(9,'Cesar Hernandez','cecar@12345@gmail.com',1),(10,'Anderson Gomez','anderson1234@gmail.com',2),(11,'Daniel Vega','daniel12345@gmail.com',3),(12,'Oscar Reatiga','oscar12345@gmail.com',4),(13,'Cesar Hernandez','cecar@12345@gmail.com',1),(14,'Anderson Gomez','anderson1234@gmail.com',2),(15,'Daniel Vega','daniel12345@gmail.com',3),(16,'Oscar Reatiga','oscar12345@gmail.com',4);
/*!40000 ALTER TABLE `administrador` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aprendices`
--

DROP TABLE IF EXISTS `aprendices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aprendices` (
  `idAprendiz` int NOT NULL AUTO_INCREMENT,
  `tipoDocumento` varchar(45) NOT NULL,
  `numeroDocumento` int NOT NULL,
  `contraseña` varchar(45) NOT NULL,
  `correo` varchar(45) NOT NULL,
  `Fichas_codigo` int NOT NULL,
  PRIMARY KEY (`idAprendiz`),
  UNIQUE KEY `numeroDocumento_UNIQUE` (`numeroDocumento`),
  KEY `fk_Aprendices_Fichas1_idx` (`Fichas_codigo`),
  CONSTRAINT `fk_Aprendices_Fichas1` FOREIGN KEY (`Fichas_codigo`) REFERENCES `fichas` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aprendices`
--

LOCK TABLES `aprendices` WRITE;
/*!40000 ALTER TABLE `aprendices` DISABLE KEYS */;
INSERT INTO `aprendices` VALUES (10,'CC',123456,'01','correoprueba@gmail.com',1),(11,'TI',56789,'ggug','correoprueba2@gmial.com',2),(12,'CC',84738,'gfyfyfyf','correopueba3@gmail.com',1);
/*!40000 ALTER TABLE `aprendices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aprendices_has_bonos`
--

DROP TABLE IF EXISTS `aprendices_has_bonos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aprendices_has_bonos` (
  `idAprendizBono` int NOT NULL AUTO_INCREMENT,
  `codigoValidante` int NOT NULL,
  `estadoBono` tinyint NOT NULL,
  `fechaCreacion` datetime NOT NULL,
  `fechaVencimiento` datetime NOT NULL,
  `Bonos_idBono` int NOT NULL,
  `Aprendices_idAprendiz` int NOT NULL,
  PRIMARY KEY (`idAprendizBono`),
  KEY `fk_Usuario_has_Bonos_Usuario1` (`Aprendices_idAprendiz`),
  KEY `fk_Usuario_has_Bonos_Bonos1` (`Bonos_idBono`),
  CONSTRAINT `fk_Usuario_has_Bonos_Bonos1` FOREIGN KEY (`Bonos_idBono`) REFERENCES `bonos` (`idBono`),
  CONSTRAINT `fk_Usuario_has_Bonos_Usuario1` FOREIGN KEY (`Aprendices_idAprendiz`) REFERENCES `aprendices` (`idAprendiz`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aprendices_has_bonos`
--

LOCK TABLES `aprendices_has_bonos` WRITE;
/*!40000 ALTER TABLE `aprendices_has_bonos` DISABLE KEYS */;
/*!40000 ALTER TABLE `aprendices_has_bonos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bonos`
--

DROP TABLE IF EXISTS `bonos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bonos` (
  `idBono` int NOT NULL,
  `valorBono` int NOT NULL,
  `puntosRequeridos` int NOT NULL,
  PRIMARY KEY (`idBono`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bonos`
--

LOCK TABLES `bonos` WRITE;
/*!40000 ALTER TABLE `bonos` DISABLE KEYS */;
INSERT INTO `bonos` VALUES (1,2000,1000),(2,3000,2000),(3,4000,3000);
/*!40000 ALTER TABLE `bonos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cafeteria`
--

DROP TABLE IF EXISTS `cafeteria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cafeteria` (
  `idCafeteria` int NOT NULL,
  `claveAcceso` int NOT NULL,
  `correoCafeteria` varchar(45) NOT NULL,
  `contraseñaCafeteria` varchar(45) NOT NULL,
  PRIMARY KEY (`idCafeteria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cafeteria`
--

LOCK TABLES `cafeteria` WRITE;
/*!40000 ALTER TABLE `cafeteria` DISABLE KEYS */;
INSERT INTO `cafeteria` VALUES (1,1,'cafeteria@gamiel.com','4545'),(2,2,'cafeteria2@gamiel.com','1213');
/*!40000 ALTER TABLE `cafeteria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clasificacion`
--

DROP TABLE IF EXISTS `clasificacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clasificacion` (
  `idclasificacion` int NOT NULL AUTO_INCREMENT,
  `nombreClasifiacion` varchar(45) NOT NULL,
  PRIMARY KEY (`idclasificacion`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clasificacion`
--

LOCK TABLES `clasificacion` WRITE;
/*!40000 ALTER TABLE `clasificacion` DISABLE KEYS */;
INSERT INTO `clasificacion` VALUES (1,'carton'),(3,'plastico'),(4,'vidrio');
/*!40000 ALTER TABLE `clasificacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entrega`
--

DROP TABLE IF EXISTS `entrega`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `entrega` (
  `idEntrega` int NOT NULL AUTO_INCREMENT,
  `cantidadMaterial` int NOT NULL,
  `canjeada` tinyint NOT NULL,
  `puntosAcumulados` int NOT NULL,
  `Cafeteria_idCafeteria` int NOT NULL,
  `Aprendices_idAprendiz` int NOT NULL,
  PRIMARY KEY (`idEntrega`),
  KEY `fk_Entrega_Cafeteria1_idx` (`Cafeteria_idCafeteria`),
  KEY `fk_Entrega_Aprendices1_idx` (`Aprendices_idAprendiz`),
  CONSTRAINT `fk_Entrega_Aprendices1` FOREIGN KEY (`Aprendices_idAprendiz`) REFERENCES `aprendices` (`idAprendiz`),
  CONSTRAINT `fk_Entrega_Cafeteria1` FOREIGN KEY (`Cafeteria_idCafeteria`) REFERENCES `cafeteria` (`idCafeteria`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entrega`
--

LOCK TABLES `entrega` WRITE;
/*!40000 ALTER TABLE `entrega` DISABLE KEYS */;
INSERT INTO `entrega` VALUES (1,5,0,500,1,10),(6,10,0,1000,2,11);
/*!40000 ALTER TABLE `entrega` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fichas`
--

DROP TABLE IF EXISTS `fichas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fichas` (
  `codigo` int NOT NULL,
  `nombreFicha` varchar(45) NOT NULL,
  `fechaCreacion` date NOT NULL,
  `fechaFin` date NOT NULL,
  `Administrador_idAdministrador` int NOT NULL,
  PRIMARY KEY (`codigo`),
  KEY `fk_Fichas_Administrador1_idx` (`Administrador_idAdministrador`),
  CONSTRAINT `fk_Fichas_Administrador1` FOREIGN KEY (`Administrador_idAdministrador`) REFERENCES `administrador` (`idAdministrador`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fichas`
--

LOCK TABLES `fichas` WRITE;
/*!40000 ALTER TABLE `fichas` DISABLE KEYS */;
INSERT INTO `fichas` VALUES (1,'ADSO','2023-08-23','2024-01-01',1),(2,'ARTES','2024-08-23','2025-01-01',2);
/*!40000 ALTER TABLE `fichas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `material`
--

DROP TABLE IF EXISTS `material`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `material` (
  `idMaterial` int NOT NULL AUTO_INCREMENT,
  `nombreMaterial` varchar(45) NOT NULL,
  `numeroPuntos` int NOT NULL,
  `clasificacion_idclasificacion` int NOT NULL,
  PRIMARY KEY (`idMaterial`),
  KEY `fk_Material_clasificacion1_idx` (`clasificacion_idclasificacion`),
  CONSTRAINT `fk_Material_clasificacion1` FOREIGN KEY (`clasificacion_idclasificacion`) REFERENCES `clasificacion` (`idclasificacion`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `material`
--

LOCK TABLES `material` WRITE;
/*!40000 ALTER TABLE `material` DISABLE KEYS */;
INSERT INTO `material` VALUES (1,'botella 750ml',100,3);
/*!40000 ALTER TABLE `material` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `material_has_entrega`
--

DROP TABLE IF EXISTS `material_has_entrega`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `material_has_entrega` (
  `Material_idMaterial` int NOT NULL,
  `Entrega_idEntrega` int NOT NULL,
  PRIMARY KEY (`Material_idMaterial`,`Entrega_idEntrega`),
  KEY `fk_Material_has_Entrega_Entrega1` (`Entrega_idEntrega`),
  CONSTRAINT `fk_Material_has_Entrega_Entrega1` FOREIGN KEY (`Entrega_idEntrega`) REFERENCES `entrega` (`idEntrega`),
  CONSTRAINT `fk_Material_has_Entrega_Material1` FOREIGN KEY (`Material_idMaterial`) REFERENCES `material` (`idMaterial`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `material_has_entrega`
--

LOCK TABLES `material_has_entrega` WRITE;
/*!40000 ALTER TABLE `material_has_entrega` DISABLE KEYS */;
INSERT INTO `material_has_entrega` VALUES (1,6);
/*!40000 ALTER TABLE `material_has_entrega` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `perfil`
--

DROP TABLE IF EXISTS `perfil`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `perfil` (
  `idPerfil` varchar(45) NOT NULL,
  `apellido` varchar(30) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `descripcionPerfil` varchar(45) DEFAULT NULL,
  `avatar` varchar(45) DEFAULT NULL,
  `Aprendices_idAprendiz` int NOT NULL,
  PRIMARY KEY (`idPerfil`),
  KEY `fk_Perfil_Aprendices1_idx` (`Aprendices_idAprendiz`),
  CONSTRAINT `fk_Perfil_Aprendices1` FOREIGN KEY (`Aprendices_idAprendiz`) REFERENCES `aprendices` (`idAprendiz`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `perfil`
--

LOCK TABLES `perfil` WRITE;
/*!40000 ALTER TABLE `perfil` DISABLE KEYS */;
INSERT INTO `perfil` VALUES ('1','espi','leo','iiiiiiii','oio',10),('2','frogo','ton','ppppp','ioioi',11);
/*!40000 ALTER TABLE `perfil` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `puntos`
--

DROP TABLE IF EXISTS `puntos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `puntos` (
  `idPuntos` int NOT NULL AUTO_INCREMENT,
  `cantidadAcumulada` int NOT NULL,
  `puntosUtilizados` int NOT NULL,
  `Aprendices_idAprendiz` int NOT NULL,
  PRIMARY KEY (`idPuntos`),
  KEY `fk_Puntos_Aprendices1_idx` (`Aprendices_idAprendiz`),
  CONSTRAINT `fk_Puntos_Aprendices1` FOREIGN KEY (`Aprendices_idAprendiz`) REFERENCES `aprendices` (`idAprendiz`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `puntos`
--

LOCK TABLES `puntos` WRITE;
/*!40000 ALTER TABLE `puntos` DISABLE KEYS */;
INSERT INTO `puntos` VALUES (1,4000,2000,11),(2,5000,1000,12),(6,100,55,11);
/*!40000 ALTER TABLE `puntos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tips`
--

DROP TABLE IF EXISTS `tips`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tips` (
  `idTips` int NOT NULL AUTO_INCREMENT,
  `nombreTips` varchar(45) NOT NULL,
  `descripcionTips` varchar(45) NOT NULL,
  `Administrador_idAdministrador` int NOT NULL,
  `Aprendices_idAprendiz` int NOT NULL,
  PRIMARY KEY (`idTips`),
  KEY `fk_Tips_Administrador1_idx` (`Administrador_idAdministrador`),
  KEY `fk_Tips_Aprendices1_idx` (`Aprendices_idAprendiz`),
  CONSTRAINT `fk_Tips_Administrador1` FOREIGN KEY (`Administrador_idAdministrador`) REFERENCES `administrador` (`idAdministrador`),
  CONSTRAINT `fk_Tips_Aprendices1` FOREIGN KEY (`Aprendices_idAprendiz`) REFERENCES `aprendices` (`idAprendiz`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tips`
--

LOCK TABLES `tips` WRITE;
/*!40000 ALTER TABLE `tips` DISABLE KEYS */;
/*!40000 ALTER TABLE `tips` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-11-01 10:01:20
