function [a] = nbodyacc(m, r, Nc)

% FUNCTION: nbodyacc
% Solves the gravitational N-body problem
% ACCEPTS:
%   m: Array of masses of all particles
%   r: Array of positions of all particles
%   Nc: Number of massive particles (Cores)
% RETURNS:
%   a: Computed N-body gravitational acceleration
    
    N = length(m);
    
    a = nan * ones(N, 3);
    sz = size(r)
    if sz(1) ~= N
        return  % Exits if the sizes are not compatible
    end

    a = zeros(N, 3);
    for i = 1 : N
        for j = 1 : Nc
            if j ~= i
                rij = r(j, :) - r(i, :);
                acc = sqrt(sum(rij .* rij));
                a(i, :) = a(i, :) + m(j) * rij ./ acc^3;
            end
        end
    end
end

