# Constraint Solver for Software Engineering
Project for CSC510 2015 spring

## Background
Modern software engineering is becoming more and more complex. Some commercial software platforms are required to equip with hundreds, even thousands of features, such as enable security network, enable scalable database, customizable GUI, etc. SPLOT(Software Product Lines Online Tools) contains hundreds of feature model instances. Some of them has more than 300 features.  

Among all of the features in a model, there are some constraints. That is, some features are related to each other.  
Implementing all features in a software project maybe impossible. We need some tools to determine which feature should be furnished at first. A good plan can shorten development time or cost, make the product more competitive in market.

## Requirements and Goals
This is a very simple feature model.
![feature1](./img/eshopmodel.jpg)

In this model, E-shop can be divided into 4 sub-feature points: catalogue, payment, security and search. Among them, search is optional, and others are mandatory. In payment sub-feature, it can be bank transfer, credit card or both of them. Security can be high or standard.  

If the above are all problem statement, this problem is quit simple, we can pick up the features from root to leaves. But in this example, their is one cross-tree constraint: CreditCard implies High security.  

Due to the cross-tree constraints, the problem become much more complex. As we all know, SAT is a NP-hard problem. Essentially, the cross-tree constraints in this problem can be expressed as SAT.

So ultimately this is a optimization problem, specifically, a binary variable optimization problem. The objectives are: try to find out as much features as possible, and follow as much constraints as possible.

In abstract, the feature model can be translated into a optimization problem: let the leaves feature be arguments, get the total satisfied feature and satisfied constraint as two objectives. Our goal is to find the settings for leaves feature (which are binary variables) so that two objectives can be optimized.

Also, in the software project, develop cost, precedentness and defects are very important factors which should not be ignored. Consequently, adding these three objective into the problem can make this tool more powerful. How to define the "best" solution and how to solve this problem will be discussed in the latter section.

To summary, this project accepts a feature model, as well as some attributes of features, and returns which feature should be implemented.

## Methods
### Feature fetch and translation
SPLOT(splot-research.org) has a open feature model repository. All models in this project are fetched from this repository. In the SPLOT repository, feature models are expressed in SXFM language. To parse it, I apply the parser provided by this repository.

After parsing the feature models, I can get all the leaf features. They are the arguments to be determined. In the "E-Shop" example, arguments include: Catalogue, BankTransfer, CreditCard, HighSecurity, Standard and Search. 

## Results

## Discussion

## Conclusion

## Future Work

## References
[1] Storn, Rainer, and Kenneth Price. "Differential evolution–a simple and efficient heuristic for global optimization over continuous spaces." Journal of global optimization 11.4 (1997): 341-359. 

[2] Abbass, Hussein A., Ruhul Sarker, and Charles Newton. "PDE: a Pareto-frontier differential evolution approach for multi-objective optimization problems." Evolutionary Computation, 2001. Proceedings of the 2001 Congress on. Vol. 2. IEEE, 2001.  

[3] Robič, Tea, and Bogdan Filipič. "DEMO: Differential evolution for multiobjective optimization." Evolutionary Multi-Criterion Optimization. Springer Berlin Heidelberg, 2005.

[4] Deb, Kalyanmoy, et al. "Scalable multi-objective optimization test problems." Proceedings of the Congress on Evolutionary Computation (CEC-2002),(Honolulu, USA). Proceedings of the Congress on Evolutionary Computation (CEC-2002),(Honolulu, USA), 2002. 

[5] Pampara, Gary, Andries Petrus Engelbrecht, and Nelis Franken. "Binary differential evolution." Evolutionary Computation, 2006. CEC 2006. IEEE Congress on. IEEE, 2006.  

[6] Zitzler, Eckart, and Lothar Thiele. "Multiobjective evolutionary algorithms: a comparative case study and the strength Pareto approach." evolutionary computation, IEEE transactions on 3.4 (1999): 257-271.  

[7] Zitzler, Eckart, and Simon Künzli. "Indicator-based selection in multiobjective search." Parallel Problem Solving from Nature-PPSN VIII. Springer Berlin Heidelberg, 2004.  

[8] Sayyad, Abdel Salam, Tim Menzies, and Hany Ammar. "On the value of user preferences in search-based software engineering: A case study in software product lines." Software engineering (ICSE), 2013 35th international conference on. IEEE, 2013.  

[9] Deb, Kalyanmoy, et al. "A fast and elitist multiobjective genetic algorithm: NSGA-II." Evolutionary Computation, IEEE Transactions on 6.2 (2002): 182-197.  

[10] Sayyad, Abdel Salam, et al. "Scalable product line configuration: A straw to break the camel's back." Automated Software Engineering (ASE), 2013 IEEE/ACM 28th International Conference on. IEEE, 2013.
