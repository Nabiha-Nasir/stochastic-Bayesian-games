### Receding horizon algorithm
Assume there is a game which runs for infinite number of stages and the computational capacity only allow us to compute security strategies in games with T<N stages in a timely manner. For this situation we have introduced receding horizon algorithm where players compute the optimal strategies for first T stages and take action for the first stage. Then move the T sized window 1 stage ahead, compute the optimal strategies and take action for the first stage of that window which is actually the 2nd stage in the game horizon. The performance of this algorithm is better than window by window method as at each stage it is computing the sufficient statistic based optimal strategy and take action accordingly. 

#### Step 1: Initialization
In this step, you need to tell the code the basic information about the game. The basic informations of this code are:

- **T**: Window size
- **N**: Game horizon
- **A**: The number of actions of player 1
- **B**: The number of actions of player 2
- **k**: The number of private state of player 1
- **l**: The number of private state of player 2
- **P**: The format of transition matrices in Fig. 2 in Matlab code is given below.
![image](https://user-images.githubusercontent.com/62413691/116102425-b2272f00-a67c-11eb-8e90-afb418449c78.png)

- **Q**: The format of transition matrices in Fig. 2 in Matlab code is given below.
![image](https://user-images.githubusercontent.com/62413691/116102535-ca974980-a67c-11eb-9109-f208c61bde5e.png)
- **p**: Initial probability of player 1's initial state. Matlab code format: p=[0.5 0.3 0.2]=[Pr(k=1) Pr(k=2) Pr(k=3)]
- **q**: Initial probability of player 2's initial state. Matlab code format: p=[0.5 0.5]=[Pr(l=1) Pr(l=2)]
- **G**: The format of payoff matrices in Fig. 1 in Matlab code is given below.
![image](https://user-images.githubusercontent.com/62413691/116102770-f9adbb00-a67c-11eb-9142-654be36cea4b.png)
- **lm**: To create discounted game (0< lm <=1)

![image](https://user-images.githubusercontent.com/62413691/115906826-0e4c4200-a436-11eb-9033-935d2413d723.png)

#### Step 2: Compute the initial vector payoff and strategy at stage 1
At stage 1, call function [fn_primal_game_p1]( https://github.com/Nabiha-Nasir/stochastic-Bayesian-games/blob/936a572474f692ff7be8e14bc090d2b04601ad39/action%20based%20strategy%20for%20short%20horizon%20cases/utilities/fn_primal_game_p1.m) to compute the initial vector payoff nu and the optimal strategy of player 1 sigma. Call function [fn_primal_game_p2]( https://github.com/Nabiha-Nasir/stochastic-Bayesian-games/blob/936a572474f692ff7be8e14bc090d2b04601ad39/action%20based%20strategy%20for%20short%20horizon%20cases/utilities/fn_primal_game_p2.m) to compute the initial vector payoff mu and the optimal strategy of player 2 tau.



#### Step 3: Run the Game
The receding horizon algorithm to run the game is given in Fig. 4

![image](https://user-images.githubusercontent.com/62413691/115909649-cb8c6900-a439-11eb-8994-50ea50eb9e74.png)


#### About the files of this folder

The code receding_method.m is an example of 36 stage game and both of the player uses receding horizon algorithm to compute their strategies. The files and functions required to run the code are in the utilities folder.
