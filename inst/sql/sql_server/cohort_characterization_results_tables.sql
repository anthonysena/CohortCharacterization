CREATE TABLE @results_schema.study_design
(
    study_design_id bigint NOT NULL,
    study_design_name VARCHAR(4000) NOT NULL,
    study_design_hash VARCHAR(4000) NOT NULL
)
;

CREATE TABLE @results_schema.covariate_ref
(
    study_design_id bigint,
    covariate_id bigint NOT NULL,
    covariate_name VARCHAR(4000) NOT NULL,
    analysis_id bigint NOT NULL,
    concept_id bigint,
    covariate_type_id integer NOT NULL
)
;

CREATE TABLE @results_schema.covariate_value
(
    cohort_id bigint NOT NULL,
    covariate_id bigint NOT NULL,
    time_id bigint NOT NULL,
    sum_value bigint,
    mean float,
    sd float,
    database_id VARCHAR(1000),
    study_design_id bigint,
    covariate_type_id integer NOT NULL
)
;

CREATE TABLE @results_schema.cohort
(
    cohort_definition_id bigint NOT NULL,
    subject_id bigint NOT NULL,
    cohort_start_date date NOT NULL,
    cohort_end_date date NOT NULL
)
;

CREATE TABLE @results_schema.time_ref
(
    time_id bigint NOT NULL,
    time_start integer NOT NULL,
    time_end integer NOT NULL,
    window_type_id integer NOT NULL,
    study_design_id bigint,
    time_window_name VARCHAR(1000)
)
;

CREATE TABLE @results_schema.window_type_ref
(
    window_type_id integer NOT NULL,
    window_type_name VARCHAR(1000) NOT NULL
)
;

CREATE TABLE @results_schema.covariate_value_dist
(
    cohort_id bigint NOT NULL,
    covariate_id bigint NOT NULL,
    time_id bigint NOT NULL,
    count_value bigint,
    min_value bigint,
    max_value bigint,
    mean float,
    sd float,
    median_value bigint,
    p_10_value bigint,
    p_25_value bigint,
    p_75_value bigint,
    p_90_value bigint,
    database_id VARCHAR(1000),
    study_design_id bigint,
    covariate_type_id integer NOT NULL
);

CREATE TABLE @results_schema.analysis_ref
(
    analysis_id bigint NOT NULL,
    analysis_name VARCHAR(4000) NOT NULL,
    domain_id VARCHAR(1000),
    start_day float,
    end_day float,
    is_binary integer NOT NULL,
    missing_means_zero integer,
    study_design_id bigint
)
;

CREATE TABLE @results_schema.database
(
    database_id VARCHAR(1000) NOT NULL,
    database_name VARCHAR(4000) NOT NULL,
    description VARCHAR(4000),
    vocabulary_version VARCHAR(100),
    min_obs_period_date VARCHAR(100),
    max_obs_period_date VARCHAR(100),
    is_meta_analysis integer,
    terms_of_use VARCHAR(4000),
    citation_req VARCHAR(4000),
    publication_req VARCHAR(4000)
)
;

CREATE TABLE @results_schema.cohort_definition
(
    cohort_definition_id bigint NOT NULL,
    cohort_name VARCHAR(4000) NOT NULL,
    description VARCHAR(4000),
    json VARCHAR(MAX)
)
;

CREATE TABLE @results_schema.covariate_type
(
    covariate_type_id integer NOT NULL,
    covariate_type_name VARCHAR(1000),
    study_design_id integer
)
;