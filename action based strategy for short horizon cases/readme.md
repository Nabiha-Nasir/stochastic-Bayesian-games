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

![image](https://user-images.githubusercontent.com/62413691/115548983-19587400-a276-11eb-98c5-3263fa29b59d.png)


#### step 2: Compute the optimal strategy
Call function [fn_primal_game_p1](https://github.com/Nabiha-Nasir/stochastic-Bayesian-games/blob/49a371d2ff1eaafb2a0d65639e2f9a2c53a3e804/action%20based%20strategy%20for%20short%20horizon%20cases/utilities/fn_primal_game_p1.m). It will compute the both the optimal strategy of player 1 **sigma**, and the vector payoff **nu** in case you need it in the dual game. It also compute the game value **v1** which is not currently listed as output of this function. But we can easily get it from this code. 

#### step 3: Run the game
In stage t, you need to first update your history observation which is organized as Ha=(k1,a1,b1,k2,a2,b2,k3,...,kt). Use function [[col_index_sigma] = sigma_col_index_new(A,B,k,k_present,Ha,t,n_is1)](https://github.com/Nabiha-Nasir/stochastic-Bayesian-games/blob/a1c51a816e9903844695c55a53fcdca4f7d04212/action%20based%20strategy%20for%20short%20horizon%20cases/utilities/sigma_col_index_new.m) to calculate the corresponding index of the strategy in sigma. Here, Ha is the history observation set, k_present is player 1's current state and n_is1 is the total number of possible information sets of player 1 at all the stages. Draw an action according to the output of the function [[a] = choose_action(sigma,A,col_index_sigma)](https://github.com/Nabiha-Nasir/stochastic-Bayesian-games/blob/a1c51a816e9903844695c55a53fcdca4f7d04212/action%20based%20strategy%20for%20short%20horizon%20cases/utilities/choose_action.m). 

Stop if arrive at the terminal stage.

### 2. Algorithm for player 2 in short horizon cases (action based strategy)
Say the dynamic stochastic Bayesian game will be played for 3, stages. Assume this time you are the minimizer at stage 2. So far, your observation is as follows. At stage 1, your private state is 2, you played action 2, and the maximizer played action 1. The one stage payoff won't be revealed until the end of the game. At stage 2, your private state jumps to 1. Based on the observed information, what is the optimal strategy for you? 

#### step 1: Initialization
In this step, you need to tell the code the basic information about the game. The basic informations of this code are T,A,B,k,l,lm,P,Q,p,q,G where, T is the total number of stages in the game, A and B are the number of actions of player 1 and 2, respectively. k is the number of private state of player 1 and l is the number of private state of player 2. lm is to create discounted game. The value of lm should be between 0 to 1. If lm<1 and the number of stages of the game is finite then it creates truncated discounted game. If lm<1 and the number of stages of the game is infinite then it creates discounted game. P is the transition matrices of player 1. The matrix form of P is P_{at, bt}(k,k'). It provides a probability matrix of player 1's state to jump from one state (k) to another state (k') when the current action of player 1 is at and player 2 is bt. Q is the transition matrices of player 2. The matrix form of Q is Q_{at, bt}(l,l'). It provides a probability matrix of player 2's state to jump from one state (l) to another state (l') when the current action of player 1 is at and player 2 is bt. p is a row vector which the independent initial probability of player 1's initial state. For example, p=[p1 p2 p3] where p1 is the probability of player 1's initial state to be 1. Similaryly, q is a row vector which the independent initial probability of player 2's initial state. For example, q=[q1 q2 q3] where q1 is the probability of player 2's initial state to be 1. G is the payoff matrix and its matrix form is G_{kt,lt}(at, bt).

![image](https://user-images.githubusercontent.com/62413691/115548983-19587400-a276-11eb-98c5-3263fa29b59d.png)

#### step 2: Compute the optimal strategy
Call function [fn_primal_game_p2](https://github.com/Nabiha-Nasir/stochastic-Bayesian-games/blob/a9a28d929bcdb1207fca66a0efc540856395ae02/action%20based%20strategy%20for%20short%20horizon%20cases/utilities/fn_primal_game_p2.m). It will compute the both the optimal strategy of player 2 **tau**, and the vector payoff **mu** in case you need it in the dual game. It also compute the game value **v2** which is not currently listed as output of this function. But we can easily get it from this code. 

#### step 3: Run the game
In stage t, you need to first update your history observation which is organized as (l1,a1,b1,l2,a2,b2,l3,...,lt). Use function [[col_index_tau] = tau_col_index_new(A,B,l,l_present,Hb,t,n_is2)](https://github.com/Nabiha-Nasir/stochastic-Bayesian-games/blob/6d9824b736e3b536b060ccd5e69b15fb642d8b8a/action%20based%20strategy%20for%20short%20horizon%20cases/utilities/tau_col_index_new.m) to calculate the corresponding index of the strategy in tau. Here, Hb is the history observation set, l_present is player 2's current state and n_is2 is the total number of possible information sets of player 2 at T stage game. Draw an action according to the output of the function [[b] = choose_action(tau,B,col_index_tau)](https://github.com/Nabiha-Nasir/stochastic-Bayesian-games/blob/a1c51a816e9903844695c55a53fcdca4f7d04212/action%20based%20strategy%20for%20short%20horizon%20cases/utilities/choose_action.m). 

Stop if arrive at the terminal stage.

### About the files of this folder
The 'utilities' folder contains all the required function and files to run the code of primal and dual game LP. In this folder, the file [primal_game_value_P1.m](https://github.com/Nabiha-Nasir/stochastic-Bayesian-games/blob/1cf81b156f5a87a0a6dfd91e303fd4a893732577/action%20based%20strategy%20for%20short%20horizon%20cases/primal_game_value_P1.m) is an example of primal game code of player 1 for 2 stage game and [primal_game_value_P2.m](https://github.com/Nabiha-Nasir/stochastic-Bayesian-games/blob/1cf81b156f5a87a0a6dfd91e303fd4a893732577/action%20based%20strategy%20for%20short%20horizon%20cases/primal_game_value_P2.m) is an example of primal game code of player 2 for 2 stage game.
