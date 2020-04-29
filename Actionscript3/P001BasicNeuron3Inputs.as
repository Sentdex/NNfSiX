package
{ //Create a basic neuron with 3 inputs in Actionscript 3 document class (Associated tutorial https://www.youtube.com/watch?v=Wo5dMEP_BbI
	import flash.display.MovieClip;
	public class P001BasicNeuron3Inputs extends MovieClip
	{
		public function P001BasicNeuron3Inputs()
		{ //Set defaults 
			var inputs:Array = [1.2, 5.1, 2.1]; //New Array with input values
			var weights:Array = [3.1, 2.1, 8.7]; //New Array with weights values
			var bias:Number = 3.0; //biases values 
			var output:Number = inputs[0]*weights[0] + inputs[1]*weights[1] + inputs[2]*weights[2] + bias;
			trace(output); //Print the result 35.7
		} //end P001BasicNeuron3Inputs
	} //end class
} //end package
