module Visualization
export create_visualization, draw

using GLMakie

struct PlotObservables
    theta::Observable
    function PlotObservables(theta::Array{AbstractFloat, 2})
        new(theta)
    end
end

struct GuiObservables
end

function create_visualization(theta::Array{AbstractFloat})
    fig = Figure(); display(fig)
    ax = Axis(fig[1, 1])
    plot_obs = PlotObservables(theta)
end

function draw(plot_obs::PlotObservables)
    GLMakie.heatmap!(plot_obs.theta, colormap = :romaO)
end


end