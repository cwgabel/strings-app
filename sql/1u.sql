CREATE EXTENSION IF NOT EXISTS CITEXT;

CREATE TABLE
 IF NOT EXISTS PUBLIC.USERS (
        ID BIGSERIAL PRIMARY KEY,
        USERNAME CITEXT UNIQUE NOT NULL,
        PASSWORD TEXT,
        AVATAR TEXT,
        IS_ADMIN BOOLEAN DEFAULT FALSE,
        CREATED_AT TIMESTAMP DEFAULT NOW (),
        UPDATED_AT TIMESTAMP DEFAULT NOW ()
    );

CREATE TABLE 
 IF NOT EXISTS PUBLIC.POSTS (
        ID BIGSERIAL PRIMARY KEY,
        USER_ID BIGINT REFERENCES PUBLIC.USERS (ID),
        CONTENT TEXT,
        CREATED_AT TIMESTAMP DEFAULT NOW (),
        UPDATED_AT TIMESTAMP DEFAULT NOW ()
    );

CREATE TABLE 
 IF NOT EXISTS PUBLIC.FOLLOWS (
        USER_ID BIGSERIAL NOT NULL REFERENCES PUBLIC.USERS (ID),
        FOLLOWER_ID BIGSERIAL NOT NULL REFERENCES PUBLIC.USERS (ID),
        CREATED_AT TIMESTAMP DEFAULT NOW (),
        UPDATED_AT TIMESTAMP DEFAULT NOW ()
    );

CREATE INDEX POSTS_USER_ID_INDEX ON PUBLIC.POSTS (USER_ID); 

CREATE INDEX FOLLOWS_USER_ID_INDEX ON PUBLIC.FOLLOWS (USER_ID); 

CREATE INDEX FOLLOWS_FOLLOWER_ID_INDEX ON PUBLIC.FOLLOWS (FOLLOWER_ID);

CREATE UNIQUE INDEX FOLLOWS_USER_FOLLOWER ON PUBLIC.FOLLOWS (USER_ID, FOLLOWER_ID);

