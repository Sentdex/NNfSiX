package
{ //Create a basic neuron layer with dot product in Actionscript 3 document class (Associated tutorial https://www.youtube.com/watch?v=tMrbN67U9d4)
	import flash.display.MovieClip;
	public class P003DotProduct extends MovieClip
	{
		public function P003DotProduct()
		{ //Set defaults 
			var inputs: Array = [1.0, 2.0, 3.0, 2.5]; //New Array with input values
			var weights: Array = [[0.2, 0.8, -0.5, 1.0], [0.5, -0.91, 0.26, -0.5], [-0.26, -0.27, 0.17, 0.87]]; //New 2D Array with weight values 
			var biases: Array = [2.0, 3.0, 0.5]; //New Array with biases values 
			trace(f_add(f_dotProduct(weights, inputs), biases)); //Print the result 4.8,1.21,2.385
		} //end P003DotProduct

		private function f_dotProduct(input1: Array, input2: Array)
		{ //Calculate weights and inputs 
			var outputs: Array = new Array(input1.length); //New Array set to the input1 array size
			for (var i: int = 0; i < input1.length; i++)
			{ //loop through the input1 Array
				var output: Number = 0; //Stores the output of the calculation
				for (var j: int = 0; j < input2.length; j++)
				{ //loop through the input2 Array
					output += input1[i][j] * input2[j]; //calculation of weights * inputs
				} //end for
				outputs[i] = output; //Store the output value
			} //end for
			return outputs; //return the outputs
		} //end f_dotProduct

		private function f_add(input1: Array, input2: Array)
		{ //Add the biases
			var output = new Array(input1.length); //New Array set to the input1 array size
			for (var i: int = 0; i < input1.length; i++)
			{ //loop through the input1 Array
				output[i] = input1[i] + input2[i]; //calculation of (weights * inputs) + biases
			} //end for
			return output;
		} //end f_add
	} //end class
} //end package
