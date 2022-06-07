@testset "value access" begin
    @test year(nd) == yr
    @test month(nd) == mn
    @test day(nd) == dy
    @test hour(nd) == hr
    @test minute(nd) == mi
    @test second(nd) == sc
    @test millisecond(nd) == ms
    @test microsecond(nd) == cs
    @test nanosecond(nd) == ns
end

@testset "period access" begin
    @test Year(nd) == Yr
    @test Month(nd) == Mn
    @test Day(nd) == Dy
    @test Hour(nd) == Hr
    @test Minute(nd) == Mi
    @test Second(nd) == Sc
    @test Millisecond(nd) == Ms
    @test Microsecond(nd) == Cs
    @test Nanosecond(nd) == Ns
end

@testset "multiperiod access" begin
    @test days(nd) = days(nd.datetime)
    @test yearmonthday(nd) = (year(nd), month(nd), day(nd)) 
    @test yearmonth(nd) = (year(nd), month(nd))
    @test monthday(nd) = (month(nd), day(nd))
end
