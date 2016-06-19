close all;
#figure 1;
r = 1e6 ./ measurements(:, 2);
#plot(r); hold on;
correction = (measurements(:, 1) == -1) .* (1 + r);
g = (r .+ measurements(:, 1) .+ correction) / 2;
#plot(g, 'g');
%k = movingAverage(g, 10);
%plot(k, 'k');
k2 = simpleLpf(g, 0.5, 0.1);
#plot(k2, 'k');
baseline = simpleLpf(g, 0.5, 0.005);
#plot(baseline, 'r');

#figure 4;
r2 = bpmFilter(measurements(:, 4), 5);
#plot(r2, 'r'); hold on;

for k = [1 4]
  #figure(k);
  #plot(measurements(:, k));
end
baseA = median(k2(1:5));
baseB = median(r2(1:5));
fis=readfis ('stress_detection');
fis2=readfis ('stress_detection_sugeno');
tic;

[z0 fuzzy_output] = inferStress(k2/baseA, r2/baseB, fis);

#z0b = inferStress(k2/baseA, r2/baseB, fis2);

timeInference = toc
figure(5);
plot(g/baseA, 'b');
plot(measurements(:, 4)/baseB, 'b');
plot(k2/baseA, 'g'); hold on;
plot(r2/baseB, 'r');

plot(z0, 'k');
p#lot(z0b, 'm');
