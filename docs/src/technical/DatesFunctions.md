
## Getting Integer Valued Information

### nanoseconds as Int128 values

```
> nd = NanoDate("2022-06-18T12:15:30.123456789");

> nanoseconds = Dates.value(nd)
63791237730123456789

> typeof(nanoseconds)
Int128

> nd == NanoDate(nanoseconds)
true
```

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

