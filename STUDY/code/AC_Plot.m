clc;clear;

x = linspace(-2, 2, 1000);
y = (x - 1) .* (x + 1);

figure(1)
hold on;
plot(x, y, LineWidth= 2);
axis equal;
xlabel("$x$", Interpreter="latex",FontSize=15);
ylabel("$\dot{x}$", Interpreter="latex",FontSize=15);
title("$\dot{x} = (x -1)(x+1)$", Interpreter="latex",FontSize=20);