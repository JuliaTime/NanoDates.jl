# NanoDates.jl
### celebrating the finer aspects of time

----


|&nbsp; 📅 &nbsp;  | [![docs](https://img.shields.io/badge/docs-dev-blue.svg)](https://jeffreysarnoff.github.io/NanoDates.jl/dev/) |  [![Coverage Status](https://coveralls.io/repos/github/JuliaCI/Coverage.jl/badge.svg?branch=master)](https://coveralls.io/github/JeffreySarnoff/NanoDatesjl?branch=main) |  [![Aqua QA](https://raw.githubusercontent.com/JuliaTesting/Aqua.jl/master/badge.svg)](https://github.com/JuliaTesting/Aqua.jl) | [![MIT license](http://img.shields.io/badge/license-MIT-brightgreen.svg)](http://opensource.org/licenses/MIT) |
|--|:------------:|:-----------:|:----------:|:---------:|
| &nbsp; 🕰️  &nbsp; |  guidance     | well tested | clean code | attribution only |


----


##### motivation

- *Every day should have all the times-of-day* (except where timezone changes apply)

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


  
| light nanoseconds | metric distance          |
|------------------:|:-------------------------:|
| 1 ns              | 300 millimeters          |
| 1000 ns == 1 μs   | 300 meters &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  |
| 1000 μs == 1 ms   | 300 kilometers&nbsp; |
|-------------------|--------------------------|
|                   | 300 is really 299.792458 |

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;from Grace Hopper (thank you, Grace)


