function [Dist, Allo] = distallo(Raster)
%Raster = [1 0 0 3 0 0; 0 0 0 0 0 0; 0 0 0 0 0 0; 0 0 6 0 0 5; 0 0 0 0 0 0; 0 4 0 0 0 0];
[x y] = find(Raster>0); %find the location of the source cells
Pts = nonzeros(Raster); %identify the value for each source cell
[nrow ncol] = size(Raster); 
D = 1;
Raster
for i = 1:nrow
    for j = 1:ncol
        for k = 1:nnz(Raster) %looping for each source cell
            C(k)= D * sqrt((i-x(k))^2+(j-y(k))^2); 
            %return the distance for cell(i,j) to source cells (k)
        end
        Dist(i,j) = min(C); %only consider the shortest distance
        [m l] = min(C); %to return the index of k of shortest distance
        Allo(i,j) = Pts(l); %to return the value of source cell of the shortest distance
    end
end
Dist
Allo

%Displaying the matrix as image
figure = input('Which graph do you want to display? 1) Allocation map or 2) Distance map? ');
if figure == 1
    image(Allo, 'CDataMapping','scaled')
    title('Raster allocation based on the closest points')
    caxis([0 ,max(max(Allo))]);
    colorbar;
    hcb=colorbar;
    set(hcb,'YTick',unique(Allo))
    saveas(gcf,'allocation','pdf')
elseif figure == 2
    image(Dist, 'CDataMapping','scaled')
    title('Distance map to the closest points [m]')
    caxis([0 1.5*max(max(Dist))]);
    colorbar;
    hcb=colorbar;
    set(hcb,'YTick',unique(Dist))
    saveas(gcf,'distance','pdf')
end



