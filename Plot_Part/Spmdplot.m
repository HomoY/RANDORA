figure
hold on
c = ones(1,11)*12;
for i = 1:11
    c(i) = c(i)/i;
end
plot(1:11,c)