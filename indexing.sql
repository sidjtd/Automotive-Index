DROP INDEX make_title;
DROP INDEX model_title;
DROP INDEX make_code;

CREATE INDEX make_title ON car_models (make_title);
CREATE INDEX model_title ON car_models (model_title);
CREATE INDEX make_code ON car_models (make_code);