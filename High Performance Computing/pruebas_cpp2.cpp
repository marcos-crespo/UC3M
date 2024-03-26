#include <RcppArmadillo.h>
using namespace Rcpp;

// - Result of the matrix chain multiplication
// [[Rcpp::depends(RcppArmadillo)]]

bool checkMatrixDimensions(const Rcpp::NumericMatrix& A, const Rcpp::NumericMatrix& B) {
  int nrowA = A.nrow();
  int ncolA = A.ncol();
  int nrowB = B.nrow();
  int ncolB = B.ncol();
  
  // Check if dimensions are suitable for multiplication
  return (ncolA == nrowB);
}
bool anyDuplicates(IntegerVector vec) {
  std::unordered_set<double> seen;
  for (int i = 0; i < vec.size(); ++i) {
    if (seen.find(vec[i]) != seen.end()) {
      return true;
    } else {
      seen.insert(vec[i]);
    }
  }
  return false;
}

bool checkDimensions(IntegerVector vec, int dims) {
  for (int i = 0; i < vec.size(); ++i) {
    if (vec[i] > dims) {
      return false;
    }
  }
  return true;
}
// [[Rcpp::export]]
arma::mat matrixChainMultiplication(List matrices, IntegerVector order) {
  // Check if the order vector is valid
  if (order.size() != matrices.size() - 1) {
    Rcpp::stop("Invalid order vector size");
  }
  for(int i=0; i<matrices.length()-1;i++){
    if (!checkMatrixDimensions(matrices[i], matrices[i+1])){
      Rcpp::stop("Invalid matrices sizes. Check matrix dimensions");
    }
  }
  if (anyDuplicates(order)){
    Rcpp::stop("Invalid order vector. Check for duplicates");
  }
  if (!checkDimensions(order,matrices.size()-2)){
    Rcpp::stop("Invalid order number. Number out of bounds");
  }
  
  LogicalVector indicator(order.size(), false);
  IntegerVector index(order.size());
  List steps(order.size());
  int cont =1;
  
  for (int i = 0; i < order.size(); i++) {
    int curr_order = order[i];
    arma::mat l, r;
    if (!indicator[curr_order -1]){
      arma::mat l = as<arma::mat>(matrices[curr_order]);
    } else {
      arma::mat l = as<arma::mat> (steps[index[curr_order-1]]);
    }
    if (!indicator[curr_order +1]){
      arma::mat r = as<arma::mat>(matrices[curr_order+1]);
    } else {
      arma::mat r= as<arma::mat> (steps[index[curr_order+1]]);
    }
    steps[i] = l*r;
    index[curr_order] = cont;
    cont++;
  }
  
  return steps[order.size()-1];
}

