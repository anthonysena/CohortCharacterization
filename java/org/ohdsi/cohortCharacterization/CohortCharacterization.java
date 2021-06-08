/*******************************************************************************
 * Copyright 2021 Observational Health Data Sciences and Informatics
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *   http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 ******************************************************************************/
package org.ohdsi.cohortCharacterization;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.StringWriter;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.locks.ReentrantLock;

import org.json.JSONArray;
import org.json.JSONObject;
import org.json.JSONWriter;
import org.ohdsi.sql.SqlRender;

/**
 * FeatureExtraction engine. Generates SQL for constructing and downloading features for cohorts of interest.
 */
public class CohortCharacterization {
	
	private static ReentrantLock							lock							= new ReentrantLock();
//	private static Map<String, PrespecAnalysis>				nameToPrespecAnalysis			= null;
//	private static Map<String, PrespecAnalysis>				nameToPrespecTemporalAnalysis	= null;
	private static Map<String, String>						nameToSql						= null;
	private static String									createCovRefTableSql			= null;
//	private static Map<String, Map<String, OtherParameter>>	typeToNameToOtherParameters		= null;
	private static Set<String>								otherParameterNames				= null;
	
	private static String									TEMPORAL						= "temporal";
	private static String									ANALYSIS_ID						= "analysisId";
	private static String									ANALYSIS_NAME					= "analysisName";
	private static String									DESCRIPTION						= "description";
	private static String									IS_DEFAULT						= "isDefault";
	private static String									SQL_FILE_NAME					= "sqlFileName";
	private static String									ANALYSES						= "analyses";
	private static String									PARAMETERS						= "parameters";
	private static String									INCLUDED_COVARIATE_CONCEPT_IDS	= "includedCovariateConceptIds";
	private static String									ADD_DESCENDANTS_TO_INCLUDE		= "addDescendantsToInclude";
	private static String									EXCLUDED_COVARIATE_CONCEPT_IDS	= "excludedCovariateConceptIds";
	private static String									ADD_DESCENDANTS_TO_EXCLUDE		= "addDescendantsToExclude";
	private static String									INCLUDED_COVARIATE_IDS			= "includedCovariateIds";
	
	private static String									COMMON_TYPE						= "common";
	private static String									DAYS_TYPE						= "days";
	private static String									TEMPORAL_TYPE					= "temporal";
	
	private static String									ADD_DESCENDANTS_SQL				= "SELECT descendant_concept_id AS id\nINTO @target_temp\nFROM @cdm_database_schema.concept_ancestor\nINNER JOIN @source_temp\n\tON ancestor_concept_id = id;\n\n";
	
	public static void main(String[] args) {
		//init("C:/Users/mschuemi/git/FeatureExtraction/inst");
		// init("C:/R/R-3.3.1/library/FeatureExtraction");
		
		// System.out.println(convertSettingsPrespecToDetails("{\"temporal\":false,\"DemographicsGender\":true,\"DemographicsAge\":true,\"longTermStartDays\":-365,\"mediumTermStartDays\":-180,\"shortTermStartDays\":-30,\"endDays\":0,\"includedCovariateConceptIds\":[],\"addDescendantsToInclude\":false,\"excludedCovariateConceptIds\":[1,2,3],\"addDescendantsToExclude\":false,\"includedCovariateIds\":[]}"));
		// System.out.println(getDefaultPrespecAnalyses());
		//
		// System.out.println(getDefaultPrespecAnalyses());
		//
		//String settings = getDefaultPrespecTemporalAnalyses();
		// String settings = convertSettingsPrespecToDetails(getDefaultPrespecTemporalAnalyses());
		// System.out.println(convertSettingsPrespecToDetails(getDefaultPrespecAnalyses()));
		// String settings =
		// "{\"temporal\":false,\"analyses\":[{\"analysisId\":301,\"sqlFileName\":\"DomainConcept.sql\",\"parameters\":{\"analysisId\":301,\"startDay\":-365,\"endDay\":0,\"inpatient\":\"\",\"domainTable\":\"drug_exposure\",\"domainConceptId\":\"drug_concept_id\",\"domainStartDate\":\"drug_exposure_start_date\",\"domainEndDate\":\"drug_exposure_start_date\"},\"addDescendantsToExclude\":true,\"includedCovariateConceptIds\":[1,2,21600537410],\"excludedCovariateConceptIds\":{},\"addDescendantsToInclude\":true,\"includedCovariateIds\":12301}]}";
		// String settings = convertSettingsPrespecToDetails(getDefaultPrespecAnalyses());
		//System.out.println(createSql(settings, true, "#temp_cohort", "row_id", -1, "cdm_synpuf"));
		// System.out.println(createSql(getDefaultPrespecAnalyses(), true, "#temp_cohort", "row_id", -1, "cdm_synpuf"));
		// System.out.println(createSql(getDefaultPrespecTemporalAnalyses(), false, "#temp_cohort", "row_id", -1, "cdm_synpuf"));
                String sql = loadSqlFile("D:/git/anthonysena/CohortCharacterization/inst", "cohort_characterization_results_tables.sql");
                System.out.println(sql);
	}

	public static String loadSqlFile(String packageFolder, String sqlFileName) {
		try {
			InputStream inputStream;
			if (packageFolder == null) // Use file in JAR
				inputStream = CohortCharacterization.class.getResourceAsStream("/inst/sql/sql_server/" + sqlFileName);
			else
				inputStream = new FileInputStream(packageFolder + "/sql/sql_server/" + sqlFileName);
			BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(inputStream, "UTF-8"));
			StringBuilder sql = new StringBuilder();
			String line;
			while ((line = bufferedReader.readLine()) != null)
				sql.append(line + "\n");
			return sql.toString();
		} catch (UnsupportedEncodingException e) {
			System.err.println("Computer does not support UTF-8 encoding");
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}

}
