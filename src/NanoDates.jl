module NanoDates

export NanoDate, date_time
export nanodate2rata, rata2nanodate, nanodate2unix, unix2nanodate

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

const NanoDate0 = NanoDate(0,1,1,0,0,0,0,0,0)

end

