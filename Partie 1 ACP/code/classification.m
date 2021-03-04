clear variables;close all;clc;

%% Utilisation de l'ACP pour detecter deux classes

% Creation d'un echantillon contenant deux classes que nous allons
% retrouver via l'ACP
nb_indiv1 = 100;nb_indiv2 = 150;nb_indiv = nb_indiv1+nb_indiv2; 
nb_param = 30;
% Creation de la premiere classe autour de l'element moyen -.5*(1 .... 1)
X1 = randn(nb_indiv1,nb_param);X1 = X1 - 0.5*ones(nb_indiv1,1)*ones(1,nb_param);  
% Creation de la premiere classe autour de l'element moyen + (1 .... 1)
X2 = randn(nb_indiv2,nb_param);X2 = X2 + 1*ones(nb_indiv2,1)*ones(1,nb_param); 
% Creation du tableau des donnees (concatenation des deux classes) 
X = [X1;X2]; 

disp(' COMPLETE ')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CALCULER LA MATRICE DE VARIANCE/COVARIANCE DU TABLEAU DES DONNEES X, ET
% LES AXES PRINCIPAUX. REORDONNER CES AXES PAR ORDRE DECROISSANT DU
% CONTRASTE QU'ILS FOURNISSENT.
% CALCULER LA MATRICE C DE L'ECHANTILLON DANS CE NOUVEAU REPERE.

%Calcul de la matrice de Variance/Covariance
XC = X - mean(X);
sigma = (1/length(X(:,1)))*(XC)'*XC ;

[W,D] = eig(sigma);
[Dtrie,ind] = sort ( diag(D), 'descend');
W=W(:,ind);

%Calcul de la matrice C de l'echantillon X
C=XC*W;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(' COMPLETE ')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AFFICHER LA PROJECTION DES INDIVIDUS DE XC SUR LE PREMIER AXE DU REPERE 
% CANONIQUE. LES INDIVIDUS DES DEUX CLASSES DOIVENT ETRE REPRESENTES PAR 
% DEUX COULEURS DIFFERENTES.
% AFFICHER LA PROJECTION DE CES MEMES INDIVIDUS SUR LE PREMIER AXE 
% PRINCIPAL (AVEC A NOUVEAU UNE COULEUR PAR CLASSE).
% COMMENTER.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1), clf, 
subplot(2,1,1)
% Affichage des donnees sur la premiere composante canonique :
% les individus de la premiere classe sont en rouge (p. ex), ceux de la 
% seconde classe sont en bleu

p1 = plot(XC(1:100,1),zeros(1,100),'r+');
hold on;
p2 = plot(XC(101:250,1),zeros(1,150),'b*');
legend([p1;p2],'classe1','classe2');

title('Visualisation des donnees sur le premier axe canonique')

% Affichage des donnees sur la premiere composante principale : (m�me
% code couleur)
subplot(2,1,2)
p1 = plot(C(1:100,1),zeros(1,100),'r+');
hold on;
p2 = plot(C(101:250,1),zeros(1,150),'b*');
legend([p1;p2],'classe1','classe2');

title('Visualisation des donnees sur le premier axe principal');

disp(' COMPLETE ')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AFFICHER UNE FIGURE MONTRANT LE POURCENTAGE D'INFORMATION APPORTEE PAR
% CHAQUE COMPOSANTE PRINCIPALE. 
% EN ABSCISSE DOIT SE TROUVER LE NUMERO DE LA COMPOSANTE OBSERVEE, EN 
% ORDONNEE ON MONTRERA LE POURCENTAGE D'INFO QUE CONTIENT CETTE COMPOSANTE.
% NB : ETANT DONNEE QU'ON A REORDONNE LES AXES PRINCIPAUX DANS L'ORDRE
% DECROISSANT DE L'INFORMATION APPORTEE, LA COURBE DOIT ETRE DECROISSANTE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(2), clf
info_axes = Dtrie/sum(Dtrie);
stem(ind,info_axes);
title('Pourcentage d info contenue sur chaque composante ppale -- 2 classes')
xlabel('num de la comp. ppale');ylabel('pourcentage d info');

%% Utilisation de l'ACP pour detecter plusieurs classes

% Dans le fichier 'jeu_de_donnees.mat' se trouvent 4 tableaux des donnees 
% d'individus vivant dans le meme espace. Chacun de ces tableaux 
% represente une classe. On concatene ces tableaux en un unique tableau X, 
% et on va chercher combien de composantes principales il faut prendre en 
% compte afin de detecter toutes les classes
load('quatre_classes.mat')
n1 = size(X1,1);n2 = size(X2,1);n3 = size(X3,1);n4 = size(X4,1);
n = n1+n2+n3+n4;
X = [X1;X2;X3;X4];
nb_param = size(X,2);

disp(' COMPLETE ')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CALCULER LA MATRICE DE VARIANCE/COVARIANCE DU TABLEAU DES DONNEES X ET
% LES AXES PRINCIPAUX. REORDONNER CES AXES PAR ORDRE DECROISSANT DU
% CONTRASTE QU'ILS FOURNISSENT.
% CALCULER LA MATRICE C DE L'ECHANTILLON DANS CE NOUVEAU REPERE.

%Calcul de la matrice de Variance/Covariance
XC = X - mean(X);
sigma = (1/length(X(:,1)))*(XC)'*XC ;

[W,D] = eig(sigma);
[Dtrie,ind] = sort ( diag(D), 'descend');
W=W(:,ind);

