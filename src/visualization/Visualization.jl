module Visualization
export create_visualization, draw

using GLMakie

struct PlotObservables
    theta::Observable
    xs::AbstractVector
    ys::AbstractVector
    function PlotObservables(theta::Array{AbstractFloat, 2})
        new(theta, range(1, size(theta, 1)), range(1, size(theta, 2)))
    end
end

struct GuiObservables
end

function create_visualization(theta::Array{AbstractFloat})
    fig = Figure(); display(fig)
    ax = Axis(fig[1, 1])
    plot_obs = PlotObservables(theta)

    width = size(theta, 1)
    height = size(theta, 2)
    xlims!(ax, 0.5, width - 0.5)
    ylims!(ax, 0.5, height - 0.5)
    ax.aspect = AxisAspect(width / height)
    hm = GLMakie.heatmap!(plot_obs.theta[], colormap = :romaO, colorrange = (0, 2*π))
    Colorbar(fig[1, 2], hm, ticks = MultiplesTicks(4, π, "π"))
    return plot_obs, fig
end

function draw(plot_obs::PlotObservables)
    GLMakie.heatmap!(plot_obs.theta[], colormap = :romaO, colorrange = (0, 2*π))
    GLMakie.arrows!(plot_obs.xs,
                    plot_obs.ys,
                    cos.(plot_obs.theta[]),
                    sin.(plot_obs.theta[]),
                    lengthscale = 0.8,
                    align = :center)
end


end