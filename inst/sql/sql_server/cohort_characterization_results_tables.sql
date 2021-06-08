-- This script was generated by a beta version of the ERD tool in pgAdmin 4.
-- Please log an issue at https://redmine.postgresql.org/projects/pgadmin4/issues/new if you find any bugs, including reproduction steps.
BEGIN;


CREATE TABLE IF NOT EXISTS public.study_design
(
    study_design_id bigint NOT NULL,
    study_design_name character varying(4000) NOT NULL,
    study_design_hash character varying NOT NULL,
    PRIMARY KEY (study_design_id)
)
WITH (
    OIDS = FALSE
);

COMMENT ON TABLE public.study_design
    IS 'Holds the metadata describing the study design in reference to the results';

CREATE TABLE IF NOT EXISTS public.covariate_ref
(
    study_design_id bigint,
    covariate_id bigint NOT NULL,
    covariate_name character varying NOT NULL,
    analysis_id bigint NOT NULL,
    concept_id bigint,
    covariate_type_id integer NOT NULL,
    PRIMARY KEY (covariate_id, covariate_type_id)
)
WITH (
    OIDS = FALSE
);

CREATE TABLE IF NOT EXISTS public.covariate_value
(
    cohort_id bigint NOT NULL,
    covariate_id bigint NOT NULL,
    time_id bigint NOT NULL,
    sum_value bigint,
    mean numeric,
    sd numeric,
    database_id character varying,
    study_design_id bigint,
    covariate_type_id integer NOT NULL,
    PRIMARY KEY (cohort_id, covariate_id, time_id, covariate_type_id)
)
WITH (
    OIDS = FALSE
);

COMMENT ON TABLE public.covariate_value
    IS 'Holds the binary features for a cohort. The database_id will be added on when the results are assembled from a network.';

CREATE TABLE IF NOT EXISTS public.cohort
(
    cohort_definition_id bigint NOT NULL,
    subject_id bigint NOT NULL,
    cohort_start_date date NOT NULL,
    cohort_end_date date NOT NULL,
    PRIMARY KEY (cohort_definition_id, subject_id, cohort_start_date, cohort_end_date)
)
WITH (
    OIDS = FALSE
);

CREATE TABLE IF NOT EXISTS public.time_ref
(
    time_id bigint NOT NULL,
    start integer NOT NULL,
    "end" integer NOT NULL,
    window_type_id integer NOT NULL,
    study_design_id bigint,
    time_window_name character varying,
    PRIMARY KEY (time_id)
)
WITH (
    OIDS = FALSE
);

CREATE TABLE IF NOT EXISTS public.window_type_ref
(
    window_type_id integer NOT NULL,
    window_type_name character varying NOT NULL,
    PRIMARY KEY (window_type_id)
)
WITH (
    OIDS = FALSE
);

CREATE TABLE IF NOT EXISTS public.covariate_value_dist
(
    cohort_id bigint NOT NULL,
    covariate_id bigint NOT NULL,
    time_id bigint NOT NULL,
    count_value bigint,
    min_value bigint,
    max_value bigint,
    mean numeric,
    sd numeric,
    median_value bigint,
    p_10_value bigint,
    p_25_value bigint,
    p_75_value bigint,
    p_90_value bigint,
    database_id character varying,
    study_design_id bigint,
    covariate_type_id integer NOT NULL,
    PRIMARY KEY (cohort_id, covariate_id, time_id, covariate_type_id)
)
WITH (
    OIDS = FALSE
);

CREATE TABLE IF NOT EXISTS public.analysis_ref
(
    analysis_id bigint NOT NULL,
    analysis_name character varying NOT NULL,
    domain_id character varying,
    start_day numeric,
    end_day numeric,
    is_binary integer NOT NULL,
    missing_means_zero integer,
    study_design_id bigint,
    PRIMARY KEY (analysis_id)
)
WITH (
    OIDS = FALSE
);

