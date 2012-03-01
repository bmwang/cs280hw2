function img = q3_single()
  if nargin < 2
      use_full = false;
  end
  load('train_small.mat');
  load('test.mat');
  
  feature_func = @phog_features

  params = train_svm(feature_func, train{7});

  pred_labels = predict_svm(feature_func, params, test);

  [err, wrong] = benchmark(pred_labels, test.labels);

  num_wrong = size(wrong,1);

  images = zeros(28,28,num_wrong);
  imgarr = test.images;

  parfor i = 1:num_wrong
    wrong_index = wrong(i)
    images(:,:,i) = imgarr(:,:,wrong_index);
  end
 
  img = montage_images(images);

end


function svm_params = train_svm(feature_func, train_struct)
  features = feature_func(train_struct.images);
  svm_params = train_linear_svm(features, train_struct.labels);
end

function predictions = predict_svm(feature_func, params, test_struct)
  features = feature_func(test_struct.images);
  predictions = predict_linear_svm(features, params);
end

function features = phog_features(images)
    new_size = 2097;
    max = size(images,3);
    features = zeros(new_size, max);
    parfor i = 1:max
        features(:,i) = double(phog(images(:,:,i), false, true));
    end;
end
