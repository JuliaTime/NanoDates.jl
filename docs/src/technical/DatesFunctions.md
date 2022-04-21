
#### Getting Integer Valued Information

----

#### low level internals from Dates

|   function           | mapping                          |
|:---------------------|:---------------------------------|
| value(x::T):         | x --> integer value underlying T |
| toms(x::Period):     | x --> milliseconds               |
| tons(x::Period):     | x --> nanoseconds                |
|                      |                                  |
| days(x::DatePeriod): | x -->  truncates (rounds down, floors)              |
|                      |   ::Nanoseconds .. ::Hour, ::Day, ::Week            |
|                      |   ::Date, ::DateTime --> daycount (RataDie)         |


-----

