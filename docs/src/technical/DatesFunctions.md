
## Getting Integer Valued Information

----

### low level internals from Dates

|   function         | mapping                          |
|:-------------------|:---------------------------------|
| value(x::T):       | x --> value stored in x::T       |
| toms(x::Period):   | x --> milliseconds               |
| tons(x::Period):   | x --> nanoseconds                |
|                    |                                  |
| days(x::Date)      | x --> daycount (RataDie)         |
| days(x::DateTime)  | x --> daycount (RataDie)         |


-----

