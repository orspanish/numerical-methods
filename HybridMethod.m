%The following finds the root of the function using a hybrid method of
%Secant and Bisection:

% This is our dA/dr function in terms of x.
f = @(x) -2000./(x.^2) - 500./(pi*x.^3) + 4*pi*(x+0.25);

%This is where the user inputs the intial interval [a,b].
disp('Enter an interval from a to b.')
a = input('Enter the 1st endpoint:');
    if a == 0
        disp(['This is not a valid approximation. The can cannot have a ' ...
            'radius of 0.'])
        return
    end
b = input('Enter the 2nd endpoint:');
    if b < a
        disp(['The second approximation must be greater than the first ' ...
            'approximation in order to constitute an ordered interval.'])
        return
    end

%Conditions to use our hybrid method. 
%(1) and (2) check if root is within the intial interval. If not, (1) will
%display error message and stop the program. If root is within intial 
% interval,(2) will find root using the hybrid method.

%(1)
if f(a) * f(b) > 0
    disp('Root is not in intveral.')
    disp('Try again.')

%(2) Hybrid method starts here. 
elseif f(a) * f(b) < 0
    
    err = abs(b - a); %This is the error formula.
    i = 0;% i represents the number of iterations. It is set to zero before
          % the while-loop takes place.

% Our error is 10^-4. The while-loop will continue once error is no longer
% greater than 10^-4. In other words, once our error, after some number of
% iterations, is less than 10^-4, the while-loop will end. This prevents an
% infinite loop.
    while err > 0.0001 % Our error is 10^-4. Loop starts here.

    f0 = f(a); %Calculating the value of the function at a.
    f1 = f(b); %Calculating the value of the function at b.
    C = b - (f1 * (b - a) / (f1 - f0)); %Secant method formula.
    a = b;  %Reassigns variable a to find error.
    b = C;  %Reassigns variable b to find error.
   
    % After doing the Secant method, if either of the conditions below are 
    % met, it means C is not within the intial interval. So, the value of C
    % will be determined using the Bisection method.
    if C < a || C > b 
        C = (.5)*(a+b); %Bisection method formula.
    end 
    err = abs(b - a); %The error of i iteration.
    i = i +1; %Counts the number of iterations.

    %The following determines the new interval used for the next iteration.
    if f(a)*f(C) < 0
        b = C; %If true, the new interval [a,b] is [a,C].
    elseif f(b)*f(C) < 0 
        a = C; % If true, the new interval [a,b] is [C,b].
    end 

    fprintf('This is iteration %d. \n', i);
    fprintf('Our approximation is %f. \n', C);
    end % Our hybrid method ends here once root if found.
    
% For the following, the value of C from our while-loop is our raduis r:    
% Find height of the can using volume formula.
h = 1000 / (pi * (C^2));

% Find surface area of the can.
s_a = (2 * pi * C * h) + 2 * pi * (C^2);

% Find cost of the can.
cost = 0.005 * s_a;

fprintf('The radius of the can (root of function) is %f cm.\n', C);
fprintf('It took our method %d iterations to find the root.\n', i);
fprintf('The height of the can is %f cm.\n', h);
fprintf('The surface area of the can is %f cm^2.\n', s_a);
fprintf('It costs $%.2f to make one can.\n', cost);
end