#include <RcppArmadillo.h>
// [[Rcpp::depends(RcppArmadillo)]]

// Function to multiply five matrices
// Assume matrices are of compatible sizes
// Inputs are passed as Rcpp::NumericMatrix objects
// Outputs are returned as Rcpp::NumericMatrix objects
// [[Rcpp::export]]
Rcpp::NumericMatrix multiplyFiveMatrices(Rcpp::NumericMatrix A, Rcpp::NumericMatrix B,
                                         Rcpp::NumericMatrix C, Rcpp::NumericMatrix D,
                                         Rcpp::NumericMatrix E) {
  // Convert Rcpp::NumericMatrix objects to Armadillo matrices
  arma::mat armaA = arma::mat(Rcpp::as<arma::mat>(A));
  arma::mat armaB = arma::mat(Rcpp::as<arma::mat>(B));
  arma::mat armaC = arma::mat(Rcpp::as<arma::mat>(C));
  arma::mat armaD = arma::mat(Rcpp::as<arma::mat>(D));
  arma::mat armaE = arma::mat(Rcpp::as<arma::mat>(E));
  
  // Multiply matrices without explicit parenthesization
  arma::mat result = armaA * armaB * armaC * armaD * armaE;
  
  // Convert Armadillo matrix back to Rcpp::NumericMatrix
  Rcpp::NumericMatrix resultR = Rcpp::wrap(result);
  
  return resultR;
}
