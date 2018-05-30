% Deja porté
function [ZI] = rectifSignal(I_ng,H,invH,Xi)

Yi = zeros(1,length(Xi));

PT = [ Xi ; Yi ; ones(1,length(Xi)) ];
iPT = H*PT;
iPT = [ iPT(1,:)./iPT(3,:) ; iPT(2,:)./iPT(3,:) ; ones(1,size(iPT,2)) ];

ZI = interp2(double(I_ng),iPT(1,:),iPT(2,:),'bicubic');

%x = iPT(1,1:20:end)
%y = iPT(2,1:20:end)
%ZI(1:20:end)
%pause

%imagesc(I_ng);axis equal; colormap gray ; hold on;
%plot(x,y,'g+');
%pause

% Cas où l'on sort de l'image
% On remplace les Nan par la moyenne du signal sur ZI ~= NaN

inotnan = find(~isnan(ZI));

if (length(inotnan) ~= length(ZI))
	msig = mean(ZI(inotnan));
else
	return;
end

inan = setdiff(1:length(ZI),inotnan);
ZI(inan) = msig;
