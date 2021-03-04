clear;
close all;
load donnees;
load exercice_1;
figure('Name','Image tiree aleatoirement','Position',[0.2*L,0.2*H,0.6*L,0.5*H]);

% Seuil de reconnaissance a regler convenablement
s = 21.5e+00;

% Pourcentage d'information 
per = 0.95;

% Tirage aleatoire d'une image de test :
individu = 37;
posture = 5;
chemin = './Images_Projet_2020';
fichier = [chemin '/' num2str(individu+3) '-' num2str(posture) '.jpg']
Im=importdata(fichier);
I=rgb2gray(Im);
I=im2double(I);
image_test=I(:)';
 

% Affichage de l'image de test :
colormap gray;
imagesc(I);
axis image;
axis off;

% Nombre N de composantes principales a prendre en compte 
% [dans un second temps, N peut etre calcule pour atteindre le pourcentage
% d'information avec N valeurs propres] :
N = 8;

% N premieres composantes principales des images d'apprentissage :
C = X_centre * W;
C_N = C(:,1:N);

% N premieres composantes principales de l'image de test :
I_centre = image_test - mean(X);
I_projection = I_centre * W;
I_N = I_projection(:,1:N);

%Determination de l'image d'apprentissage la plus proche (plus proche voisin) :

%Methode1 : Calcul directe de la distance minimal.

%indice = 1;
%distance_min = sqrt(sum( (C_N(1,:) - I_N).^2 ));
%for i = 1:n
%    distance = sqrt(sum( (C_N(i,:) - I_N).^2 ));
%    if distance < distance_min 
%       distance_min = distance; 
%        indice = i;
%    end
%end

%Mehodes2 : Utilisation d'un classifieur kppv
labelC_N=[repmat(numeros_individus(1),4,1);repmat(numeros_individus(2),4,1);repmat(numeros_individus(3),4,1);repmat(numeros_individus(4),4,1)];
ListeClass=[numeros_individus(1),numeros_individus(2),numeros_individus(3),numeros_individus(4)];
[distance_min,partition]=kppv(C_N,I_N,labelC_N,1,ListeClass);

    
% Affichage du resultat :
if distance_min < s
        individu_reconnu=partition;
  
	    title(['Posture numero ' ,num2str(posture), ' de l''individu numero ',...
        num2str(individu+3),...
		' Je reconnais l''individu numero ',num2str(individu_reconnu+3)],'FontSize',12);
else
        title(['Posture numero ' ,num2str(posture), ' de l''individu numero ',...
        num2str(individu+3),...
		' Je ne reconnais pas cet individu !' ],'FontSize',12);
end


%----------------Test et Calcul de la matrice de Confusion-----------------



%On creer une base d'apprentissage a partir de 37 individu et 3 prostures 

% Choix des images parmi les 37 individus et 3 postures faciales :
numeros_individus = [1:37];
numeros_postures = [1 2 3];

nombre_individues=length(numeros_individus);

% Chargement et conversion des images
chemin = './Images_Projet_2020';
Y=[];
for i=numeros_individus
     for j=numeros_postures
         fichier = [chemin '/' num2str(i+3) '-' num2str(j) '.jpg'];
         Im=importdata(fichier);
         I=rgb2gray(Im);
         I=im2double(I);
         Y=[Y;I(:)'];
    end
end
%On refait le meme travail que dans l'exercice 1
individu_moyenY = mean(Y);

Y_centre = Y - individu_moyenY;

SigmaY_2 = Y_centre * ( Y_centre )'/ n ;

[W_Y_2,D_Y] = eig(SigmaY_2);

[Dtrie,ind] = sort ( diag(D_Y), 'descend');

W_Y_2 = W_Y_2(:,ind);

W_Y_2 = W_Y_2(:,1:end-1);

W_Y = zeros(p,n-1);

for i = 1:n-1
W_Y(:,i) = Y_centre' * W_Y_2(:,i);
end  

W_Y = orth(W_Y);

% N premieres composantes principales des images d'apprentissage :
C_Y = Y_centre * W_Y;
C_N_Y = C(:,1:N);
DataA=C_N_Y;

%On doit tester les 37 individu alors on choisie aléatoirement une posture
%pour chaqu'un
Images_test=[]
for i=numeros_individus
    j=randi(6);
    fichier = [chemin '/' num2str(i+3) '-' num2str(j) '.jpg'];
    Im=importdata(fichier);
    I=rgb2gray(Im);
    I=im2double(I);
    Images_test=[Images_test;I(:)'];
    
end

Label_Images_test=[1:37]
% N premieres composantes principales des images de test :
Images_test_centre = Images_test - mean(X);
Images_test_projection = Images_test_centre * W;
I_N_Y = Images_test_projection(:,1:N);
DataT=I_N_Y;

LabelA=[]
for i =1:37
    LabelA=[LabelA;i;i;i]
end

ListeClass=[1:37]

%On fait le test
[distance_min,partition]=kppv(DataA,DataT,LabelA,3,ListeClass);

%On Construit la matrice de confusion
Confusion=confusionmat(Label_Images_test,partition);

%Taux d'erreur
elements_hors_diag=0;
for i=1:37
    for j=1:37
        if i~=j && Confusion(i,j)~=0
           elements_hors_diag=elements_hors_diag+ 1;
        end
    end
end
Taux_erreur = elements_hors_diag/nombre_individues; 

disp(['Taux_erreur = ' num2str(Taux_erreur)]);

    




