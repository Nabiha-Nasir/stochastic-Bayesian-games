### 1. Algorithm for player 1 in short horizon cases (action based strategy)
In dynamic stochasti Bayesian games, the game will be played for several, say 3, stages. Assume you are the maximizer at stage 2. So far, you observation is as follows. At stage 1, your private state is 2, you played action 3, and the minimizer played action 1. The one stage payoff won't be revealed until the end of the game. At stage 2, your private state jumps to 1. Based on the observed information, what is the optimal strategy for you? 

#### step 1: Initialization
In this step, you need to tell the code ????? the basic information about the game. ????? Details about the initial parameters ??????????????
Please also give a picture of the initialization part

#### step 2: Compute the optimal strategy
Call function ????. It will compute the both the optimal strategy ????, the game value ????, and the vector payoff ??? in case you need it in the dual game.

#### step 3: Run the game
In stage t, you need to first update your history observation which is organized as (k1,a1,b1,k2,a2,b2,k3,...,kt). Use function ???? to calculate the corresponding index of the strategy in ???. Draw an action according to ????????. 

Stop if arrive at the terminal stage.


### 2. Algorithm for player 2 in short horizon cases (action based strategy)
??????? please fill in this section for player 2 ?????????????????
