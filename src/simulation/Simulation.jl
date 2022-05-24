module Simulation
export start_simulation

using InputParams
using Lattices

using Parameters
using GLMakie


@with_kw mutable struct SimulationData
    lattice::Lattice
    sparams::SimulationParams
    consts::Consts
    timestep::Integer = 0
end

"""
    start_simulation(params::Params, consts::Consts)

The function executing the simulation.
"""
function start_simulation(lp::LatticeParams, sp::SimulationParams, consts::Consts)
    lattice = Lattice(lp)
    fill_random!(lattice)

    obs_theta = Observable(lattice.theta)

    fig = Figure(); display(fig)
    ax = Axis(fig[1, 1])

    simdata = SimulationData(lattice, sp, consts, 0)

    for t = 1:sp.burnin_timesteps
        update!(simdata)
        if simdata.timestep % sp.vis_timesteps == 0
            GLMakie.heatmap!(obs_theta, colormap = :romaO)
        end
    end

    for t = sp.burnin_timesteps:sp.max_timesteps
        update!(simdata)
        if simdata.timestep % sp.vis_timesteps == 0
            GLMakie.heatmap!(obs_theta, colormap = :romaO)
        end
    end
end

"""
    update(simdata::SimulationData)

Move forward one timestep in the simulation. 
"""
function update!(simdata::SimulationData)
    isaccepted = metropolis!(simdata)
    simdata.timestep += 1
    simdata.timestep % simdata.sparams.print_timesteps == 0 && println(simdata.timestep)
end

"""
    metropolis(simdata::SimulationData)

Apply the metropolis algorithm to find a new configuration.

If a new configuration is rejected, the old one is kept. 
Returns true if the new configuration has been accepted, false otherwise. 
"""
function metropolis!(simdata::SimulationData)
    lattice = simdata.lattice
    params = lattice.params
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

end