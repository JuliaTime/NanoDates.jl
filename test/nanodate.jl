using Dates, NanoDates, Test
using NanoDates: datedatetime, nanosecs

date = Date(2022, 7, 28)
time = Time(10, 30, 0, 350, 789, 420)
nanos = nanosecs(Microseconds(time), Nanoseconds(time))
datetime = DateTime(date, trunc(time, Millisecond))
nanodate = NanoDate(datetime, nanos)

@testset "constructors" begin
    @test_throws MethodError NanoDate()
    
    @test nanodate.datetime == datetime
    @test nanodate.nanosecs == nanos

    @test NanoDate(date, time) == nanodate
    @test NanoDate(2022, 7, 28) == NanoDate(date)
    @test NanoDate(2022, 7, 28, 10, 30, 0, 350, 789, 420) == NanoDate(date, time)
end
