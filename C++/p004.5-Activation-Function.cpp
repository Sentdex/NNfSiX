#include <iostream>
#include <vector>

using namespace std;

void printlayer(vector <vector <double>> weights, vector <double> biases, int layernumber)
{
		cout << "\n======= Layer " << layernumber << " =======\n\n";
		for(size_t x=0; x < weights.size(); x++)
		{
			cout << "weights" << x+1 << ": [ ";
			for(size_t i=0; i < weights[x].size(); i++)
			{
				string a = i < (weights[x].size() - 1) ? ", " : "" ;
				printf("%.8f%s", weights[x][i], a.c_str());
			}
			cout << " ]\n";
		}

		cout << "\n  biases: [ ";
		for(size_t i=0; i < biases.size(); i++)
		{
			string a = i < (biases.size() - 1) ? ", " : "";
			printf("%.8f%s", biases[i], a.c_str());
		}
		cout << " ]\n";
}

void printoutput(vector <vector <double>> outputs, string type="", int number=0)
{
	if(outputs.size()) { cout << endl; if(type.length()) cout << "===== " << type << " " << number << " =====\n\n"; }

	for(size_t x=0; x < outputs.size(); x++)
	{
		cout << "outputs" << x+1 << ": [ ";
		for(size_t i=0; i < outputs[x].size(); i++)
		{
			string a = i < (outputs[x].size() - 1) ? ", " : "";
			printf("%.8f%s", outputs[x][i], a.c_str());
		}
		cout << " ]\n";
	}
}

class layer_dense
{
	public:

		int inputs;
		int neurons;
		int layernumber;
		static int count;
		vector <double> biases;
		vector <vector <double>> weights;
		vector <vector <double>> outputs;

		void output(bool printname=false)
		{ if(printname) { printoutput(outputs, "Layer", layernumber); } else { printoutput(outputs); } }

		void print() { printlayer(weights, biases, layernumber); }

		layer_dense(int n_inputs, int n_neurons, char rnd=true)
		{
			neurons = n_neurons;
			inputs = n_inputs;
			layernumber = ++count;  
			weights = vector <vector <double>> (inputs, vector <double> (neurons));
			biases.resize(neurons); if(rnd > 1) for(double &x : biases) x = (double)rand() / (double)RAND_MAX;
			if(rnd) for(int i=0; i < inputs; i++) for(double &x : weights[i]) x = (double)rand() / (double)RAND_MAX;
		}

		void forward(vector <vector <double>> inputdata)
		{
			outputs = vector <vector <double>> (inputdata.size(), vector <double> (neurons));
			for(size_t z=0; z < inputdata.size(); z++) for(int i=0; i < neurons; i++)
			{
				double dotprod = 0.0;
				for(int x=0; x < inputs; x++) dotprod += weights[x][i] * inputdata[z][x];
				outputs[z][i] = dotprod + biases[i];
			}
		}
};

class activation_relu
{
	public:
		static int count;
		int activation_number;
		vector <vector <double>> outputs;

		activation_relu() { activation_number = ++count; }
		void output() { printoutput(outputs, "Activation", activation_number); }

		void forward(vector <vector <double>> inputs, bool deriv=false)
		{
			outputs = inputs;
			for(size_t x=0; x < outputs.size(); x++) for(double &k : outputs[x])
			{
				if(deriv) { k = k > 0 ? 1 : 0; } else { k = k > 0 ? k : 0; }
			}
		}
};

int layer_dense::count = 0;
int activation_relu::count = 0;

int main(int argc, char** argv)
{
	srand(0);
	vector <vector <double>> X = {
					{1, 2, 3, 2.5},
					{2.0, 5.0, -1.0, 2.0},
					{-1.5, 2.7, 3.3, -0.8} };

	layer_dense layer1 = layer_dense(X[0].size(), 5);
	layer_dense layer2 = layer_dense(layer1.neurons, 2);
	activation_relu activation1;

	layer1.weights = {{ 0.17640523, 0.04001572,  0.0978738,  0.22408932,   0.1867558 },
			  {-0.09772779, 0.09500884, -0.01513572, -0.01032189,  0.04105985},
			  { 0.01440436, 0.14542735,  0.07610377, 0.0121675,    0.04438632},
			  { 0.03336743, 0.14940791, -0.02051583, 0.03130677,  -0.08540957}};

	layer2.weights = {{-0.25529898,  0.06536186},
			 { 0.08644362, -0.0742165 },
			 { 0.22697546, -0.14543657},
			 { 0.00457585, -0.01871839},
			 { 0.15327792,  0.14693588}};

	//layer1.print();
	layer1.forward(X);
	//layer1.output();
	
	//activation1.forward(layer1.outputs);
	//activation1.output();

	//layer2.print();
	layer2.forward(layer1.outputs);
	layer2.output();
}
