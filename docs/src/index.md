```@meta
CurrentModule = ObjectivePaths
```

# ObjectivePaths
ObjectivePaths is a small Julia library aiming to make a few operations around handling paths to folders and files easier. It's a small wrapper around Base's [file system](https://docs.julialang.org/en/v1/base/file/) applying some ideas from Python's [pathlib](https://docs.python.org/3/library/pathlib.html) library, in a Julian way.

## AbstractPath, Folder & File
The first thing you need is to craete pointers to paths (folders/files). This is done by calling the `path` function on a string with a filepath:

```example op
import ObjectivePath: path

current_folder = pwd()  # path to current folder
path(current_folder)    # create a Folder type
```

As you can see, calling `path` on a string pointing to a file create a `Folder` type. If, instead, you are using a file:


```example op
using ObjectivePath

afile = readdir(current_folder; join=true)[1]  # get first file in current path(afile)
```

this creates a `File`. These are the two subtypes of `AbstractPath`. There's a few methods for `AbstractPath`s which can make your life easier, starting from printing nicely formatted info as shown above. But you can do more

```example op
fld = path(current_folder)  # Folder object

exists(fld) |> print  # true if folder exists
nfiles(fld) |> print  # number of files in folder
name(fld) |> print    # name of folder (last part of the path)

# also mose Base methods are available for AbstractPaths
split(fld) |> print   # split path into base/name
```

### Folder-specific methods
With `Folder` objects you can do a few more, starting from viewing more info (or use `tree` to just print out the folder structure):

```example op
info(fld)
```

Or get the files/subfolders in your folder
```example op
println("Subfolders in folder:")
subdirs(fld) |> print

println("Files in folder's parent:")
files(parent(fld)) |> print  # parent goes up one level
```


## Manipulating paths
One of the things that can be a bit annoying is manipulating paths. Normally, you'd create a `String` with the path you need, or you combine things like `splitpath` and `joinpath` to create a path. Not fun. 
We can make things a bit easier.

```example op
# say you want to get access to a folder 2 levels up the current one
fld - 2  # done
```

Yep, that's it.
But what if you want to create a new folder in there? Need to split, join paths or something? Nope
    
```example op

newfld = (fld - 2) / "new_folder_that_doesnt_exist_yet"  # point to new folder

```

and then you can use `mkdir` or `mkpath` as you would normally, neat.


## Coda
That's it for now. But if you have issues, or questions or ideas for new improvements, get in touch on Github!