module NN
    implicit none

    type layer_dense
        real,allocatable :: weights(:,:)
        real,allocatable :: biases(:)
        real,allocatable :: output(:,:)
    contains
        procedure :: init=>init_layer
        procedure :: forward=>forward_layer
    end type layer_dense

    type activation_relu
        real, allocatable :: output(:,:)
    contains
        procedure :: forward=>forward_relu
    end type activation_relu

contains
    subroutine init_layer(self, n_inputs, n_neurons)
        class(layer_dense) :: self
        integer :: n_inputs, n_neurons
        allocate(self%weights(n_inputs, n_neurons))
        allocate(self%biases(n_neurons))
        call random_number(self%weights)
        self%biases=0.0
    end subroutine init_layer
    subroutine forward_layer(self, inputs)
        class(layer_dense) :: self
        real :: inputs(:,:)
        self%output = matmul(inputs, self%weights) + spread(self%biases,1,size(inputs,1))
    end subroutine forward_layer

    subroutine forward_relu(self, inputs)
        class(activation_relu) :: self
        real :: inputs(:,:)
        integer :: r,c,i,j
        r=size(inputs,1)
        c=size(inputs,2)
        allocate(self%output(r,c))
        do i=1,r
            do j=1,c
                self%output(i,j) = max(0.0, inputs(i,j))
            end do
        end do
    end subroutine forward_relu
end module NN

program main
    use NN
    implicit none

    integer :: i
    real :: X(300,2), y(300)
    type(layer_dense) :: layer1
    type(activation_relu) :: activation1

    open(1,file='spiral.dat')
    do i=1,size(X,1)
        read (1,*) X(i,1),X(i,2),y(i)
    end do
    close(1)

    call layer1%init(size(X,2),5)
    call layer1%forward(X)

    call activation1%forward(layer1%output)

    do i=1,size(activation1%output,1)
        print *, activation1%output(i,:)
    end do

end program main
