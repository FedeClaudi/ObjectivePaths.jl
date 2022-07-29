
# ---------------------------- paths manipulation ---------------------------- #
function Base.:-(path::AbstractPath, val::Int)
    parts = splitpath(path.path)
    length(parts) <= val && begin
        @warn "Cannot go $(val) steps up from $(path.path)"
        return nothing
    end
    return Folder(joinpath(parts[1:length(parts)-val]))
end




# ---------------------------------- joining --------------------------------- #
Base.:/(p1::AbstractPath, p2::AbstractPath) = path(joinpath(p1.path, p2.path))
Base.:/(p1::AbstractPath, p2::String) = path(joinpath(p1.path, p2))
