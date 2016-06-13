figure 1;
hold off;
r = 1e6 ./ measurements(:, 2);
plot(r, 'r'); hold on;
correction = (measurements(:, 1) == -1) .* (1 + r);
g = (r .+ measurements(:, 1) .+ correction) / 2;
plot(g, 'g');
k = movingAverage(g, 10);
k2 = simpleLpf(g, 0.5, 0.1);
plot(k, 'k');
plot(k2, 'k');

figure 4; hold off;
r2 = bpmFilter(measurements(:, 4), 5);
plot(r2, 'r'); hold on;

for k = [1 4]
  figure(k);
  plot(measurements(:, k));
end
