#' @keywords internal
"_PACKAGE"

#' @importFrom SqlRender loadRenderTranslateSql translate render
#' @importFrom methods is
#' @importFrom stats aggregate quantile sd
#' @importFrom rlang .data
#' @import DatabaseConnector
#' @import dplyr
NULL

.onLoad <- function(libname, pkgname) {

  rJava::.jpackage(pkgname, lib.loc = libname)

  # Taken from FeatureExtraction
  # Verify checksum of JAR:
  #storedChecksum <- scan(file = system.file("csv", "jarChecksum.txt", package = "CohortCharacterization"), what = character(), quiet = TRUE)
  #computedChecksum <- tryCatch(rJava::J("org.ohdsi.featureExtraction.JarChecksum","computeJarChecksum"),
  #                             error = function(e) {warning("Problem connecting to Java. This is normal when runing roxygen."); return("")})
  #if (computedChecksum != "" && (storedChecksum != computedChecksum)) {
  #  warning("Java library version does not match R package version! Please try reinstalling the FeatureExtraction package.
  #          Make sure to close all instances of R, and open only one instance before reinstalling. Also make sure your
  #          R workspace is not reloaded on startup. Delete your .Rdata file if necessary")
  #}
}