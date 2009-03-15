function ML=ML(a,b,c)
    ML=zeros(size(a));
    for i=1:451
        for j=1:451
            if(a(i,j)>b(i,j)&& a(i,j)>c(i,j))
                ML(i,j)=0;
            else if(b(i,j)>a(i,j)&& b(i,j)>c(i,j))
                    ML(i,j)=1;
                else
                    ML(i,j)=2;
                end
            end
        end
    end
end