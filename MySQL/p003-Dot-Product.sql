--
-- Doing dot product with a layer of neurons and multiple inputs
--
-- Associated YT NNFS tutorial: https://www.youtube.com/watch?v=tMrbN67U9d4
--

DROP DATABASE IF EXISTS `p003_dot_product`;
CREATE DATABASE `p003_dot_product`;

USE `p003_dot_product`;

CREATE TABLE `inputs`
(
    `0` DOUBLE NOT NULL,
    `1` DOUBLE NOT NULL,
    `2` DOUBLE NOT NULL,
    `3` DOUBLE NOT NULL
);

CREATE TABLE `weights`
(
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `0`  DOUBLE  NOT NULL,
    `1`  DOUBLE  NOT NULL,
    `2`  DOUBLE  NOT NULL,
    `3`  DOUBLE  NOT NULL,
    PRIMARY KEY (`id`) USING BTREE
);

CREATE TABLE `biases`
(
    `weight_id` INT(11) NOT NULL DEFAULT '0',
    `bias`      DOUBLE  NOT NULL
);

INSERT INTO `inputs` (`0`, `1`, `2`, `3`)
VALUES (1, 2, 3, 2.5);

INSERT INTO `weights` (`id`, `0`, `1`, `2`, `3`)
VALUES (1, 0.2, 0.8, -0.5, 1),
       (2, 0.5, -0.91, 0.26, -0.5),
       (3, -0.26, -0.27, 0.17, 0.87);

INSERT INTO `biases` (`weight_id`, `bias`)
VALUES (1, 2),
       (2, 3),
       (3, 0.5);

DELIMITER $$
CREATE FUNCTION `dot`(
    `vector1` JSON,
    `vector2` JSON
) RETURNS DOUBLE
    NO SQL
    DETERMINISTIC
    COMMENT 'The dot product of two vectors in json format'
BEGIN

    DECLARE i INT DEFAULT 0;
    DECLARE vector_length INT;
    DECLARE output DOUBLE DEFAULT 0;

    SET vector_length = JSON_LENGTH(vector1);

    WHILE i < vector_length
        DO
            SET output = output + JSON_EXTRACT(vector1, CONCAT("$[", i, "]")) * JSON_EXTRACT(vector2, CONCAT("$[", i, "]"));
            SET i = i + 1;
        END WHILE;

    RETURN output;

END $$
DELIMITER ;

SELECT (dot(JSON_ARRAY(i.`0`, i.`1`, i.`2`, i.`3`),JSON_ARRAY(w.`0`, w.`1`, w.`2`, w.`3`)) + b.bias) AS output
FROM inputs i, weights w, biases b
WHERE b.weight_id = w.id;
