
mulby60(x::T) where T = (x * 60)

mulby86400(x::T)   where T = (x *              86_400)
mulby86400e3(x::T) where T = (x *          86_400_000)
mulby86400e6(x::T) where T = (x *     (86_400_000_000 % Int128))
mulby86400e9(x::T) where T = (x * (86_400_000_000_000 % Int128))

mulby10(x::T)   where T = (x *             10)
mulby100(x::T)  where T = (x *            100)
mulby1e3(x::T)  where T = (x *          1_000)
mulby1e6(x::T)  where T = (x *      1_000_000)
mulby1e9(x::T)  where T = (x * (1_000_000_000 % Int128))

mulby60e3(x::T) where T = (x *          60_000)
mulby60e6(x::T) where T = (x *      60_000_000)
mulby60e9(x::T) where T = (x * (60_000_000_000 % Int128))


fldby86400(x::T)   where T = fld(x,              86_400)
fldby86400e3(x::T) where T = fld(x,          86_400_000)
fldby86400e6(x::T) where T = fld(x,      86_400_000_000)
fldby86400e9(x::T) where T = fld(x,  86_400_000_000_000)

fldby10(x::T)   where T = fld(x,             10)
fldby60(x::T)   where T = fld(x,             60)
fldby100(x::T)  where T = fld(x,            100)
fldby1e3(x::T)  where T = fld(x,          1_000)
fldby1e6(x::T)  where T = fld(x,      1_000_000)
fldby1e9(x::T)  where T = fld(x,  1_000_000_000)

fldby60e3(x::T) where T = fld(x,          60_000)
fldby60e6(x::T) where T = fld(x,      60_000_000)
fldby60e9(x::T) where T = fld(x,  60_000_000_000)


modby60(x::T) where T = mod(x, 60)

modby86400(x::T)   where T = mod(x,              86_400)
modby86400e3(x::T) where T = mod(x,          86_400_000)
modby86400e6(x::T) where T = mod(x,      86_400_000_000)
modby86400e9(x::T) where T = mod(x,  86_400_000_000_000)

modby10(x::T)   where T = mod(x,             10)
modby100(x::T)  where T = mod(x,            100)
modby1e3(x::T)  where T = mod(x,          1_000)
modby1e6(x::T)  where T = mod(x,      1_000_000)
modby1e9(x::T)  where T = mod(x,  1_000_000_000)

modby60e3(x::T) where T = mod(x,          60_000)
modby60e6(x::T) where T = mod(x,      60_000_000)
modby60e9(x::T) where T = mod(x,  60_000_000_000)


fldmodby60(x::T) where T = fldby60(x), modby60(x)

fldmodby86400(x::T)   where T = fldby86400(x), modby86400(x)
fldmodby86400e3(x::T) where T = fldby86400e3(x), modby86400e3(x)
fldmodby86400e6(x::T) where T = fldby86400e6(x), modby86400e6(x)
fldmodby86400e9(x::T) where T = fldby86400e9(x), modby86400e9(x)

fldmodby10(x::T)   where T = fldby10(x), modby10(x)
fldmodby100(x::T)  where T = fldby100(x), modby100(x)
fldmodby1e3(x::T)  where T = fldby1e3(x), modby1e3(x)
fldmodby1e6(x::T)  where T = fldby1e6(x), modby1e6(x)
fldmodby1e9(x::T)  where T = fldby1e9(x), modby1e9(x)

fldmodby60e3(x::T) where T = fldby60e3(x), fldby60e3(x)
fldmodby60e6(x::T) where T = fldby60e6(x), fldby60e6(x)
fldmodby60e9(x::T) where T = fldby60e9(x), fldby60e9(x)

# ------------------------------------------------------------------


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

#=

# nanoseconds per millisecond
# microseconds per second

function mulby1000000(x)
    y = Int128(x)
    z = (y << 6) - y
    z = (z << 5) - z
    z = (z << 3) + y
    z << 6
end


# safe for x:2^2:Int64 <= 2^27 - 1
unsafe_fld_1_000_000(x::T) where {T<:Union{Int64,UInt64}} =
    ((x >> 6) * 274_878) >> 32

fld_1_000_000(x::T) where {T<:Union{Int64,UInt64}} =
    if (x < 134_217_728)          # 2^27 -1
        unsafe_fld_1_000_000(x)
    else
        fld(x, 1_000_000)
    end

function fldmod_1_000_000(x::T) where {T<:Union{Int64,UInt64}}
    quotient = if (x < 134_217_728)          # 2^27 -1
        unsafe_fld_1_000_000(x)
    else
        fld(x, 1_000_000)
    end

    remainder = x - quotient * 1_000_000
    quotient, remainder
end
=#
#=
# 86_400 (SecondsPerDay)
function mulby86400(x)
    y = x
    z = (y << 4) - y
    z = (z << 4) - z
    z = (z << 2) - z
    z << 7
end

# 86_400_000 (MillisecondsPerDay)
function mulby86400000(x)
    y = x
    z = (y << 5) - y
    z = (z << 2) + y
    z = (z << 4) - z
    z = (z << 4) - z
    z = (z << 2) - z
    z << 10
end

# 60 (SecondsPerMinute, MinutesPerHour)
function mulby60(x)
    y = x
    z = (y << 4) - y
    z << 2
end

# 3600 = 60*60 (SecondsPerHour)
function mulby3600(x)
    y = x
    z = (y << 4) - y
    z = (z << 4) - z
    z << 4
end

# 1440 = 24*60 (MinutesPerDay)
function mulby1440(x)
    y = x
    z = (y << 4) - y
    z = (z << 2) - z
    z << 5
