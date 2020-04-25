/*
Create a basic neuron with 3 inputs in Java
*/

class P001BasicNeuron3Inputs {
	public static void main(String[] args) {
		double[] inputs = {1.2, 5.1, 2.1};
		double[] weights = {3.1, 2.1, 8.7};
		double bias = 3.1;

		double output = inputs[0] * weights[0] + inputs[1] * weights[1] + inputs[2] * weights[2] + bias;
		System.out.println(output);
	}
}