%Calcul de la matrice C de l'echantillon X
C=XC*W;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(' COMPLETE ')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AFFICHER LA PROJECTION DE XC SUR :
% - LE PREMIER AXE PRINCIPAL
% - LE DEUXIEME AXE PRINCIPAL
% - LE TROISIEME AXE PRINCIPAL
% EN UTILISANT UNE COULEUR PAR CLASSE.
%
% QUESTION 5 RAPPORT :
% COMBIEN DE CLASSES EST-ON CAPABLE DE DETECTER AVEC LA PREMIERE 
% COMPOSANTE, LA DEUXIEME, LA TROISIEME, PUIS LES TROIS ENSEMBLES ?
% NB : VOTRE FIGURE DOIT CORRESPONDRE A LA FIGURE 2(b) DE L'ENONCE.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(3),clf
subplot(3,1,1)
p1 = plot(C(1:n1,1),zeros(1,n1),'r*');
hold on;
p2 = plot(C(n1+1:n1+n2,1),zeros(1,n2),'b*');
hold on;
p3 = plot(C(n1+n2+1:n1+n2+n3,1),zeros(1,n3),'g*');
hold on;
p4 = plot(C(n1+n2+n3+1:n,1),zeros(1,n4),'m*');
legend([p1;p2;p3;p4],'classe1','classe2','classe3','classe4');

title('1ere composante ppale')

subplot(3,1,2)
p1 = plot(C(1:n1,2),zeros(1,n1),'r*');
hold on;
p2 = plot(C(n1+1:n1+n2,2),zeros(1,n2),'b*');
hold on;
p3 = plot(C(n1+n2+1:n1+n2+n3,2),zeros(1,n3),'g*');
hold on;
p4 = plot(C(n1+n2+n3+1:n,2),zeros(1,n4),'m*');
legend([p1;p2;p3;p4],'classe1','classe2','classe3','classe4');
title('2eme composante ppale')

subplot(3,1,3)

p1 = plot(C(1:n1,3),zeros(1,n1),'r*');
hold on;
p2 = plot(C(n1+1:n1+n2,3),zeros(1,n2),'b*');
hold on;
p3 = plot(C(n1+n2+1:n1+n2+n3,3),zeros(1,n3),'g*');
hold on;
p4 = plot(C(n1+n2+n3+1:n,3),zeros(1,n4),'m*');
legend([p1;p2;p3;p4],'classe1','classe2','classe3','classe4');
title('3eme composante ppale')

disp(' COMPLETE ')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AFFICHER LES DEUX PREMIERES COMPOSANTES PRINCIPALES DE X DANS LE PLAN, 
% PUIS AFFICHER LES TROIS PREMIERES COMPOSANTES PRINCIPALES DE X DANS 
% L'ESPACE. UTILISER UNE COULEUR PAR CLASSE. 
%
% QUESTION 5 RAPPORT :
% COMBIEN DE CLASSES PEUT-ON DETECTER DANS LE PLAN ? DANS L'ESPACE ?
% NB : VOS FIGURES DOIVENT CORRESPONDRE AUX FIGURES 2(c) ET (d) DE L'ENONCE
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(4), clf, 
grid on 
hold on
p1 = plot(C(1:n1,1),C(1:n1,2),'r*');
p2 = plot(C(n1+1:n1+n2,1),C(n1+1:n1+n2,2),'b*');
p3 = plot(C(n1+n2+1:n1+n2+n3,1),C(n1+n2+1:n1+n2+n3,2),'g*');
p4 = plot(C(n1+n2+n3+1:n,1),C(n1+n2+n3+1:n,2),'m*');
legend([p1;p2;p3;p4],'ind. de la classe1','ind. de la classe2',...
    'ind. de la classe3','ind. de la classe4');
title('Proj. des donnees sur les deux 1ers axes ppaux')

figure(5), clf, 
p1 = plot3(C(1:n1,1),C(1:n1,2),C(1:n1,3),'r*');
hold on
p2 = plot3(C(n1+1:n1+n2,1),C(n1+1:n1+n2,2),C(n1+1:n1+n2,3),'b*');
hold on
p3 = plot3(C(n1+n2+1:n1+n2+n3,1),C(n1+n2+1:n1+n2+n3,2),C(n1+n2+1:n1+n2+n3,3),'g*');
hold on
p4 = plot3(C(n1+n2+n3+1:n,1),C(n1+n2+n3+1:n,2),C(n1+n2+n3+1:n,3),'m*');
legend([p1;p2;p3;p4],'ind. de la classe1','ind. de la classe2',...
    'ind. de la classe3','ind. de la classe4');grid on
title('Proj. des donnees sur 3 1ers axes ppaux')



disp(' COMPLETE ')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AFFICHER UNE FIGURE MONTRANT LE POURCENTAGE D'INFORMATION APPORTEE PAR
% CHAQUE COMPOSANTE PRINCIPALE. 
% EN ABSCISSE DOIT SE TROUVER LE NUMERO DE LA COMPOSANTE OBSERVEE, EN 
% ORDONNEE ON MONTRERA LE POURCENTAGE D'INFO QUE CONTIENT CETTE COMPOSANTE.
% NB : ETANT DONNEE QU'ON A REORDONNE LES AXES PRINCIPAUX DANS L'ORDRE
% DECROISSANT DE L'INFORMATION APPORTEE, LA COURBE DOIT ETRE DECROISSANTE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(6),clf
info_axes = Dtrie/sum(Dtrie);
stem(ind,info_axes);
title('Pourcentage d info contenue sur chaque composante ppale -- 4 classes')
xlabel('num de la comp. ppale');ylabel('pourcentage d info');

disp(' COMPLETE ')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COMPARER CETTE FIGURE AVEC LA MEME FIGURE OBTENUE POUR LA CLASSIFICATION
% EN DEUX GROUPES.
%
% QUESTION 5 RAPPORT :
% COMMENTER.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

