nd = NanoDate(2022,05,24,18,26,21,123,456,789)
nd0 = nd - Month(3) - Hour(55) - Second(3456)
dnd = nd - dn0
cdnd = canonical(dnd)

@testset "CompoundPeriod" begin

  @test dnd == Day(19) + Nanosecond(28656000000000)
  @test cdnd == Day(19) + Hour(7) + Minute(57) + Second(36) 

end

@testset "within CompoundPeriods"

  @test hour(cdnd) == 7
  @test Day(dnd) == Day(19)

  @test Minute(dnd) == Minute(0)
  @test Minute(cdnd) == Minute(57)

  @test week(dnd) == Week(0)
  @test week(canonicalize(dnd)) == 13

end