module InputParams
export LatticeParams, SimulationParams, Consts

using Parameters

@with_kw struct LatticeParams
    T::Float64                = 1                      # temperature
    J::Float64                = 1.                     # coupling constant
    nrow::Integer             = 50                 # number of rows in the lattice
    ncol::Integer             = 50                 # number of cols in the lattice
end
@with_kw struct SimulationParams
    max_timesteps::Integer    = 1e6        # number of timesteps to simulate
    burnin_timesteps::Integer = 1e3     # timesteps which are discarded at the beginning
    vis_timesteps::Integer    = 1e4        # timesteps between visualization frames
    print_timesteps::Integer  = 1e4      # timesteps between log statements
end

@with_kw struct Consts
    #kB::Float64 = 1.380649e-23    # Boltzmann constant
    kB::Float64 = 1.
end

end