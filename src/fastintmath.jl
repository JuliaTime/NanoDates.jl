# nanos per micro, micros per milli, millis per second
#
# safe for 0 < x < 268435456  (2^28)
#
is_x_lt_2pow28(x::UInt64) = iszero(x & 0x1fff_ffff_f000_0000)
is_x_lt_2pow28(x::UInt32) = iszero(x & 0xf000_0000)
is_x_lt_2pow28(x::Int64)  = is_x_lt_2pow28(x % UInt64)
is_x_lt_2pow28(x::Int32)  = is_x_lt_2pow28(x % UInt32)

is_x_gte_2pow28(x::UInt32) = iszero(x & 0x8000_0000)
issafe_fld_1000(x::Int64) = !signbit(x) && iszero(x & 0x0000000010000000)

unsafe_fld_1000(x::T) where {T} =
    ((x >> 3) * 34_359_739) >> 32

fld_1000(x::T) where {T<:Union{Int64,UInt64}} =
    if (x < 434_934_000) # 2^28 = 268_435_456
    # if x & ~0xffffffff == 0
        unsafe_fld_1000(x)
    else
        fld(x, 1_000)
    end

@inline mulby_1000(x::T) where {T<:Signed} = (x * T(1_000))
@inline mulby_100(x::T) where {T<:Signed} = (x * T(100))

unsafe_mulby_1000(x) = (x<<10) - (x << 5) + (x << 3)

safe_mulby_1000(x::Int64) = x <= 9_223_372_036_854_775 ? mulby_100(x) : 
                                                         ArgumentError("$(x) is too large")
safe_mulby_1000(x::Int32) = x <= 2_147_483 ? mulby_100(x) : ArgumentError("$(x) is too large")

function fldmod_1000(x::T) where {T<:Union{Int64,UInt64,Int128}}
    if abs(x) <= 9_780_955_816
        quotient =  if (x < 434_934_000)          # in 2^28 .. 2^29
                        unsafe_fld_1000(x)
                    else
                        fld(x, 1_000)
                    end

        remainder = x - unsafe_mulby_1000(quotient)
        
        if signbit(quotient) && signbit(remainder)
            quotient -= 1
            remainder += 1000
        end
    else
        quotient, remainder = fldmod(x, 1000)
    end
        
    quotient, remainder
end
