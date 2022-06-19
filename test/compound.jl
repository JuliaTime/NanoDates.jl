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
   
    tda = today()
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

    @test Date(Month(11)) == Date(year(tda), 11, 1)
    @test Date(Day(11)) == Date(year(tda), 1, 11)

end

@testset "DateTime([Compound]Period)" begin
    tda = today()

    @test DateTime(Month(2)) == firstdayofyear(tda) + Month(2-1)
    @test DateTime(Month(2) + Second(5)) ==
        firstdayofyear(tda) + Month(2-1) + Second(5)
    @test DateTime(Month(2) + Microsecond(0)) ==
        firstdayofyear(tda) + Month(2-1)
    @test DateTime(Month(2) + Microsecond(999)) ==
        firstdayofyear(tda) + Month(2-1)
end

@testset "NanoDate(Period)" begin

    tda = NanoDate(today())
    @test NanoDate(Month(3)) == 
        tda - (Month(month(tda)-1)) + Month(3-1) - Day(day(tda)-1)
    @test NanoDate(Day(5)) == firstdayofyear(tda) + Day(5-1)
    @test NanoDate(Hour(3)) == firsthourofday(tda) + Hour(3)

end

@testset "NanoDate(CompoundPeriod)" begin
    nd = NanoDate(2022, 6, 18,  12, 15, 30,  123, 456, 789);
    cnd = CompoundPeriod(nd)
    tda = NanoDate(today())
    
    @test NanoDate(Month(2) + Day(5)) ==
        firstdayofyear(tda) + Month(2-1) + Day(5-1)
    @test NanoDate(Month(2) + Hour(3)) ==
        firstdayofyear(tda) + Month(2-1) + Hour(3)

    @test NanoDate(CompoundPeriod(nd)) == nd
end
