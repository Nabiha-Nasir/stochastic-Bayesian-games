### 1. Algorithm for player 1 in short horizon cases (action based strategy)
In dynamic stochastic Bayesian games, the game will be played for several, say 3, stages. Assume you are the maximizer at stage 2. So far, your observation is as follows. At stage 1, your private state is 2, you played action 2, and the minimizer played action 1. The one stage payoff won't be revealed until the end of the game. At stage 2, your private state jumps to 1. Based on the observed information, what is the optimal strategy for you? 

#### step 1: Initialization
In this step, you need to tell the code [primal_game_value_P1.m](https://github.com/Nabiha-Nasir/stochastic-Bayesian-games/blob/0fe815a92cbd181c609518bea9a1a6f8b5194ca4/action%20based%20strategy%20for%20short%20horizon%20cases/primal_game_value_P1.m) the basic information about the game. The basic informations of this code are T,A,B,k,l,lm,P,Q,p,q,G where, T is the total number of stages in the game, A and B are the number of actions of player 1 and 2, respectively. k is the number of private state of player 1 and l is the number of private state of player 2. lm is to create discounted game. The value of lm should be between 0 to 1. If lm<1 and the number of stages of the game is finite then it creates truncated discounted game. If lm<1 and the number of stages of the game is infinite then it creates discounted game. P is the transition matrices of player 1. The matrix form of P is P_{at, bt}(k,k'). It provides a probability matrix of player 1's state to jump from one state (k) to another state (k') when the current action of player 1 is at and player 2 is bt. Q is the transition matrices of player 2. The matrix form of Q is Q_{at, bt}(l,l'). It provides a probability matrix of player 2's state to jump from one state (l) to another state (l') when the current action of player 1 is at and player 2 is bt. p is a row vector which the independent initial probability of player 1's initial state. For example, p=[p1 p2 p3] where p1 is the probability of player 1's initial state to be 1. Similaryly, q is a row vector which the independent initial probability of player 2's initial state. For example, q=[q1 q2 q3] where q1 is the probability of player 2's initial state to be 1. G is the payoff matrix and its matrix form is G_{kt,lt}(at, bt).

![image](https://user-images.githubusercontent.com/62413691/115548983-19587400-a276-11eb-98c5-3263fa29b59d.png)


#### step 2: Compute the optimal strategy
Call function ????. It will compute the both the optimal strategy ????, the game value ????, and the vector payoff ??? in case you need it in the dual game.

#### step 3: Run the game
In stage t, you need to first update your history observation which is organized as (k1,a1,b1,k2,a2,b2,k3,...,kt). Use function ???? to calculate the corresponding index of the strategy in ???. Draw an action according to ????????. 

Stop if arrive at the terminal stage.


### 2. Algorithm for player 2 in short horizon cases (action based strategy)
??????? please fill in this section for player 2 ?????????????????



The 'utilities' folder contains all the required function and files to run the code of primal and dual game LP
