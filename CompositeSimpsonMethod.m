x = 0:6:84; % x-values from Time (in seconds).
f = [124,134,148,156,147,133,121,109,99,85,78,89,104,116,123]; % Our f(x) values from Speed (in feet/second).

%Some preliminaries
a = x(1); %Lower limit of integral.
b = x(end);%Upper limit of integral.
p = numel(x); % Counts the number of nodes from nodes array.
n = p-1; %Counts the number of subintervals.
R = mod(n,2); %Used to determined if n is even.

%SIMPSON'S RULE STARTS HERE
if R == 0 && n ~= 0

h = (b-a)/n; %Equal length between nodes.
f_x0 = f(1); %This is our f(x0) value. 
f_xn = f(end);%This is our f(xn) value.
Sum1 = sum(f(2:2:end-1)); %Adds all f(xi) values where i is odd and i is from 1 to n-1.
Sum2 = sum(f(3:2:end-2)); %Adds all f(xj) values where j is even and j is from 2 to n-2.

I = (h/3)*(f_x0 + 4*(Sum1) + 2*(Sum2) + f_xn); %Approximates in feet.

Mi = (I)/5280; %Converts feet to miles.

fprintf('The length between nodes is %f.\n',h);
fprintf('The number of subintervals is %f. \n',n);
fprintf('Our approximation for the length of the track is %f mile(s). \n',Mi);

else
    if R ~= 0 %Fail safe in case n is odd.
    disp('Number of n subintervals must be even for Simpsons Rule.')
    disp('Check number of nodes.')
    end 

    disp('Try again.')
end