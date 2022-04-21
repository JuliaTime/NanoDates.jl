# NanoDates.jl
#### celebrating the finer aspects of time

`NanoDates` gives you nanoseconds and microseconds with your dates.

The `Time` type from Dates does resolve nanoseconds, and they work within the scope of that type.
With the `DateTime` type from Dates does not keep the two most finely resolved time periods.
*To have date-and-time together, one must drop microseconds and ignore nanoseconds.*

`NanoDate` is a date-and-time type giving you all the dates and all the times-of-day.





Grace Hopper, with gratitude

| light nanoseconds | metric distance (units) |
|------------------:|:-----------------------:|
| 1 ns              | 300 millimeters         |
| 1000 ns == 1 μs   | 300 meters              |
| 1000 μs == 1 ms   | 300 kilometers          |
|                   |                         |
|                   | 300 is 299.792458       |

  1 light-nanometer    is about   30 centimeters
500 light-nanometers   is about  150 meters
500 light-microseconds is about  750 furlongs
  1 light-millisecond  is about  186 miles

