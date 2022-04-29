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
        NanoDate(ananodate.datetime, nanosecs(Nanosecond(444)))
    @test NanoDate(ananodate, Microsecond(888)) ==
        NanoDate(ananodate.datetime, nanosecs(Microsecond(888)))
    @test NanoDate(ananodate, Microsecond(888), Nanosecond(444)) ==
        NanoDate(ananodate.datetime, nanosecs(Microsecond(888),Nanosecond(444)))
end