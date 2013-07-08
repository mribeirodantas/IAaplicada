function [classe w] = competitive_learnig(db,centros,n_iteracoes)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[li co] = size(db);

eta = 0.002;
indices = randperm(centros);
classe = zeros(size(db,1));
w=db(indices(1:centros),:);  % both neuron initially at random place

for i = 1:n_iteracoes
    for j= 1:centros-1
        for k=1:li
            if norm(db(k,:) - w(j,:)) < norm(db(k,:) - w(j+1,:))
                 w(j,:)=w(j,:)+eta*((db(k,:)-w(j,:)));
%             else if norm(db(k,:) - w(j,:)) > norm(db(k,:) - w(j+1,:))
%                     w(j,:)=w(j,:)-eta*((db(k,:)-w(j,:))/w(j,:));
%                  end
            end
        end
    end
end
[dt classe]=min(dist(w, db'));


end

