using ObjectivePaths
using Test

@testset "Folder" begin
    fld = pwd()
    @info "Test - folder: $fld"

    fold = path(fld)
    @test typeof(fold) == Folder
    @test exists(fold) == true
    @test name(fold) == splitpath(fld)[end]

    @test parent(fold) == base(fold)
    @test parent(fold) == fold - 1


    # test a non existing folder
    ne = fold / "asafisufhsndfnssfnais"
    @test ne isa Folder
    @test exists(ne) == false
end

@testset "Folder utils" begin
    fld = path(pwd())
    fls = files(fld)
    @test typeof(fls) == Vector{File}
    @test nfiles(fld) == length(fls)

    subs = subdirs(fld - 1)
    @test typeof(subs) == Vector{Folder}
end

@testset "Folder info_print" begin
    fld = path(pwd())
    tree(fld)
    info(fld)
    print(fld)
end

@testset "File" begin
    fl = files(path(pwd()))[1]
    @test typeof(fl) == File
    @test exists(fl) == true
end

@testset "File print" begin
    fl = files(path(pwd()))[1]
    print(fl)
end
