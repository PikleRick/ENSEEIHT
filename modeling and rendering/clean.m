function [vx,vy] = clean(im_mask_1, vx, vy,nb_lignes,nb_colonnes)

vx_1 = vx(1,:);
vx_2 = vx(2,:);
vy_1 = vy(1,:);
vy_2 = vy(2,:);

% filtres_x = [vx_1 >= 1; vx_2 >= 1; vx_1 <= nb_colonnes,; ...
%     vx_2 <= nb_colonnes];
% filtres_y = [vy_1 >= 1; vy_2 >= 1; vy_1 <= nb_lignes; ...
%     vy_2 <= nb_lignes];
% 
% for i=1:4
%     vx_1 = vx_1(filtres_x(i));
%     vx_2 = vx_2(filtres_x(i));
%     vy_1 = vy_1(filtres_x(i));
%     vy_2 = vy_2(filtres_x(i));
%     
%     vx_1 = vx_1(filtres_y(i));
%     vx_2 = vx_2(filtres_y(i));
%     vy_1 = vy_1(filtres_y(i));
%     vy_2 = vy_2(filtres_y(i));
% end


filtre_x = vx_1 >= 1;
vx_1 = vx_1(filtre_x);
vx_2 = vx_2(filtre_x);
vy_1 = vy_1(filtre_x);
vy_2 = vy_2(filtre_x);

filtre_x = vx_2 >= 1;
vx_1 = vx_1(filtre_x);
vx_2 = vx_2(filtre_x);
vy_1 = vy_1(filtre_x);
vy_2 = vy_2(filtre_x);

filtre_x = vx_1 <= nb_colonnes;
vx_1 = vx_1(filtre_x);
vx_2 = vx_2(filtre_x);
vy_1 = vy_1(filtre_x);
vy_2 = vy_2(filtre_x);

filtre_x = vx_2 <= nb_colonnes;
vx_1 = vx_1(filtre_x);
vx_2 = vx_2(filtre_x);
vy_1 = vy_1(filtre_x);
vy_2 = vy_2(filtre_x);

ind_y = vy_1 >= 10;
vx_1 = vx_1(ind_y);
vx_2 = vx_2(ind_y);
vy_1 = vy_1(ind_y);
vy_2 = vy_2(ind_y);

ind_y = vy_2 >= 10;
vx_1 = vx_1(ind_y);
vx_2 = vx_2(ind_y);
vy_1 = vy_1(ind_y);
vy_2 = vy_2(ind_y);

ind_y = vy_1 <= nb_lignes;
vx_1 = vx_1(ind_y);
vx_2 = vx_2(ind_y);
vy_1 = vy_1(ind_y);
vy_2 = vy_2(ind_y);

ind_y = vy_2 <= nb_lignes;
vx_1 = vx_1(ind_y);
vx_2 = vx_2(ind_y);
vy_1 = vy_1(ind_y);
vy_2 = vy_2(ind_y);

% Filtrage selon les pixels interieurs à la forme
p_x = round(vx_1);
p_y = round(vy_1);
in = [];
for k=1:length(p_x)
    if (im_mask_1(p_y(k),p_x(k)) == 1)
        in = [in, k];
    end
end

vx_1 = vx_1(in);
vy_1 = vy_1(in);
vx_2 = vx_2(in);
vy_2 = vy_2(in);

vx = [vx_1;
      vx_2];
vy = [vy_1; 
      vy_2];
end
