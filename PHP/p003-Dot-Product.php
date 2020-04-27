<?php
/**
* Doing dot product with a layer of neurons and multiple inputs
* Associated YT NNFS tutorial: https://www.youtube.com/watch?v=tMrbN67U9d4
**/

function dot($a, $b){
    
    // vector, vector
    if(!is_array($a[0]) && !is_array($b[0])){
        $dot = 0;
        for($i = 0; $i < count($a); $i++){
            $dot += $a[$i] * $b[$i];
        }
        return $dot;
    }

    // matrix, vector
    if(is_array($a[0]) && !is_array($b[0])){
        $dot = [];
        for($i = 0; $i < count($a); $i++){
            $subDot = 0;
            for($j = 0; $j < count($a[$i]); $j++){
                $subDot += $a[$i][$j] * $b[$j];
            }
            $dot[] = $subDot;
        }
        return $dot;
    }
}

function add($a, $b){

    // vector, scalar or vector, vector
    if(!is_array($a[0])){
        $sum = [];
        for($i = 0; $i < count($a); $i++){
            $sum[] = $a[$i] + (is_array($b) ? $b[$i] : $b);
        }
        return $sum;
    }
}

function print_array($a){

    // vector
    if(!is_array($a[0]))
        print("[ " . implode(' ', $a) . " ]\n");
}


$inputs = [1.0, 2.0, 3.0, 2.5];

$weights = [[0.2, 0.8, -0.5, 1.0],
            [0.5, -0.91, 0.26, -0.5],
            [-0.26, -0.27, 0.17, 0.87]];

$biases = [2.0, 3.0, 0.5];

$output = add(dot($weights, $inputs), $biases);
print_array($output);
