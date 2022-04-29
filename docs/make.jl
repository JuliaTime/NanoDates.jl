
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
        "Guide" => Any[
            "Construction" => "use/construction.md",
            "As a string" => "use/intostring.md",
        ],
    ]
)

#=
Deploy docs to Github pages.
=#
Documenter.deploydocs(
    branch = "gh-pages",
    latest = "main",
    target = "build",
    deps = nothing,
    make = nothing,
    repo = "github.com/JeffreySarnoff/NanoDates.jl.git",
)

