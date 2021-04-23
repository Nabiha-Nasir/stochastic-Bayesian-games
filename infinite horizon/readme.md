### Receding horizon algorithm
Assume there is a game which runs for infinite number of stages and the computational capacity only allow us to compute security strategies in games with T<N stages in a timely manner. For this situation we have introduced receding horizon algorithm where players compute the optimal strategies for first n stages and take action for the first stage. Then move the n sized window 1 stage ahead, compute the optimal strategies and take action for the first stage of that window which is actually the 2nd stage in the game horizon. The performance of this algorithm is better than window by window method as at each stage it is computing the sufficient statistic based optimal strategy and take action accordingly. 

#### step 1: Initialization
In this step, you need to tell the code the basic information about the game. The basic informations of this code are:

- **T**: Window size
- **N**: Game horizon
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

![image](https://user-images.githubusercontent.com/62413691/115906826-0e4c4200-a436-11eb-9033-935d2413d723.png)

#### step 3: Run Game

![image](https://user-images.githubusercontent.com/62413691/115909649-cb8c6900-a439-11eb-8994-50ea50eb9e74.png)


#### About the files of this folder

The code receding_method.m is an example of 36 stage game and both of the player uses receding horizon algorithm to compute their strategies. The files and functions required to run the code are in the utilities folder.
