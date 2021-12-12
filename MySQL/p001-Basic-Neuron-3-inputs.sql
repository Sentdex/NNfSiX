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
    `0` DOUBLE NOT NULL,
    `1` DOUBLE NOT NULL,
    `2` DOUBLE NOT NULL
);

CREATE TABLE `weights`
(
    `0` DOUBLE NOT NULL,
    `1` DOUBLE NOT NULL,
    `2` DOUBLE NOT NULL
);

CREATE TABLE `bias`
(
    `0` DOUBLE NOT NULL
);

INSERT INTO `inputs` (`0`, `1`, `2`) VALUES ( 1.2, 5.1, 2.1 );
INSERT INTO `weights` (`0`, `1`, `2`) VALUES ( 3.1, 2.1, 8.7 );
INSERT INTO `bias` (`0`) VALUES ( 3.0 );

SELECT (
                   ( SELECT `inputs`.`0` FROM inputs ) * ( SELECT `weights`.`0` FROM weights ) +
                   ( SELECT `inputs`.`1` FROM inputs ) * ( SELECT `weights`.`1` FROM weights ) +
                   ( SELECT `inputs`.`2` FROM inputs ) * ( SELECT `weights`.`2` FROM weights ) +
                   ( SELECT `bias`.`0` FROM bias )
           ) AS output;