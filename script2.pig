-- Load the dataset
raw_data = LOAD 'tugas2.csv' USING PigStorage(',') AS (
    date:chararray,
    opponent:chararray,
    outcome:chararray,
    method:chararray,
    rounds:int,
    location:chararray
);

-- Filter fights won by Muhammad Ali
ali_wins = FILTER raw_data BY outcome == 'Win';

-- Group fights by outcome and count
fights_by_outcome = GROUP raw_data BY outcome;
outcome_count = FOREACH fights_by_outcome GENERATE 
    group AS outcome, 
    COUNT(raw_data) AS count;

-- Filter fights that ended by knockout
knockout_fights = FILTER raw_data BY method MATCHES '.*KO.*';

-- Group fights by location and count
fights_by_location = GROUP raw_data BY location;
location_count = FOREACH fights_by_location GENERATE 
    group AS location, 
    COUNT(raw_data) AS count;

-- Output results
STORE ali_wins INTO 'ali_wins' USING PigStorage(',');
STORE outcome_count INTO 'outcome_count' USING PigStorage(',');
STORE knockout_fights INTO 'knockout_fights' USING PigStorage(',');
STORE location_count INTO 'location_count' USING PigStorage(',');