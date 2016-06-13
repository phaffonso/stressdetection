function s2 = bpmFilter(s, window)

  tofix = (s <= 150 && s >= 100);
  f = tofix .* s * 9 + s;
  
  valid = (s > 350);
  s2 = zeros(size(s));
  m = 0;
  
  for k = 1:(window - 1)
    s2(k) = median(f(1:k));
  end
  
  in = f(1:window);
  m = median(in(in > 350));
  
  for k = window:size(s, 1)
    in = f((k-window+1):k);
    m = median(in(and(in > 350, in < m+150, in > m-150)));
    fflush(stdout);
    s2(k) = m;
  end

end