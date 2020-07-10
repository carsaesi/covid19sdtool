# Copyright 2020 Biomedical Data Science Lab, Universitat Politècnica de València (Spain)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#' Estimates the mean proportion and confidence intervals of a binary variable at a given confidence level.
#'
pCI <- function(x, alpha = 0.05){
  n = length(x)
  phat = sum(x)/n
  error = qnorm(alpha/2,lower.tail = F)*sqrt(phat*(1-phat)/n)
  res = c(phat, phat-error, phat+error)
  names(res) <- c('p','lci','uci')
  return(res)
}