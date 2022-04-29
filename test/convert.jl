@testset "convert" begin
    @test convert(NanoDate, adatetime) == ananodate0
    @test convert(NanoDate, adate) == ananodate00
end

@testset "promote" begin
    @test promote(ananodate, adatetime) == (ananodate, NanoDate(adatetime))
    @test promote(ananodate, adate) == (ananodate, NanoDate(adate))
end

@testset "splice" begin
    @test NanoDate(ananodate, latertime) == NanoDate(Date(ananodate), latertime)
    @test NanoDate(ananodate, laterdate) == NanoDate(laterdate, Time(ananodate))
    @test NanoDate(ananodate, Nanosecond(444)) ==
        NanoDate(ananodate.datetime, nanosecs(Microsecond(ananodate), Nanosecond(444)))
    @test NanoDate(ananodate, Microsecond(888)) ==
        NanoDate(ananodate.datetime, nanosecs(Microsecond(888),Nanosecond(ananodate)))
    @test NanoDate(ananodate, Microsecond(888), Nanosecond(444)) ==
        NanoDate(ananodate.datetime, nanosecs(Microsecond(888),Nanosecond(444)))
end

@testset "substitute" begin
    @test ananodate - NanoDate(ananodate, Yr-Year(2)) == Year(2)
    @test ananodate - NanoDate(ananodate, Quarter(ananodate) - Quarter(2)) == Quarter(2)
    @test ananodate - NanoDate(ananodate, Mn-Month(-2)) == Month(-2)
    @test ananodate - NanoDate(ananodate, Week(ananodate) - Week(2)) == Week(2)
    @test ananodate - NanoDate(ananodate, Dy+Day(2)) == -Day(2)
 
    @test ananodate - NanoDate(ananodate, Hr-Hour(2)) == Hour(2)
    @test ananodate - NanoDate(ananodate, Mi+Minute(122)) == -Minute(122)
    @test ananodate - NanoDate(ananodate, Sc-Second(64)) == Second(64)
    @test ananodate - NanoDate(ananodate, Ms-Millisecond(324)) == Millisecond(324)

    @test ananodate - NanoDate(ananodate, Cs-Microsecond(800)) == Microsecond(800)
    @test ananodate - NanoDate(ananodate, Ns-Nanosecond(999)) == Nanosecond(999)
end

