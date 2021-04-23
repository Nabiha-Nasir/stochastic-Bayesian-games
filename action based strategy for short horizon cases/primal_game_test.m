clear all;
close all;
clc;

%% Initialization
%%%Every element of P and Q should be non-negative and every row sums to 1.
load P.mat; %transition matrix of player 1
load Q.mat; %transition matrix of player 2
load M.mat; %payoff matrix
G=M;
T=2; %Number of stages in a game
A=2; %Number of player 1's actions
B=2; %Number of player 2's actions
k=3; %Number of states of player 1
l=2; %Number of states of player 2
lm=0.3; %discounted value
p=[0.5 0.3 0.2]; %player 1's initial probability for state
q=[0.5 0.5];     %player 2's initial probability for state


%information set of player 1 and 2
[is1,n_is1]=info_I(T,A,B,k);
[is2,n_is2]=info_J(T,A,B,l);


%% Compute the optimal strategy
%Optimal strategy of player 1
[sigma,nu,v1] = fn_primal_game_p1(T,A,B,k,l,lm,P,Q,p,q,G);
%Optimal strategy of player 2
[tau,mu,v2] = fn_primal_game_p2(T,A,B,k,l,lm,P,Q,p,q,G);

%% Run the game
payoff_list=[];
my_loop=2000; %to run the experiemnt several times to get the average result

for m=1:my_loop
    payoff=0;
    X_star=sigma(:,1:k); %this means all rows and col 1: to k. This is the optimal strategy for player 1 in t=1
    Y_star=tau(:,1:l); %this means all rows and col 1: to L. This is the optimal strategy for player 2 in t=1

    %Choose 1st stage's state of player 1: k_1
    [k_present] = choose_state(p,k);
    %Choose 1st stage's state of player 2: l_1
    [l_present] = choose_state(q,l);

    Ha=[k_present];
    Hb=[l_present]; 
    action_p1=[];
    action_p2=[];

    for i=1:T

        %Choose player 1's strategy sigma for stage i
        [col_index_sigma] = sigma_col_index_new(A,B,k,k_present,Ha,i,T); %For first T sized window we are getting sigma from primal game and specific Ha this is my X*
        %Choose player 2's strategy tau
        [col_index_tau] = tau_col_index_new(A,B,l,l_present,Hb,i,T); %For first T sized window we are getting tau from primal game and specific Hb this is my Y*

        %Choose player 1's action a_1 accoriding to the strategy sigma
        [a] = choose_action(sigma,A,col_index_sigma);

        %Choose player 2's action b_1 accoriding to the strategy tau
        [b] = choose_action(tau,B,col_index_tau);

        %Payoff
        payoff=payoff+G{k_present,l_present}(a,b)*lm^(i-1);

        % update state
        if i<T  %As after last stage there will be no new state
            %for k
            k_prob=P{a,b}(k_present,:);
            [k_present] = choose_state(k_prob,k);

            %for l
            l_prob=Q{a,b}(l_present,:);
            [l_present] = choose_state(l_prob,l);

            % update history
             Ha=[Ha a b k_present];
             Hb=[Hb a b l_present];
        else
            % update history
              Ha=[Ha a b];
              Hb=[Hb a b];
        end
    end
    payoff_list=[payoff_list payoff];
end

avg_payoff=sum(payoff_list)/my_loop

