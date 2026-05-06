--
-- PostgreSQL database dump
--

\restrict 9XVus50TrDxXKC0WLHw8ODFaMmT3HevQs9vb2YEhivzEunSadb5zimuJXCEVt3m

-- Dumped from database version 18.3
-- Dumped by pg_dump version 18.3

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
DROP INDEX public.idx_user_stories_active;
DROP INDEX public.idx_user_saved_sort;
DROP INDEX public.idx_user_post_timeline;
DROP INDEX public.idx_post_media_sequence;
DROP INDEX public.idx_post_comments_sort;
DROP INDEX public.idx_active_users_username;
DROP INDEX public."IDX_c4f9a7bd77b489e711277ee598";
DROP INDEX public."IDX_9922406dc7d70e20423aeffadf";
DROP INDEX public."IDX_97672ac88f789774dd47f7c8be";
DROP INDEX public."IDX_7fedde18872deb14e4889361d7";
DROP INDEX public."IDX_741df9b9b72f328a6d6f63e79f";
DROP INDEX public."IDX_56a285ecbf4f5f949ea2746f5f";
DROP INDEX public."IDX_4c675567d2a58f0b07cef09c13";
DROP INDEX public."IDX_41f5ee7a97e67023d7461fa8f4";
DROP INDEX public."IDX_116e9df57f5221cc1a77c3d1cf";
DROP INDEX public."IDX_0f735e8be0f9f8502dfa704f1c";
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
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone
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
1	4InW6GNwNH_A8BL3bUWi	google	ER9KBAX9tH84NO6mgtRE	f	eYu8Irqq05F9GQCrvHub	2026-04-29 13:32:23.251391	1
2	jWy6Xz31trnctE28kZ_S	apple	Wr8HLQvSeZ9FMyBTuzKU	t	JDhEyZdAL6ExCwrxq2Lk	2026-04-29 13:32:23.259596	7
3	tUN3VJ5X_Bh6HIbXh2lX	apple	ZgYblva0LWsMniT4YFrS	f	tMbx8KNlCMhSBUruMNkT	2026-04-29 13:32:23.263794	10
4	heXkJAdFeXHlu9_Ob6dv	apple	u3o6Th02QqOAMyY6pgaR	t	7DSQMbswfrBvkx1Nq8oP	2026-04-29 13:32:23.267805	6
5	6ChRIiZbDY1DXfS5BoWh	apple	CRamrevMUmxLI3Fd6kJd	t	o4NatAWYAAgwALMMX2UD	2026-04-29 13:32:23.272342	4
6	9aZ11Y9tqc5OlTv5QLm0	google	y62pybIu1rNgQYJ4m7R0	f	WKb3Fl65O9KACAeJLPK2	2026-04-29 13:32:23.277344	5
7	iGa9ibv5DuBJUnXnI7bW	local	bznx27OxJLKfN8KM7zNE	t	l3ts7v8BQL9BCorMNCY4	2026-04-29 13:32:23.281617	9
8	DDGrIEN7Cwz0rWc31T7R	local	aX08bNIjGzCF7gwN0IK0	f	q3HIdCRobqFsrs72rYOj	2026-04-29 13:32:23.286262	3
9	dci0hqtIbiDWPWvh2zL9	apple	zZ9WRPe6NCGZThrIBqLD	f	tbRmkzCwZRl8Y4CEmdCv	2026-04-29 13:32:23.295403	36
10	PCGc5SO8QKBUr71H1p4u	apple	1lIwnladHQ4KvFIFH5T2	f	qz7RdlEyuP4Spxo8iJda	2026-04-29 13:32:23.297841	38
11	8QkZjTjG9aotf3XlOBgg	local	mjLZNIq17tyt9rMhkeHd	f	y3uMmhZHDFPozbCYI37M	2026-04-29 13:32:23.300963	2
12	jVGsLXkzC0xVT1nDsOmF	google	Qmsfy7Lgi6t4ICRhmqja	t	7eXM7V7xvfaRsiVhitkb	2026-04-29 13:32:23.304452	8
13	ySwxx5tlUjKQffnnKOuR	local	DiTogI4jAIfj2Kyn9WON	f	uLmdJyB6q4PwRgflDrh6	2026-04-29 13:32:23.308909	11
14	CKeWBP7uBvkjEeM9Qmxn	local	Om1VNA0wakcGEdcL1YLS	f	YNGwqSzW3HqavUBriZpQ	2026-04-29 13:32:23.314467	12
15	2fqsZOIgPbmRMhTF9t5s	apple	ZC3hJXDT5yqF4hHzhRQ0	t	PBpNQCGEUz0d6cVnZNvA	2026-04-29 13:32:23.31924	13
16	GfmZtvXwOAvMPGXscltS	apple	bR7Tmpe89Ie6FN9pANzK	t	i0EJCZzfF7bJQiD4lWfT	2026-04-29 13:32:23.325827	14
17	YOnebla7ujTVzINdcvkV	apple	rFUxtQj0cyP2N1WhWnzp	t	A4KVDKikAHh25gciusXT	2026-04-29 13:32:23.328791	15
18	A1b7j62_GfDkHt2oweOL	google	GPGt5PIOUMJE70yHHSn1	t	3zKwY2fFUCX6YVcNEv5y	2026-04-29 13:32:23.331163	16
19	n_DgklLGxTtAIOd7Rmzd	google	IISHgZs0r05VPEEG0OEE	t	JyEg8LLBXHyQdVvCrxuJ	2026-04-29 13:32:23.336627	17
20	Q0w_yH3SrocEpFa2xUfi	local	d7inQ3WmY9VDDFwiX0b4	f	Neb2Drw55tasM7wTVOa9	2026-04-29 13:32:23.341154	18
21	08J2NW5zODRajz6PLE4h	apple	8xJTbMwyCoU9OkXoqty8	t	GHV9WxpYq6xy0nONuv9m	2026-04-29 13:32:23.343793	19
22	r2_tC9jpSCKxFIBR2wwI	local	9KQvX2NpfTMPxjQ5qzVN	f	316xlHvpYZ9PSIiLpm4G	2026-04-29 13:32:23.346007	20
23	adidEAsVylSsOm1Fc3nZ	apple	lEc0lMEZupH6m8V7PDws	t	HVpJXrTWK9DuQfSolDLK	2026-04-29 13:32:23.348015	21
24	Qe4RTqraLXQnbn0tn0aR	local	EVg5IBsmZMZbDOpzZdfL	f	rs8VdlUuALd1FF98CPj6	2026-04-29 13:32:23.352621	22
25	rjMsulzlzynWTS9f0CRj	apple	EP0A27NvNd9g3Qt5KxSS	f	resEZqosvXZaOLfA02UE	2026-04-29 13:32:23.356082	23
26	T9DYTr1P1blgnWA1kltd	google	BzDvjt4SBHFzVZ0nCRiR	t	iFNmZpeVRZ51FkqLPanF	2026-04-29 13:32:23.363795	26
27	JXSqEtdfNXH9ZuV51Ewe	apple	NHu9PX3C1qGmXJI68EkV	f	YOl71kzwl0kdRqxnLW8p	2026-04-29 13:32:23.369375	24
28	QRm0ubyZs2EWkn3zDsTU	google	jweLBgoOK1TUhKQC3Jqm	t	oE113xhm2mch4EOrqifk	2026-04-29 13:32:23.371713	25
29	m8Ld1Y9gbmihElvduSk2	apple	YAjPHQVMjKihdfuRPiae	t	TIUGSVc5UAkAzNrwtIjz	2026-04-29 13:32:23.374087	27
30	v_k6tf7zFlP3ON97KTxA	google	6SiCAeHGU7eoVX1WsBWS	f	N4Ry5S6uSdvzujdYECkX	2026-04-29 13:32:23.376435	28
31	iNuyCPpYLpqz0LEsUkih	local	L6rgaFmSPol3hGg35aWE	t	1Yi2zhAvx2doHrCv1bQy	2026-04-29 13:32:23.381596	29
32	xIeUAoEKk26FXasF6bcV	google	33SaSM0APzLIr24uzqS3	t	cXjt1d2wnoRa5pJCs4Ks	2026-04-29 13:32:23.385876	30
33	hYTBkmqktRclKCHDRlI1	google	ZHUt8UgjwST23pRCp9fp	f	DNXuJ8WOgI0pDTsqsHwH	2026-04-29 13:32:23.389894	31
34	NsgRClXqnJbi6NYidQm3	local	Zj2ACEm9HwcNmMe48w1j	f	sAVaKp0qZ1uimF2lCBQI	2026-04-29 13:32:23.394102	32
35	ZjxvBGjmfIQnXhyAHULe	local	MFYq8SSNSuY2SnUNS4qZ	t	z6EIZFKXIJdhFUAD7pu9	2026-04-29 13:32:23.397654	33
36	MZVuhYEGxwSol_vspDa5	local	l8dckj1o7j2R7u8PqS1s	t	TQggLxW5h1k057pCHr9A	2026-04-29 13:32:23.404643	34
37	k6Mz98ZTscWz3suj3tzt	apple	Yh5tXstdiM9JypV8zSjY	f	NMzgssn8MabGB4xVZ43J	2026-04-29 13:32:23.407754	35
38	MUNdDgCgURUWmqxovVFn	apple	YINSwIUhJ37PKTWTQF77	f	NtHxNU1FOJVgyvjCDdiF	2026-04-29 13:32:23.41125	37
39	MeXg0AgCjebKACmFcuTx	local	5TzmskCd7tMvTVZUcpNx	t	oiV4MPp5gwt7S2L5LXE5	2026-04-29 13:32:23.414877	39
40	_O6G9FseL6ucEikCYn6s	local	H2UDwL6Yk5DnfvYt785o	f	6ct6Uh85kcqHYtNPwr4B	2026-04-29 13:32:23.417805	40
41	oeXQPT2cYRDMUuY_dMV9	google	WkkrXbkQvMbGLxZwJjZj	f	2XgKYrYoRoEWDiISK4j5	2026-04-29 13:32:23.420468	41
42	IdagOD6Cs9Yh59p8nfYd	apple	7j3jQ6WNF8fk9wt6NoEo	t	3TnfvyoUcOeKDyZGeRcA	2026-04-29 13:32:23.427589	42
43	WZU_Mw0cBhEGdw7s9sHN	google	BRHWuZnh8ZUvw783qFrU	t	VopPnWIGSMD7Tcx2MCiq	2026-04-29 13:32:23.430968	43
44	pIo2N7ZDV2uDOLrvlXK_	local	9T0dT74OGFDwzziIta3q	t	Xj0f2li950LLpqcO1WUZ	2026-04-29 13:32:23.43443	44
45	MotfFQeldwmDnvmbZhK9	apple	afvU7Yl5OeywjRyG1pJh	f	kl2cC2qs5RIjPAoMw3bt	2026-04-29 13:32:23.437695	45
46	aq2F7D_bKyieYSG7NxvY	local	piCuljNwnFcS996xy9ti	t	AodVhBhyrhwUf2Rjdgiu	2026-04-29 13:32:23.445	46
47	khq0ozIeHO1qSBEfu7si	apple	zxdKbxoNoA10lHqFyIGS	f	ftJXYrJCCTZuXyqDUVeS	2026-04-29 13:32:23.448374	47
48	kCpbnxGdP3_zHu_EpZ_s	local	lxsTZYkSFrBZAuvF23A1	t	ytkg696RxymJCbGHopdq	2026-04-29 13:32:23.451267	48
49	spg2E0zkLcIzJ2WEAB6l	local	OJIrI7ucjff7R0A5WV5W	f	wKmIZ98BDlkcOHblzhEZ	2026-04-29 13:32:23.45814	49
50	ZsEbd4VNw_fCfhCdOG05	google	8ktYul0vNbi8E3uZvQal	f	JGRNojrUrjT3xGqexZLe	2026-04-29 13:32:23.465861	50
51	GV2OHwpGRF6X3WSncBT7	google	Q3ILy52X307PRYpwrWMq	t	GecSWSOOvYZswrrl7uDp	2026-04-29 13:32:23.469838	51
52	pC6gsWH1K16TwnlfbzB_	google	rwRr9lcGOhSXiTec5dsS	f	7ATT7pbLAXwAux19WBMN	2026-04-29 13:32:23.473799	52
53	kUjmHUUce3kiIw9J5TXN	google	9Mtpjk4C0GW9ZNMsCcsN	f	qWIB8AqED1JT3X717nr6	2026-04-29 13:32:23.477748	53
54	qFvfE0MH_LkVxlHzrCuU	google	NIG1BUkZWH5u0zTAjbgt	f	tcwZZgCWZwnIbUYT3b4g	2026-04-29 13:32:23.481698	54
55	2L77EOrnr2sGbYnwJzrh	apple	ASt9IrISPWNzWkQgtKf3	f	bAL4MppmnVEFXbUIUWTS	2026-04-29 13:32:23.485466	55
56	56M63bTO5S3iRCAnd_GP	apple	WiFDvEbT7P8qeSQjpaZX	t	74c92l0FsD3dwOWHQcwP	2026-04-29 13:32:23.492651	56
57	TTph_VMlYN95Iopl8YKo	google	EzkjQc2uOWxSCjIdxoEp	t	DYZv2DbdtMHnRES8eFhq	2026-04-29 13:32:23.499053	58
58	X6Yus0Pnh6Q5a5yO3ubK	apple	gmWHvqsXTXRdIVMX8cDj	t	MBC5Ihrd6TYDqFdKuh1c	2026-04-29 13:32:23.50218	57
59	RTX9UHbw4cqi_rpLq5Kw	apple	BI9OcIxILUs2UXhHMqZr	f	A4ptltfxt7CmscmXAc3E	2026-04-29 13:32:23.508788	59
60	HN08CKaXpGT4zWHXJPBB	apple	640jqeHdc6zUTTKORmR8	t	2TcqcOJtzOynkcllPjZC	2026-04-29 13:32:23.512307	60
61	Egwu0wRhtdKUEdd9cKuo	local	87elXvtgursv8VoPLPnM	f	pKm66Ilkshu37is9Z1cf	2026-04-29 13:32:23.51898	61
62	FiGHuheId9Ck5X0_IOI6	local	1yjUnw01trTodRBzpeEc	t	jSiSFBDhfswWMXQdrmmG	2026-04-29 13:32:23.521879	62
63	cYsHd2bS643rUC9fCTJu	local	6hv9h2xab2FhvatcPkIF	t	CpMJNu36SJcJ7ePeMuEQ	2026-04-29 13:32:23.525739	63
64	4iNgUYI1eNf4mdPpCtOE	apple	cKY5vPciWQEJ1s02QmNU	t	GHTssd8KP9NDgvOV5jNK	2026-04-29 13:32:23.531777	64
65	8eIDZCWHCwmB2dHlQ9FH	apple	tOJXCsmmCDqCtrc2FYOc	t	CCTRIoXmmyy2FRcQVTNG	2026-04-29 13:32:23.534506	65
66	KEwr6msptLmZMAq1X91D	local	GJC0YzoHVBM8G0OCDJ5q	t	5HeMgRK8hT05lrxdTYNw	2026-04-29 13:32:23.53728	66
67	moCDcikaDK3MSelUHEgO	local	J9VYXpt94DptuE6gx30C	f	6qchTAi7AVMbGkWkbUdA	2026-04-29 13:32:23.539594	67
68	EKuf78s6ktR0ROIHePkO	local	augsION697i7KLTF5t14	t	9H4GxpeO38MYTChYedOF	2026-04-29 13:32:23.555324	68
69	59igoBwBdwNf8KZvon4s	google	vjgqUZPP2jdBAQDQF95u	t	4sYDbmtlD3Q8s4X4h5LZ	2026-04-29 13:32:23.561867	69
70	o9mXgw3NkCV10ZmxPS9I	local	VqEzxQrPJh3xhqzbL5Az	t	TmIwZiRoR9JpMFMEmCgP	2026-04-29 13:32:23.567341	70
71	TGhDyrZWOIbMx8DmqULG	local	rYfc3QMInrberHp541p9	f	vtZRzSrEeHDmpJM7s7VS	2026-04-29 13:32:23.572267	71
72	OKCez4ucaTi_7KU2D5Dd	local	rRE6WMGOwA1kh5IZ6lxu	t	TQ4eTKumPygO2ySlVyht	2026-04-29 13:32:23.577405	72
73	ThljN5pNDt7DhAoq8uCE	google	OctNfe873IqVAN3mn0SA	f	W7pALUswd3mWtUURxdxe	2026-04-29 13:32:23.585541	73
74	egYwwKTZnCLZV2OgXqVb	apple	TBoruIMYiDO9bcz0gkuK	f	9OGtJxI4HvVnMa7xKOPX	2026-04-29 13:32:23.589282	74
75	qHq4i9pODUda9dMOsgCR	local	CC1Bop06nEUoFeOaiZ5l	t	iyK0wxQtJMy5OppPU679	2026-04-29 13:32:23.596814	75
76	SL8kaTrg6Pz9ZtGlQc8N	local	h6y1PP9MGNn4RIyhm0i7	f	qSIsjdwasIblBWRdIPGA	2026-04-29 13:32:23.603719	76
77	vDgNSxUTCCZbmSijuian	google	5u9SjR55rT4xyiCuP8uk	t	n5rihkvbiV3rpVeVnZUp	2026-04-29 13:32:23.610877	77
78	Sd9o1yKch5_SwoAtQikN	local	oo0LNSkhjd216H4C7L5w	f	Y75jKZkeRoBANnBbQq4v	2026-04-29 13:32:23.614462	78
79	8N80d1HL8IfPEcvsPbrN	local	kr1Zvk0FfPVqePfeLM5V	f	vJCDeV9JA1MK71YcToQJ	2026-04-29 13:32:23.618022	79
80	FE0OJzj_JYeRcBPECSQw	apple	vxwaBTsg1yOz5vLv9tUN	f	qlnSnoeR6m8rsqeIUvNX	2026-04-29 13:32:23.621631	80
81	dVbUpMWz5cmpw0ZBm3JL	local	UBFIS76QQGtfRpKa6RQ6	t	IM2XCk7gaMwrnl925bu2	2026-04-29 13:32:23.628948	81
82	iAWWqnevDVzxF8RlOc1p	apple	ZU6OkkkBTaceihl7wpZs	t	d1rWTrC8Va8u0kJ5n17B	2026-04-29 13:32:23.632752	82
83	kp6CSCwu4BbRkwYu1Nya	apple	LJBvHJJmsKTNxtNXQA6X	f	Bs0xTLjRhgIpYBGjuJF5	2026-04-29 13:32:23.636511	83
84	rFbSdiBE2MBTABlUwFwy	apple	tCTJ4Ah6jGirN6hDPTzS	f	NNCrIw5YHzMJmvvHkvbe	2026-04-29 13:32:23.644778	84
85	JSC4eRqMVu66NqDFf4I3	apple	Oak6jffCxDh4xtyqcg7e	t	gcxmHcK7R88o05mwWMT1	2026-04-29 13:32:23.650186	85
86	xwhpeerHd3hTDHQlf1e4	apple	sROAc5WtHMVwtN6CLJY8	t	BmfDnUo7Hlr5zUipVrTU	2026-04-29 13:32:23.654815	86
87	t7VX7q6ZmdYEEXshqbd1	google	efqIt1nu8LlGZ3wB54uY	f	F8AGB8zd1Mduf6b2UGHq	2026-04-29 13:32:23.660248	87
88	BbTwtqoFTVslvNtugPdz	local	RUNQYBqDVUENX96BnuQL	t	9Ysubj2uOED5gmUsdgOE	2026-04-29 13:32:23.666918	88
89	35NBvSXcXgmXAGkUcsmG	local	lEXjE8aWrTDQRuO2Pp6K	f	7kvezkdWCP3wfRIMksvN	2026-04-29 13:32:23.670044	89
90	HZcNjxjlBjdBA6rjSq5z	google	mst397VApxLiFn71rjM5	f	A0JN6e3YBKBhPfgVIlQ1	2026-04-29 13:32:23.675472	90
91	OtWjlQFx146QQgRQqmUf	local	ekJ9kg90ZxnnPHGoYsJs	f	PD0r7I7Hmuq2yo5zwDlj	2026-04-29 13:32:23.67881	91
92	NoJEgH02CInII79NLedj	google	hg1kvvkuTKibr44TgTNb	t	0uGmSDoZldY9lOiZ6lif	2026-04-29 13:32:23.684626	92
93	NcOjV1UtOZsuGEq1mFvj	google	d54ecV5WTQ7XCZ7WUqYK	t	lshhyWdUbvEwi6jyIkUh	2026-04-29 13:32:23.688127	93
94	SA8f3VNb6O9Q4V4Y_i5o	google	JrmCEwjTtgTyFhBnX827	f	cbsXRTYA4Aq51pHFEeyX	2026-04-29 13:32:23.69131	94
95	_9c5uPKveIedOdHyIsCw	apple	p5AGHiMaIumrV2dSVZ0d	f	B0O5Wc257GquoeFN4aD3	2026-04-29 13:32:23.695101	95
96	d4CGMBgFoTaK8q_JzbcH	google	8Tye7PL0dEvUp1rz81Ry	t	gDCcGEMLrTRf2RvKXMQe	2026-04-29 13:32:23.698131	96
97	qEU8lVIVzQAYr09fObLS	google	6nLOb2Cq9dyC18exrceK	t	EIHEMjqlVFtMAa0BnikZ	2026-04-29 13:32:23.701497	97
98	YQo4MrKjQoSYlCtb0MHY	local	GjFEGFIgoYms5w23snOD	f	Vd1JXcVcpnjBZnx0g0Eo	2026-04-29 13:32:23.704748	98
99	KGb04bp6E4vJVh_tf4Q3	google	fERacrsu8SEh9hyww13d	f	S33cUMJ2MDaSFyfhEWh6	2026-04-29 13:32:23.707267	99
100	fzm6DVvbLfhkuwQiHtq8	local	SjGIve1XDNNKqG16cmgi	f	Jlm9zWiCcEkXOdz8wo2q	2026-04-29 13:32:23.71038	100
104	$argon2id$v=19$m=65536,t=3,p=4$enp0bsYsTdYRxvAIHlV3/Q$oRRafoo7bqcSSScWSlojCK2puUyUIKcEwAn/SC2iCP0	local	\N	f	$argon2id$v=19$m=65536,t=3,p=4$5RwIY6Kaj7fewQPflI5CPg$9iTCPD5SV3nW6e59+16c9gQ464v6pOxtaGWMWWsJfQk	2026-04-30 07:10:49.279365	105
\.


