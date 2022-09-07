function [r v] = star_init(N, m, rlim, r0, v0, vs0)

% FUNCTION: star_init
% Initializes the position and velocity of stars around cores
% ACCEPTS:
%   N: Number of stars
%   m: Array of masses of all particles
%   rlim: Interval of orbital distances stored as a 2-vector
%   r0: Initial position of the cores
%   v0: Initial velocity of the cores
%   vs0: Rotational velocity sense
% RETURNS:
%   r: Position data for the stars
%   v: Velocity data for the stars

    r = zeros(N, 3);
    v = zeros(N, 3);

    radius = linspace(rlim(1), rlim(2), N);
    angle = 2 * pi * rand(1, N);

    for i = 1 : N 
        r(i, 1) = r0(1) + radius(i) * cos(angle(i));
        r(i, 2) = r0(2) + radius(i) * sin(angle(i));
        vi = sqrt(m / radius(i));
        v(i, 1) = v0(1) + vs0 * vi * sin(angle(i));
        v(i, 2) = v0(2) - vs0 * vi * cos(angle(i));
    end
end
