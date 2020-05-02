module NN
    implicit none

    type layer_dense
        real,allocatable :: weights(:,:)
        real,allocatable :: biases(:)
        real,allocatable :: output(:,:)
    contains
        procedure :: init
        procedure :: forward
    end type layer_dense
contains
    subroutine init(self, n_inputs, n_neurons)
        class(layer_dense) :: self
        integer :: n_inputs, n_neurons
        allocate(self%weights(n_inputs, n_neurons))
        allocate(self%biases(n_neurons))
        call random_number(self%weights)
        self%biases=0.0
    end subroutine init
    subroutine forward(self, inputs)
        class(layer_dense) :: self
        real :: inputs(:,:)
        self%output = matmul(inputs, self%weights) + spread(self%biases,1,size(inputs,1))
    end subroutine forward
end module NN

program main
    use NN
    implicit none

    integer :: i
    real :: X(3,4)
    type(layer_dense) :: layer1, layer2

    X(1,:)  = [ 1.0 ,  2.0 ,  3.0 ,  2.5 ]
    X(2,:)  = [ 2.0 ,  5.0 , -1.0 ,  2.0 ]
    X(3,:)  = [-1.5 ,  2.7 ,  3.3 , -0.8 ]

    call layer1%init(size(X,2),5)
    call layer2%init(5,2)

    call layer1%forward(X)
    call layer2%forward(layer1%output)

    do i=1,size(layer2%output,1)
        print *, layer2%output(i,:)
    end do

end program main
