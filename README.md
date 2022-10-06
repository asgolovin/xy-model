# XY Model

A beautiful model from statistical physics that turnes out to be a 2D electron gas if you look closely. 

The [XY model](https://en.wikipedia.org/wiki/Classical_XY_model) is a subtype of [Ising-like models](https://en.wikipedia.org/wiki/N-vector_model). 
Similarly to the Ising model, interacting spins $\vec{s}_i$ are located on a 2D lattice, but instead of having just two binary states, they can rotate in the grid plane. 
Since the length of the spin is fixed, each spin has effectively just one degree of freedom - the angle of rotation $\theta$. 
The spins interact according to the following Hamiltonian:

$$\mathcal{H} = -J \sum_{\braket{i, j}} \vec{s}_i \cdot \vec{s}_j = -J \sum_\braket{i, j} \cos(\theta_i - \theta_j)$$

where $J$ is the coupling constant and the sum goes over the nearest neighbors. 

At high temperatures, as one would expect, chaos prevails. The spins jiggle around randomly and do not try to align with their neighbors very much. 

<div align="center">
<figure>
<img src="videos/T_2.0_-timesteps_1e6.0_-50x40.gif" width="400" />
<br>
<figcaption align = "center">The XY model at high temperatures.</figcaption>
<figure>
</div>

If we go to low temperatures, the coupling between spins becomes more important. Since the Hamiltonian is minimised whenever the neighboring spins point 
in the same direction, we should expect a nice smooth field.

<div align="center">
<figure>
<img src="videos/T_0.1_-timesteps_1e6.0_-50x40.gif" width="400" />
<br>
<figcaption align = "center">The XY model at low temperatures.</figcaption>
<figure>
</div>

The field in general does look very smooth, but there are some points ("vortices") where the field changes rapidly. 
If you follow the arrows around a vortex, you will notice, that they always make a full turn, either clock-wise, or anti-clock-wise. 

It turnes out (pages of phyiscs calculations skipped here), that those vortices act exactly like charged Coulumb particles.
Vortices with opposite winding numbers attract to each other, just like particles with opposite charge, and can even fuse with each other, releasing the energy. 

In other words, the inherently discrete XY model with only local nearest-neighbor interactions behaves similarly to a gas of particles in a continuous world with the long-range Coulumb force. 
The glorious and magnificent XY model!
