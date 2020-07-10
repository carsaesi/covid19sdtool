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

#' Estimates the word2vec tokenization of variables containing tokenized values.
#'
performWord2Vec <- function(data, targetVariable, term_count_min = 2, doc_proportion_min = 0.025) {
  
  prep_fun = tolower
  tok_fun = word_tokenizer
  
  it_text = itoken(data[[targetVariable]], 
                   preprocessor = prep_fun, 
                   tokenizer = tok_fun,
                   progressbar = TRUE)
  
  vocab = create_vocabulary(it_text)
  vocab = prune_vocabulary(vocab, term_count_min = term_count_min, doc_proportion_min = doc_proportion_min)
  
  vectorizer = vocab_vectorizer(vocab)
  dtm_text = create_dtm(it_text, vectorizer)
 
  # create matrix of texts (one row per individual)
  textsVector = as.matrix(dtm_text)
  
  # find  those texts where terms in the vocabulary were present
  idsValidTexts = rowSums(textsVector) > 0

  results <- list("textsVector" = textsVector, "vocab" = vocab, "idsValidTexts" = idsValidTexts)
  return(results)
  
}