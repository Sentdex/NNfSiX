/*
Creates a basic neuron with 3 inputs.

Associated YT NNFS tutorial: https://www.youtube.com/watch?v=Wo5dMEP_BbI
*/

class P001BasicNeuron3Inputs {
	public static void main(String[] args) {
		double[] inputs = {1.2, 5.1, 2.1};
		double[] weights = {3.1, 2.1, 8.7};
		double bias = 3.0;
		double output = 0;
		
		for(int i=0; i<inputs.length; i++) {
			output += inputs[i]*weights[i];
		}
		System.out.println(output+bias);
	}
}
