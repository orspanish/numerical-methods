%The following finds the root of the function using the Secant Method:

% This is our dA/dr function in terms of x.
f = @(x) -2000./(x.^2) - 500./(pi*x.^3) + 4*pi*(x+0.25);

%The following are the initial approximations, manually inputted.
x0 = input('Enter the 1st approximation:');
    if x0 == 0
        disp(['This is not a valid approximation. The can cannot have a ' ...
            'radius of 0.'])
        return
    end

x1 = input('Enter the 2nd approximation:');
    if x1 < x0
        disp(['The second approximation must be greater than the first ' ...
            'approximation in order to constitute an ordered interval.'])
        return
    end

err = abs(x1 - x0); %This is the error formula.
i = 0; % i represents the number of iterations. It is set to zero before
       % the while-loop takes place.

% Our error is 10^-4. The while-loop will continue once error is no longer
% greater than 10^-4. In other words, once our error, after some number of
% iterations, is less than 10^-4, the while-loop will end. This prevents an
% infinite loop.
while err > 0.0001
    f0 = f(x0); % Calculating the value of the function at x0
    f1 = f(x1); % Calculating the value of the function at x1
    x2 = x1 - (f1 * (x1 - x0) / (f1 - f0)); %Secant method formula.
    x0 = x1; % Reassigns variable x0 for next iteration.
    x1 = x2; % Reassigns variable x1 for next iteration.
    err = abs(x1 - x0); % The error of i iteration.
    i = i +1; % Counts the number of iterations.
    fprintf('This is iteration %d. \n', i);
    fprintf('Our approximation is %f. \n', x2);
end

% For the following, the value of x2 from our while-loop is our raduis r:
% Using x2, we can find height of the can using volume formula.
h = 1000 / (pi*(x2^2));

% Using x2, we can find surface area of the can.
s_a = (2*pi*x2*h) + 2*pi*(x2^2);

% Using x2, we can find the cost of the can.
cost = 0.005*s_a;

fprintf('The radius of the can (root of function) is %f cm. \n', x2);
fprintf('It took our method %d iterations to find the root. \n', i);
fprintf('The height of the can is %f cm. \n', h);
fprintf('The surface area of the can is %f cm^2. \n', s_a);
fprintf('It costs $%.2f to make one can. \n', cost);