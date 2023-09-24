## Using NanoDates in ranges

```
using Dates, NanoDates

nd1 = NanoDate("2022-10-27T00:00:00.000000000")
nd2 = NanoDate("2022-10-27T10:00:00.000000000")
nanostep = NanoDates.Minute(127)+NanoDates.Second(77)+NanoDates.Microsecond(99875)

steprange = nd1:ndstep:nd2
nsteps = length(steprange)

(nsteps-1)*ndstep <= nd2-nd1 <= nsteps*ndstep
# true
```
