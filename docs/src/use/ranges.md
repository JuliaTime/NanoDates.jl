## Using NanoDates in ranges

```
using Dates, NanoDates

nd1 = NanoDate("2022-10-27T00:00:00.000000000")
nd2 = NanoDate("2022-10-27T10:00:00.000000000")
nanostep = NanoDates.Minute(127)+NanoDates.Second(77)+NanoDates.Microsecond(99875)

steprange = nd1:ndstep:nd2
nsteps = length(steprange)
steps = collect(steprange)
#=
5-element Vector{NanoDate}:
 2022-10-27T00:00:00
 2022-10-27T02:08:17.099875
 2022-10-27T04:16:34.199750
 2022-10-27T06:24:51.299625
 2022-10-27T08:33:08.399500
=#

(nsteps-1)*ndstep <= nd2-nd1 <= nsteps*ndstep
# true
```
