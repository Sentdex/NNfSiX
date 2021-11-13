use Math::Matrix;
sub dotProduct{
    my $weights = Math::Matrix-> new(@{$_[0]});
    my $inputs = Math::Matrix-> new(@{ $_[1] });
    my $biases = Math::Matrix-> new(@{ $_[2] });
    
    ($x, $y) = $weights->size;
    ($m, $n) = $inputs->size;
    
    if ($y ne $m && $y eq $n){
        $inputs = $inputs -> transpose;
    }
    $output = $weights -> mmul($inputs);

    if ($output->ncol() eq $biases->nrow() && $output->nrow() eq $biases->ncol()){
        $biases = $biases -> transpose;
    }
    $output = $output->madd($biases);

    return $output->transpose->print();
}

@inputs = [1.0, 2.0, 3.0, 2.5];
@weights = ([0.2, 0.8, -0.5, 1.0], 
            [0.5, -0.91, 0.26, -0.5], 
            [-0.26, -0.27, 0.17, 0.87]);
@biases = [2.0, 3.0, 0.5];

dotProduct(\@weights, \@inputs, \@biases);

