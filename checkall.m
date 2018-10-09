% Matlab code
% Implement an algorithm to check all extreme points
% to find optimal solution

% define the standard form problem
% min c'x
% Ax = b
% x >= 0
A = [1 1 1 0 0; 1 0 0 1 0; 0 1 0 0 1]; %A matrix
b = [1;1;1]; %right-hand side matrix
c = [1;1;1;1;1]; %objective function

% parameters
m = size(A, 1);
n = size(A, 2);

% all posible basic partition beta and eta of A
beta = combnk(1:n, m);
eta = zeros(size(beta,1), n-m);
for j = 1:size(eta,1)
    eta(j,:) = setdiff(1:n, beta(j,:));
end


% keep track of all the x_beta, x and objective value
% colomns are x(i)
x_beta = zeros(m, size(beta,1));
x = zeros(n, size(beta,1));
objective = zeros(1, size(beta,1));

for i = 1:size(beta, 1)
    % all possible basis matrix
    A_beta = A(:, beta(i, :));
    if det(A_beta) == 0
        % can't form basis
        continue;
    end
    
    % basis matrix - calculate x_beta and x
    x_beta(:,i) = A_beta\b;
    if x_beta(:,i) >= 0
        %construct x from x_beta
        x(eta(i,:),i) = 0;
        for k = 1:m
            x(beta(i,k),i) = x_beta(k,i);
        end
        %calculate objective value
        objective(i) = c' * x(:,i);
    end
end 

% compare all objectives
[optimal_obj, optimal_idx] = max(objective);
optimal_x = x(:, optimal_idx);


