close all;
clear all;

nx = 50;
ny = 50; %change nx ny from 50 to 30 for better subplot
eig_num = 20;
x = linspace(0, 1, nx);
dx = x(2) - x(1);
dx2 = 1;% dx * dx;

%prepare G matrix
G = zeros(nx*ny, nx*ny);
for i=1:(nx*ny)
    G(i, i) = 1;
end


for i=1:(nx)
    for j=1:(ny)
       index = j + (i-1)*ny;
        if(i==1 || i==nx || j==1 || j==ny)
            G(index, index) = 1/dx2;
        else
            G(index, index) = -4/dx2;
            
            %uncomment this to change the fiagonal setting
            %{
            if (i<20 && i>10)
                G(index,index) = -2/dx2;
            end
            %}

            inup = j + (i-2)*ny;
            indown = j + (i)*ny;
            inR = j+1 +(i-1)*ny;
            inL = j-1 + (i-1)*ny;
            G(index, inup) = 1/dx2;
            G(index, indown) = 1/dx2;
            G(index, inR) = 1/dx2;
            G(index, inL) = 1/dx2;
        end
         
    end
end

[E,D] = eigs(G, eig_num, 'SM');

mod1 = eV(E, 1, nx, ny);
mod2 = eV(E, 2, nx, ny);
mod3 = eV(E, 3, nx, ny);
mod4 = eV(E, 4, nx, ny);
mod5 = eV(E, 5, nx, ny);
mod6 = eV(E, 6, nx, ny);
mod7 = eV(E, 7, nx, ny);
mod8 = eV(E, 8, nx, ny);
mod9 = eV(E, 9, nx, ny);

%plotting
figure(1);
spy(G); %spy plot of G
title("Spy(G)");
%eigen value
for i=1:eig_num
    figure(2);
    plot(i, D(i,i),'*');
    hold on;
end
title('Eigen Val');
%mod surf plot
x = linspace(0, nx, nx);
y = linspace(0, ny, ny);
[xx yy] = meshgrid(x, y);
figure(3);
subplot(3,3, 1);
surf(xx, yy, mod1);
title('Mod 1');
subplot(3,3, 2);
surf(xx, yy, mod2);
title('Mod 2');
subplot(3,3, 3);
surf(xx, yy, mod3);
title('Mod 3');
subplot(3,3, 4);
surf(xx, yy, mod4);
title('Mod 4');
subplot(3,3, 5);
surf(xx, yy, mod5);
title('Mod 5');
subplot(3,3, 6);
surf(xx, yy, mod6);
title('Mod 6');
subplot(3,3, 7);
surf(xx, yy, mod7);
title('Mod 7');
subplot(3,3, 8);
surf(xx, yy, mod8);
title('Mod 8');
subplot(3,3, 9);
surf(xx, yy, mod9);
title('Mod 9');




function eigV_plot = eV(ev_m, mod, nx, ny)
    eigV_plot = zeros(ny, nx);
    for i=1:nx
        for j=1:ny
            ind = j + (i-1)*ny;
            eigV_plot(j,i) = ev_m(ind, mod);
        end
    end
end