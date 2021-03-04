clear variables;clc
% tolerance relative minimum pour l'ecart entre deux iteration successives
% de la suite tendant vers la valeur propre dominante
% (si |lambda-lambda_old|/|lambda_old|<eps, l'algo a converge)
eps = 1e-8;
% nombre d iterations max pour atteindre la convergence
% (si i > kmax, l'algo finit)
kmax = 5000;

% Generation d une matrice rectangulaire aleatoire A de taille n x p.
% On cherche le vecteur propre et la valeur propre dominants de AA^T puis
% de A^TA
n = 5; p = 8;
A = 5*randn(n,p);
% AAt est une  matrice carre de taille  (n x n)
AAt = A*A';
%m le nombre de vecteurs v de la matrice V
m=6;
%% Methode de la puissance iteree pour la matrice AAt de taille nxn
%Generation de m vecteurs orthonormal
%On genere une matrice aléatoire
B=randn(n,m);
B_orth=orth(B);
V=B_orth;
M = AAt;
cv = false;
k = 0;  % pour compter le nombre d'iterations effectuees
err1 = 0; % residu de la norme du vecteur propre. On sort de la boucle
% quand err1 <eps


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CODER L'ALGORITHME DE LA PUISSANCE ITEREE TEL QUE DONNE DANS L'ENONCE
% POUR LA MATRICE AAt
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
while(~cv)
    k = k + 1;
    Y=M*V;
    H=V'*M*V;
    err1 = (norm(M*V-V*H,'fro'))/(norm(M,'fro'));
    %Orthonormalisation
    V=orth(Y);
    %V=Y
    cv =  (err1 < eps) | ( k >  kmax);
end
V

