function plotImages(images, Y ,scale, skip)
% Plot images on predefined coordinates
%
% images: h x w x n, images, in a 3-dimensional matrix (height by width by n)
% Y: n x 2, where to plot the image (Y(:,1) by Y(:,2))
% scale: double, scale of each image w.r.t. figure size (scale<<1)
% skip: integer, skip of images to be plotted, (i.e. skip=2, plot 1th, 3th, 5th, ...)

xoff=0;
yoff=0;

width = (max(Y(:,1)) - min(Y(:,1))) * scale;
height = (max(Y(:,2)) - min(Y(:,2))) * scale;

colormap(gray);

n_images = size(images,3);

xs = Y(:,1) + xoff;
ys = Y(:,2) + yoff;
hold on
for counter = 1:skip:n_images
    [~,knnD] = knnsearch([xs(1:counter-1), ys(1:counter-1)],[xs(counter), ys(counter)]);
    if knnD<(width+height)*0.5
        continue;
    else
        current_image = - images(:,:,counter);
        imagesc([xs(counter)	xs(counter)+width], ...
            [ys(counter)+height	ys(counter)], ...
            current_image' ...
        );
    end
end

xlabel ('x')
ylabel ('y')
hold off
end
