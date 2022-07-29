using ObjectivePaths
using Documenter

DocMeta.setdocmeta!(
    ObjectivePaths,
    :DocTestSetup,
    :(using ObjectivePaths);
    recursive = true,
)

makedocs(;
    modules = [ObjectivePaths],
    authors = "FedeClaudi <federicoclaudi@protonmail.com> and contributors",
    repo = "https://github.com/FedeClaudi/ObjectivePaths.jl/blob/{commit}{path}#{line}",
    sitename = "ObjectivePaths.jl",
    format = Documenter.HTML(;
        prettyurls = get(ENV, "CI", "false") == "true",
        canonical = "https://FedeClaudi.github.io/ObjectivePaths.jl",
        assets = String[],
        collapselevel = 1,
    ),
    strict=false,
    pages = ["Home" => "index.md"],
)

deploydocs(; repo = "github.com/FedeClaudi/ObjectivePaths.jl")
