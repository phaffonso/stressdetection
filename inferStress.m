function [z0 fuzzy_output] = inferStress(a0, b0, fis)
  [z0, rule_input, rule_output, fuzzy_output] = evalfis([min(a0, 4) max(0.5, min(b0, 1.5))], fis, 101);
end