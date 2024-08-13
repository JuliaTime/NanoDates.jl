# NanoDates.jl

#### a date-and-time type
- Years, Months, Days
- Hours, Minutes, Seconds
- Milliseconds, Microseconds, Nanoseconds



#### cooperates with Dates

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
   - Technical Note: DateFormats used with NanoDates must use '.' only to separate seconds from subseconds.
     - If you need that sort of format, use `NanoDate(DateTime(datestring, dateformat))`.
     - `nd = NanoDate(DateTime("12.31.2024 23:59", dateformat"mm.dd.yyyy HH:MM"))`


----
#### help 
- install with  `using Pkg; Pkg.add("NanoDates")`

- ask questions
  - on [Discourse](https://discourse.julialang.org/latest) -- add the tag `time`
  - on [Zulip](https://julialang.zulipchat.com/#narrow/stream/321834-dates-times-zones) -- using the stream `dates-times-zones`
  
- report any issues [here](https://github.com/JuliaTime/NanoDates.jl/issues)

----
