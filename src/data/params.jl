using Parameters

@with_kw struct Params
    T::Float64 = 1.              # temperature
    J::Float64 = 1.              # coupling constant
    nrow::Integer                # number of rows in the lattice
    ncol::Integer                # number of cols in the lattice
    max_timesteps::Integer = 1e6    # number of timesteps to simulate
    burnin_timesteps::Integer = 20000    # timesteps which are discarded at the beginning
end

@with_kw struct Consts
    kB::Float64 = 1.380649e-23    # Boltzmann constant
end