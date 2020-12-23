/**
 * Doing dot product with a layer of neurons and multiple inputs
 * Associated YT NNFS tutorial: https://www.youtube.com/watch?v=tMrbN67U9d4 
 */


fun main() {
    
val inputs = arrayListOf(1.0, 2.0, 3.0, 2.5)

val weights = arrayListOf(
    arrayListOf(0.2, 0.8, -0.5, 1.0), 
    arrayListOf(0.5, -0.91, 0.26, -0.5),
    arrayListOf(-0.26, -0.27, 0.17, 0.87))

val biases = arrayListOf(2.0, 3.0, 0.5)


print(add(dotProduct(weights, inputs), biases))

}

fun dotProduct(weights:ArrayList<ArrayList<Double>>, inputs:ArrayList<Double>): ArrayList<Double>{
    var outputs:ArrayList<Double> = ArrayList<Double>()
    for (weight in weights){
        var output = 0.0
        for (i in 0 until weight.size){
            output = output + weight[i] * inputs[i]
        }
        outputs.add(output)
    }
    
    return outputs
}

fun add(neuron:ArrayList<Double>, biases: ArrayList<Double>): ArrayList<Double>{
    var finalOutput = ArrayList<Double>()
    
    for( i in 0 until neuron.size){
        finalOutput.add(neuron[i] + biases[i])
    }
    
    return finalOutput
}
