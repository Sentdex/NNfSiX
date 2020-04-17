/**
 * Creates a basic neuron with 3 inputs
 *
 * Associated YT NNFS tutorial: https://www.youtube.com/watch?v=Wo5dMEP_BbI
 */

#include <iostream>
#include <vector>

using namespace std;

double neuron(vector<double> i, vector<double> w, double bias) 
{
    double output = 0;

    for(int a = 0; a < i.size() && a < w.size(); a++)
    {
        output += i[a] * w[a];
    }
    output += bias;

    return output;
}

int main() 
{
    vector<double> inputs;
    vector<double> weights;

    inputs.push_back(1.2);
    inputs.push_back(5.1);
    inputs.push_back(2.1);

    weights.push_back(3.1);
    weights.push_back(2.1);
    weights.push_back(8.7);

    double bias = 3.0;
    
    double output = neuron(inputs, weights, bias);

    cout << "Output : " << output << endl;;
}
