# NanoDates.jl
#### celebrating the finer aspects of time

----


| NanoDates status | [![docs](https://img.shields.io/badge/docs-dev-blue.svg)](https://jeffreysarnoff.github.io/NanoDates.jl/dev/) |  [![Coverage Status](https://coveralls.io/repos/github/JuliaCI/Coverage.jl/badge.svg?branch=master)](https:1//coveralls.io/github/JuliaMath/DoubleFloats.jl?branch=master) |  [![Aqua QA](https://raw.githubusercontent.com/JuliaTesting/Aqua.jl/master/badge.svg)](https://github.com/JuliaTesting/Aqua.jl) |  |
|--|-------------|---------|----|----|
|  | use it | well tested | clean methods |  | 


----

`NanoDates` gives you all the dates and all the times-of-day

##### motivation

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

from Grace Hopper

| light nanoseconds | metric distance (units) |
|------------------:|:-----------------------:|
| 1 ns              | 300 millimeters         |
| 1000 ns == 1 μs   | 300 meters              |
| 1000 μs == 1 ms   | 300 kilometers          |
| 1 ms              | 186 miles               |
|-------------------|-------------------------|
|                   | 300 is 299.792458       |




