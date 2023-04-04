function [c] = data_association_step(x,P,z,R)

% It there is no maps in the state vector, all the measurements are new, then C is assigned -1
% for the whole length of measurements z

if isempty (x(4:end))
      c(1:length(z)) = -1;
else
% splitting out the x components of map and y components of map into
% separate variables mx and my

i = 4:2:length(x) - 1;
mx(:,:) = x(i);
i = 5:2:lrngth(x);
my(:,:) = x(i);


% finding 2x3 matrix H
for i=1:length(mx) 
    H_sub(2*i - 1:2*i,:) = [((x(1) - mx(i))/sqrt((x(1) - mx(i)).^2 + (x(2) - my(i)).^2)) ((x(2) - mx(i))/sqrt((x(1) - mx(i)).^2 + (x(2) - my(i)).^2)) 0;
                            -((x(2) - my(i))/((x(1) - mx(i)).^2 + (x(2) - my(i)).^2)) ((x(1) - my(i))/((x(1) - mx(i)).^2 + (x(2) - my(i)).^2)) -1];
end;
for i=1:length(mx)
    Hm(2*i-1:2*i,:)=[-((x(1)-mx(i)/sqrt((x(1)-mx(i)).^2 + (x(2)-my(i)).^2)) - ((x(2)-my(i))/sqrt((x(i)-mx(i)).^2 + (x(2)-my(i).^2));
                     ((x(2)-my(i))/((x(1)).^2 + (x(2)-my(i)).^2 - ((x(1)-mx(i))/((x(1)-mx(i).^2 + (x(2)-my(i)).^2];
end;

Hm1=zeros(length(Hm),length(Hm));

for i=1:length(mx);
    j=i;
    Hm1(2*i-1:2*i, 2*j-1:2*j) = Hm(2*i-1:2*i,:);
end;

H = [H_sub Hm1];

% converting the landmarks from cartesian back to polar coordinates
i=1:length(mx);
hy(:,:)=[sqrt((x(1)-mx(i)).^2+(x(2)-my(i)).^2) pi_to_pi(atan2((x(2)-my(i)) ((x(1)-mx(i))))-x(3)-(pi/2))];
hy=hy';

for i=1:length(hy)
    v(2*i-1:2*i,:)=z-repmat(hy(:,i),1,size(z,2));
    
    % finding the innovation between all the measurements and each landmark
    
    H = [H_sub(2*i-1:2*i,:) Hm(2*i-1:2*i,:)]; % matrix H
    Pxx = P(1:3,1:3);
    Pmx = P(2*i+2:2*i+3,1:3);
    Pmm = P(2*i+2:2*i+3, 2*i+2:2*i+3);
    p = [Pxx;Pmx];
    Pmm=[Pmx';Pmm];
    p = [p Pmm];     % matrix P
    S = H*p*H'+R;    % calculating the matrix S
    
    % calculating the mahalanobis distance
    
    width=size(v);
    for j=1:width(2);
        M(j,i) = v(2*i-1:2*i,j)'*inv(S)*v(2*i-1:2*i,j);
    end;
end;

width1=size(z);
i=1:width1(1,2);
c(i)=-1;   % initializing the entire C = -1

for i=1:size(hy,2)
    min_Value = min(abs(M(:,i)));
    if(min_Value < 6)
        r = find(abs((M(:,i)))==min_Value);
        % checking in each coloumn if the distance is less than 6
        if length(r)==1
            c(r)=i; %setting the measurement as the associated landmark represented by the coloumn
            
        end;
    end;
end;


end;
end; 
        