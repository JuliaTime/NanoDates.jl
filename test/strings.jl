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

#=
    see 
    https://github.com/JuliaTime/NanoDates.jl/issues/3
    https://github.com/JuliaTime/NanoDates.jl/commit/3878003bda122037de9804e1f7c9a2338f7de99f
=#
@testset "drop any 10th, 11th.. subsecond digits" begin
    
    subsecsstr9digits  = "123456789"
    subsecsstr10digits = "1234567890"
    subsecsstr11digits = "12345678990"
    subsecsstr12digits = "123456789554"
    subsecsstr13digits = "1234567890001"
    
    ymdhms9subsecs  = ymdhms * subsecstr9digits
    ymdhms10subsecs = ymdhms * subsecstr10digits
    ymdhms11subsecs = ymdhms * subsecstr11digits
    ymdhms12subsecs = ymdhms * subsecstr12digits
    ymdhms13subsecs = ymdhms * subsecstr13digits
    
    subsecs9digits = "sss" * "sss" * "sss"
    subsecs10digits = subsecs9digits  * "s"
    subsecs11digits = subsecs9digits  * "ss"
    subsecs12digits = subsecs9digits  * "sss"
    subsecs13digits = subsecs9digits  * "ssss"
    
    df9subsecs  = dateformat"yyyy-mm-ddTHH:MM:SS.sssssssss"
    df10subsecs = dateformat"yyyy-mm-ddTHH:MM:SS.ssssssssss"
    df11subsecs = dateformat"yyyy-mm-ddTHH:MM:SS.sssssssssss"
    df12subsecs = dateformat"yyyy-mm-ddTHH:MM:SS.sssssssssss"
    df13subsecs = dateformat"yyyy-mm-ddTHH:MM:SS.ssssssssssss"
    
    str = "2022-04-28T02:15:30"
    str9subsecs  = str * subsecstr9digits
    str10subsecs = str * subsecstr10digits
    str12subsecs = str * subsecstr12digits
    str13subsecs = str * subsecstr13digits
    
    nd = NanoDate(str) + Time(0,0,0,123,456,789)
 
    @test nd == NanoDate(str, df9)
    @test nd == NanoDate(str9subsecs, df9subsecs) 
    @test nd == NanoDate(str10subsecs, df10subsecs)
    @test nd == NanoDate(str11subsecs, df11subsecs)
    @test nd == NanoDate(str12subsecs, df12subsecs)
    @test nd == NanoDate(str13subsecs, df13subsecs)
    
end
