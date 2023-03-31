# Functions for updating the solution at each timestep

# Load functions
include("system.jl")

# Function for estimating the timestep size
function getTimeStep(Q, x, γ, CFL)
    # Number of cells
    imax = size(Q, 2); 
    # Estimate the maximum wave speed
    Smax = 0.0;
    Δx = x[end] - x[1];
    for i = 1:imax
        ai = speedOfSound(Q[:, i], γ);
        ui = Q[2, i] / Q[1, i];
        Smax = max(Smax, abs(ui) + ai);
        Δx = min(Δx, x[i+1] - x[i]);
    end
    
    return CFL * Δx / Smax

end