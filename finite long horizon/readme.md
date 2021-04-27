### Window by window algorithm

Assume the computational capacity only allow us to compute security strategies in games with T<N stages in a timely manner. For every T stages, we can compute and apply the security strategies in the T-stage game periodically. The problem is that, except the first window, no player has full access to the belief (p,q) in the other windows and cannot compute the security strategy in the primal game.
To solve this problem, we propose a window-by-window dual game based strategy as follows. 

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

#### Step 2: Run the Game

![](pics/window_by_window.PNG)

#### About the files of this folder

The code window_by_window_method.m is an example of 36 stage game and both of the player uses window by window method to compute their strategies. The files and functions required to run the code are in the utilities folder. 

