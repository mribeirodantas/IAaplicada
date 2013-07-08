function [classe, centros] = kmeanss(d, k)
% K-meas 
% Arg. Entr.: d: DADOS A SEREM AGRUPADOS
%             k: QUANTIDADE DE GRUPOS               
% Arg. Saida: classe: VETOR DE CLASSES
%             centros: MATRIZ EM QUE CONTEM OS k CENTROS DOS GRUPOS
%
% 27.9.2011

%if nargin < 3
 %   num_max_it = 100;
%end

% if size(d,2) == 2
%    plot(d(:,1), d(:,2), '.')
% end
seq = randperm(size(d,1));

centros = d(seq(1:k),:);

%pause
classe = zeros(size(d,1));
classe_ant = 1;
T = 1;
a = 1;

while T
    if a > 1;
        classe_ant = classe;
    end
    % atribuicao dos pontos as classes
    [dt, classe] = min(dist(centros, d'));
    E(a) = sum(dt);
%    disp(classe)
    % Recalculo dos centros
    for i = 1:k
        centros(i,:) = mean(d(classe == i, :));
    end

% pause
   if classe_ant == classe
       T = 0;
   end
   a = a + 1
   
   %if a > num_max_it 
   %    T = 0;
   %end
   
end

% figure;
% plot(E);
% title('figura do kmeans');
% % Colorindo o grafico
% if size(d,2) == 2
%     
%    cores = rand( numero_clust, 3);
% 
%     for i = 1:size(d,1)
%       h = plot(d(i,1), d(i,2), '.');
%       set(h, 'color', cores(classe(i),:))
%     end
%     h  = plot(centros(:,1), centros(:,2), 'k*');
%     set(h, 'markersize', 10);
% end