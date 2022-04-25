@testset "value access" begin
    @test year(ananodate) == yr
    @test month(ananodate) == mn
    @test day(ananodate) == dy
    @test hour(ananodate) == hr
    @test minute(ananodate) == mi
    @test second(ananodate) == sc
    @test millisecond(ananodate) == ms
    @test microsecond(ananodate) == cs
    @test nanosecond(ananodate) == ns
end

@testset "period access" begin
    @test Year(ananodate) == Yr
    @test Month(ananodate) == Mn
    @test Day(ananodate) == Dy
    @test Hour(ananodate) == Hr
    @test Minute(ananodate) == Mi
    @test Second(ananodate) == Sc
    @test Millisecond(ananodate) == Ms
    @test Microsecond(ananodate) == Cs
    @test Nanosecond(ananodate) == Ns
end

