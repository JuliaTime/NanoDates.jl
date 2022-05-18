# nanoseconds per microsecond
# microseconds per millisecond
# milliseconds per second
# safe for 0 < x < 268435456  (2^28)
unsafe_fld_1000(x::T) where {T} =
    ((x >> 3) * 34_359_739) >> 32

fld_1000(x::T) where {T<:Union{Int64,UInt64}} =
    if (x < 268_435_456)          # 2^28
        unsafe_fld_1000(x)
    else
        fld(x, 1_000)
    end

function fldmod_1000(x::T) where {T<:Union{Int64,UInt64}}
    quotient =  if (x < 268_435_456)          # 2^28
                    unsafe_fld_1000(x)
                else
                    fld(x, 1_000)
                end
    remainder = x - quotient * 1_000
    quotient, remainder
end

# nanoseconds per millisecond
# microseconds per second
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

#=

reference

Euclidean Affine Functions and Applications to Calendar Algorithms
by Cassio Neri, Lorenz Schneider
    arXiv:2102.06959v1 [cs.DS] 13 Feb2021 
    https://arxiv.org/pdf/2102.06959.pdf
    pg 11
=#

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

