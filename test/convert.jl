@testset "convert" begin
    @test convert(NanoDate, daytime) == nd0
    @test convert(NanoDate, dayte) == nd00
end

@testset "promote" begin
    @test promote(nd, daytime) == (nd, NanoDate(daytime))
    @test promote(nd, dayte) == (nd, NanoDate(dayte))
end

@testset "splice" begin
    @test NanoDate(nd, latertime) == NanoDate(Date(nd), latertime)
    @test NanoDate(nd, laterdate) == NanoDate(laterdate, Time(nd))
    @test NanoDate(nd, Nanosecond(444)) ==
        NanoDate(nd.datetime, nanosecs(Microsecond(nd), Nanosecond(444)))
    @test NanoDate(nd, Microsecond(888)) ==
        NanoDate(nd.datetime, nanosecs(Microsecond(888),Nanosecond(nd)))
    @test NanoDate(nd, Microsecond(888), Nanosecond(444)) ==
        NanoDate(nd.datetime, nanosecs(Microsecond(888),Nanosecond(444)))
end

@testset "substitute" begin
    @test nd - NanoDate(nd, Yr-Year(2)) == Year(2)
    @test nd - NanoDate(nd, Quarter(nd) - Quarter(2)) == Quarter(2)
    @test nd - NanoDate(nd, Mn-Month(-2)) == Month(-2)
    @test nd - NanoDate(nd, Week(nd) - Week(2)) == Week(2)
    @test nd - NanoDate(nd, Dy+Day(2)) == -Day(2)
 
    @test nd - NanoDate(nd, Hr-Hour(2)) == Hour(2)
    @test nd - NanoDate(nd, Mi+Minute(122)) == -Minute(122)
    @test nd - NanoDate(nd, Sc-Second(64)) == Second(64)
    @test nd - NanoDate(nd, Ms-Millisecond(324)) == Millisecond(324)

    @test nd - NanoDate(nd, Cs-Microsecond(800)) == Microsecond(800)
    @test nd - NanoDate(nd, Ns-Nanosecond(999)) == Nanosecond(999)
end

