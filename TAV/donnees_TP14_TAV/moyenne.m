function res = moyenne(image)

image = double(image);
R = image(:, :, 1);
V = image(:, :, 2);
B = image(:, :, 3);

sum = R + V + B;
R = R ./ max(1, sum);
V = V ./ max(1, sum);

res(1, 1) = mean(R(:));
res(1, 2) = mean(V(:));

end