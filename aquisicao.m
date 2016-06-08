
http_init;

i = input('identificador do candidato: ', 's');
N = input('numero de medidas a fazer: ');
deltaT = 0.5;

urlbase = 'http://192.168.0.19:4950';

gr.name = 'grupostress';
gr.resources{1} = '/eHealth/skinResponse';
gr.resources{2} = '/eHealth/oxiometer/bpm';

groupname = [urlbase '/group/' gr.name];
http_delete(groupname);
g1 = http_post([urlbase '/group'], gr)

measurements = [];

t = (1:N)*deltaT;

tic;
for k = 1:N
  if(mod(k, 10) == 0)
    disp (k);
    fflush(stdout);
  end
  raw = http_get(groupname);
  m = [raw{1}.skinResponse.conductance raw{1}.skinResponse.resistance raw{1}.skinResponse.conductanceVoltage raw{2}.bpm];
  measurements = [measurements ; m];
  
  elapsedTime = toc;
  sleep(deltaT - elapsedTime);
  tic;
end


save(['measurement_' i '.mat'], 'measurements', 't');

disp('Medicoes salvas com sucesso');

for k = 1:4
  figure(k);
  plot(measurements(:, k));
end
