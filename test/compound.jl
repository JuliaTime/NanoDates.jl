@testset "iterate CompoundPeriod" begin
    cperiod = Mn + Dy + Hr + Mi
    orderedtypes = (typeof(Mi), typeof(Hr), typeof(Dy), typeof(Mn))
    for (idx, period) in enumerate(cperiod)
        @test typeof(period) == orderedtypes[idx]
    end
end
