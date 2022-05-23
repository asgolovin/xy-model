include("simulation/simulation.jl")

using InputParams

params = Params(nrow = 100, ncol = 100)
consts = Consts()

start_simulation(params, consts)