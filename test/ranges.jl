nd1 = NanoDate("2022-10-27T00:00:00.000000000")
nd2 = NanoDate("2022-10-27T10:00:00.000000000")
ndstep = NanoDates.Minute(127)+NanoDates.Second(77)
sr = nd1:ndstep:nd2
steps = collect(sr)
nsteps = length(steps)

@test nd1 + (nsteps-1)*ndstep <= nd2
@test nd1 + nsteps*ndstep >= nd2

# `Dates.tons` measures a `Year` as the mean Gregorian year in Float64 nanoseconds,
# which is too coarse to keep the trailing nanosecond, so test that NanoDates is
# doing it correctly.
# A mean Gregorian year of 365.2425 days is 31_556_952 seconds.
@test value(Year(100) + Nanosecond(1)) === Int128(100) * 31_556_952 * 1_000_000_000 + 1