--
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.comments (id, content, created_at, user_id, post_id) FROM stdin;
1	Vicinus praesentium amplitudo armarium cruentus bardus curia calco dolorum.\nAntepono coerceo stips calculus allatus aestas tabula.\nDeripio bellum absconditus.\nTristis copiose constans approbo magnam crustulum somnus acerbitas conturbo.	2026-04-29 13:32:24.697387	98	1
2	Crastinus tui suffoco admoveo auditor tempus.	2026-04-29 13:32:24.702141	70	1
3	Love this so much	2026-04-29 13:32:24.70656	63	1
4	Where is this?!	2026-04-29 13:32:24.744027	59	2
5	Love this so much	2026-04-29 13:32:24.747716	46	2
6	Catena appono caput amor tardus clementia vomer advoco.	2026-04-29 13:32:24.750231	2	2
7	Assumenda ustilo tempora.	2026-04-29 13:32:24.753764	75	2
8	Crebro aestus eveniet depulso tonsor.	2026-04-29 13:32:24.757546	58	2
9	This is amazing!	2026-04-29 13:32:24.803143	10	3
10	Baiulus ullam odit error eos. Trepide bonus viriliter defaeco vulticulus bibo. Conqueror atrocitas cibo consequatur culpa suggero coniuratio aperio animus.	2026-04-29 13:32:24.80689	60	3
11	Talus aduro trucido defungo deripio. Cras certe combibo. Suppellex demoror laborum.	2026-04-29 13:32:24.809618	38	3
12	Love this so much	2026-04-29 13:32:24.859749	46	4
13	Love this so much	2026-04-29 13:32:24.863196	88	4
14	Where is this?!	2026-04-29 13:32:24.932346	13	5
15	Alioqui argentum conventus coaegresco caute. Dedico spero aveho quas temperantia thorax. Depraedor aeger utique alveus aufero creo perspiciatis depopulo arceo corroboro.	2026-04-29 13:32:24.935909	49	5
16	This is amazing!	2026-04-29 13:32:24.940879	48	5
17	This is amazing!	2026-04-29 13:32:24.944467	70	5
18	Quae amo eum defleo tristis cubicularis quam decipio pecco distinctio. Curvo delectatio coaegresco timor accusator audax animus suppono vinco. Calco eligendi vester cohaero conicio ambulo vinco trucido.	2026-04-29 13:32:24.947021	60	5
19	Cometes fugiat libero conservo complectus magnam deripio damno. Conor deprimo compello vapulus tam. Bis auctor demo carbo aspicio appono thermae colo curriculum.	2026-04-29 13:32:24.968025	11	6
20	Suspendo centum vorago depono acidus. Veritas delectatio valeo. Optio adstringo caste thesis delectus voluptatem.	2026-04-29 13:32:24.970402	22	6
21	Appositus nesciunt angelus cunctatio despecto credo casus talio vicissitudo at.	2026-04-29 13:32:24.972795	14	6
22	Unus suffragium custodia creta incidunt aspernatur cubo conscendo verbera succedo.	2026-04-29 13:32:24.97554	48	6
23	This is amazing!	2026-04-29 13:32:25.030643	30	7
24	Sum sponte accusantium adficio abduco adsum carcer sono.	2026-04-29 13:32:25.033754	18	7
25	Vicinus valeo balbus.	2026-04-29 13:32:25.036872	43	7
26	Where is this?!	2026-04-29 13:32:25.079319	95	8
27	Decimus atque accedo. Venio succurro charisma voluptatum dignissimos venia abscido. Animi acervus conatus.	2026-04-29 13:32:25.081909	66	8
28	This is amazing!	2026-04-29 13:32:25.084801	39	8
29	Where is this?!	2026-04-29 13:32:25.08702	62	8
30	This is amazing!	2026-04-29 13:32:25.089417	67	8
31	This is amazing!	2026-04-29 13:32:25.140995	56	9
32	Where is this?!	2026-04-29 13:32:25.14335	31	9
33	Vestigium amplitudo basium summisse arto umerus tabella amet tabernus voluptates.\nEt video victus decet desidero urbs usitas paens ratione adficio.\nAegrotatio tot alius harum argentum placeat.\nUmerus vivo censura tremo adsidue defluo virtus tabernus usque.\nBeatae casso subito blandior.	2026-04-29 13:32:25.145749	19	9
34	Xiphias magnam audio terebro tener.	2026-04-29 13:32:25.164058	75	10
35	Love this so much	2026-04-29 13:32:25.166513	47	10
36	Campana communis praesentium agnosco sollers. Subseco arcus arma voluptates stella versus claustrum aestas vester coma. Comminor voluptates vado balbus comparo.	2026-04-29 13:32:25.16847	46	10
37	Love this so much	2026-04-29 13:32:25.170504	44	10
38	This is amazing!	2026-04-29 13:32:25.174501	53	10
39	Love this so much	2026-04-29 13:32:25.22146	57	11
40	Where is this?!	2026-04-29 13:32:25.225364	36	11
41	Aegre modi auctus vobis decet undique textilis delectus theologus cenaculum.	2026-04-29 13:32:25.227829	49	11
42	This is amazing!	2026-04-29 13:32:25.301284	19	13
43	Where is this?!	2026-04-29 13:32:25.305043	64	13
44	Adnuo perferendis colligo decens et spectaculum laudantium spero iste.\nVer clam teres vulgus cetera peccatus arcesso solvo acquiro quo.\nSolitudo atrox delinquo vomito eligendi.\nAdnuo odio concedo tabernus spero aggredior comminor.	2026-04-29 13:32:25.309152	59	13
45	Conatus demulceo tenus atqui claro.\nSolus corporis credo vaco thesaurus spes capillus pariatur.\nCaelum consectetur deleo.	2026-04-29 13:32:25.355697	14	14
46	Adipiscor volaticus defungo adstringo derelinquo tandem.	2026-04-29 13:32:25.358892	71	14
47	Love this so much	2026-04-29 13:32:25.398096	50	15
48	Where is this?!	2026-04-29 13:32:25.40154	77	15
49	Vir coaegresco aequus degenero creptio. Sollers vesica velit defetiscor infit aequus dolorem. Tui tracto terga demergo assumenda contigo testimonium tamquam sodalitas.	2026-04-29 13:32:25.405013	99	15
50	Veritatis aqua aeneus.\nColo canto adaugeo vitiosus.	2026-04-29 13:32:25.454816	54	16
51	Caput odio infit. Theca crux aufero sollicito patior tantum ante attonbitus. Thymum beatus armarium.	2026-04-29 13:32:25.458393	76	16
52	Where is this?!	2026-04-29 13:32:25.461235	65	16
53	Tolero capillus aequitas claudeo quisquam ocer.	2026-04-29 13:32:25.464515	94	16
54	Where is this?!	2026-04-29 13:32:25.467026	78	16
55	Love this so much	2026-04-29 13:32:25.504502	77	17
56	Love this so much	2026-04-29 13:32:25.508836	71	17
57	This is amazing!	2026-04-29 13:32:25.5129	94	17
58	Absorbeo candidus aegrotatio sollers campana cohors cognatus conicio.	2026-04-29 13:32:25.581806	80	19
59	Curiositas maxime balbus tabesco sublime iusto. Viridis tepesco crudelis umerus. Absorbeo inventore ascisco conitor textus talis tamen carbo.	2026-04-29 13:32:25.586449	4	19
60	Where is this?!	2026-04-29 13:32:25.59059	92	19
61	Where is this?!	2026-04-29 13:32:25.594379	98	19
62	Where is this?!	2026-04-29 13:32:25.597603	60	19
63	Where is this?!	2026-04-29 13:32:25.673718	16	20
64	Love this so much	2026-04-29 13:32:25.712092	62	21
65	Decerno truculenter deserunt ter peior dapifer vergo amaritudo. Uberrime advoco est studio damnatio vallum vestrum colligo spiculum conor. Atavus cibo laborum.	2026-04-29 13:32:25.779307	1	22
66	Defero odio viriliter talus viduo basium sollers texo ante corrigo.	2026-04-29 13:32:25.781718	13	22
67	Sto universe assentator bis vomito caelum voluptate. Ars desparatus hic culpo subnecto ducimus tergeo versus tabesco. Vox volo ventosus tactus celo.	2026-04-29 13:32:25.785066	64	22
68	Consuasor cavus provident cicuta porro aggredior avaritia cruciamentum.\nAdipiscor aspicio aspernatur.\nDeinde cur earum.\nQuasi unde vindico virtus tendo degero.\nCuriositas vix ulterius.	2026-04-29 13:32:25.789432	43	22
69	Love this so much	2026-04-29 13:32:25.909754	30	24
70	Where is this?!	2026-04-29 13:32:25.913406	73	24
71	This is amazing!	2026-04-29 13:32:25.917057	29	24
72	Culpo verbera calculus vallum.	2026-04-29 13:32:25.956246	70	25
73	Deserunt bellicus amoveo vesica.	2026-04-29 13:32:26.037296	92	27
74	Adipisci taedium vulgaris.	2026-04-29 13:32:26.039822	17	27
75	Demergo amitto similique paens arma.\nUniverse natus eos canto quos derelinquo amoveo acidus adsum.\nVigilo depulso ambulo texo harum calamitas apparatus.	2026-04-29 13:32:26.042344	80	27
76	Suscipit circumvenio error.\nAsper aegrus ustilo censura cupressus umquam condico rem peior.	2026-04-29 13:32:26.044674	65	27
77	Where is this?!	2026-04-29 13:32:26.078708	62	28
78	A bestia audio utrimque vulnero tendo velociter arbustum comprehendo. Vociferor vigilo anser. Decumbo tersus defetiscor impedit.	2026-04-29 13:32:26.114249	54	29
79	Aequus totam tolero triduana suscipit.	2026-04-29 13:32:26.11687	74	29
80	This is amazing!	2026-04-29 13:32:26.156188	98	30
81	Love this so much	2026-04-29 13:32:26.159299	63	30
82	Voco voco qui.\nDemonstro civitas cruentus urbs condico theatrum.\nNobis enim cohaero earum aequus.\nTeneo angulus dens sortitus praesentium.\nRepudiandae tripudio terreo deprecator celebrer aequus exercitationem accusamus solum hic.	2026-04-29 13:32:26.162545	91	30
83	Aedificium cura curis. Utor conqueror ante deorsum vehemens cura. Distinctio cultellus curiositas decerno.	2026-04-29 13:32:26.231222	42	31
84	This is amazing!	2026-04-29 13:32:26.23401	90	31
85	This is amazing!	2026-04-29 13:32:26.236986	77	31
86	Aestus credo supplanto tamisium consectetur sumptus utilis. Demo synagoga cibus. Cognatus molestias capillus.	2026-04-29 13:32:26.240258	19	31
87	Theologus candidus campana victus.\nAntea et vinum civis natus cibus paulatim eius.\nExcepturi undique sumptus tero amoveo attonbitus atqui terra.\nTotus conscendo placeat ex subvenio blandior atrocitas viridis.\nCito vehemens defaeco ad pectus truculenter solutio thesaurus amor.	2026-04-29 13:32:26.2436	4	31
88	This is amazing!	2026-04-29 13:32:26.308626	32	32
89	Love this so much	2026-04-29 13:32:26.312063	8	32
90	Where is this?!	2026-04-29 13:32:26.336703	90	33
91	Love this so much	2026-04-29 13:32:26.340338	91	33
92	Where is this?!	2026-04-29 13:32:26.385411	11	34
93	Where is this?!	2026-04-29 13:32:26.388635	61	34
94	This is amazing!	2026-04-29 13:32:26.391051	19	34
95	Love this so much	2026-04-29 13:32:26.393929	93	34
96	Omnis centum arceo conturbo pauper vinco convoco subseco. Clibanus tersus beatae patior convoco sto a tredecim. Virgo tondeo apud.	2026-04-29 13:32:26.397006	59	34
97	Where is this?!	2026-04-29 13:32:26.445652	75	35
98	Where is this?!	2026-04-29 13:32:26.491547	70	36
99	Aperiam sordeo certe uterque velut crux demum tripudio vesper. Tum cubitum depulso spoliatio cattus curso decens conspergo videlicet delicate. Vociferor solitudo alius cornu sequi votum pectus accedo advenio cum.	2026-04-29 13:32:26.494666	31	36
100	Cultura admiratio depromo basium.\nTum cohors curvo ventito suggero verbera deleniti.\nThesaurus culpo crebro.	2026-04-29 13:32:26.497464	8	36
101	Love this so much	2026-04-29 13:32:26.501064	90	36
102	Where is this?!	2026-04-29 13:32:26.56463	62	37
103	Love this so much	2026-04-29 13:32:26.623089	48	38
104	Curis antiquus benevolentia quia fugiat sollers.	2026-04-29 13:32:26.626452	65	38
105	Bis alter verumtamen tamisium arcesso crustulum explicabo. Atavus appositus suppono celo usus vesica. Coadunatio varius suus.	2026-04-29 13:32:26.630189	12	38
106	Cibus strues vae appello quod deleniti.	2026-04-29 13:32:26.634124	2	38
107	Dolor sulum volva theca tabgo id virtus.	2026-04-29 13:32:26.637735	45	38
108	Pectus ultra quae vulariter. Ulterius curo capitulus animadverto curis curatio. Tactus acceptus complectus carmen voco.	2026-04-29 13:32:26.669105	56	39
109	Asper cervus sint socius victus verbera.\nTheologus occaecati viridis vaco.\nCreo cernuus currus.\nVideo adstringo tergeo capitulus.\nAmiculum corroboro cernuus addo tabula.	2026-04-29 13:32:26.671973	46	39
110	Cena nihil vos vulnus conqueror acsi teres casso coadunatio.	2026-04-29 13:32:26.675627	80	39
111	Coerceo caute voluptatibus atrox tumultus.\nPeior eveniet aptus.\nSuper conqueror copiose adflicto auctor eaque adhuc astrum.\nCervus admitto territo deripio sufficio quisquam.\nVolup iste crebro laudantium aspicio chirographum colo appello atque.	2026-04-29 13:32:26.678326	6	39
112	Volubilis talus corrupti civis stultus adulatio corrigo patria tumultus acidus.\nUlterius tyrannus at talus ullus accusator trado.\nSulum adhaero asper artificiose.\nSollicito vitiosus curriculum tero amissio vomica adicio convoco.	2026-04-29 13:32:26.681363	69	39
113	Advoco degusto patria vomica decimus. Tolero alius vesco neque debitis absum studio vulticulus sint autus. Verus copia subnecto veritatis arbitro vox sit votum vita vulgaris.	2026-04-29 13:32:26.720389	68	40
114	Pecco callide aut. Verbera tutamen placeat atavus facilis. Damno vis via.	2026-04-29 13:32:26.724328	54	40
115	Ullam explicabo temeritas aureus colligo caterva dapifer abundans amiculum benevolentia.	2026-04-29 13:32:26.727134	63	40
116	Love this so much	2026-04-29 13:32:26.729662	70	40
117	Where is this?!	2026-04-29 13:32:26.732605	20	40
118	Considero turpis degenero verumtamen molestias stillicidium.	2026-04-29 13:32:26.78494	3	41
119	Where is this?!	2026-04-29 13:32:26.788435	15	41
120	Crur vereor addo celo utilis complectus dolores. Solitudo capitulus corrumpo alias virtus tribuo decor tardus demens. Tenetur tristis vere depono eveniet utrum arbustum.	2026-04-29 13:32:26.791267	55	41
121	Love this so much	2026-04-29 13:32:26.794734	24	41
122	Surculus tamen thalassinus solvo curtus aspernatur neque curvo. Vis agnitio ex. Officia in architecto appositus adinventitias.	2026-04-29 13:32:26.797569	94	41
123	This is amazing!	2026-04-29 13:32:26.849565	99	42
124	This is amazing!	2026-04-29 13:32:26.851908	64	42
125	Love this so much	2026-04-29 13:32:26.884063	82	43
126	Where is this?!	2026-04-29 13:32:26.88679	37	43
127	This is amazing!	2026-04-29 13:32:26.889824	78	43
128	Love this so much	2026-04-29 13:32:26.948569	100	44
129	Love this so much	2026-04-29 13:32:26.951468	77	44
130	This is amazing!	2026-04-29 13:32:26.954975	22	44
131	Adfectus synagoga curso.\nQuas pecco corroboro ustilo cum contabesco pectus audio atrox brevis.\nCiminatio aut tutis adsuesco vito voco theca statim amaritudo.\nCunabula cresco conturbo decerno truculenter repudiandae.\nVeniam suppono aestas sollicito earum umerus appositus.	2026-04-29 13:32:26.974945	50	45
132	Eos sollers aperte subvenio suppellex bellicus compono capitulus vergo. Alienus dolor caute abundans aegrus victus. Iste architecto vulticulus cervus.	2026-04-29 13:32:26.976991	90	45
133	Love this so much	2026-04-29 13:32:27.033263	56	46
134	Love this so much	2026-04-29 13:32:27.037111	83	46
135	This is amazing!	2026-04-29 13:32:27.041647	16	46
136	Where is this?!	2026-04-29 13:32:27.103001	42	48
137	Cunabula triduana apparatus theca utroque solio culpa.	2026-04-29 13:32:27.107633	23	48
138	This is amazing!	2026-04-29 13:32:27.111537	2	48
139	Capio tredecim celebrer.\nVarietas aduro cui stips timor solvo aequitas pel.\nFacilis decumbo acerbitas adversus debilito vivo ullam deorsum.\nCatena velum dapifer vel candidus.	2026-04-29 13:32:27.228167	19	50
140	Where is this?!	2026-04-29 13:32:27.231847	54	50
141	Love this so much	2026-04-29 13:32:27.235629	55	50
142	Love this so much	2026-04-29 13:32:27.239449	39	50
143	Acceptus depulso templum soluta at voro quo desidero. Comedo comptus solvo vociferor addo autus ago tumultus vos acidus. Vigilo aperio caterva verbum credo attero suffragium termes.	2026-04-29 13:32:27.244321	95	50
144	Soleo audacia sunt.	2026-04-29 13:32:27.328774	1	52
145	Where is this?!	2026-04-29 13:32:27.330837	43	52
146	Where is this?!	2026-04-29 13:32:27.333258	80	52
147	Desparatus dolorem consequuntur ipsam tamdiu adulatio triduana tenuis minus deprimo. Comprehendo vesper vigor comptus doloribus vacuus. Animi viriliter damnatio vetus advoco attonbitus antiquus caritas.	2026-04-29 13:32:27.335831	64	52
148	Capitulus consequuntur quaerat triumphus amor depraedor.	2026-04-29 13:32:27.383793	73	53
149	Love this so much	2026-04-29 13:32:27.38737	16	53
150	Ulterius delinquo cilicium consequatur tunc temperantia corporis arbor.\nSpeculum hic ceno atque compono nam at stabilis.	2026-04-29 13:32:27.443452	29	54
151	Love this so much	2026-04-29 13:32:27.497619	27	56
152	Molestias degenero sufficio sui error bellum.\nCasus synagoga tenus summopere causa.\nAdipisci tergeo annus fugit tripudio audax demulceo.\nCursim thorax acervus defetiscor.	2026-04-29 13:32:27.500184	18	56
153	Alo communis quaerat votum soleo arcesso advoco id veniam quas. Sollicito armarium quidem auditor subseco surgo timor fugiat spiritus demonstro. Versus crustulum trans timor usus accusator tego avarus.	2026-04-29 13:32:27.502552	15	56
154	Talus valens terebro dolores vester aggredior cimentarius summopere curo cunctatio.	2026-04-29 13:32:27.505724	12	56
155	Tepidus accusamus vinco tricesimus totidem decerno claro. Absconditus creator contabesco. Aperiam autus recusandae cruentus tripudio suppono.	2026-04-29 13:32:27.509346	53	56
156	Utrimque patruus decretum atque creta.\nPecto sponte ocer suspendo vesper adicio aduro aveho stipes.	2026-04-29 13:32:27.558049	46	57
157	This is amazing!	2026-04-29 13:32:27.56043	75	57
158	This is amazing!	2026-04-29 13:32:27.562907	21	57
159	Cupio triumphus doloremque thesis curis caute cruciamentum audacia audentia tametsi.\nAbbas alter animi.\nRepellat coerceo thalassinus caveo.	2026-04-29 13:32:27.565306	30	57
160	Officia minima confugo accusamus desino.\nTabgo tres officia impedit via amita aptus articulus apud.	2026-04-29 13:32:27.567518	37	57
161	Love this so much	2026-04-29 13:32:27.605352	78	58
162	Crux conor abundans in somniculosus volva.\nAssumenda advoco sumo delectus coadunatio cubitum suadeo antiquus cicuta tenax.\nComptus velum deleniti subseco aegre adulatio eligendi umbra stabilis attollo.\nArs admiratio spectaculum vilicus trado compono conscendo surgo porro.	2026-04-29 13:32:27.643622	84	59
163	Where is this?!	2026-04-29 13:32:27.645727	75	59
164	This is amazing!	2026-04-29 13:32:27.647964	41	59
165	Where is this?!	2026-04-29 13:32:27.650191	66	59
166	Vomer sulum anser ars cetera vero conitor annus. Vespillo amoveo advenio apto titulus stultus calco. Coniuratio conscendo volutabrum debitis quisquam super debilito comis dicta virga.	2026-04-29 13:32:27.653269	96	59
167	This is amazing!	2026-04-29 13:32:27.675919	64	60
168	Accusantium tergiversatio bellum sponte commodo laudantium vulgaris curtus.	2026-04-29 13:32:27.680392	45	60
169	Tergeo delinquo minus rem.	2026-04-29 13:32:27.737559	15	62
170	Where is this?!	2026-04-29 13:32:27.741631	65	62
171	Strues vomica tracto temeritas canis alius exercitationem optio repellat auxilium.	2026-04-29 13:32:27.744901	87	62
172	Quis alveus umerus constans vulgivagus casso commodi. Vulpes adiuvo tabella solitudo desidero caveo. Acerbitas uberrime communis compello ciminatio.	2026-04-29 13:32:27.791755	94	63
173	Conculco capio adsidue corpus xiphias quisquam. Vinculum vilis rerum vesper voluptas. Acer strenuus cometes decet speculum tondeo tam.	2026-04-29 13:32:27.79452	95	63
174	Where is this?!	2026-04-29 13:32:27.851627	65	64
175	Praesentium callide synagoga ventus desolo degenero comprehendo.	2026-04-29 13:32:27.853662	90	64
176	Love this so much	2026-04-29 13:32:27.937461	7	66
177	Adfero aspicio audacia. Vergo arx causa arceo. Adnuo collum vinco temeritas terra vallum vinculum peior trepide.	2026-04-29 13:32:27.940627	75	66
178	Love this so much	2026-04-29 13:32:27.944521	3	66
179	This is amazing!	2026-04-29 13:32:27.948228	19	66
180	Umbra deludo casso sapiente. Ventus creta quo vivo consectetur. Curto vos beatus considero copiose synagoga.	2026-04-29 13:32:28.008968	79	67
181	This is amazing!	2026-04-29 13:32:28.011542	1	67
182	Where is this?!	2026-04-29 13:32:28.015568	76	67
183	Where is this?!	2026-04-29 13:32:28.019226	54	67
184	Spiritus abutor ipsum undique cito acies anser comptus.\nContra arceo demoror canis.\nAddo delicate creber.	2026-04-29 13:32:28.068882	9	68
185	Beneficium trucido subiungo dicta voveo terreo viscus acquiro.	2026-04-29 13:32:28.071124	46	68
186	Love this so much	2026-04-29 13:32:28.073892	38	68
187	Sordeo decerno testimonium eligendi adicio termes causa ter vespillo deputo. Vergo caecus beneficium adopto accusamus territo defluo accusator ustilo. Caput saepe summa stips conforto vix suffoco.	2026-04-29 13:32:28.076087	92	68
188	Where is this?!	2026-04-29 13:32:28.079831	42	68
189	Molestiae optio corrupti pel.	2026-04-29 13:32:28.14841	40	69
190	Where is this?!	2026-04-29 13:32:28.152678	73	69
191	This is amazing!	2026-04-29 13:32:28.157498	37	69
192	Love this so much	2026-04-29 13:32:28.195172	40	70
193	Where is this?!	2026-04-29 13:32:28.199057	10	70
194	Libero cedo collum incidunt. Absorbeo adfectus caute trado animi cenaculum appono absorbeo denuo. Una vere agnitio tamdiu vociferor custodia allatus vado.	2026-04-29 13:32:28.251192	70	71
195	Conspergo adnuo nobis.\nVulgo universe comparo vulgivagus valetudo exercitationem cultellus tergeo vehemens.\nDeorsum surculus despecto.	2026-04-29 13:32:28.288356	14	72
196	Love this so much	2026-04-29 13:32:28.291352	63	72
197	A deorsum demum ait solio aegrus adeptio quaerat. Carmen ubi odio sustineo tristis. Solvo beatae aestas clarus adulescens vorax aranea sordeo deprecator degero.	2026-04-29 13:32:28.294385	10	72
198	Vulticulus degenero turpis canis tenax tot asper vitiosus.\nVolutabrum subito vita angustus apparatus attero.	2026-04-29 13:32:28.296486	59	72
199	Where is this?!	2026-04-29 13:32:28.299213	69	72
200	Love this so much	2026-04-29 13:32:28.339995	18	73
201	This is amazing!	2026-04-29 13:32:28.343457	49	73
202	Where is this?!	2026-04-29 13:32:28.346476	65	73
203	Where is this?!	2026-04-29 13:32:28.348945	88	73
204	Speciosus terror via doloremque arcesso canonicus stella anser video.	2026-04-29 13:32:28.353182	47	73
205	Temptatio varietas dolores suggero claro cariosus minus demonstro hic aliquam. Theologus celebrer earum sol animadverto utor titulus ciminatio delectus. Centum cilicium desino vero ulterius deludo debitis arma.	2026-04-29 13:32:28.406595	57	74
206	Velit ustulo cena trado corona vinum velut earum.	2026-04-29 13:32:28.410708	64	74
207	Audio callide terror truculenter molestias pauper dicta asperiores. Admitto vinco cribro tepidus utilis. Calculus est antea virgo celo vir utpote.	2026-04-29 13:32:28.41379	67	74
208	Where is this?!	2026-04-29 13:32:28.458059	3	75
209	This is amazing!	2026-04-29 13:32:28.460512	11	75
210	Vito armarium summisse verus provident aranea carpo cenaculum cur.	2026-04-29 13:32:28.468859	66	75
211	Quidem adicio vulgo supplanto odio arguo ustilo cito.	2026-04-29 13:32:28.565636	35	77
212	Supellex acies conicio iure hic. Adhaero cursim tametsi comedo absque pauci. Quibusdam corroboro aequitas abeo accendo verecundia aliquid vestigium congregatio.	2026-04-29 13:32:28.631527	5	78
213	Timor decerno universe pecto congregatio utroque vobis.	2026-04-29 13:32:28.635641	16	78
214	This is amazing!	2026-04-29 13:32:28.639566	65	78
215	Copia chirographum uterque terreo nam vox demoror pel tutamen adipiscor.	2026-04-29 13:32:28.643045	94	78
216	Usus minus paens corrumpo vetus. Pel administratio carmen caelum compello voluptates texo avaritia. Volubilis rem clementia careo infit cupio cerno velut debilito.	2026-04-29 13:32:28.702086	35	79
217	Iure delego ulciscor quis commodi odit volutabrum crinis. Sponte adopto cicuta culpa triduana uterque. Crudelis necessitatibus aggero succedo.	2026-04-29 13:32:28.733037	29	80
218	This is amazing!	2026-04-29 13:32:28.735772	74	80
219	Love this so much	2026-04-29 13:32:28.73889	31	80
220	This is amazing!	2026-04-29 13:32:28.784354	17	81
221	Where is this?!	2026-04-29 13:32:28.786494	29	81
222	Where is this?!	2026-04-29 13:32:28.789682	13	81
223	Where is this?!	2026-04-29 13:32:28.82731	48	82
224	Love this so much	2026-04-29 13:32:28.893247	92	83
225	Cupio decerno dens varius casus copiose omnis solum vox.	2026-04-29 13:32:28.895995	7	83
226	Qui allatus celebrer denuo hic desino acsi stultus inventore bibo.\nTheca vigilo curvo.\nUlciscor demens tabernus antiquus conspergo vulariter talus vigilo barba.	2026-04-29 13:32:28.898706	7	83
227	Contigo conor cruentus. Vae deorsum abbas arx adamo pecus adsum tactus. Terror decens calcar soleo non versus nesciunt urbanus certe ambulo.	2026-04-29 13:32:28.901713	36	83
228	Aggredior benevolentia xiphias molestiae.\nAmita quisquam deripio.\nVitiosus denuo deripio voro auxilium cras.	2026-04-29 13:32:28.904613	1	83
229	Thymum vulnus tantum auctor nulla vapulus pecco conduco atavus.\nSupra vir in.	2026-04-29 13:32:28.975543	2	85
230	This is amazing!	2026-04-29 13:32:28.978461	99	85
231	Templum iusto ab.	2026-04-29 13:32:28.980956	29	85
232	Antiquus studio sonitus ducimus creo iusto animi ad.\nCognatus curtus sumo desino bibo dignissimos.\nAbundans stips harum valde creptio culpa carpo curso ventus.	2026-04-29 13:32:28.984576	35	85
233	Love this so much	2026-04-29 13:32:29.042584	3	86
234	This is amazing!	2026-04-29 13:32:29.045945	76	86
235	Dapifer tamen deporto voluptate defessus careo culpa vel.\nBibo provident usque tergiversatio demum dignissimos decerno demoror conventus collum.\nAdeo avarus cervus qui absconditus caelum.\nIpsam praesentium vesper vero.	2026-04-29 13:32:29.092707	53	87
236	This is amazing!	2026-04-29 13:32:29.0953	82	87
237	Where is this?!	2026-04-29 13:32:29.097398	6	87
238	Where is this?!	2026-04-29 13:32:29.099137	68	87
239	Where is this?!	2026-04-29 13:32:29.102264	58	87
240	Aqua totam paulatim arto suffragium.	2026-04-29 13:32:29.13481	24	88
241	Love this so much	2026-04-29 13:32:29.182051	91	89
242	This is amazing!	2026-04-29 13:32:29.184624	90	89
243	Appono nulla speciosus antea aro inflammatio nemo incidunt aliqua arma.\nAdmitto usus aspicio supra calcar auxilium caries.\nTerreo deprimo quam demitto annus dolores textus.\nModi ascisco vado aveho taedium aegrus cum vulgus.	2026-04-29 13:32:29.187594	78	89
244	Comes vestigium volaticus triumphus totidem tamquam termes debitis caelestis tertius.\nBaiulus valetudo sursum.\nAbsconditus debitis caveo amiculum earum corpus eligendi alter.\nAliquid depraedor vigor copiose.	2026-04-29 13:32:29.190638	92	89
245	Crapula tabella infit votum verumtamen.	2026-04-29 13:32:29.194116	12	89
246	Vitium celo substantia deripio cilicium urbs. Tum turpis cubo. Asperiores bibo tubineus esse amet magnam bis stultus vigilo validus.	2026-04-29 13:32:29.242136	40	90
247	Love this so much	2026-04-29 13:32:29.245829	37	90
248	Sequi defetiscor dapifer adopto conor.	2026-04-29 13:32:29.248847	49	90
249	Uxor solum cultellus tabula debitis aegrus amicitia amor.\nAestas cattus conspergo turpis timidus officiis ver adicio.	2026-04-29 13:32:29.292762	85	91
250	Ea tandem cibo depulso culpo.	2026-04-29 13:32:29.296153	93	91
251	This is amazing!	2026-04-29 13:32:29.29992	31	91
252	Terga usque deludo. Cras degusto sollicito contigo suffoco defendo aufero esse varietas. Admitto adeo antiquus caput alo ipsam umquam ab.	2026-04-29 13:32:29.366435	2	92
253	Aranea angulus alii vesica. Suffragium aeger verbera traho canonicus conscendo cognatus sint sordeo. Decimus accedo verus tamisium quia vindico valeo adeo audentia abundans.	2026-04-29 13:32:29.36935	59	92
254	This is amazing!	2026-04-29 13:32:29.372606	66	92
255	This is amazing!	2026-04-29 13:32:29.413139	33	93
256	Infit vix voco curo thymum conforto iusto tempore.	2026-04-29 13:32:29.416779	58	93
257	This is amazing!	2026-04-29 13:32:29.42056	60	93
258	Love this so much	2026-04-29 13:32:29.424635	15	93
259	Bonus virtus testimonium cinis tergeo studio charisma aggredior sperno. Vomica appello utrum curatio testimonium deporto depraedor. Aeternus ceno deorsum labore desparatus celebrer.	2026-04-29 13:32:29.445336	32	94
260	Love this so much	2026-04-29 13:32:29.47726	19	95
261	Uter trucido confero ater annus vulgivagus. Magnam carmen auxilium crustulum cupressus laudantium corrigo accusantium vulgivagus. Taceo denego tristis suscipit soluta constans quibusdam neque.	2026-04-29 13:32:29.480993	24	95
262	This is amazing!	2026-04-29 13:32:29.485578	3	95
263	Verecundia verumtamen thema iure defero vix subiungo reprehenderit decens. Tener comminor calamitas sortitus conitor dolorum bene solvo. Clam via pecco.	2026-04-29 13:32:29.489097	3	95
264	This is amazing!	2026-04-29 13:32:29.52691	44	96
265	Triumphus arbustum tunc eligendi. Uter tardus conventus solvo fugit. Adhaero adfectus aveho.	2026-04-29 13:32:29.530023	71	96
266	At consectetur adhaero succedo.\nTaceo aliqua ocer umquam volaticus absorbeo beatae voluptatem sub.\nAqua vociferor paens.\nSuggero vestigium attonbitus caute aspicio adipisci testimonium defluo sponte armarium.	2026-04-29 13:32:29.53386	90	96
267	Love this so much	2026-04-29 13:32:29.573656	34	97
268	This is amazing!	2026-04-29 13:32:29.57605	74	97
269	Approbo pecto deputo defero atavus ventosus.\nBrevis vesco thalassinus stabilis cuius.\nSuspendo caput labore surgo valde repellendus conspergo ipsam dapifer tubineus.	2026-04-29 13:32:29.578157	49	97
270	Voluntarius denuo tego averto usitas suadeo concido creator copiose.	2026-04-29 13:32:29.623502	14	98
271	Love this so much	2026-04-29 13:32:29.625813	68	98
272	Where is this?!	2026-04-29 13:32:29.628176	26	98
273	Curiositas vox quia tersus volaticus voluptates.\nVideo timor terror deprimo vapulus commodi sto sulum ut.\nValetudo cedo iusto pecco vinum.\nSpiritus alioqui terra cicuta fuga animi.	2026-04-29 13:32:29.630595	79	98
274	Stella comprehendo cras acerbitas vitiosus.	2026-04-29 13:32:29.661228	7	99
275	Love this so much	2026-04-29 13:32:29.664618	77	99
276	This is amazing!	2026-04-29 13:32:29.712625	75	100
277	This is amazing!	2026-04-29 13:32:29.715812	88	100
278	Aliqua dedecor suasoria.\nSubseco terreo in sustineo.\nTaceo sollers demo.	2026-04-29 13:32:29.718345	32	100
279	This is amazing!	2026-04-29 13:32:29.720744	100	100
280	This is amazing!	2026-04-29 13:32:29.723071	31	100
\.


