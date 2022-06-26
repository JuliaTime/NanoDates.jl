using Dates, NanoDates
import Parsers as P

nd = NanoDate(2022, 6, 18, 12, 15, 30, 123, 456, 789);
ndstr = string(nd);
ndstrlen = length(ndstr);

dfsec = dateformat"yyyy-mm-ddTHH:MM:SS";
dfmsec = dateformat"yyyy-mm-ddTHH:MM:SS.s";
dfsss = dateformat"yyyy-mm-ddTHH:MM:SS.sss";
dfn = dateformat"yyyy-mm-ddTHH:MM:SS.n";
dfnnn = dateformat"yyyy-mm-ddTHH:MM:SS.nnn";

posec = P.Options(dateformat="yyyy-mm-ddTHH:MM:SS");
pomsec = P.Options(dateformat="yyyy-mm-ddTHH:MM:SS.s");
posss = P.Options(dateformat="yyyy-mm-ddTHH:MM:SS.sss");
pon = P.Options(dateformat="yyyy-mm-ddTHH:MM:SS.n");
ponnn = P.Options(dateformat="yyyy-mm-ddTHH:MM:SS.nnn");

# ===========================


using Dates, NanoDates

nd_nano = NanoDate(2022, 6, 18, 12, 15, 30, 123, 456, 789);
nd_micro = NanoDate(2022, 6, 18, 12, 15, 30, 123, 456);
nd_milli = NanoDate(2022, 6, 18, 12, 15, 30, 123);
nd_sec = NanoDate(2022, 6, 18, 12, 15, 30);

nd_milli2 = NanoDate(2022, 6, 18, 12, 15, 30, 12);
nd_milli3 = NanoDate(2022, 6, 18, 12, 15, 30, 120);
nd_nano2 = NanoDate(2022, 6, 18, 12, 15, 30, 8, 456, 500);

nd_nano_str = string(nd_nano);
nd_micro_str = string(nd_micro);
nd_milli_str = string(nd_milli);
nd_sec_str = string(nd_sec);
nd_nano2_str = string(nd_nano2);
nd_milli2_str = string(nd_milli2);
nd_milli3_str = string(nd_milli3);

df_iso_nano = dateformat"yyyy-mm-ddTHH:MM:SS.sss";
df_iso_micro = dateformat"yyyy-mm-ddTHH:MM:SS.ss";
df_iso_milli = dateformat"yyyy-mm-ddTHH:MM:SS.s";
df_iso_sec = dateformat"yyyy-mm-ddTHH:MM:SS";

df_subsec = dateformat"sss";
df_dotsubsec = dateformat".sss";
df_secsubsec = dateformat"SS.sss";




# =======================================

#=
po1s = P.Options(stripwhitespace=true, stripquoted=true, dateformat="yyyy-mm-ddTHH:MM:SS.s");
po2s = P.Options(stripwhitespace=true, stripquoted=true, dateformat="yyyy-mm-ddTHH:MM:SS.ss");
po3s = P.Options(stripwhitespace=true, stripquoted=true, dateformat="yyyy-mm-ddTHH:MM:SS.sss");

po1n = P.Options(stripwhitespace=true, stripquoted=true, dateformat="yyyy-mm-ddTHH:MM:SS.n");
po2n = P.Options(stripwhitespace=true, stripquoted=true, dateformat="yyyy-mm-ddTHH:MM:SS.nn");
po3n = P.Options(stripwhitespace=true, stripquoted=true, dateformat="yyyy-mm-ddTHH:MM:SS.nnn");


tryxparse(::Type{NanoDate}, str::String, pos::Int64, 
          strlen::Int64, po::P.Options) =
    P.xparse(NanoDate, ndstr, pos, strlen, po1s)


tryparsed(ndstr::AbstractString) = tryparse(NanoDate, ndstr);
println((tryparsed(ndstr), ndstr))

tryxparsed(ndstr::AbstractString) = xparse(NanoDate, ndstr);
println((tryxparsed(ndstr), ndstr))
=#


