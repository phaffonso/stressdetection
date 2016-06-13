function s2 = simpleLpf(s, dt, fc)
  tau = 2*pi*fc*dt;
  alpha = tau / (tau + 1);
  
  s2(1) = s(1);
  
  for k  = 2:size(s, 1)
    s2(k) = alpha * s(k) + (1 - alpha) * s2(k - 1);
  end
end