#' @export
getResultsSchemaSql <- function() {
  sql <- rJava::J("org.ohdsi.cohortCharacterization.CohortCharacterization")$loadSqlFile(system.file("", package = "CohortCharacterization"), "/sql/postgresql/", "cohort_characterization_results_tables.sql")
  return(sql)
}