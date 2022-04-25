
using Documenter

makedocs(
    # modules = [NanosecondDates],
    sitename = "NanosecondDates",
    authors = "Jeffrey Sarnoff",
    clean = false,
    strict = !("strict=false" in ARGS),
    doctest = ("doctest=only" in ARGS) ? :only : true,
    format = Documenter.HTML(
        # Use clean URLs, unless built as a "local" build
        prettyurls = !("local" in ARGS),
        highlights = ["yaml"],
        ansicolor = true,
    ),
    pages = Any[
        "Home" => "index.md",
        "Use" = Any[
            "Construction" => "use/construction.md",
            "As a string" => "use/intostring.md",
        ],
    ],
)

#=
Deploy docs to Github pages.
=#
Documenter.deploydocs(
    repo="github.com/JeffreySarnoff/NanosecondDates.jl.git",
    devbranch = "main",
)
