module Lattices
export Lattice, fill_random!, fill_zero!, get_ΔE, set!

using InputParams

"""
    Lattice(nrow, ncol)

A representation of the spins on a two-dimensional lattice with dimensions (nrow, ncol).

Every spin has an angle which must lie in the interval [0, 2 π).

The energy is computed according to the Hamiltonian

    E = - J ∑ s_i ⋅ s_j = - J ∑ cos(θ_i - θ_j)

where the sum runs over nearest neighbors. 
"""
mutable struct Lattice
    params::LatticeParams
    nrow::Integer
    ncol::Integer
    theta::Array{AbstractFloat, 2}
    energy::AbstractFloat
    function Lattice(params::LatticeParams)
        new(params, params.nrow, params.ncol, Array{AbstractFloat, 2}(undef, params.nrow, params.ncol), 0.)
    end
end



function get_energy(lattice::Lattice)
    energy = 0.
    ncol = lattice.ncol
    nrow = lattice.nrow
    for j = 1:ncol
        for i = 1:nrow
            energy += get_spin_energy(lattice, i, j)
        end
    end
    return energy
end

function get_spin_energy(lattice::Lattice, i::Integer, j::Integer)
    return get_spin_energy(lattice, i, j, lattice.theta[i, j])
end

function get_spin_energy(lattice::Lattice, i::Integer, j::Integer, theta::Number)
    energy = 0.
    ncol = lattice.ncol
    nrow = lattice.nrow
    energy -= cos(theta - lattice.theta[mod1(i + 1, nrow), j])
    energy -= cos(theta - lattice.theta[i, mod1(j + 1, ncol)])
    energy -= cos(theta - lattice.theta[mod1(i - 1, nrow), j])
    energy -= cos(theta - lattice.theta[i, mod1(j - 1, ncol)])
    energy *= lattice.params.J
    return energy
end

function get_ΔE(lattice::Lattice, i::Integer, j::Integer, new_theta::Number)
    old_spin_energy = get_spin_energy(lattice, i, j)
    new_spin_energy = get_spin_energy(lattice, i, j, new_theta)
    return 2 * (new_spin_energy - old_spin_energy)
end

function fill_random!(lattice::Lattice)
    lattice.theta = 2 * π * rand(Float64, lattice.nrow, lattice.ncol)
    lattice.energy = get_energy(lattice)
end

function fill_zero!(lattice::Lattice)
    fill!(lattice.theta, 0.)
    lattice.energy = - 4 * lattice.params.J * lattice.ncol * lattice.nrow
end

function set!(lattice::Lattice, i::Integer, j::Integer, new_theta::Number)
    ΔE = get_ΔE(lattice, i, j, new_theta)
    lattice.theta[i, j] = mod(new_theta, 2 * π)
    lattice.energy += ΔE
end

function add!(lattice::Lattice, i::Integer, j::Integer, Δ_theta::Number)
    set!(lattice, i, j, lattice.theta[i, j] + Δ_theta)
end

end