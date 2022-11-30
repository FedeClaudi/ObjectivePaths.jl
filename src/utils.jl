# ---------------------------------------------------------------------------- #
#                                   on paths                                   #
# ---------------------------------------------------------------------------- #
"""
    exists(path::AbstractPath)

Check if an object exists at the target path
"""
exists(path::AbstractPath) = ispath(path.path)
exists(path::String) = ispath(path)

"""
    nfiles(f::Folder)

Get the number of files in a folder
"""
nfiles(f::Folder) = exists(f) ? length(readdir(f.path)) : nothing
nfiles(f::String) = isdir(f) ? length(readdir(f)) : nothing
nfiles(f::File) = nothing

# ---------------------------------------------------------------------------- #
#                                   contents                                   #
# ---------------------------------------------------------------------------- #
"""
    files(f::Folder)::Vector{File}

Get all files in a folder (without recursion)
"""
files(f::Folder)::Vector{File} =
    exists(f) ? path.(filter(isfile, readdir(f; join = true))) : []

"""
    subdirs(f::Folder)::Vector{Folder}

Get all subfolders in a folder (without recursion)
"""
subdirs(f::Folder)::Vector{Folder} =
    exists(f) ? path.(filter(isdir, readdir(f; join = true))) : []

# ---------------------------------------------------------------------------- #
#                                    visuals                                   #
# ---------------------------------------------------------------------------- #
"""
    highlight_path(path::String)

Add Term's markup syntax to highlights parts of a path.
"""
function highlight_path(path::String)
    parts = splitpath(path)
    parts[end] = "{bold white}$(parts[end]){/bold white}"
    join(parts, "{bright_blue} > {/bright_blue}")
end

"""
  get_file_format(nbytes; suffix="B")
Return a string with formatted file size.
"""
function get_file_format(nbytes::Int; suffix = "B")
    for unit in ("", "K", "M", "G", "T", "P", "E", "Z", "Y")
        nbytes < 1024 && return string(round(nbytes; digits = 2), ' ', unit, suffix)
        nbytes = nbytes / 1024
    end
end

# ---------------------------------------------------------------------------- #
#                                 FOLDERS TREE                                 #
# ---------------------------------------------------------------------------- #
op_theme = Theme(
    tree_title = "bold white",
    tree_node = "bold blue",
    tree_guide = "dim #6488f5",
    tree_max_width = 240,
)
set_theme(op_theme)

"""
    _tree(dir::String)::OrderedDict

Construct a dictionary storing files/subsfolders hierarchy form a directory.

Calls itself recursively to handle subfolders.
"""
function _tree(dir::String)::OrderedDict
    tree_data = OrderedDict{String,Any}("files" => [])
    for item in readdir(dir)
        startswith(item, '.') && continue
        path = joinpath(dir, item)
        if isdir(path)
            tree_data["📁 " * item] = _tree(path)
        else
            item, ext = splitext(item)
            ext = "{bold dim}$ext{bold dim}"
            length(tree_data["files"]) < 20 &&
                push!(tree_data["files"], nothing => "{white}$(item)$(ext){/white}")
            length(tree_data["files"]) == 20 && push!(
                tree_data["files"],
                nothing => "{white} ... files omitted ... {/white}",
            )
        end
    end
    tree_data
end

"""
    tree(dir::String)::Tree

Construct a term Tree with a folder's content.
"""
function tree(dir::String)::Tree
    return Tree(_tree(dir); title = "{bright_blue}$(name(dir)){bright_blue}")
end

tree(f::Folder) = tree(f.path)
