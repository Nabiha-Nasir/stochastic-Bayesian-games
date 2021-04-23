### 1. Algorithm for player 1 in short horizon cases (action based strategy)
In dynamic stochastic Bayesian games, the game will be played for several, say 3, stages. Assume you are the maximizer at stage 2. So far, your observation is as follows. At stage 1, your private state is 2, you played action 2, and the minimizer played action 1. The one stage payoff won't be revealed until the end of the game. At stage 2, your private state jumps to 1. Based on the observed information, what is the optimal strategy for you? 

#### step 1: Initialization
In this step, you need to tell the code the basic information about the game. The basic informations of this code are:

- **T**: Total number of stages in the game
- **A**: The number of actions of player 1
- **B**: The number of actions of player 2
- **k**: The number of private state of player 1
- **l**: The number of private state of player 2
- **P**: Transition matrix of player 1. Format of P in the matlab code: If k=2, P(at,bt}=[Pr(kt=1,k(t+1)=1) Pr(kt=1,k(t+1)=2); Pr(kt=2,k(t+1)=1) Pr(kt=2,k(t+1)=2)]. For example, when k=3 and the actions (a,b)=(1,2) then P{1,2}=[.4 .5 .1; .2 .3 .5; .4 .4 .2 ]. Here, when a=1 and b=2 the probability of player 1's state jump from k=2 to k=2 is 0.3. Notice that the state is jumping from row element to column element. Every element of P should be non-negative and every row sums to 1.
- **Q**: Transition matrix of player 2. Format of Q in the matlab code: If l=2, P(at,bt}=[Pr(lt=1,l(t+1)=1) Pr(lt=1,l(t+1)=2); Pr(lt=2,l(t+1)=1) Pr(lt=2,l(t+1)=2)]. For example, when l=3 and the actions (a,b)=(1,1) then Q{1,1}=[.8 .2;.5 .5]. In this example, when a=1 and b=2 the probability of player 1's state jump from l=1 to l=2 is 0.5. Notice that the state is jumping from row element to column element. Every element of Q should be non-negative and every row sums to 1.
- **p**: Initial probability of player 1's initial state. Matlab code format: p=[0.5 0.3 0.2]=[Pr(k=1) Pr(k=2) Pr(k=3)]
- **q**: Initial probability of player 2's initial state. Matlab code format: p=[0.5 0.5]=[Pr(l=1) Pr(l=2)]
- **G**: Payoff Matrix, Format of G in the matlab code: If the actions (kt,lt)=(1,1) then G{1,1}= [108.89,113.78;108.89,113.78]
- **lm**: To create discounted game (0< lm <=1)

