inputs =: 1 2 3 2.5

ArrayMaker =: ". ;. _2

weights =: ArrayMaker 0 : 0
0.2 0.8 _0.5 1
0.5 _0.91 0.26 _0.5
_0.26 _0.27 0.17 0.87
)

bias =: 2 3 0.5

output =: (weights +/ . * inputs) + bias

echo output
exit(0)