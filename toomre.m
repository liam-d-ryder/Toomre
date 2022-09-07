% TOOMRE MODEL OF GALAXY COLLISIONS
% Driving script that sets parameters to model a galactic collision.
% Creates a playable AVI format animation of the collision created by the
% parameters as set below


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PARAMETERS
Nc = 2;  % Number of massive gravitational particles
mc = [1 1];  % Mass of the cores
stars = [5000 5000];  % Number of massless particles (Stars)
N = Nc + sum(stars);  % Number of all particles

m = [mc, ones(1, sum(stars))];  % Array of masses of all particles

% Set time interval and dt
tmin = 0;
tmax = 10.0;
dt = 0.004;
t = tmin:dt:tmax;  % Initialize array of times
nt = length(t);
dt = t(2) - t(1);

% Set initial core positions and velocities
rc0 = [[-0.75, -1.12, 0.0]; [0.75, 1.12, 0.0]; [0.0, 0.0, 0.0]];
vc0 = [[0.75, 0.0, 0.0]; [-0.75, 0.0, 0.0]; [0.0, 0.0, 0.0]];

% Set rotation sense for each core (-1 for CW, 1 for CCW)
vsense0 = [-1, 1];

% Set position limits for orbits
rlim = [[0.05, 0.75]; [0.05, 0.75]; [0.05, 0.75] ];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Initialize position grid function
r = zeros(N, 3, nt);
% Initialize velocity grid function
v0 = zeros(N, 3);

% First particle index for each group of stars
sind = zeros(1, Nc+1);
sind(1) = Nc + 1;
for i = 2 : Nc + 1
    sind(i) = sind(i-1) + stars(i-1) ;
end

for i = 1 : Nc
% Initialize position and velocitiy of cores
    r(i,:,1) = rc0(i, :);
    v0(i,:) = vc0(i, :);

% Compute and store star initial positions, velocities
    [rs0, vs0] = star_init(stars(i), mc(i), rlim(i,:), rc0(i,:), ...
    vc0(i,:), vsense0(i));

    r(sind(i):sind(i+1)-1,:,1) = rs0;
    v0(sind(i):sind(i+1)-1,:) = vs0;
end


% Compute accelerations by FDA for all particles
r(:,:,2) = r(:,:,1) + dt * v0 + 0.5 * dt^2 * nbodyacc(m, r(:,:,1), Nc);

for i = 2 : nt - 1
    r(:, :, i+1) = 2 * r(:, :, i) - r(:, :, i-1) + ...
    dt^2 * nbodyacc(m, r(:,:,i), Nc);
end

% Output stride for nbodyout
os = 5;

% Output data for subsequent visualization
nbodyout(t(1:os:nt), r(:,:,1:os:nt), Nc, stars);
