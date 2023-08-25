create extension if not EXISTS citext;

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
        USER_ID bigint references public.users (id),
        content text,
        CREATED_AT TIMESTAMP DEFAULT NOW (),
        UPDATED_AT TIMESTAMP DEFAULT NOW ()
    );

CREATE TABLE 
 IF NOT EXISTS PUBLIC.follows (
        USER_ID BIGSERIAL not null references public.users (id),
        follower_ID BIGSERIAL not null references public.users (id),
        CREATED_AT TIMESTAMP DEFAULT NOW (),
        UPDATED_AT TIMESTAMP DEFAULT NOW ()
    );

create index posts_user_id_index on public.posts (user_id); 

create index follows_user_id_index on public.follows (user_id); 

create index follows_follower_id_index on public.follows (follower_id);



