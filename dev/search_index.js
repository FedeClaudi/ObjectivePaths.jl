var documenterSearchIndex = {"docs":
[{"location":"library/#Library","page":"library","title":"Library","text":"","category":"section"},{"location":"library/","page":"library","title":"library","text":"List of all types and methods in the library","category":"page"},{"location":"library/","page":"library","title":"library","text":"CurrentModule = ObjectivePaths","category":"page"},{"location":"library/","page":"library","title":"library","text":"Pages   = [\"library.md\"]","category":"page"},{"location":"library/","page":"library","title":"library","text":"Modules = [ObjectivePaths]","category":"page"},{"location":"library/#ObjectivePaths.get_file_format-Tuple{Int64}","page":"library","title":"ObjectivePaths.get_file_format","text":"getfileformat(nbytes; suffix=\"B\") Return a string with formatted file size.\n\n\n\n\n\n","category":"method"},{"location":"","page":"Home","title":"Home","text":"CurrentModule = ObjectivePaths","category":"page"},{"location":"#ObjectivePaths","page":"Home","title":"ObjectivePaths","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"ObjectivePaths is a small Julia library aiming to make a few operations around handling paths to folders and files easier. It's a small wrapper around Base's file system applying some ideas from Python's pathlib library, in a Julian way.","category":"page"},{"location":"#AbstractPath,-Folder-and-File","page":"Home","title":"AbstractPath, Folder & File","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"The first thing you need is to craete pointers to paths (folders/files). This is done by calling the path function on a string with a filepath:","category":"page"},{"location":"","page":"Home","title":"Home","text":"using ObjectivePaths\n\ncurrent_folder = pwd()  # path to current folder\npath(current_folder)    # create a Folder type","category":"page"},{"location":"","page":"Home","title":"Home","text":"As you can see, calling path on a string pointing to a file create a Folder type. If, instead, you are using a file:","category":"page"},{"location":"","page":"Home","title":"Home","text":"parent_content = readdir(parent(path(current_folder)); join=true) # get content of parent folder\nfiles_paths = filter(isfile, parent_content)                     # get only files\npath(files_paths[1])  # pointer to a file","category":"page"},{"location":"","page":"Home","title":"Home","text":"this creates a File. These are the two subtypes of AbstractPath. There's a few methods for AbstractPaths which can make your life easier, starting from printing nicely formatted info as shown above. But you can do more","category":"page"},{"location":"","page":"Home","title":"Home","text":"fld = path(current_folder)  # Folder object\n\nexists(fld) |> print  # true if folder exists\nnfiles(fld) |> print  # number of files in folder\nname(fld) |> print    # name of folder (last part of the path)\n\n# also mose Base methods are available for AbstractPaths\nsplit(fld) |> print   # split path into base/name","category":"page"},{"location":"#Folder-specific-methods","page":"Home","title":"Folder-specific methods","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"With Folder objects you can do a few more, starting from viewing more info (or use tree to just print out the folder structure):","category":"page"},{"location":"","page":"Home","title":"Home","text":"info(fld)","category":"page"},{"location":"","page":"Home","title":"Home","text":"Or get the files/subfolders in your folder","category":"page"},{"location":"","page":"Home","title":"Home","text":"println(\"Subfolders in folder:\")\nsubdirs(fld) |> print\n\nprintln(\"Files in folder's parent:\")\nfiles(parent(fld)) |> print  # parent goes up one level","category":"page"},{"location":"#Manipulating-paths","page":"Home","title":"Manipulating paths","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"One of the things that can be a bit annoying is manipulating paths. Normally, you'd create a String with the path you need, or you combine things like splitpath and joinpath to create a path. Not fun.  We can make things a bit easier.","category":"page"},{"location":"","page":"Home","title":"Home","text":"# say you want to get access to a folder 2 levels up the current one\nfld - 2  # done","category":"page"},{"location":"","page":"Home","title":"Home","text":"Yep, that's it. But what if you want to create a new folder in there? Need to split, join paths or something? Nope","category":"page"},{"location":"","page":"Home","title":"Home","text":"\nnewfld = (fld - 2) / \"new_folder_that_doesnt_exist_yet\"  # point to new folder\n","category":"page"},{"location":"","page":"Home","title":"Home","text":"and then you can use mkdir or mkpath as you would normally, neat.","category":"page"},{"location":"#Coda","page":"Home","title":"Coda","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"That's it for now. But if you have issues, or questions or ideas for new improvements, get in touch on Github!","category":"page"},{"location":"","page":"Home","title":"Home","text":"Also, please consider supporting my work if you find it valuable!","category":"page"},{"location":"","page":"Home","title":"Home","text":"(Image: ko-fi)","category":"page"}]
}