--
-- Data for Name: follows; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.follows (following_user_id, followed_user_id, created_at) FROM stdin;
7	39	2026-04-29 13:32:29.757624
10	17	2026-04-29 13:32:29.761273
10	79	2026-04-29 13:32:29.763964
6	36	2026-04-29 13:32:29.767134
6	66	2026-04-29 13:32:29.770415
6	30	2026-04-29 13:32:29.777017
5	82	2026-04-29 13:32:29.781712
9	12	2026-04-29 13:32:29.787821
9	15	2026-04-29 13:32:29.793761
36	91	2026-04-29 13:32:29.800902
36	14	2026-04-29 13:32:29.810223
36	27	2026-04-29 13:32:29.818143
36	18	2026-04-29 13:32:29.826244
36	34	2026-04-29 13:32:29.832081
38	75	2026-04-29 13:32:29.835899
38	31	2026-04-29 13:32:29.839201
38	60	2026-04-29 13:32:29.842594
38	21	2026-04-29 13:32:29.84561
2	42	2026-04-29 13:32:29.848857
2	70	2026-04-29 13:32:29.852017
2	47	2026-04-29 13:32:29.855471
2	15	2026-04-29 13:32:29.858495
8	2	2026-04-29 13:32:29.861849
11	79	2026-04-29 13:32:29.865132
11	8	2026-04-29 13:32:29.868752
11	2	2026-04-29 13:32:29.872316
12	69	2026-04-29 13:32:29.875504
12	66	2026-04-29 13:32:29.878661
12	72	2026-04-29 13:32:29.881543
12	35	2026-04-29 13:32:29.884936
12	86	2026-04-29 13:32:29.889062
13	84	2026-04-29 13:32:29.892307
13	32	2026-04-29 13:32:29.895183
13	48	2026-04-29 13:32:29.898447
13	11	2026-04-29 13:32:29.902241
13	21	2026-04-29 13:32:29.904963
14	82	2026-04-29 13:32:29.907868
14	47	2026-04-29 13:32:29.911534
15	83	2026-04-29 13:32:29.914456
17	92	2026-04-29 13:32:29.917122
17	82	2026-04-29 13:32:29.919998
17	44	2026-04-29 13:32:29.923326
17	49	2026-04-29 13:32:29.926036
18	88	2026-04-29 13:32:29.928532
18	84	2026-04-29 13:32:29.930768
20	58	2026-04-29 13:32:29.93445
21	91	2026-04-29 13:32:29.943131
21	46	2026-04-29 13:32:29.946533
21	62	2026-04-29 13:32:29.949862
22	48	2026-04-29 13:32:29.953648
22	53	2026-04-29 13:32:29.956311
26	3	2026-04-29 13:32:29.959461
26	22	2026-04-29 13:32:29.961907
26	50	2026-04-29 13:32:29.964778
26	62	2026-04-29 13:32:29.968229
24	22	2026-04-29 13:32:29.971092
24	68	2026-04-29 13:32:29.973556
24	57	2026-04-29 13:32:29.97639
25	91	2026-04-29 13:32:29.980095
25	72	2026-04-29 13:32:29.984247
29	69	2026-04-29 13:32:29.988355
29	22	2026-04-29 13:32:29.992534
30	92	2026-04-29 13:32:29.996168
30	91	2026-04-29 13:32:29.999652
30	8	2026-04-29 13:32:30.002933
30	42	2026-04-29 13:32:30.00577
30	29	2026-04-29 13:32:30.008067
31	70	2026-04-29 13:32:30.011856
31	28	2026-04-29 13:32:30.015777
31	56	2026-04-29 13:32:30.019595
32	41	2026-04-29 13:32:30.024515
32	77	2026-04-29 13:32:30.028486
34	48	2026-04-29 13:32:30.034934
35	32	2026-04-29 13:32:30.038615
35	89	2026-04-29 13:32:30.041998
37	77	2026-04-29 13:32:30.045882
40	67	2026-04-29 13:32:30.049219
40	66	2026-04-29 13:32:30.05236
40	77	2026-04-29 13:32:30.055966
42	26	2026-04-29 13:32:30.058949
43	9	2026-04-29 13:32:30.062375
43	35	2026-04-29 13:32:30.066166
44	100	2026-04-29 13:32:30.069189
44	66	2026-04-29 13:32:30.072575
44	93	2026-04-29 13:32:30.076621
44	99	2026-04-29 13:32:30.080447
45	61	2026-04-29 13:32:30.085132
45	68	2026-04-29 13:32:30.088807
46	12	2026-04-29 13:32:30.092546
47	34	2026-04-29 13:32:30.095881
48	89	2026-04-29 13:32:30.099248
48	57	2026-04-29 13:32:30.103546
48	3	2026-04-29 13:32:30.106993
48	91	2026-04-29 13:32:30.110685
49	11	2026-04-29 13:32:30.115146
49	96	2026-04-29 13:32:30.119091
49	20	2026-04-29 13:32:30.123201
49	3	2026-04-29 13:32:30.127486
50	91	2026-04-29 13:32:30.130723
50	64	2026-04-29 13:32:30.134392
50	6	2026-04-29 13:32:30.137321
51	37	2026-04-29 13:32:30.139903
51	86	2026-04-29 13:32:30.142794
51	63	2026-04-29 13:32:30.145974
51	43	2026-04-29 13:32:30.148682
52	4	2026-04-29 13:32:30.151997
52	42	2026-04-29 13:32:30.155542
52	50	2026-04-29 13:32:30.158734
52	69	2026-04-29 13:32:30.162595
53	7	2026-04-29 13:32:30.166369
54	3	2026-04-29 13:32:30.169745
54	25	2026-04-29 13:32:30.17288
54	87	2026-04-29 13:32:30.176502
55	70	2026-04-29 13:32:30.179974
56	46	2026-04-29 13:32:30.18372
56	66	2026-04-29 13:32:30.187301
56	22	2026-04-29 13:32:30.191038
57	31	2026-04-29 13:32:30.194962
57	72	2026-04-29 13:32:30.198403
59	56	2026-04-29 13:32:30.20279
59	46	2026-04-29 13:32:30.205643
59	1	2026-04-29 13:32:30.208659
60	91	2026-04-29 13:32:30.211653
60	70	2026-04-29 13:32:30.215039
60	65	2026-04-29 13:32:30.217955
61	17	2026-04-29 13:32:30.221584
61	6	2026-04-29 13:32:30.225377
62	79	2026-04-29 13:32:30.230263
62	4	2026-04-29 13:32:30.234867
63	61	2026-04-29 13:32:30.238244
63	32	2026-04-29 13:32:30.244118
64	70	2026-04-29 13:32:30.247415
64	100	2026-04-29 13:32:30.250077
64	73	2026-04-29 13:32:30.254145
64	41	2026-04-29 13:32:30.257202
66	89	2026-04-29 13:32:30.260558
66	78	2026-04-29 13:32:30.264616
66	13	2026-04-29 13:32:30.268238
66	45	2026-04-29 13:32:30.270934
66	85	2026-04-29 13:32:30.274255
67	52	2026-04-29 13:32:30.277603
68	92	2026-04-29 13:32:30.280979
68	95	2026-04-29 13:32:30.285308
68	41	2026-04-29 13:32:30.288169
69	48	2026-04-29 13:32:30.290841
69	81	2026-04-29 13:32:30.294557
69	70	2026-04-29 13:32:30.299074
69	6	2026-04-29 13:32:30.302545
70	6	2026-04-29 13:32:30.305964
70	13	2026-04-29 13:32:30.308488
70	11	2026-04-29 13:32:30.311668
70	39	2026-04-29 13:32:30.31485
71	3	2026-04-29 13:32:30.317662
72	31	2026-04-29 13:32:30.321313
72	97	2026-04-29 13:32:30.324986
72	33	2026-04-29 13:32:30.328639
72	67	2026-04-29 13:32:30.331812
73	44	2026-04-29 13:32:30.335158
73	49	2026-04-29 13:32:30.338893
73	89	2026-04-29 13:32:30.341496
73	56	2026-04-29 13:32:30.344741
74	11	2026-04-29 13:32:30.34738
74	81	2026-04-29 13:32:30.349744
74	46	2026-04-29 13:32:30.352671
74	41	2026-04-29 13:32:30.356067
75	52	2026-04-29 13:32:30.359158
75	59	2026-04-29 13:32:30.363117
75	43	2026-04-29 13:32:30.367257
77	16	2026-04-29 13:32:30.370804
77	70	2026-04-29 13:32:30.37428
77	13	2026-04-29 13:32:30.377606
78	62	2026-04-29 13:32:30.380272
78	40	2026-04-29 13:32:30.384896
78	100	2026-04-29 13:32:30.388103
78	45	2026-04-29 13:32:30.39117
79	4	2026-04-29 13:32:30.394212
80	65	2026-04-29 13:32:30.398105
81	23	2026-04-29 13:32:30.40186
81	15	2026-04-29 13:32:30.405456
81	73	2026-04-29 13:32:30.408614
81	52	2026-04-29 13:32:30.411669
81	72	2026-04-29 13:32:30.415069
82	30	2026-04-29 13:32:30.417814
82	85	2026-04-29 13:32:30.421608
82	86	2026-04-29 13:32:30.42498
85	23	2026-04-29 13:32:30.428041
85	61	2026-04-29 13:32:30.432288
85	11	2026-04-29 13:32:30.435239
86	89	2026-04-29 13:32:30.438127
86	29	2026-04-29 13:32:30.442888
86	16	2026-04-29 13:32:30.447335
86	28	2026-04-29 13:32:30.450892
86	7	2026-04-29 13:32:30.453817
87	99	2026-04-29 13:32:30.457118
87	53	2026-04-29 13:32:30.459678
87	14	2026-04-29 13:32:30.462857
87	42	2026-04-29 13:32:30.472327
87	9	2026-04-29 13:32:30.478155
88	87	2026-04-29 13:32:30.482382
88	75	2026-04-29 13:32:30.48609
88	76	2026-04-29 13:32:30.49203
88	23	2026-04-29 13:32:30.496168
89	59	2026-04-29 13:32:30.500568
89	54	2026-04-29 13:32:30.505464
90	15	2026-04-29 13:32:30.511075
90	23	2026-04-29 13:32:30.515619
90	9	2026-04-29 13:32:30.51846
90	87	2026-04-29 13:32:30.522482
90	52	2026-04-29 13:32:30.526396
91	69	2026-04-29 13:32:30.530097
91	20	2026-04-29 13:32:30.533271
91	82	2026-04-29 13:32:30.53657
91	76	2026-04-29 13:32:30.540058
92	95	2026-04-29 13:32:30.544158
92	83	2026-04-29 13:32:30.547303
92	61	2026-04-29 13:32:30.550038
92	52	2026-04-29 13:32:30.555364
92	48	2026-04-29 13:32:30.561685
94	77	2026-04-29 13:32:30.565706
94	64	2026-04-29 13:32:30.569383
94	33	2026-04-29 13:32:30.573608
94	15	2026-04-29 13:32:30.57739
94	74	2026-04-29 13:32:30.58075
95	41	2026-04-29 13:32:30.585243
95	68	2026-04-29 13:32:30.58908
95	80	2026-04-29 13:32:30.591639
95	69	2026-04-29 13:32:30.595182
96	22	2026-04-29 13:32:30.598688
96	73	2026-04-29 13:32:30.602645
96	76	2026-04-29 13:32:30.606995
97	88	2026-04-29 13:32:30.612064
97	31	2026-04-29 13:32:30.617224
97	99	2026-04-29 13:32:30.62281
99	71	2026-04-29 13:32:30.626923
99	49	2026-04-29 13:32:30.630212
99	32	2026-04-29 13:32:30.633737
100	9	2026-04-29 13:32:30.637965
100	72	2026-04-29 13:32:30.641835
100	51	2026-04-29 13:32:30.645387
\.


--
-- Data for Name: hashtags; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.hashtags (id, name, created_at) FROM stdin;
1	taliodT2	2026-04-29 13:32:23.721476
2	dignissimosyw2	2026-04-29 13:32:23.721462
3	caveo6Dv	2026-04-29 13:32:23.721577
4	assentatorUTb	2026-04-29 13:32:23.721469
5	laborer6B	2026-04-29 13:32:23.721558
6	maioreskJj	2026-04-29 13:32:23.721816
7	sursumYvg	2026-04-29 13:32:23.721692
8	arx9j0	2026-04-29 13:32:23.721856
9	dedecorIQl	2026-04-29 13:32:23.721693
10	alienusy6A	2026-04-29 13:32:23.721594
11	veritas3xL	2026-04-29 13:32:23.726369
12	conturbopCQ	2026-04-29 13:32:23.727457
13	innky	2026-04-29 13:32:23.727556
14	libero5sX	2026-04-29 13:32:23.727645
15	agnosco4Ji	2026-04-29 13:32:23.727761
16	vulgivagus4IT	2026-04-29 13:32:23.727899
17	odio3KV	2026-04-29 13:32:23.728045
18	cursim6fW	2026-04-29 13:32:23.72799
19	calculusdDt	2026-04-29 13:32:23.728157
20	voxvYf	2026-04-29 13:32:23.72928
\.


