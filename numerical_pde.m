clear all;
clc;

% Parameter values 
L=1; % Depth of pond
C=0.5; % Heating rate
T0=60; % Water temp at pond surface

% Setting up the (x,t) domain & gridsizes
a=0; b=1; % The endpoints of the x interval [0,1]
tInit=0; tFinal=1; % Time interval for which we want to solve the PDE
h=0.1; 
k=0.005;
r=k/(h^2);

% Setting up the table to store the values of u
NumCols = ((b-a)/h);  % Number of columns in the table  
NumRows=((tFinal-tInit)/k)+1;  % Number of rows in the table
u=zeros(NumRows,NumCols);

% Left boundary Condition
%u(:,1)=T0;  This is already incorporated into F

% Initial condition
for i=1:NumCols
    u(1,i)=T0*exp(-2*i*h);
end

% Set up tridiagonal matrix A
n=NumCols;
A=zeros(n,n);
c=2+2*r;
d=-r;
A = diag(c*ones(1,n)) + diag(d*ones(1,n-1),1) + diag(d*ones(1,n-1),-1);
A(n,n-1)=-2*r;

% Set up tridiagonal matrix B
B=zeros(n,n);
e=2-2*r;
B = diag(e*ones(1,n)) + diag(r*ones(1,n-1),1) + diag(r*ones(1,n-1),-1);
B(n,n-1)=2*r;

% Set up column vector F
F = zeros(10, 1);
for i = 1:10
    if i == 1
        F(i, 1) = 2 * C * k * (L - (i * h)) + 2 * r * T0;
    else
        F(i, 1) = 2 * C * k * (L - (i * h));
    end
end

% Compute the solution u from one row to the next                
% Compute the solution u from one row to the next                
for j = 1:NumRows-1
   u(j+1,:) = A\(B*u(j,:)'+F);
end

% Left boundary condition
l = T0*ones(NumRows,1);
uplot = horzcat(l,u);

% Plot the solution at t=0,0.5,and 1
figure(1)

plot(a:h:b,uplot(1,:),'b*-','LineWidth',1)
hold on
plot(a:h:b,uplot(100,:), 'ro-', 'LineWidth',1)
plot(a:h:b,uplot(200,:), 'gx-', 'LineWidth',1)
axis([a b min(u(1,:)) max(u(201,:))]);
xlabel('x');
ylabel('u(x,t)');
title('Temperature Distribution in the Pond at Various Times');
legend('t=0', 't=0.5', 't=1');
hold off

% Plotting solution over time
figure(2)

for j=1:NumRows-1
    plot(a:h:b,uplot(j,:),'b*-','LineWidth',1)
    axis([a b min(u(1,:)) max(u(201,:))])
    xlabel('x')
    ylabel('u(x,t)')
    title(sprintf('Time: %d', j*k));
    hold off
    pause(0.1)
end

fprintf('The temperature at the bottom of the pond at t=1 is %2.4f degrees.', u(NumRows-1,NumCols))