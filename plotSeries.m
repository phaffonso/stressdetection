close all;

loadFilenames;

baselines = [0 0 4.2 0 0 0 0 0 0 0];

for iter = 1:10
iter
if(iter > 5)
  fn = filescontrol{iter - 5}
else
  fn = filesstress{iter}
end

load(fn);
figure(iter); hold on;
%title(fn);

#figure 1;
resInv = 1e6 ./ measurements(:, 2);
#plot(resInv); hold on;
correction = (measurements(:, 1) == -1) .* (1 + resInv);
avgGsr = (resInv .+ measurements(:, 1) .+ correction) / 2;
avgGsr = max(avgGsr, 0);
%plot(avgGsr, 'b');
%k = movingAverage(g, 10);
%plot(k, 'k');
filteredGsr = gsrFilter(avgGsr, 0.5, 0.1);
%plot(filteredGsr, 'g');
#baseline = simpleLpf(avgGsr, 0.5, 0.005);
#plot(baseline, 'r');

#figure 4;
filteredHr = bpmFilter(measurements(:, 4), 5);
#plot(filteredHr, 'r'); hold on;

#for k = [1 4]
  #figure(k);
  #plot(measurements(:, k));
#end
if(baselines(iter) > 0)
  baseA = baselines(iter)
else
  baseA = median(filteredGsr(1:50))
end
baseB = median(filteredHr(1:50))
fis=readfis ('stress_detection');
fis2=readfis ('stress_detection_sugeno');
tic;

step = 5;
xx = 1:step:size(measurements, 1);
%[z0 fuzzy_output] = inferStress(filteredGsr(xx)/baseA, filteredHr(xx)/baseB, fis);

#z0b = inferStress(filteredGsr/baseA, filteredHr/baseB, fis2);

timeInference = toc
#figure(5);
plot(avgGsr/baseA, 'b'); hold on;
plot(measurements(:, 4)/baseB, 'b');
plot(filteredGsr/baseA, 'g;Condutancia da Pele;'); 
plot(filteredHr/baseB, 'r;Frequencia Cardiaca;');

%plot(measurements(:, 4), 'r;Antes da filtragem;');
%plot(filteredHr, 'k;Apos filtragem;');

%plot(avgGsr, 'g;Antes da filtragem;');
%plot(filteredGsr, 'k;Apos filtragem;');


plot(xx, z0, 'k;Nivel de stress (saida);');
#plot(z0b, 'm');

end
