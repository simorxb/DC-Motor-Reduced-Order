%% Init params

m = 0.1;
r = 0.05;
J = 0.5*m*r^2;
b = 0.0000095;
kt = 0.0187;
R = 0.6;
L = 0.35/1000;
ke = 0.0191;

%% Reduce System

% State-space matrices
A = [0 1 0; 0 -b/J kt/J; 0 -ke/L -R/L];
B = [0; 0; 1/L];
C = [1 0 0];
D = 0;

% Create state-space model
sys = ss(A, B, C, D);

% Create a model order reduction specification using balanced truncation
red = reducespec(sys, 'balanced');

% View state contributions using Hankel singular values
figure;
view(red);

% Obtain reduced-order model of order 2
reducedOrder = 2;
rsys2 = getrom(red, 'Order', reducedOrder);

% Obtain reduced-order model of order 1
reducedOrder = 1;
rsys1 = getrom(red, 'Order', reducedOrder);

%% Plot

figure;

% 12V for the first second and 0V afterwards
T = 0:0.1:5;
U = (T <= 1)*12;

% Simulate the 3 systems
[y, t] = lsim(sys, U, T);
[yr2, tr2] = lsim(rsys2, U, T);
[yr1, tr1] = lsim(rsys1, U, T);

% Angular Position
subplot(2, 1, 1);
plot(t, y, '-r', 'LineWidth', 2);
hold on;
plot(tr2, yr2, '--b', 'LineWidth', 2);
plot(tr1, yr1, '--g', 'LineWidth', 2);
hold off;
grid on;
legend('Original System', 'Reduced-Order 2 System', 'Reduced-Order 1 System');
ylabel('\theta (rad)');

% Input Voltage
subplot(2, 1, 2);
plot(T, U, '-r', 'LineWidth', 2);
grid on;
xlabel('Time (s)');
ylabel('Voltage (V)');

title('Impulse Response Comparison');