--
-- Data for Name: likes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.likes (user_id, post_id, created_at) FROM stdin;
67	1	2026-04-29 13:32:24.713024
39	1	2026-04-29 13:32:24.718994
10	1	2026-04-29 13:32:24.724781
49	1	2026-04-29 13:32:24.730572
10	2	2026-04-29 13:32:24.763102
97	2	2026-04-29 13:32:24.767476
63	2	2026-04-29 13:32:24.772785
91	2	2026-04-29 13:32:24.777151
31	2	2026-04-29 13:32:24.782223
10	3	2026-04-29 13:32:24.813537
5	3	2026-04-29 13:32:24.818108
76	3	2026-04-29 13:32:24.825707
90	4	2026-04-29 13:32:24.868542
55	4	2026-04-29 13:32:24.872964
15	4	2026-04-29 13:32:24.877251
67	4	2026-04-29 13:32:24.882188
75	4	2026-04-29 13:32:24.887
13	4	2026-04-29 13:32:24.89162
46	4	2026-04-29 13:32:24.896135
34	4	2026-04-29 13:32:24.900165
56	5	2026-04-29 13:32:24.950607
13	5	2026-04-29 13:32:24.953306
84	5	2026-04-29 13:32:24.955873
27	5	2026-04-29 13:32:24.959345
27	6	2026-04-29 13:32:24.981547
52	6	2026-04-29 13:32:24.984023
50	6	2026-04-29 13:32:24.986489
60	6	2026-04-29 13:32:24.991846
10	6	2026-04-29 13:32:24.996121
69	6	2026-04-29 13:32:24.999671
98	6	2026-04-29 13:32:25.004167
80	7	2026-04-29 13:32:25.039657
26	7	2026-04-29 13:32:25.043716
63	7	2026-04-29 13:32:25.046924
10	7	2026-04-29 13:32:25.050237
3	7	2026-04-29 13:32:25.05382
17	7	2026-04-29 13:32:25.056999
66	7	2026-04-29 13:32:25.060351
91	7	2026-04-29 13:32:25.062924
59	7	2026-04-29 13:32:25.06681
35	8	2026-04-29 13:32:25.09243
33	8	2026-04-29 13:32:25.095049
55	8	2026-04-29 13:32:25.097443
79	8	2026-04-29 13:32:25.099912
11	8	2026-04-29 13:32:25.102918
16	8	2026-04-29 13:32:25.105787
60	8	2026-04-29 13:32:25.108784
49	8	2026-04-29 13:32:25.112671
51	8	2026-04-29 13:32:25.117742
21	8	2026-04-29 13:32:25.121192
49	9	2026-04-29 13:32:25.148677
92	9	2026-04-29 13:32:25.151116
84	10	2026-04-29 13:32:25.178658
30	10	2026-04-29 13:32:25.182294
81	10	2026-04-29 13:32:25.185682
79	10	2026-04-29 13:32:25.188212
63	10	2026-04-29 13:32:25.191216
10	10	2026-04-29 13:32:25.194521
4	10	2026-04-29 13:32:25.198367
65	10	2026-04-29 13:32:25.205519
100	10	2026-04-29 13:32:25.208245
29	11	2026-04-29 13:32:25.230727
18	11	2026-04-29 13:32:25.235054
42	11	2026-04-29 13:32:25.239315
54	11	2026-04-29 13:32:25.243768
39	12	2026-04-29 13:32:25.263964
40	12	2026-04-29 13:32:25.268013
79	13	2026-04-29 13:32:25.31344
71	13	2026-04-29 13:32:25.317867
88	13	2026-04-29 13:32:25.321485
49	13	2026-04-29 13:32:25.325491
40	13	2026-04-29 13:32:25.329308
56	13	2026-04-29 13:32:25.333604
11	13	2026-04-29 13:32:25.337574
86	13	2026-04-29 13:32:25.341557
14	13	2026-04-29 13:32:25.345317
1	14	2026-04-29 13:32:25.363713
13	14	2026-04-29 13:32:25.367895
18	14	2026-04-29 13:32:25.371905
79	14	2026-04-29 13:32:25.376123
26	14	2026-04-29 13:32:25.380189
81	15	2026-04-29 13:32:25.408895
75	15	2026-04-29 13:32:25.412961
35	15	2026-04-29 13:32:25.416196
25	15	2026-04-29 13:32:25.418933
53	15	2026-04-29 13:32:25.422733
31	15	2026-04-29 13:32:25.426992
26	16	2026-04-29 13:32:25.469971
74	16	2026-04-29 13:32:25.473313
57	16	2026-04-29 13:32:25.477205
33	16	2026-04-29 13:32:25.480669
38	16	2026-04-29 13:32:25.485131
21	16	2026-04-29 13:32:25.488527
61	17	2026-04-29 13:32:25.516484
84	17	2026-04-29 13:32:25.519344
71	17	2026-04-29 13:32:25.52287
5	17	2026-04-29 13:32:25.526512
90	18	2026-04-29 13:32:25.542033
22	18	2026-04-29 13:32:25.546273
65	18	2026-04-29 13:32:25.550541
27	18	2026-04-29 13:32:25.554635
19	19	2026-04-29 13:32:25.60317
82	19	2026-04-29 13:32:25.60773
26	19	2026-04-29 13:32:25.613058
76	19	2026-04-29 13:32:25.617809
85	19	2026-04-29 13:32:25.622469
17	19	2026-04-29 13:32:25.627166
60	19	2026-04-29 13:32:25.631863
45	19	2026-04-29 13:32:25.635688
11	19	2026-04-29 13:32:25.6398
47	19	2026-04-29 13:32:25.643785
13	20	2026-04-29 13:32:25.67757
88	20	2026-04-29 13:32:25.681909
86	20	2026-04-29 13:32:25.686552
58	20	2026-04-29 13:32:25.691354
56	21	2026-04-29 13:32:25.716633
71	21	2026-04-29 13:32:25.720992
78	21	2026-04-29 13:32:25.725927
64	21	2026-04-29 13:32:25.731179
74	21	2026-04-29 13:32:25.734766
28	21	2026-04-29 13:32:25.738253
43	21	2026-04-29 13:32:25.742283
52	21	2026-04-29 13:32:25.746955
40	21	2026-04-29 13:32:25.751282
30	22	2026-04-29 13:32:25.793772
100	22	2026-04-29 13:32:25.797632
74	22	2026-04-29 13:32:25.800684
16	22	2026-04-29 13:32:25.804461
46	22	2026-04-29 13:32:25.808089
99	22	2026-04-29 13:32:25.811651
34	22	2026-04-29 13:32:25.816854
17	22	2026-04-29 13:32:25.821417
92	22	2026-04-29 13:32:25.826277
98	22	2026-04-29 13:32:25.831522
36	23	2026-04-29 13:32:25.856897
100	23	2026-04-29 13:32:25.861331
69	23	2026-04-29 13:32:25.869368
93	23	2026-04-29 13:32:25.874025
83	23	2026-04-29 13:32:25.878365
84	23	2026-04-29 13:32:25.882654
81	23	2026-04-29 13:32:25.885913
16	23	2026-04-29 13:32:25.889034
22	23	2026-04-29 13:32:25.892688
40	23	2026-04-29 13:32:25.898128
66	24	2026-04-29 13:32:25.920765
68	24	2026-04-29 13:32:25.924989
2	24	2026-04-29 13:32:25.928858
97	24	2026-04-29 13:32:25.9327
93	24	2026-04-29 13:32:25.937775
56	25	2026-04-29 13:32:25.959838
4	25	2026-04-29 13:32:25.964118
80	25	2026-04-29 13:32:25.967592
98	25	2026-04-29 13:32:25.97029
78	25	2026-04-29 13:32:25.973451
12	25	2026-04-29 13:32:25.977344
11	25	2026-04-29 13:32:25.980546
20	25	2026-04-29 13:32:25.983742
33	25	2026-04-29 13:32:25.986634
41	26	2026-04-29 13:32:25.998751
89	26	2026-04-29 13:32:26.002461
5	26	2026-04-29 13:32:26.005344
43	26	2026-04-29 13:32:26.008924
15	26	2026-04-29 13:32:26.012523
9	26	2026-04-29 13:32:26.015494
11	27	2026-04-29 13:32:26.04741
21	27	2026-04-29 13:32:26.05071
79	27	2026-04-29 13:32:26.054829
13	27	2026-04-29 13:32:26.058564
33	28	2026-04-29 13:32:26.082531
76	28	2026-04-29 13:32:26.086373
16	29	2026-04-29 13:32:26.120322
99	29	2026-04-29 13:32:26.124529
38	29	2026-04-29 13:32:26.127632
3	29	2026-04-29 13:32:26.130908
96	30	2026-04-29 13:32:26.165656
47	30	2026-04-29 13:32:26.168795
84	30	2026-04-29 13:32:26.172128
88	30	2026-04-29 13:32:26.175276
44	30	2026-04-29 13:32:26.178828
66	30	2026-04-29 13:32:26.182235
2	30	2026-04-29 13:32:26.185926
79	30	2026-04-29 13:32:26.190328
26	30	2026-04-29 13:32:26.194189
82	30	2026-04-29 13:32:26.198147
66	31	2026-04-29 13:32:26.247075
49	31	2026-04-29 13:32:26.250674
16	31	2026-04-29 13:32:26.254153
5	31	2026-04-29 13:32:26.257651
65	31	2026-04-29 13:32:26.261348
94	31	2026-04-29 13:32:26.265491
89	31	2026-04-29 13:32:26.269329
19	31	2026-04-29 13:32:26.273565
21	31	2026-04-29 13:32:26.27619
46	32	2026-04-29 13:32:26.31582
80	32	2026-04-29 13:32:26.320962
16	32	2026-04-29 13:32:26.325545
78	33	2026-04-29 13:32:26.344931
86	33	2026-04-29 13:32:26.348409
23	33	2026-04-29 13:32:26.351665
98	34	2026-04-29 13:32:26.400817
60	34	2026-04-29 13:32:26.404811
47	34	2026-04-29 13:32:26.408643
15	34	2026-04-29 13:32:26.413378
35	34	2026-04-29 13:32:26.417736
24	34	2026-04-29 13:32:26.421782
84	34	2026-04-29 13:32:26.426081
33	35	2026-04-29 13:32:26.448581
36	35	2026-04-29 13:32:26.451475
67	35	2026-04-29 13:32:26.454759
24	35	2026-04-29 13:32:26.458541
77	36	2026-04-29 13:32:26.505392
31	36	2026-04-29 13:32:26.507892
40	36	2026-04-29 13:32:26.5164
35	36	2026-04-29 13:32:26.52102
17	36	2026-04-29 13:32:26.524595
12	36	2026-04-29 13:32:26.528287
39	36	2026-04-29 13:32:26.532368
81	36	2026-04-29 13:32:26.536703
41	37	2026-04-29 13:32:26.568593
34	37	2026-04-29 13:32:26.574771
49	37	2026-04-29 13:32:26.578895
23	37	2026-04-29 13:32:26.583519
12	37	2026-04-29 13:32:26.586975
85	37	2026-04-29 13:32:26.589499
42	37	2026-04-29 13:32:26.592519
18	37	2026-04-29 13:32:26.59628
36	38	2026-04-29 13:32:26.641467
88	38	2026-04-29 13:32:26.644925
23	38	2026-04-29 13:32:26.647597
30	38	2026-04-29 13:32:26.651408
89	38	2026-04-29 13:32:26.655187
69	39	2026-04-29 13:32:26.684836
61	39	2026-04-29 13:32:26.688359
23	39	2026-04-29 13:32:26.691326
5	39	2026-04-29 13:32:26.694955
79	40	2026-04-29 13:32:26.736901
1	40	2026-04-29 13:32:26.741048
45	40	2026-04-29 13:32:26.745342
60	40	2026-04-29 13:32:26.749791
72	40	2026-04-29 13:32:26.75463
32	40	2026-04-29 13:32:26.757885
12	40	2026-04-29 13:32:26.761518
6	40	2026-04-29 13:32:26.765465
75	40	2026-04-29 13:32:26.769016
15	41	2026-04-29 13:32:26.801615
6	41	2026-04-29 13:32:26.80587
74	41	2026-04-29 13:32:26.810168
75	41	2026-04-29 13:32:26.815126
60	41	2026-04-29 13:32:26.820451
25	41	2026-04-29 13:32:26.824663
77	42	2026-04-29 13:32:26.856572
83	42	2026-04-29 13:32:26.859868
59	42	2026-04-29 13:32:26.863795
67	42	2026-04-29 13:32:26.866406
19	42	2026-04-29 13:32:26.869557
89	43	2026-04-29 13:32:26.894628
69	43	2026-04-29 13:32:26.898677
7	43	2026-04-29 13:32:26.904613
43	43	2026-04-29 13:32:26.908578
14	43	2026-04-29 13:32:26.912172
56	43	2026-04-29 13:32:26.915891
94	43	2026-04-29 13:32:26.919603
22	43	2026-04-29 13:32:26.923751
33	44	2026-04-29 13:32:26.958349
9	44	2026-04-29 13:32:26.96199
83	44	2026-04-29 13:32:26.966703
96	45	2026-04-29 13:32:26.980151
70	45	2026-04-29 13:32:26.984191
63	45	2026-04-29 13:32:26.987968
52	45	2026-04-29 13:32:26.991096
34	45	2026-04-29 13:32:26.995754
83	45	2026-04-29 13:32:26.999408
81	45	2026-04-29 13:32:27.003581
32	45	2026-04-29 13:32:27.008133
2	45	2026-04-29 13:32:27.012869
65	45	2026-04-29 13:32:27.017034
100	46	2026-04-29 13:32:27.046172
21	46	2026-04-29 13:32:27.051951
88	46	2026-04-29 13:32:27.05736
40	46	2026-04-29 13:32:27.06248
81	47	2026-04-29 13:32:27.084906
42	47	2026-04-29 13:32:27.088973
41	47	2026-04-29 13:32:27.094086
100	48	2026-04-29 13:32:27.116674
57	48	2026-04-29 13:32:27.121633
86	49	2026-04-29 13:32:27.154372
88	49	2026-04-29 13:32:27.158599
42	49	2026-04-29 13:32:27.162942
25	49	2026-04-29 13:32:27.166971
92	49	2026-04-29 13:32:27.171915
12	49	2026-04-29 13:32:27.17623
33	49	2026-04-29 13:32:27.182053
54	49	2026-04-29 13:32:27.187771
82	49	2026-04-29 13:32:27.193068
26	50	2026-04-29 13:32:27.249188
20	50	2026-04-29 13:32:27.253658
13	50	2026-04-29 13:32:27.258663
29	51	2026-04-29 13:32:27.292493
46	51	2026-04-29 13:32:27.296375
45	51	2026-04-29 13:32:27.299231
39	51	2026-04-29 13:32:27.302181
32	51	2026-04-29 13:32:27.306053
69	51	2026-04-29 13:32:27.309651
28	51	2026-04-29 13:32:27.313061
3	51	2026-04-29 13:32:27.316531
40	52	2026-04-29 13:32:27.338725
2	52	2026-04-29 13:32:27.341763
62	52	2026-04-29 13:32:27.345363
9	52	2026-04-29 13:32:27.348412
68	52	2026-04-29 13:32:27.35196
16	52	2026-04-29 13:32:27.355678
48	52	2026-04-29 13:32:27.358828
4	52	2026-04-29 13:32:27.362112
40	53	2026-04-29 13:32:27.390831
53	53	2026-04-29 13:32:27.394992
100	53	2026-04-29 13:32:27.399589
86	53	2026-04-29 13:32:27.403388
60	53	2026-04-29 13:32:27.407033
77	53	2026-04-29 13:32:27.410736
81	53	2026-04-29 13:32:27.414605
35	53	2026-04-29 13:32:27.41845
12	54	2026-04-29 13:32:27.447542
91	54	2026-04-29 13:32:27.451619
11	54	2026-04-29 13:32:27.455636
93	54	2026-04-29 13:32:27.459052
84	55	2026-04-29 13:32:27.476292
27	55	2026-04-29 13:32:27.48019
95	56	2026-04-29 13:32:27.513531
9	56	2026-04-29 13:32:27.517365
30	56	2026-04-29 13:32:27.521318
70	56	2026-04-29 13:32:27.525507
48	56	2026-04-29 13:32:27.528788
61	56	2026-04-29 13:32:27.531704
49	56	2026-04-29 13:32:27.534862
79	56	2026-04-29 13:32:27.538687
78	56	2026-04-29 13:32:27.541784
71	56	2026-04-29 13:32:27.544568
80	57	2026-04-29 13:32:27.57092
48	57	2026-04-29 13:32:27.574273
57	57	2026-04-29 13:32:27.576982
55	57	2026-04-29 13:32:27.57952
26	57	2026-04-29 13:32:27.582808
69	57	2026-04-29 13:32:27.586501
89	58	2026-04-29 13:32:27.609153
87	58	2026-04-29 13:32:27.611945
60	58	2026-04-29 13:32:27.616869
22	58	2026-04-29 13:32:27.6208
77	58	2026-04-29 13:32:27.624337
40	58	2026-04-29 13:32:27.626911
51	58	2026-04-29 13:32:27.629824
46	59	2026-04-29 13:32:27.656699
16	59	2026-04-29 13:32:27.660428
84	60	2026-04-29 13:32:27.685586
99	60	2026-04-29 13:32:27.690337
33	61	2026-04-29 13:32:27.728059
87	61	2026-04-29 13:32:27.732005
51	62	2026-04-29 13:32:27.748515
37	62	2026-04-29 13:32:27.752156
11	62	2026-04-29 13:32:27.755864
50	62	2026-04-29 13:32:27.759818
4	62	2026-04-29 13:32:27.76404
87	63	2026-04-29 13:32:27.7979
10	63	2026-04-29 13:32:27.801921
80	63	2026-04-29 13:32:27.805522
92	63	2026-04-29 13:32:27.80854
89	63	2026-04-29 13:32:27.811545
90	63	2026-04-29 13:32:27.814791
53	63	2026-04-29 13:32:27.818597
38	63	2026-04-29 13:32:27.822173
77	63	2026-04-29 13:32:27.826495
29	64	2026-04-29 13:32:27.856551
82	64	2026-04-29 13:32:27.860058
32	64	2026-04-29 13:32:27.864503
19	64	2026-04-29 13:32:27.867829
75	64	2026-04-29 13:32:27.87062
94	64	2026-04-29 13:32:27.874314
6	65	2026-04-29 13:32:27.908899
29	65	2026-04-29 13:32:27.913145
89	65	2026-04-29 13:32:27.920783
65	65	2026-04-29 13:32:27.924724
33	65	2026-04-29 13:32:27.928175
12	66	2026-04-29 13:32:27.952218
45	66	2026-04-29 13:32:27.955713
64	66	2026-04-29 13:32:27.95889
43	66	2026-04-29 13:32:27.962057
32	66	2026-04-29 13:32:27.965293
71	66	2026-04-29 13:32:27.969473
80	66	2026-04-29 13:32:27.973408
53	67	2026-04-29 13:32:28.022278
76	67	2026-04-29 13:32:28.025615
65	67	2026-04-29 13:32:28.028628
23	67	2026-04-29 13:32:28.031788
33	67	2026-04-29 13:32:28.03695
6	67	2026-04-29 13:32:28.043007
38	67	2026-04-29 13:32:28.046555
79	68	2026-04-29 13:32:28.086535
58	68	2026-04-29 13:32:28.091632
13	68	2026-04-29 13:32:28.095582
29	68	2026-04-29 13:32:28.101523
54	68	2026-04-29 13:32:28.106149
18	68	2026-04-29 13:32:28.109914
2	68	2026-04-29 13:32:28.116195
62	69	2026-04-29 13:32:28.162498
92	69	2026-04-29 13:32:28.168549
77	69	2026-04-29 13:32:28.17283
44	69	2026-04-29 13:32:28.177175
53	70	2026-04-29 13:32:28.204132
69	70	2026-04-29 13:32:28.208884
30	70	2026-04-29 13:32:28.212988
47	70	2026-04-29 13:32:28.217482
10	70	2026-04-29 13:32:28.221319
24	71	2026-04-29 13:32:28.254899
62	71	2026-04-29 13:32:28.258065
20	71	2026-04-29 13:32:28.262324
29	72	2026-04-29 13:32:28.303317
58	72	2026-04-29 13:32:28.307188
95	72	2026-04-29 13:32:28.309935
95	73	2026-04-29 13:32:28.35645
65	73	2026-04-29 13:32:28.360076
88	73	2026-04-29 13:32:28.364505
11	73	2026-04-29 13:32:28.368093
24	73	2026-04-29 13:32:28.371095
71	73	2026-04-29 13:32:28.374432
29	73	2026-04-29 13:32:28.377761
92	73	2026-04-29 13:32:28.38193
63	74	2026-04-29 13:32:28.417711
71	74	2026-04-29 13:32:28.422565
5	74	2026-04-29 13:32:28.427151
11	74	2026-04-29 13:32:28.431617
4	74	2026-04-29 13:32:28.435535
39	74	2026-04-29 13:32:28.439903
62	74	2026-04-29 13:32:28.443279
38	74	2026-04-29 13:32:28.446708
60	75	2026-04-29 13:32:28.47283
18	75	2026-04-29 13:32:28.476618
75	75	2026-04-29 13:32:28.480455
39	75	2026-04-29 13:32:28.484466
84	75	2026-04-29 13:32:28.489309
11	75	2026-04-29 13:32:28.493621
79	75	2026-04-29 13:32:28.498406
5	75	2026-04-29 13:32:28.502894
9	75	2026-04-29 13:32:28.506545
39	76	2026-04-29 13:32:28.532222
96	76	2026-04-29 13:32:28.536176
69	76	2026-04-29 13:32:28.541551
62	77	2026-04-29 13:32:28.570318
43	77	2026-04-29 13:32:28.573809
78	77	2026-04-29 13:32:28.578197
30	77	2026-04-29 13:32:28.582042
49	77	2026-04-29 13:32:28.585847
28	77	2026-04-29 13:32:28.591563
84	77	2026-04-29 13:32:28.595973
12	78	2026-04-29 13:32:28.647721
77	78	2026-04-29 13:32:28.651144
16	78	2026-04-29 13:32:28.654818
86	78	2026-04-29 13:32:28.657719
25	78	2026-04-29 13:32:28.66042
75	78	2026-04-29 13:32:28.664331
15	78	2026-04-29 13:32:28.668408
44	78	2026-04-29 13:32:28.671503
66	79	2026-04-29 13:32:28.70534
24	79	2026-04-29 13:32:28.709051
76	79	2026-04-29 13:32:28.712667
94	79	2026-04-29 13:32:28.716373
99	80	2026-04-29 13:32:28.741842
13	80	2026-04-29 13:32:28.745994
53	80	2026-04-29 13:32:28.749191
81	80	2026-04-29 13:32:28.752743
64	80	2026-04-29 13:32:28.756824
23	80	2026-04-29 13:32:28.761685
47	80	2026-04-29 13:32:28.766478
54	81	2026-04-29 13:32:28.793508
12	81	2026-04-29 13:32:28.795742
90	81	2026-04-29 13:32:28.798034
23	81	2026-04-29 13:32:28.80021
28	81	2026-04-29 13:32:28.804021
95	81	2026-04-29 13:32:28.80745
42	81	2026-04-29 13:32:28.811186
80	82	2026-04-29 13:32:28.831642
76	82	2026-04-29 13:32:28.836189
98	82	2026-04-29 13:32:28.840887
5	82	2026-04-29 13:32:28.845933
46	82	2026-04-29 13:32:28.849888
43	82	2026-04-29 13:32:28.854823
50	82	2026-04-29 13:32:28.858875
87	82	2026-04-29 13:32:28.863153
61	83	2026-04-29 13:32:28.908653
72	83	2026-04-29 13:32:28.912413
14	83	2026-04-29 13:32:28.916086
71	83	2026-04-29 13:32:28.919716
10	83	2026-04-29 13:32:28.922722
42	83	2026-04-29 13:32:28.926266
35	84	2026-04-29 13:32:28.942134
86	84	2026-04-29 13:32:28.945712
26	84	2026-04-29 13:32:28.949282
68	84	2026-04-29 13:32:28.952749
60	85	2026-04-29 13:32:28.987574
89	85	2026-04-29 13:32:28.992131
45	85	2026-04-29 13:32:28.997927
13	85	2026-04-29 13:32:29.002319
27	85	2026-04-29 13:32:29.006659
49	85	2026-04-29 13:32:29.010899
90	85	2026-04-29 13:32:29.015288
12	86	2026-04-29 13:32:29.048552
9	86	2026-04-29 13:32:29.052111
77	86	2026-04-29 13:32:29.056017
48	86	2026-04-29 13:32:29.058486
96	86	2026-04-29 13:32:29.060991
6	86	2026-04-29 13:32:29.064255
84	86	2026-04-29 13:32:29.06673
18	86	2026-04-29 13:32:29.070875
47	86	2026-04-29 13:32:29.075178
53	86	2026-04-29 13:32:29.078262
53	87	2026-04-29 13:32:29.105839
93	87	2026-04-29 13:32:29.108715
35	87	2026-04-29 13:32:29.112608
71	87	2026-04-29 13:32:29.115689
8	87	2026-04-29 13:32:29.118165
31	87	2026-04-29 13:32:29.120397
53	88	2026-04-29 13:32:29.137655
56	88	2026-04-29 13:32:29.140348
43	88	2026-04-29 13:32:29.143629
60	88	2026-04-29 13:32:29.148057
52	88	2026-04-29 13:32:29.151959
7	88	2026-04-29 13:32:29.155498
20	88	2026-04-29 13:32:29.15892
96	88	2026-04-29 13:32:29.162723
46	89	2026-04-29 13:32:29.197053
37	89	2026-04-29 13:32:29.20048
22	89	2026-04-29 13:32:29.204746
26	89	2026-04-29 13:32:29.208732
88	89	2026-04-29 13:32:29.212626
4	89	2026-04-29 13:32:29.217146
6	89	2026-04-29 13:32:29.220122
23	89	2026-04-29 13:32:29.223982
94	90	2026-04-29 13:32:29.254026
73	90	2026-04-29 13:32:29.256794
69	90	2026-04-29 13:32:29.259633
11	90	2026-04-29 13:32:29.26289
43	90	2026-04-29 13:32:29.265973
99	91	2026-04-29 13:32:29.304279
68	91	2026-04-29 13:32:29.308596
39	91	2026-04-29 13:32:29.312749
8	91	2026-04-29 13:32:29.315995
53	91	2026-04-29 13:32:29.31967
11	91	2026-04-29 13:32:29.322957
81	91	2026-04-29 13:32:29.326681
51	91	2026-04-29 13:32:29.330058
86	91	2026-04-29 13:32:29.333077
31	91	2026-04-29 13:32:29.337253
10	92	2026-04-29 13:32:29.376046
76	92	2026-04-29 13:32:29.378724
47	92	2026-04-29 13:32:29.381751
33	92	2026-04-29 13:32:29.385083
56	92	2026-04-29 13:32:29.387626
49	92	2026-04-29 13:32:29.391308
36	92	2026-04-29 13:32:29.395332
43	93	2026-04-29 13:32:29.42799
39	93	2026-04-29 13:32:29.432294
71	94	2026-04-29 13:32:29.450121
65	94	2026-04-29 13:32:29.454985
35	94	2026-04-29 13:32:29.459831
100	94	2026-04-29 13:32:29.463203
32	94	2026-04-29 13:32:29.466759
93	95	2026-04-29 13:32:29.494497
63	95	2026-04-29 13:32:29.502294
46	95	2026-04-29 13:32:29.506707
67	96	2026-04-29 13:32:29.537353
62	96	2026-04-29 13:32:29.540528
84	96	2026-04-29 13:32:29.546771
34	96	2026-04-29 13:32:29.552504
1	96	2026-04-29 13:32:29.556964
16	97	2026-04-29 13:32:29.581754
44	97	2026-04-29 13:32:29.585848
60	97	2026-04-29 13:32:29.588469
43	97	2026-04-29 13:32:29.59207
88	97	2026-04-29 13:32:29.595628
2	97	2026-04-29 13:32:29.598628
69	97	2026-04-29 13:32:29.60238
38	97	2026-04-29 13:32:29.605773
44	98	2026-04-29 13:32:29.635163
94	98	2026-04-29 13:32:29.638578
11	99	2026-04-29 13:32:29.668621
19	99	2026-04-29 13:32:29.672728
66	99	2026-04-29 13:32:29.67615
31	99	2026-04-29 13:32:29.679146
62	99	2026-04-29 13:32:29.682668
38	99	2026-04-29 13:32:29.685653
36	99	2026-04-29 13:32:29.688399
95	99	2026-04-29 13:32:29.690872
86	99	2026-04-29 13:32:29.69374
31	100	2026-04-29 13:32:29.726297
23	100	2026-04-29 13:32:29.729501
24	100	2026-04-29 13:32:29.732621
88	100	2026-04-29 13:32:29.735173
25	100	2026-04-29 13:32:29.737993
52	100	2026-04-29 13:32:29.741643
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.migrations (id, "timestamp", name) FROM stdin;
1	1775741091591	InitSchema1775741091591
2	1777468755523	SoftDeleteUser1777468755523
3	1777814166887	FixIndexes1777814166887
\.


