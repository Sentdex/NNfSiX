<?php
/**
* Doing dot product with a layer of neurons and multiple inputs
* Associated YT NNFS tutorial: https://www.youtube.com/watch?v=TEWy9vZcxW4
* I've added start() which makes it more usable, and is easier to follow the tutorial =github.com/alexnf8
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
        print("[ " . implode(' ', $a) . " ]<br>");
    else{
        foreach($a as $array){
        print("[ " . implode(' ', $array) . " ]<br>");
        }
    }
}

function start($inputs, $weights, $biases, $addBool){
    $output = [];
if(is_array($inputs[0])){
    foreach($inputs as $input){
        if ($addBool){
            array_push($output, (add(dot($weights, $input), $biases)));
    }else{
        array_push($output, (dot($weights, $input)));
    }
    }
}else{
    if($addBool){
        $output = add(dot($weights, $inputs), $biases);
    }else{
        $output = dot($weights, $inputs);
    }
}
return $output;
}

$X = [[1, 2, 3, 2.5],
      [2, 5, -1, 2],
      [-1.5, 2.7, 3.3, -.8]];

class Layer_Dense{
    function __construct($n_inputs, $n_neurons){
        $this->weights = [];
        for($i=0;$i<$n_neurons;$i++){//create weights
            $a1 = array_fill(0,$n_inputs,"");//creates an array with $n_inputs length
            foreach($a1 as $key => &$value){
                $value = rand(-10000,10000)/10000;
            }
            array_push($this->weights, $a1);
        }
        $this->biases=array_fill(0,$n_neurons-1,null);
    }

    function forward($inputs){
        $this->output = start($inputs, $this->weights, $this->biases,false);
    }
}
$layer1 = new Layer_Dense(4,5);
$layer2 = new Layer_Dense(5,2);

$layer1 -> forward($X);
$layer2 -> forward($layer1->output);
print_array($layer2->output);