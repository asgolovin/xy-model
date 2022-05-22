include("../data/params.jl")
include("../data/lattice.jl")

using Parameters

@with_kw mutable struct SimulationData
    lattice::Lattice
    params::Params
    consts::Consts
    timestep::Integer = 0
end

"""
    start(params::Params, consts::Consts)

The function executing the simulation. 
"""
function start_simulation(params::Params, consts::Consts)
    lattice = Lattice(params.nrow, params.ncol)
    fill_random!(lattice)

    simdata = SimulationData(lattice, params, consts, 0)

    for t = 1:params.burnin_timesteps
        update!(simdata)
        #println(lattice.theta)
    end

    for t = params.burnin_timesteps:params.max_timesteps
        update!(simdata)
    end

end

"""
    update(simdata::SimulationData)

Move forward one timestep in the simulation. 
"""
function update!(simdata::SimulationData)
    isaccepted = metropolis!(simdata)
    simdata.timestep += 1
    simdata.timestep % 100000 == 0 && println(simdata.timestep)
end

"""
    metropolis(simdata::SimulationData)

Apply the metropolis algorithm to find a new configuration.

If a new configuration is rejected, the old one is kept. 
Returns true if the new configuration has been accepted, false otherwise. 
"""
function metropolis!(simdata::SimulationData)
    lattice = simdata.lattice
    params = simdata.params
    consts = simdata.consts

    i = rand(1:lattice.nrow)
    j = rand(1:lattice.ncol)
    new_theta = rand() * 2 * π
    ΔE = get_ΔE(lattice, i, j, new_theta)
    if rand() < exp(-ΔE / (params.T * consts.kB))
        # accept
        set!(lattice, i, j, new_theta)
        return true
    else
        # reject
        return false
    end
end