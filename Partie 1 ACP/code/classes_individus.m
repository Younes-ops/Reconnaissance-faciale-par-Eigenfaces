clear variables
close all

% chargement du jeu de donn�es
load('dataset.mat')

%Calcul de la matrice de Variance/Covariance
XC = X - mean(X);
sigma = (1/length(X(:,1)))*(XC)'*XC ;

[W,D] = eig(sigma);
[Dtrie,ind] = sort ( diag(D), 'descend');
W=W(:,ind);

%Calcul de la matrice C de l'echantillon X
C=XC*W;

figure(1),clf
info_axes = Dtrie/sum(Dtrie);
stem(ind,info_axes);
title('Pourcentage d info contenue sur chaque composante ppale')
xlabel('num de la comp. ppale');ylabel('pourcentage d info');


figure(2), clf, 
grid on 
p1 = plot(C(:,1),C(:,2),'r*');
title('Projection des classes sur les 2 axes principaux')

%On constate l'éxistence de 6 clusters que ce soit avec 2 axes principaux
%ou 3 axes principaux.
