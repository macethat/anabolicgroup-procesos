/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-11.4.14-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: abgroup_catalogo
-- ------------------------------------------------------
-- Server version	11.4.14-MariaDB-ubu2404

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Dumping data for table `products`
--
-- WHERE:  id IN (32,35,36,39,66,70,92)

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (32,2,2,'Boldenona Undecilenato','boldenona-undecilenato','','','',69.99,'USD','outofstock',0,'/static/img/boldenona-undecilenato.png','BOLDENONA UNDECILENATO','',31,'2026-11-18 16:52:26','2026-11-18 17:34:29','LAN-VOL-016',14083,'https://anabolicgroup.com/wp-admin/post.php?post=14083&action=edit');
INSERT INTO `products` VALUES (35,2,2,'Primoboland Enantato Gold 10 ml','primoboland-enantato-gold-10ml','','','',99.99,'USD','instock',0,'/static/img/primoboland-enantato-gold-10ml.png','PRIMOBOLAND ENANTATO GOLD 10ml','',34,'2026-11-18 16:52:26','2026-11-18 17:34:29','LAN-VOL-019',14005,'https://anabolicgroup.com/wp-admin/post.php?post=14005&action=edit');
INSERT INTO `products` VALUES (36,2,2,'Testoland Depot 200 mg','testoland-depot-200-mg','','','',74.99,'USD','instock',0,'/static/img/testoland-depot-200-mg.webp','TESTOLAND DEPOT 200 MG','',35,'2026-11-18 16:52:26','2026-11-18 17:34:29','LAN-VOL-020',14962,'https://anabolicgroup.com/wp-admin/post.php?post=14962&action=edit');
INSERT INTO `products` VALUES (39,2,2,'Trembolona Enantado Gold','trembolona-enantado-gold','','','',74.99,'USD','instock',0,'/static/img/trembolona-enantado-gold.png','TREMBOLONA ENANTADO GOLD','',38,'2026-11-18 16:52:26','2026-11-18 17:34:29','LAN-VOL-023',14077,'https://anabolicgroup.com/wp-admin/post.php?post=14077&action=edit');
INSERT INTO `products` VALUES (66,3,2,'Boldaplex 200 mg','boldaplex-200-mg','','','',75.99,'USD','outofstock',0,'/static/img/boldaplex-200-mg.webp','BOLDAPLEX 200 MG','',65,'2026-11-18 16:52:27','2026-11-18 17:34:29','XTL-VOL-027',14600,'https://anabolicgroup.com/wp-admin/post.php?post=14600&action=edit');
INSERT INTO `products` VALUES (70,3,2,'Masteplex - P','masteplex-p','','','',64.99,'USD','instock',0,'/static/img/masteplex-p.png','MASTEPLEX - P','',69,'2026-11-18 16:52:27','2026-11-18 17:34:29','XTL-DEF-031',14244,'https://anabolicgroup.com/wp-admin/post.php?post=14244&action=edit');
INSERT INTO `products` VALUES (92,3,2,'Trembolona Acetato 100 mg','trembolona-acetato-100-mg','Trembolona Acetato 100 mg: m├║sculo rocoso, quema grasa extrema y potencia nuclear.','<p class=\"my-2 [&amp;+p]:mt-4 [&amp;_strong:has(+br)]:inline-block [&amp;_strong:has(+br)]:pb-2\"><strong>Trembolona Acetato 100 mg/ml</strong>┬áes el esteroide anab├│lico m├ís potente (5x testosterona) en vial 10ml, derivado nandrolona de acci├│n corta (2-3 d├¡as), perfecto para ciclos de corte extremo y recomposici├│n, promoviendo lip├│lisis directa, dureza muscular gran├¡tica, vascularidad 3D y fuerza sobrehumana (+50-70% compuestos) sin retenci├│n h├¡drica ni aromatizaci├│n.</p>\r\n<p class=\"my-2 [&amp;+p]:mt-4 [&amp;_strong:has(+br)]:inline-block [&amp;_strong:has(+br)]:pb-2\"><strong>Beneficios clave</strong>: M├║sculo ultra-compacto (p├®rdidas m├¡nimas PCT), quema grasa visceral sin dieta dr├ística, pumps vasculares intensos, recuperaci├│n horas, IGF-1 elevado y metabolismo proteico elite. Dosis avanzados: 300-500 mg/semana IM EOD (0.5-1 ml), ciclos 6-8 semanas m├íximo. Stacks: + Test/Primo (base segura), + Winstrol/Masteron (corte pro), nunca solo. No mujeres/novatos.</p>','',74.99,'USD','outofstock',0,'/static/img/trembolona-acetato-100-mg.webp','Trembolona Acetato 100 mg: Fuerza Brutal + Definici├│n','Trembolona Acetato 100 mg: m├║sculo rocoso, quema grasa extrema y potencia nuclear.',91,'2026-11-18 16:52:27','2026-11-18 17:34:29','XTL-DEF-039',14364,'https://anabolicgroup.com/product/trembolona-acetato-100mg/');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2026-11-18 14:12:49
