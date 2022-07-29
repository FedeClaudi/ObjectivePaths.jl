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
        assets = String[],
    ),
    pages = ["Home" => "index.md"],
)
