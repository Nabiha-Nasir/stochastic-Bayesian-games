### Window by window algorithm

Assume the computational capacity only allow us to compute security strategies in games with n<N stages in a timely manner. For every n stages, we can compute and apply the security strategies in the n-stage game periodically. The problem is that, except the first window, no player has full access to the belief (p,q) in the other windows and cannot compute the security strategy in the primal game.
To solve this problem, we propose a window-by-window dual game based strategy as follows. 

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

#### step 2: Compute the initial vector payoff

Call the function [fn_primal_game_p1](https://github.com/Nabiha-Nasir/stochastic-Bayesian-games/blob/45e1fb93b86dba49be6d0c8de39f6528e309c4e7/action%20based%20strategy%20for%20short%20horizon%20cases/utilities/fn_primal_game_p1.m) for player 1 and [fn_primal_game_p2](https://github.com/Nabiha-Nasir/stochastic-Bayesian-games/blob/45e1fb93b86dba49be6d0c8de39f6528e309c4e7/action%20based%20strategy%20for%20short%20horizon%20cases/utilities/fn_primal_game_p2.m) for player 2 to get the inital vector payoff **nu** and **mu** for the window size.

#### step 3: Run Game

![image](https://user-images.githubusercontent.com/62413691/115869981-9fa6be80-a40c-11eb-8b75-446080e6859f.png)
