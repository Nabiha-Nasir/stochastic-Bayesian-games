# stochastic-Bayesian-games
### 1. LP formulas of two-player zero-sum stochastic Bayesian games

Two-player zero-sum Bayesian games are dynamic games where two players play against each other for several stages. Sometimes, they will play against each other forever. In this game, every player has its own private information (which is also called the private state), say 'k' for player 1 (maximizer) and 'l' for player 2 (minimizer). At every stage, the players need to take some action based on the information they have, and the one-stage payoff is decided by both payers' actions and private states. The game is player for several stages. When the game evolves to the next stage, the player's private states will change according to a Markovian rule based on the current private states and the current actions of both players. If we want to benefit from long time behavior, playing greedily in the current stage might not be the best solution. 
We are interested in a computationally efficient way to find the optimal solution for the players. To this purpose, we build this project.
### 2. Some terminologies.
**Player 1** is the maximizer and also the row player (you will know what we mean by ‘row’ or ‘column’ player when we introduce the payoff matrix). Its action and private state at stage t are indicated by **at** and **kt**. We use A and K to denote the set of actions and private states of player 1.

**Player 2** is the minimizer and also the column player. Its action and private state at stage t are indicated by **bt** and **lt**. We use B and L to denote the set of actions and private states of player 2.

The initial probability distribution of the two private states are. We assume that the initial states are chosen independently. 

The one stage **payoff G(at ,kt , bt ,lt)** is decided by both players’ private states and actions. We prefer to write it in a **matrix form G_{kt,lt}(at, bt)**. Gkt,lt is a payoff matrix when the private states are kt and lt. player 1 decides row index (at), and player 2 decides the column index(bt). Take the following payoff matrices as an example. If player 1’s private state k=2 and player 2’s private state l=1, the corresponding payoff matrix is the third matrix highlighted. If player 1 plays action 1 and player 2 plays action 2, the current one stage payoff is 107.38, the element in row 1 column 2 of the matrix.
![Picture1](https://your-copied-image-address)

The private states are initially chosen according to the independent **initial probability distribution ‘p’ for player 1, and ‘q’ for player 2**. 

After stage 1, the private states of both players will change according to the Markovian rules that depend on the current actions and the current private states of both players. **Player 1’s state jumping (or transition) rule is P_{ab}(k,k’)**. It means the probability of jumping from state k to k’ if current action pair is (a,b). **Player 2’s state jumping (or transition) rule is Q_{ab}(l,l’)**. It means the probability of jumping from state l to l’ if the current action pair is (a,b). Let’s take the following transition matrices as an example. Assume the current action pair is (a=1, b=2). That is player 1 plays row 1 and player 2 plays column 2. In this case, the transition matrices for player 1 and 2 are highlighted as in the figure. If player 1’s current private state is 3, the probability of its next private state being 2 will be 0.4, the element in row 3 column 2 of the highlighted transition matrix P. If player 2’s current state is 1, the probability of its private state being 2 will be 0.8, the element in row 1 column 2 of highlight transition matrix Q. 
 
### 3. Primal game and its LPs in finite horizon. 
The primal game is as what we explained in Section 1. If a player remembers all available information and uses it to decide its current strategy, we can solve the following LPs to compute the optimal strategy for player 1 and player 2. Please find the details in the original paper ???????????????.

LP for player 1:
 
LP for player 2:
 
#### 3.1 The LP code of player 1 (provided in ???????)

**Inputs:** ?????????????? detailed explanation of the inputs if other than something introduced in section 2

**Outputs:** ???????????????? detailed explanation of outputs and how to use them. 

#### 3.2 The LP code of player 2 (provided in ??????????????)

**Inputs:** ?????????????? detailed explanation of the inputs if other than something introduced in section 2

**Outputs:** ???????????????? detailed explanation of outputs and how to use them. 



