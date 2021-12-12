--
-- Creates a simple layer of neurons, with 4 inputs.
--
-- Associated YT NNFS tutorial: https://www.youtube.com/watch?v=lGLto9Xd7bU
--

DROP DATABASE IF EXISTS `p002_basic_neuron_layer`;
CREATE DATABASE `p002_basic_neuron_layer`;

USE `p002_basic_neuron_layer`;

CREATE TABLE `inputs` ( `0` DOUBLE NOT NULL, `1` DOUBLE NOT NULL, `2` DOUBLE NOT NULL, `3` DOUBLE NOT NULL );

CREATE TABLE `weights1` ( `0` DOUBLE NOT NULL, `1` DOUBLE NOT NULL, `2` DOUBLE NOT NULL, `3` DOUBLE NOT NULL );
CREATE TABLE `weights2` ( `0` DOUBLE NOT NULL, `1` DOUBLE NOT NULL, `2` DOUBLE NOT NULL, `3` DOUBLE NOT NULL );
CREATE TABLE `weights3` ( `0` DOUBLE NOT NULL, `1` DOUBLE NOT NULL, `2` DOUBLE NOT NULL, `3` DOUBLE NOT NULL );

CREATE TABLE `bias1` ( `0` DOUBLE NOT NULL );
CREATE TABLE `bias2` ( `0` DOUBLE NOT NULL );
CREATE TABLE `bias3` ( `0` DOUBLE NOT NULL );

INSERT INTO `inputs` (`0`, `1`, `2`, `3`) VALUES ( 1, 2, 3, 2.5 );

INSERT INTO `weights1` (`0`, `1`, `2`, `3`) VALUES ( 0.2, 0.8, -0.5, 1 );
INSERT INTO `weights2` (`0`, `1`, `2`, `3`) VALUES ( 0.5, -0.91, 0.26, -0.5 );
INSERT INTO `weights3` (`0`, `1`, `2`, `3`) VALUES ( -0.26, -0.27, 0.17, 0.87 );

INSERT INTO `bias1` (`0`) VALUES (2);
INSERT INTO `bias2` (`0`) VALUES (3);
INSERT INTO `bias3` (`0`) VALUES (0.5);

SELECT (
   ( SELECT `inputs`.`0` FROM inputs ) * ( SELECT `weights1`.`0` FROM weights1 ) +
   ( SELECT `inputs`.`1` FROM inputs ) * ( SELECT `weights1`.`1` FROM weights1 ) +
   ( SELECT `inputs`.`2` FROM inputs ) * ( SELECT `weights1`.`2` FROM weights1 ) +
   ( SELECT `inputs`.`3` FROM inputs ) * ( SELECT `weights1`.`3` FROM weights1 ) +
   ( SELECT `bias1`.`0` FROM bias1 )
) AS `1`,
(
   ( SELECT `inputs`.`0` FROM inputs ) * ( SELECT `weights2`.`0` FROM weights2 ) +
   ( SELECT `inputs`.`1` FROM inputs ) * ( SELECT `weights2`.`1` FROM weights2 ) +
   ( SELECT `inputs`.`2` FROM inputs ) * ( SELECT `weights2`.`2` FROM weights2 ) +
   ( SELECT `inputs`.`3` FROM inputs ) * ( SELECT `weights2`.`3` FROM weights2 ) +
   ( SELECT `bias2`.`0` FROM bias2 )
) AS `2`,
(
   ( SELECT `inputs`.`0` FROM inputs ) * ( SELECT `weights3`.`0` FROM weights3 ) +
   ( SELECT `inputs`.`1` FROM inputs ) * ( SELECT `weights3`.`1` FROM weights3 ) +
   ( SELECT `inputs`.`2` FROM inputs ) * ( SELECT `weights3`.`2` FROM weights3 ) +
   ( SELECT `inputs`.`3` FROM inputs ) * ( SELECT `weights3`.`3` FROM weights3 ) +
   ( SELECT `bias3`.`0` FROM bias3 )
) AS `3`