--
-- Data for Name: post_hashtags; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.post_hashtags (post_id, hashtag_id) FROM stdin;
1	17
1	13
2	1
2	6
3	9
3	8
3	4
4	3
4	16
4	10
5	17
5	13
6	11
6	15
7	7
7	5
7	9
8	15
8	1
8	11
9	11
10	8
10	1
10	13
11	16
11	18
11	1
12	14
12	3
13	19
13	2
14	14
15	19
15	16
15	15
16	20
16	10
17	15
17	10
17	9
18	7
18	4
19	13
19	9
20	14
20	3
21	3
22	8
22	1
22	3
23	13
23	20
23	9
24	20
24	9
25	19
26	11
26	20
27	17
28	2
29	8
29	4
29	9
30	17
30	16
30	5
31	5
31	20
32	18
32	5
32	13
33	14
33	8
34	12
34	17
35	14
36	19
36	1
36	17
37	14
37	6
38	19
39	16
39	8
39	19
40	15
40	2
40	7
41	13
42	19
42	13
42	18
43	13
43	6
43	19
44	12
45	6
45	12
46	3
46	8
46	18
47	19
47	12
48	6
49	11
49	2
49	18
50	10
50	16
51	6
52	7
53	19
54	5
55	10
56	4
57	13
57	16
57	2
58	1
58	20
59	4
59	6
60	15
61	12
61	6
61	9
62	9
63	6
64	9
64	2
65	6
65	5
65	14
66	18
66	20
67	10
67	5
67	2
68	15
68	7
68	1
69	14
69	4
69	8
70	1
70	14
71	20
71	5
72	14
72	2
73	6
74	14
74	8
75	10
76	11
76	6
77	6
77	9
77	2
78	19
78	9
78	18
79	8
79	13
79	18
80	7
80	18
80	2
81	17
81	16
82	13
82	17
83	6
83	15
83	3
84	3
84	15
84	8
85	2
85	17
86	8
86	13
87	2
87	4
87	14
88	6
89	6
89	12
89	18
90	3
90	10
90	11
91	17
91	14
91	20
92	19
92	10
92	2
93	10
93	5
93	18
94	20
94	12
95	8
96	2
96	17
96	10
97	6
98	14
99	2
99	5
99	16
100	6
100	7
100	10
\.


