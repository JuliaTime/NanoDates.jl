@testset "retype" begin

    @test retype(CompoundPeriod, adate) == Yr + Mn + Dy
    @test retype(CompoundPeriod, atime) == Hr + Mi + Sc + Ms + Cs + Ns
    @test retype(CompoundPeriod, adatetime) == Yr + Mn + Dy + Hr + Mi + Sc + Ms
    @test retype(CompoundPeriod, ananodate) == Yr + Mn + Dy + Hr + Mi + Sc + Ms + Cs + Ns
    
    @test retype(Date, retype(CompoundPeriod, adate)) == adate
    @test retype(Time, retype(CompoundPeriod, atime)) == atime
    @test retype(DateTime, retype(CompoundPeriod, adatetime)) == adatetime
    @test retype(NanoDate, retype(CompoundPeriod, ananodate)) == ananodate
    
end

@testset "iterate CompoundPeriod" begin
    cperiod = Mn + Dy + Hr + Mi
    orderedtypes = (typeof(Mi), typeof(Hr), typeof(Dy), typeof(Mn))
    for (idx, period) in enumerate(cperiod)
        @test typeof(period) == orderedtypes[idx]
    end
end
