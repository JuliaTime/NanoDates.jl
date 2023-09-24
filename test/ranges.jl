nd1 = NanoDate("2022-10-27T00:00:00.000000000")
nd2 = NanoDate("2022-10-27T10:00:00.000000000")
ndstep = NanoDates.Minute(127)+NanoDates.Second(77)
sr = nd1:ndstep:nd2
steps = collect(sr)
nsteps = length(steps)

@test nd1 + (nsteps-1)*ndstep <= nd2
@test nd1 + nsteps*ndstep >= nd2

