
# ---------------------------- paths manipulation ---------------------------- #
"""
    -(path::AbstractPath, val::Int)

Move `val` levels up in the paths hierarchy.
"""
function Base.:-(path::AbstractPath, val::Int)
    parts = splitpath(path.path)
    length(parts) <= val && begin
        @warn "Cannot go $(val) steps up from $(path.path)"
        return nothing
    end
    return Folder(joinpath(parts[1:(length(parts) - val)]))
end

# ---------------------------------- joining --------------------------------- #
"""
    /(p1::AbstractPath, p2::AbstractPath)

Concatenate paths.
"""
Base.:/(p1::AbstractPath, p2::AbstractPath) = path(joinpath(p1.path, p2.path))
Base.:/(p1::AbstractPath, p2::String) = path(joinpath(p1.path, p2))
