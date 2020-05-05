=begin comment
Associated YT tutorial: https://youtu.be/TEWy9vZcxW4

Note: Raku's rand draws from uniform, not normal distribution.

See https://rosettacode.org/wiki/Statistics/Normal_distribution#Raku
for an example of a normal distribution.
=end comment

srand(0);

sub mmult (@a, @b) {
    my @p;
    for ^@a X ^@b[0] -> ($r, $c) {
        @p[$r][$c] += @a[$r][$_] * @b[$_][$c] for ^@b
    }
    @p;
}

my @X =  [1.0, 2.0, 3.0, 2.5],
         [2.0, 5.0, -1.0, 2.0],
         [-1.5, 2.7, 3.3, -0.8];

class Layer_Dense {
    has @.weights;
    has @.biases;
    has @.output;

    method new($n_inputs, $n_neurons) {
        my @weights;
        my @biases;
        for ^$n_inputs {
            @weights[$_] = [(-0.1..0.1).rand xx $n_neurons];
        }
        @biases = [0 xx $n_neurons];
        self.bless(:@weights, :@biases);
    }

    method forward(@inputs) {
        my @product = mmult(@inputs, self.weights);
        for ^@inputs {
            self.output[$_] =@product[$_] >>+<< self.biases;
        }
    }
}

my $layer1 = Layer_Dense.new(4, 5);
my $layer2 = Layer_Dense.new(5, 2);

$layer1.forward(@X);
$layer2.forward($layer1.output);
say $layer2.output;
