@testset "timestamp generation" begin

    @test timestamp(nd; utc=true, postfix=true) == "2022-07-28T10:20:08.350789420Z"
    @test timestamp(nd; utc=true, postfix=false) == "2022-07-28T10:20:08.350789420"
    @test timestamp(nd; localtime=true, postfix=true) == "2022-07-28T10:20:08.350789420"*NanoDates.LOCAL_TZ_DELTA_STR
    @test timestamp(nd; localtime=true, postfix=false) == timestamp(nd + NanoDates.LOCAL_TZ_DELTA; utc=true, postfix=false)
   
    @test timestamp(nd; sep="_", postfix=false) == "2022-07-28T10:20:08.350_789_420"
    @test timestamp(nd; sep="_") == "2022-07-28T10:20:08.350_789_420Z"
    @test timestamp(nd; sep="_", postfix=false) == "2022-07-28T10:20:08.350_789_420"

end

@testset "timestamp parsing" begin
    @test NanoDate("2022-06-18T12:15:30.123456789", dateformat"yyyy-mm-ddTHH:MM:SS.sssssssss") == NanoDate(2022, 06, 18, 12, 15, 30, 123, 456, 789)
    @test NanoDate("2022-06-18T12:15:30.123456789Z", dateformat"yyyy-mm-ddTHH:MM:SS.sssssssssZ") == NanoDate(2022, 06, 18, 12, 15, 30, 123, 456, 789)
    @test NanoDate("2022-06-18T12:15:30.123456789-04:00", dateformat"yyyy-mm-ddTHH:MM:SS.sssssssss+hh:mm"; localtime=true) == NanoDate(2022, 06, 18, 8, 15, 30, 123, 456, 789)

    @test NanoDate("2022-06-18T12:15:30.123456", dateformat"yyyy-mm-ddTHH:MM:SS.ssssss") == NanoDate(2022, 06, 18, 12, 15, 30, 123, 456, 0)
    @test NanoDate("2022-06-18T12:15:30.123456Z", dateformat"yyyy-mm-ddTHH:MM:SS.ssssssZ") == NanoDate(2022, 06, 18, 12, 15, 30, 123, 456, 0)
    @test NanoDate("2022-06-18T12:15:30.123456-04:00", dateformat"yyyy-mm-ddTHH:MM:SS.ssssss+hh:mm"; localtime=true) == NanoDate(2022, 06, 18, 8, 15, 30, 123, 456, 0)

    @test NanoDate("2022-06-18T12:15:30.12345", dateformat"yyyy-mm-ddTHH:MM:SS.sssss") == NanoDate(2022, 06, 18, 12, 15, 30, 123, 450, 0)
    @test NanoDate("2022-06-18T12:15:30.12345Z", dateformat"yyyy-mm-ddTHH:MM:SS.sssssZ") == NanoDate(2022, 06, 18, 12, 15, 30, 123, 450, 0)
    @test NanoDate("2022-06-18T12:15:30.12345-04:00", dateformat"yyyy-mm-ddTHH:MM:SS.sssss+hh:mm"; localtime=true) == NanoDate(2022, 06, 18, 8, 15, 30, 123, 450, 0)
end

@testset "ndtoday" begin

end

@testset "ndnow" begin

end

@testset "ndnow{_strict" begin

end
