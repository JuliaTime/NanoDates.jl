# NanoDates.jl

Offers NanoDate, a date-and-time type with nanosecond resolution

#### plays well with others

>   - NanoDate works like DateTime with more precision
>   - Supports Dates.jl methods
>   - Interconverts with DateTime, Date

#### introduces enhancements

>    - supports splicing in period values
        - NanoDate(nd, Hour(5))
          - replaces Hour(nd) with Hour(5)
        - NanoDate(nd, Week(2))
          - moves to Week(2) of the Year(nd)

>    - option to separate subseconds
        - 2022-04-28T02:15:30.124_455_831
        - 2022-04-28T02:15:30.124◦455◦831


----

- installs with  `using Pkg; Pkg.add("NanoDates")`

- ask questions
  - on [Discourse](https://discourse.julialang.org/latest)
  - on [Slack](https://app.slack.com/client/T68168MUP)
  - on [Zulip](https://julialang.zulipchat.com/#narrow/stream/321834-dates-times-zones) -- using the stream `dates-times-zones`
  
- report any issues [here](https://github.com/JeffreySarnoff/NanoDates.jl/issues)

----