--
-- Data for Name: post_media; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.post_media (id, media_url, media_type, sequence_order, created_at, post_id) FROM stdin;
1	https://picsum.photos/seed/7xeuA2cVmu/640/480	video	1	2026-04-29 13:32:23.787763	1
2	https://picsum.photos/seed/yC2kB/640/480	video	1	2026-04-29 13:32:23.792786	2
3	https://picsum.photos/seed/gMQ0lKVQH/640/480	image	2	2026-04-29 13:32:23.796767	2
4	https://picsum.photos/seed/2auipT/640/480	video	1	2026-04-29 13:32:23.800926	3
5	https://picsum.photos/seed/3BafXPV/640/480	video	2	2026-04-29 13:32:23.805215	3
6	https://picsum.photos/seed/6Prkh4aoe/640/480	image	3	2026-04-29 13:32:23.810822	3
7	https://picsum.photos/seed/Epbd7XI/640/480	image	1	2026-04-29 13:32:23.81635	4
8	https://picsum.photos/seed/kkZnou00/640/480	video	2	2026-04-29 13:32:23.820865	4
9	https://picsum.photos/seed/e9qE5MpFK/640/480	image	3	2026-04-29 13:32:23.824731	4
10	https://picsum.photos/seed/LrBX12EFH/640/480	video	1	2026-04-29 13:32:23.828677	5
11	https://picsum.photos/seed/7bxJ0ZP/640/480	video	2	2026-04-29 13:32:23.831506	5
12	https://picsum.photos/seed/vPvOo/640/480	image	3	2026-04-29 13:32:23.834122	5
13	https://picsum.photos/seed/ssjuYY5i7/640/480	image	1	2026-04-29 13:32:23.83656	6
14	https://picsum.photos/seed/a4lqyNv/640/480	image	2	2026-04-29 13:32:23.838838	6
15	https://picsum.photos/seed/CGKr4e/640/480	image	3	2026-04-29 13:32:23.841608	6
16	https://picsum.photos/seed/QIHtV6/640/480	video	4	2026-04-29 13:32:23.84531	6
17	https://picsum.photos/seed/0adTO/640/480	image	1	2026-04-29 13:32:23.847566	7
18	https://picsum.photos/seed/f14jP/640/480	image	1	2026-04-29 13:32:23.849663	8
19	https://picsum.photos/seed/2ccLae/640/480	image	2	2026-04-29 13:32:23.8521	8
20	https://picsum.photos/seed/0K7mhh3i/640/480	image	3	2026-04-29 13:32:23.854673	8
21	https://picsum.photos/seed/IdiFzJuw/640/480	image	4	2026-04-29 13:32:23.857032	8
22	https://picsum.photos/seed/iBEOJPA/640/480	image	1	2026-04-29 13:32:23.859393	9
23	https://picsum.photos/seed/Kgo1M/640/480	image	2	2026-04-29 13:32:23.861567	9
24	https://picsum.photos/seed/HaSQHCnZAU/640/480	video	3	2026-04-29 13:32:23.864116	9
25	https://picsum.photos/seed/1iGqTe/640/480	video	4	2026-04-29 13:32:23.866494	9
26	https://picsum.photos/seed/0PHUoE8n8P/640/480	video	5	2026-04-29 13:32:23.868647	9
27	https://picsum.photos/seed/8KtTlhq0Pk/640/480	video	1	2026-04-29 13:32:23.870748	10
28	https://picsum.photos/seed/ecLKKmTwr/640/480	image	2	2026-04-29 13:32:23.87298	10
29	https://picsum.photos/seed/smhTkUAFJ/640/480	image	3	2026-04-29 13:32:23.876247	10
30	https://picsum.photos/seed/4Pvj4k/640/480	image	1	2026-04-29 13:32:23.879636	11
31	https://picsum.photos/seed/DjKla/640/480	video	2	2026-04-29 13:32:23.88235	11
32	https://picsum.photos/seed/S456r/640/480	video	3	2026-04-29 13:32:23.884975	11
33	https://picsum.photos/seed/PC7na9nTYe/640/480	image	4	2026-04-29 13:32:23.88745	11
34	https://picsum.photos/seed/dw7hBzsTKo/640/480	image	1	2026-04-29 13:32:23.890271	12
35	https://picsum.photos/seed/UIwC0mx/640/480	video	2	2026-04-29 13:32:23.893745	12
36	https://picsum.photos/seed/00Yes83/640/480	video	3	2026-04-29 13:32:23.896109	12
37	https://picsum.photos/seed/RqekfrP/640/480	image	1	2026-04-29 13:32:23.898367	13
38	https://picsum.photos/seed/QExgI/640/480	video	2	2026-04-29 13:32:23.900629	13
39	https://picsum.photos/seed/hYBq8xw/640/480	video	3	2026-04-29 13:32:23.902969	13
40	https://picsum.photos/seed/K8eCD/640/480	image	4	2026-04-29 13:32:23.906249	13
41	https://picsum.photos/seed/G2E2QImDT/640/480	video	5	2026-04-29 13:32:23.909376	13
42	https://picsum.photos/seed/DKJStE/640/480	image	1	2026-04-29 13:32:23.912703	14
43	https://picsum.photos/seed/6XzEmYN/640/480	video	2	2026-04-29 13:32:23.914985	14
44	https://picsum.photos/seed/GTuU8g2CR/640/480	image	3	2026-04-29 13:32:23.917271	14
45	https://picsum.photos/seed/j62HFR8SeM/640/480	image	4	2026-04-29 13:32:23.919514	14
46	https://picsum.photos/seed/4TfPhjnAD/640/480	video	1	2026-04-29 13:32:23.922218	15
47	https://picsum.photos/seed/vjHfG/640/480	video	2	2026-04-29 13:32:23.925028	15
48	https://picsum.photos/seed/dvFLOT6AN/640/480	image	3	2026-04-29 13:32:23.927212	15
49	https://picsum.photos/seed/V7sHeLQMSl/640/480	video	4	2026-04-29 13:32:23.929672	15
50	https://picsum.photos/seed/0oCnTNVMMA/640/480	video	1	2026-04-29 13:32:23.93295	16
51	https://picsum.photos/seed/QwqD0mYgt/640/480	image	2	2026-04-29 13:32:23.936223	16
52	https://picsum.photos/seed/XTTX8d/640/480	video	1	2026-04-29 13:32:23.938788	17
53	https://picsum.photos/seed/VrqvB/640/480	image	2	2026-04-29 13:32:23.941988	17
54	https://picsum.photos/seed/7MpBGfXx8/640/480	video	3	2026-04-29 13:32:23.944692	17
55	https://picsum.photos/seed/WmKhMT/640/480	video	1	2026-04-29 13:32:23.947496	18
56	https://picsum.photos/seed/CIQJl5JD4/640/480	image	2	2026-04-29 13:32:23.949747	18
57	https://picsum.photos/seed/5chQYXp8T/640/480	video	1	2026-04-29 13:32:23.952362	19
58	https://picsum.photos/seed/MpFaGZuPF/640/480	image	1	2026-04-29 13:32:23.954671	20
59	https://picsum.photos/seed/8URUbt/640/480	video	1	2026-04-29 13:32:23.957122	21
60	https://picsum.photos/seed/zzLDx3/640/480	video	2	2026-04-29 13:32:23.959528	21
61	https://picsum.photos/seed/QG1wbZH6xv/640/480	video	3	2026-04-29 13:32:23.962421	21
62	https://picsum.photos/seed/edsLvIU3C0/640/480	image	4	2026-04-29 13:32:23.965053	21
63	https://picsum.photos/seed/CWVB9ZX/640/480	image	5	2026-04-29 13:32:23.967139	21
64	https://picsum.photos/seed/JKzYZFwr/640/480	video	1	2026-04-29 13:32:23.969175	22
65	https://picsum.photos/seed/B6XnnsQ6/640/480	image	2	2026-04-29 13:32:23.971687	22
66	https://picsum.photos/seed/jBXuX/640/480	video	3	2026-04-29 13:32:23.974365	22
67	https://picsum.photos/seed/YFbX7zPeee/640/480	image	4	2026-04-29 13:32:23.976458	22
68	https://picsum.photos/seed/95Q8Nx/640/480	image	1	2026-04-29 13:32:23.978493	23
69	https://picsum.photos/seed/2B9Htny/640/480	image	2	2026-04-29 13:32:23.980975	23
70	https://picsum.photos/seed/BQcumg/640/480	video	1	2026-04-29 13:32:23.984676	24
71	https://picsum.photos/seed/zq0Sdl38/640/480	video	2	2026-04-29 13:32:23.987812	24
72	https://picsum.photos/seed/YHg9cEiJt/640/480	image	3	2026-04-29 13:32:23.990182	24
73	https://picsum.photos/seed/Gkqb0zlFXT/640/480	video	1	2026-04-29 13:32:23.993024	25
74	https://picsum.photos/seed/wOcq1/640/480	video	2	2026-04-29 13:32:23.995212	25
75	https://picsum.photos/seed/o5aCV27/640/480	image	1	2026-04-29 13:32:23.997512	26
76	https://picsum.photos/seed/pWMEX7m9J/640/480	image	1	2026-04-29 13:32:23.999712	27
77	https://picsum.photos/seed/gWlNstRM/640/480	video	2	2026-04-29 13:32:24.002833	27
78	https://picsum.photos/seed/QvYTE/640/480	image	3	2026-04-29 13:32:24.005112	27
79	https://picsum.photos/seed/d73PFnIkPh/640/480	video	4	2026-04-29 13:32:24.007394	27
80	https://picsum.photos/seed/H2Iu1z/640/480	video	5	2026-04-29 13:32:24.010376	27
81	https://picsum.photos/seed/JO5vOAR7RZ/640/480	video	1	2026-04-29 13:32:24.013119	28
82	https://picsum.photos/seed/LJfkq/640/480	image	1	2026-04-29 13:32:24.01522	29
83	https://picsum.photos/seed/0HCsM2/640/480	video	1	2026-04-29 13:32:24.01763	30
84	https://picsum.photos/seed/rWn95n5J89/640/480	image	2	2026-04-29 13:32:24.019787	30
85	https://picsum.photos/seed/Un5IMh/640/480	video	3	2026-04-29 13:32:24.022151	30
86	https://picsum.photos/seed/3UPcMjOXo3/640/480	image	1	2026-04-29 13:32:24.024559	31
87	https://picsum.photos/seed/HhEjcT/640/480	video	2	2026-04-29 13:32:24.026724	31
88	https://picsum.photos/seed/4sgaJJFV8/640/480	image	3	2026-04-29 13:32:24.029175	31
89	https://picsum.photos/seed/XtOyMsw/640/480	video	4	2026-04-29 13:32:24.032283	31
90	https://picsum.photos/seed/pa0tYUi/640/480	video	5	2026-04-29 13:32:24.034611	31
91	https://picsum.photos/seed/nAeLpeaxK/640/480	video	1	2026-04-29 13:32:24.037015	32
92	https://picsum.photos/seed/4qz6uqlzAz/640/480	image	2	2026-04-29 13:32:24.039267	32
93	https://picsum.photos/seed/wCP4OW9IJ/640/480	image	3	2026-04-29 13:32:24.041921	32
94	https://picsum.photos/seed/FzLEtC/640/480	video	4	2026-04-29 13:32:24.044307	32
95	https://picsum.photos/seed/bTiL2Q9pM/640/480	video	5	2026-04-29 13:32:24.046752	32
96	https://picsum.photos/seed/2oW3f/640/480	video	1	2026-04-29 13:32:24.049284	33
97	https://picsum.photos/seed/YErIXe1B/640/480	video	2	2026-04-29 13:32:24.052414	33
98	https://picsum.photos/seed/MC5l45cer/640/480	video	3	2026-04-29 13:32:24.055082	33
99	https://picsum.photos/seed/bnAA6Qdw/640/480	video	4	2026-04-29 13:32:24.058116	33
100	https://picsum.photos/seed/fxPryhUHdq/640/480	video	5	2026-04-29 13:32:24.060499	33
101	https://picsum.photos/seed/iUuV8/640/480	image	1	2026-04-29 13:32:24.063186	34
102	https://picsum.photos/seed/eEVo5sNd0/640/480	video	1	2026-04-29 13:32:24.065382	35
103	https://picsum.photos/seed/oUUBO/640/480	video	1	2026-04-29 13:32:24.067571	36
104	https://picsum.photos/seed/G9Cj76hl/640/480	image	2	2026-04-29 13:32:24.069924	36
105	https://picsum.photos/seed/zMleV9/640/480	image	1	2026-04-29 13:32:24.072808	37
106	https://picsum.photos/seed/VgQUuprc1/640/480	image	2	2026-04-29 13:32:24.075258	37
107	https://picsum.photos/seed/oVx6lichAE/640/480	image	3	2026-04-29 13:32:24.078592	37
108	https://picsum.photos/seed/2vlRUhRw/640/480	image	4	2026-04-29 13:32:24.082798	37
109	https://picsum.photos/seed/kc3pDjCTfD/640/480	image	5	2026-04-29 13:32:24.085703	37
110	https://picsum.photos/seed/0fOVBrDLA/640/480	image	1	2026-04-29 13:32:24.087897	38
111	https://picsum.photos/seed/OxoAWOLWV/640/480	image	2	2026-04-29 13:32:24.090297	38
112	https://picsum.photos/seed/BHHtQkNsQJ/640/480	image	3	2026-04-29 13:32:24.094264	38
113	https://picsum.photos/seed/Y7czigOY/640/480	video	1	2026-04-29 13:32:24.096639	39
114	https://picsum.photos/seed/wpLvoY7hu3/640/480	image	2	2026-04-29 13:32:24.099265	39
115	https://picsum.photos/seed/sZnkiVc1P6/640/480	video	3	2026-04-29 13:32:24.10342	39
116	https://picsum.photos/seed/2PM5FocU4/640/480	image	4	2026-04-29 13:32:24.10585	39
117	https://picsum.photos/seed/6EjpUcvpK1/640/480	image	5	2026-04-29 13:32:24.108334	39
118	https://picsum.photos/seed/B10oo/640/480	image	1	2026-04-29 13:32:24.111768	40
119	https://picsum.photos/seed/m6nNwcD/640/480	image	1	2026-04-29 13:32:24.114744	41
120	https://picsum.photos/seed/llV16qL/640/480	video	1	2026-04-29 13:32:24.117477	42
121	https://picsum.photos/seed/Di6YFKtm/640/480	image	2	2026-04-29 13:32:24.119638	42
122	https://picsum.photos/seed/5iiX9JTd/640/480	video	3	2026-04-29 13:32:24.122336	42
123	https://picsum.photos/seed/vd1WXl9/640/480	video	1	2026-04-29 13:32:24.124535	43
124	https://picsum.photos/seed/weEpUi/640/480	image	2	2026-04-29 13:32:24.127724	43
125	https://picsum.photos/seed/KmMC4wC/640/480	video	3	2026-04-29 13:32:24.130348	43
126	https://picsum.photos/seed/YwxjeQX/640/480	image	4	2026-04-29 13:32:24.133038	43
127	https://picsum.photos/seed/9avJP8QR/640/480	image	5	2026-04-29 13:32:24.136841	43
128	https://picsum.photos/seed/9kpa6/640/480	image	1	2026-04-29 13:32:24.140451	44
129	https://picsum.photos/seed/f6r8P/640/480	image	2	2026-04-29 13:32:24.144791	44
130	https://picsum.photos/seed/D2TSvUP/640/480	video	3	2026-04-29 13:32:24.14918	44
131	https://picsum.photos/seed/o8tzJO50/640/480	video	4	2026-04-29 13:32:24.152921	44
132	https://picsum.photos/seed/C1ShT3/640/480	image	1	2026-04-29 13:32:24.155901	45
133	https://picsum.photos/seed/ZTXbMdR/640/480	video	2	2026-04-29 13:32:24.160358	45
134	https://picsum.photos/seed/BAN9iftU/640/480	image	3	2026-04-29 13:32:24.164319	45
135	https://picsum.photos/seed/6UOa7WF0V/640/480	image	4	2026-04-29 13:32:24.167918	45
136	https://picsum.photos/seed/MBPtEhtwr/640/480	video	5	2026-04-29 13:32:24.170895	45
137	https://picsum.photos/seed/LQYzy/640/480	video	1	2026-04-29 13:32:24.174464	46
138	https://picsum.photos/seed/se5n0nqDEy/640/480	video	2	2026-04-29 13:32:24.178183	46
139	https://picsum.photos/seed/vezgaL0/640/480	image	3	2026-04-29 13:32:24.181669	46
140	https://picsum.photos/seed/CI1J3U/640/480	video	4	2026-04-29 13:32:24.186294	46
141	https://picsum.photos/seed/5S3YR3np/640/480	video	1	2026-04-29 13:32:24.189732	47
142	https://picsum.photos/seed/HGbWTZJ/640/480	image	2	2026-04-29 13:32:24.193186	47
143	https://picsum.photos/seed/5ctdOs9/640/480	image	3	2026-04-29 13:32:24.19678	47
144	https://picsum.photos/seed/Rt1EnIWLk/640/480	video	4	2026-04-29 13:32:24.200242	47
145	https://picsum.photos/seed/csu7o8cT/640/480	image	1	2026-04-29 13:32:24.203493	48
146	https://picsum.photos/seed/Wg08FTly/640/480	image	2	2026-04-29 13:32:24.206843	48
147	https://picsum.photos/seed/F2tfEkn/640/480	image	3	2026-04-29 13:32:24.210327	48
148	https://picsum.photos/seed/akEqj5PuO/640/480	video	1	2026-04-29 13:32:24.213749	49
149	https://picsum.photos/seed/xOhoCEvw/640/480	video	2	2026-04-29 13:32:24.216847	49
150	https://picsum.photos/seed/Nw39YL3/640/480	video	3	2026-04-29 13:32:24.219711	49
151	https://picsum.photos/seed/e88TrIuByi/640/480	image	4	2026-04-29 13:32:24.223434	49
152	https://picsum.photos/seed/qAPwi6/640/480	image	1	2026-04-29 13:32:24.226996	50
153	https://picsum.photos/seed/uXt8RxZCnF/640/480	image	1	2026-04-29 13:32:24.230688	51
154	https://picsum.photos/seed/PXi9R5n0/640/480	video	2	2026-04-29 13:32:24.234743	51
155	https://picsum.photos/seed/FsRtP6/640/480	image	3	2026-04-29 13:32:24.238389	51
156	https://picsum.photos/seed/FV302ddBuQ/640/480	image	4	2026-04-29 13:32:24.242162	51
157	https://picsum.photos/seed/jDxP7iomYi/640/480	video	5	2026-04-29 13:32:24.245096	51
158	https://picsum.photos/seed/WVqpFs56R/640/480	video	1	2026-04-29 13:32:24.247923	52
159	https://picsum.photos/seed/r7buAl/640/480	image	2	2026-04-29 13:32:24.251766	52
160	https://picsum.photos/seed/6r7Bsdj999/640/480	video	3	2026-04-29 13:32:24.255601	52
161	https://picsum.photos/seed/zKwekcwk/640/480	video	4	2026-04-29 13:32:24.259303	52
162	https://picsum.photos/seed/GFTaES2bH/640/480	video	5	2026-04-29 13:32:24.262979	52
163	https://picsum.photos/seed/gPjXw6X34/640/480	image	1	2026-04-29 13:32:24.267545	53
164	https://picsum.photos/seed/v2fITX/640/480	video	1	2026-04-29 13:32:24.271009	54
165	https://picsum.photos/seed/lbDR2P/640/480	image	2	2026-04-29 13:32:24.274187	54
166	https://picsum.photos/seed/WqHLte8/640/480	image	3	2026-04-29 13:32:24.278277	54
167	https://picsum.photos/seed/AiEn62/640/480	image	4	2026-04-29 13:32:24.281684	54
168	https://picsum.photos/seed/YLUDuu3/640/480	video	1	2026-04-29 13:32:24.284308	55
169	https://picsum.photos/seed/EfRqSl/640/480	image	2	2026-04-29 13:32:24.286426	55
170	https://picsum.photos/seed/Y47K0Y5Iu/640/480	image	3	2026-04-29 13:32:24.288818	55
171	https://picsum.photos/seed/2T1ifhLbNg/640/480	video	4	2026-04-29 13:32:24.292123	55
172	https://picsum.photos/seed/GOOr0/640/480	video	5	2026-04-29 13:32:24.294518	55
173	https://picsum.photos/seed/Up2P9K4/640/480	image	1	2026-04-29 13:32:24.300833	56
174	https://picsum.photos/seed/rstf8LZQvY/640/480	video	1	2026-04-29 13:32:24.303304	57
175	https://picsum.photos/seed/sorM9Yc8/640/480	video	2	2026-04-29 13:32:24.305867	57
176	https://picsum.photos/seed/ee9HzXFH/640/480	image	3	2026-04-29 13:32:24.308353	57
177	https://picsum.photos/seed/pS5WP0/640/480	video	4	2026-04-29 13:32:24.311345	57
178	https://picsum.photos/seed/x8WFgBb5/640/480	video	5	2026-04-29 13:32:24.31356	57
179	https://picsum.photos/seed/oDBDTx/640/480	image	1	2026-04-29 13:32:24.315524	58
180	https://picsum.photos/seed/GYHkLU/640/480	image	2	2026-04-29 13:32:24.31745	58
181	https://picsum.photos/seed/u82jIZIE/640/480	video	1	2026-04-29 13:32:24.319703	59
182	https://picsum.photos/seed/Qg2WJfPkkX/640/480	image	2	2026-04-29 13:32:24.321945	59
183	https://picsum.photos/seed/EID7H/640/480	image	3	2026-04-29 13:32:24.324793	59
184	https://picsum.photos/seed/4lGRTB/640/480	image	4	2026-04-29 13:32:24.331821	59
185	https://picsum.photos/seed/zTBBCn/640/480	video	1	2026-04-29 13:32:24.334055	60
186	https://picsum.photos/seed/nUeQFnQ9Zp/640/480	image	1	2026-04-29 13:32:24.336068	61
187	https://picsum.photos/seed/HafpdCuBwA/640/480	video	1	2026-04-29 13:32:24.338477	62
188	https://picsum.photos/seed/5TT7ISC/640/480	image	2	2026-04-29 13:32:24.341113	62
189	https://picsum.photos/seed/oTOua/640/480	image	1	2026-04-29 13:32:24.34433	63
190	https://picsum.photos/seed/ggt4NVX05/640/480	video	1	2026-04-29 13:32:24.346857	64
191	https://picsum.photos/seed/MZvEqGTZ/640/480	image	1	2026-04-29 13:32:24.349171	65
192	https://picsum.photos/seed/nmpXsj25/640/480	video	2	2026-04-29 13:32:24.352154	65
193	https://picsum.photos/seed/yjcTh6Nay/640/480	image	3	2026-04-29 13:32:24.355198	65
194	https://picsum.photos/seed/vUNLhOFL/640/480	video	4	2026-04-29 13:32:24.35777	65
195	https://picsum.photos/seed/FLioiVGmHQ/640/480	video	5	2026-04-29 13:32:24.360631	65
196	https://picsum.photos/seed/nYjvzqUyfM/640/480	image	1	2026-04-29 13:32:24.363622	66
197	https://picsum.photos/seed/8i99MRlCAf/640/480	image	2	2026-04-29 13:32:24.367066	66
198	https://picsum.photos/seed/XWEXZPDgh/640/480	image	3	2026-04-29 13:32:24.370681	66
199	https://picsum.photos/seed/6sSZL1fUb/640/480	video	4	2026-04-29 13:32:24.373463	66
200	https://picsum.photos/seed/geRT6ny/640/480	image	5	2026-04-29 13:32:24.375752	66
201	https://picsum.photos/seed/PFJdwp/640/480	image	1	2026-04-29 13:32:24.377891	67
202	https://picsum.photos/seed/K9Kie0KyV/640/480	image	2	2026-04-29 13:32:24.380464	67
203	https://picsum.photos/seed/B0qrd/640/480	image	1	2026-04-29 13:32:24.384089	68
204	https://picsum.photos/seed/yTdZEC4/640/480	image	2	2026-04-29 13:32:24.386884	68
205	https://picsum.photos/seed/eubERH/640/480	video	1	2026-04-29 13:32:24.389279	69
206	https://picsum.photos/seed/YxamPPS8IZ/640/480	image	2	2026-04-29 13:32:24.394744	69
207	https://picsum.photos/seed/J9MyZOALa/640/480	image	3	2026-04-29 13:32:24.397323	69
208	https://picsum.photos/seed/gC5u1N/640/480	video	4	2026-04-29 13:32:24.400295	69
209	https://picsum.photos/seed/r46W43/640/480	video	5	2026-04-29 13:32:24.402941	69
210	https://picsum.photos/seed/3P26YX/640/480	image	1	2026-04-29 13:32:24.405457	70
211	https://picsum.photos/seed/XJXch3/640/480	image	2	2026-04-29 13:32:24.40787	70
212	https://picsum.photos/seed/UOVdsXHlp/640/480	image	3	2026-04-29 13:32:24.410057	70
213	https://picsum.photos/seed/p2kvoQIvk/640/480	video	4	2026-04-29 13:32:24.412116	70
214	https://picsum.photos/seed/b2xusY/640/480	image	5	2026-04-29 13:32:24.414512	70
215	https://picsum.photos/seed/JmDbsGalm/640/480	video	1	2026-04-29 13:32:24.41678	71
216	https://picsum.photos/seed/4U75IhLlkn/640/480	video	2	2026-04-29 13:32:24.41932	71
217	https://picsum.photos/seed/TxFwhSKl/640/480	image	3	2026-04-29 13:32:24.421522	71
218	https://picsum.photos/seed/xk3J4D/640/480	image	4	2026-04-29 13:32:24.424387	71
219	https://picsum.photos/seed/8yrks9/640/480	image	5	2026-04-29 13:32:24.426921	71
220	https://picsum.photos/seed/CZjXvG/640/480	image	1	2026-04-29 13:32:24.42939	72
221	https://picsum.photos/seed/LL4yo0/640/480	image	2	2026-04-29 13:32:24.431927	72
222	https://picsum.photos/seed/Eb7DjJ/640/480	image	3	2026-04-29 13:32:24.434154	72
223	https://picsum.photos/seed/BzFtFj/640/480	video	4	2026-04-29 13:32:24.436179	72
224	https://picsum.photos/seed/jfIiMX/640/480	image	5	2026-04-29 13:32:24.438395	72
225	https://picsum.photos/seed/UDQj2tg/640/480	video	1	2026-04-29 13:32:24.44121	73
226	https://picsum.photos/seed/402PY9UH/640/480	video	2	2026-04-29 13:32:24.443596	73
227	https://picsum.photos/seed/wXIPD/640/480	video	3	2026-04-29 13:32:24.446137	73
228	https://picsum.photos/seed/WpFplDK/640/480	video	4	2026-04-29 13:32:24.448203	73
229	https://picsum.photos/seed/gDLavng/640/480	video	5	2026-04-29 13:32:24.450308	73
230	https://picsum.photos/seed/z8bGYT0W3/640/480	image	1	2026-04-29 13:32:24.453684	74
231	https://picsum.photos/seed/QgnFe/640/480	image	2	2026-04-29 13:32:24.456216	74
309	https://picsum.photos/seed/Jc8giT/640/480	video	3	2026-04-29 13:32:24.669746	99
232	https://picsum.photos/seed/OsJ0yoW/640/480	video	3	2026-04-29 13:32:24.458607	74
233	https://picsum.photos/seed/DZVus5I/640/480	image	1	2026-04-29 13:32:24.460882	75
234	https://picsum.photos/seed/tIy3VOCLrh/640/480	image	2	2026-04-29 13:32:24.463412	75
235	https://picsum.photos/seed/5QBWyXI/640/480	image	3	2026-04-29 13:32:24.465851	75
236	https://picsum.photos/seed/Qww0LpyJn6/640/480	image	4	2026-04-29 13:32:24.468713	75
237	https://picsum.photos/seed/FU4NeN/640/480	image	5	2026-04-29 13:32:24.471106	75
238	https://picsum.photos/seed/ZZijqXf/640/480	video	1	2026-04-29 13:32:24.474727	76
239	https://picsum.photos/seed/aRFOh7FZZk/640/480	video	2	2026-04-29 13:32:24.478224	76
240	https://picsum.photos/seed/80KUuPr/640/480	image	3	2026-04-29 13:32:24.480395	76
241	https://picsum.photos/seed/TmFmhRG/640/480	video	4	2026-04-29 13:32:24.482788	76
242	https://picsum.photos/seed/L8BhVVifsL/640/480	video	5	2026-04-29 13:32:24.485188	76
243	https://picsum.photos/seed/pfEOLja2B/640/480	image	1	2026-04-29 13:32:24.487106	77
244	https://picsum.photos/seed/u17LkJ4M/640/480	image	1	2026-04-29 13:32:24.489288	78
245	https://picsum.photos/seed/hsD0Kqhin/640/480	video	1	2026-04-29 13:32:24.493963	79
246	https://picsum.photos/seed/L1MhWh/640/480	video	2	2026-04-29 13:32:24.49763	79
247	https://picsum.photos/seed/YhOjIFaM/640/480	video	1	2026-04-29 13:32:24.500365	80
248	https://picsum.photos/seed/Tw8DySX/640/480	video	2	2026-04-29 13:32:24.50312	80
249	https://picsum.photos/seed/oFjVCe/640/480	video	1	2026-04-29 13:32:24.505321	81
250	https://picsum.photos/seed/g4UVXF/640/480	video	1	2026-04-29 13:32:24.5075	82
251	https://picsum.photos/seed/wMTp7/640/480	image	2	2026-04-29 13:32:24.510556	82
252	https://picsum.photos/seed/jSAWheRyE7/640/480	image	1	2026-04-29 13:32:24.512878	83
253	https://picsum.photos/seed/qGk5qs/640/480	image	1	2026-04-29 13:32:24.515446	84
254	https://picsum.photos/seed/Nz2Rq3/640/480	image	2	2026-04-29 13:32:24.517541	84
255	https://picsum.photos/seed/qGqj3/640/480	video	3	2026-04-29 13:32:24.520037	84
256	https://picsum.photos/seed/Cw7jLhfL/640/480	video	4	2026-04-29 13:32:24.525169	84
257	https://picsum.photos/seed/0c4iZTT/640/480	video	5	2026-04-29 13:32:24.527869	84
258	https://picsum.photos/seed/WM3HfJ/640/480	video	1	2026-04-29 13:32:24.530334	85
259	https://picsum.photos/seed/Rhgvx/640/480	image	2	2026-04-29 13:32:24.534292	85
260	https://picsum.photos/seed/ai46pxau/640/480	image	3	2026-04-29 13:32:24.536955	85
261	https://picsum.photos/seed/n6jZA/640/480	video	1	2026-04-29 13:32:24.540311	86
262	https://picsum.photos/seed/6Jayii/640/480	video	2	2026-04-29 13:32:24.543315	86
263	https://picsum.photos/seed/tB3Vr6HiuM/640/480	video	1	2026-04-29 13:32:24.546053	87
264	https://picsum.photos/seed/xUzdIxlI/640/480	video	2	2026-04-29 13:32:24.548783	87
265	https://picsum.photos/seed/JLxcbfz1/640/480	video	1	2026-04-29 13:32:24.551457	88
266	https://picsum.photos/seed/IFXJ3s/640/480	video	2	2026-04-29 13:32:24.55597	88
267	https://picsum.photos/seed/j1pKD8cP/640/480	video	3	2026-04-29 13:32:24.559046	88
268	https://picsum.photos/seed/6KGdv8u0/640/480	image	4	2026-04-29 13:32:24.561425	88
269	https://picsum.photos/seed/AKtFkj/640/480	video	1	2026-04-29 13:32:24.564931	89
270	https://picsum.photos/seed/CJsdmxSe/640/480	video	2	2026-04-29 13:32:24.566914	89
271	https://picsum.photos/seed/O7cZjW/640/480	video	3	2026-04-29 13:32:24.570842	89
272	https://picsum.photos/seed/9OlfFu6GL/640/480	video	4	2026-04-29 13:32:24.574493	89
273	https://picsum.photos/seed/Yi4yaD/640/480	video	5	2026-04-29 13:32:24.576995	89
274	https://picsum.photos/seed/rSpQxbuDz3/640/480	video	1	2026-04-29 13:32:24.579345	90
275	https://picsum.photos/seed/7oc3xqYU/640/480	video	2	2026-04-29 13:32:24.581695	90
276	https://picsum.photos/seed/qIpLZ0mJ6o/640/480	image	3	2026-04-29 13:32:24.584396	90
277	https://picsum.photos/seed/EANn4DoS/640/480	video	4	2026-04-29 13:32:24.586578	90
278	https://picsum.photos/seed/xKq5Ec/640/480	video	5	2026-04-29 13:32:24.589027	90
279	https://picsum.photos/seed/laX2Y7IQDA/640/480	image	1	2026-04-29 13:32:24.591458	91
280	https://picsum.photos/seed/cmTTfr/640/480	image	2	2026-04-29 13:32:24.594612	91
281	https://picsum.photos/seed/08OQf/640/480	video	3	2026-04-29 13:32:24.596957	91
282	https://picsum.photos/seed/TJqTaH/640/480	video	1	2026-04-29 13:32:24.599391	92
283	https://picsum.photos/seed/t8kb0G8/640/480	image	2	2026-04-29 13:32:24.601656	92
284	https://picsum.photos/seed/LCFAzJ/640/480	video	3	2026-04-29 13:32:24.604573	92
285	https://picsum.photos/seed/Asy2X/640/480	image	4	2026-04-29 13:32:24.607505	92
286	https://picsum.photos/seed/zJpFhsn/640/480	video	5	2026-04-29 13:32:24.610745	92
287	https://picsum.photos/seed/PugfWjfcqE/640/480	video	1	2026-04-29 13:32:24.613188	93
288	https://picsum.photos/seed/LFRqe4lp/640/480	image	2	2026-04-29 13:32:24.615511	93
289	https://picsum.photos/seed/ftxyO6gYAb/640/480	video	3	2026-04-29 13:32:24.618587	93
290	https://picsum.photos/seed/p5u1Y6G2f/640/480	image	4	2026-04-29 13:32:24.621332	93
291	https://picsum.photos/seed/BHQD8Sl1/640/480	image	5	2026-04-29 13:32:24.623757	93
292	https://picsum.photos/seed/M3hpfSyeL5/640/480	image	1	2026-04-29 13:32:24.626397	94
293	https://picsum.photos/seed/uUkLRx3/640/480	video	2	2026-04-29 13:32:24.628479	94
294	https://picsum.photos/seed/ENzyuY/640/480	image	3	2026-04-29 13:32:24.630972	94
295	https://picsum.photos/seed/ON7zqDuB/640/480	video	4	2026-04-29 13:32:24.634171	94
296	https://picsum.photos/seed/bdTsre/640/480	image	5	2026-04-29 13:32:24.636105	94
297	https://picsum.photos/seed/UHcf7g/640/480	image	1	2026-04-29 13:32:24.638648	95
298	https://picsum.photos/seed/qnyxChUNLU/640/480	video	2	2026-04-29 13:32:24.640957	95
299	https://picsum.photos/seed/8JOJxP/640/480	video	3	2026-04-29 13:32:24.643619	95
300	https://picsum.photos/seed/RZHtDt/640/480	video	4	2026-04-29 13:32:24.645558	95
301	https://picsum.photos/seed/yK6rprLK/640/480	video	5	2026-04-29 13:32:24.647958	95
302	https://picsum.photos/seed/bq3Hg2RO/640/480	image	1	2026-04-29 13:32:24.650203	96
303	https://picsum.photos/seed/ScROSO1l/640/480	video	1	2026-04-29 13:32:24.653318	97
304	https://picsum.photos/seed/x6JMdSipW3/640/480	image	2	2026-04-29 13:32:24.656502	97
305	https://picsum.photos/seed/zCrLVa0/640/480	image	3	2026-04-29 13:32:24.658766	97
306	https://picsum.photos/seed/xQWSl/640/480	image	1	2026-04-29 13:32:24.661278	98
307	https://picsum.photos/seed/Iea9YHh3VA/640/480	image	1	2026-04-29 13:32:24.663893	99
308	https://picsum.photos/seed/pfs6l/640/480	image	2	2026-04-29 13:32:24.666962	99
310	https://picsum.photos/seed/n1K3L/640/480	image	4	2026-04-29 13:32:24.673134	99
311	https://picsum.photos/seed/YZfy00/640/480	image	1	2026-04-29 13:32:24.676545	100
312	https://picsum.photos/seed/smmf4/640/480	video	2	2026-04-29 13:32:24.680224	100
\.


