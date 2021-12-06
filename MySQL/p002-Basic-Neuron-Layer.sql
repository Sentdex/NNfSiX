--
-- Creates a simple layer of neurons, with 4 inputs.
--
-- Associated YT NNFS tutorial: https://www.youtube.com/watch?v=lGLto9Xd7bU
--

DROP DATABASE IF EXISTS `p002_basic_neuron_layer`;
CREATE DATABASE `p002_basic_neuron_layer`;

USE `p002_basic_neuron_layer`;

CREATE TABLE `inputs` ( `i0` DOUBLE NOT NULL, `i1` DOUBLE NOT NULL, `i2` DOUBLE NOT NULL, `i3` DOUBLE NOT NULL );

CREATE TABLE `weights1` ( `w0` DOUBLE NOT NULL, `w1` DOUBLE NOT NULL, `w2` DOUBLE NOT NULL, `w3` DOUBLE NOT NULL );
CREATE TABLE `weights2` ( `w0` DOUBLE NOT NULL, `w1` DOUBLE NOT NULL, `w2` DOUBLE NOT NULL, `w3` DOUBLE NOT NULL );
CREATE TABLE `weights3` ( `w0` DOUBLE NOT NULL, `w1` DOUBLE NOT NULL, `w2` DOUBLE NOT NULL, `w3` DOUBLE NOT NULL );

CREATE TABLE `bias1` ( `b` DOUBLE NOT NULL );
CREATE TABLE `bias2` ( `b` DOUBLE NOT NULL );
CREATE TABLE `bias3` ( `b` DOUBLE NOT NULL );

INSERT INTO `inputs` (`i0`, `i1`, `i2`, `i3`) VALUES ( 1, 2, 3, 2.5 );

INSERT INTO `weights1` (`w0`, `w1`, `w2`, `w3`) VALUES ( 0.2, 0.8, -0.5, 1 );
INSERT INTO `weights2` (`w0`, `w1`, `w2`, `w3`) VALUES ( 0.5, -0.91, 0.26, -0.5 );
INSERT INTO `weights3` (`w0`, `w1`, `w2`, `w3`) VALUES ( -0.26, -0.27, 0.17, 0.87 );

INSERT INTO `bias1` (`b`) VALUES (2);
INSERT INTO `bias2` (`b`) VALUES (3);
INSERT INTO `bias3` (`b`) VALUES (0.5);

SELECT (
   ( SELECT inputs.i0 FROM inputs ) * ( SELECT weights1.w0 FROM weights1 ) +
   ( SELECT inputs.i1 FROM inputs ) * ( SELECT weights1.w1 FROM weights1 ) +
   ( SELECT inputs.i2 FROM inputs ) * ( SELECT weights1.w2 FROM weights1 ) +
   ( SELECT inputs.i3 FROM inputs ) * ( SELECT weights1.w3 FROM weights1 ) +
   ( SELECT bias1.b FROM bias1 )
) AS o1,
(
   ( SELECT inputs.i0 FROM inputs ) * ( SELECT weights2.w0 FROM weights2 ) +
   ( SELECT inputs.i1 FROM inputs ) * ( SELECT weights2.w1 FROM weights2 ) +
   ( SELECT inputs.i2 FROM inputs ) * ( SELECT weights2.w2 FROM weights2 ) +
   ( SELECT inputs.i3 FROM inputs ) * ( SELECT weights2.w3 FROM weights2 ) +
   ( SELECT bias2.b FROM bias2 )
) AS o2,
(
   ( SELECT inputs.i0 FROM inputs ) * ( SELECT weights3.w0 FROM weights3 ) +
   ( SELECT inputs.i1 FROM inputs ) * ( SELECT weights3.w1 FROM weights3 ) +
   ( SELECT inputs.i2 FROM inputs ) * ( SELECT weights3.w2 FROM weights3 ) +
   ( SELECT inputs.i3 FROM inputs ) * ( SELECT weights3.w3 FROM weights3 ) +
   ( SELECT bias3.b FROM bias3 )
) AS o3