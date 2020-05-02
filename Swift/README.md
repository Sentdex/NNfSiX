Neural Networks from Scratch in Swift
---

## notes
recreating the necessary parts of numpy to follow along quickly becomes cumbersome. A better approach is to use a library. 

Arguably the best library to use for this is numpy itself, by using [swift for tensorflow](https://github.com/tensorflow/swift
) and directly importing Python like:

```swift
import TensorFlow
import Python

let np = Python.import("numpy")

let array = np.arange(100).reshape(10, 10) // Create a 10x10 numpy array.
```
<small>src: [swift for tensorflow README.md
](https://github.com/tensorflow/swift
)</small>

however, this approach is no longer pure swift. Plausibly suitable libaries do exist for matrix manipulation, such as [Surge](https://github.com/Jounce/Surge
), which was chosen because it uses Accelorate and so can reasonably be expected to _have legs_.

## instructions

In order to use this playground, you need to associate it with a xcworkspace project that has been configured to use Surge. This can be done manually, but it is far simpler to use a tool like arena or nef to set this up for you:

- `brew install finestructure/tap/arena`
- `arena Jounce/Surge`
- (when xcode opens to playground) <large>⌘+b</large>

