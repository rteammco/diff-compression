function [ restored ] = restoreImg( diff, template, min_val, max_val )
% restoreImg Restores the original image given the saved difference, the
%   template image, and the minimum and maximum pixel values of the
%   difference image.
%
%   The diff image is expected to be a have pixel values between 0 and 255.
%   Returns the restored image.

    % Restore the original integer range difference image.
    diff = double(diff) / double(255);
    diff = int16(diff * double(max_val - min_val));
    diff = diff + min_val;

    % Add the template (scaled) to get back the original image.
    [num_rows, num_cols, ~] = size(diff);
    template = imresize(template, [num_rows, num_cols]);
    restored = uint8(diff + int16(template));

end

