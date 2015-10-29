function [ diff, min_val, max_val ] = getDiffImg( imgToCompress, template )
%getDiffImg Computes the difference between the two images.
%
%   Returns the difference image as double values between 0 and 1, as well
%   as the maximum and minimum pixel values in the original integer
%   difference matrix. To restore the original difference matrix (which may
%   include negative values), interpolate the doubles in range 0 to 1
%   linearly to map 0 to mid(1n_val and 1 to max_val.

    % Resize the template to match the target image size.
    [num_rows, num_cols, ~] = size(imgToCompress);
    template = imresize(template, [num_rows, num_cols]);

    diff = int16(imgToCompress) - int16(template);
    % Make diff a uint image by offsetting it.
    min_val = int16(min(diff(:)));
    max_val = int16(max(diff(:)));
    diff = diff - min_val; % Make the smallest value 0.
    diff = double(diff) / double(max(diff(:))); % Make the max value 1.

    % Scale it up to 0-255 standard pixel intensity scale.
    diff = uint8(diff * 255);

end

