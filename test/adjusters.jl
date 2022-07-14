@testset "first_of_" begin

   @test trunc(nd, Year) == firstdayofyear(nd)
   @test trunc(nd, Quarter) == firstdayofquarter(nd)
   @test trunc(nd, Month) == firstdayofmonth(nd)
   @test trunc(nd, Week) == firstdayofweek(nd)
   @test trunc(nd, Day) == firsthourofday(nd)
   @test trunc(nd, Hour) == firstminuteofhour(nd)
   @test trunc(nd, Minute) == firstsecondofminute(nd)
   @test trunc(nd, Second) == firstmillisecondofsecond(nd)
   @test trunc(nd, Millisecond) == firstmicrosecondofmillisecond(nd)
   @test trunc(nd, Microsecond) == firstnanosecondofmicrosecond(nd)
   
end

@testset "last_of_" begin

   @test lastdayofyear(nd) == NanoDate(lastdayofyear(nd.datetime))
   @test lastdayofquarter(nd) == NanoDate(lastdayofquarter(nd.datetime))
   @test lastdayofmonth(nd) == NanoDate(lastdayofmonth(nd.datetime))
   @test lastdayofweek(nd) == NanoDate(lastdayofweek(nd.datetime))

   @test lasthourofday(nd) == trunc(nd, Day) + Hour(23)
   @test lastminuteofhour(nd) == trunc(nd, Hour) + Minute(59)
   @test lastsecondofminute(nd) == trunc(nd, Minute) + Second(59)
   @test lastmillisecondofsecond(nd) == trunc(nd, Second) + Millisecond(999)
   @test lastmicrosecondofmillisecond(nd) == trunc(nd, Millisecond) + Microsecond(999)
   @test lastnanosecondofmicrosecond(nd) == trunc(nd, Microsecond) + Nanosecond(999)
   
end
