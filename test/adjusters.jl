@testset "adjusters .. @test truncation" begin

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
