#' Run enrichment analysis procedure
#' 
#' This is a generic function that chooses an enrichment analysis procedure
#' based on the model class and runs the analysis.
#' @param model An S4 object which represents one of mulea's Tests. See details
#' for more information.
#' @details The function requires the definition of a model. Models currently
#' implemented in mulea include Gene Set Enrichment Analysis (GSEA) and
#' Over-Representation Analysis (ORA). These models must be defined through
#' their specific functions which are provided in this package. 
#' @seealso \code{\link{gsea}}, \code{\link{ora}}
#' @export
#' @examples
#' modelDfFromFile <- read_gmt(
#'   file = system.file(package="mulea", "extdata", "model.gmt"))
#' dataFromExperiment <- c(
#'   "FBgn0004407", "FBgn0010438", "FBgn0003742", "FBgn0029709", "FBgn0030341",
#'   "FBgn0037044", "FBgn0002887", "FBgn0028434", "FBgn0030170", "FBgn0263831")
#' dataFromExperimentPool <- unique(
#'   c(c("FBgn0033690", "FBgn0261618", "FBgn0004407", "FBgn0010438",
#'       "FBgn0032154", "FBgn0039930", "FBgn0040268", "FBgn0013674",
#'       "FBgn0037008", "FBgn0003116", "FBgn0037743", "FBgn0035401",
#'       "FBgn0037044", "FBgn0051005", "FBgn0026737", "FBgn0026751",
#'       "FBgn0038704", "FBgn0002887", "FBgn0028434", "FBgn0030170",
#'       "FBgn0263831", "FBgn0000579"),
#'    c("FBgn0066666", "FBgn0000000", "FBgn0099999", "FBgn0011111",
#'      "FBgn0022222", "FBgn0777777", "FBgn0333333", "FBgn0003742",
#'      "FBgn0029709", "FBgn0030341")))
#' setBasedTest <- ora(gmt = modelDfFromFile, element_names = dataFromExperiment,
#'                    number_of_cpu_threads = 2)
#' setBasedTestWithPool <- ora(gmt = modelDfFromFile,
#'                             element_names = dataFromExperiment,
#'                             background_element_names = dataFromExperimentPool,
#'                             number_of_cpu_threads = 2)
#' setBasedTestWithPoolAndAdjust <- ora(gmt = modelDfFromFile,
#'                                      element_names = dataFromExperiment,
#'                                      background_element_names = dataFromExperimentPool,
#'                                      p_value_adjustment_method = "BH",
#'                                      number_of_cpu_threads = 2)
#' setBasedTestRes <- run_test(setBasedTest)
#' setBasedTestWithPoolRes <- run_test(setBasedTestWithPool)
#' setBasedTestWithPoolAndAdjustRes <- run_test(setBasedTestWithPoolAndAdjust)
#' dataFromExperimentScores <- c(0.09, 0.11, 0.15, 0.20, 0.21, 0.24, 0.28,
#'                               0.30, 0.45, 0.50)
#' GSEASubramanian <- gsea(
#'   method = "Subramanian",
#'   gmt = modelDfFromFile,
#'   element_names = dataFromExperiment,
#'   element_scores = dataFromExperimentScores)
#' GSEASubramanianRes <- mulea::run_test(GSEASubramanian)
#' @return Results in form of data frame. Structure of data frame depends on
#' object processed by this generic method.
#' @importFrom methods new
setGeneric("run_test", function(model)
  standardGeneric("run_test"))
