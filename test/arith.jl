@testset "add periods" begin
    @test ananodate + Year(1) == NanoDate(yr+1,mn,dy,hr+1,mi,sc,ms,cs,ns)
    @test ananodate + Month(1) == NanoDate(yr,mn+1,dy,hr+1,mi,sc,ms,cs,ns)
    @test ananodate + Day(1) == NanoDate(yr,mn,dy+1,hr,mi,sc,ms,cs,ns)
    @test ananodate + Hour(1) == NanoDate(yr,mn,dy,hr+1,mi,sc,ms,cs,ns)
    @test ananodate + Minute(1) == NanoDate(yr,mn,dy,hr,mi+1,sc,ms,cs,ns)
    @test ananodate + Second(1) == NanoDate(yr,mn,dy,hr,mi,sc+1,ms,cs,ns)
    @test ananodate + Millisecond(1) == NanoDate(yr,mn,dy,hr,mi,sc,ms+1,cs,ns)
    @test ananodate + Microsecond(1) == NanoDate(yr,mn,dy,hr,mi,sc,ms,cs+1,ns)
    @test ananodate + Nanosecond(1) == NanoDate(yr,mn,dy,hr,mi,sc,ms,cs,ns+1)
end

@testset "subtract periods" begin
    @test ananodate - Year(1) == NanoDate(yr-1,mn,dy,hr+1,mi,sc,ms,cs,ns)
    @test ananodate - Month(1) == NanoDate(yr,mn-1,dy,hr+1,mi,sc,ms,cs,ns)
    @test ananodate - Day(1) == NanoDate(yr,mn,dy-1,hr,mi,sc,ms,cs,ns)
    @test ananodate - Hour(1) == NanoDate(yr,mn,dy,hr-1,mi,sc,ms,cs,ns)
    @test ananodate - Minute(1) == NanoDate(yr,mn,dy,hr,mi-1,sc,ms,cs,ns)
    @test ananodate - Second(1) == NanoDate(yr,mn,dy,hr,mi,sc-1,ms,cs,ns)
    @test ananodate - Millisecond(1) == NanoDate(yr,mn,dy,hr,mi,sc,ms-1,cs,ns)
    @test ananodate - Microsecond(1) == NanoDate(yr,mn,dy,hr,mi,sc,ms,cs-1,ns)
    @test ananodate - Nanosecond(1) == NanoDate(yr,mn,dy,hr,mi,sc,ms,cs,ns-1)
end

