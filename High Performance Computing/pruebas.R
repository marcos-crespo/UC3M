setwd("~/Universidad/Master/GitHub/UC3M/High Performance Computing")

#Matrix A 50x15
#Matrix B 15x70
#Matrix C 70x10
#Matrix D 10*50
#Matrix E 50*2

# ABCDE
50*15*70+50*70*10+50*10*50+50*2*50
###117500

# A(BC)DE

#BC 15*70*10 --- 15*10
#A(BC) 50*15*10 --- 50*10
#A(BC)D 50*10*50 --- 50*50
#A(BC)DE 50*50*2 --- 50*2
15*70*10+50*15*10+50*10*50+50*50*2
###48000

# A((BC)(DE))

#BC 15*70*10 --- 15*10
#DE 10*50*2 --- 10*2
#(BC)(DE) 10*50*2 --- 15*2
#A(BC)(DE) 50*15*2 --- 50*2

15*70*10+10*50*2+10*50*2+50*15*2
### 14000

set.seed(123)
A<- matrix(runif(50*15), nrow = 50, ncol=15)
B<- matrix(runif(15*70), nrow = 15, ncol=70)
C<- matrix(runif(70*10), nrow = 70, ncol=10)
D<- matrix(runif(10*50), nrow = 10, ncol=50)
E<-matrix(runif(50*2), nrow = 50, ncol=2)

library(microbenchmark)
microbenchmark::microbenchmark(A%*%B%*%C%*%D%*%E,A%*%(B%*%C)%*%D%*%E,A%*%(B%*%C)%*%(D%*%E), times=100)

library(Rcpp)
sourceCpp('pruebas_cpp.cpp')

microbenchmark::microbenchmark(A%*%B%*%C%*%D%*%E,A%*%(B%*%C)%*%(D%*%E),multiplyFiveMatrices(A,B,C,D,E) ,times=100)

sourceCpp('pruebas_cpp2.cpp')
