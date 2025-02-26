using UnfoldSim
using Documenter
using Glob
using Literate


GENERATED = joinpath(@__DIR__, "src", "generated")
SOURCE = joinpath(@__DIR__, "literate")

for subfolder ∈ ["explanations","HowTo","tutorials","reference"]
    local SOURCE_FILES = Glob.glob(subfolder*"/*.jl", SOURCE)
    #config=Dict(:repo_root_path=>"https://github.com/unfoldtoolbox/UnfoldSim")
    foreach(fn -> Literate.markdown(fn, GENERATED*"/"*subfolder), SOURCE_FILES)

end


DocMeta.setdocmeta!(UnfoldSim, :DocTestSetup, :(using UnfoldSim); recursive=true)

makedocs(;
    modules=[UnfoldSim],
authors="Luis Lips, Benedikt Ehinger, Judith Schepers",
    repo="https://github.com/unfoldtoolbox/UnfoldSim.jl/blob/{commit}{path}#{line}",
    sitename="UnfoldSim.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://unfoldtoolbox.github.io/UnfoldSim.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
        "Tutorials"=>[
                "Quickstart" => "generated/tutorials/quickstart.md",
                "Simulate ERPs" => "generated/tutorials/simulateERP.md",
                "Poweranalysis" => "generated/tutorials/poweranalysis.md",
        ],
        "Reference"=>[
                "Toolbox Overview" =>"./generated/reference/overview.md",
                "NoiseTypes" =>      "./generated/reference/noisetypes.md",
                "ComponentBasisTypes" => "./generated/reference/basistypes.md",
        ],
        "HowTo" => [
                "New Experimental Design" => "./generated/HowTo/newDesign.md",
                "Repeating Trials within a Design" => "./generated/HowTo/repeatTrials.md",
                "New Duration/Shift-dependent Component" => "./generated/HowTo/newComponent.md",
                "Multi Channel Data" =>"./generated/HowTo/multichannel.md",
        ],
        "DocStrings" => "api.md",
    ],
)

deploydocs(;
    repo="github.com/unfoldtoolbox/UnfoldSim.jl",
    devbranch="main",
)
