module ObjectivePaths

using Term
using Term.Layout
using Term.Tables
import Term: Theme, set_theme
import Term.Trees: Tree
import OrderedCollections:  OrderedDict

include("types.jl")
include("utils.jl")
include("operations.jl")
include("parts.jl")

const is_win = Sys.iswindows()

export Folder, File, path, info, tree
export name, exists, nfiles, base

end
