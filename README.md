# LPs for two-player zero-sum stochastic-Bayesian-games
### 1. Two-player zero-sum stochastic Bayesian games
Two-player zero-sum Bayesian games are dynamic games where two players play against each other for several stages. Sometimes, they will play against each other forever. In this game, every player has its own private information (which is also called the private state), say 'k' for player 1 (maximizer) and 'l' for player 2 (minimizer). At every stage, the players need to take actions based on the information they have, and the one-stage payoff is decided by both payers' actions and private states. The game is played for several stages. When the game evolves to the next stage, the players' private states will change according to a Markovian rule based on the current private states and the current actions of both players. If we want to benefit from long time behavior, playing greedily in the current stage might not be the best solution. 
We are interested in a computationally efficient way to find the optimal solution for the players. For this purpose, we build this project.

### 2. Some terminologies.
**Player 1** is the maximizer and also the row player (you will know what we mean by ‘row’ or ‘column’ player when we introduce the payoff matrix). Its action and private state at stage t are indicated by **at** and **kt**. We use A and K to denote the set of actions and private states of player 1.

**Player 2** is the minimizer and also the column player. Its action and private state at stage t are indicated by **bt** and **lt**. We use B and L to denote the set of actions and private states of player 2.

The one stage **payoff G(at ,kt , bt ,lt)** is decided by both players’ private states and actions. We prefer to write it in a **matrix form G_{kt,lt}(at, bt)**. G{kt,lt} is a payoff matrix when the private states are kt and lt. player 1 decides row index (at), and player 2 decides the column index (bt). Take the following payoff matrices as an example. If player 1’s private state k=2 and player 2’s private state l=1, the corresponding payoff matrix is the third matrix highlighted. If player 1 plays action 1 and player 2 plays action 2, the current one stage payoff is 107.38, the element in row 1 column 2 of the matrix.

<img src="https://user-images.githubusercontent.com/62413691/115833217-c56a9e00-a3e1-11eb-8094-105ef2255200.png" width="700"> 
Fig. 1 An example of payoff matrices

The private states are initially chosen according to the independent **initial probability distribution ‘p’ for player 1, and ‘q’ for player 2**. 

After stage 1, the private states of both players will change according to the Markovian rules that depend on the current actions and the current private states of both players. **Player 1’s state jumping (or transition) rule is P_{ab}(k,k’)**. It means the probability of jumping from state k to k’ if current action pair is (a,b). **Player 2’s state jumping (or transition) rule is Q_{ab}(l,l’)**. It means the probability of jumping from state l to l’ if the current action pair is (a,b). Let’s take the following transition matrices as an example. Assume the current action pair is (a=1, b=2). That is player 1 plays row 1 and player 2 plays column 2. In this case, the transition matrices for player 1 and 2 are highlighted as in the figure. If player 1’s current private state is 3, the probability of its next private state being 2 will be 0.4, the element in row 3 column 2 of the highlighted (yellow) transition matrix P. If player 2’s current state is 1, the probability of its private state being 2 will be 0.8, the element in row 1 column 2 of highlighted (green) transition matrix Q. 

<img src="https://user-images.githubusercontent.com/62413691/115487146-1170e380-a226-11eb-899a-0cad8a113681.png" width="700">
Fig. 2: An example of transition matrices
 
