@testset "CompoundPeriod" begin

  @test Month(Month(5)) == Month(5)
  @test Day(Day(15)) == Day(15)
  @test Hour(Hour(1)) == Hour(1)
  @test Nanosecond(Nanosecond(123)) == Nanosecond(123)

  @test month(Month(5)) == 5
  @test day(Day(15)) == 15
  @test hour(Hour(1)) == 1
  @test nanosecond(Nanosecond(123)) == 123
  
  @test dnd == Day(91) + Nanosecond(28656000000000)
  @test cdnd == Day(91) + Hour(7) + Minute(57) + Second(36)

end

@testset "within CompoundPeriods" begin

  @test hour(cdnd) == 7
  @test Day(dnd) == Day(91)

  @test Minute(dnd) == Minute(0)
  @test Minute(cdnd) == Minute(57)

  @test week(dnd) == 0
  @test week(canonicalize(dnd)) == 13

end