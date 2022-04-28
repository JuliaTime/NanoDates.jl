Base.promote_rule(::Type{NanoDate}, ::Type{DateTime}) = NanoDate
Base.promote_rule(::Type{NanoDate}, ::Type{Date}) = NanoDate

# should be in Dates imo, important for NanoDates ease of use 
date_time(d::Date, t::Time) = DateTime(d, trunc(t, Millisecond))

