@testset "stringize" begin

    @test string(nd) == "2022-07-28T10:20:08.350789420"
    @test string(nd; sep=Underscore) == "2022-07-28T10:20:08.350_789_420"

end

@testset "parse" begin
    df = dateformat
    
    @test parse(NanoDate, "1999-07-12 08:15:30", df"yyyy-mm-dd HH:MM:SS") == NanoDate(1999,07,12,08,15,30)
    @test parse(NanoDate, "2022-7-8 4:5:6.1", df"yyyy-m-d H:M:S.s") == NanoDate(2022,7,8,4,5,6,1)
    @test parse(NanoDate, "2022/07/18 04:15:16.124", df"yyyy/mm/dd HH:MM:SS.s") == NanoDate(2022,7,18,4,15,16,124)
    @test parse(NanoDate, "2022-07-18T04:15:16.1245", df"yyyy-mm-ddTHH:MM:SS.ss") == NanoDate(2022,7,18,4,15,16,124,500)
    @test parse(NanoDate, "2022-07-18T04:15:16.12456789", df"yyyy-mm-ddTHH:MM:SS.sss") == NanoDate(2022,7,18,4,15,16,124,567,890)

end

