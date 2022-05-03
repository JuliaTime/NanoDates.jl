# NanoDates.jl
#### celebrating the finer aspects of time


`NanoDates` gives you nanoseconds and microseconds with your dates.

##### motivation

- The `Time` type from Dates supports nanoseconds when dates are not used.
- `Time` works incompletely with`DateTime` which is limited to milliseconds.

- We need date-and-time together, fully resolved, accurate and precise.
  - `NanoDate` is familiar and effective
    -  works well with Dates
    -  uses `DateTime` methods

- This package is a redesign of `TimesDates`
  - `TimesDates` is widely used and well liked
    - offers nanoseond resolved dates       (as do we)
    - offers nanosecond accurate time zones (we do not)
 
- Contributors are welcome
  -  clear code, robust performance, reliable interoperability
  -  frendly docs, easily followed, well explained
 
----

`NanoDate`, a type giving you all the dates and all the times-of-day.

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




