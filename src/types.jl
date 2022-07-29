abstract type AbstractPath end

struct Folder <: AbstractPath
    path::String
end

struct File <: AbstractPath
    path::String
end

function path(p::String)
    # if it doesn't point to an existing path, infer folder/file from name
    if ispath(p)
        return if isfile(p)
            File(p)
        else
            Folder(p)
        end
    else
        _name = splitpath(p)[end]
        return if occursin(".", _name)
            File(p)
        else
            Folder(p)
        end
    end
end

# ----------------------------------- repr ----------------------------------- #

title(f::Folder) = "📁 folder:"
title(f::File) = "📄 file:"

function repr_info(p::Folder)
    _exists = exists(p) ? "{bold green}✔{/bold green}" : "{dim red}✖{/dim red}"
    _nfiles = exists(p) ? "# files: {bright_blue}$(nfiles(p)){/bright_blue}" : ""
    "{dim}exists: $_exists | $_nfiles{/dim}"
end

function repr_info(p::File)
    _exists = exists(p) ? "{bold green}✔{/bold green}" : "{dim red}✖{/dim red}"
    _size = get_file_format(filesize(p.path))
    _size_info = exists(p) ? "# size: {bright_blue}$_size{/bright_blue}" : ""
    "{dim}exists: $_exists | $_size_info{/dim}"
end

function Base.print(io::IO, p::AbstractPath)
    path = RenderableText(
        "{bright_blue}$(title(p)){/bright_blue} {italic}" *
        highlight_path(p.path) *
        "{italic}";
        style = "bold white",
    )
    print(io, path / hLine(path; box = :HEAVY, style = "black") / repr_info(p))
end

Base.show(io::IO, ::MIME"text/plain", p::AbstractPath) = print(io, p)

# ------------------------------- Base methods ------------------------------- #
Base.splitpath(p::AbstractPath) = splitpath(p.path)
Base.isfile(f::Folder) = false
Base.isfile(f::File) = true
Base.ispath(p::AbstractPath) = ispath(p.path)
Base.isdir(f::Folder) = true
Base.isdir(f::File) = false
Base.dirname(p::AbstractPath) = dirname(p.path)
Base.splitext(p::AbstractPath) = splitext(p.path)
Base.mkdir(f::Folder; kwargs...) = mkdir(f.path; kwargs...)
Base.mkpath(f::Folder; kwargs...) = mkpath(f.path; kwargs...)
Base.cp(source::AbstractPath, dest::AbstractPath; kwargs...) =
    cp(source.path, dest.path; kwargs...)
Base.cp(source::String, dest::AbstractPath; kwargs...) = cp(source, dest.path; kwargs...)
Base.cp(source::AbstractPath, dest::String; kwargs...) = cp(source.path, dest; kwargs...)
Base.mv(source::AbstractPath, dest::AbstractPath; kwargs...) =
    mv(source.path, dest.path; kwargs...)
Base.mv(source::String, dest::AbstractPath; kwargs...) = mv(source, dest.path; kwargs...)
Base.mv(source::AbstractPath, dest::String; kwargs...) = mv(source.path, dest; kwargs...)
Base.rm(p::AbstractPath; kwargs...) = rm(p.path; kwargs...)
Base.readdir(f::Folder; kwargs...) = readdir(f.path; kwargs...)

# ---------------------------------------------------------------------------- #
#                                     info                                     #
# ---------------------------------------------------------------------------- #
function info(f::Folder)
    path =
        RenderableText(title(f) * highlight_path(f.path) * "{italic}"; style = "bold white")
    path /= hLine(path; box = :HEAVY, style = "black")

    if !exists(f)
        content = Panel(
            rvstack(path, "{dim}  does not exist yet{/dim}", pad = 1);
            padding = (5, 5, 1, 1),
            style = "dim blue",
        )
    else
        # ----------------------------------- tree ----------------------------------- #
        folder_tree = "" / tree(f.path)

        # ----------------------------------- table ---------------------------------- #
        properties = ["exists", "# files"]
        values = [exists(f) ? "{green}yes{/green}" : "{red}no{/red}", nfiles(f)]

        tb = Panel(
            Table(
                OrderedDict("" => properties, :value => string.(values)),
                columns_justify = [:right, :center],
                header_justify = [:right, :center],
                header_style = "#f59d5b",
                columns_style = ["#f2c56b", "bold"],
                box = :SIMPLE_HEAD,
            );
            box = :SQUARE,
            style = "dim",
            title = "properties",
            title_style = "default bright_blue",
        )

        content = Panel(
            cvstack(path, (folder_tree * Spacer(folder_tree.measure.h, 5) * tb); pad = 1);
            padding = (5, 5, 1, 1),
            style = "dim blue",
        )
    end
    print(content)
end
