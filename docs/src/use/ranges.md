## Using NanoDates in ranges

```
using Dates, NanoDates

nd1 = NanoDate("2022-10-27T00:00:00.000000000")
nd2 = NanoDate("2022-10-27T10:00:00.000000000")
nanostep = Minute(127) + Second(77) + Microsecond(99875) + Nanosecond(7850)

steprange = nd1:nanostep:nd2
nsteps = length(steprange)
steps = collect(steprange)
#=
5-element Vector{NanoDate}:
 2022-10-27T00:00:00
 2022-10-27T02:08:17.099882850
 2022-10-27T04:16:34.199765700
 2022-10-27T06:24:51.299648550
 2022-10-27T08:33:08.399531400
=#

(nsteps-1)*nanostep <= nd2-nd1 <= nsteps*nanostep
# true
```
