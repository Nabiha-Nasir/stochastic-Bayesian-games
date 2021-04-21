# LPs for two-player zero-sum stochastic-Bayesian-games
### 1. Two-player zero-sum stochastic Bayesian games
Two-player zero-sum Bayesian games are dynamic games where two players play against each other for several stages. Sometimes, they will play against each other forever. In this game, every player has its own private information (which is also called the private state), say 'k' for player 1 (maximizer) and 'l' for player 2 (minimizer). At every stage, the players need to take some action based on the information they have, and the one-stage payoff is decided by both payers' actions and private states. The game is played for several stages. When the game evolves to the next stage, the players' private states will change according to a Markovian rule based on the current private states and the current actions of both players. If we want to benefit from long time behavior, playing greedily in the current stage might not be the best solution. 
We are interested in a computationally efficient way to find the optimal solution for the players. For this purpose, we build this project.

### 2. Some terminologies.
**Player 1** is the maximizer and also the row player (you will know what we mean by ‘row’ or ‘column’ player when we introduce the payoff matrix). Its action and private state at stage t are indicated by **at** and **kt**. We use A and K to denote the set of actions and private states of player 1.

**Player 2** is the minimizer and also the column player. Its action and private state at stage t are indicated by **bt** and **lt**. We use B and L to denote the set of actions and private states of player 2.

The one stage **payoff G(at ,kt , bt ,lt)** is decided by both players’ private states and actions. We prefer to write it in a **matrix form G_{kt,lt}(at, bt)**. G{kt,lt} is a payoff matrix when the private states are kt and lt. player 1 decides row index (at), and player 2 decides the column index (bt). Take the following payoff matrices as an example. If player 1’s private state k=2 and player 2’s private state l=1, the corresponding payoff matrix is the third matrix highlighted. If player 1 plays action 1 and player 2 plays action 2, the current one stage payoff is 107.38, the element in row 1 column 2 of the matrix.

