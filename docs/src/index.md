# NanoDates.jl

### NanoDate is a date-and-time type
- Years, Months, Days
- Hours, Minutes, Seconds
- Milliseconds, Microseconds, Nanoseconds



#### plays well with others

 - NanoDate works like DateTime with more precision
 - Supports Dates.jl methods
 - construct from 
   - DateTime & Time, Date & Time
   - DateTime & Microseconds [, Nanoseconds]
   - DateTime, Date
 - convert NanoDate to DateTime, Date, Time


#### introduces enhancements

- supports splicing in period values
    - NanoDate(nd, Hour(5))
       - replaces Hour(nd) with Hour(5)
    - NanoDate(nd, Week(2))
       - moves to Week(2) of the Year(nd)

- readability options
    - separate subseconds
       - NanoDate("2022-04-28T02:15:30.124_455_831")
    - substitute space (' ') for 'T' as separator
       - NanoDate("2022-04-28 02:15:30.124_455_831")


----

- installs with  `using Pkg; Pkg.add("NanoDates")`

- ask questions
  - on [Discourse](https://discourse.julialang.org/latest)
  - on [Slack](https://app.slack.com/client/T68168MUP)
  - on [Zulip](https://julialang.zulipchat.com/#narrow/stream/321834-dates-times-zones) -- using the stream `dates-times-zones`
  
- report any issues [here](https://github.com/JeffreySarnoff/NanoDates.jl/issues)

----
