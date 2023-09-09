%B=imread('imag/maphoto.png');
%A=rgb2gray(B);
% IINSERER DEUX MARQUES 

clc;
close all;
A=imread('imag/im1.png'); % uint8
[L,C]=size(A);
[LL1,LH1,HL1,HH1] = dwt2(A,'haar'); % double 
%figure, imshow(host), title('host');
nLL=uint8(LL1);
W=imread('imag/cle.png');

[M,N]=size(nLL);
RedimTatouage=imresize(W, [M,N]); % uint8
RedimTatouageBinaire=im2bw(RedimTatouage);
ImageTatouee=bitset(nLL, 1, RedimTatouageBinaire);
it=double(ImageTatouee);

% INSERTION DE LA PREMIERE MARQUE
B0=imread('imag/sante.png');
B1=rgb2gray(B0);
B2=imresize(B1, [L,C]);
B3=im2bw(B2);
ImW=bitset(A, 1, B3);

figure;
subplot(2,2,1); imshow(A); title('Original image');
subplot(2,2,2); imshow(B0); title('Watermark 1');
subplot(2,2,3); imshow(B3); title('Binary watermark 1');
subplot(2,2,4); imshow(ImW); title('Image watermarked 1');

% INSERTION DE LA SECONDE MARQUE 
[h_LL1,h_LH1,h_HL1,h_HH1] = dwt2(ImW,'haar');
x=L/2; y=C/2;
W0=imresize(W, [x,y]);
W1=double(W0);                  % Convertir la marque en double
% Insertion de la marque dans la sous bande LL 
k=0.01;
newhost_LL = h_LL1 + k*W1;

%image tatou e
ImW2=idwt2(newhost_LL,h_LH1,h_HL1,h_HH1,'haar');
ImW3=imresize(ImW2, [L,C]);
figure;
subplot(1,2,1),imshow(uint8(W1));title('Watermark');
subplot(1,2,2),imshow(uint8(ImW2));title('image tatouee');
imwrite(uint8(ImW2),'tatouee.jpg');


% EXTRACTION DE LA MARQUE          imshow(double(I),[0,255])
WEXT1=bitget(double(ImW), 1);

WEXT2=bitget(uint8(ImW2), 1);
WEXT22 = double(WEXT2);
WEXT3=bitget(uint8(ImW3), 1);


%WEXT33 = double(WEXT3);
CC = bitxor(im2bw(WEXT1),im2bw(WEXT3));

figure;
subplot(1,3,1);imshow(WEXT1);title('Watermark 1');
% subplot(1,2,2);imshow(uint8(WEXT22));title('Watermark 2');
subplot(1,3,2);  imshow(double(WEXT3),[0,255]) ;title('Watermark 2'); % imshow(im2double(WEXT3))
subplot(1,3,3); imshow(CC); title('Watermark 3'); 


% EXTRACTION DE LA MARQUE 1  imagesc(LL1);colormap gray;



figure;
subplot(2,2,1); imshow(ImageTatouee); title('Coefficient tatou e');
subplot(2,2,2); imshow(uint8(it)); title('Coefficient tatou e et convertir en double');
subplot(2,2,3); imagesc(LL1);colormap gray; title('Coefficient original');
subplot(2,2,4); imagesc(nLL);colormap gray; title('Coefficient convertir en uint8');

figure;
subplot(2,2,1)
imagesc(LL1)
colormap gray
title('LL1')
subplot(2,2,2)
imagesc(LH1)
colormap gray
title('LH1')
subplot(2,2,3)
imagesc(HL1)
colormap gray
title('HL1')
subplot(2,2,4)
imagesc(HH1)
colormap gray
title('HH1')



[LL2,LH2,HL2,HH2] = dwt2(LL1,'haar');
%figure, imshow(host), title('host');

figure;
subplot(2,2,1)
imagesc(LL2)
colormap gray
title('LL2 : Approximation niveau 2')
subplot(2,2,2)
imagesc(LH2)
colormap gray
title('LH2 : Horizontal niveau 2')
subplot(2,2,3)
imagesc(HL2)
colormap gray
title('HL2 : Vertical niveau 2')
subplot(2,2,4)
imagesc(HH2)
colormap gray
title('HH2 : Diagonal niveau 2')
