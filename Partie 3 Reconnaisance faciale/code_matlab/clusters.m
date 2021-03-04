clear;
close all;
load exercice_1;
figure('Name',['Plan des deux premieres composantes principales'],'Position',[0,0,0.67*L,0.67*H]);

individu = 2;
posture = 1;
chemin = './Images_Projet_2020';
fichier = [chemin '/' num2str(individu+3) '-' num2str(posture) '.jpg']
Im=importdata(fichier);
I=rgb2gray(Im);
I=im2double(I);
image_test=I(:)';
I_centre = image_test - mean(image_test);
I_projection = I_centre * W;
I_k = I_projection(:,1:2);

% Composantes principales des donnees d'apprentissage
C = X_centre*W;			

% Affichage des deux premieres composantes principales des donnees d'apprentissage :
hold on;
for i = 1:nb_individus
	lignes = (i-1)*nb_postures+1:i*nb_postures;
	plot(C(lignes,1),C(lignes,2),['*' 0.5*(rand(1,3)+1)],'MarkerSize',10,'LineWidth',2);
end
plot(I_k(1),I_k(2),"+");
proportion = 0.5;
ecart_x = max(C(:,1))-min(C(:,1));
min_x = min(C(:,1))-proportion*ecart_x;
max_x = max(C(:,1))+proportion*ecart_x;
ecart_y = max(C(:,2))-min(C(:,2));
min_y = min(C(:,2))-proportion*ecart_y;
max_y = max(C(:,2))+proportion*ecart_y;
axis([min_x max_x min_y max_y]);
axis equal;
set(gca,'FontSize',20);
xlabel('$C_1$','FontSize',30,'Interpreter','Latex');
ylabel('$C_2$','FontSize',30,'Interpreter','Latex');
