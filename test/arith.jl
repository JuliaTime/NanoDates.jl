@testset "add periods" begin
    @test ananodate + Year(1) == NanoDate(yr+1,mn,dy,hr,mi,sc,ms,cs,ns)
    @test ananodate + Month(1) == NanoDate(yr,mn+1,dy,hr,mi,sc,ms,cs,ns)
    @test ananodate + Day(1) == NanoDate(yr,mn,dy+1,hr,mi,sc,ms,cs,ns)
    @test ananodate + Hour(1) == NanoDate(yr,mn,dy,hr+1,mi,sc,ms,cs,ns)
    @test ananodate + Minute(1) == NanoDate(yr,mn,dy,hr,mi+1,sc,ms,cs,ns)
    @test ananodate + Second(1) == NanoDate(yr,mn,dy,hr,mi,sc+1,ms,cs,ns)
    @test ananodate + Millisecond(1) == NanoDate(yr,mn,dy,hr,mi,sc,ms+1,cs,ns)
    @test ananodate + Microsecond(1) == NanoDate(yr,mn,dy,hr,mi,sc,ms,cs+1,ns)
    @test ananodate + Nanosecond(1) == NanoDate(yr,mn,dy,hr,mi,sc,ms,cs,ns+1)
end

@testset "subtract periods" begin
    @test ananodate - Year(1) == NanoDate(yr-1,mn,dy,hr,mi,sc,ms,cs,ns)
    @test ananodate - Month(1) == NanoDate(yr,mn-1,dy,hr,mi,sc,ms,cs,ns)
    @test ananodate - Day(1) == NanoDate(yr,mn,dy-1,hr,mi,sc,ms,cs,ns)
    @test ananodate - Hour(1) == NanoDate(yr,mn,dy,hr-1,mi,sc,ms,cs,ns)
    @test ananodate - Minute(1) == NanoDate(yr,mn,dy,hr,mi-1,sc,ms,cs,ns)
    @test ananodate - Second(1) == NanoDate(yr,mn,dy,hr,mi,sc-1,ms,cs,ns)
    @test ananodate - Millisecond(1) == NanoDate(yr,mn,dy,hr,mi,sc,ms-1,cs,ns)
    @test ananodate - Microsecond(1) == NanoDate(yr,mn,dy,hr,mi,sc,ms,cs-1,ns)
    @test ananodate - Nanosecond(1) == NanoDate(yr,mn,dy,hr,mi,sc,ms,cs,ns-1)
end

@testset "trunc to period" begin
    @test trunc(ananodate, Year) == NanoDate(yr)
    @test trunc(ananodate, Month) == NanoDate(yr,mn)
    @test trunc(ananodate, Day) == NanoDate(yr,mn,dy)
    @test trunc(ananodate, Hour) == NanoDate(yr,mn,dy,hr)
    @test trunc(ananodate, Minute) == NanoDate(yr,mn,dy,hr,mi)
    @test trunc(ananodate, Second) == NanoDate(yr,mn,dy,hr,mi,sc)
    @test trunc(ananodate, Millisecond) == NanoDate(yr,mn,dy,hr,mi,sc,ms)
    @test trunc(ananodate, Microsecond) == NanoDate(yr,mn,dy,hr,mi,sc,ms,cs)
    @test trunc(ananodate, Nanosecond) == NanoDate(yr,mn,dy,hr,mi,sc,ms,cs,ns)
end

@testset "floor to period" begin
    @test floor(ananodate, Year) == NanoDate(yr)
    @test floor(ananodate, Month) == NanoDate(yr,mn)
    @test floor(ananodate, Day) == NanoDate(yr,mn,dy)
    @test floor(ananodate, Hour) == NanoDate(yr,mn,dy,hr)
    @test floor(ananodate, Minute) == NanoDate(yr,mn,dy,hr,mi)
    @test floor(ananodate, Second) == NanoDate(yr,mn,dy,hr,mi,sc)
    @test floor(ananodate, Millisecond) == NanoDate(yr,mn,dy,hr,mi,sc,ms)
    @test floor(ananodate, Microsecond) == NanoDate(yr,mn,dy,hr,mi,sc,ms,cs)
    @test floor(ananodate, Nanosecond) == NanoDate(yr,mn,dy,hr,mi,sc,ms,cs,ns)
end

@testset "ceil to period" begin
    @test ceil(ananodate, Year) == NanoDate(yr+!isone(mn))
    @test ceil(ananodate, Month) == NanoDate(yr,mn+!isone(dy))
    @test ceil(ananodate, Day) == NanoDate(yr,mn,dy+!iszero(hr))
    @test ceil(ananodate, Hour) == NanoDate(yr,mn,dy,hr+!iszero(mi))
    @test ceil(ananodate, Minute) == NanoDate(yr,mn,dy,hr,mi+!iszero(sc))
    @test ceil(ananodate, Second) == NanoDate(yr,mn,dy,hr,mi,sc+!iszero(ms))
    @test ceil(ananodate, Millisecond) == NanoDate(yr,mn,dy,hr,mi,sc,ms+!iszero(cs))
    @test ceil(ananodate, Microsecond) == NanoDate(yr,mn,dy,hr,mi,sc,ms,cs+!iszero(ns))
    @test ceil(ananodate, Nanosecond) == NanoDate(yr,mn,dy,hr,mi,sc,ms,cs,ns)
end
