<?php
	
	function DotProduct ($arrayOne, $arrayTwo, &$result) {

		for ($iterator = 0; $iterator < count($arrayOne); $iterator++) { 
			
			$output = 0;

			for ($jiterator = 0; $jiterator < count($arrayTwo); $jiterator++)
				$output += $arrayOne[$iterator][$jiterator] * $arrayTwo[$jiterator];

			$result[$iterator] = $output;
		}
	}

	function Add ($arrayOne, $arrayTwo, &$result) {

		for ($iterator = 0; $iterator < count($arrayOne); $iterator++)
			$result[$iterator] = $arrayOne[$iterator] + $arrayTwo[$iterator];

	}

	function OutputArray ($array) {
		
		for ($iterator = 0; $iterator < count($array); $iterator++) { 
		
			echo($array[$iterator]);
		
			echo(" ");
		}
	}

	$inputs = array(1.0, 2.0, 3.0, 2.5);

	$weights = array(array(0.2, 0.8, -0.5, 1.0), 
					 array(0.5, -0.91, 0.26, -0.5),
					 array(-0.26, -0.27, 0.17, 0.87)
					); 

	$biases = array(2.0, 3.0, 0.5);

	$productArray = array();
	$result = array();

	DotProduct ($weights, $inputs, $productArray);

	Add ($productArray, $biases, $result);
	
	OutputArray ($result);

?>