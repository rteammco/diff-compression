function [ dissimilarity ] = computeDissimilarity( img1, img2 )
%computeDissimilarity Returns the dissimilarity measure between the RGB
%   color histograms of images img1 and img2.
%
%   The smaller this value is, the more similar the images are. This
%   function is symmetric. The dissimilarity of identical images is 0.

    % Compute the histograms.
    img1 = double(img1);
    img2 = double(img2);
    h1 = hist(reshape(img1,[],3), 1:255);
    h1 = h1 / norm(h1);
    h2 = hist(reshape(img2,[],3), 1:255);
    h2 = h2 / norm(h2);

    %subplot(1, 2, 1);
    %plot(h1);
    %subplot(1, 2, 2);
    %plot(h2);

    dissimilarity = diag(pdist2(h1', h2'));
    dissimilarity = sum(dissimilarity(:));

end

