# NanoDates.jl
#### celebrating the finer aspects of time

----


|🕰️| [![docs](https://img.shields.io/badge/docs-dev-blue.svg)](https://jeffreysarnoff.github.io/NanoDates.jl/dev/) |  [![Coverage Status](https://coveralls.io/repos/github/JuliaCI/Coverage.jl/badge.svg?branch=master)](https://coveralls.io/github/JeffreySarnoff/NanoDatesjl?branch=main) |  [![Aqua QA](https://raw.githubusercontent.com/JuliaTesting/Aqua.jl/master/badge.svg)](https://github.com/JuliaTesting/Aqua.jl) |📅|
|--|:------------:|:-----------:|:----------:|--|
|  | guidance     | well tested | clean code |  | 


[![Build Status](https://travis-ci.org/JeffreySarnoff/NanoDates.jl.svg?branch=master)](https://travis-ci.org/JeffreySarnoff/NanoDates.jl)&nbsp;&nbsp;&nbsp;[![codecov](https://codecov.io/gh/JeffreySarnoff/NanoDates.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/JeffreySarnoff/NanoDates.jl)&nbsp;&nbsp;&nbsp;[![Docs](https://img.shields.io/badge/docs-stable-blue.svg)](http://jeffreysarnoff.github.io/NanoDates.jl)



----


##### motivation

- *Every day should have all times-of-day*

- The `Time` type from Dates supports nanoseconds when dates are not used.
- `Time` works incompletely with`DateTime` which is limited to milliseconds.

- We need date-and-time together, fully resolved, accurate and precise.
  - `NanoDate` is familiar and effective
    -  works well with Dates
    -  uses `DateTime` methods

- This package is a redesign of `TimesDates`
  - `TimesDates` is widely used and well-liked
    - offers nanoseond resolved dates       (as do we)
    - offers nanosecond accurate time zones (we do not)
 
- Contributors are welcome
  -  clear code, robust performance, reliable interoperability
  -  frendly docs, easily followed, well explained
 
----

from Grace Hopper (thank you to her)

| light nanoseconds | metric distance (units) |
|------------------:|:-----------------------:|
| 1 ns              | 300 millimeters         |
| 1000 ns == 1 μs   | 300 meters              |
| 1000 μs == 1 ms   | 300 kilometers          |
| 1 ms              | 186 miles               |
|-------------------|-------------------------|
|                   | 300 is 299.792458       |




