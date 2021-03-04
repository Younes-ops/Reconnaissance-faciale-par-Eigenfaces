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
individu = randi(37);
posture = randi(6);
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

% Determination de l'image d'apprentissage la plus proche (plus proche voisin) :
labelC_N=[repmat(numeros_individus(1),4,1);repmat(numeros_individus(2),4,1);repmat(numeros_individus(3),4,1);repmat(numeros_individus(4),4,1)];
ListeClass=[numeros_individus(1),numeros_individus(2),numeros_individus(3),numeros_individus(4)];
[dist_min,partition]=kppv(C_N,I_N,labelC_N,1,ListeClass)
disp(dist_min)
indice = 1;
distance_min = sqrt(sum( (C_N(1,:) - I_N).^2 ));
for i = 1:n
    distance = sqrt(sum( (C_N(i,:) - I_N).^2 ));
    if distance < distance_min 
        distance_min = distance; 
        indice = i;
    end
end

    
% Affichage du resultat :
if distance_min < s
        
     if    1 <= indice <= 4
        individu_reconnu = numeros_individus(1);
     elseif 5 <= indice <= 8
        individu_reconnu = numeros_individus(2);
     elseif 9 <= indice <= 12
        individu_reconnu = numeros_individus(3);
     else 
        individu_reconnu = numeros_individus(4);
     end
       
        
	    title(['Posture numero ' ,num2str(posture), ' de l''individu numero ',...
        num2str(individu+3),...
		' Je reconnais l''individu numero ',num2str(individu_reconnu+3)],'FontSize',12);
else
        title(['Posture numero ' ,num2str(posture), ' de l''individu numero ',...
        num2str(individu+3),...
		' Je ne reconnais pas cet individu !' ],'FontSize',12);
end
