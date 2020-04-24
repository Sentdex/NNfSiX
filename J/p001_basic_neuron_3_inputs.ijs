inputs =: 1.2 5.1 2.1
weights =: 3.1 2.1 8.7
bias =: 3


output =: (0{inputs*0{weights)+(1{inputs*1{weights)+(2{inputs*2{weights)+bias

echo output
exit(0)
