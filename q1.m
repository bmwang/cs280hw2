function results = q1(use_full)
  if nargin < 1
    use_full = false;
  end
  results = run_svm(@pixel_features, use_full);
  
  sample_axis = [100 200 500 1000 2000 5000 10000 60000];
  error_max = [1 1 1 1 1 1 1 1];
  if not(use_full)
    sample_axis = sample_axis(1:7);
    error_max = error_max(1:7);
  end
  
  error = error_max - results/10000;
      
  plot(sample_axis,error);
end
