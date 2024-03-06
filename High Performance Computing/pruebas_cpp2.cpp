#include <RcppArmadillo.h>
// [[Rcpp::depends(RcppArmadillo)]]

// Function to perform matrix multiplication based on a given order
// Inputs:
//   matrices: List of matrices
//   order: Vector defining the order of matrix multiplication
// Returns:
//   Result of the matrix multiplication
// [[Rcpp::export]]
Rcpp::NumericMatrix multiplyMatricesInOrder(Rcpp::List matrices, Rcpp::IntegerVector order) {
  // Check if the order vector is valid
  if (order.size() != matrices.size() - 1) {
    Rcpp::stop("Invalid order vector size");
  }
  
  // Initialize result matrix
  arma::mat result = arma::eye<arma::mat>(matrices[0].rows(), matrices[order[0]].cols());
  
  // Perform matrix multiplication based on the given order
  for (int i = 0; i < order.size(); ++i) {
    arma::mat currentMat = arma::mat(Rcpp::as<arma::mat>(matrices[order[i]]));
    result *= currentMat;
  }
  
  // Convert Armadillo matrix back to Rcpp::NumericMatrix
  Rcpp::NumericMatrix resultR = Rcpp::wrap(result);
  
  return resultR;
}
