using Dates, NanoDates
using NanoDates
using Dates: value, CompoundPeriod, toms, tons, UTM, UTD
using NanoDates: nanosecs, NanoDate0, DateTime0, Date0, Time0
using Aqua, Test

Aqua.testall(NanoDates)

include("constants.jl")

@testset "nanodate" begin
    include("nanodate.jl")
end

@testset "accessors" begin
    include("accessors.jl")
end

@testset "convert" begin
    include("convert.jl")
end

@testset "compare" begin
    include("compare.jl")
end

@testset "interop" begin
    include("interop.jl")
end

@testset "arith" begin
    include("arith.jl")
end

@testset "strings" begin
    include("strings.jl")
end
