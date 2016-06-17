close all;
fis=readfis ('stress_detection');

plotmf (fis, 'input', 1);
plotmf (fis, 'input', 2);
plotmf (fis, 'output', 1);


tic;
[output, rule_input, rule_output, fuzzy_output] = ...
  evalfis ([1.2 1.2], fis, 101);
tempoEval = toc

%gensurf (fis, [1 2], 1);

x_axis = linspace (fis.output(1).range(1), ...
                   fis.output(1).range(2), 101);
colors = ['r' 'b' 'm' 'g'];
figure ('NumberTitle', 'off', 'Name', ...
        'Output of Fuzzy Rules 1-4 for Input = (4, 6)');

for i = 1 : 25
    %y_label = [colors(i) ";Rule " num2str(i) ";"];
    plot (x_axis, rule_output(:,i));
    hold on;
endfor

ylim ([-0.1, 1.6]);
grid;
hold;

figure('NumberTitle', 'off', 'Name', ...
       'Aggregation and Defuzzification');
plot (x_axis, fuzzy_output(:, 1), "b;Aggregated Fuzzy Output;", ...
      'LineWidth', 2);
hold on;
crisp_output = evalmf(x_axis, output(1), 'constant');
y_label = ["r;Saida defuzificada = " num2str(output(1)) ";"];
plot (x_axis, crisp_output, y_label, 'LineWidth', 2);
ylim ([-0.1, 1.6]);
xlabel ('Tip', 'FontWeight', 'bold');
grid;
hold;

## Show the rules in symbolic format.
puts ("\nMamdani Tip Calculator Rules:\n\n");
showrule (fis, 1:columns(fis.rule), 'symbolic');
