# NanoDates.jl

### a date-and-time type
- Years, Months, Days
- Hours, Minutes, Seconds
- Milliseconds, Microseconds, Nanoseconds



### cooperates with Dates

 - NanoDate works like a more precise DateTime
 - all Dates methods (afaik)
 - construct from 
   - DateTime & Time, Date & Time
   - DateTime & Microseconds [, Nanoseconds]
   - DateTime, Date
 - deconstruct to
   - DateTime, Date, Time
 - uses DateFormat
   - one 's' for each subsecond digit
   - `format(::NanoDate, ::DateFormat)`


----

- install with  `using Pkg; Pkg.add("NanoDates")`

- ask questions
  - on [Discourse](https://discourse.julialang.org/latest) -- add the tag `time`
  - on [Zulip](https://julialang.zulipchat.com/#narrow/stream/321834-dates-times-zones) -- using the stream `dates-times-zones`
  
- report any issues [here](https://github.com/JeffreySarnoff/NanoDates.jl/issues)

----