end

# 1_000_000_000 (NanosecondsPerSecond)
function mulby_1000000000(x)
    y = x
    z = (y << 6) - y
    z = (z << 5) - z
    z = (z << 3) + y
    z = (z << 2) + z
    z = (z << 2) + z
    z = (z << 2) + z
    z << 9
end
=#

#=

reference

Euclidean Affine Functions and Applications to Calendar Algorithms
by Cassio Neri, Lorenz Schneider
    arXiv:2102.06959v1 [cs.DS] 13 Feb2021
    https://arxiv.org/pdf/2102.06959.pdf
    pg 11
=#

mod2p32(x) = (x & 0xffff)

unsafe_fld_3600(x) =
    (1193047 * x) >> 32

function fld_3600(x)
    if x < 2_257_200
        unsafe_fld_3600(x)
    else
        fld(x, 3600)
    end
end

unsafe_mod_3600(x) =
    3600 * mod2p32(1193047 * x) >> 32

function mod_3600(x)
    if x < 2_255_762
        unsafe_mod_3600(x)
    else
        mod(x, 3600)
    end
end

function fldmod_3600(x)
    if x < 2_255_762
        (unsafe_fld_3600(x), unsafe_mod_3600(x))
    else
        fldmod(x, 3600)
    end
end

unsafe_fld_60(x) =
    mod2p32(71_582_789 * x) >> 32

function fld_60(x)
    if x < 97_612_920
        unsafe_fld_60(x)
    else
        fld(x, 60)
    end
end

unsafe_mod_60(x) =
    60 * mod2p32(71_582_789 * x) >> 32

function mod_60(x)
    if x < 97_612_920
        unsafe_mod_60(x)
    else
        mod(x, 60)
    end
end

function fldmod_60(x)
    if x < 2_255_762
        (unsafe_fld_60(x), unsafe_mod_60(x))
    else
        fldmod(x, 60)
    end
end


unsafe_fld_10(x) =
    mod2p32(429_496_730 * x) >> 32

function fld_10(x)
    if x < 1_073_741_829
        unsafe_fld_10(x)
    else
        fld(x, 10)
    end
end

unsafe_mod_10(x) =
    10 * mod2p32(429_496_730 * x) >> 32

function mod_10(x)
    if x < 1_073_741_829
        unsafe_mod_10(x)
    else
        mod(x, 10)
    end
end

function fldmod_10(x)
    if x < 1_073_741_829
        (unsafe_fld_10(x), unsafe_mod_10(x))
    else
        fldmod(x, 10)
    end
end

    

#=

const twopow32 = typemax(UInt32)
mod2p32(x) = (x & 0xffff)

const k3600 =   1_193_047     #  n_div_3600 = mod2p32(k3600 * mod32(n))
const   k60 =  71_582_789     #    n_div_60 = mod2p32(  k60 * mod32(n))
const   k10 = 429_496_730     #    n_div_10 = mod2p32(  k10 * mod32(n))

const k3600 =   1_193_047     #  n_mod_3600 = (k3600 * mod32(n)) ÷ k3600
const   k60 =  71_582_789     #    n_mod_60 = (  k60 * mod32(n)) ÷ k60
const   k10 = 429_496_730     #    n_mod_10 = (  k10 * mod32(n)) ÷ k10



const k3600 =   1_193_047     #  n_div_3600 = mod2p32(k3600 * mod32(n))
const   k60 =  71_582_789     #    n_div_60 = mod2p32(  k60 * mod32(n))
const   k10 = 429_496_730     #    n_div_10 = mod2p32(  k10 * mod32(n))

const k3600 =   1_193_047     #  n_mod_3600 = (k3600 * mod32(n)) ÷ k3600
const   k60 =  71_582_789     #    n_mod_60 = (  k60 * mod32(n)) ÷ k60
const   k10 = 429_496_730     #    n_mod_10 = (  k10 * mod32(n)) ÷ k10




const k3600 =   1_193_047     #  n_div_3600 = mod2p32(k3600 * mod32(n))
const   k60 =  71_582_789     #    n_div_60 = mod2p32(  k60 * mod32(n))
const   k10 = 429_496_730     #    n_div_10 = mod2p32(  k10 * mod32(n))

const k3600 =   1_193_047     #  n_mod_3600 = (k3600 * mod32(n)) ÷ k3600
const   k60 =  71_582_789     #    n_mod_60 = (  k60 * mod32(n)) ÷ k60
const   k10 = 429_496_730     #    n_mod_10 = (  k10 * mod32(n)) ÷ k10

tested correct for n =[0,2^32-1]
 mod3600(n) = (3600 * ((1193047*n)%UInt32)) >> 32

=#


#=
    divmod10(k)   -> (k ÷   10, k %   10)     ∀n ∈ [0,     2_257_200]
    divmod60(k)   -> (k ÷   60, k %   60)     ∀n ∈ [0,    97_612_920]
    divmod3600(k) -> (k ÷ 3600, k % 3600)     ∀n ∈ [0, 1_073_741_830]

    div10(k)    -> k ÷   10   ↤  ( 429_496_730 * n ) & twopow32
    div60(k)    -> k ÷   60   ↤  (  71_582_789 * n ) & twopow32
    div3600(k)  -> k ÷ 3600   ↤  (   1_193_047 * n ) & twopow32

    mod10(k)    -> k %   10   ↤  ( 429_496_730 * n ) % twopow32
    mod60(k)    -> k %   60
    mod3600(k)  -> k % 3600
=#

