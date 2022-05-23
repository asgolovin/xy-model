module InputParams
export Params, Consts

using Parameters

@with_kw struct Params
    T::Float64 = 1                      # temperature
    J::Float64 = 1.                     # coupling constant
    nrow::Integer                       # number of rows in the lattice
    ncol::Integer                       # number of cols in the lattice
    max_timesteps::Integer = 1e8        # number of timesteps to simulate
    burnin_timesteps::Integer = 1e7     # timesteps which are discarded at the beginning
    vis_timesteps::Integer = 1e3        # timesteps between visualization frames
    print_timesteps::Integer = 1e3      # timesteps between log statements
end

@with_kw struct Consts
    #kB::Float64 = 1.380649e-23    # Boltzmann constant
    kB::Float64 = 1.
end

end