This is a project I'm taking on to learn both deep learning and the math
behind it all from the ground up. I'll be improving and adding to the library
as I move through the NNFS guide/series and become a better Nim developer.

The math (libs/common.nim) is not optimized at all right now- there are no
iterators, inline functions, etc to improve efficiency or exception handling.

That being said...

The concept of a deep learning framework written in pure Nim via the standard
library sounds pretty cool!

repo: https://github.com/Niminem/NimNet

******** NOTICE ********

If you'd like to use a (real) and higher performance math library, you can use Neo!
https://github.com/andreaferretti/neo

I had originally used Neo through part 6 with no issues. You'll just need to modify
the code a little bit.