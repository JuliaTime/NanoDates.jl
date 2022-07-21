# NanoDates.jl
### celebrating the finer aspects of time

----


|&nbsp; 📅 &nbsp;  | [![docs](https://img.shields.io/badge/docs-dev-blue.svg)](https://juliatime.github.io/NanoDates.jl/dev/) |  [![Coverage Status](https://coveralls.io/repos/github/JeffreySarnoff/NanoDates.jl/badge.svg?branch=main)](https://coveralls.io/github/JeffreySarnoff/NanoDates.jl?branch=main) |  [![Aqua QA](https://raw.githubusercontent.com/JuliaTesting/Aqua.jl/master/badge.svg)](https://github.com/JuliaTesting/Aqua.jl) | [![MIT license](http://img.shields.io/badge/license-MIT-brightgreen.svg)](http://opensource.org/licenses/MIT) |
|--|:------------:|:-----------:|:----------:|:---------:|
| &nbsp; 🕰️  &nbsp; |  guidance     | testing | clean code | attribution only |

[![DOI](https://zenodo.org/badge/483859789.svg)](https://zenodo.org/badge/latestdoi/483859789)

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
|:-----------------:|:-------------------------:|
| 1 ns              | 299_793_458 nanometers    |
| 1 ns              | 0.299_793_458 meters  |

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;from Grace Hopper (thank you, Grace)