![Picture1](https://github.com/Li-Lichun-Lab/stochastic-Bayesian-games/blob/main/pics/Picture1.png)

The private states are initially chosen according to the independent **initial probability distribution ‘p’ for player 1, and ‘q’ for player 2**. 

After stage 1, the private states of both players will change according to the Markovian rules that depend on the current actions and the current private states of both players. **Player 1’s state jumping (or transition) rule is P_{ab}(k,k’)**. It means the probability of jumping from state k to k’ if current action pair is (a,b). **Player 2’s state jumping (or transition) rule is Q_{ab}(l,l’)**. It means the probability of jumping from state l to l’ if the current action pair is (a,b). Let’s take the following transition matrices as an example. Assume the current action pair is (a=1, b=2). That is player 1 plays row 1 and player 2 plays column 2. In this case, the transition matrices for player 1 and 2 are highlighted as in the figure. If player 1’s current private state is 3, the probability of its next private state being 2 will be 0.4, the element in row 3 column 2 of the highlighted (yellow) transition matrix P. If player 2’s current state is 1, the probability of its private state being 2 will be 0.8, the element in row 1 column 2 of highlighted (green) transition matrix Q. 

<img src="https://user-images.githubusercontent.com/62413691/115487146-1170e380-a226-11eb-899a-0cad8a113681.png" width="500" height="100">
 
### 3. Primal game and its LPs in finite horizon (action based strategy). 
The primal game is as what we explained in Section 1. If a player remembers all available information and uses it to decide its current strategy, we can solve the following LPs to compute the optimal strategy for player 1 and player 2. Please find the details in the original paper [[1]](#1).

LP for player 1:

![Picture3](https://github.com/Li-Lichun-Lab/stochastic-Bayesian-games/blob/main/pics/Picture3.png)

LP for player 2:

![Picture4](https://github.com/Li-Lichun-Lab/stochastic-Bayesian-games/blob/main/pics/Picture4.png)
 
#### 3.1 The LP code of player 1 (provided in [fn_primal_game_p1](https://github.com/Nabiha-Nasir/stochastic-Bayesian-games/blob/fd1de8441f69b0b8faa7cba65ce23180b5cdabd0/action%20based%20strategy%20for%20short%20horizon%20cases/utilities/fn_primal_game_p1.m))

**Inputs:** The primal game LP of player 1 can be solved by using the function **[sigma,nu] = fn_primal_game_p1(T,A,B,k,l,lm,P,Q,p,q,G)**. Here, T is the total number of stages in the game, A and B are the number of actions of player 1 and 2, respectively. k is the number of private state of player 1 and l is the number of private state of player 2. lm is to create discounted game. The value of lm should be between 0 to 1. If lm<1 and the number of stages of the game is finite then it creates truncated discounted game. If lm<1 and the number of stages of the game is infinite then it creates discounted game. P is the transition matrices of player 1. The matrix form of P is **P_{at, bt}(k,k')**. It provides a probability matrix of player 1's state to jump from one state (k) to another state (k') when the current action of player 1 is at and player 2 is bt. Q is the transition matrices of player 2. The matrix form of Q is **Q_{at, bt}(l,l')**. It provides a probability matrix of player 2's state to jump from one state (l) to another state (l') when the current action of player 1 is at and player 2 is bt. p is a row vector which the indipendent initial probability of player 1's initial state. For example, p=[p1 p2 p3] where p1 is the probability of player 1's initial state to be 1. Similaryly, q is a row vector which the indipendent initial probability of player 2's initial state. For example, q=[q1 q2 q3] where q1 is the probability of player 2's initial state to be 1. G is the payoff matrix and its matrix form is G_{kt,lt}(at, bt).

**Outputs:** From the LP code of player 2's primal game we get two outputs **sigma** and **nu**. sigma is the optimal strategy of player 1 and provides a probability distribution over player 1's actions to play optimally. Sometimes, sigma contains NaN or Inf elements. It means that the possibility of the corresponding history is 0. The function [choose_action]( https://github.com/Nabiha-Nasir/stochastic-Bayesian-games/blob/eea7a9e0a24a1acc7d0f17bb9aeb07595dea4ff8/action%20based%20strategy%20for%20short%20horizon%20cases/utilities/choose_action.m), [a] = choose_action(sigma,A,sigma_col_index_new(A,B,k,k_present,Ha,t,n_is1)) is used to get the optimal action of player 1 at stage t when its current state is k_present, the available information set is Ha, total number of possible information sets of player 1 at all the stages n_is1.
nu is the initial vector payoff over player 2's state. nu is the probability distribution over player 2's private state l. It is one of the sufficient statistics elements of player 1 in dual game. We will use this term in dual game LP. 

#### 3.2 The LP code of player 2 (provided in [fn_primal_game_p2](https://github.com/Nabiha-Nasir/stochastic-Bayesian-games/blob/fd1de8441f69b0b8faa7cba65ce23180b5cdabd0/action%20based%20strategy%20for%20short%20horizon%20cases/utilities/fn_primal_game_p2.m))

**Inputs:** The primal game LP of player 1 can be solved by using the function **[tau,mu] = fn_primal_game_p2(T,A,B,k,l,lm,P,Q,p,q,G)**. Here, T is the total number of stages in the game, A and B are the number of actions of player 1 and 2, respectively. k is the number of private state of player 1 and l is the number of private state of player 2. lm is to create discounted game. The value of lm should be between 0 to 1. If lm<1 and the number of stages of the game is finite then it creates truncated discounted game. If lm<1 and the number of stages of the game is infinite then it creates discounted game. P is the transition matrices of player 1. The matrix form of P is **P_{at, bt}(k,k')**. It provides a probability matrix of player 1's state to jump from one state (k) to another state (k') when the current action of player 1 is at and player 2 is bt. Q is the transition matrices of player 2. The matrix form of Q is **Q_{at, bt}(l,l')**. It provides a probability matrix of player 2's state to jump from one state (l) to another state (l') when the current action of player 1 is at and player 2 is bt. p is a row vector which the indipendent initial probability of player 1's initial state. For example, p=[p1 p2 p3] where p1 is the probability of player 1's initial state to be 1. Similaryly, q is a row vector which the indipendent initial probability of player 2's initial state. For example, q=[q1 q2 q3] where q1 is the probability of player 2's initial state to be 1. G is the payoff matrix and its matrix form is G_{kt,lt}(at, bt).

**Outputs:** From the LP code of player 2's primal game we get two outputs **tau** and **mu**. tau is the optimal strategy of player 2 and provides a probability distribution over player 2's actions to play optimally. Sometimes, tau contains NaN or Inf elements. It means that the possibility of the corresponding history is 0. The function [choose_action]( https://github.com/Nabiha-Nasir/stochastic-Bayesian-games/blob/eea7a9e0a24a1acc7d0f17bb9aeb07595dea4ff8/action%20based%20strategy%20for%20short%20horizon%20cases/utilities/choose_action.m), [b] = choose_action(rau,B,tau_col_index_new(A,B,l,l_present,Hb,t,n_is2)) is used to get the optimal action of player 2 at stage t when its current state is l_present, the available information set is Hb, total number of possible information sets of player 1 at all the stages n_is2.
mu is the initial vector payoff over player 1's state. mu is the probability distribution over player 1's private state k. It is one of the sufficient statistics elements of player 2 in dual game. We will use this term in dual game LP. 

### 4. Dual games and its LPs in finite horizon (actoin based strategy). 
The size of the LPs of the primal game increases exponentially with respect to the horizon of the game. Therefore, the action based strategy doesn't work well in long horizon. During the process of developing sufficient statistic based strategy, we find that the sufficient statistic in the primal game is not fully accessible to either players (explained in the original paper [[1]](#1)). To develop sufficient statistic based strategy, dual games are introduced.

**Type 1 dual game** is played exactly the same as in the primal game except for the first stage. In the first stage, player 1 chooses its own state, and there is a initial vector payoff, exactly the same size of the initial probability of player 1. If player 1 chooses a private state, the associated initial payoff will be added to its stage 1 payoff. 

Similarly, **Type 2 dual game** is also played exactly the same as in the primal game except for the first stage. In the first stage, player 2 chooses its own state, and there is a initial vector payoff, exactly the same size of the initial probability of player 2. If player 2 chooses a private state, the associated initial payoff will be added to its stage 1 payoff. 

**Interesting facts:** If we carefully choose the initial vector payoff in type 1 dual game, then player 2's optimal strategy in the dual game is also its optimal strategy in the primal game. Acturally, the output ??? of the primal game LP is the special inital vector payoff.

Similarly, if we carefully choose the initial vector payoff in type 2 dual game, then player 1's optimal strategy in the dual game is also its optimal strategy in the primal game. Acturally, the output ??? of the primal game LP is the special inital vector payoff.

The LPs in the dual game is a simple extension of the LPs in the primal game. We can compute the optimal strategies of the players by solving these LPs. 

LP for player 1:

![Picture5](https://github.com/Li-Lichun-Lab/stochastic-Bayesian-games/blob/main/pics/Picture5.png)

LP for player 2:

![Picture6](https://github.com/Li-Lichun-Lab/stochastic-Bayesian-games/blob/main/pics/Picture6.png)
 
#### 4.1 The LP code of player 1 (provided in ???????)

**Inputs:** ?????????????? detailed explanation of the inputs if other than something introduced in section 2

**Outputs:** ???????????????? detailed explanation of outputs and how to use them. 

#### 4.2 The LP code of player 2 (provided in ??????????????)

**Inputs:** ?????????????? detailed explanation of the inputs if other than something introduced in section 2

**Outputs:** ???????????????? detailed explanation of outputs and how to use them. 

### 5. Dual games and the sufficient statistic update

As we mentioned in Section 4, the purpose of introducing dual games is to introduce sufficient statistic based strategy. The nice part of the dual games is that their sufficient statistics are fully accessible to one player. For example, type 2 dual game's sufficient statistic is fully accessible by player 1 and type 1 dual game's sufficient statistic is fully accessible by player 2. Our next question is how to update the sufficient statistics. 

The sufficien statistic of player 1 in type 2 dual game is updated by the following LP.

![Picture7](https://github.com/Li-Lichun-Lab/stochastic-Bayesian-games/blob/main/pics/Picture7.png)

The sufficien statistic of player 2 in type 1 dual game is updated by the following LP.

![Picture8](https://github.com/Li-Lichun-Lab/stochastic-Bayesian-games/blob/main/pics/Picture8.png)

#### 5.1 The LP code of player 1 (provided in ???????)

**Inputs:** ?????????????? detailed explanation of the inputs if other than something introduced in section 2

**Outputs:** ???????????????? detailed explanation of outputs and how to use them. 

#### 5.2 The LP code of player 2 (provided in ??????????????)

**Inputs:** ?????????????? detailed explanation of the inputs if other than something introduced in section 2

**Outputs:** ???????????????? detailed explanation of outputs and how to use them. 

### 6. How to use these codes

If your application has short horizon (2-3 stages), the action based strategy introduced in Section 3 is suitable. The detailed usage is provided in folder ??????

If your application has long horizon (>3 stages), the sufficient statistic based strategy is more suitable. The detailed algorithm based on the LPs introduced above is given in folder ???? and ?????



## References
<a id="1">[1]</a> 
DN. N. Orpa and L. Li (2020). 
“Lp formulations of two-player zero-sum stochastic bayesian finite horizon games”