CREATE TABLE IF NOT EXISTS public.database
(
    database_id character varying NOT NULL,
    database_name character varying NOT NULL,
    description character varying,
    vocabulary_version character varying,
    min_obs_period_date character varying,
    max_obs_period_date character varying,
    is_meta_analysis integer,
    terms_of_use character varying,
    citation_req character varying,
    publication_req character varying,
    PRIMARY KEY (database_id)
)
WITH (
    OIDS = FALSE
);

CREATE TABLE IF NOT EXISTS public.cohort_definition
(
    cohort_definition_id bigint NOT NULL,
    cohort_name character varying NOT NULL,
    description character varying,
    json character varying,
    PRIMARY KEY (cohort_definition_id)
)
WITH (
    OIDS = FALSE
);

CREATE TABLE IF NOT EXISTS public.covariate_type
(
    covariate_type_id integer NOT NULL,
    covariate_type_name character varying,
    study_design_id integer,
    PRIMARY KEY (covariate_type_id)
)
WITH (
    OIDS = FALSE
);

COMMENT ON TABLE public.covariate_type
    IS '1 = FeatureExtraction, 2 = TemporalFeatureExtraction';

ALTER TABLE public.cohort
    ADD FOREIGN KEY (cohort_definition_id)
    REFERENCES public.covariate_value (cohort_id)
    NOT VALID;


ALTER TABLE public.covariate_value
    ADD FOREIGN KEY (covariate_id)
    REFERENCES public.covariate_ref (covariate_id)
    NOT VALID;


ALTER TABLE public.covariate_value
    ADD FOREIGN KEY (time_id)
    REFERENCES public.time_ref (time_id)
    NOT VALID;


ALTER TABLE public.covariate_value_dist
    ADD FOREIGN KEY (cohort_id)
    REFERENCES public.cohort (cohort_definition_id)
    NOT VALID;


ALTER TABLE public.covariate_value_dist
    ADD FOREIGN KEY (covariate_id)
    REFERENCES public.covariate_ref (covariate_id)
    NOT VALID;


ALTER TABLE public.covariate_value_dist
    ADD FOREIGN KEY (time_id)
    REFERENCES public.time_ref (time_id)
    NOT VALID;


ALTER TABLE public.study_design
    ADD FOREIGN KEY (study_design_id)
    REFERENCES public.analysis_ref (study_design_id)
    NOT VALID;


ALTER TABLE public.covariate_value
    ADD FOREIGN KEY (database_id)
    REFERENCES public.database (database_id)
    NOT VALID;


ALTER TABLE public.covariate_value_dist
    ADD FOREIGN KEY (database_id)
    REFERENCES public.database (database_id)
    NOT VALID;


ALTER TABLE public.cohort_definition
    ADD FOREIGN KEY (cohort_definition_id)
    REFERENCES public.cohort (cohort_definition_id)
    NOT VALID;


ALTER TABLE public.covariate_value_dist
    ADD FOREIGN KEY (covariate_type_id)
    REFERENCES public.covariate_type (covariate_type_id)
    NOT VALID;


ALTER TABLE public.study_design
    ADD FOREIGN KEY (study_design_id)
    REFERENCES public.covariate_type (covariate_type_id)
    NOT VALID;


ALTER TABLE public.covariate_ref
    ADD FOREIGN KEY (covariate_type_id)
    REFERENCES public.covariate_type (covariate_type_id)
    NOT VALID;


ALTER TABLE public.covariate_value
    ADD FOREIGN KEY (covariate_type_id)
    REFERENCES public.covariate_type (covariate_type_id)
    NOT VALID;


ALTER TABLE public.study_design
    ADD FOREIGN KEY (study_design_id)
    REFERENCES public.covariate_value_dist (study_design_id)
    NOT VALID;


ALTER TABLE public.covariate_value
    ADD FOREIGN KEY (study_design_id)
    REFERENCES public.study_design (study_design_id)
    NOT VALID;


ALTER TABLE public.time_ref
    ADD FOREIGN KEY (window_type_id)
    REFERENCES public.window_type_ref (window_type_id)
    NOT VALID;

END;