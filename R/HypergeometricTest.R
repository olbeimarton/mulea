#' PRIVATE class : An S4 class to represent a Hypergeometric tests in mulea.
#'
#' @slot gmt A data.frame representing the GMT model.
#' @slot element_names Data to be analysed across the model.
#' @slot background_element_names Background data used for the test.
#' @return muleaHypergeometricTest object. Used as private function.
#' @examples
#' \dontrun{
#' #It is a private s4 object. Look at ora's examples.
#' }
muleaHypergeometricTest <- setClass(
  "muleaHypergeometricTest",
  slots = list(
    gmt = "data.frame",
    element_names = "character",
    pool = "character",
    number_of_cpu_threads = "numeric",
    test = "function"
  )
)

setMethod("initialize", "muleaHypergeometricTest",
          function(.Object,
                   gmt = data.frame(),
                   element_names = character(),
                   pool = character(),
                   number_of_cpu_threads = 4,
                   test = NULL,
                   ...) {
            .Object@gmt <- gmt
            .Object@element_names <- element_names
            .Object@pool <- pool
            .Object@number_of_cpu_threads <- number_of_cpu_threads
            
            .Object@test <- function(model) {
              model@element_names <- checkIfPoolIncludeSample(model@gmt, model@element_names, model@pool)
              
              muleaSetBaseEnrichmentTest <-
                SetBasedEnrichmentTest(
                  gmt = model@gmt,
                  element_names = model@element_names,
                  pool = model@pool,
                  only_hyper_geometric_test = TRUE,
                  nthreads = model@number_of_cpu_threads
                )
              
              muleaSetBaseEnrichmentTestResult <- run_test(muleaSetBaseEnrichmentTest)
              modelGlobal <- model

              #muleaSetBaseEnrichmentTestResult <<- run_test(muleaSetBaseEnrichmentTest)
              #modelGlobal <<- model
              
              testResults <- data.frame(
                'ontology_name' = muleaSetBaseEnrichmentTestResult$DB_names,
                'list_of_values' = model@gmt$list_of_values,
                'p.value' = muleaSetBaseEnrichmentTestResult$P_val,
                row.names = NULL
              )
              
              testResults
            }
            
            .Object
            
          })

#' @describeIn muleaHypergeometricTest runs test calculations.
#' @param model Object of s4 class represents mulea Test.
#' @return run_test method for muleaHypergeometricTest object. Used as private
#' function.
#' @examples
#' \dontrun{
#' #It is a private method. Look at run_test of ora's examples.
#' }
setMethod("run_test",
          signature(model = "muleaHypergeometricTest"),
          function(model) {
            model@test(model)
          })
