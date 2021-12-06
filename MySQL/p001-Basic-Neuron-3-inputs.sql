--
-- Creates a basic neuron with 3 inputs.
--
-- Associated YT NNFS tutorial: https://www.youtube.com/watch?v=Wo5dMEP_BbI
--

DROP DATABASE IF EXISTS `p001_basic_neuron_3_inputs`;
CREATE DATABASE `p001_basic_neuron_3_inputs`;

USE `p001_basic_neuron_3_inputs`;

CREATE TABLE `inputs`
(
    `i0` DOUBLE NOT NULL,
    `i1` DOUBLE NOT NULL,
    `i2` DOUBLE NOT NULL
);

CREATE TABLE `weights`
(
    `w0` DOUBLE NOT NULL,
    `w1` DOUBLE NOT NULL,
    `w2` DOUBLE NOT NULL
);

CREATE TABLE `bias`
(
    `b` DOUBLE NOT NULL
);

INSERT INTO `inputs` (`i0`, `i1`, `i2`) VALUES (1.2, 5.1, 2.1);
INSERT INTO `weights` (`w0`, `w1`, `w2`) VALUES (3.1, 2.1, 8.7);
INSERT INTO `bias` (`b`) VALUES (3.0);

SELECT (
   ( SELECT inputs.i0 FROM inputs ) * ( SELECT weights.w0 FROM weights ) +
   ( SELECT inputs.i1 FROM inputs ) * ( SELECT weights.w1 FROM weights ) +
   ( SELECT inputs.i2 FROM inputs ) * ( SELECT weights.w2 FROM weights ) +
   ( SELECT bias.b FROM bias )
) AS output;