### 3. Primal game and its LPs in finite horizon (action based strategy). 
The primal game is as what we explained in Section 1. If a player remembers all available information and uses it to decide its current strategy, we can solve the following LPs to compute the optimal strategy for player 1 and player 2. Please find the details in Theorem 1 of the original paper [[1]](#1).

LP for player 1:

![Picture3](https://github.com/Li-Lichun-Lab/stochastic-Bayesian-games/blob/main/pics/Picture3.png)

LP for player 2:

![Picture4](https://github.com/Li-Lichun-Lab/stochastic-Bayesian-games/blob/main/pics/Picture4.png)
 
#### 3.1 The LP code of player 1 (provided in [fn_primal_game_p1](https://github.com/Nabiha-Nasir/stochastic-Bayesian-games/blob/45e1fb93b86dba49be6d0c8de39f6528e309c4e7/action%20based%20strategy%20for%20short%20horizon%20cases/utilities/fn_primal_game_p1.m))

The primal game LP of player 1 can be solved by using the function **[sigma,nu,v1] = fn_primal_game_p1(T,A,B,k,l,lm,P,Q,p,q,G)**. 

**Inputs:** 

- **T**: Total number of stages in the game
- **A**: The number of actions of player 1
- **B**: The number of actions of player 2
- **k**: The number of private states of player 1
- **l**: The number of private states of player 2
- **P**: The format of transition matrices in Fig. 2 in Matlab code is given below.
![image](https://user-images.githubusercontent.com/62413691/116102425-b2272f00-a67c-11eb-8e90-afb418449c78.png)

- **Q**: The format of transition matrices in Fig. 2 in Matlab code is given below.
![image](https://user-images.githubusercontent.com/62413691/116102535-ca974980-a67c-11eb-9109-f208c61bde5e.png)

- **p**: Initial probability of player 1's initial state. Matlab code format: p=[0.5 0.3 0.2]=[Pr(k=1) Pr(k=2) Pr(k=3)]
- **q**: Initial probability of player 2's initial state. Matlab code format: p=[0.5 0.5]=[Pr(l=1) Pr(l=2)]
- **G**: The format of payoff matrices in Fig. 1 in Matlab code is given below.
![image](https://user-images.githubusercontent.com/62413691/116102770-f9adbb00-a67c-11eb-9142-654be36cea4b.png)
 
- **lm**: To create discounted game (0< lm <=1)

**Outputs:**
- **sigma**: The optimal strategy of player 1 which is a probability distribution over player 1's actions to play optimally. The action can be chosen by the function [choose_action]( https://github.com/Nabiha-Nasir/stochastic-Bayesian-games/blob/eea7a9e0a24a1acc7d0f17bb9aeb07595dea4ff8/action%20based%20strategy%20for%20short%20horizon%20cases/utilities/choose_action.m), [a] = choose_action(sigma,A,
[[col_index_sigma] = sigma_col_index_new(A,B,k,k_present,Ha,t,T)]( https://github.com/Nabiha-Nasir/stochastic-Bayesian-games/blob/ab0538a8d4ff0bc1c9db4dbb0af1ccddbb09de19/finite%20long%20horizon/unitilities/sigma_col_index_new.m) at stage t when its current state is k_present, the available information set is Ha=[k1,a1,b1,k2,a2,b2,k3,...kt].
- **nu**: The initial vector payoff over player 2's state in the dual game. It is one of the sufficient statistic elements of player 1 in dual game. 
- **v1**: Game value

#### 3.2 The LP code of player 2 (provided in [fn_primal_game_p2](https://github.com/Nabiha-Nasir/stochastic-Bayesian-games/blob/45e1fb93b86dba49be6d0c8de39f6528e309c4e7/action%20based%20strategy%20for%20short%20horizon%20cases/utilities/fn_primal_game_p2.m))

The primal game LP of player 1 can be solved by using the function **[tau,mu,v2] = fn_primal_game_p2(T,A,B,k,l,lm,P,Q,p,q,G)**.

**Inputs:** 
- **T**: Total number of stages in the game
- **A**: The number of actions of player 1
- **B**: The number of actions of player 2
- **k**: The number of private states of player 1
- **l**: The number of private states of player 2
- **P**: The format of transition matrices in Fig. 2 in Matlab code is given below.
![image](https://user-images.githubusercontent.com/62413691/116102425-b2272f00-a67c-11eb-8e90-afb418449c78.png)

- **Q**: The format of transition matrices in Fig. 2 in Matlab code is given below.
![image](https://user-images.githubusercontent.com/62413691/116102535-ca974980-a67c-11eb-9109-f208c61bde5e.png)

- **p**: Initial probability of player 1's initial state. Matlab code format: p=[0.5 0.3 0.2]=[Pr(k=1) Pr(k=2) Pr(k=3)]
- **q**: Initial probability of player 2's initial state. Matlab code format: p=[0.5 0.5]=[Pr(l=1) Pr(l=2)]
- **G**:  The format of payoff matrices in Fig. 1 in Matlab code is given below.
![image](https://user-images.githubusercontent.com/62413691/116102770-f9adbb00-a67c-11eb-9142-654be36cea4b.png)

- **lm**: To create discounted game (0< lm<1)

**Outputs:**

- **tau**: The optimal strategy of player 2 which is a probability distribution over player 2's actions to play optimally. The action can be chosen by the function [choose_action]( https://github.com/Nabiha-Nasir/stochastic-Bayesian-games/blob/eea7a9e0a24a1acc7d0f17bb9aeb07595dea4ff8/action%20based%20strategy%20for%20short%20horizon%20cases/utilities/choose_action.m), [b] = choose_action(tau,B,
[[col_index_tau] = tau_col_index_new(A,B,l,l_present,Hb,t,T)]( https://github.com/Nabiha-Nasir/stochastic-Bayesian-games/blob/68faf04f2c67924d49ab5549814d596674d202d7/action%20based%20strategy%20for%20short%20horizon%20cases/utilities/tau_col_index_new.m) at stage t when its current state is l_present, the available information set is Hb=[l1,a1,b1,l2,a2,b2,l3,...lt].
- **mu**: The initial vector payoff over player 1's state in the dual game. It is one of the sufficient statistic elements of player 2 in dual game.
- **v2**: Game value

### 4. Dual games and its LPs in finite horizon (actoin based strategy). 
The size of the LPs of the primal game increases exponentially with respect to the horizon of the game. Therefore, the action based strategy doesn't work well in long horizon. During the process of developing sufficient statistic based strategy, we find that the sufficient statistic in the primal game is not fully accessible to either players (explained in the original paper [[1]](#1)). To develop sufficient statistic based strategy, dual games are introduced.

**Type 1 dual game** is played exactly the same as in the primal game except for the first stage. In the first stage, player 1 chooses its own state, and there is an initial vector payoff, exactly the same size of the initial probability of player 1. If player 1 chooses a private state, the associated initial payoff will be added to its stage 1 payoff. 

Similarly, **Type 2 dual game** is also played exactly the same as in the primal game except for the first stage. In the first stage, player 2 chooses its own state, and there is a initial vector payoff, exactly the same size of the initial probability of player 2. If player 2 chooses a private state, the associated initial payoff will be added to its stage 1 payoff. 

**Interesting facts:** If we carefully choose the initial vector payoff in type 1 dual game, then player 2's optimal strategy in the dual game is also its optimal strategy in the primal game. Acturally, the output 'mu' of the primal game LP is the special inital vector payoff.

Similarly, if we carefully choose the initial vector payoff in type 2 dual game, then player 1's optimal strategy in the dual game is also its optimal strategy in the primal game. Acturally, the output 'nu' of the primal game LP is the special inital vector payoff.

The LPs in the dual game is a simple extension of the LPs in the primal game. We can compute the optimal strategies of the players by solving these LPs. 

LP for player 1:

![Picture5](https://github.com/Li-Lichun-Lab/stochastic-Bayesian-games/blob/main/pics/Picture5.png)

LP for player 2:

![Picture6](https://github.com/Li-Lichun-Lab/stochastic-Bayesian-games/blob/main/pics/Picture6.png)
 
#### 4.1 The LP code of player 1 (provided in [fn_full_dual_game_value_P1](https://github.com/Nabiha-Nasir/stochastic-Bayesian-games/blob/605e524a0c44aa5ab87a4778dce40b2bac8992ce/action%20based%20strategy%20for%20short%20horizon%20cases/utilities/fn_full_dual_game_value_P1.m))

The dual game LP of player 1 can be solved by using the function **[sigma] = fn_full_dual_game_value_P1(T,A,B,k,l,lm,G,P,Q,p,nu)**

**Inputs:**

- **T**: Total number of stages in the game
- **A**: The number of actions of player 1
- **B**: The number of actions of player 2
- **k**: The number of private states of player 1
- **l**: The number of private states of player 2
- **P**: The format of transition matrices in Fig. 2 in Matlab code is given below.
![image](https://user-images.githubusercontent.com/62413691/116102425-b2272f00-a67c-11eb-8e90-afb418449c78.png)

- **Q**: The format of transition matrices in Fig. 2 in Matlab code is given below.
![image](https://user-images.githubusercontent.com/62413691/116102535-ca974980-a67c-11eb-9109-f208c61bde5e.png)

- **p**: Initial probability of player 1's initial state. Matlab code format: p=[0.5 0.3 0.2]=[Pr(k=1) Pr(k=2) Pr(k=3)]
- **G**:  The format of payoff matrices in Fig. 1 in Matlab code is given below.
![image](https://user-images.githubusercontent.com/62413691/116102770-f9adbb00-a67c-11eb-9142-654be36cea4b.png)

- **lm**: To create discounted game (0< lm<1)
- **nu**: The initial vector payoff over player 2's state in the dual game. It is one of the sufficient statistics elements of player 1 in dual game. We get this value from solving primal game of player 1 ( [fn_primal_game_p1](https://github.com/Nabiha-Nasir/stochastic-Bayesian-games/blob/fd1de8441f69b0b8faa7cba65ce23180b5cdabd0/action%20based%20strategy%20for%20short%20horizon%20cases/utilities/fn_primal_game_p1.m) ).

**Outputs:**

**sigma**: The optimal strategy of player 1 which is a probability distribution over player 1's actions to play optimally. The action can be chosen by the function [choose_action]( https://github.com/Nabiha-Nasir/stochastic-Bayesian-games/blob/eea7a9e0a24a1acc7d0f17bb9aeb07595dea4ff8/action%20based%20strategy%20for%20short%20horizon%20cases/utilities/choose_action.m), [a] = choose_action(sigma,A,
[[col_index_sigma] = sigma_col_index_new(A,B,k,k_present,Ha,t,T)]( https://github.com/Nabiha-Nasir/stochastic-Bayesian-games/blob/ab0538a8d4ff0bc1c9db4dbb0af1ccddbb09de19/finite%20long%20horizon/unitilities/sigma_col_index_new.m)) at stage t when its current state is k_present, the available information set is Ha=[k1,a1,b1,k2,a2,b2,k3,...kt]

#### 4.2 The LP code of player 2 (provided in [fn_full_dual_game_value_P2](https://github.com/Nabiha-Nasir/stochastic-Bayesian-games/blob/d10e8d507c89a966a631f0a65fae6ab4871b140f/action%20based%20strategy%20for%20short%20horizon%20cases/utilities/fn_full_dual_game_value_P2.m))

The dual game LP of player 2 can be solved by using the function **[tau] = fn_full_dual_game_value_P2(T,A,B,k,l,lm,G,P,Q,q,mu)**.

**Inputs:** 

- **T**: Total number of stages in the game
- **A**: The number of actions of player 1
- **B**: The number of actions of player 2
- **k**: The number of private states of player 1
- **l**: The number of private states of player 2
- **P**: The format of transition matrices in Fig. 2 in Matlab code is given below.
![image](https://user-images.githubusercontent.com/62413691/116102425-b2272f00-a67c-11eb-8e90-afb418449c78.png)

- **Q**: The format of transition matrices in Fig. 2 in Matlab code is given below.
![image](https://user-images.githubusercontent.com/62413691/116102535-ca974980-a67c-11eb-9109-f208c61bde5e.png)

- **q**: Initial probability of player 2's initial state. Matlab code format: p=[0.5 0.5]=[Pr(l=1) Pr(l=2)]
- **G**:  The format of payoff matrices in Fig. 1 in Matlab code is given below.
![image](https://user-images.githubusercontent.com/62413691/116102770-f9adbb00-a67c-11eb-9142-654be36cea4b.png)

- **lm**: To create discounted game (0< lm<1)
- **mu**: The initial vector payoff over player 1's state in the dual game. It is one of the sufficient statistics elements of player 2 in dual game. We get this value from primal game of player 2 ( [fn_primal_game_p2](https://github.com/Nabiha-Nasir/stochastic-Bayesian-games/blob/fd1de8441f69b0b8faa7cba65ce23180b5cdabd0/action%20based%20strategy%20for%20short%20horizon%20cases/utilities/fn_primal_game_p2.m) ).

**Outputs:**

**tau**: The optimal strategy of player 2 which is a probability distribution over player 2's actions to play optimally. The action can be chosen by the function [choose_action]( https://github.com/Nabiha-Nasir/stochastic-Bayesian-games/blob/eea7a9e0a24a1acc7d0f17bb9aeb07595dea4ff8/action%20based%20strategy%20for%20short%20horizon%20cases/utilities/choose_action.m), [b] = choose_action(tau,B,
[[col_index_tau] = tau_col_index_new(A,B,l,l_present,Hb,t,T)]( https://github.com/Nabiha-Nasir/stochastic-Bayesian-games/blob/68faf04f2c67924d49ab5549814d596674d202d7/action%20based%20strategy%20for%20short%20horizon%20cases/utilities/tau_col_index_new.m)) at stage t when its current state is l_present, the available information set is Hb=[l1,a1,b1,l2,a2,b2,l3,...lt]

### 5. Dual games and the sufficient statistic update

As we mentioned in Section 4, the purpose of introducing dual games is to introduce sufficient statistic based strategy. The nice part of the dual games is that their sufficient statistics are fully accessible to one player. For example, type 2 dual game's sufficient statistic is fully accessible by player 1 and type 1 dual game's sufficient statistic is fully accessible by player 2. Our next question is how to update the sufficient statistics. 

The sufficien statistic of player 1 in type 2 dual game is updated by the following LP.

![Picture7](https://github.com/Li-Lichun-Lab/stochastic-Bayesian-games/blob/main/pics/Picture7.png)

The sufficien statistic of player 2 in type 1 dual game is updated by the following LP.

![Picture8](https://github.com/Li-Lichun-Lab/stochastic-Bayesian-games/blob/main/pics/Picture8.png)

#### 5.1 The LP code of player 1 (provided in [fn_dual_game_2nd_P1](https://github.com/Nabiha-Nasir/stochastic-Bayesian-games/blob/d10e8d507c89a966a631f0a65fae6ab4871b140f/finite%20long%20horizon/window_by_window_method/unitilities/fn_dual_game_2nd_P1.m))

The LP of player 1 can be solved by using the function **[alpha_vector] = fn_dual_game_2nd_P1(T,A,B,k,l,lm,G,P,Q,p,nu,X_star)**.

**Inputs:** 

- **T**: Total number of stages in the game
- **A**: The number of actions of player 1
- **B**: The number of actions of player 2
- **k**: The number of private states of player 1
- **l**: The number of private states of player 2
- **P**: The format of transition matrices in Fig. 2 in Matlab code is given below.
![image](https://user-images.githubusercontent.com/62413691/116102425-b2272f00-a67c-11eb-8e90-afb418449c78.png)

- **Q**: The format of transition matrices in Fig. 2 in Matlab code is given below.
![image](https://user-images.githubusercontent.com/62413691/116102535-ca974980-a67c-11eb-9109-f208c61bde5e.png)

- **p**: For first stage p is the initial probability of player 1's initial state. For other stages p is the updated belief for next stage which depends on current stage's action of player 1 (a) and player 2(b) and the optimal strategy of player 1 at current stage (X). The updated p can be found using the function [[p_present] = update_belief_li_pplus(k,p,X,a,b,P)]( https://github.com/Nabiha-Nasir/stochastic-Bayesian-games/blob/6ff7988a02b6d6b0514d11cb0f077386e98ff878/finite%20long%20horizon/unitilities/update_belief_li_pplus.m). Matlab code format: p=[0.5 0.3 0.2]=[Pr(k=1) Pr(k=2) Pr(k=3)]
- **G**:  The format of payoff matrices in Fig. 1 in Matlab code is given below.
![image](https://user-images.githubusercontent.com/62413691/116102770-f9adbb00-a67c-11eb-9142-654be36cea4b.png)

- **lm**: To create discounted game (0< lm<1)
- **nu**: The initial vector payoff over player 2's state in the dual game. It is one of the sufficient statistics elements of player 1 in dual game. We get this value from primal game of player 1 ( [fn_primal_game_p1](https://github.com/Nabiha-Nasir/stochastic-Bayesian-games/blob/fd1de8441f69b0b8faa7cba65ce23180b5cdabd0/action%20based%20strategy%20for%20short%20horizon%20cases/utilities/fn_primal_game_p1.m) ).
- **X_star**: The optimal strategy of player 1 at stage 1 which we can get using primal or dual game LP. 

**Outputs:** 

**alpha_vector**: The updated vector payoff over player 2's state for all possible action set (at,bt) of the current stage t. Take the following Fig as an example. At stage t if player 1's action is a=1 and player 2's action is b=2 then the vector payoff of over player 2's state is [-60.78 -67.27] (the highlighted part in the Fig).

<img src="pics/alpha_vector.PNG" width="400"> 

The alpha_vector is presented as a row vector in the matlab code. An example of the format of alpha_vector in the matlab code is given below.

![](pics/alpha_matlab.PNG)

If the current action of player 1 and 2 is 'a' and 'b' then we can get the updated nu using the following two line of code.

col_index_alpha=(a-1)* B* l+(b-1)* l

nu_plus=alpha_vector(1,col_index_alpha+1:col_index_alpha+l)

The size of updated nu should be same as the initial probability of player 2's state q.

#### 5.2 The LP code of player 2 (provided in [fn_dual_game_2nd_P2](https://github.com/Nabiha-Nasir/stochastic-Bayesian-games/blob/ad98cf1406b1d8756714a8e42e933cb0e46423f3/finite%20long%20horizon/window_by_window_method/unitilities/fn_dual_game_2nd_P2.m))

The LP of player 2 can be solved by using the function **[beta_vector] = fn_dual_game_2nd_P2(T,A,B,k,l,lm,G,P,Q,q,mu,Y_star)**.

**Inputs:** 

- **T**: Total number of stages in the game
- **A**: The number of actions of player 1
- **B**: The number of actions of player 2
- **k**: The number of private states of player 1
- **l**: The number of private states of player 2
- **P**: Transition matrix of player 1. Format of P in the matlab code: If k=2, P(at,bt}=[Pr(kt=1,k(t+1)=1) Pr(kt=1,k(t+1)=2); Pr(kt=2,k(t+1)=1) Pr(kt=2,k(t+1)=2)]. For example, when k=3 and the actions (a,b)=(1,2) then P{1,2}=[.4 .5 .1; .2 .3 .5; .4 .4 .2 ]. Here, when a=1 and b=2 the probability of player 1's state jump from k=2 to k=2 is 0.3. Notice that the state is jumping from row element to column element. Every element of P should be non-negative and every row sums to 1.
- **Q**: Transition matrix of player 2. Format of Q in the matlab code: If l=2, P(at,bt}=[Pr(lt=1,l(t+1)=1) Pr(lt=1,l(t+1)=2); Pr(lt=2,l(t+1)=1) Pr(lt=2,l(t+1)=2)]. For example, when l=3 and the actions (a,b)=(1,1) then Q{1,1}=[.8 .2;.5 .5]. In this example, when a=1 and b=2 the probability of player 1's state jump from l=1 to l=2 is 0.5. Notice that the state is jumping from row element to column element. Every element of Q should be non-negative and every row sums to 1.
- **q**: For first stage p is the initial probability of player 2's initial state. For other stages q is the updated belief for next stage which depends on current stage's action of player 1 (a) and player 2(b) and the optimal strategy of player 2 at current stage (Y). The updated q can be found using the function [[q_present] = update_belief_li_qplus(l,q,Y,a,b,Q)]( https://github.com/Nabiha-Nasir/stochastic-Bayesian-games/blob/6ff7988a02b6d6b0514d11cb0f077386e98ff878/finite%20long%20horizon/unitilities/update_belief_li_qplus.m). Matlab code format: p=[0.5 0.3 0.2]=[Pr(k=1) Pr(k=2) Pr(k=3)].
- **G**: Payoff Matrix, Format of G in the matlab code: If the actions (kt,lt)=(1,1) then G{1,1}= [108.89,113.78;108.89,113.78]
- **lm**: To create discounted game (0< lm<1)
- **mu**: The initial vector payoff over player 1's state in the dual game. It is one of the sufficient statistics elements of player 2 in dual game. We get this value from primal game of player 2 ( [fn_primal_game_p2](https://github.com/Nabiha-Nasir/stochastic-Bayesian-games/blob/fd1de8441f69b0b8faa7cba65ce23180b5cdabd0/action%20based%20strategy%20for%20short%20horizon%20cases/utilities/fn_primal_game_p2.m) ).
- **Y_star**: The optimal strategy of player 2 at stage 1 which we can get using primal or dual game LP. 

**Outputs:** 

**beta_vector**: The updated vector payoff over player 1's state for all possible action set (at,bt) of the current stage t. Take the following Fig as an example. At stage t if player 1's action is a=2 and player 2's action is b=1 then the vector payoff of over player 1's state is [-177.99 -66.07 -8.30] (the highlighted part in the Fig).

<img src="pics/beta_vector.PNG" width="400"> 

The beta_vector is presented as a row vector in the matlab code. An example of the format of alpha_vector in the matlab code is given below.

![](pics/beta_matlab.PNG)

If the current action of player 1 and 2 is 'a' and 'b' then we can get the updated mu using the following two line of code.

col_index_beta=(a-1)* B* k+(b-1)* k

mu_plus=beta_vector(1,col_index_beta+1:col_index_beta+k)

The size of updated mu should be same as the initial probability of player 1's state p.

### 6. How to use these codes

If your application has short horizon (2-3 stages), the action based strategy introduced in Section 3 is suitable. The detailed usage is provided in folder [action based strategy for short horizon cases](https://github.com/Nabiha-Nasir/stochastic-Bayesian-games/tree/main/action%20based%20strategy%20for%20short%20horizon%20cases)

If your application has long horizon (>3 stages), the sufficient statistic based strategy is more suitable. The detailed algorithm based on the LPs introduced above is given in folder [finite long horizon](https://github.com/Nabiha-Nasir/stochastic-Bayesian-games/tree/main/finite%20long%20horizon) and [infinite horizon](https://github.com/Nabiha-Nasir/stochastic-Bayesian-games/tree/main/infinite%20horizon)


## References
<a id="1">[1]</a> 
DN. N. Orpa and L. Li (2020). 
“Lp formulations of two-player zero-sum stochastic bayesian finite horizon games”

