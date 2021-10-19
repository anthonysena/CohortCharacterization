DROP TABLE IF EXISTS @results_schema.analysis_ref;
CREATE TABLE @results_schema.analysis_ref
(
    analysis_id bigint NOT NULL,
    analysis_name VARCHAR(4000) NOT NULL,
    domain_id VARCHAR(1000) NOT NULL,
    start_day float NOT NULL,
    end_day float NOT NULL,
    is_binary integer NOT NULL,
    missing_means_zero integer NOT NULL,
    study_design_id bigint NOT NULL,
    PRIMARY KEY(analysis_id)
)
;

DROP TABLE IF EXISTS @results_schema.cohort;
CREATE TABLE @results_schema.cohort
(
    cohort_definition_id bigint NOT NULL,
    subject_id bigint NOT NULL,
    cohort_start_date date NOT NULL,
    cohort_end_date date NOT NULL
)
;

DROP TABLE IF EXISTS @results_schema.cohort_count;
CREATE TABLE @results_schema.cohort_count
(
    cohort_id bigint NOT NULL,
    cohort_entries bigint NOT NULL,
    cohort_subjects bigint NOT NULL,
    database_id character varying(255) NOT NULL,
    PRIMARY KEY(cohort_id, database_id)
)
;

DROP TABLE IF EXISTS @results_schema.cohort_definition;
CREATE TABLE @results_schema.cohort_definition
(
    cohort_definition_id bigint NOT NULL,
    cohort_name VARCHAR(4000) NOT NULL,
    description VARCHAR(4000) NOT NULL,
    json text,
	sql_command text NOT NULL,
    PRIMARY KEY(cohort_definition_id)
)
;

DROP TABLE IF EXISTS @results_schema.cohort_xref;
CREATE TABLE @results_schema.cohort_xref
(
    cohort_id bigint NOT NULL,
    target_id bigint NOT NULL,
    target_name character varying(4000) NOT NULL,
    subgroup_id bigint NOT NULL,
    subgroup_name character varying(4000) NOT NULL,
    cohort_type character varying(4000) NOT NULL,
    PRIMARY KEY(cohort_id)
)
;

DROP TABLE IF EXISTS @results_schema.covariate_ref;
CREATE TABLE @results_schema.covariate_ref
(
    covariate_id bigint NOT NULL,
    covariate_type_id integer NOT NULL,
    covariate_name VARCHAR(4000) NOT NULL,
    analysis_id bigint NOT NULL,
    concept_id bigint,
    PRIMARY KEY(covariate_id, covariate_type_id)
)
;

DROP TABLE IF EXISTS @results_schema.covariate_type;
CREATE TABLE @results_schema.covariate_type
(
    covariate_type_id integer NOT NULL,
    covariate_type_name VARCHAR(1000) NOT NULL,
    study_design_id integer NOT NULL,
    PRIMARY KEY(covariate_type_id)
)
;

DROP TABLE IF EXISTS @results_schema.covariate_value;
CREATE TABLE @results_schema.covariate_value
(
    cohort_id bigint NOT NULL,
    covariate_id bigint NOT NULL,
    covariate_type_id integer NOT NULL,
    time_id bigint NOT NULL,
    sum_value bigint NOT NULL,
    mean float NOT NULL,
    sd float,
    database_id VARCHAR(1000) NOT NULL,
    PRIMARY KEY(cohort_id, covariate_id, covariate_type_id, time_id, database_id)
)
;

DROP TABLE IF EXISTS @results_schema.covariate_value_dist;
CREATE TABLE @results_schema.covariate_value_dist
(
    cohort_id bigint NOT NULL,
    covariate_id bigint NOT NULL,
    covariate_type_id integer NOT NULL,
    time_id bigint NOT NULL,
    count_value bigint NOT NULL,
    min_value bigint NOT NULL,
    max_value bigint NOT NULL,
    mean float NOT NULL,
    sd float NOT NULL,
    median_value bigint NOT NULL,
    p_10_value bigint NOT NULL,
    p_25_value bigint NOT NULL,
    p_75_value bigint NOT NULL,
    p_90_value bigint NOT NULL,
    database_id VARCHAR(1000) NOT NULL,
    PRIMARY KEY(cohort_id, covariate_id, covariate_type_id, time_id, database_id)
);

DROP TABLE IF EXISTS @results_schema.database;
CREATE TABLE @results_schema.database
(
    database_id VARCHAR(1000) NOT NULL,
    database_name VARCHAR(4000) NOT NULL,
    description VARCHAR(4000),
  	database_source_documentation_reference VARCHAR(4000),
  	database_cdm_etl_reference VARCHAR(4000),
  	database_source_release_date VARCHAR(4000),
  	database_cdm_release_date VARCHAR(4000),
  	database_cdm_version VARCHAR(4000),
    vocabulary_version VARCHAR(100),
    data_start_date VARCHAR(100),
    data_end_date VARCHAR(100),
    is_meta_analysis integer,
    terms_of_use VARCHAR(4000),
    citation_req VARCHAR(4000),
    publication_req VARCHAR(4000),
    PRIMARY KEY(database_id)
)
;

DROP TABLE IF EXISTS @results_schema.study_design;
CREATE TABLE @results_schema.study_design
(
    study_design_id bigint NOT NULL,
    study_design_name VARCHAR(4000) NOT NULL,
    study_design_hash VARCHAR(4000) NOT NULL,
    PRIMARY KEY(study_design_id)
)
;

DROP TABLE IF EXISTS @results_schema.time_ref;
CREATE TABLE @results_schema.time_ref
(
    time_id bigint NOT NULL,
    time_start integer NOT NULL,
    time_end integer NOT NULL,
    window_type_id integer NOT NULL,
    study_design_id bigint,
    time_window_name VARCHAR(1000),
    PRIMARY KEY(time_id)    
)
;

DROP TABLE IF EXISTS @results_schema.window_type_ref;
CREATE TABLE @results_schema.window_type_ref
(
    window_type_id integer NOT NULL,
    window_type_name VARCHAR(1000) NOT NULL,
    PRIMARY KEY(window_type_id)    
)
;
