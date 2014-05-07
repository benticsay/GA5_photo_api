CREATE TABLE selfies
(
  id  serial NOT NULL primary key,
  user_name varchar(255),
  description varchar(255),
  url  text
);