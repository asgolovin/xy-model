struct Params
    T::AbstractFloat     # temperature
    J::AbstractFloat     # coupling constant
    nrow::Integer        # number of rows in the lattice
    ncol::Integer        # number of cols in the lattice
end

struct Consts
    kB = 1.380649e-23    # Boltzmann constant
end