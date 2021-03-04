function [dist_min,Partition] = kppv(DataA,DataT,labelA,K,ListeClass)

[Na,~] = size(DataA);
[Nt,~] = size(DataT);

Nt_test = Nt; % A changer, pouvant aller de 1 jusqu'à Nt

% Initialisation du vecteur d'étiquetage des images tests
Partition = zeros(Nt_test,1);

disp(['Classification des images test dans ' num2str(length(ListeClass)) ' classes'])
disp(['par la methode des ' num2str(K) ' plus proches voisins:'])

dist_min =[];

% Boucle sur les vecteurs test de l'ensemble de l'évaluation
for i = 1:Nt_test
    
    disp(['image test n°' num2str(i)])

    % Calcul des distances entre les vecteurs de test 
    % et les vecteurs d'apprentissage (voisins)
    % A COMPLÉTER
    
    distances=sqrt(sum((DataA-repmat(DataT(i,:),Na,1)).^2,2));
    
    % On ne garde que les indices des K + proches voisins
    % A COMPLÉTER
    
    [~,ind_kppv]=sort(distances);
    dist_min=[dist_min,min(distances)];
    ind_kppv=ind_kppv(1:K);
    
    % Comptage du nombre de voisins appartenant à chaque classe
    % A COMPLÉTER
    nb_classes=length(ListeClass);
    classes_kppv=labelA(ind_kppv);
    nech=zeros(nb_classes,1);
    for j=1:nb_classes
        nech(j)=length(find(classes_kppv==ListeClass(j)));
    end

    % Recherche de la classe contenant le maximum de voisins
    % A COMPLÉTER
    
    [~,ind_max]=max(nech);
    
    % Si l'image test a le plus grand nombre de voisins dans plusieurs  
    % classes différentes, alors on lui assigne celle du voisin le + proche,
    % sinon on lui assigne l'unique classe contenant le plus de voisins 
    % A COMPLÉTER
    if length(ind_max)==1
        classe_test=ListeClass(ind_max);
    else
        classe_test=labelA(indkppv(1));
    end
    
    % Assignation de l'étiquette correspondant à la classe trouvée au point 
    % correspondant à la i-ème image test dans le vecteur "Partition" 
    % A COMPLÉTER
    Partition(i)=classe_test;
    
    
end

