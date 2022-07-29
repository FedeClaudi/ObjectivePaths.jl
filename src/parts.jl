name(dir::AbstractPath) = splitpath(dir.path)[end]
name(dir::String) = splitpath(dir)[end]

base(p::AbstractPath) = path(dirname(p))

extension(f::Folder) = ""
extension(f::File) = splitext(f)[end]

Base.parent(path::AbstractPath) = path - 1
Base.split(path::AbstractPath)::Tuple{AbstractPath,String} = base(path), name(path)
