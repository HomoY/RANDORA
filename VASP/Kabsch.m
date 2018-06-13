function U=Kabsch(P,Q)
%C=PQt
C=P*Q';

%svd
[V,S,W]=svd(C);

d=sign(det(C));

U=W*[1 0 0;0 1 0;0 0 d]*V';
end