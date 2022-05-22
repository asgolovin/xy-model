include("data/lattice.jl")
include("data/params.jl")
include("simulation/simulator.jl")

params = Params(nrow = 100, ncol = 100)
consts = Consts()

start_simulation(params, consts)