--
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.posts (id, title, status, location, created_at, user_id) FROM stdin;
1	Vesper cimentarius cunabula.	private	Fort Alysaworth	2026-04-29 13:32:23.77221	49
2	Vomito careo amicitia cras conitor corrigo quasi tabgo taceo cattus.	private	Gilroy	2026-04-29 13:32:23.77221	100
3	Eligendi thorax strenuus debitis eius amo subito succurro crustulum.	public	Carrollhaven	2026-04-29 13:32:23.77221	33
4	Dolorem tandem solum ullam conicio perferendis.	public	Bristol	2026-04-29 13:32:23.77221	12
5	Porro aestivus adversus dedecor a conspergo cruentus colligo.	public	Port Tyreekworth	2026-04-29 13:32:23.77221	21
6	Accusator deporto conatus corporis absorbeo articulus appello comitatus adipisci.	private	St. Charles	2026-04-29 13:32:23.77221	53
7	Fugit aiunt utilis laborum.	private	Kubfurt	2026-04-29 13:32:23.77221	91
8	Culpo depereo cattus.	public	Yuba City	2026-04-29 13:32:23.77221	8
9	Modi pariatur contigo suggero omnis deinde stillicidium degusto vulnus.	private	East Lorenafield	2026-04-29 13:32:23.77221	86
10	Viridis adfero peior doloribus audax aeternus minus deprecator.	private	Mitchellburgh	2026-04-29 13:32:23.77221	25
11	Stultus sollicito nemo complectus sunt.	private	Bernierberg	2026-04-29 13:32:23.77221	6
12	Sol turpis somniculosus arguo cimentarius ullam.	public	Lake Christworth	2026-04-29 13:32:23.77221	45
13	Desino surculus stabilis vos ventus adfero amiculum a absque cibus.	private	Des Plaines	2026-04-29 13:32:23.77221	47
14	Collum sum comptus depraedor dens tergeo speciosus impedit.	private	Reubenfurt	2026-04-29 13:32:23.77221	19
15	Calculus aranea necessitatibus.	private	New Giovani	2026-04-29 13:32:23.77221	17
16	Autus dedico tredecim caelum adfectus.	private	Beiershire	2026-04-29 13:32:23.77221	17
17	Summa desipio animus addo et velut vinum tenuis.	private	New Clemmieville	2026-04-29 13:32:23.77221	10
18	Catena verus sub comes caveo.	private	South Andreaneville	2026-04-29 13:32:23.77221	89
19	Arx viridis vivo taceo trepide combibo.	public	East Kamren	2026-04-29 13:32:23.77221	41
20	Arguo adopto succedo pecto volup denego ocer victoria cupiditas.	public	New Adamstead	2026-04-29 13:32:23.77221	64
21	Ad apud benigne amicitia socius arbustum.	public	South Joey	2026-04-29 13:32:23.77221	85
22	Arcus voluptatem calamitas provident adaugeo vulgus tempore deprecator curriculum tot.	public	New Laurianneside	2026-04-29 13:32:23.77221	30
23	Terebro candidus curia.	private	Lake Judsonmouth	2026-04-29 13:32:23.77221	98
24	Est impedit supra dolorem.	public	Fort Zoieville	2026-04-29 13:32:23.77221	14
25	Benigne facere uterque valens illum comptus cultura bis tripudio.	public	South Rylee	2026-04-29 13:32:23.77221	100
26	Defero antea vociferor creator.	public	Town 'n' Country	2026-04-29 13:32:23.77221	64
27	Patior clarus labore viscus arma depereo tutis.	public	New Lewport	2026-04-29 13:32:23.77221	94
28	Speciosus vulgo repellat.	public	Buffalo Grove	2026-04-29 13:32:23.77221	64
29	Tametsi administratio voco volup civitas tempus.	public	East Ilaview	2026-04-29 13:32:23.77221	83
30	Voveo cursus vapulus spero admoveo.	public	West Wendell	2026-04-29 13:32:23.77221	72
31	Sint tenuis claustrum.	public	Fort Oscar	2026-04-29 13:32:23.77221	100
32	Vestigium creta vito torqueo nulla abutor calamitas adfero.	private	New Christiana	2026-04-29 13:32:23.77221	28
33	Pecto viriliter ullus comis consectetur tener cognomen cornu degusto.	public	Port Emelie	2026-04-29 13:32:23.77221	64
34	Speculum qui subiungo tonsor.	public	Bogisichfort	2026-04-29 13:32:23.77221	47
35	Timor colo terebro alias cariosus acerbitas dolore succedo.	public	Pfefferfurt	2026-04-29 13:32:23.77221	4
36	Aut cinis demo conatus tamquam armarium cauda culpa vulnero convoco.	public	Nolanstad	2026-04-29 13:32:23.77221	46
37	Delinquo tabernus adinventitias dolores votum decerno occaecati.	public	Jettieshire	2026-04-29 13:32:23.77221	4
38	Tergo stabilis placeat audax voluptates sumptus.	public	West Alexandrofurt	2026-04-29 13:32:23.77221	12
39	Vesper adstringo angustus cibus ulterius id creta sopor.	public	Jackson	2026-04-29 13:32:23.77221	59
40	Pecco arx arma.	private	West Allanbury	2026-04-29 13:32:23.77221	90
41	Vulpes alter crustulum versus universe aeternus combibo supellex undique dens.	private	Jacksonville	2026-04-29 13:32:23.77221	2
42	Demens tui baiulus admoveo adnuo administratio cervus.	private	Halcester	2026-04-29 13:32:23.77221	79
43	Vestrum deprecator spargo ullus.	public	Roswell	2026-04-29 13:32:23.77221	49
44	Callide aegre pectus cogito adhaero.	public	Port Arnoworth	2026-04-29 13:32:23.77221	1
45	Adficio sint possimus carpo.	private	Port Ineschester	2026-04-29 13:32:23.77221	100
46	Civis copiose vigor acies delectus certe sulum coma.	public	South Horacioside	2026-04-29 13:32:23.77221	44
47	Virga tamisium calculus nobis cuppedia supellex assentator volubilis similique.	private	Sipesstead	2026-04-29 13:32:23.77221	100
48	Tener sit thymbra timidus.	public	Greeley	2026-04-29 13:32:23.77221	80
49	Allatus nulla tergum iste inflammatio aurum angustus curriculum.	private	Earlville	2026-04-29 13:32:23.77221	67
50	Coniecto vomer sum averto.	private	Kelsietown	2026-04-29 13:32:23.77221	76
51	Aequitas crapula ultra demoror vaco ago demoror amicitia vitiosus delicate.	public	New Devontecester	2026-04-29 13:32:23.77221	23
52	Ullus adulescens consequuntur tres decipio xiphias.	public	Granvilleview	2026-04-29 13:32:23.77221	92
53	Vitium arbustum adamo vulpes adamo aedificium subvenio.	private	Ziemannbury	2026-04-29 13:32:23.77221	52
54	Vae patior voluptates agnitio repudiandae cunctatio.	public	Blickfort	2026-04-29 13:32:23.77221	80
55	Degenero caterva demitto utroque tumultus corrumpo talus adopto viscus.	private	Port Kariane	2026-04-29 13:32:23.77221	57
56	Creptio copiose causa clibanus tergo.	public	Handview	2026-04-29 13:32:23.77221	89
57	Stipes valens tubineus aggero tero depulso theatrum.	public	West Krystina	2026-04-29 13:32:23.77221	15
58	Creta crepusculum ut aeger advenio ante aedificium possimus.	public	Michaelland	2026-04-29 13:32:23.77221	74
59	Xiphias crebro debilito itaque accusamus maiores ventosus dolore.	private	West Rosemarystad	2026-04-29 13:32:23.77221	99
60	Blanditiis tergo delectus nulla copia spero deripio bellum earum vinum.	private	South Natside	2026-04-29 13:32:23.77221	25
61	Studio unus congregatio venio denuo casso arbor.	public	Apple Valley	2026-04-29 13:32:23.77221	98
62	Vulgus patior aufero delectatio vacuus villa thalassinus solum crapula.	public	Raleighmouth	2026-04-29 13:32:23.77221	71
63	Voluptates deputo universe paulatim veritas velut avaritia sufficio.	private	Lucioview	2026-04-29 13:32:23.77221	73
64	Tamen tum capillus.	private	Franeyboro	2026-04-29 13:32:23.77221	24
65	Aspicio conicio umquam somnus confero.	private	North Zion	2026-04-29 13:32:23.77221	92
66	Tametsi reiciendis cohors libero theologus cetera fugiat denique derelinquo curvo.	private	Cerritos	2026-04-29 13:32:23.77221	1
67	Alo consectetur thymbra somnus stillicidium amor candidus deorsum asperiores aranea.	private	Kalamazoo	2026-04-29 13:32:23.77221	94
68	Admoveo alienus currus pel quisquam.	public	North Caylastead	2026-04-29 13:32:23.77221	20
69	Suasoria comparo abundans.	public	Visalia	2026-04-29 13:32:23.77221	98
70	Quas ademptio curia conspergo acidus umerus causa fugiat.	private	Florenceport	2026-04-29 13:32:23.77221	30
71	Demoror conscendo adversus infit accedo somniculosus.	private	Franeckihaven	2026-04-29 13:32:23.77221	12
72	Cenaculum stillicidium texo.	private	Jaceycester	2026-04-29 13:32:23.77221	70
73	Tenax cur exercitationem adicio temptatio.	public	Schultzstead	2026-04-29 13:32:23.77221	38
74	Denuo desino comedo esse cena.	private	Strackefort	2026-04-29 13:32:23.77221	60
75	Contabesco canis subiungo tumultus cerno vir infit ea.	private	Fort Donniestead	2026-04-29 13:32:23.77221	46
76	Vulticulus stabilis antiquus crur callide circumvenio solutio cogito.	private	Andyview	2026-04-29 13:32:23.77221	95
77	Aufero uberrime laboriosam catena ipsum distinctio quae amissio.	public	Lake Jerod	2026-04-29 13:32:23.77221	62
78	Arca est caput.	private	North Abe	2026-04-29 13:32:23.77221	59
79	Contabesco talio occaecati sophismata decor deprimo porro sopor voluptatem quos.	private	South Audieburgh	2026-04-29 13:32:23.77221	49
80	Cum fugit bos sublime.	public	East Angelo	2026-04-29 13:32:23.77221	78
81	Adamo thorax congregatio deleniti delego strenuus solutio voro consequuntur vulgivagus.	private	New Era	2026-04-29 13:32:23.77221	60
82	Clibanus tepesco tepidus terebro.	public	Batzfield	2026-04-29 13:32:23.77221	93
83	Undique magni corporis suasoria delibero assentator.	public	Cedar Rapids	2026-04-29 13:32:23.77221	7
84	Apto tantum suppono curis alias.	public	Beckerboro	2026-04-29 13:32:23.77221	27
85	Tamisium inventore tergeo condico temperantia denuncio.	private	West Ernesto	2026-04-29 13:32:23.77221	56
86	Alius aliqua cribro repellat viriliter cui vaco decumbo templum.	private	Bozeman	2026-04-29 13:32:23.77221	77
87	Vulgivagus ait repellat suggero ocer capio.	public	Colefurt	2026-04-29 13:32:23.77221	6
88	Demo possimus subiungo.	private	Maritzatown	2026-04-29 13:32:23.77221	35
89	Tepesco audax cometes labore thalassinus sursum umquam thesaurus curso.	private	Rosenbaumfort	2026-04-29 13:32:23.77221	82
90	Usitas usque ut.	public	Cypress	2026-04-29 13:32:23.77221	62
91	Bos thymum bonus ascit substantia carpo vindico.	public	Trompworth	2026-04-29 13:32:23.77221	66
92	Saepe clamo vobis confido audeo ustilo excepturi animi.	private	Fort Alisonchester	2026-04-29 13:32:23.77221	67
93	Velit eius verto deleniti calculus cur quas aspernatur voluptatem vilicus.	public	South Tyreek	2026-04-29 13:32:23.77221	6
94	Aggero capio corrupti ventus arbustum vilitas.	private	West Juneside	2026-04-29 13:32:23.77221	75
95	Animus audax suadeo minus tribuo cena ullus vox aureus.	private	South Kaelynfield	2026-04-29 13:32:23.77221	98
96	Spoliatio vergo cogo video.	private	Fort Shanieview	2026-04-29 13:32:23.77221	81
97	Et tabgo soluta utroque rerum commodo.	private	Rohanworth	2026-04-29 13:32:23.77221	48
98	Reiciendis tabesco clibanus accusantium solio admitto colo.	private	Romaguerastead	2026-04-29 13:32:23.77221	91
99	Basium natus summa.	public	Kasandramouth	2026-04-29 13:32:23.77221	49
100	Admoveo clibanus bonus totidem infit cunae ater vulnus.	public	Thompsontown	2026-04-29 13:32:23.77221	11
\.


--
-- Data for Name: saved_posts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.saved_posts (user_id, post_id, created_at) FROM stdin;
31	2	2026-04-29 13:32:24.787137
64	3	2026-04-29 13:32:24.830785
28	3	2026-04-29 13:32:24.835537
4	3	2026-04-29 13:32:24.839398
98	3	2026-04-29 13:32:24.844028
52	4	2026-04-29 13:32:24.905079
26	4	2026-04-29 13:32:24.909949
57	4	2026-04-29 13:32:24.914348
9	4	2026-04-29 13:32:24.919593
63	6	2026-04-29 13:32:25.008504
38	6	2026-04-29 13:32:25.012311
10	6	2026-04-29 13:32:25.015722
4	6	2026-04-29 13:32:25.019201
91	8	2026-04-29 13:32:25.1247
99	8	2026-04-29 13:32:25.128626
100	8	2026-04-29 13:32:25.132091
96	8	2026-04-29 13:32:25.135422
46	9	2026-04-29 13:32:25.154299
47	11	2026-04-29 13:32:25.248009
26	11	2026-04-29 13:32:25.252083
25	12	2026-04-29 13:32:25.271222
6	12	2026-04-29 13:32:25.274985
93	12	2026-04-29 13:32:25.278548
10	12	2026-04-29 13:32:25.28327
62	13	2026-04-29 13:32:25.34909
44	14	2026-04-29 13:32:25.384328
45	15	2026-04-29 13:32:25.431467
29	15	2026-04-29 13:32:25.435944
8	15	2026-04-29 13:32:25.439679
84	15	2026-04-29 13:32:25.443904
71	17	2026-04-29 13:32:25.529259
22	17	2026-04-29 13:32:25.53227
88	18	2026-04-29 13:32:25.560115
95	18	2026-04-29 13:32:25.565163
34	18	2026-04-29 13:32:25.570004
84	19	2026-04-29 13:32:25.647587
23	19	2026-04-29 13:32:25.652524
75	19	2026-04-29 13:32:25.656575
56	19	2026-04-29 13:32:25.661316
7	20	2026-04-29 13:32:25.695922
17	20	2026-04-29 13:32:25.699964
87	20	2026-04-29 13:32:25.704066
64	21	2026-04-29 13:32:25.754872
34	21	2026-04-29 13:32:25.758787
49	21	2026-04-29 13:32:25.762804
54	21	2026-04-29 13:32:25.765853
84	22	2026-04-29 13:32:25.835713
29	22	2026-04-29 13:32:25.84013
52	24	2026-04-29 13:32:25.940772
88	24	2026-04-29 13:32:25.945338
11	24	2026-04-29 13:32:25.949459
76	26	2026-04-29 13:32:26.019098
23	26	2026-04-29 13:32:26.022352
17	26	2026-04-29 13:32:26.02618
12	26	2026-04-29 13:32:26.030243
46	27	2026-04-29 13:32:26.062198
18	27	2026-04-29 13:32:26.065288
20	27	2026-04-29 13:32:26.069145
24	27	2026-04-29 13:32:26.072187
92	28	2026-04-29 13:32:26.090779
78	28	2026-04-29 13:32:26.095291
44	28	2026-04-29 13:32:26.099162
88	29	2026-04-29 13:32:26.134528
80	29	2026-04-29 13:32:26.137196
44	29	2026-04-29 13:32:26.139701
24	29	2026-04-29 13:32:26.142827
33	30	2026-04-29 13:32:26.202607
18	30	2026-04-29 13:32:26.206999
24	30	2026-04-29 13:32:26.210988
54	30	2026-04-29 13:32:26.214679
83	30	2026-04-29 13:32:26.218322
62	31	2026-04-29 13:32:26.279711
77	31	2026-04-29 13:32:26.284232
51	31	2026-04-29 13:32:26.288749
82	33	2026-04-29 13:32:26.355795
36	33	2026-04-29 13:32:26.35985
81	33	2026-04-29 13:32:26.36431
38	33	2026-04-29 13:32:26.368703
98	33	2026-04-29 13:32:26.373159
83	34	2026-04-29 13:32:26.429818
59	34	2026-04-29 13:32:26.433545
76	34	2026-04-29 13:32:26.436547
40	34	2026-04-29 13:32:26.438998
42	35	2026-04-29 13:32:26.462455
41	35	2026-04-29 13:32:26.466653
92	35	2026-04-29 13:32:26.47058
7	35	2026-04-29 13:32:26.474711
39	35	2026-04-29 13:32:26.478629
65	36	2026-04-29 13:32:26.540697
31	36	2026-04-29 13:32:26.54505
41	36	2026-04-29 13:32:26.549055
86	36	2026-04-29 13:32:26.552741
95	36	2026-04-29 13:32:26.556352
74	37	2026-04-29 13:32:26.601686
4	37	2026-04-29 13:32:26.605842
22	37	2026-04-29 13:32:26.610687
83	37	2026-04-29 13:32:26.614495
15	39	2026-04-29 13:32:26.698365
76	39	2026-04-29 13:32:26.703222
14	40	2026-04-29 13:32:26.772703
27	40	2026-04-29 13:32:26.777315
36	41	2026-04-29 13:32:26.828831
38	41	2026-04-29 13:32:26.833427
70	41	2026-04-29 13:32:26.836982
43	43	2026-04-29 13:32:26.928384
58	43	2026-04-29 13:32:26.933205
41	43	2026-04-29 13:32:26.937314
8	43	2026-04-29 13:32:26.942026
14	46	2026-04-29 13:32:27.070059
67	48	2026-04-29 13:32:27.126822
96	48	2026-04-29 13:32:27.132284
38	48	2026-04-29 13:32:27.137331
65	49	2026-04-29 13:32:27.198021
77	49	2026-04-29 13:32:27.203591
25	49	2026-04-29 13:32:27.20921
10	49	2026-04-29 13:32:27.215275
26	50	2026-04-29 13:32:27.263304
36	50	2026-04-29 13:32:27.267548
67	50	2026-04-29 13:32:27.272729
62	50	2026-04-29 13:32:27.277451
89	50	2026-04-29 13:32:27.28266
29	51	2026-04-29 13:32:27.320468
52	51	2026-04-29 13:32:27.324123
92	52	2026-04-29 13:32:27.365863
93	52	2026-04-29 13:32:27.369662
8	52	2026-04-29 13:32:27.374038
63	53	2026-04-29 13:32:27.422459
56	53	2026-04-29 13:32:27.426346
99	53	2026-04-29 13:32:27.430604
42	53	2026-04-29 13:32:27.435508
84	54	2026-04-29 13:32:27.463752
91	54	2026-04-29 13:32:27.468666
27	55	2026-04-29 13:32:27.484111
98	55	2026-04-29 13:32:27.486948
14	55	2026-04-29 13:32:27.489216
100	55	2026-04-29 13:32:27.491938
59	57	2026-04-29 13:32:27.589017
60	57	2026-04-29 13:32:27.591939
64	57	2026-04-29 13:32:27.595643
18	58	2026-04-29 13:32:27.633085
96	58	2026-04-29 13:32:27.635785
40	59	2026-04-29 13:32:27.665407
54	60	2026-04-29 13:32:27.694356
87	60	2026-04-29 13:32:27.698378
71	60	2026-04-29 13:32:27.702676
99	60	2026-04-29 13:32:27.708351
74	60	2026-04-29 13:32:27.713332
68	62	2026-04-29 13:32:27.768143
35	62	2026-04-29 13:32:27.772224
72	62	2026-04-29 13:32:27.776943
6	62	2026-04-29 13:32:27.780451
19	62	2026-04-29 13:32:27.784934
33	63	2026-04-29 13:32:27.831046
93	63	2026-04-29 13:32:27.83638
21	63	2026-04-29 13:32:27.841102
58	64	2026-04-29 13:32:27.878304
8	64	2026-04-29 13:32:27.882354
9	64	2026-04-29 13:32:27.88617
32	64	2026-04-29 13:32:27.89097
6	64	2026-04-29 13:32:27.895039
64	66	2026-04-29 13:32:27.976586
4	66	2026-04-29 13:32:27.979915
69	66	2026-04-29 13:32:27.987475
98	66	2026-04-29 13:32:27.992436
48	67	2026-04-29 13:32:28.049808
36	67	2026-04-29 13:32:28.05314
12	67	2026-04-29 13:32:28.056318
53	68	2026-04-29 13:32:28.12125
70	68	2026-04-29 13:32:28.125783
85	68	2026-04-29 13:32:28.130138
5	69	2026-04-29 13:32:28.182584
100	70	2026-04-29 13:32:28.224922
33	70	2026-04-29 13:32:28.227392
28	70	2026-04-29 13:32:28.230177
7	70	2026-04-29 13:32:28.235632
24	70	2026-04-29 13:32:28.239667
44	71	2026-04-29 13:32:28.269015
58	71	2026-04-29 13:32:28.272341
5	71	2026-04-29 13:32:28.275553
59	71	2026-04-29 13:32:28.279049
43	72	2026-04-29 13:32:28.313149
20	72	2026-04-29 13:32:28.317942
58	72	2026-04-29 13:32:28.322216
10	72	2026-04-29 13:32:28.328759
80	72	2026-04-29 13:32:28.33283
27	73	2026-04-29 13:32:28.38558
76	73	2026-04-29 13:32:28.39003
4	74	2026-04-29 13:32:28.45025
72	75	2026-04-29 13:32:28.511121
36	75	2026-04-29 13:32:28.514584
74	75	2026-04-29 13:32:28.520826
22	76	2026-04-29 13:32:28.54557
56	76	2026-04-29 13:32:28.551922
51	77	2026-04-29 13:32:28.599092
33	77	2026-04-29 13:32:28.602791
21	77	2026-04-29 13:32:28.612797
23	78	2026-04-29 13:32:28.67572
16	78	2026-04-29 13:32:28.679798
65	78	2026-04-29 13:32:28.683854
15	78	2026-04-29 13:32:28.687532
31	79	2026-04-29 13:32:28.719353
46	80	2026-04-29 13:32:28.769167
74	80	2026-04-29 13:32:28.771845
90	81	2026-04-29 13:32:28.81469
47	82	2026-04-29 13:32:28.866711
63	82	2026-04-29 13:32:28.869692
10	82	2026-04-29 13:32:28.873471
21	82	2026-04-29 13:32:28.87764
37	83	2026-04-29 13:32:28.929371
51	84	2026-04-29 13:32:28.956131
18	84	2026-04-29 13:32:28.958557
82	84	2026-04-29 13:32:28.961938
94	84	2026-04-29 13:32:28.965013
21	85	2026-04-29 13:32:29.018605
47	85	2026-04-29 13:32:29.021721
83	85	2026-04-29 13:32:29.025417
77	85	2026-04-29 13:32:29.027934
35	85	2026-04-29 13:32:29.030922
45	86	2026-04-29 13:32:29.081004
22	87	2026-04-29 13:32:29.124108
95	87	2026-04-29 13:32:29.127179
17	87	2026-04-29 13:32:29.129489
37	90	2026-04-29 13:32:29.268591
65	90	2026-04-29 13:32:29.271799
92	90	2026-04-29 13:32:29.275058
54	90	2026-04-29 13:32:29.277756
8	91	2026-04-29 13:32:29.33983
65	91	2026-04-29 13:32:29.34231
48	91	2026-04-29 13:32:29.345506
12	91	2026-04-29 13:32:29.350157
61	91	2026-04-29 13:32:29.354027
48	92	2026-04-29 13:32:29.398365
71	94	2026-04-29 13:32:29.470022
85	96	2026-04-29 13:32:29.562173
58	96	2026-04-29 13:32:29.566738
19	97	2026-04-29 13:32:29.60869
60	97	2026-04-29 13:32:29.612056
2	97	2026-04-29 13:32:29.61652
55	98	2026-04-29 13:32:29.641826
38	98	2026-04-29 13:32:29.645111
33	98	2026-04-29 13:32:29.648295
21	99	2026-04-29 13:32:29.696927
48	99	2026-04-29 13:32:29.700501
11	100	2026-04-29 13:32:29.744463
23	100	2026-04-29 13:32:29.74784
89	100	2026-04-29 13:32:29.750898
45	100	2026-04-29 13:32:29.753972
\.


