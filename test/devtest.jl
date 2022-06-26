using Dates, NanoDates
import Parsers as p

nd = NanoDate(2022, 6, 18,  12, 15, 30,  123, 456, 789);
ndstr = string(nd); ndstrlen = length(ndstr);

dfmt(::Type{NanoDate}) = "::Type{NanoDate}"
dfmt(nd::NanoDate) = "nd::NanoDate"
dfmt(x) = "unrecognized"

po1s = P.Options(stripwhitespace=true, stripquoted=true, dateformat="yyyy-mm-ddTHH:MM:SS.s");
po2s = P.Options(stripwhitespace=true, stripquoted=true, dateformat="yyyy-mm-ddTHH:MM:SS.ss");
po3s = P.Options(stripwhitespace=true, stripquoted=true, dateformat="yyyy-mm-ddTHH:MM:SS.sss");

po1n = P.Options(stripwhitespace=true, stripquoted=true, dateformat="yyyy-mm-ddTHH:MM:SS.n");
po2n = P.Options(stripwhitespace=true, stripquoted=true, dateformat="yyyy-mm-ddTHH:MM:SS.nn");
po3n = P.Options(stripwhitespace=true, stripquoted=true, dateformat="yyyy-mm-ddTHH:MM:SS.nnn");


tryxparse(::Type{NanoDate}, str::String, pos::Int64, 
          strlen::Int64, po::P.Options) =
    P.xparse(NanoDate, ndstr, pos, strlen, po1s)

println(("po1s", po1s))
println(("po2s", po2s))
println(("po3s", po3s))

println(("po1n", po1n))
println(("po2n", po2n))
println(("po3n", po3n))

tryparsed = tryparse(NanoDate, ndstr);
println(tryparsed, ndstr)

tryxparsed = xparse(NanoDate, ndstr)
println(tryxparsed, ndstr)




