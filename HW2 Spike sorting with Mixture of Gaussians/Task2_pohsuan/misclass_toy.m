function Mis=misclass_toy(assignments)
V=perms(1:3);
for i =1:length(V)
idx_true(:,i)=[V(i,1)*ones(300,1);V(i,2)*ones(500,1);V(i,3)*ones(200,1)];
end
idx_m=bsxfun(@times, idx', ones(1,size(V,1)));
Mis= min(sum(not(idx_true==idx_m))); % misclassification

end