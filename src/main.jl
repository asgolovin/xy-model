for (root, dirs, _) in walkdir("src")
    for dir in dirs
        push!(LOAD_PATH, joinpath(pwd(), root, dir))
    end
end

using InputParams
using Simulation

lparams = LatticeParams()
sparams = SimulationParams()
consts = Consts()

start_simulation(lparams, sparams, consts)