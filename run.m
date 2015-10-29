disp('Running');

% Uses O for the original and Ts for the template list. Also uses 'orig' to
% check the original file size (this should be a file path).

if ~exist('Tmp', 'dir')
    mkdir Tmp;
end

T = findBestMatch(O, Ts);

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
off_pixels = sum(artifacts(:));

% Compute the number of bytes saved and the ratio.
bytes_saved = orig_size - compressed_size;
compression_ratio = compressed_size / orig_size;
disp(['Bytes saved: ' num2str(bytes_saved)]);
disp(['Compression: ' num2str(compression_ratio)]);

% Plot the graphs.
subplot(2, 3, 1);
imshow(O);
title('Original Image');

subplot(2, 3, 2);
imshow(R);
title('Restored Image');

subplot(2, 3, 3);
bar([orig_size compressed_size]);
title([num2str(compression_ratio) ' Compression (' num2str(bytes_saved) ' bytes saved)']);

subplot(2, 3, 4);
imshow(T);
title('Closest Template');

subplot(2, 3, 5);
imshow(saved_diff);
title('Diff Image');

subplot(2, 3, 6);
imshow(artifacts * 10);
title(['Compression Artifacts (' num2str(off_pixels) ' pixels error)']);

% Clean up trash.
clear T file orig_size fname diff min_val max_val compressed_size;
clear saved_diff artifacts off_pixels bytes_saved compression_ratio;