using ObjectivePaths
using Term: install_term_stacktrace
install_term_stacktrace()

f = path("/Users/federicoclaudi/Documents/Github/ObjectivePaths/src")
f2 = path("/Users/federicoclaudi/Documents/Github/ObjectivePaths/nonexist")
p = path("src/types.jl")

# TODO docstrings
# TODO readme
# TODO release

# f / p
# f / "test.md"
# f

println("\n"^10)
println(f)
println(f2)
println(p)

info(f)
