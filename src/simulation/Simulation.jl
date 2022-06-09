module Simulation
export start_simulation

using InputParams
using Lattices
using Visualization

using Parameters
using GLMakie
using Formatting


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

    vis_obs, fig = create_visualization(lattice.theta)
    simdata = SimulationData(lattice, sp, consts, 0)

    # for t = 1:sp.max_timesteps
    #     update!(simdata)
    #     if simdata.timestep % sp.vis_timesteps == 0
    #         draw(vis_obs)
    #     end
    # end

    print("T_$(lp.T), timesteps_$(sp.max_timesteps ÷ 1e3)k.mp4")

    record(fig, "T_$(lp.T), timesteps_$(sp.max_timesteps ÷ 1e3)k.mp4", range(1, sp.max_timesteps / sp.vis_timesteps), framerate=15, compression=1) do t
        for i = 1:sp.vis_timesteps
            update!(simdata)
        end
        draw(vis_obs)
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