program NN
    implicit none
    real    :: inputs(4,1),weights(3,4),biases(3,1),outputs(3,1)

    inputs   = reshape([ 1.0 ,  2.0 ,  3.0 ,  2.5 ],shape(inputs))

    weights  = reshape([ 0.2 ,  0.8 , -0.5 ,  1.0,&
                         0.5 , -0.91,  0.26, -0.5,& 
                        -0.26, -0.27,  0.17,  0.87], shape(weights),order=[2,1])

    biases   = reshape([2.0, 3.0, 0.5], shape(biases))

    outputs  = matmul(weights,inputs) + biases
    ! In fortran, dot_product is only for vectors

    print *, outputs
end program NN
