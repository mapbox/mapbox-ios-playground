# arc

This is a Swift implementation of the Great Arc method, ported
from [arc.js](https://github.com/springmeyer/arc.js).

Notes:

* It took a long time to realize that instead of casting lots of things
  to Floats, I should just give in and represent everything as Doubles
* The range operators are like Ruby's, but `..` is `..<` instead.
* Tests can't deeply assert anything about objects, it seems, like t.deepEqual
  can for JavaScript.
* XCode warning about using var when you don't need to is super cool.
