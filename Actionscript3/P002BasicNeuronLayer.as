package
{ //Create a simple layer of neurons, with 4 inputs in Actionscript 3 document class (Associated tutorial https://www.youtube.com/watch?v=lGLto9Xd7bU
	import flash.display.MovieClip;
	public class P002BasicNeuronLayer extends MovieClip
	{
		public function P002BasicNeuronLayer()
		{ //Set defaults 
			var inputs: Array = [1.0, 2.0, 3.0, 2.5]; //New Array with input values
			var weights1: Array = [0.2, 0.8, -0.5, 1.0]; //New Array with weights values
			var weights2: Array = [0.5, -0.91, 0.26, -0.5]; //New Array with weights values
			var weights3: Array = [-0.26, -0.27, 0.17, 0.87]; //New Array with weights values

			var bias1: Number = 2.0; //biases values 
			var bias2: Number = 3.0; //biases values 
			var bias3: Number = 0.5; //biases values 

			var output: Array = output = [inputs[0] * weights1[0] + inputs[1] * weights1[1] + inputs[2] * weights1[2] + inputs[3] * weights1[3] + bias1,
                              inputs[0] * weights2[0] + inputs[1] * weights2[1] + inputs[2] * weights2[2] + inputs[3] * weights2[3] + bias2,
                              inputs[0] * weights3[0] + inputs[1] * weights3[1] + inputs[2] * weights3[2] + inputs[3] * weights3[3] + bias3];
			trace(output); //Print the result 4.8,1.21,2.385
		} //end P002BasicNeuronLayer
	} //end class
} //end package
