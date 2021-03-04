clear all;clc
% tolérance
eps = 1e-8;
% nombre d'iterations max pour atteindre la convergence (si i > maxit, l'algo échoue)
maxit = 300; 

% Géneration d'une matrice rectangulaire aléatoire A de taille (n x p)
n = 1000; p = 50;

% ré-initialisation du générateur aléatoire (enlever ligne pour avoir une
% matrice différente à chaque appel
randn('state', 0);

A = 5*randn(n,p);
% AAt, AtA : équations normales de la matrice A
AAt = A*A';
AtA = A'*A;



% appel a eig de matlab : calcul de toutes les valeurs propres
t_v =  cputime;
[VA, DA] = eig(AAt);
t_v = cputime-t_v;
fprintf('eig : Temps eig = %0.3e\n',t_v);
[WA, indices] = sort(diag(DA), 'descend');
VA = VA(:, indices);

% test avec votre puissance itérée
%
%
%
%

% nombre de valeurs propres cherchées (v0) 
% ou taille du sous-espace (V1 et v2)
m = 40;

% pour comparer les différentes versions 
% on veut  que le V (généré aléatoirement) soit le même
% on sauvegarde la valeur du générateur aléatoire
s = rng;

t_v0 =  cputime;
[W0, V0, it1, flag0] = subspace_iter_v0(AAt, m, eps, maxit);
t_v0 = cputime-t_v0;
q0 = norm(W0 - WA(1:m))/norm(WA);
flag0

for i = 1:m
    qv0(i) = norm(AAt*V0(:,i) - W0(i)*V0(:,i))/norm(W0(i));
end

fprintf('iter0 : Temps v0 = %0.3e\n',t_v0);
fprintf('iter0 : Qualité de la solution valeurs propres / eig = %0.3e\n',q0);
fprintf('iter0 : Qualité de la solution couple propres = [%0.3e - %0.3e]\n', min(qv0), max(qv0));


% pourcentage de la trace que l'on veut atteindre
percentage = 0.5;

% on ré-initialise la valeur du générateur aléatoire avec la valeur sauvée
rng(s);

t_v1 =  cputime;
[ W1, V1, n_ev1, k1, flag1 ] = subspace_iter_v1( AAt, m, percentage, eps, maxit );
t_v1 = cputime-t_v1;

q1 =  norm(W1 - WA(1:n_ev1))/norm(WA);
n_ev1
k1
flag1

for i = 1:n_ev1
    qv1(i) = norm(AAt*V1(:,i) - W1(i)*V1(:,i))/norm(W1(i));
end

fprintf('iter1 : Temps v1 = %0.3e\n',t_v1);
fprintf('iter1 : Qualité de la solution valeurs propres / eig = %0.3e\n',q1);
fprintf('iter1 : Qualité de la solution couple propres = [%0.3e - %0.3e]\n', min(qv1), max(qv1));

% on ré-initialise la valeur du générateur aléatoire avec la valeur sauvée
rng(s);

% nombre de produits par itération (approche bloc)
nbprod = 5;
t_v2 =  cputime;
[ W2, V2, n_ev2, k2, flag2 ] = subspace_iter_v2( AAt, m, percentage, nbprod, eps, maxit );
t_v2 = cputime-t_v2;
q2 = norm(W2 - WA(1:n_ev2))/norm(WA);
n_ev2
k2
flag2
for i = 1:n_ev2
    qv2(i) = norm(AAt*V2(:,i) - W2(i)*V2(:,i))/norm(W2(i));
end
fprintf('iter2 : Temps v2 = %0.3e\n', t_v2);
fprintf('iter2 : Qualité de la solution valeurs propres / eig = %0.3e\n',q2);
fprintf('iter2 : Qualité de la solution couple propres = [%0.3e - %0.3e]\n', min(qv2), max(qv2));

%Comparaison entre les distributions des valeurs propres pour les
%différents algorithmes pour une matrice donnée
% Nombre de Valeurs propres à afficher
a = min([m n_ev1 n_ev2 length(W0)]);

figure(1),clf
grid on;
subplot(4,1,1)
p1=plot(WA(1:a,1),zeros(1,a),'k*-') ;
grid on;
title('Distribution des valeurs propres pour les différents algorithmes');
subplot(4,1,2)
p2=plot(W0(1:a,1),zeros(1,a),'r*-') ;
grid on;
subplot(4,1,3)
p3=plot(W1(1:a,1),zeros(1,a),'g*-') ;
grid on;
subplot(4,1,4)
p4=plot(W2(1:a,1),zeros(1,a),'b*-') ;
grid on;
legend([p1;p2;p3;p4],'Méthode eig','subspace-iter-v0','subspace-iter-v1','subspace-iter-v2');

%Q13 - Distribution des valeurs propres pour les différentes matrices
% dimensions des matrices 200x200
% algorithme utilisé : subspace_iter_v3
%Nombre des valeurs propres à afficher ( Valeurs prises à partir du
%terminal en lançant les implantations des algo en Fortran )
a  = 10;
T1 = [200 199 198 197 196 195 194 193 192 191];
T2 = [1.000 0.744 0.597 0.589 0.544 0.540 0.536 0.481 0.419 0.370];
T3 = [100.000 94.379 89.074 84.067 79.341 74.881 70.672 66.699 62.950 59.411];
T4 = [1000 995.025 990.050 985.075 980.101 975.126 970.151 965.176 960.201 955.226];

figure(2),clf

subplot(4,1,1)
p1=plot(T1,zeros(1,a),'k*-') ;
grid on;
title('Distribution des valeurs propres pour les différentes matrices');
subplot(4,1,2)
p2=plot(T2,zeros(1,a),'r*-') ;
grid on;
subplot(4,1,3)
p3=plot(T3,zeros(1,a),'g*-') ;
grid on;
subplot(4,1,4)
p4=plot(T4,zeros(1,a),'b*-') ;
grid on;
legend([p1;p2;p3;p4],'Matrice type 1','Matrice type 2','Matrice type 3','Matrice type 4');

% même chose avec AtA
% ...
