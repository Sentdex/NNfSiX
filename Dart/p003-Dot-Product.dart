List<double> dotProduct(List<List<double>> weights, List<double> inputs)
{
  List<double> result = [];
  for(int i=0; i<weights.length; i++)
  {
    double _sum = 0;
    for(int j=0; j<inputs.length; j++)
    {
      _sum += inputs[j]*weights[i][j];
    }
    result.add(_sum);
  }
  return result;
}

List<double> addVectors(List<double> dotProducts, List<double> biases)
{
  List<double> result = [];
  for(int i=0; i<dotProducts.length; i++)
  {
    result.add(dotProducts[i]+biases[i]);
  }
  return result;
}
  
void main() 
{
  // Creating a basic neuron and doing dot product and adding that to biases, instead of multiplying and adding it all manually.
  List<double> inputs = [1.0, 2.0, 3.0, 2.5];
  List<List<double>> weights = [ [0.2, 0.8, -0.5, 1.0],
                                 [0.5, -0.91, 0.26, -0.5],
                                 [-0.26, -0.27, 0.17, 0.87]
                               ];

  List<double> biases = [2.0, 3.0, 0.5];
  List<double> output = addVectors(dotProduct(weights, inputs), biases);
  print(output);
}
