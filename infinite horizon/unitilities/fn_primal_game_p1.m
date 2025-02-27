function [sigma,nu] = fn_primal_game_p1(T,A,B,k,l,lm,P,Q,p,q,G)
%%% to get player 1's optimal strategy and nu
    warning('off')
    if k==size(P{1,1},1) && l==size(Q{1,1},1) && A==size(G{1,1},1) && B==size(G{1,1},2)
        %information set of player 1 and 2
        [is1,n_is1]=info_I(T,A,B,k);
        [is2,n_is2]=info_J(T,A,B,l);


        %Contraint R_{I_t}(a_t)=P_{a_{t-1},b_{t-1}}(k_{t-1},k_t)R_{I_{t-1}}(a_t-1)
        %\forall t=1,...n, \forall \mathcal{I}_t
        %Creating the equation as matrix multiplication [Aeq]*[variable]=[beq]. In
        %this equation the variable is R_{I_t}
        Aeq=zeros(sum(n_is1),sum(n_is1)*A);
        beq=zeros(sum(n_is1),1);

        row_index=0;
        for t=1:T
            for i=1:length(is1{t})
                row_index=row_index+1;
                for a=1:A  %As there is summation a_t in R_{I_{t}}
                    I=is1{t}(i,:); %for selecting each row from the information set of player 1
                    [col_index_RIt] = RIt_col_index_P1(t,I,A,B,k,a,n_is1); %finding the column index for that particular information set row
                    Aeq(row_index,col_index_RIt)=1;
                end
            kt=I(end);
                if t==1
                   beq(row_index,1)=p(kt); %As at t=1, P_{a_0,b_0}(k_0,k_1)=1 and R_{I_0}(a_0)=Pr(k1)
                else
                    Ipre=is1{t}(i,1:(length(is1{t}(i,:))-3));
                    aprev=is1{t}(i,(length(is1{t}(i,:))-2));
                    bprev=is1{t}(i,(length(is1{t}(i,:))-1));
                    [col_index_RItprev] = RIt_col_index_P1(t-1,Ipre,A,B,k,aprev,n_is1);
                    ktpre=I(end-3);
                    Aeq(row_index,col_index_RItprev)=-P{aprev,bprev}(ktpre,kt);
                end     
            end
        end  

        %for inequality contraints
        %Creating the equation as matrix multiplication [Ain]*[variables]=[bin]. In 
        %this equation the variables are R_{I_t},(U_{J_t},U_{J_{t+1}})
        [kset,~] = Kset(T,k);

        Ain=zeros(sum(n_is2)*B,(sum(n_is1)*A+sum(n_is2)));
        bin=zeros(sum(n_is2)*B,1);

        row_index=0;
        for t=1:T
            for j=1: length (is2{t}) %for different J_t and different b_t there will be different row
                for b=1:B
                    row_index=row_index+1;
                    for kn=1:length(kset{t})
                        for a=1:A
                            [I] = construct_Is(j,kn,t,kset,is2);
                            [col_index] = RIt_col_index_P1(t,I,A,B,k,a,n_is1);
                            Ain(row_index,col_index)=lm^(t-1)*G{I(3*t-2),(is2{t}(j,(3*t-2)))}(a,b); %R_{I_t} coefficient
                        end
                    end
                    %To find the term for U_{J_{t+1}}
                    if t<T  %As for U_{J_{N+1}}=0
                        for a1=1:A
                            for lplus=1:l  
                                Jplus=[is2{t}(j,:) a1 b lplus];
                                [col_index_Jplus] = J_col_index(n_is1,A,B,l,Jplus,n_is2,t+1);
                                 Ain(row_index,col_index_Jplus)=Q{a1,b}(is2{t}(j,end),lplus);%The coefficient for U_{J_{t+1}}
                            end
                        end      
                    end
                    %To find the term for U_{J_{t}}
                    Jpre=is2{t}(j,:);
                    [col_index_Jpre] = J_col_index(n_is1,A,B,l,Jpre,n_is2,t);
                     Ain(row_index,col_index_Jpre)=-1;
                end
            end
        end 

        %Construct the objective function
        f=[zeros(1,sum(n_is1)*A) q zeros(1,sum(n_is2(2:end)))]; %zeros(1,sum(n_is1)*A) is for R_{I_t} as there is no R_{I_t} in the objective function. zeros(1,sum(n_is2(2:end))) is for U_{J_{2:T}} as in objective function there is only U_{\mathcal{J}_{1}}

        %Rearrange every coefficient to use in linprog
        Ain1=-Ain; %As linprog use <=
        bin1=-bin; %As linprog use <=
        f1=-[zeros(1,size(Ain1,2)-size(f,2)) f ]; %as linprog works for only minimize obj function thats why -ve. To ensure that matrix of objective function and Ain,Aeq are of same size we add zeroes 
        Aeq1=padarray(Aeq,[0, (size(Ain1,2)-size(Aeq,2))],0,'post'); % to use linprog Ain and Aeq must have same column number as column number indicates variables. Both equation must have same variables
        lb=[zeros(sum(n_is1)*A,1);-Inf((size(Ain1,1)-sum(n_is1)*A),1)];
        ub=+Inf;

        options = optimoptions('linprog','Display','none');
        [x,v1]=linprog(f1,Ain1,bin1,Aeq1,beq,lb,ub,options); %x=[R_{I_t} U_{J_t}] and v1 is the game value


        %Finding the optimal strategy from the realization plan we got from previous linprog result
        %sigma=RIT/(P_{a_{t-1},b_{t-1}}(k_{t-1},k_t)*RI_{t-1})

        sigma=zeros(1,sum(n_is1));
        sigma_col=0;
        for t=1:T
            for i=1:length(is1{t})
                I=is1{t}(i,:); %for selecting each row from the information set of player 1
                sigma_col=sigma_col+1;
                for a=1:A  %As there is summation a_t in R_{I_{t}}
                    [row_index_RIt] = RIt_col_index_P1(t,I,A,B,k,a,n_is1); %finding the column index for that particular information set row. The number of column index in RIt is the number of row index in optimal realization plan x
                    RIt=x(row_index_RIt,1);        
                    kt=I(end);
                    if t==1
                       RItprev=p(kt);
                       pvalue=1;
                    else
                        Ipre=is1{t}(i,1:(length(is1{t}(i,:))-3));
                        aprev=is1{t}(i,(length(is1{t}(i,:))-2));
                        bprev=is1{t}(i,(length(is1{t}(i,:))-1));
                        [row_index_RItprev] = RIt_col_index_P1(t-1,Ipre,A,B,k,aprev,n_is1);
                        ktpre=I(end-3);
                        RItprev=x(row_index_RItprev,1);
                        pvalue=P{aprev,bprev}(ktpre,kt);
                    end
                    sigma(a,sigma_col)=RIt/(RItprev*pvalue);
                end
            end
        end

        %to find ontimal nu
        %to find UJ1
        for l_present=1:l
            t=1;
            info=l_present;
            [col_index_UJ1] = J_col_index(n_is1,A,B,l,info,n_is2,t);
            UJ1=x(col_index_UJ1,1);
            nu(l_present)=[UJ1];
        end
        nu=-nu; %as nu=-Z_{I_1}
    else
        'Error: Please check the dimensions of P,Q,G,k,l,A,B and try again.'
    end
end

