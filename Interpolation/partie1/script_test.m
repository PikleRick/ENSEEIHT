%% Test Script 
% Please enter the number of Iterations and the degre : 

clear all

prompt = 'Entrez le nombre d''itérations: ';
nbIter = input(prompt);

prompt1 = 'Entrez le degre: ';
degre = input(prompt1); 

if nbIter>0 && degre>0
    Splines_unif_pt();
else 
    disp('Error: Please try again'); 
end 
