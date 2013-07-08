%% Testes com k-means e codificacao de imagens 


%% COMANDO PARA A LEITURA DA IMAGEM
a = imread('lena.bmp');

%% EXIBIÇÃO DA IMAGEM
figure; imagesc(a)
colorbar
colormap(gray)
axis equal
axis off
set(gcf, 'color', [ 1 1 1])

%% TAMANHO DO JANELA PARA COMPACTAÇÃO
tam_jan = 4;

jj = 1;

tam_d_sai = (size(a,1)/tam_jan)  * (size(a,2)/tam_jan);
d_sai = zeros(tam_d_sai, tam_jan*tam_jan);

%% ENQUADRAMENTO DA IMAGEM DE ACORDO COM O TAMANHO DA JANELA
for i = 1:tam_jan:size(a,1)
    for j = 1:tam_jan:size(a,1)
       d_sai(jj,:) = reshape(a(i:i+tam_jan-1, j:j+tam_jan-1), 1, tam_jan*tam_jan);
       jj = jj + 1;
    end
end

d_sai = double(d_sai);

%% TREINAMENTO DO ESPECIALISTA 
k = 32

[classe, centros] = kmeans(d_sai,k);

min_img = min(a(:));
max_img = max(a(:));


%% IMAGEM DO CODEBOOK, CENTROS
figure; 
imagesc(reshape(classe,size(a,1)/tam_jan, size(a,2)/tam_jan)');
title(['Imagem de índices com ' ,num2str(k), ' centros']);

%% RECONSTRUÇÃO DA IMAGEM

img_sai = zeros(size(a,1), size(a,2));
jj = 1;
for i = 1:tam_jan:size(a,1)
    for j = 1:tam_jan:size(a,1)
       img_sai(i:i+tam_jan-1, j:j+tam_jan-1) = reshape(centros(classe(jj),:), tam_jan, tam_jan);
       jj = jj + 1;
    end
end

img_sai2 = uint8(round(img_sai));

figure; 
subplot(1,2,1); 
imagesc(a);axis square;
title('Imagem Original');
subplot(1,2,2); 
imagesc(img_sai2);axis square;
colormap gray
title(['Imagem processada com ', num2str(k), ' centros']);
I2 = imcrop(img_sai2,[150 250 200 200]);
I3 = imcrop(a,[150 250 200 200]);


figure; 
subplot(1,2,1); 
imagesc(I3);axis square;
title('Parte Original');
subplot(1,2,2); 
imagesc(I2);axis square;
colormap gray
title(['Imagem processada com ', num2str(k), ' centros']);

%% MEDIDAS DE TAXA DE ERRO PARA SINAIS APLICADA A IMAGEM
%%  mean squared error e Peak signal-to-noise ratio
 MSE = sum(sum((double(img_sai2) - double(a)).^2))/(prod(size(a)))

psnr = 10*log10(double(max_img).^2 / MSE)

