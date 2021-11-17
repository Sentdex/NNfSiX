import kotlin.random.Random

val rng: Random = Random(0) 

fun main() {
    var X: MutableList<MutableList<Double>> =
            mutableListOf(
                    mutableListOf(1.0, 2.0, 3.0, 2.5),
                    mutableListOf(2.0, 5.0, -1.0, 2.0),
                    mutableListOf(-1.5, 2.7, 3.3, -0.8)
            )

    var layer1: Layer_Dense = Layer_Dense(4, 5)
    var layer2: Layer_Dense = Layer_Dense(5, 2)

    layer1.forward(X)
    layer2.forward(layer1.output)
    println(layer2.output)
}

private class Layer_Dense {
    var output: MutableList<MutableList<Double>> = mutableListOf()
    var weights: MutableList<MutableList<Double>> = mutableListOf()
    var biases: MutableList<Double> = mutableListOf()

    constructor(n_inputs: Int, n_neurons: Int) {
        weights = MutableList(n_inputs) { MutableList(n_neurons) { rng.nextDouble(from = -0.5, until = 1.0) * 0.1 }} // -0.5 to make # more likely to be positive
        biases = MutableList(n_neurons) { 0.0 }
        output = MutableList(n_neurons) { mutableListOf() }
    }

    fun forward(inputs: MutableList<MutableList<Double>>) {
        output = inputs.dot2D(weights).addList2D(biases)
    }
}

/** Everything below is implementation of numpy in kotlin ------------------------ */

// dot product of 2 1D arrays
private fun MutableList<Double>.dot1D(list: MutableList<Double>): Double {
    if (list.size != this.size) {
        throw Exception("Lists must be the same size")
    }
    var result: Double = 0.0
    for (i in 0..this.size - 1) {
        result += this[i] * list[i]
    }
    return result
}

// add 1D array to another 1A array
private fun MutableList<Double>.addList1D(list: MutableList<Double>): List<Double> {
    if (this.size != list.size) {
        throw Exception("Lists must be the same size")
    }
    return this.zip(list) { a, b -> a + b }
}

// dot product of 2 2D arrays
private fun MutableList<MutableList<Double>>.dot2D(
        list: MutableList<MutableList<Double>>
): MutableList<MutableList<Double>> {
    var result: MutableList<MutableList<Double>> =
            MutableList(this.size) { MutableList(list[0].size) { 0.0 } }

    for (r in 0..this.size - 1) {
        for (c in 0..list[0].size - 1) {
            for (i in 0..this[0].size - 1) {
                result[r][c] += (this[r][i] * list[i][c])
            }
        }
    }
    return result
}

// transposes a 2D array
private fun MutableList<MutableList<Double>>.T(): MutableList<MutableList<Double>> {
    var out: MutableList<MutableList<Double>> = mutableListOf()

    var x = this.size
    var y = this[0].size
    var N = if (x > y) x else y
    var M = if (y < x) y else x
    for (n in 0..N - 1) {
        for (m in 0..M - 1) {
            var a = if (x > y) n else m
            var b = if (y < x) m else n
            if (out.size <= b) {
                out.add(mutableListOf())
            }
            out[b].add(this[a][b])
        }
    }
    return out
}

// adds a 1D array to a 2D array
private fun MutableList<MutableList<Double>>.addList2D(
        list: MutableList<Double>
): MutableList<MutableList<Double>> {
    if (this[0].size != list.size) {
        throw Exception("List indicies must be the same size")
    }
    return this.map { a -> a.zip(list) { b, c -> b + c }.toMutableList() }.toMutableList()
}
