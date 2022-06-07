@testset "CompoundPeriod" begin

  @test dnd == Day(91) + Nanosecond(28656000000000)
  @test cdnd == Day(91) + Hour(7) + Minute(57) + Second(36)

end

@testset "within CompoundPeriods" begin

  @test hour(cdnd) == 7
  @test Day(dnd) == Day(91)

  @test Minute(dnd) == Minute(0)
  @test Minute(cdnd) == Minute(57)

  @test week(dnd) == Week(0)
  @test week(canonicalize(dnd)) == 13

end