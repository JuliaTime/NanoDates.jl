module NanoDates

export NanoDate, date_time, retype
export nanodate2rata, rata2nanodate, nanodate2unix, unix2nanodate
export CompoundPeriod

using Dates
using Dates: AbstractDateTime, CompoundPeriod,
                value, days, toms, tons, UTM, UTD

include("constants.jl")
include("nanodate.jl")
include("accessors.jl")
include("conversions.jl")
include("compare.jl")
include("interop.jl")
include("arith.jl")
include("strings.jl")
include("io.jl")

end

