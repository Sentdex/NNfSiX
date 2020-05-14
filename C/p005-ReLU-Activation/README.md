
spiral_data.txt was generated using the following python code

`sscanf()` has a rounding error when reading the file.

```python
import numpy as np 
import nnfs
from nnfs.datasets import spiral_data

nnfs.init()

X, y = spiral_data(100, 3)

f = open("spiral_data.txt","w+")
print(len(X))
for z in X:
	print(z)
	f.write(str(z) + '\n')

f.close();
```
