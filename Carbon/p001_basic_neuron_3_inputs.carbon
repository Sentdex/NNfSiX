// CHECK: result: 34
//This is a basic neuron with 3 int inputs
//Associated tutorial by Sentdex:https://www.youtube.com/watch?v=Wo5dMEP_BbI


package ExplorerTest api;


fn Main()-> i32 {

  var inputs: [i32; 3] = (1, 2, 3);
  var weights: [i32; 3] = (3, 2, 8);
  var bias: i32 = 3;

  var output: i32 = inputs[0] * weights[0] +
                    inputs[1] * weights[1] + 
                    inputs[2] * weights[2] + 
                    bias;
  Print("The output is:{0}", output);
  return 0;

}



