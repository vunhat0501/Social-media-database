--
-- PostgreSQL database dump
--

\restrict oeovfC7IzFFXU8qtUnKSxjnWiI5M4xMsaZtKvRpRyKBOJDJ30DwdGs3yotCUDTf

-- Dumped from database version 18.3 (Debian 18.3-1.pgdg12+1)
-- Dumped by pg_dump version 18.3 (Debian 18.3-1.pgdg12+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE ONLY public.posts DROP CONSTRAINT "FK_c4f9a7bd77b489e711277ee5986";
ALTER TABLE ONLY public.follows DROP CONSTRAINT "FK_afe636fd5d9cf912133e7eb7aeb";
ALTER TABLE ONLY public.stories DROP CONSTRAINT "FK_ab4ee230faf536e7c5aee12f4ea";
ALTER TABLE ONLY public.auth DROP CONSTRAINT "FK_9922406dc7d70e20423aeffadf3";
ALTER TABLE ONLY public.saved_posts DROP CONSTRAINT "FK_78c961371a509e86d789714dd4f";
ALTER TABLE ONLY public.likes DROP CONSTRAINT "FK_741df9b9b72f328a6d6f63e79ff";
ALTER TABLE ONLY public.post_hashtags DROP CONSTRAINT "FK_6c16a0f366b0642259bbe50481c";
ALTER TABLE ONLY public.follows DROP CONSTRAINT "FK_56a285ecbf4f5f949ea2746f5f2";
ALTER TABLE ONLY public.comments DROP CONSTRAINT "FK_4c675567d2a58f0b07cef09c13d";
ALTER TABLE ONLY public.post_hashtags DROP CONSTRAINT "FK_41f5ee7a97e67023d7461fa8f43";
ALTER TABLE ONLY public.likes DROP CONSTRAINT "FK_3f519ed95f775c781a254089171";
ALTER TABLE ONLY public.comments DROP CONSTRAINT "FK_259bf9825d9d198608d1b46b0b5";
ALTER TABLE ONLY public.post_media DROP CONSTRAINT "FK_1eeb54a4fdfbe9db17899243cbe";
ALTER TABLE ONLY public.saved_posts DROP CONSTRAINT "FK_116e9df57f5221cc1a77c3d1cfe";
DROP INDEX public."IDX_b268ef13743e47999b36cb1470";
DROP INDEX public."IDX_7fedde18872deb14e4889361d7";
DROP INDEX public."IDX_741df9b9b72f328a6d6f63e79f";
DROP INDEX public."IDX_56a285ecbf4f5f949ea2746f5f";
DROP INDEX public."IDX_41f5ee7a97e67023d7461fa8f4";
DROP INDEX public."IDX_074a1f262efaca6aba16f7ed92";
ALTER TABLE ONLY public.auth DROP CONSTRAINT "UQ_c8a9c2d3b54261f286487e1cfb7";
ALTER TABLE ONLY public.users DROP CONSTRAINT "UQ_97672ac88f789774dd47f7c8be3";
ALTER TABLE ONLY public.hashtags DROP CONSTRAINT "UQ_7fedde18872deb14e4889361d7b";
ALTER TABLE ONLY public.auth DROP CONSTRAINT "UQ_30d7073cf23d5a90f50d4cdc204";
ALTER TABLE ONLY public.users DROP CONSTRAINT "UQ_074a1f262efaca6aba16f7ed920";
ALTER TABLE ONLY public.post_hashtags DROP CONSTRAINT "PK_c605e5a0c23a9e348ae87dde1ff";
ALTER TABLE ONLY public.stories DROP CONSTRAINT "PK_bb6f880b260ed96c452b32a39f0";
ALTER TABLE ONLY public.users DROP CONSTRAINT "PK_a3ffb1c0c8416b9fc6f907b7433";
ALTER TABLE ONLY public.hashtags DROP CONSTRAINT "PK_994c5bf9151587560db430018c5";
ALTER TABLE ONLY public.migrations DROP CONSTRAINT "PK_8c82d7f526340ab734260ea46be";
ALTER TABLE ONLY public.comments DROP CONSTRAINT "PK_8bf68bc960f2b69e818bdb90dcb";
ALTER TABLE ONLY public.saved_posts DROP CONSTRAINT "PK_837a562f71fec3009c9af77ee53";
ALTER TABLE ONLY public.auth DROP CONSTRAINT "PK_7e416cf6172bc5aec04244f6459";
ALTER TABLE ONLY public.likes DROP CONSTRAINT "PK_723da61de46f65bb3e3096750d2";
ALTER TABLE ONLY public.posts DROP CONSTRAINT "PK_2829ac61eff60fcec60d7274b9e";
ALTER TABLE ONLY public.follows DROP CONSTRAINT "PK_127ee66907c5f852d55d7bcda17";
ALTER TABLE ONLY public.post_media DROP CONSTRAINT "PK_049edb1ce7ab3d2a98009b171d0";
ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.stories ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.posts ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.post_media ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.migrations ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.hashtags ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.comments ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.auth ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE public.users_id_seq;
DROP TABLE public.users;
DROP SEQUENCE public.stories_id_seq;
DROP TABLE public.stories;
DROP TABLE public.saved_posts;
DROP SEQUENCE public.posts_id_seq;
DROP TABLE public.posts;
DROP SEQUENCE public.post_media_id_seq;
DROP TABLE public.post_media;
DROP TABLE public.post_hashtags;
DROP SEQUENCE public.migrations_id_seq;
DROP TABLE public.migrations;
DROP TABLE public.likes;
DROP SEQUENCE public.hashtags_id_seq;
DROP TABLE public.hashtags;
DROP TABLE public.follows;
DROP SEQUENCE public.comments_id_seq;
DROP TABLE public.comments;
DROP SEQUENCE public.auth_id_seq;
DROP TABLE public.auth;
DROP TYPE public.users_role_enum;
--
-- Name: users_role_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.users_role_enum AS ENUM (
    'admin',
    'user'
);


ALTER TYPE public.users_role_enum OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: auth; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth (
    id integer NOT NULL,
    hashed_password character varying,
    auth_provider character varying DEFAULT 'local'::character varying NOT NULL,
    auth_provider_id character varying,
    email_verified boolean DEFAULT false NOT NULL,
    refresh_token character varying,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    user_id integer
);


ALTER TABLE public.auth OWNER TO postgres;

--
-- Name: auth_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.auth_id_seq OWNER TO postgres;

--
-- Name: auth_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_id_seq OWNED BY public.auth.id;


--
-- Name: comments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comments (
    id integer NOT NULL,
    content text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    user_id integer,
    post_id integer
);


ALTER TABLE public.comments OWNER TO postgres;

--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.comments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.comments_id_seq OWNER TO postgres;

--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.comments_id_seq OWNED BY public.comments.id;


--
-- Name: follows; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.follows (
    following_user_id integer NOT NULL,
    followed_user_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.follows OWNER TO postgres;

--
-- Name: hashtags; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hashtags (
    id integer NOT NULL,
    name character varying NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.hashtags OWNER TO postgres;

--
-- Name: hashtags_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.hashtags_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.hashtags_id_seq OWNER TO postgres;

--
-- Name: hashtags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.hashtags_id_seq OWNED BY public.hashtags.id;


--
-- Name: likes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.likes (
    user_id integer NOT NULL,
    post_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.likes OWNER TO postgres;

--
-- Name: migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    "timestamp" bigint NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.migrations OWNER TO postgres;

--
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.migrations_id_seq OWNER TO postgres;

--
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- Name: post_hashtags; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.post_hashtags (
    post_id integer NOT NULL,
    hashtag_id integer NOT NULL
);


ALTER TABLE public.post_hashtags OWNER TO postgres;

--
-- Name: post_media; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.post_media (
    id integer NOT NULL,
    media_url character varying NOT NULL,
    media_type character varying DEFAULT 'image'::character varying NOT NULL,
    sequence_order integer DEFAULT 1 NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    post_id integer
);


ALTER TABLE public.post_media OWNER TO postgres;

--
-- Name: post_media_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.post_media_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.post_media_id_seq OWNER TO postgres;

--
-- Name: post_media_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.post_media_id_seq OWNED BY public.post_media.id;


--
-- Name: posts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.posts (
    id integer NOT NULL,
    title text,
    status character varying DEFAULT 'public'::character varying NOT NULL,
    location text,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    user_id integer
);


ALTER TABLE public.posts OWNER TO postgres;

--
-- Name: posts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.posts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.posts_id_seq OWNER TO postgres;

--
-- Name: posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.posts_id_seq OWNED BY public.posts.id;


--
-- Name: saved_posts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.saved_posts (
    user_id integer NOT NULL,
    post_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.saved_posts OWNER TO postgres;

--
-- Name: stories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stories (
    id integer NOT NULL,
    media_url character varying NOT NULL,
    expires_at timestamp without time zone NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    user_id integer
);


ALTER TABLE public.stories OWNER TO postgres;

--
-- Name: stories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.stories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.stories_id_seq OWNER TO postgres;

--
-- Name: stories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.stories_id_seq OWNED BY public.stories.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    user_name character varying NOT NULL,
    email character varying NOT NULL,
    role public.users_role_enum DEFAULT 'user'::public.users_role_enum NOT NULL,
    avatar_url character varying,
    bio character varying,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: auth id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth ALTER COLUMN id SET DEFAULT nextval('public.auth_id_seq'::regclass);


--
-- Name: comments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments ALTER COLUMN id SET DEFAULT nextval('public.comments_id_seq'::regclass);


--
-- Name: hashtags id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hashtags ALTER COLUMN id SET DEFAULT nextval('public.hashtags_id_seq'::regclass);


--
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- Name: post_media id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_media ALTER COLUMN id SET DEFAULT nextval('public.post_media_id_seq'::regclass);


--
-- Name: posts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.posts ALTER COLUMN id SET DEFAULT nextval('public.posts_id_seq'::regclass);


--
-- Name: stories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stories ALTER COLUMN id SET DEFAULT nextval('public.stories_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: auth; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth (id, hashed_password, auth_provider, auth_provider_id, email_verified, refresh_token, created_at, user_id) FROM stdin;
\.


--
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.comments (id, content, created_at, user_id, post_id) FROM stdin;
\.


--
-- Data for Name: follows; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.follows (following_user_id, followed_user_id, created_at) FROM stdin;
\.


--
-- Data for Name: hashtags; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.hashtags (id, name, created_at) FROM stdin;
\.


--
-- Data for Name: likes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.likes (user_id, post_id, created_at) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.migrations (id, "timestamp", name) FROM stdin;
1	1775741091591	InitSchema1775741091591
\.


--
-- Data for Name: post_hashtags; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.post_hashtags (post_id, hashtag_id) FROM stdin;
\.


--
-- Data for Name: post_media; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.post_media (id, media_url, media_type, sequence_order, created_at, post_id) FROM stdin;
\.


--
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.posts (id, title, status, location, created_at, user_id) FROM stdin;
\.


--
-- Data for Name: saved_posts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.saved_posts (user_id, post_id, created_at) FROM stdin;
\.


--
-- Data for Name: stories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.stories (id, media_url, expires_at, created_at, user_id) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, user_name, email, role, avatar_url, bio, created_at) FROM stdin;
\.


--
-- Name: auth_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_id_seq', 1, false);


--
-- Name: comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.comments_id_seq', 1, false);


--
-- Name: hashtags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.hashtags_id_seq', 1, false);


--
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.migrations_id_seq', 1, true);


--
-- Name: post_media_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.post_media_id_seq', 1, false);


--
-- Name: posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.posts_id_seq', 1, false);


--
-- Name: stories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.stories_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 1, false);


--
-- Name: post_media PK_049edb1ce7ab3d2a98009b171d0; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_media
    ADD CONSTRAINT "PK_049edb1ce7ab3d2a98009b171d0" PRIMARY KEY (id);


--
-- Name: follows PK_127ee66907c5f852d55d7bcda17; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.follows
    ADD CONSTRAINT "PK_127ee66907c5f852d55d7bcda17" PRIMARY KEY (following_user_id, followed_user_id);


--
-- Name: posts PK_2829ac61eff60fcec60d7274b9e; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT "PK_2829ac61eff60fcec60d7274b9e" PRIMARY KEY (id);


--
-- Name: likes PK_723da61de46f65bb3e3096750d2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.likes
    ADD CONSTRAINT "PK_723da61de46f65bb3e3096750d2" PRIMARY KEY (user_id, post_id);


--
-- Name: auth PK_7e416cf6172bc5aec04244f6459; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth
    ADD CONSTRAINT "PK_7e416cf6172bc5aec04244f6459" PRIMARY KEY (id);


--
-- Name: saved_posts PK_837a562f71fec3009c9af77ee53; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.saved_posts
    ADD CONSTRAINT "PK_837a562f71fec3009c9af77ee53" PRIMARY KEY (user_id, post_id);


--
-- Name: comments PK_8bf68bc960f2b69e818bdb90dcb; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT "PK_8bf68bc960f2b69e818bdb90dcb" PRIMARY KEY (id);


--
-- Name: migrations PK_8c82d7f526340ab734260ea46be; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT "PK_8c82d7f526340ab734260ea46be" PRIMARY KEY (id);


--
-- Name: hashtags PK_994c5bf9151587560db430018c5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hashtags
    ADD CONSTRAINT "PK_994c5bf9151587560db430018c5" PRIMARY KEY (id);


--
-- Name: users PK_a3ffb1c0c8416b9fc6f907b7433; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT "PK_a3ffb1c0c8416b9fc6f907b7433" PRIMARY KEY (id);


--
-- Name: stories PK_bb6f880b260ed96c452b32a39f0; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stories
    ADD CONSTRAINT "PK_bb6f880b260ed96c452b32a39f0" PRIMARY KEY (id);


--
-- Name: post_hashtags PK_c605e5a0c23a9e348ae87dde1ff; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_hashtags
    ADD CONSTRAINT "PK_c605e5a0c23a9e348ae87dde1ff" PRIMARY KEY (post_id, hashtag_id);


--
-- Name: users UQ_074a1f262efaca6aba16f7ed920; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT "UQ_074a1f262efaca6aba16f7ed920" UNIQUE (user_name);


--
-- Name: auth UQ_30d7073cf23d5a90f50d4cdc204; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth
    ADD CONSTRAINT "UQ_30d7073cf23d5a90f50d4cdc204" UNIQUE (user_id, auth_provider);


--
-- Name: hashtags UQ_7fedde18872deb14e4889361d7b; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hashtags
    ADD CONSTRAINT "UQ_7fedde18872deb14e4889361d7b" UNIQUE (name);


--
-- Name: users UQ_97672ac88f789774dd47f7c8be3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT "UQ_97672ac88f789774dd47f7c8be3" UNIQUE (email);


--
-- Name: auth UQ_c8a9c2d3b54261f286487e1cfb7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth
    ADD CONSTRAINT "UQ_c8a9c2d3b54261f286487e1cfb7" UNIQUE (auth_provider, auth_provider_id);


--
-- Name: IDX_074a1f262efaca6aba16f7ed92; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_074a1f262efaca6aba16f7ed92" ON public.users USING btree (user_name);


--
-- Name: IDX_41f5ee7a97e67023d7461fa8f4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_41f5ee7a97e67023d7461fa8f4" ON public.post_hashtags USING btree (hashtag_id);


--
-- Name: IDX_56a285ecbf4f5f949ea2746f5f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_56a285ecbf4f5f949ea2746f5f" ON public.follows USING btree (followed_user_id);


--
-- Name: IDX_741df9b9b72f328a6d6f63e79f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_741df9b9b72f328a6d6f63e79f" ON public.likes USING btree (post_id);


--
-- Name: IDX_7fedde18872deb14e4889361d7; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_7fedde18872deb14e4889361d7" ON public.hashtags USING btree (name);


--
-- Name: IDX_b268ef13743e47999b36cb1470; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_b268ef13743e47999b36cb1470" ON public.stories USING btree (expires_at);


--
-- Name: saved_posts FK_116e9df57f5221cc1a77c3d1cfe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.saved_posts
    ADD CONSTRAINT "FK_116e9df57f5221cc1a77c3d1cfe" FOREIGN KEY (post_id) REFERENCES public.posts(id) ON DELETE CASCADE;


--
-- Name: post_media FK_1eeb54a4fdfbe9db17899243cbe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_media
    ADD CONSTRAINT "FK_1eeb54a4fdfbe9db17899243cbe" FOREIGN KEY (post_id) REFERENCES public.posts(id) ON DELETE CASCADE;


--
-- Name: comments FK_259bf9825d9d198608d1b46b0b5; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT "FK_259bf9825d9d198608d1b46b0b5" FOREIGN KEY (post_id) REFERENCES public.posts(id) ON DELETE CASCADE;


--
-- Name: likes FK_3f519ed95f775c781a254089171; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.likes
    ADD CONSTRAINT "FK_3f519ed95f775c781a254089171" FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: post_hashtags FK_41f5ee7a97e67023d7461fa8f43; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_hashtags
    ADD CONSTRAINT "FK_41f5ee7a97e67023d7461fa8f43" FOREIGN KEY (hashtag_id) REFERENCES public.hashtags(id) ON DELETE CASCADE;


--
-- Name: comments FK_4c675567d2a58f0b07cef09c13d; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT "FK_4c675567d2a58f0b07cef09c13d" FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: follows FK_56a285ecbf4f5f949ea2746f5f2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.follows
    ADD CONSTRAINT "FK_56a285ecbf4f5f949ea2746f5f2" FOREIGN KEY (followed_user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: post_hashtags FK_6c16a0f366b0642259bbe50481c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_hashtags
    ADD CONSTRAINT "FK_6c16a0f366b0642259bbe50481c" FOREIGN KEY (post_id) REFERENCES public.posts(id) ON DELETE CASCADE;


--
-- Name: likes FK_741df9b9b72f328a6d6f63e79ff; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.likes
    ADD CONSTRAINT "FK_741df9b9b72f328a6d6f63e79ff" FOREIGN KEY (post_id) REFERENCES public.posts(id) ON DELETE CASCADE;


--
-- Name: saved_posts FK_78c961371a509e86d789714dd4f; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.saved_posts
    ADD CONSTRAINT "FK_78c961371a509e86d789714dd4f" FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: auth FK_9922406dc7d70e20423aeffadf3; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth
    ADD CONSTRAINT "FK_9922406dc7d70e20423aeffadf3" FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: stories FK_ab4ee230faf536e7c5aee12f4ea; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stories
    ADD CONSTRAINT "FK_ab4ee230faf536e7c5aee12f4ea" FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: follows FK_afe636fd5d9cf912133e7eb7aeb; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.follows
    ADD CONSTRAINT "FK_afe636fd5d9cf912133e7eb7aeb" FOREIGN KEY (following_user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: posts FK_c4f9a7bd77b489e711277ee5986; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT "FK_c4f9a7bd77b489e711277ee5986" FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict oeovfC7IzFFXU8qtUnKSxjnWiI5M4xMsaZtKvRpRyKBOJDJ30DwdGs3yotCUDTf