![image](https://user-images.githubusercontent.com/62413691/115858717-4be0a900-a3fd-11eb-95b0-c24b3321a0b0.png)


#### step 2: Compute the optimal strategy
Call function [fn_primal_game_p1](https://github.com/Nabiha-Nasir/stochastic-Bayesian-games/blob/936a572474f692ff7be8e14bc090d2b04601ad39/action%20based%20strategy%20for%20short%20horizon%20cases/utilities/fn_primal_game_p1.m). It will compute the game value **v1**, the optimal strategy of player 1 **sigma**, and the vector payoff **nu** in case you need it in the dual game. 

#### step 3: Run the game
In stage t, you need to first update your history observation which is organized as Ha=[k1,a1,b1,k2,a2,b2,k3,...,kt]. Use function [[col_index_sigma] = sigma_col_index_new(A,B,k,k_present,Ha,t,T)]( https://github.com/Nabiha-Nasir/stochastic-Bayesian-games/blob/ab0538a8d4ff0bc1c9db4dbb0af1ccddbb09de19/finite%20long%20horizon/unitilities/sigma_col_index_new.m) to calculate the corresponding index of the strategy in sigma at t stage when k_present is player 1's current state. Draw an action according to the output of the function [[a] = choose_action(sigma,A,col_index_sigma)](https://github.com/Nabiha-Nasir/stochastic-Bayesian-games/blob/eea7a9e0a24a1acc7d0f17bb9aeb07595dea4ff8/action%20based%20strategy%20for%20short%20horizon%20cases/utilities/choose_action.m). 

Stop if arrive at the terminal stage.

### 2. Algorithm for player 2 in short horizon cases (action based strategy)
Say the dynamic stochastic Bayesian game will be played for 3, stages. Assume this time you are the minimizer at stage 2. So far, your observation is as follows. At stage 1, your private state is 2, you played action 2, and the maximizer played action 1. The one stage payoff won't be revealed until the end of the game. At stage 2, your private state jumps to 1. Based on the observed information, what is the optimal strategy for you? 

#### step 1: Initialization
In this step, you need to tell the code the basic information about the game. The basic informations of this code are:

- **T**: Total number of stages in the game
- **A**: The number of actions of player 1
- **B**: The number of actions of player 2
- **k**: The number of private state of player 1
- **l**: The number of private state of player 2
- **P**: Transition matrix of player 1. Format of P in the matlab code: If k=2, P(at,bt}=[Pr(kt=1,k(t+1)=1) Pr(kt=1,k(t+1)=2); Pr(kt=2,k(t+1)=1) Pr(kt=2,k(t+1)=2)]. For example, when k=3 and the actions (a,b)=(1,2) then P{1,2}=[.4 .5 .1; .2 .3 .5; .4 .4 .2 ]. Here, when a=1 and b=2 the probability of player 1's state jump from k=2 to k=2 is 0.3. Notice that the state is jumping from row element to column element. Every element of P should be non-negative and every row sums to 1.
- **Q**: Transition matrix of player 2. Format of Q in the matlab code: If l=2, P(at,bt}=[Pr(lt=1,l(t+1)=1) Pr(lt=1,l(t+1)=2); Pr(lt=2,l(t+1)=1) Pr(lt=2,l(t+1)=2)]. For example, when l=3 and the actions (a,b)=(1,1) then Q{1,1}=[.8 .2;.5 .5]. In this example, when a=1 and b=2 the probability of player 1's state jump from l=1 to l=2 is 0.5. Notice that the state is jumping from row element to column element. Every element of Q should be non-negative and every row sums to 1.
- **p**: Initial probability of player 1's initial state. Matlab code format: p=[0.5 0.3 0.2]=[Pr(k=1) Pr(k=2) Pr(k=3)]
- **q**: Initial probability of player 2's initial state. Matlab code format: p=[0.5 0.5]=[Pr(l=1) Pr(l=2)]
- **G**: Payoff Matrix, Format of G in the matlab code: If the actions (kt,lt)=(1,1) then G{1,1}= [108.89,113.78;108.89,113.78]
- **lm**: To create discounted game (0< lm <=1)

![image](https://user-images.githubusercontent.com/62413691/115858717-4be0a900-a3fd-11eb-95b0-c24b3321a0b0.png)

#### step 2: Compute the optimal strategy
Call function [fn_primal_game_p2](https://github.com/Nabiha-Nasir/stochastic-Bayesian-games/blob/936a572474f692ff7be8e14bc090d2b04601ad39/action%20based%20strategy%20for%20short%20horizon%20cases/utilities/fn_primal_game_p2.m). It will compute the game value **v2**, the optimal strategy of player 1 **tau**, and the vector payoff **mu** in case you need it in the dual game. 

#### step 3: Run the game
In stage t, you need to first update your history observation which is organized as Hb=[l1,a1,b1,l2,a2,b2,l3,...,lt]. Use function [[col_index_tau] = tau_col_index_new(A,B,l,l_present,Hb,t,T)]( https://github.com/Nabiha-Nasir/stochastic-Bayesian-games/blob/68faf04f2c67924d49ab5549814d596674d202d7/action%20based%20strategy%20for%20short%20horizon%20cases/utilities/tau_col_index_new.m) to calculate the corresponding index of the strategy in tau at t stage when l_present is player 2's current state. Draw an action according to the output of the function [[b] = choose_action(tau,B,col_index_tau)](https://github.com/Nabiha-Nasir/stochastic-Bayesian-games/blob/eea7a9e0a24a1acc7d0f17bb9aeb07595dea4ff8/action%20based%20strategy%20for%20short%20horizon%20cases/utilities/choose_action.m). 

Stop if arrive at the terminal stage.

### About the files of this folder
The code primal_game_test.m is an example of a 2 stage game where player 1 and 2 compute their optimal strategy using primal game LP and take action accordingly. The 'utilities' folder contains all the required function and files to run this code.
