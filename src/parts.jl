"""
    name(dir::AbstractPath)

Get name (last part) of a path.
"""
name(dir::AbstractPath) = splitpath(dir.path)[end]
name(dir::String) = splitpath(dir)[end]

"""
    base(p::AbstractPath) 

Get the base (dirname) of a path.

Similar to `dirname(p)` but returns a `Folder` object instead of a `String`.
"""
base(p::AbstractPath) = path(dirname(p))

"""
    f::File)

Get the extension of a file. 

Returns an empty string for a folder.
"""
extension(f::File) = splitext(f)[end]
extension(f::Folder) = ""

"""
    parent(path::AbstractPath)

Get the folder one level up in the hierarchy of a path.
"""
Base.parent(path::AbstractPath) = path - 1

"""
    split(path::AbstractPath)::Tuple{AbstractPath,String}

Split a path into its base and its name.
"""
Base.split(path::AbstractPath)::Tuple{AbstractPath,String} = base(path), name(path)
