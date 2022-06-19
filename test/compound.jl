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

@testset "canonical" begin

    @test canonical(Microsecond(5)) == Microsecond(5)
    @test canonical(Microsecond(1234)) == Millisecond(1) + Microsecond(234)

    @test canonical(Quarter(2)) == Month(6)
    @test canonical(Week(1) + Day(3)) == Day(10)

end

@testset "Date" begin
   
   da = Date(2022,6,18)
   cpda = CompoundPeriod(da)

   @test Date(cpda) == da
   @test Date(cpda - Day(da)) == da - Day(da)
   @test Date(cpda - Day(da) + Day(1)) == da - Day(da) + Day(1)
   @test Date(cpda - Day(da)) - Day(1) == (da - Day(da)) - Day(1)
   @test Date(cpda - (Day(da) - Day(1))) == da - (Day(da) - Day(1))
   
   @test Date(cpda - Month(da)) == da - Month(da)
   @test Date(cpda - Month(da) + Month(1)) == da - Month(da) + Month(1)
   @test Date(cpda - Month(da)) - Month(1) == (da - Month(da)) - Month(1)
   @test Date(cpda - (Month(da) - Month(1))) == da - (Month(da) - Month(1))
   
   @test Date(cpda - Month(da) - Day(da)) == da - Month(da) - Day(da)

end
