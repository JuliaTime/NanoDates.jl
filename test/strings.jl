@testset "stringize" begin
    ndstr1 = "2022-07-28T10:20:08.350789420"
    nd1 = NanoDate(ndstr1)
    ndstr2 = "2022-07-28T10:20:08.350_789_420"
    nd2 = NanoDate(ndstr2)

    @test nd1 == nd2
    @test hour(nd2 - nd1) == 0
end

@testset "parse nanodate strings" begin
    nd1a = NanoDate("1999-07-12 08:15:30", dateformat"yyyy-mm-dd HH:MM:SS")
    nd1b == NanoDate(1999,07,12,08,15,30)
    @test nd1a == nd1b

    nd2a = NanoDate("2022-7-8 4:5:6.1", dateformat"yyyy-m-d H:M:S.s")
    nd2b = NanoDate(2022,7,8,4,5,6,100)
    @test nd2a == nd2b
end

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

#=
    see 
    https://github.com/JuliaTime/NanoDates.jl/issues/3
    https://github.com/JuliaTime/NanoDates.jl/commit/3878003bda122037de9804e1f7c9a2338f7de99f
=#
@testset "drop any 10th, 11th.. subsecond digits" begin
   
    nd = NanoDate(2022, 6, 18,  12, 15, 30,  123, 456, 789);
    ymdhms = string(trunc(nd,Second))
    
    all_as_nanosecs = Time(nd) - Time(ymdhms)
    rollup_nanosecs = canonical(all_as_nanosecs)
    
    subsecstr9digits  = ".123456789"
    subsecstr10digits = ".1234567890"
    subsecstr11digits = ".12345678990"
    subsecstr12digits = ".123456789554"
    subsecstr13digits = ".1234567890001"
    
    ymdhms9subsecs  = ymdhms * subsecstr9digits
    ymdhms10subsecs = ymdhms * subsecstr10digits
    ymdhms11subsecs = ymdhms * subsecstr11digits
    ymdhms12subsecs = ymdhms * subsecstr12digits
    ymdhms13subsecs = ymdhms * subsecstr13digits
    
    subsec9digits = "sss" * "sss" * "sss"
    subsec10digits = subsec9digits  * "s"
    subsec11digits = subsec9digits  * "ss"
    subsec12digits = subsec9digits  * "sss"
    subsec13digits = subsec9digits  * "ssss"
    
    df9subsecs  = dateformat"yyyy-mm-ddTHH:MM:SS.sssssssss"
    df10subsecs = dateformat"yyyy-mm-ddTHH:MM:SS.ssssssssss"
    df11subsecs = dateformat"yyyy-mm-ddTHH:MM:SS.sssssssssss"
    df12subsecs = dateformat"yyyy-mm-ddTHH:MM:SS.ssssssssssss"
    df13subsecs = dateformat"yyyy-mm-ddTHH:MM:SS.sssssssssssss"
    
    @test nd == NanoDate(ymdhms9subsecs,  df9subsecs) 
    @test nd == NanoDate(ymdhms10subsecs, df10subsecs)
    @test nd == NanoDate(ymdhms11subsecs, df11subsecs)
    @test nd == NanoDate(ymdhms12subsecs, df12subsecs)
    @test nd == NanoDate(ymdhms13subsecs, df13subsecs)
    
end

=#
