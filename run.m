disp('Running');

% Uses O for the original and T for the template. Also uses 'orig' to check
% the original file size (this should be a file path).

if ~exist('Tmp', 'dir')
    mkdir Tmp;
end

file = dir(orig);
orig_size = file.bytes;

% Get the diff file and write it.
fname = 'Tmp/diff.jpg';
[diff, min_val, max_val] = getDiffImg(O, T);
imwrite(diff, fname);

% Compute the compressed data size in bytes. 4 bytes are taken up by the
% min_val and max_val (each an int16) values.
file = dir(fname);
compressed_size = file.bytes + 4;

% Read back the file, and restore it.
saved_diff = imread(fname);
R = restoreImg(saved_diff, T, min_val, max_val);

% Get the artifact image (noise from compression).
artifacts = uint8(abs(int16(O) - int16(R)));

% Print out the number of bytes saved and the ratio.
disp(['Bytes saved: ' num2str(orig_size - compressed_size)]);
disp(['Compression: ' num2str(compressed_size / orig_size)]);

% Plot the graphs.
subplot(2, 2, 1);
imshow(O);
title('Original Image');

subplot(2, 2, 2);
imshow(R);
title('Restored Image');

subplot(2, 2, 3);
imshow(saved_diff);
title('Diff Image');

subplot(2, 2, 4);
imshow(artifacts * 10);
title('Compression Artifacts');

% Clean up trash.
clear file orig_size fname diff min_val max_val compressed_size saved_diff;