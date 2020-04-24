inputs =: 1 2 3 2.5

weights1 =: 0.2 0.8 _0.5 1
weights2 =: 0.5 _0.91 0.26 _0.5
weights3 =: _0.26 _0.27 0.17 0.87

bias1 =: 2
bias2 =: 3
bias3 =: 0.5

ArrayMaker =: ". ;. _2

output =: ArrayMaker 0 : 0
(0{inputs*0{weights1)+(1{inputs*1{weights1)+(2{inputs*2{weights1)+(3{inputs*3{weights1)+bias1
(0{inputs*0{weights2)+(1{inputs*1{weights2)+(2{inputs*2{weights2)+(3{inputs*3{weights2)+bias2
(0{inputs*0{weights3)+(1{inputs*1{weights3)+(2{inputs*2{weights3)+(3{inputs*3{weights3)+bias3
)

echo output
exit(0)