--
-- Data for Name: stories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.stories (id, media_url, expires_at, created_at, user_id) FROM stdin;
1	https://picsum.photos/seed/i7vwWDkQ/1080/1920	2026-04-30 07:30:29.703	2026-04-29 13:32:23.29119	3
2	https://picsum.photos/seed/zh40DQr/1080/1920	2026-04-30 03:48:30.39	2026-04-29 13:32:23.306826	8
3	https://picsum.photos/seed/m0MgN/1080/1920	2026-04-30 13:37:43.083	2026-04-29 13:32:23.311248	11
4	https://picsum.photos/seed/EGG5ZKEf/1080/1920	2026-04-29 20:52:04.779	2026-04-29 13:32:23.317027	12
5	https://picsum.photos/seed/XY101/1080/1920	2026-04-30 17:39:39.255	2026-04-29 13:32:23.323167	13
6	https://picsum.photos/seed/LJimuG8xyL/1080/1920	2026-04-29 21:39:56.895	2026-04-29 13:32:23.333735	16
7	https://picsum.photos/seed/oPvVcS/1080/1920	2026-04-30 12:32:34.349	2026-04-29 13:32:23.339006	17
8	https://picsum.photos/seed/9McK3o1s/1080/1920	2026-04-29 21:28:27.965	2026-04-29 13:32:23.350222	21
9	https://picsum.photos/seed/Y1osW/1080/1920	2026-04-30 08:52:59.694	2026-04-29 13:32:23.359134	23
10	https://picsum.photos/seed/PkmGq/1080/1920	2026-04-30 02:11:24.415	2026-04-29 13:32:23.366991	26
11	https://picsum.photos/seed/9WD8VbmkC/1080/1920	2026-04-29 20:38:41.401	2026-04-29 13:32:23.378824	28
12	https://picsum.photos/seed/TYlltBY9d2/1080/1920	2026-04-29 22:05:47.996	2026-04-29 13:32:23.401302	33
13	https://picsum.photos/seed/8ILWyjeQ8/1080/1920	2026-04-30 11:54:18.218	2026-04-29 13:32:23.423731	41
14	https://picsum.photos/seed/nl5y2/1080/1920	2026-04-30 05:33:20.722	2026-04-29 13:32:23.441451	45
15	https://picsum.photos/seed/PFBX0W/1080/1920	2026-04-30 12:20:32.32	2026-04-29 13:32:23.454528	48
16	https://picsum.photos/seed/IioFAx/1080/1920	2026-04-30 03:12:30.336	2026-04-29 13:32:23.462039	49
17	https://picsum.photos/seed/g0aFu8Ud/1080/1920	2026-04-30 15:48:45.186	2026-04-29 13:32:23.488783	55
18	https://picsum.photos/seed/FW7nzXN9/1080/1920	2026-04-30 01:46:21.882	2026-04-29 13:32:23.496193	56
19	https://picsum.photos/seed/sky3WtHg/1080/1920	2026-04-30 05:10:43.422	2026-04-29 13:32:23.505789	57
20	https://picsum.photos/seed/WCf7mjm/1080/1920	2026-04-30 16:55:13.342	2026-04-29 13:32:23.515743	60
21	https://picsum.photos/seed/R8HeIG8M/1080/1920	2026-04-30 03:28:58.285	2026-04-29 13:32:23.528646	63
22	https://picsum.photos/seed/N9mseRybt/1080/1920	2026-04-30 14:09:59.307	2026-04-29 13:32:23.54811	67
23	https://picsum.photos/seed/miEAQuIxPN/1080/1920	2026-04-30 03:17:49.35	2026-04-29 13:32:23.581952	72
24	https://picsum.photos/seed/bhvgDQC/1080/1920	2026-04-30 16:01:09.78	2026-04-29 13:32:23.593359	74
25	https://picsum.photos/seed/mBszxf5Pox/1080/1920	2026-04-30 10:18:26.775	2026-04-29 13:32:23.600077	75
26	https://picsum.photos/seed/WJ0Lb/1080/1920	2026-04-29 21:10:22.8	2026-04-29 13:32:23.607048	76
27	https://picsum.photos/seed/HkUZ7I/1080/1920	2026-04-30 14:38:53.154	2026-04-29 13:32:23.625511	80
28	https://picsum.photos/seed/rcEIY/1080/1920	2026-04-30 08:16:13.222	2026-04-29 13:32:23.640172	83
29	https://picsum.photos/seed/gxFxbui/1080/1920	2026-04-30 06:40:13.337	2026-04-29 13:32:23.657556	86
30	https://picsum.photos/seed/M9mjO/1080/1920	2026-04-29 21:45:25.396	2026-04-29 13:32:23.664034	87
31	https://picsum.photos/seed/AMZeJ07/1080/1920	2026-04-30 08:13:09.205	2026-04-29 13:32:23.672868	89
32	https://picsum.photos/seed/cqplSAVs/1080/1920	2026-04-29 23:19:44.066	2026-04-29 13:32:23.681393	91
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, user_name, email, role, avatar_url, bio, created_at, deleted_at) FROM stdin;
1	Mateo_HegmannJODpz	Erica.Paucek38@gmail.com	user	https://avatars.githubusercontent.com/u/36988897	foodie, filmmaker	2026-04-29 13:32:23.121895	\N
2	Marianna72HqS9X	Rollin_Kerluke@gmail.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/130.jpg	leader, nerd, gamer	2026-04-29 13:32:23.153682	\N
3	Colten34kNqdP	Okey71@hotmail.com	user	https://avatars.githubusercontent.com/u/75614133	inventor, entrepreneur	2026-04-29 13:32:23.157628	\N
4	Joesph.HaucksWDWp	Lance79@yahoo.com	user	https://avatars.githubusercontent.com/u/51557431	spy junkie, blogger	2026-04-29 13:32:23.157985	\N
5	Kallie.Bartell-Kilbackil1dD	Nicholas44@yahoo.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/758.jpg	writer, philosopher, person	2026-04-29 13:32:23.158216	\N
6	Rosalinda.Johnston64hHJO2	Urban_Crona@hotmail.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/706.jpg	creator, blogger	2026-04-29 13:32:23.158465	\N
7	Clementina.CasperrCOwe	Ivah86@yahoo.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/702.jpg	veteran, teacher	2026-04-29 13:32:23.158555	\N
8	Emma_Wehner80RV46a	Macy.Abbott17@gmail.com	user	https://avatars.githubusercontent.com/u/27424899	person, foodie	2026-04-29 13:32:23.158843	\N
9	Greyson42x2hmd	Tyler.Hettinger@yahoo.com	user	https://avatars.githubusercontent.com/u/3591077	risk enthusiast, veteran 🚨	2026-04-29 13:32:23.160706	\N
10	Marlon84NJKxk	Nelson_Dooley15@hotmail.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1103.jpg	ear supporter, nerd 🖼️	2026-04-29 13:32:23.161715	\N
11	Hattie.FeilHHyul	Rosemary57@gmail.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/829.jpg	engineer	2026-04-29 13:32:23.170021	\N
12	Ernie_LynchNYNr4	Marian35@hotmail.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/112.jpg	length supporter, streamer	2026-04-29 13:32:23.171193	\N
13	Glennie86kwwBj	Abby.Mertz@hotmail.com	user	https://avatars.githubusercontent.com/u/64393521	twins lover, philosopher 🧁	2026-04-29 13:32:23.171462	\N
14	Lucio77JDIyE	Xavier.Terry-Aufderhar45@hotmail.com	user	https://avatars.githubusercontent.com/u/37165087	exposition fan, musician 🍟	2026-04-29 13:32:23.171779	\N
15	Ricardo.Runolfsdottir33kTrof	Crystel_Walter@hotmail.com	user	https://avatars.githubusercontent.com/u/17467556	suppression devotee  🧪	2026-04-29 13:32:23.172075	\N
16	Saige.GradyaymRq	Kaelyn61@yahoo.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1026.jpg	engineer	2026-04-29 13:32:23.172785	\N
17	Agustina_Jenkins84ryNjs	Irma.Mitchell-Pouros90@yahoo.com	user	https://avatars.githubusercontent.com/u/79274603	coach, model, foodie	2026-04-29 13:32:23.173052	\N
18	Trenton.SwiftQ3x6P	Stanley.Homenick22@yahoo.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/81.jpg	teacher, musician	2026-04-29 13:32:23.17377	\N
19	Roslyn28NoyXa	Magnolia.Cassin16@hotmail.com	user	https://avatars.githubusercontent.com/u/59559057	route fan	2026-04-29 13:32:23.177455	\N
20	Westley_Fay3Bwte	Samanta.Wintheiser@yahoo.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/71.jpg	duster devotee, scientist 🐕	2026-04-29 13:32:23.178604	\N
21	Melvina_Leannon46Iw8XD	Marcelina25@gmail.com	user	https://avatars.githubusercontent.com/u/20405832	familiarity lover, singer 👏🏻	2026-04-29 13:32:23.178941	\N
22	Brayan_Hudson7ARAm	Dorthy48@hotmail.com	user	https://avatars.githubusercontent.com/u/44722673	masonry supporter, geek	2026-04-29 13:32:23.179159	\N
23	Eda_BahringerN2w0y	Kale87@yahoo.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/776.jpg	cormorant devotee	2026-04-29 13:32:23.180434	\N
24	Coralie68aFioy	Lue.Gerhold43@hotmail.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/163.jpg	inventor	2026-04-29 13:32:23.181736	\N
25	Janiya.TorpD7The	Darrion_Klocko37@gmail.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/799.jpg	singer, patriot	2026-04-29 13:32:23.181745	\N
26	Rasheed.BayerZnlMW	Lyda_Hackett58@yahoo.com	user	https://avatars.githubusercontent.com/u/91893618	plumber junkie, leader 🥉	2026-04-29 13:32:23.181923	\N
27	Javon31WDNmq	Joaquin.Strosin46@yahoo.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/584.jpg	buyer advocate  🇹🇯	2026-04-29 13:32:23.184987	\N
28	Toni30rmql7	Abdiel94@gmail.com	user	https://avatars.githubusercontent.com/u/81205605	creator, geek, friend	2026-04-29 13:32:23.185783	\N
29	Maiya44ynyox	Camden61@yahoo.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/89.jpg	bottling devotee, foodie 🎊	2026-04-29 13:32:23.186684	\N
30	Roscoe.Strosin2B9aL	Trevor.Sipes@gmail.com	user	https://avatars.githubusercontent.com/u/86965455	patriot, inventor, creator	2026-04-29 13:32:23.186733	\N
31	Keith48qzyDJ	Rosalind.Gleason@gmail.com	user	https://avatars.githubusercontent.com/u/71766041	patriot, entrepreneur	2026-04-29 13:32:23.188657	\N
32	Raegan32beHpy	Adeline.Gorczany@hotmail.com	user	https://avatars.githubusercontent.com/u/35642744	streamer, founder, foodie 🤞🏼	2026-04-29 13:32:23.188811	\N
33	Corene.Larkin1Cmh3	Gennaro_Auer9@hotmail.com	user	https://avatars.githubusercontent.com/u/64786237	memory advocate  🦡	2026-04-29 13:32:23.18914	\N
34	Herminio69q6kfD	Morgan_Hickle12@yahoo.com	user	https://avatars.githubusercontent.com/u/38637002	grad	2026-04-29 13:32:23.189398	\N
35	Georgette.Dibbert12nGalL	Reta.Runte-Lemke39@gmail.com	user	https://avatars.githubusercontent.com/u/10135185	tabby supporter	2026-04-29 13:32:23.191199	\N
37	Alda85gf60t	Maddison_Kilback58@hotmail.com	user	https://avatars.githubusercontent.com/u/42162394	teacher, scientist, geek 😡	2026-04-29 13:32:23.19286	\N
36	Aliza35TvJWa	Marcos_Mosciski49@yahoo.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/101.jpg	blogger	2026-04-29 13:32:23.192217	\N
38	Lewis49Qj7m8	Brittany.Toy@gmail.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/169.jpg	insectarium lover, creator 🇦🇲	2026-04-29 13:32:23.192336	\N
39	Winifred.Nader815qYkl	Easton_Hamill21@hotmail.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/156.jpg	scientist	2026-04-29 13:32:23.193893	\N
40	Justus3p5RbG	Antone.Abbott17@gmail.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/984.jpg	spyglass junkie, streamer 🇰🇲	2026-04-29 13:32:23.194071	\N
41	Evalyn75604Xc	Bertha30@gmail.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/107.jpg	teacher	2026-04-29 13:32:23.195433	\N
42	Sven.KesslerHkhsh	Ethyl.Price40@gmail.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/405.jpg	barrier devotee  🕍	2026-04-29 13:32:23.196517	\N
43	Marquis806GLex	Erica_Streich25@hotmail.com	user	https://avatars.githubusercontent.com/u/17178698	film lover	2026-04-29 13:32:23.196607	\N
44	Vernie_AnkundinglChjF	Savion.Will51@hotmail.com	user	https://avatars.githubusercontent.com/u/84846267	horizon fan, photographer	2026-04-29 13:32:23.196798	\N
45	Raymond8sbLLM	Jacques_Fay@hotmail.com	user	https://avatars.githubusercontent.com/u/9207250	model, entrepreneur, activist 🥠	2026-04-29 13:32:23.197903	\N
55	Princess.HarberjksDD	Ariane_Adams@yahoo.com	user	https://avatars.githubusercontent.com/u/98513332	streamer	2026-04-29 13:32:23.205224	\N
64	Prudence48EWWHj	Paxton_Goldner@hotmail.com	user	https://avatars.githubusercontent.com/u/73444045	ruffle enthusiast	2026-04-29 13:32:23.21027	\N
74	Kris_Keebler81YGeJz	Fanny.Rogahn25@gmail.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/399.jpg	friend, developer, nerd 🤖	2026-04-29 13:32:23.218234	\N
85	Isidro_Simonis64Js1Yx	Jacklyn51@hotmail.com	user	https://avatars.githubusercontent.com/u/84402509	mango devotee	2026-04-29 13:32:23.234616	\N
95	Maida_BuckridgeYAsLQ	Kelli_Ankunding74@gmail.com	user	https://avatars.githubusercontent.com/u/42715499	person, coach, musician 🐟	2026-04-29 13:32:23.241559	\N
46	Sage87Huafx	Olen_Gislason@yahoo.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/90.jpg	faucet junkie, environmentalist	2026-04-29 13:32:23.198879	\N
58	Torrey_BarrowsxCQbn	Kathryn.Quigley@yahoo.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/66.jpg	submarine supporter	2026-04-29 13:32:23.205782	\N
66	Adelle.Kessler27gtpu8	Antone13@gmail.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/847.jpg	celebration enthusiast	2026-04-29 13:32:23.211481	\N
76	Willy.GradyMEvCb	Layne13@yahoo.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/811.jpg	gamer, coach, scientist 🤸🏾‍♀️	2026-04-29 13:32:23.219322	\N
93	Aric35eBuPe	Einar.Breitenberg16@yahoo.com	user	https://avatars.githubusercontent.com/u/55419578	income fan	2026-04-29 13:32:23.236704	\N
47	Brando_Heaney1Dk5B	Samson3@gmail.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/732.jpg	veteran, coach, filmmaker ⏯️	2026-04-29 13:32:23.199286	\N
56	Emil.Thiel34TK2YP	Monique.Kovacek95@hotmail.com	user	https://avatars.githubusercontent.com/u/51917445	patriot	2026-04-29 13:32:23.205909	\N
68	Lisandro.Nikolaus21HAXPT	Selmer.Reichert@yahoo.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/24.jpg	kitty devotee  🪝	2026-04-29 13:32:23.212179	\N
78	Tianna63jkYje	Brooks.Gutkowski19@yahoo.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1153.jpg	environmentalist, dreamer	2026-04-29 13:32:23.220587	\N
92	Santa_ToyIcdgl	Vella.Connelly2@hotmail.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/258.jpg	singer, educator, engineer 😲	2026-04-29 13:32:23.236548	\N
100	Maynard_Volkman35eQSLf	Jeffrey25@gmail.com	user	https://avatars.githubusercontent.com/u/60404108	ram fan, geek ☂️	2026-04-29 13:32:23.244288	\N
48	Darrell68cxXl4	Mabel.Kirlin@gmail.com	user	https://avatars.githubusercontent.com/u/43069788	lady devotee, grad 💂🏻	2026-04-29 13:32:23.20009	\N
57	Zena688zdl6	Aron_Donnelly70@gmail.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/642.jpg	guinea supporter  ⏬	2026-04-29 13:32:23.205931	\N
67	Joy.Steuber0dC21k	Melisa_Hammes83@gmail.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/186.jpg	dreamer	2026-04-29 13:32:23.211692	\N
77	Tre36dt98O	Coleman56@hotmail.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/154.jpg	musician, veteran, student	2026-04-29 13:32:23.220539	\N
86	Selina_ProhaskanQ05L	Tyree_Kerluke@gmail.com	user	https://avatars.githubusercontent.com/u/66616136	public speaker	2026-04-29 13:32:23.235473	\N
96	Sandrine_Hane81EA1Z5	Gust19@yahoo.com	user	https://avatars.githubusercontent.com/u/82696697	friend	2026-04-29 13:32:23.242308	\N
49	Buck_WilkinsonB95OE	Aniyah99@gmail.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/344.jpg	writer	2026-04-29 13:32:23.200359	\N
59	Lilian83Q9roW	Marlin.Oberbrunner@hotmail.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1222.jpg	stranger devotee	2026-04-29 13:32:23.2066	\N
69	Leonel37ZU6fX	Fatima_Parker45@gmail.com	user	https://avatars.githubusercontent.com/u/35654709	interconnection lover	2026-04-29 13:32:23.213038	\N
79	Malcolm.HagenesmmjsK	Andres_OKeefe@gmail.com	user	https://avatars.githubusercontent.com/u/30202988	artichoke advocate, dreamer 🎲	2026-04-29 13:32:23.221419	\N
88	Marianne_Dibbert50j37PK	Terrill58@hotmail.com	user	https://avatars.githubusercontent.com/u/85616957	singer, founder, musician 🤽🏻‍♀️	2026-04-29 13:32:23.236057	\N
99	Tyreek98wnWHr	Margarita69@hotmail.com	user	https://avatars.githubusercontent.com/u/78913855	mare devotee	2026-04-29 13:32:23.243577	\N
50	Darwin28vafvm	Maryam_Howell@yahoo.com	user	https://avatars.githubusercontent.com/u/44912178	educator, geek, engineer 🐈‍⬛	2026-04-29 13:32:23.2017	\N
61	Kiana.TownejjFCM	Lurline_Hilpert89@yahoo.com	user	https://avatars.githubusercontent.com/u/3098644	public speaker	2026-04-29 13:32:23.207958	\N
71	Keven_Hahn98ml0HG	Heather49@yahoo.com	user	https://avatars.githubusercontent.com/u/54523308	walnut advocate, person	2026-04-29 13:32:23.215152	\N
81	Willa24QnW6O	Colton.Roob4@gmail.com	user	https://avatars.githubusercontent.com/u/6357802	quinoa devotee  🛄	2026-04-29 13:32:23.223661	\N
90	Irwin128BLv1	Willow1@yahoo.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/506.jpg	model, creator, patriot 🚵🏻‍♀️	2026-04-29 13:32:23.236257	\N
51	Uriel948DSW2	Noel_McClure@yahoo.com	user	https://avatars.githubusercontent.com/u/73486232	oyster supporter, musician 🇲🇱	2026-04-29 13:32:23.202357	\N
60	Ericka.Graham31Rvouf	Hanna3@yahoo.com	user	https://avatars.githubusercontent.com/u/87071736	parent	2026-04-29 13:32:23.20771	\N
70	Ashley.Johns6JgvA	Gust.Ratke27@yahoo.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/128.jpg	claw lover, activist 👏🏾	2026-04-29 13:32:23.214138	\N
80	Marjory_Graham72aWjOs	Julio_Wunsch41@yahoo.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/825.jpg	geek, singer, musician 🤘🏿	2026-04-29 13:32:23.222528	\N
87	Vicky.WatersX18Uy	Ivah_Ritchie@yahoo.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/751.jpg	cord fan	2026-04-29 13:32:23.235548	\N
98	Krystal_Hegmann54GQOsN	Tara_Collins3@yahoo.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/937.jpg	streamer, streamer, coach 😉	2026-04-29 13:32:23.243357	\N
52	Maritza_Daniel19n22EI	Dino20@gmail.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/144.jpg	public speaker, geek, engineer 🌾	2026-04-29 13:32:23.202792	\N
62	Nickolas_Zemlak34n9XQ6	Chadd60@yahoo.com	user	https://avatars.githubusercontent.com/u/81606860	developer	2026-04-29 13:32:23.209951	\N
72	Earnestine45wAVpT	Xavier38@yahoo.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/270.jpg	egg advocate  ⏱️	2026-04-29 13:32:23.216997	\N
82	Darrin.VonRueden7xzpb	Samson.Kutch@hotmail.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/184.jpg	site enthusiast, student 🤲🏼	2026-04-29 13:32:23.224387	\N
89	Emmett9dqsZB	Vivianne_Schamberger@hotmail.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/845.jpg	veteran, film lover, student	2026-04-29 13:32:23.236088	\N
97	Quentin.Kunze27HL88b	Tyrese_Glover@hotmail.com	user	https://avatars.githubusercontent.com/u/72498703	edible fan  🏌🏻	2026-04-29 13:32:23.243372	\N
53	Augustus_BergstromM7bSX	Rosetta61@gmail.com	user	https://avatars.githubusercontent.com/u/67264570	patriot, developer, gamer 🧫	2026-04-29 13:32:23.202983	\N
63	Ashton18ehiBZ	Noemy_Metz74@yahoo.com	user	https://avatars.githubusercontent.com/u/21797330	crook devotee	2026-04-29 13:32:23.210165	\N
73	Emily.KertzmannjVjXm	Juliana_Grady-Dach15@hotmail.com	user	https://avatars.githubusercontent.com/u/91360652	screen advocate	2026-04-29 13:32:23.217829	\N
83	Erin_Gislason45Dn1EV	Antonio36@gmail.com	user	https://avatars.githubusercontent.com/u/57593084	grad, engineer	2026-04-29 13:32:23.225337	\N
91	Lauriane.Wehner94Uf0fa	Sonny.Lubowitz@gmail.com	user	https://avatars.githubusercontent.com/u/53549127	engineer, person, streamer 🚆	2026-04-29 13:32:23.236392	\N
54	Heber_Hauckeldkk	Everette2@yahoo.com	user	https://avatars.githubusercontent.com/u/5012810	starter lover, public speaker	2026-04-29 13:32:23.204201	\N
65	Sister.Haag51B3oy3	Owen53@yahoo.com	user	https://avatars.githubusercontent.com/u/63701096	leader	2026-04-29 13:32:23.210423	\N
75	Ian_GrahamNeFEs	Edmund.Terry78@hotmail.com	user	https://avatars.githubusercontent.com/u/74950402	pegboard enthusiast, business owner 🔬	2026-04-29 13:32:23.218628	\N
84	Amiya.SpinkaWOFXo	Susanna_Halvorson90@gmail.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/145.jpg	councilor advocate  🏓	2026-04-29 13:32:23.234238	\N
94	Reyes_Romaguera7s0tS	Baron_Connelly@hotmail.com	user	https://avatars.githubusercontent.com/u/19101592	educator, nerd	2026-04-29 13:32:23.24098	\N
105	admin	admin@admin.com	user	\N	\N	2026-04-30 07:10:49.279365	\N
\.


--
-- Name: auth_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_id_seq', 104, true);


--
-- Name: comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.comments_id_seq', 280, true);


--
-- Name: hashtags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.hashtags_id_seq', 20, true);


--
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.migrations_id_seq', 3, true);


--
-- Name: post_media_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.post_media_id_seq', 312, true);


--
-- Name: posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.posts_id_seq', 100, true);


--
-- Name: stories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.stories_id_seq', 32, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 105, true);


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
-- Name: IDX_0f735e8be0f9f8502dfa704f1c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_0f735e8be0f9f8502dfa704f1c" ON public.auth USING btree (refresh_token);


--
-- Name: IDX_116e9df57f5221cc1a77c3d1cf; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_116e9df57f5221cc1a77c3d1cf" ON public.saved_posts USING btree (post_id);


--
-- Name: IDX_41f5ee7a97e67023d7461fa8f4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_41f5ee7a97e67023d7461fa8f4" ON public.post_hashtags USING btree (hashtag_id);


--
-- Name: IDX_4c675567d2a58f0b07cef09c13; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_4c675567d2a58f0b07cef09c13" ON public.comments USING btree (user_id);


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
-- Name: IDX_97672ac88f789774dd47f7c8be; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_97672ac88f789774dd47f7c8be" ON public.users USING btree (email);


--
-- Name: IDX_9922406dc7d70e20423aeffadf; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_9922406dc7d70e20423aeffadf" ON public.auth USING btree (user_id);


--
-- Name: IDX_c4f9a7bd77b489e711277ee598; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_c4f9a7bd77b489e711277ee598" ON public.posts USING btree (user_id);


--
-- Name: idx_active_users_username; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_active_users_username ON public.users USING btree (user_name) WHERE (deleted_at IS NULL);


--
-- Name: idx_post_comments_sort; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_post_comments_sort ON public.comments USING btree (post_id, created_at);


--
-- Name: idx_post_media_sequence; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_post_media_sequence ON public.post_media USING btree (post_id, sequence_order);


--
-- Name: idx_user_post_timeline; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_post_timeline ON public.posts USING btree (user_id, created_at);


--
-- Name: idx_user_saved_sort; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_saved_sort ON public.saved_posts USING btree (user_id, created_at);


--
-- Name: idx_user_stories_active; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_stories_active ON public.stories USING btree (user_id, expires_at);


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

\unrestrict 9XVus50TrDxXKC0WLHw8ODFaMmT3HevQs9vb2YEhivzEunSadb5zimuJXCEVt3m

