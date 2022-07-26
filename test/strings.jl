@testset "stringize" begin
    ndstr1 = "2022-07-28T10:20:08.350789420"
    nd1 = NanoDate(ndstr1)
    ndstr2 = "2022-07-28T10:20:08.350_789_420"
    nd2 = NanoDate(ndstr2)

    @test nd1 == nd2
    @test hour(nd2 - nd1) == 0
end

#=
@testset "parse nanodate strings" begin
    nd1a = NanoDate("1999-07-12 08:15:30", dateformat"yyyy-mm-dd HH:MM:SS")
    nd1b == NanoDate(1999,07,12,08,15,30)
    @test nd1a == nd1b

    nd2a = NanoDate("2022-7-8 4:5:6.1", dateformat"yyyy-m-d H:M:S.s")
    nd2b = NanoDate(2022,7,8,4,5,6,100)
    @test nd2a == nd2b
end
=#
#=
@testset
    @test NanoDate("2022/07/18 04:15:16.124", dateformat"yyyy/mm/dd HH:MM:SS.sss") == NanoDate(2022,7,18,4,15,16,124)
    @test NanoDate("2022-07-18T04:15:16.1245", dateformat"yyyy-mm-ddTHH:MM:SS.ssss") == NanoDate(2022,7,18,4,15,16,124,500)
    @test NanoDate("2022-07-18T04:15:16.12456789", dateformat"yyyy-mm-ddTHH:MM:SS.ssssssss") == NanoDate(2022,7,18,4,15,16,124,567,890)

    str = "2022-05-24 18 26 21.123456789"
    df = dateformat"yyyy-mm-dd HH MM SS.sssssssss"
    @test NanoDate(str, df) == NanoDate(2022,5,24,18,26,21,123,456,789)    
@end
=#

@testset "parse more" begin

    @test NanoDate("2022-04-28 02:15:30") == NanoDate("2022-04-28T02:15:30")
    @test NanoDate("2022-04-28 02:15:30.12") == NanoDate("2022-04-28T02:15:30.12")
    @test NanoDate("2022-04-28 02:15:30.123") == NanoDate("2022-04-28T02:15:30.123")
    @test NanoDate("2022-04-28 02:15:30.1234") == NanoDate("2022-04-28T02:15:30.1234")

end

#=

@testset "stringize" begin

    @test string(nd) == "2022-07-28T10:20:08.350789420"
    @test string(nd; sep=Underscore) == "2022-07-28T10:20:08.350_789_420"

end

@testset "parse" begin
    
    @test NanoDate("1999-07-12 08:15:30", dateformat"yyyy-mm-dd HH:MM:SS") == NanoDate(1999,07,12,08,15,30)
    @test NanoDate("2022-7-8 4:5:6.1", dateformat"yyyy-m-d H:M:S.s") == NanoDate(2022,7,8,4,5,6,100)
    @test NanoDate("2022/07/18 04:15:16.124", dateformat"yyyy/mm/dd HH:MM:SS.sss") == NanoDate(2022,7,18,4,15,16,124)
    @test NanoDate("2022-07-18T04:15:16.1245", dateformat"yyyy-mm-ddTHH:MM:SS.ssss") == NanoDate(2022,7,18,4,15,16,124,500)
    @test NanoDate("2022-07-18T04:15:16.12456789", dateformat"yyyy-mm-ddTHH:MM:SS.ssssssss") == NanoDate(2022,7,18,4,15,16,124,567,890)

    str = "2022-05-24 18 26 21.123456789"
    df = dateformat"yyyy-mm-dd HH MM SS.sssssssss"
    @test NanoDate(str, df) == NanoDate(2022,5,24,18,26,21,123,456,789)
    
end

@testset "parse more" begin

    @test NanoDate("2022-04-28 02:15:30") == NanoDate("2022-04-28T02:15:30")
    @test NanoDate("2022-04-28 02:15:30.12") == NanoDate("2022-04-28T02:15:30.12")
    @test NanoDate("2022-04-28 02:15:30.123") == NanoDate("2022-04-28T02:15:30.123")
    @test NanoDate("2022-04-28 02:15:30.1234") == NanoDate("2022-04-28T02:15:30.1234")

end

=#
