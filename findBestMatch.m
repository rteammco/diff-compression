function [ match ] = findBestMatch( img, templates )
%findBestMatch Finds the template image that is most similar to the given
%   img.
%
%   Uses the computeDissimilarity function to find the best match.

    min_diss = computeDissimilarity(img, templates{1});
    index = 1;
    for i = 2 : max(size(templates))
        diss = computeDissimilarity(img, templates{i});
        if diss < min_diss
            min_diss = diss;
            index = i;
        end
    end

    match = templates{index};

end

