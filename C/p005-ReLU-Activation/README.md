


import numpy as np 
import nnfs
from nnfs.datasets import spiral_data  # See for code: https://gist.github.com/Sentdex/454cb20ec5acf0e76ee8ab8448e6266c

nnfs.init()

X, y = spiral_data(100, 3)

f = open("spiral_data.txt","w+")
print(len(X))
for z in X:
	print(z)
	f.write(str(z) + '\n')

f.close();