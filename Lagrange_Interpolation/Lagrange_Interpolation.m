x = 0:6:84;
y = [124, 134, 148, 156, 147, 133, 121,109, 99, 85, 78, 89, 104, 116, 123];
t = 0:1:84;

c = Lagrange_coef(x,y);
p = Lagrange_Eval(50,x,c);

fprintf('The car is traveling at a speed of %f ft/s at t = 50 seconds.', p)

plot(x,y, "Marker","*") 
hold on
plot(t,Lagrange_Eval(t,x,c),"Marker","o")
title('Racetrack Intervals');
xlabel('Time (seconds)');
ylabel('Speed (feet/second)');
legend('Initial Data', 'Lagrange Interpolating Polynomial')
saveas(gcf, 'LagrangePlot.png');

