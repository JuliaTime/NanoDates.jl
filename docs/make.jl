
using Documenter

makedocs(
   # modules = [NanoDates],
    sitename = "NanoDates.jl",
    authors = "Jeffrey Sarnoff",
    source = "src",
    clean = false,
    strict = !("strict=false" in ARGS),
    doctest = ("doctest=only" in ARGS) ? :only : true,
    format = Documenter.HTML(
        # Use clean URLs, unless built as a "local" build
        prettyurls = !("local" in ARGS),
        highlights = ["yaml"],
        ansicolor = true,
    ),
    pages = [
        "Home" => "index.md",
        "Advantages" => "appropriate/advantages.md",
        "Basic Use" => Any[
            "Construction" => "use/construction.md",
            "Specification" => "use/specify.md",
            "Accessors" => "use/accessors.md",
        ],
        "Helpful Extras" => Any[
            "Period Compounding" => "use/compoundperiod.md",
            "Conviences" => "use/convenient.md",
            "Strings" => "use/intostring.md",
        ],
        "tempus fugit" => Any[
             "Outside Time" => "betterinformed/the_representation.md",
             "Inside  Time" =>  "betterinformed/their_dual_natures.md",
        ]
    ]
)

#=
Deploy docs to Github pages.
=#
Documenter.deploydocs(
    branch = "gh-pages",
    target = "build",
    deps = nothing,
    make = nothing,
    repo = "github.com/JeffreySarnoff/NanoDates.jl.git",
)

