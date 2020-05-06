=begin comment
Doing dot product with a layer of neurons and multiple inputs
Associated YT NNFS tutorial: https://www.youtube.com/watch?v=tMrbN67U9d4
=end comment

sub dot (@weights, @inputs) {
    my @output;
    for @weights -> @w {
        @output.append: [+] @w >>*<< @inputs;
    }
    @output;
}

my @inputs = 1.0, 2.0, 3.0, 2.5;
my @weights = [0.2, 0.8, -0.5, 1.0],
              [0.5, -0.91, 0.26, -0.5],
              [-0.26, -0.27, 0.17, 0.87];

my @biases = 2.0, 3.0, 0.5;

my $output = dot(@weights, @inputs) >>+<< @biases;

say $output;
