"""
    Lattice(nrow, ncol)

A representation of the spins on a two-dimensional lattice with dimensions (nrow, ncol).

Every spin has an angle which must lie in the interval [0, 2 π).
"""
mutable struct Lattice
    nrow::Integer
    ncol::Integer
    theta::Array{Float32, 2}
    function Lattice(nrow::Integer, ncol::Integer)
        new(nrow, ncol, Array{Float32, 2}(undef, nrow, ncol));
    end
end

function fill_random!(lattice::Lattice)
    lattice.theta = 2 * π * rand(Float32, lattice.nrow, lattice.ncol)
end

function fill_zero!(lattice::Lattice)
    fill!(lattice.theta, 0.)
end

function set!(lattice::Lattice, i::Integer, j::Integer, value::Number)
    lattice.theta[i, j] = mod(value, 2 * π)
end

function add!(lattice::Lattice, i::Integer, j::Integer, dtheta::Number)
    lattice.theta[i, j] = mod(lattice.theta[i, j] + dtheta, 2 * π)
end