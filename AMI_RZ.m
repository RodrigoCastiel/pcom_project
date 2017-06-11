function AMI_RZ()
%Line code AMI RZ.
%Author: Diego Orlando Barragn Guerrero
%For more information, visit: www.matpic.com
%diegokillemall@yahoo.com
%Example:
h=[1 0 0 1 1 0 1 0 1 0 0 0 0 0 1];
%h=[0 1 0 1 1 1 0 0 0 0 1 0 1 1 0 1 0 0 0 0 0 0 0 0 0 0 1 0 1 1 0 1 0 1 0 0 0 0 1 ];

%AMIRZ(h)
i=1;
z=0;
even=1;
st=0;
frequency=0.001;

while(i<length(h))
    if (~h(i)) 
        z = z+1;
    else
        z=0;
        even=~even;
    end
    if (z == 4)
        if(even && st)
            h(i-3)=1;
        end
        st=1;
        h(i)=-1;
        z=0;
    end
    i = i+1;
end
clf;
n=1;
l=length(h);
h(l+1)=1;
ami=-1;
while n<=length(h)-1;
    t=n-1:frequency:n;
    if h(n) == 0
        y=(t>n);
        
        d=plot(t,y);grid on;
        title('Line code AMI RZ');
        set(d,'LineWidth',2.5);
        hold on;
        axis([0 length(h)-1 -1.5 1.5]);
        disp('zero');
    elseif h(n)==1
        ami=ami*-1;
        if h(n+1)==0
            if ami==1
                y= ( abs(t-n+0.5)<=0.25);
            else
                y=-( abs(t-n+0.5)<=0.25);
            end
        else
            if ami==1
                y=( abs(t-n+0.5)<=0.25);
            else
                y=-( abs(t-n+0.5)<=0.25);
            end
            
        end
        %y=(t>n-1)+(t==n-1);
        d=plot(t,y);grid on;
        title('Line code AMI RZ');
        set(d,'LineWidth',2.5);
        hold on;
        axis([0 length(h)-1 -1.5 1.5]);
        disp('one');
    else
        
        if h(n+1)==0
            if ami==1
                y=( abs(t-n+0.5)<=0.25);
            else
                y=-( abs(t-n+0.5)<=0.25);
            end
        else
            if ami==1
                y=( abs(t-n+0.5)<=0.25);
            else
                y=-( abs(t-n+0.5)<=0.25);
            end
            
        end
        %y=(t>n-1)+(t==n-1);
        d=plot(t,y);grid on;
        title('Line code AMI RZ');
        set(d,'LineWidth',2.5);
        hold on;
        axis([0 length(h)-1 -1.5 1.5]);
        disp('viola'); 
    end
    samples = 1.0/frequency;
    x=0;
    for  j= 0.25*samples:((0.75*samples)+1)
        x = x+y(j);
%         j = j+1;
    end
    answer=0;
    if(samples*0.25<=x)answer=1;
    
    elseif(samples*-0.25>=x)answer=-1;
    end;
    answer
    n=n+1;
    %pause; 
end

