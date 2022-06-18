@testset "adjusters .. truncation" begin

   trunc(nd, Year) == firstdayofyear(nd)
   trunc(nd, Quarter) == firstdayofquarter(nd)
   trunc(nd, Month) == firstdayofmonth(nd)
   trunc(nd, Week) == firstdayofweek(nd)
   trunc(nd, Day) == firsthourofday(nd)
   trunc(nd, Hour) == firstminuteofhour(nd)
   trunc(nd, Minute) == firstsecondofminute(nd)
   trunc(nd, Second) == firstmillisecondofsecond(nd)
   trunc(nd, Millisecond) == firstmillisecondofsecond(nd)
   trunc(nd, Microsecond) == firstmicrosecondofmillisecond(nd)
   trunc(nd, Nanosecond) == firstnanosecondofmicrosecond(nd)
   
end
