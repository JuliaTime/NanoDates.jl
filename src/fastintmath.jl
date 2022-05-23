mulby_1000(x) = (x<<10) - (x << 5) + (x << 3)

safe_mulby_1000(x::Int64) = x <= 9_223_372_036_854_775 ? mulby_100(x) : 
                                                         ArgumentError("$(x) is too large")
safe_mulby_1000(x::Int32) = x <= 2_147_483 ? mulby_100(x) : ArgumentError("$(x) is too large")

# nanoseconds per microsecond
# microseconds per millisecond
# milliseconds per second
# safe for 0 < x < 268435456  (2^28)
unsafe_fld_1000(x::T) where {T} =
    ((x >> 3) * 34_359_739) >> 32

fld_1000(x::T) where {T<:Union{Int64,UInt64}} =
    if (x < 434_934_000) # 2^28 = 268_435_456
    # if x & ~0xffffffff == 0
        unsafe_fld_1000(x)
    else
        fld(x, 1_000)
    end

function fldmod_1000(x::T) where {T<:Union{Int64,UInt64}}
    quotient = if (x < 268_435_456)          # 2^28
        unsafe_fld_1000(x)
    else
        fld(x, 1_000)
    end
    remainder = x - quotient * 1_000
    quotient, remainder
end

# nanoseconds per millisecond
# microseconds per second
mulby_1000_000(x) = (x << 20) - (x << 15) - (x << 14) + (x << 10) - (x << 9) + (x << 6)
function mulby_1mm(x)
    y = x << 10
    z = y >> 1    # x << 9
    t = z >> 3    # x << 6
    a = y << 4    # x << 14
    b = z << 1    # x << 10
    c = b << 5    # x << 15
    d = c << 5    # x << 20
    d - c - a + b - z + t
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

# mulby86400000a(x) = (x<<26 + x<<24 + x<<21 + x<<18 + x<<17 + x<<14 + x<<12 + x<<11 + x<<10)

mulby86400(x) = mulby15625(x) << 4
mulby15625(x) = (((x << 4)-1) << 10) - (x << 9) - ((x << 5) - x)

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

