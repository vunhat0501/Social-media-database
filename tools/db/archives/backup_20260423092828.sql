--
-- PostgreSQL database dump
--

\restrict OUfAsRbpYIe0kskZxHM2M82b8ObmOR2yAyDgpmRgFQAdu3tegU3fcs2XvSb5olk

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
1	t73Pt0wtiweRObT0MvdM	local	rKoEOogx0CboK4KYIRa5	f	C4XhKn9L0qkdU5npKt1v	2026-04-13 01:10:52.799663	1
2	JpwvZijUQU4ajwgoTavT	apple	rtrNfDtfNRUBENGPKxOy	f	HI0dmceYh9xGEIMZosHI	2026-04-13 01:10:52.80579	7
3	WE2x0nN5PqRhFSTqYH6u	local	Y7ZQAnV4JQU9F07WH1hz	t	C6XPCCQneMppqHH3lGeB	2026-04-13 01:10:52.809891	6
4	rWo_pTW7sEr5RiDQAhrz	google	KS2h5p5cYS6FJPjOlrI9	f	lY2GSDB3DNe3tHdMn686	2026-04-13 01:10:52.813716	4
5	H2EBPrNpRFDfVSBHE3Tq	apple	5y3Vjb5DqgsPMKHhd0Om	t	Fk0XId9Dxt70pERTEkmY	2026-04-13 01:10:52.825651	5
6	NJqCeOOgM909tO_J2KSN	local	jcm5G4xLS8gnRFqeELBs	f	xBJAvsEdceAY9IvGbjAR	2026-04-13 01:10:52.831755	11
7	VlMZ5zUafLKpBsxa4NZL	google	E9Xrnjj0ge7qz951GAHx	t	QtTTWlQc1aV779OCKIKa	2026-04-13 01:10:52.835778	89
8	642sHe_zVC2ORgNOE5un	local	tnEXZY3B5ZEFK4eys1q8	t	LJtAyq1xnrD4vrIYtm6O	2026-04-13 01:10:52.844746	14
9	WBCfbahheOwQMpMzAIWn	apple	OtsUFlmtbI3udznLeB81	f	GHnfrIOE0oI4yHwJYlez	2026-04-13 01:10:52.852776	90
10	JxIHoiQzIVIfVZfBdANB	google	LoD58APEIaTxrvTuUVPI	f	0ALVoA3lSXRnde20lDEJ	2026-04-13 01:10:52.86082	91
11	yYY1wePLn89000Y9MWRr	local	xIjYOwmvmhsYtBGj2QKz	f	HzNpc7ZNqxvi4vunR5FT	2026-04-13 01:10:52.865412	2
12	I9cAAf4wH17Vdk0ac_IH	local	jh2gfBaRhn63gKl7sT9c	f	0amxRh4dOTKjnydRoTj4	2026-04-13 01:10:52.87264	3
13	SquH8yO4S55dsHOPY8mz	apple	kscugvPbpsSD9hPY69EW	f	naOR6YxzP7HYwAenV6cN	2026-04-13 01:10:52.876203	8
14	3j0vtNkPkmk77U9aF1J5	apple	jo181rQmJ0cUQB5vuX3k	f	bqKdinu4CUOzo4kQ0pSO	2026-04-13 01:10:52.880574	9
15	iRpBssrvGvLVYdt3ZmRL	local	OIFuI8peLo3x1uHmiI3w	f	UQL3zG6kpmcKGxjRTQWS	2026-04-13 01:10:52.883797	10
16	Wsod0jymybto0qPRsny9	apple	dD5MoZyaq8EET1ODYxsm	t	72vF01bToihby49A6RaI	2026-04-13 01:10:52.888596	12
17	uvQCaNxFAV96_1GOthKi	apple	6T6k2tt4NmEdvQl0qqTc	f	ht2Q22h9TiDCRC0RG7k7	2026-04-13 01:10:52.892198	13
18	hVylT_0QNjTHrBogQ9iA	local	tX4BBf9Ek9Wund53fnoO	t	ooxk73E6L51aXJjZpXsr	2026-04-13 01:10:52.895255	15
19	MW7l7fg3PQWaBuHDffvW	google	pqYrXlTWz1iY7xSWzJBN	f	UXUedIhseZKnbRCo8Qdz	2026-04-13 01:10:52.901477	16
20	YpjP5SXZE_nwlN0jYiyL	local	1zPa3Jd2AnbBhuhXPQXI	f	RH5ZxQH7Fidb1IRi1qmS	2026-04-13 01:10:52.904678	17
21	cypnCmo0EXRfQER442lA	apple	c371etux1afs0lKfAjDV	f	Sh8hcreKDn7ykK6tTPt0	2026-04-13 01:10:52.91184	18
22	M4hmAuwnotesOUXEpXP4	google	t26RmKk2NMfX8cUoLsv6	f	dtPrWco6Sw0XRNeZ0B91	2026-04-13 01:10:52.918481	19
23	2unuzeN3H3evcQCboeZQ	local	81EjW900wTe9yseVcX0q	f	ROIKevsQVGpKxsRTurDl	2026-04-13 01:10:52.92639	20
24	A5hnCJiKaQuX0mreT4IO	apple	iPYeEycGHzm1L6L8tAQs	t	QFwHcHJUReHTdpbdsfkG	2026-04-13 01:10:52.932989	21
25	rWMz11cDGar_pPbSgthi	apple	4Vqwz7seNNrSVJuqHilE	t	wRrJeyV5lUEFcwli1hH6	2026-04-13 01:10:52.936043	22
26	n9xG_zYyBF75miWfiTMg	local	wDtSQsEVZ3zrfx1fcJPS	f	8ce9fPYOqNwc9cjush77	2026-04-13 01:10:52.939844	23
27	P5QxXOxI7vABaW5N1vgd	google	WZ422Hl9xnMboggLFYox	t	iYjXjrJfnXFkBxOXQke0	2026-04-13 01:10:52.947448	24
28	mJFudd3JhGTXKRgpJYFK	google	8S4YVI6FTx1AFawRJ9vM	t	u6wEk8H6gPrDHrRJQ1y3	2026-04-13 01:10:52.950645	25
29	EFLmN1DK7AAxA5sM4Tjy	apple	V8V5ItkG8A7P5YFCjZzY	t	iAIND1WLQFxPFEeYwKzu	2026-04-13 01:10:52.95894	26
30	usui7CQrS8jvo8tRan5Z	google	5Jh2qVLH2VxBciVZxzrN	f	XIBuW4M3sjPKthjivcfl	2026-04-13 01:10:52.966872	27
31	HTJpNOEexrMPa8faKdo3	local	cMxKI2Q8xKzZgylfPUhE	f	Eewi9dpRfrY1QyyUhcjp	2026-04-13 01:10:52.969737	28
32	Jz6fqSCUVHVIGUu8l0Dn	google	BJUE4W38R9WzyXehswO2	f	FXz5j0zignlzJlmfKjOA	2026-04-13 01:10:52.973815	29
33	V3zGkkDz_67P25j2l3ui	google	a21bwmce88MObvloQcZ3	f	VvU7FbhLFzdJuUeQvAED	2026-04-13 01:10:52.978049	30
34	LxdFnBcu3tFJ2GP8wMLR	apple	rp3HL4rgSR9huOo99BxM	f	fCUAOMdRuuBDcJ9Yu2UB	2026-04-13 01:10:52.984629	31
35	pcqW6iIZ1DEvJTD8cLxz	apple	zrG1oP9zI5IoUaXtOqT3	f	msptaLs0jIOPk7qjd93s	2026-04-13 01:10:52.99476	32
36	H4uH7STpgvRgK6ssBodf	local	tfZLfUAtBbKmiaVfsBfo	t	sYed6WbeANix0QCWySgj	2026-04-13 01:10:52.999813	33
37	lK7B1_sUUWVtFOYM1hbL	local	OY2vGBPiNyAB5tK50Now	t	ouUsFoM7Sg40Piy72dcK	2026-04-13 01:10:53.00324	34
38	7gYvPc5MyuhxNZ94r9YI	google	3586biE6KSbCsgHN3bQe	f	GIPTLHZoqBmac8wOIzSj	2026-04-13 01:10:53.007539	35
39	GnRRSrTRRMcLHTjZDW9H	google	zfjiTGqeNfcoQDjVK8F3	t	btdBur0PIOX6FsqhWxLf	2026-04-13 01:10:53.011624	36
40	ric17Pc2falq13kKSVjj	local	IwUHSOaug4q4bTxdiKd9	f	BeydMuUDARnitWrf0ndd	2026-04-13 01:10:53.018305	37
41	kLJfZwICWtxf1KMSVkCW	apple	SuBXmdW550ZYUSoQAcbx	t	HFCSlvy3il2gQmWGYgRD	2026-04-13 01:10:53.025366	38
42	gmYahJMwr4vOW9Dl1B1F	local	qaQGEhn7TgLv5rRbCHru	t	UcYm9Z3LQqvaPPmVfkHq	2026-04-13 01:10:53.028948	39
43	pGzXW_W6Jdeqd5yGFhdv	google	bwSlZlE6R9VIsaSbf5Jl	f	XVsfLRqej2J5ZBrIY4Or	2026-04-13 01:10:53.032158	40
44	H939yp3s2IUONEld9zh6	google	5O778IURQVKQWO0dS5Bv	t	RM8yikl0aykh6U6YqOFH	2026-04-13 01:10:53.035162	41
45	qumvFgZO0ncReRTNQuF1	local	vy0xfJNZ6Qrb49JMDJYs	f	APOfGaFRRN4HAddEOnjN	2026-04-13 01:10:53.039024	42
46	Ez6GdoyECDFHVRK1OQRE	google	sTbHXa52onoDMQKsYHfM	t	7skjVmjjA3A3EYIUIRHb	2026-04-13 01:10:53.043473	43
47	7gsAk7Cw6kHBxmAdAz0a	local	SDRkhv0k2tFrVJwzAZZK	f	yaSTuTDpQCa1cUmzi4Mf	2026-04-13 01:10:53.046695	44
48	Zmdf8Ypcr2EZiCp7aA6H	apple	R8avUvDamOLQdQOscpqw	f	S27Efyex20fN9SEfRNuj	2026-04-13 01:10:53.049451	45
49	KViWZoBf3NDdFxVP13RU	local	N8pICb4EaNFcO7U0WwEJ	f	sTCzQhldUxpjYRUt3len	2026-04-13 01:10:53.052127	46
50	5W_yRcnZMxjbQs0j1nx3	local	iWLx8xDTqfkjYZ3y65VF	f	OFgs25RHJFOmIvc6SlAY	2026-04-13 01:10:53.055929	47
51	V4BZ_R6CRF57dmDFkax3	local	CqjS0q5XQEDOXkvSchEp	f	Swb62bIYfepDhKAX4GBy	2026-04-13 01:10:53.060357	48
52	VmMSNB60L8K01Ix5pOWE	apple	hruZuM1oHp4lPh9KEqN6	f	AEs6uVypUbZCPGLmrTlw	2026-04-13 01:10:53.066817	49
53	WT4xMrZZwtyCojpSfwKl	google	7rZqordKUuqGgb6OTuz5	t	kx0nsTxsQBaWWvxLsLtx	2026-04-13 01:10:53.070321	50
54	JS1ob0U23wECtNpcLm_O	local	ar0dwFa825muOqfFuyVS	f	PG6jJkJTefMQ2Op8UgvT	2026-04-13 01:10:53.07416	51
55	laUn9uwMnSdOzpbI30jw	google	yjq0sf68CKfi7PG3QA8s	f	GDWRxkM88nAv1ahfZxW8	2026-04-13 01:10:53.077932	52
56	Tf4xmxmillUX8UbPstpl	apple	DVufSLV8n2GHC37gO5XT	t	D5tm5LXEUCCI4Ub0I20D	2026-04-13 01:10:53.081664	53
57	k6aMl84bu4nZPAuiOOB1	apple	psiB1ZSTpudcVGskuATO	f	yIYkfovhM3UiobOCAli8	2026-04-13 01:10:53.084311	54
58	tT55_z7xMDG9frKw7CKe	apple	WUTfaaG7J9e4pTSJ8LJN	f	reLMdJYWanq8Px0YijwL	2026-04-13 01:10:53.0911	55
59	LAl2NWtWEh8Yhs4tsoCJ	google	sxIOFKoWV8jSThJz4g5Q	f	mgA1L11tSovSpmXs0sVe	2026-04-13 01:10:53.098189	56
60	z5CaczJ8rlo7HzxYPoqs	local	Er96llOVUOUTe63YFB0a	f	oN8TCKMnvj2hLf0w1pjO	2026-04-13 01:10:53.101666	57
61	_cDMLffJLYYKVREqBPYv	apple	0u4JNhCNA3Jq5rgivaY2	t	sAIKnxWqOUZfKKACoDPF	2026-04-13 01:10:53.105554	58
62	2iflIxOEUd1EpbVVZ312	local	Sm34ctkLTpnzD5MAR88H	f	Tt2C2SUtPmCpnTNWXgCZ	2026-04-13 01:10:53.109809	59
63	8saNpOoT76o5zyMt5Veu	local	WA3n0BQeHUIJQJNpZAyv	f	16fhQ4G99J6HLJaY4Rw7	2026-04-13 01:10:53.115741	60
64	aUBPnyfSNJLBo8WuyqIM	google	UaKBNCo2GX41KTbn6ovJ	f	V546bkw7AcLjmyl8AQJP	2026-04-13 01:10:53.118703	61
65	w3deUHLn7jKQ9PyFNmhs	apple	xYDFF2bvwKNkCRkY1Yxs	f	Xk4rOCWU1X0PMbOXfVpD	2026-04-13 01:10:53.121379	62
66	BVmmtk8umr40jyovbqMF	local	82KIBEHhwwHjJwvjG8TH	f	TTEMxX0RZYn8Guqfmrk9	2026-04-13 01:10:53.128914	63
67	3FHUO4AaT6Kxcrj2SQIX	local	1zsepRRo1c8eT8KRwleN	t	zpc76nGsPjeRowBgIdWF	2026-04-13 01:10:53.132751	64
68	n3kWCQwwE_nsGj08ptNo	google	FwhhTFqTMMmfwxsPO0Bb	t	ISQ4wBxWeRO5iAus2ESA	2026-04-13 01:10:53.139282	65
69	vQ8lOPwnBkoCwAdZG2Cx	local	bXFUYJLmFscdDDVta4WA	t	NPE8t27CdPZKm1Wsdr0O	2026-04-13 01:10:53.142681	66
70	fSgJu4X3f9qIKqh250e4	apple	DK0fL0y4mNqe6gP152Gb	t	2nqPFiZ1VAQgGjt8BStR	2026-04-13 01:10:53.146364	67
71	6slboLX1Tum7UF7NhcuY	google	uw9LpKExmmts17cuNTFv	f	FTrGxa5B4MqMqXo0sDn8	2026-04-13 01:10:53.148988	68
72	5XDjAXJ6UOdxeL3Bz5tG	apple	g0Y04g1nQXdyUGaPkByP	t	xHJzgZVXezMBwJek58NK	2026-04-13 01:10:53.151347	69
73	QRBryYuppxqVpwZ2iko5	google	KVFWJtTjD91b4Hu5W4t7	f	Bantp5eRrL9U02pnpruD	2026-04-13 01:10:53.15735	70
74	ks9WqLk58yCdrdfZ4dGY	apple	vuP3GXpHM8fHspSp9fTr	t	UvpQuLFr2mfbSwOMkhYI	2026-04-13 01:10:53.16144	71
75	vejgGlRgH1W_iw8kbwVi	apple	MGRyExNhKHC65q7TwTSr	f	A8CygFvad4suyV5650CY	2026-04-13 01:10:53.164601	72
76	LLYmIbjrVJTtifPUD_Mr	apple	tvnFU1xYKUBfuNcYCiz5	t	TBnUXHH1xahHZ8isrInE	2026-04-13 01:10:53.167653	73
77	uiDECak54uzvTBsCK7WE	google	pGTp6tBPwzTSXV4I5uNz	t	ENM5fZP3vozdk3viCNgY	2026-04-13 01:10:53.174993	74
78	50286AuRfQzTqmGIKmoa	google	r9ItHYPn7MqZ13xHrtZc	f	F9qc7eRmIAYkYNYhzSzq	2026-04-13 01:10:53.179279	75
79	mpiimVu8Nog7CPOYbc1w	local	RCLcTwjYkLWmeechPMms	f	pBnWRxDsTLgOPU1Zx3xu	2026-04-13 01:10:53.182465	76
80	ibm0QDIlaZuSowetd8dA	local	A9Sirp1cI0ynZgOOcaWK	f	wLpupVlruZDwEqlHwwN4	2026-04-13 01:10:53.185	77
81	DKgFmU8kLwexhhmcyeaT	google	rXBU0NlptBeCc03yv1NZ	f	qiKt3lTeSTxe8TTKVtam	2026-04-13 01:10:53.187596	78
82	u9E8VySNg77WvCdwGN2U	local	jbh6vPnr5NG4UcWYiDAc	t	42CJdj3I8IKLU0yh2MFJ	2026-04-13 01:10:53.191891	79
83	o5QVfd3m6YFJ_b9opz2P	apple	vnoPtB8cO7fDtTSbYIuW	t	hBijXabjfw2CgX7uEkzu	2026-04-13 01:10:53.195468	80
84	gE_D_exsAOhPz3bBzI_Z	apple	bNCsll4Yl9LzMbXeWSWK	t	vn15eJKNYItSaGWFnGAO	2026-04-13 01:10:53.198084	81
85	I49aG9ZAZAurMsIv4XTf	local	Y8cqVK8Eluog2TqLnxQm	t	0lCFuSNzJExDEfbmNtkS	2026-04-13 01:10:53.201141	82
86	Poc0_DUOBwFkWrX4nx3y	apple	ioFParTCW6eMdIa3Yv3c	f	CCaKWo5mectozmbfPlQZ	2026-04-13 01:10:53.2044	83
87	s1pZLSW7dx48CE6JRXYz	apple	wvFutINaW1u9irvOEkyK	f	glUeJhCVW3APUQVfB3uh	2026-04-13 01:10:53.20849	84
88	LNFA1vuCN5Droy3snw5n	google	YAsfyxDic3iVFo3cRYmJ	t	MaUdjCEyJF7GVcVPKLKf	2026-04-13 01:10:53.211927	85
89	ZcQZKGMS99oKpHU9wFqF	google	dcuscYAkbmFzqgHRi4s2	f	xuRRZHq55We0wgto3Gks	2026-04-13 01:10:53.215416	86
90	oYDuCLVjJ6JYAI_Okj29	google	OkLorZIfGt9UOp2kIdXs	t	l5gGJ3ZqeDnPn82tCzrT	2026-04-13 01:10:53.220702	87
91	0JcYQ_zGJavLlukEaNlu	apple	Z8qp6aUtn8SlVR2zCLcS	t	YQ9c8sqGnPrp96IWpfne	2026-04-13 01:10:53.228578	88
92	RfX_gyF_1wsYjjDXXHJE	local	4RWyyqULvp8YhLzN5pqU	t	uo9KI0PeOnai1BNC0qTG	2026-04-13 01:10:53.23111	92
93	LX_vuxL9xiWou8Rxqqtq	google	ciorUmobEOG8l0YbS9Pz	f	mBlFAYpisUYuykpcO5dg	2026-04-13 01:10:53.236703	93
94	KucZRa1Io3lN2IJrLHRz	apple	CcVamIeEu5nVLxIuTxPA	t	hAdBhLwgvueCqUDKYoeN	2026-04-13 01:10:53.244319	94
95	moCBVbkefi0ZvMVPaeVW	local	HNqbfz34QbhOIxlDg4GY	f	Dm7cjg9M7w0qrl1GhaYa	2026-04-13 01:10:53.246837	95
96	3sefhDiOjAQLfl88qY79	google	ZoV1IoQDBpjxtjZZebuf	t	02eTzoMT3LRbQFVMfcX0	2026-04-13 01:10:53.249616	96
97	MXLQTIqjRhUY06YxAL3U	local	iZIurrtMQYxQmPiAZlOn	f	TJWcWPEkxJvcDtcvuupY	2026-04-13 01:10:53.255757	97
98	B7lLmXaHBZPiTCaOwXhP	local	2e3jfkajgSpaqVZWhMSe	f	eUNdq8lCqsFOE7H1SKWq	2026-04-13 01:10:53.259666	98
99	aYAnrRxeqx9QmlpR7ytk	google	TUDc11sPAP3Utc8OD18e	t	mJHU5jJIkSc0lDsVrOjS	2026-04-13 01:10:53.262858	99
100	DXWD_f0UY4GL_vgYEaGH	local	McrtJ5OBa0snY3E4kiNr	t	mYlbHbZfleTC7BkkbXdo	2026-04-13 01:10:53.265171	100
101	$argon2id$v=19$m=65536,t=3,p=4$BZ/2DeZu6ZeN/Z+lJ0ogYA$gIfRlfF/6A+stHgoQWi+lYR5Q3Ga4Kk8jSo6zuH3lI8	local	\N	f	$argon2id$v=19$m=65536,t=3,p=4$9M5zoZheyfncbkNqIbUiSg$QqncSNKQzl3/4M2UmoTttC8IfIkmEubqExx7/hb7WmU	2026-04-22 08:13:09.971779	101
\.


--
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.comments (id, content, created_at, user_id, post_id) FROM stdin;
1	Love this so much	2026-04-13 01:10:54.336838	70	1
2	This is amazing!	2026-04-13 01:10:54.341594	28	1
3	This is amazing!	2026-04-13 01:10:54.345163	7	1
4	Astrum totidem desolo et saepe civitas.\nColligo terreo deripio.\nAppono cunctatio patior copia causa decimus aeger cicuta circumvenio.\nCoerceo advoco brevis super venustas deleo autem.	2026-04-13 01:10:54.348545	84	1
5	Angulus aer aqua celo.\nTempore complectus arbitro civis vociferor claro colo.\nBeneficium tollo compello compono statua aestivus conduco.	2026-04-13 01:10:54.351975	27	1
6	Distinctio ad doloribus saepe consequuntur voluptate crustulum tunc.\nPel concido nemo artificiose cursim strenuus depromo caelum sperno mollitia.\nCredo comedo admiratio territo quidem aggredior civis defleo unus thymbra.\nCedo corrigo cedo arx peccatus aveho.\nFugiat supellex tenetur tristis brevis allatus degusto.	2026-04-13 01:10:54.400358	2	2
7	Love this so much	2026-04-13 01:10:54.403069	14	2
8	Love this so much	2026-04-13 01:10:54.406896	56	2
9	Where is this?!	2026-04-13 01:10:54.41119	37	2
10	Where is this?!	2026-04-13 01:10:54.414353	7	2
11	Modi perspiciatis balbus decimus incidunt velut. Atavus tantillus debeo cibus quam vicinus conforto ago vis tactus. Adicio alo basium speciosus baiulus cultura.	2026-04-13 01:10:54.46761	2	3
12	Vehemens templum trado deludo valde arbitro caveo veritas provident cohors.	2026-04-13 01:10:54.47023	90	3
13	Love this so much	2026-04-13 01:10:54.473399	41	3
14	Culpa sublime vulgus bene cibus deleo tunc.\nPerspiciatis nesciunt laudantium crinis pariatur capio quos magnam vigilo umquam.\nBonus balbus colligo candidus atque.	2026-04-13 01:10:54.503863	96	4
15	Convoco temeritas esse caries rerum adsum trepide.\nSolio tondeo aeger vix tenus angelus video averto laudantium arguo.	2026-04-13 01:10:54.506759	86	4
16	Where is this?!	2026-04-13 01:10:54.510126	32	4
17	Autus sto suspendo brevis turba calamitas adfero.\nDemum deficio aetas creator umbra nam artificiose compono vitium tempus.	2026-04-13 01:10:54.5133	13	4
18	Where is this?!	2026-04-13 01:10:54.515959	65	4
19	Where is this?!	2026-04-13 01:10:54.543409	33	5
20	This is amazing!	2026-04-13 01:10:54.546015	20	5
21	Where is this?!	2026-04-13 01:10:54.550164	43	5
22	Viriliter deinde agnitio amissio caste demitto certus. Tredecim ciminatio verus vulpes demonstro currus. Tabesco tot corroboro.	2026-04-13 01:10:54.552387	35	5
23	Contabesco suscipio auctus.	2026-04-13 01:10:54.555977	77	5
24	Cena quaerat atrocitas vulnus facilis praesentium veniam pauper. Ustilo curatio civis certus coniuratio stipes cupressus cultura autus sodalitas. Tepidus cribro utpote.	2026-04-13 01:10:54.643653	62	7
25	This is amazing!	2026-04-13 01:10:54.647414	10	7
26	Basium tertius cresco advoco terreo omnis. Statim tot degusto creber. Damno assumenda vivo volva adsum.	2026-04-13 01:10:54.706869	52	8
27	Inventore comptus cogo.	2026-04-13 01:10:54.710794	66	8
28	This is amazing!	2026-04-13 01:10:54.713443	32	8
29	Cum crastinus avarus argentum modi admoneo denuo valeo vae.	2026-04-13 01:10:54.715793	6	8
30	This is amazing!	2026-04-13 01:10:54.718374	23	8
31	Vindico vilicus ciminatio supplanto ambitus. Adinventitias repellat terminatio quia recusandae. Saepe adipisci conventus aureus cupiditate aptus.	2026-04-13 01:10:54.812105	38	10
32	Administratio deporto capillus cogo somniculosus. Agnitio admitto ante adamo benevolentia virga voluptatum sono debitis. Culpo alias cimentarius teneo adsum.	2026-04-13 01:10:54.86989	50	12
33	Where is this?!	2026-04-13 01:10:54.872753	69	12
34	Infit vita sponte adstringo ea nisi. Commodi vox amplexus theologus velociter nihil avaritia. Bestia arbustum solus vix.	2026-04-13 01:10:54.910083	35	13
35	Sol atrox spargo admoveo talis.	2026-04-13 01:10:54.955891	61	14
36	Cubicularis demens xiphias decipio temporibus verbum.\nCunabula consequuntur super cupiditas tutamen somniculosus apparatus totam crur auxilium.\nVersus calculus aliquam virga.\nBene theca vulpes appono turbo strenuus absconditus.\nDolorem volo soluta eligendi victus.	2026-04-13 01:10:55.011009	9	15
37	This is amazing!	2026-04-13 01:10:55.013382	31	15
38	Amplitudo abundans cimentarius comedo comes. Cado votum toties ulterius tondeo recusandae ulterius cursim civis. Attollo dedico curo.	2026-04-13 01:10:55.015723	10	15
39	Love this so much	2026-04-13 01:10:55.018257	87	15
40	Ipsum virga summa adeptio vallum crustulum voluptatem totidem.\nVinco tumultus clibanus statua audentia absconditus cauda.\nCopia occaecati absum dignissimos.	2026-04-13 01:10:55.070598	44	16
41	Where is this?!	2026-04-13 01:10:55.144706	13	18
42	Love this so much	2026-04-13 01:10:55.181869	65	19
43	Where is this?!	2026-04-13 01:10:55.184243	22	19
44	Voluptate ultra vigilo conqueror ipsam voco. Ut crepusculum sto circumvenio sub cresco vinum decumbo. Contra supplanto ultra defaeco audacia virgo attollo.	2026-04-13 01:10:55.187168	71	19
45	Where is this?!	2026-04-13 01:10:55.190164	92	19
46	Love this so much	2026-04-13 01:10:55.194225	44	19
47	This is amazing!	2026-04-13 01:10:55.286581	13	21
48	This is amazing!	2026-04-13 01:10:55.289806	16	21
49	Varius venustas comes similique adopto.\nTremo harum tubineus cupio deserunt uredo neque vetus.\nTraho non votum possimus cuppedia celebrer balbus.\nAetas commodo patruus amplexus casso occaecati.	2026-04-13 01:10:55.293108	91	21
50	Compono tardus ager vobis accedo delectus tempore sollicito.\nVilicus peccatus benigne deserunt sperno cotidie canis thymbra triduana.\nUtrimque vinco autem averto sublime causa derideo decens.\nDecor quia denego.\nAudacia tertius antea damno.	2026-04-13 01:10:55.336635	9	22
51	This is amazing!	2026-04-13 01:10:55.340005	100	22
52	Where is this?!	2026-04-13 01:10:55.34402	68	22
53	Volup cetera decipio cunabula rem cupiditate advenio. Cohibeo caput testimonium celer viduo voluptatum aeneus curatio solutio. Deporto ancilla cogito.	2026-04-13 01:10:55.398334	21	23
54	Where is this?!	2026-04-13 01:10:55.437818	84	24
55	Love this so much	2026-04-13 01:10:55.441685	11	24
56	This is amazing!	2026-04-13 01:10:55.445075	90	24
57	Where is this?!	2026-04-13 01:10:55.447704	2	24
58	Culpo bellum arca alo tondeo inventore desino.	2026-04-13 01:10:55.473259	72	25
59	This is amazing!	2026-04-13 01:10:55.530858	74	26
60	This is amazing!	2026-04-13 01:10:55.533229	62	26
61	Supellex aurum conscendo alveus.	2026-04-13 01:10:55.535875	19	26
62	This is amazing!	2026-04-13 01:10:55.577874	76	27
63	This is amazing!	2026-04-13 01:10:55.580634	23	27
64	Love this so much	2026-04-13 01:10:55.584225	67	27
65	Clamo supellex reiciendis appositus amicitia.\nEum tergum trado eius.	2026-04-13 01:10:55.614317	18	28
66	This is amazing!	2026-04-13 01:10:55.617096	78	28
67	Eligendi suffragium tactus provident comis. Utrimque ut curso addo aliquam sumo virgo est canis dedecor. Adfero deputo dens cumque ullam coaegresco custodia caelestis solutio adinventitias.	2026-04-13 01:10:55.620032	89	28
68	Error conitor curriculum suggero uterque termes tenus sperno tergiversatio.	2026-04-13 01:10:55.62416	24	28
69	This is amazing!	2026-04-13 01:10:55.627614	30	28
70	Substantia vacuus temperantia celer. Cenaculum demergo cursus. Defungo ex baiulus thermae provident vacuus molestias.	2026-04-13 01:10:55.748568	52	30
71	This is amazing!	2026-04-13 01:10:55.781351	32	31
72	Love this so much	2026-04-13 01:10:55.81578	37	32
73	Love this so much	2026-04-13 01:10:55.817899	8	32
74	Admiratio eum aetas vado iste repellat amet saepe vos.\nSursum corrigo tolero adamo pax astrum.	2026-04-13 01:10:55.820598	43	32
75	Degenero angelus tredecim patrocinor velut contigo stips. Accusantium defungo sit ciminatio accedo conatus. Aureus vulgus demonstro ambulo.	2026-04-13 01:10:55.873967	11	33
76	Aveho articulus verbera carus adiuvo amplexus tricesimus thorax cumque vero. Apto bonus crapula in officiis. Comparo voluntarius vallum viscus degenero toties demens claustrum architecto.	2026-04-13 01:10:55.920778	71	34
77	Where is this?!	2026-04-13 01:10:55.925146	33	34
78	Adhuc utpote appositus tripudio socius modi torrens asperiores victus.\nTalio inflammatio caterva deludo callide.\nExpedita avaritia demum non crudelis sunt apud exercitationem.\nAbundans sulum subvenio alienus.\nQuo capitulus temporibus admoneo attonbitus congregatio pel audio vorax.	2026-04-13 01:10:55.928444	59	34
79	Love this so much	2026-04-13 01:10:55.976048	58	35
80	Love this so much	2026-04-13 01:10:55.979632	87	35
81	Where is this?!	2026-04-13 01:10:55.982112	61	35
82	Where is this?!	2026-04-13 01:10:55.984696	4	35
83	Cognomen cur civis derideo sursum cunae conatus defendo vesco iure.\nAperio conitor appositus absens curto comminor cetera suscipio demonstro.\nAlius conor repellat repellendus tabernus adeo creator.	2026-04-13 01:10:56.032312	28	36
84	Abduco autus artificiose attonbitus damnatio concido aedificium umerus corroboro. Thesis sol cimentarius adstringo vinculum carbo alter sustineo. Abduco summa deputo clam.	2026-04-13 01:10:56.034871	37	36
85	Love this so much	2026-04-13 01:10:56.036932	61	36
86	Ait aggero carbo casus debitis succedo velum armarium tenax terra.	2026-04-13 01:10:56.066108	29	37
87	Veritatis tui doloribus voluptate tenetur.	2026-04-13 01:10:56.069048	45	37
88	Love this so much	2026-04-13 01:10:56.072717	13	37
89	Dignissimos coniecto volo corrumpo.	2026-04-13 01:10:56.076496	83	37
90	Love this so much	2026-04-13 01:10:56.098126	56	38
91	Where is this?!	2026-04-13 01:10:56.100754	63	38
92	Coruscus consequuntur dapifer compello bardus civitas conturbo.\nAdmoneo volup surgo virtus.\nCultura adsum bardus defungo crur auctor.\nCompono custodia cresco.	2026-04-13 01:10:56.103096	95	38
93	Careo soluta coadunatio unus cohaero decipio absconditus amiculum.\nTempus bardus inflammatio.\nSpargo subvenio turbo.\nTibi voluptatum deprecator damnatio arbustum.\nSoluta tunc ascisco armarium exercitationem baiulus angelus solvo vulariter vesica.	2026-04-13 01:10:56.106613	10	38
94	Sono sordeo auctor thorax antepono copiose.\nAperio ulciscor aut bis sulum supplanto corrumpo cerno vacuus arceo.\nAter ara deleniti nam paens.\nIn a dens.\nConfero vero patria antepono ustulo delectus caste.	2026-04-13 01:10:56.297155	91	42
95	Amicitia crudelis artificiose vox.\nVere voveo reiciendis ulciscor cotidie totus explicabo trucido vulgus eum.\nAranea decipio sophismata valetudo ars depromo bis commodi.\nTheca molestias voluptatum.\nVelut decens varius.	2026-04-13 01:10:56.366276	18	43
96	Love this so much	2026-04-13 01:10:56.40316	37	44
97	Where is this?!	2026-04-13 01:10:56.406734	69	44
98	Love this so much	2026-04-13 01:10:56.410554	75	44
99	Corrigo celebrer ciminatio aro comminor cresco vel appono.\nSolvo alter creptio praesentium surgo tumultus vae.\nTabgo adhaero cognatus vomito talio.\nSunt vulpes incidunt.\nViridis suspendo absconditus eveniet temptatio una voluntarius.	2026-04-13 01:10:56.413289	72	44
100	Cenaculum odio conspergo voluptates catena uxor tenax quia tero vulgo.	2026-04-13 01:10:56.466108	4	45
101	Curis villa succedo cattus dapifer studio eligendi aegre. Tergiversatio confido uxor vis dolores. Tamquam copia depopulo pectus.	2026-04-13 01:10:56.468825	3	45
102	Deinde sono decretum.	2026-04-13 01:10:56.509181	95	46
103	Coruscus succurro tandem vomica adaugeo suus creator.	2026-04-13 01:10:56.512885	41	46
104	Where is this?!	2026-04-13 01:10:56.516128	77	46
105	Contra truculenter temporibus. Despecto via depulso. Curriculum confero cubo.	2026-04-13 01:10:56.612631	22	48
106	Where is this?!	2026-04-13 01:10:56.616067	60	48
107	Love this so much	2026-04-13 01:10:56.686337	25	49
108	Where is this?!	2026-04-13 01:10:56.690167	52	49
109	Tunc tepesco derideo. Absorbeo coniecto crepusculum carbo despecto uterque. Taceo vilitas nemo ambulo alias creo antiquus solus.	2026-04-13 01:10:56.69438	55	49
110	Votum vicinus abutor claro tripudio audeo.	2026-04-13 01:10:56.697692	51	49
111	Where is this?!	2026-04-13 01:10:56.700988	99	49
112	Love this so much	2026-04-13 01:10:56.750163	67	50
113	Auctus suggero denego ex commemoro commodo alioqui similique attollo. Statua adhaero tonsor conservo vivo substantia aduro acquiro usitas. Illo adfero talio absum.	2026-04-13 01:10:56.75285	17	50
114	Love this so much	2026-04-13 01:10:56.790529	86	51
115	Where is this?!	2026-04-13 01:10:56.794152	12	51
116	Angulus porro dolore adulescens pel curriculum advenio agnitio degenero sponte. Vigilo ceno tot tibi argentum cunabula autem. Quod suus et.	2026-04-13 01:10:56.796592	91	51
117	This is amazing!	2026-04-13 01:10:56.799004	70	51
118	Where is this?!	2026-04-13 01:10:56.801787	45	51
119	Stips acies creta vulgus vero cubitum thesaurus.	2026-04-13 01:10:56.825311	59	52
120	Celo officiis solus capillus benevolentia thymbra complectus adsidue vitiosus tubineus. Crastinus perspiciatis cresco deficio sunt. Conturbo vir nam velit cicuta sopor.	2026-04-13 01:10:56.828724	98	52
121	Quidem ventosus antepono distinctio caritas totidem stillicidium vulgus desolo tardus. Accusantium volo vapulus cibus thymbra denuo tremo. Quaerat aetas autus arcesso delinquo cui totam atavus custodia.	2026-04-13 01:10:56.857239	9	53
122	Carus bis quas perspiciatis suasoria adnuo animadverto stella atrox.	2026-04-13 01:10:56.86099	94	53
123	Love this so much	2026-04-13 01:10:56.864463	51	53
124	This is amazing!	2026-04-13 01:10:56.90043	57	54
125	This is amazing!	2026-04-13 01:10:56.903205	81	54
126	Patrocinor vereor adfero suffoco.\nNeque creator apparatus cumque sumptus colo cena amplus depulso.\nPeior comis ceno viduo saepe cotidie.\nComes ait suasoria vulgaris coerceo.	2026-04-13 01:10:56.906035	61	54
127	Ver itaque cohors abundans amita vilicus demum absque thalassinus. Officia defessus valde caelestis umquam communis beatus coaegresco capitulus vel. Articulus curso tempora sustineo vulgus umerus id vigilo alius.	2026-04-13 01:10:56.909162	87	54
128	Unus acquiro umquam demergo campana caveo consectetur.\nTabella cras sunt vulnus caste aro.\nAliquam ulterius urbs traho.	2026-04-13 01:10:56.934444	56	55
129	Coma umerus totam. Suggero defendo concido tumultus absque virtus infit. Cupiditas ancilla calamitas illum vobis curiositas.	2026-04-13 01:10:56.937598	43	55
130	Love this so much	2026-04-13 01:10:56.941406	58	55
131	Where is this?!	2026-04-13 01:10:56.992549	78	56
132	Admiratio capto adhuc aperio.\nAcquiro deduco cohibeo.\nTempore cenaculum dolorum unus caelum angulus denego.\nTero depono laudantium.	2026-04-13 01:10:56.995664	95	56
133	Id cohaero stillicidium suppono tempore auxilium bis creta cur defessus.\nConiuratio culpo illo vallum talis cogo viridis perspiciatis vado adnuo.\nAnimi delectatio utique defungo carmen adversus.\nSopor auctor attollo sumptus summa conspergo.\nNatus suppellex adicio advoco pecus.	2026-04-13 01:10:56.998215	42	56
134	Love this so much	2026-04-13 01:10:57.000834	16	56
135	Aegrotatio tergo eos. Voro contabesco vir thema rem placeat alienus barba venustas. Defaeco curso quod talus incidunt eos conscendo vetus vapulus adficio.	2026-04-13 01:10:57.054985	50	57
136	Adicio iusto capitulus cur damno arma pax venio.\nSpiritus amor atavus eos arbustum titulus.\nAltus sono peior antepono conqueror.	2026-04-13 01:10:57.059424	65	57
137	Demo turbo paulatim balbus cohibeo totus thymum creator amor veritatis.	2026-04-13 01:10:57.062656	100	57
138	Damno absconditus contabesco demergo.\nSolutio articulus rem causa armarium.	2026-04-13 01:10:57.100951	55	58
139	Velociter avarus voco vito fugiat textilis eum.\nAdulatio cohibeo verus sustineo turpis.\nVox minus comedo conturbo consuasor acidus deduco amplus.\nTego sui cultellus sit sponte amplexus sol asper exercitationem creber.\nTyrannus delectus cultura.	2026-04-13 01:10:57.132889	15	59
140	Where is this?!	2026-04-13 01:10:57.135288	1	59
141	Love this so much	2026-04-13 01:10:57.137631	16	59
142	Torrens conventus denique calco tantum.	2026-04-13 01:10:57.141121	16	59
143	Deporto cras beatus desidero depromo esse aro amissio.	2026-04-13 01:10:57.221259	72	61
144	Ipsum patruus vae comedo vinculum. Trans ante coerceo succedo caelum deprecator acies adopto voco. Arceo commodi cerno.	2026-04-13 01:10:57.225366	21	61
145	Depraedor aestas validus.\nUxor desino bonus sufficio similique paulatim.\nPorro validus vitae labore delicate ventus.	2026-04-13 01:10:57.228764	85	61
146	Sodalitas accedo apud autus.\nAbbas odio sto minima nemo copia aiunt.\nAmicitia conturbo audio.\nNumquam amor valeo curia cruciamentum coma carpo ter.	2026-04-13 01:10:57.231716	22	61
147	Ubi beatae cupio valetudo thesaurus conservo auxilium video deludo enim.	2026-04-13 01:10:57.234703	1	61
148	Love this so much	2026-04-13 01:10:57.278226	1	62
149	Arca brevis trans ago brevis candidus vesper iste bonus.\nTredecim testimonium crudelis tutis reiciendis.\nCurtus ipsam verumtamen eos aedificium creptio quia iusto victus.\nVobis auditor acidus caecus delicate.\nTextor impedit cerno absorbeo consequatur contabesco adsidue sollicito placeat.	2026-04-13 01:10:57.281284	91	62
150	Where is this?!	2026-04-13 01:10:57.283738	19	62
151	Ultra creptio bis trucido clementia conicio vulgivagus pauci vulgus natus.	2026-04-13 01:10:57.301261	80	63
152	This is amazing!	2026-04-13 01:10:57.30386	42	63
153	This is amazing!	2026-04-13 01:10:57.306961	13	63
154	Corporis umerus ullus dens audentia illo summisse.	2026-04-13 01:10:57.309958	95	63
155	Dicta capio suscipio tero.	2026-04-13 01:10:57.363938	8	64
156	Approbo ambitus totus advenio.	2026-04-13 01:10:57.366216	52	64
157	Love this so much	2026-04-13 01:10:57.40959	50	65
158	Love this so much	2026-04-13 01:10:57.444374	52	66
159	Where is this?!	2026-04-13 01:10:57.486904	87	67
160	At currus conitor ab comminor patior sub accedo nisi. Aufero commodi hic addo vigor in ustulo conqueror. Exercitationem tametsi curvo confido aetas calamitas fugit cernuus tutis.	2026-04-13 01:10:57.490804	73	67
161	Corrumpo tunc sunt tredecim videlicet sol consuasor victus nemo tactus.	2026-04-13 01:10:57.494829	43	67
162	Cur pauci uter ultio caelestis patruus tabella collum.\nDolor toties celebrer aeneus canto vinitor demergo veniam patrocinor.\nClam cicuta combibo testimonium perferendis.	2026-04-13 01:10:57.497242	60	67
163	This is amazing!	2026-04-13 01:10:57.556454	92	68
164	Love this so much	2026-04-13 01:10:57.560042	44	68
165	Degero caute urbanus sunt tunc laborum aduro celer aperiam.	2026-04-13 01:10:57.645512	45	70
166	Dolores strenuus denique vilitas absens venia. Ancilla demergo amplus vere velit teres vehemens damno acquiro. Accusantium quaerat debitis ultio ait complectus.	2026-04-13 01:10:57.648157	59	70
167	Confugo carmen ancilla.\nQuasi termes acquiro cavus titulus argentum officia substantia truculenter.\nVoluptates arma sublime tyrannus volva minima amiculum attonbitus amita fugit.\nVesco votum soluta nihil charisma nesciunt acies victus.	2026-04-13 01:10:57.650511	79	70
168	Comptus caput caveo aperte appello spiculum comptus.	2026-04-13 01:10:57.676866	80	71
169	Where is this?!	2026-04-13 01:10:57.680106	65	71
170	Auxilium tamen adduco arceo.	2026-04-13 01:10:57.721078	31	72
171	Delectatio venio corrupti adicio audax sono utilis turba. Corpus velum alienus umquam ubi aptus qui cotidie. Contego molestias strenuus sursum ultio tantum sulum viscus censura.	2026-04-13 01:10:57.724246	15	72
172	Torqueo tardus acerbitas capto ceno ducimus.	2026-04-13 01:10:57.793925	33	73
173	This is amazing!	2026-04-13 01:10:57.796159	55	73
174	Where is this?!	2026-04-13 01:10:57.79857	7	73
175	Laboriosam adopto ambulo solium eos ventito defetiscor eligendi celo turba.\nTerebro eaque beneficium minima attero pax aqua.	2026-04-13 01:10:57.801659	23	73
176	Civis cometes est deludo ciminatio caecus magni traho stips. Volup curiositas demo vix tibi astrum. Voro quibusdam patrocinor adsuesco cinis aiunt.	2026-04-13 01:10:57.887829	31	75
177	Where is this?!	2026-04-13 01:10:57.891792	47	75
178	Love this so much	2026-04-13 01:10:57.895119	92	75
179	Tener amoveo sto dolorum tracto claudeo consequatur custodia. Adimpleo debitis cibo consuasor aperio mollitia adicio aiunt turpis. Theologus cogito cogito audentia vivo.	2026-04-13 01:10:57.897496	41	75
180	Quia deleo defluo provident vado quia. Vinculum teres vinitor depono damno admoneo angelus tergo amplexus amor. Vere patrocinor spero tametsi.	2026-04-13 01:10:57.947225	66	76
181	This is amazing!	2026-04-13 01:10:57.949525	21	76
182	Tergum torqueo theca aperte accedo.	2026-04-13 01:10:57.987274	81	77
183	This is amazing!	2026-04-13 01:10:57.990662	31	77
184	This is amazing!	2026-04-13 01:10:57.993689	76	77
185	This is amazing!	2026-04-13 01:10:58.01986	17	78
186	Cupiditate ulciscor deputo animus ustulo voluptatem. Caritas abscido carcer thermae. Cunae sortitus volaticus claustrum.	2026-04-13 01:10:58.022791	22	78
187	Where is this?!	2026-04-13 01:10:58.114489	83	80
188	Where is this?!	2026-04-13 01:10:58.184577	19	81
189	Where is this?!	2026-04-13 01:10:58.23145	35	82
190	Aranea labore explicabo eaque abundans adeptio curia delibero.\nMolestias pel demo vae.\nCandidus autus ventosus vis eum ventito.	2026-04-13 01:10:58.233859	85	82
191	Cotidie damno conitor atrocitas cum.\nExcepturi clam uxor repudiandae atqui adamo sto.\nDolorum adhuc maiores.\nSpargo creo brevis.	2026-04-13 01:10:58.236329	24	82
192	Compello vere carus degero quidem nihil.	2026-04-13 01:10:58.240185	50	82
193	Trado commodi pauci quidem theatrum doloribus voco ullam. Vorax utpote cornu vigor. Curto deprimo ducimus alii amor sufficio cupressus conscendo.	2026-04-13 01:10:58.322528	77	84
194	Charisma attonbitus odit alo impedit sunt. Tenax villa solium cunctatio decor. Deleniti pecco somnus tunc desparatus enim viriliter decipio sulum considero.	2026-04-13 01:10:58.326057	79	84
195	Agnosco confido vindico studio calcar defleo dolore voluptatibus abutor dolor.	2026-04-13 01:10:58.341612	56	85
196	This is amazing!	2026-04-13 01:10:58.387906	54	86
197	Love this so much	2026-04-13 01:10:58.391179	97	86
198	Voveo non possimus spiculum calamitas. Spectaculum acidus depraedor. Tamen bos ventus.	2026-04-13 01:10:58.394352	3	86
199	Love this so much	2026-04-13 01:10:58.397443	63	86
200	Where is this?!	2026-04-13 01:10:58.399652	16	86
201	Magnam strenuus aetas sequi traho desipio. Utor decretum assumenda amoveo terminatio vorago quod ademptio. Vitium uredo temptatio stabilis caritas abduco turbo copia agnitio.	2026-04-13 01:10:58.452712	19	87
202	Where is this?!	2026-04-13 01:10:58.455152	55	87
203	Solitudo denuncio titulus laborum. Vitae cupressus incidunt dens aiunt spiculum tabernus. Veniam amissio rerum.	2026-04-13 01:10:58.619311	60	90
204	Alioqui ambitus appono aperte neque aeger facere solum. Cognatus curriculum vir arcus ipsa hic. Perferendis solus voluptatum delibero.	2026-04-13 01:10:58.622642	16	90
205	Conqueror dicta taedium abscido qui. Terga audeo peccatus patrocinor aestas amitto toties velit. Usque abeo degenero amiculum dignissimos vespillo chirographum magnam.	2026-04-13 01:10:58.669942	3	91
206	This is amazing!	2026-04-13 01:10:58.722552	20	92
207	Where is this?!	2026-04-13 01:10:58.726499	17	92
208	Where is this?!	2026-04-13 01:10:58.74728	56	93
209	Love this so much	2026-04-13 01:10:58.785365	60	94
210	Where is this?!	2026-04-13 01:10:58.788164	97	94
211	Ullam mollitia venustas umquam caecus utrum comminor considero vitae demoror.	2026-04-13 01:10:58.863352	81	96
212	This is amazing!	2026-04-13 01:10:58.865976	83	96
213	Love this so much	2026-04-13 01:10:58.869088	38	96
214	This is amazing!	2026-04-13 01:10:58.871979	58	96
215	Combibo audax verecundia conor carmen adipisci bis tertius paens.\nCicuta aeternus nesciunt angulus sub anser officia addo delectus.\nUxor perferendis cognatus cubitum tubineus.	2026-04-13 01:10:58.905969	86	97
216	Labore uredo versus aspicio recusandae ademptio appono aliqua aeternus.\nCupio assentator varius cura apparatus tracto creator arma.\nSpeculum tamdiu demergo solus praesentium auditor vilis.\nVoluptate thesaurus cuppedia quia nostrum terga cupressus ascit strues cupiditate.	2026-04-13 01:10:58.909523	9	97
217	Vitiosus tricesimus tego currus verumtamen benevolentia aestus.	2026-04-13 01:10:58.977989	1	98
218	Velociter acies vereor. Talus cito deprecator ustulo ut adsuesco stabilis atrocitas aestus. Vere caecus stips repellat.	2026-04-13 01:10:58.980799	21	98
219	Acsi curatio teres cuius adeptio tutamen considero texo delinquo.\nDepraedor dolor aequus vespillo magni aptus.	2026-04-13 01:10:58.983452	39	98
220	Capto deleniti aggero.	2026-04-13 01:10:58.985911	58	98
221	Curso beneficium ratione vulnus contra confero. Cauda acquiro dolorum. Condico deprecator amaritudo adficio synagoga tabella votum.	2026-04-13 01:10:58.98948	25	98
\.


--
-- Data for Name: follows; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.follows (following_user_id, followed_user_id, created_at) FROM stdin;
6	94	2026-04-13 01:10:59.09874
4	81	2026-04-13 01:10:59.102391
4	67	2026-04-13 01:10:59.105717
4	69	2026-04-13 01:10:59.109925
4	98	2026-04-13 01:10:59.113546
5	43	2026-04-13 01:10:59.117472
5	29	2026-04-13 01:10:59.120463
5	4	2026-04-13 01:10:59.123973
5	90	2026-04-13 01:10:59.128197
5	80	2026-04-13 01:10:59.131551
11	25	2026-04-13 01:10:59.134589
14	45	2026-04-13 01:10:59.137397
14	86	2026-04-13 01:10:59.140619
14	10	2026-04-13 01:10:59.14516
90	5	2026-04-13 01:10:59.148446
90	85	2026-04-13 01:10:59.15147
91	99	2026-04-13 01:10:59.15485
91	59	2026-04-13 01:10:59.159306
91	100	2026-04-13 01:10:59.162816
91	5	2026-04-13 01:10:59.165898
91	40	2026-04-13 01:10:59.168903
2	65	2026-04-13 01:10:59.172091
2	86	2026-04-13 01:10:59.176569
2	29	2026-04-13 01:10:59.180094
3	65	2026-04-13 01:10:59.182997
8	41	2026-04-13 01:10:59.186212
8	84	2026-04-13 01:10:59.190555
8	17	2026-04-13 01:10:59.1948
9	62	2026-04-13 01:10:59.197717
9	71	2026-04-13 01:10:59.201125
9	52	2026-04-13 01:10:59.204612
9	51	2026-04-13 01:10:59.208946
9	10	2026-04-13 01:10:59.213025
12	28	2026-04-13 01:10:59.216457
12	43	2026-04-13 01:10:59.220041
13	19	2026-04-13 01:10:59.224173
13	90	2026-04-13 01:10:59.228219
13	32	2026-04-13 01:10:59.231992
13	86	2026-04-13 01:10:59.23584
16	9	2026-04-13 01:10:59.240131
17	88	2026-04-13 01:10:59.244833
17	78	2026-04-13 01:10:59.248168
17	10	2026-04-13 01:10:59.251698
17	74	2026-04-13 01:10:59.255209
18	83	2026-04-13 01:10:59.259488
19	26	2026-04-13 01:10:59.262874
19	3	2026-04-13 01:10:59.265995
19	83	2026-04-13 01:10:59.268993
19	31	2026-04-13 01:10:59.271724
19	92	2026-04-13 01:10:59.276074
21	7	2026-04-13 01:10:59.280323
22	17	2026-04-13 01:10:59.283659
22	49	2026-04-13 01:10:59.287165
22	83	2026-04-13 01:10:59.290187
23	27	2026-04-13 01:10:59.294574
23	43	2026-04-13 01:10:59.298221
24	52	2026-04-13 01:10:59.301672
24	36	2026-04-13 01:10:59.304406
25	64	2026-04-13 01:10:59.30861
25	4	2026-04-13 01:10:59.312847
26	49	2026-04-13 01:10:59.316759
26	28	2026-04-13 01:10:59.320027
26	27	2026-04-13 01:10:59.324909
26	53	2026-04-13 01:10:59.328801
27	26	2026-04-13 01:10:59.33254
27	91	2026-04-13 01:10:59.335469
27	28	2026-04-13 01:10:59.339765
28	31	2026-04-13 01:10:59.344164
30	88	2026-04-13 01:10:59.347715
30	62	2026-04-13 01:10:59.351305
30	87	2026-04-13 01:10:59.354326
30	65	2026-04-13 01:10:59.357962
30	91	2026-04-13 01:10:59.362038
31	87	2026-04-13 01:10:59.3658
32	22	2026-04-13 01:10:59.369036
32	55	2026-04-13 01:10:59.372533
32	51	2026-04-13 01:10:59.376843
32	59	2026-04-13 01:10:59.380458
33	55	2026-04-13 01:10:59.383773
33	86	2026-04-13 01:10:59.387146
33	48	2026-04-13 01:10:59.390977
33	43	2026-04-13 01:10:59.394847
34	42	2026-04-13 01:10:59.398537
34	46	2026-04-13 01:10:59.401828
34	32	2026-04-13 01:10:59.405289
34	62	2026-04-13 01:10:59.40963
35	71	2026-04-13 01:10:59.413651
35	62	2026-04-13 01:10:59.417102
35	93	2026-04-13 01:10:59.420713
36	39	2026-04-13 01:10:59.426366
36	64	2026-04-13 01:10:59.437469
36	61	2026-04-13 01:10:59.448314
37	64	2026-04-13 01:10:59.456587
37	65	2026-04-13 01:10:59.462403
37	49	2026-04-13 01:10:59.469129
38	7	2026-04-13 01:10:59.475396
38	10	2026-04-13 01:10:59.479521
38	80	2026-04-13 01:10:59.483515
38	52	2026-04-13 01:10:59.486912
38	36	2026-04-13 01:10:59.491852
39	21	2026-04-13 01:10:59.495877
42	36	2026-04-13 01:10:59.499192
43	95	2026-04-13 01:10:59.502984
43	87	2026-04-13 01:10:59.507974
43	15	2026-04-13 01:10:59.511773
44	55	2026-04-13 01:10:59.515085
45	72	2026-04-13 01:10:59.518962
46	21	2026-04-13 01:10:59.52224
46	14	2026-04-13 01:10:59.526979
47	84	2026-04-13 01:10:59.531029
47	29	2026-04-13 01:10:59.534535
47	17	2026-04-13 01:10:59.537946
47	1	2026-04-13 01:10:59.54233
47	54	2026-04-13 01:10:59.546274
48	11	2026-04-13 01:10:59.549676
49	67	2026-04-13 01:10:59.55257
49	68	2026-04-13 01:10:59.555632
49	40	2026-04-13 01:10:59.560114
50	79	2026-04-13 01:10:59.563529
50	23	2026-04-13 01:10:59.566793
50	11	2026-04-13 01:10:59.570226
50	86	2026-04-13 01:10:59.574159
51	75	2026-04-13 01:10:59.578394
51	32	2026-04-13 01:10:59.582004
51	45	2026-04-13 01:10:59.58557
51	28	2026-04-13 01:10:59.589391
52	89	2026-04-13 01:10:59.593381
52	40	2026-04-13 01:10:59.596241
52	73	2026-04-13 01:10:59.598932
52	36	2026-04-13 01:10:59.602801
52	94	2026-04-13 01:10:59.606209
53	54	2026-04-13 01:10:59.609719
54	1	2026-04-13 01:10:59.613354
54	61	2026-04-13 01:10:59.616009
55	11	2026-04-13 01:10:59.619139
58	39	2026-04-13 01:10:59.622872
58	99	2026-04-13 01:10:59.626646
58	65	2026-04-13 01:10:59.630111
58	100	2026-04-13 01:10:59.633203
58	77	2026-04-13 01:10:59.636225
60	31	2026-04-13 01:10:59.640311
60	84	2026-04-13 01:10:59.644097
60	40	2026-04-13 01:10:59.647487
61	98	2026-04-13 01:10:59.650806
62	5	2026-04-13 01:10:59.653573
62	51	2026-04-13 01:10:59.657857
62	87	2026-04-13 01:10:59.66184
63	50	2026-04-13 01:10:59.665342
65	90	2026-04-13 01:10:59.668527
68	94	2026-04-13 01:10:59.671759
68	77	2026-04-13 01:10:59.675957
69	17	2026-04-13 01:10:59.679645
69	65	2026-04-13 01:10:59.682788
69	1	2026-04-13 01:10:59.686074
69	86	2026-04-13 01:10:59.690127
69	38	2026-04-13 01:10:59.694418
70	30	2026-04-13 01:10:59.69816
71	53	2026-04-13 01:10:59.701617
71	9	2026-04-13 01:10:59.705057
71	63	2026-04-13 01:10:59.709732
72	63	2026-04-13 01:10:59.713658
72	13	2026-04-13 01:10:59.717168
73	100	2026-04-13 01:10:59.720208
73	84	2026-04-13 01:10:59.724148
73	16	2026-04-13 01:10:59.728547
74	71	2026-04-13 01:10:59.732002
74	23	2026-04-13 01:10:59.736317
75	71	2026-04-13 01:10:59.740128
76	65	2026-04-13 01:10:59.744076
76	9	2026-04-13 01:10:59.746952
76	100	2026-04-13 01:10:59.749857
76	92	2026-04-13 01:10:59.752722
76	23	2026-04-13 01:10:59.756497
77	26	2026-04-13 01:10:59.761356
77	99	2026-04-13 01:10:59.765221
77	53	2026-04-13 01:10:59.768252
77	70	2026-04-13 01:10:59.771916
78	46	2026-04-13 01:10:59.776535
79	37	2026-04-13 01:10:59.780178
79	14	2026-04-13 01:10:59.783813
79	6	2026-04-13 01:10:59.786772
79	66	2026-04-13 01:10:59.790653
80	29	2026-04-13 01:10:59.795417
80	40	2026-04-13 01:10:59.798738
81	49	2026-04-13 01:10:59.80144
82	37	2026-04-13 01:10:59.804304
84	19	2026-04-13 01:10:59.816716
84	90	2026-04-13 01:10:59.820399
84	40	2026-04-13 01:10:59.824518
85	5	2026-04-13 01:10:59.828884
85	64	2026-04-13 01:10:59.832489
85	70	2026-04-13 01:10:59.835323
85	26	2026-04-13 01:10:59.839792
87	34	2026-04-13 01:10:59.844795
87	82	2026-04-13 01:10:59.847781
87	19	2026-04-13 01:10:59.850597
87	36	2026-04-13 01:10:59.853927
92	39	2026-04-13 01:10:59.857149
92	88	2026-04-13 01:10:59.861267
92	10	2026-04-13 01:10:59.866205
93	73	2026-04-13 01:10:59.868959
94	27	2026-04-13 01:10:59.871709
94	100	2026-04-13 01:10:59.8762
94	37	2026-04-13 01:10:59.879784
94	25	2026-04-13 01:10:59.882802
95	7	2026-04-13 01:10:59.885721
95	51	2026-04-13 01:10:59.888379
95	3	2026-04-13 01:10:59.892542
96	66	2026-04-13 01:10:59.895882
96	82	2026-04-13 01:10:59.898783
96	33	2026-04-13 01:10:59.902252
96	70	2026-04-13 01:10:59.905055
99	90	2026-04-13 01:10:59.909533
99	63	2026-04-13 01:10:59.913231
100	94	2026-04-13 01:10:59.916542
\.


--
-- Data for Name: hashtags; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.hashtags (id, name, created_at) FROM stdin;
1	termeslvB	2026-04-13 01:10:53.274828
2	verumtamenWL6	2026-04-13 01:10:53.274845
3	currusJiQ	2026-04-13 01:10:53.275009
4	admoneoa1I	2026-04-13 01:10:53.274817
5	concedokLp	2026-04-13 01:10:53.275138
6	comad82	2026-04-13 01:10:53.274776
7	commodiPEG	2026-04-13 01:10:53.274745
8	corporis7Oz	2026-04-13 01:10:53.275122
9	officiaifv	2026-04-13 01:10:53.27512
10	adficio0tf	2026-04-13 01:10:53.274697
11	reiciendisSKC	2026-04-13 01:10:53.281723
12	utorZ5E	2026-04-13 01:10:53.282575
13	doloresu0E	2026-04-13 01:10:53.283058
14	ullus1cQ	2026-04-13 01:10:53.283159
15	amor9rS	2026-04-13 01:10:53.283588
16	corroboroZpm	2026-04-13 01:10:53.283558
17	delectatiouKf	2026-04-13 01:10:53.284348
18	defetiscorqcX	2026-04-13 01:10:53.284585
19	coniuratioQBL	2026-04-13 01:10:53.284856
20	cupiditasIMg	2026-04-13 01:10:53.285101
\.


--
-- Data for Name: likes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.likes (user_id, post_id, created_at) FROM stdin;
79	1	2026-04-13 01:10:54.356238
31	1	2026-04-13 01:10:54.362653
34	1	2026-04-13 01:10:54.366685
99	1	2026-04-13 01:10:54.370647
76	1	2026-04-13 01:10:54.375064
26	1	2026-04-13 01:10:54.378978
46	1	2026-04-13 01:10:54.383185
29	2	2026-04-13 01:10:54.417213
11	2	2026-04-13 01:10:54.420538
72	2	2026-04-13 01:10:54.425773
40	2	2026-04-13 01:10:54.429328
60	2	2026-04-13 01:10:54.433022
30	2	2026-04-13 01:10:54.436533
54	2	2026-04-13 01:10:54.44072
38	3	2026-04-13 01:10:54.477691
60	3	2026-04-13 01:10:54.480974
99	3	2026-04-13 01:10:54.484679
84	3	2026-04-13 01:10:54.48796
3	4	2026-04-13 01:10:54.51954
16	4	2026-04-13 01:10:54.523445
97	5	2026-04-13 01:10:54.560389
67	5	2026-04-13 01:10:54.563732
17	5	2026-04-13 01:10:54.567239
3	5	2026-04-13 01:10:54.570618
37	5	2026-04-13 01:10:54.57549
28	5	2026-04-13 01:10:54.579894
50	5	2026-04-13 01:10:54.583881
70	5	2026-04-13 01:10:54.588232
65	5	2026-04-13 01:10:54.593371
89	5	2026-04-13 01:10:54.597377
47	6	2026-04-13 01:10:54.627928
25	6	2026-04-13 01:10:54.631904
88	6	2026-04-13 01:10:54.635931
38	7	2026-04-13 01:10:54.65097
17	7	2026-04-13 01:10:54.654812
19	7	2026-04-13 01:10:54.659622
92	7	2026-04-13 01:10:54.663387
12	7	2026-04-13 01:10:54.667434
31	7	2026-04-13 01:10:54.671082
56	7	2026-04-13 01:10:54.675453
83	7	2026-04-13 01:10:54.679462
40	8	2026-04-13 01:10:54.72196
35	8	2026-04-13 01:10:54.72706
41	8	2026-04-13 01:10:54.730921
6	8	2026-04-13 01:10:54.734118
8	9	2026-04-13 01:10:54.760459
84	9	2026-04-13 01:10:54.764001
100	9	2026-04-13 01:10:54.767414
16	9	2026-04-13 01:10:54.770632
20	9	2026-04-13 01:10:54.77426
30	9	2026-04-13 01:10:54.778219
59	9	2026-04-13 01:10:54.782254
34	9	2026-04-13 01:10:54.78597
74	10	2026-04-13 01:10:54.815375
7	10	2026-04-13 01:10:54.818952
58	10	2026-04-13 01:10:54.822575
1	10	2026-04-13 01:10:54.826501
28	10	2026-04-13 01:10:54.830183
82	10	2026-04-13 01:10:54.83321
37	11	2026-04-13 01:10:54.853208
45	11	2026-04-13 01:10:54.856872
18	11	2026-04-13 01:10:54.860854
33	11	2026-04-13 01:10:54.863628
84	12	2026-04-13 01:10:54.876978
53	12	2026-04-13 01:10:54.880368
86	12	2026-04-13 01:10:54.884107
83	12	2026-04-13 01:10:54.887725
94	12	2026-04-13 01:10:54.891395
51	13	2026-04-13 01:10:54.913405
20	13	2026-04-13 01:10:54.916915
43	13	2026-04-13 01:10:54.920154
11	13	2026-04-13 01:10:54.924236
88	14	2026-04-13 01:10:54.960262
33	14	2026-04-13 01:10:54.963476
48	14	2026-04-13 01:10:54.967149
15	14	2026-04-13 01:10:54.971321
82	14	2026-04-13 01:10:54.975911
87	14	2026-04-13 01:10:54.979184
80	14	2026-04-13 01:10:54.982605
56	14	2026-04-13 01:10:54.985903
62	15	2026-04-13 01:10:55.02301
53	15	2026-04-13 01:10:55.027182
80	15	2026-04-13 01:10:55.031405
97	15	2026-04-13 01:10:55.03505
78	15	2026-04-13 01:10:55.038856
18	15	2026-04-13 01:10:55.043591
15	15	2026-04-13 01:10:55.047408
4	16	2026-04-13 01:10:55.073924
59	16	2026-04-13 01:10:55.078263
87	17	2026-04-13 01:10:55.08484
86	17	2026-04-13 01:10:55.089155
24	17	2026-04-13 01:10:55.093573
7	17	2026-04-13 01:10:55.096917
50	17	2026-04-13 01:10:55.100199
19	17	2026-04-13 01:10:55.103872
4	17	2026-04-13 01:10:55.10861
11	17	2026-04-13 01:10:55.112429
62	17	2026-04-13 01:10:55.115722
97	18	2026-04-13 01:10:55.148456
80	18	2026-04-13 01:10:55.151455
40	18	2026-04-13 01:10:55.155352
61	18	2026-04-13 01:10:55.160168
35	19	2026-04-13 01:10:55.197809
60	19	2026-04-13 01:10:55.201298
57	19	2026-04-13 01:10:55.204782
6	20	2026-04-13 01:10:55.242745
23	20	2026-04-13 01:10:55.25153
9	20	2026-04-13 01:10:55.258262
19	20	2026-04-13 01:10:55.265129
47	20	2026-04-13 01:10:55.271731
84	21	2026-04-13 01:10:55.296984
13	21	2026-04-13 01:10:55.300432
61	21	2026-04-13 01:10:55.30446
91	21	2026-04-13 01:10:55.309396
38	21	2026-04-13 01:10:55.314124
17	21	2026-04-13 01:10:55.317542
17	22	2026-04-13 01:10:55.347768
25	22	2026-04-13 01:10:55.351771
1	22	2026-04-13 01:10:55.355421
93	22	2026-04-13 01:10:55.360172
34	22	2026-04-13 01:10:55.364028
48	22	2026-04-13 01:10:55.367692
60	23	2026-04-13 01:10:55.401919
90	23	2026-04-13 01:10:55.406631
30	23	2026-04-13 01:10:55.410789
14	23	2026-04-13 01:10:55.414206
46	23	2026-04-13 01:10:55.417642
13	23	2026-04-13 01:10:55.42112
63	24	2026-04-13 01:10:55.451381
22	24	2026-04-13 01:10:55.455049
59	24	2026-04-13 01:10:55.460016
31	24	2026-04-13 01:10:55.463481
60	25	2026-04-13 01:10:55.477972
100	25	2026-04-13 01:10:55.481677
82	25	2026-04-13 01:10:55.485114
28	25	2026-04-13 01:10:55.488085
38	25	2026-04-13 01:10:55.492373
87	25	2026-04-13 01:10:55.49622
35	25	2026-04-13 01:10:55.499903
57	25	2026-04-13 01:10:55.503185
21	25	2026-04-13 01:10:55.507047
43	25	2026-04-13 01:10:55.511774
30	26	2026-04-13 01:10:55.541061
46	26	2026-04-13 01:10:55.545315
99	26	2026-04-13 01:10:55.54867
74	26	2026-04-13 01:10:55.551454
36	26	2026-04-13 01:10:55.55494
42	26	2026-04-13 01:10:55.559556
9	26	2026-04-13 01:10:55.562639
47	27	2026-04-13 01:10:55.587685
13	27	2026-04-13 01:10:55.592234
63	27	2026-04-13 01:10:55.596271
43	27	2026-04-13 01:10:55.599349
100	28	2026-04-13 01:10:55.63148
35	28	2026-04-13 01:10:55.63493
43	28	2026-04-13 01:10:55.639374
50	28	2026-04-13 01:10:55.644262
34	28	2026-04-13 01:10:55.647843
56	28	2026-04-13 01:10:55.651819
4	28	2026-04-13 01:10:55.656451
62	28	2026-04-13 01:10:55.660194
61	29	2026-04-13 01:10:55.68567
49	29	2026-04-13 01:10:55.690302
45	29	2026-04-13 01:10:55.694925
3	29	2026-04-13 01:10:55.698694
48	29	2026-04-13 01:10:55.702324
88	29	2026-04-13 01:10:55.706815
40	29	2026-04-13 01:10:55.711613
30	29	2026-04-13 01:10:55.714814
42	29	2026-04-13 01:10:55.718114
4	30	2026-04-13 01:10:55.751518
65	30	2026-04-13 01:10:55.755049
29	30	2026-04-13 01:10:55.759413
77	30	2026-04-13 01:10:55.763019
80	31	2026-04-13 01:10:55.783948
53	31	2026-04-13 01:10:55.787624
15	31	2026-04-13 01:10:55.791501
16	31	2026-04-13 01:10:55.795159
13	32	2026-04-13 01:10:55.824674
78	32	2026-04-13 01:10:55.828394
22	32	2026-04-13 01:10:55.831769
62	32	2026-04-13 01:10:55.834998
60	32	2026-04-13 01:10:55.839717
65	32	2026-04-13 01:10:55.844781
77	33	2026-04-13 01:10:55.878241
8	33	2026-04-13 01:10:55.881475
16	33	2026-04-13 01:10:55.885127
3	33	2026-04-13 01:10:55.888119
52	33	2026-04-13 01:10:55.892669
2	33	2026-04-13 01:10:55.896151
88	33	2026-04-13 01:10:55.899473
42	34	2026-04-13 01:10:55.931761
16	34	2026-04-13 01:10:55.935376
34	34	2026-04-13 01:10:55.939283
1	34	2026-04-13 01:10:55.943318
51	34	2026-04-13 01:10:55.946841
48	34	2026-04-13 01:10:55.950317
33	34	2026-04-13 01:10:55.953957
67	34	2026-04-13 01:10:55.958408
21	34	2026-04-13 01:10:55.962397
61	34	2026-04-13 01:10:55.965991
17	35	2026-04-13 01:10:55.988842
75	35	2026-04-13 01:10:55.993614
73	35	2026-04-13 01:10:55.997269
41	35	2026-04-13 01:10:56.000577
56	35	2026-04-13 01:10:56.00337
35	35	2026-04-13 01:10:56.007804
22	35	2026-04-13 01:10:56.011834
34	36	2026-04-13 01:10:56.041994
76	36	2026-04-13 01:10:56.046366
97	36	2026-04-13 01:10:56.049309
42	37	2026-04-13 01:10:56.079992
98	37	2026-04-13 01:10:56.083416
98	38	2026-04-13 01:10:56.111033
35	38	2026-04-13 01:10:56.11454
50	38	2026-04-13 01:10:56.11752
48	38	2026-04-13 01:10:56.120393
11	38	2026-04-13 01:10:56.125373
77	38	2026-04-13 01:10:56.129694
42	38	2026-04-13 01:10:56.13289
36	38	2026-04-13 01:10:56.136188
22	38	2026-04-13 01:10:56.140099
8	39	2026-04-13 01:10:56.160579
61	39	2026-04-13 01:10:56.164291
67	39	2026-04-13 01:10:56.16807
91	39	2026-04-13 01:10:56.17242
80	39	2026-04-13 01:10:56.177172
75	39	2026-04-13 01:10:56.180664
49	39	2026-04-13 01:10:56.183955
63	39	2026-04-13 01:10:56.186976
93	40	2026-04-13 01:10:56.202713
10	40	2026-04-13 01:10:56.205947
5	40	2026-04-13 01:10:56.210514
36	40	2026-04-13 01:10:56.214355
64	40	2026-04-13 01:10:56.218266
27	41	2026-04-13 01:10:56.23657
94	41	2026-04-13 01:10:56.240964
84	41	2026-04-13 01:10:56.245274
83	41	2026-04-13 01:10:56.248776
65	41	2026-04-13 01:10:56.252067
25	41	2026-04-13 01:10:56.255261
7	41	2026-04-13 01:10:56.259606
89	41	2026-04-13 01:10:56.26335
18	42	2026-04-13 01:10:56.300972
47	42	2026-04-13 01:10:56.304713
74	42	2026-04-13 01:10:56.311463
90	42	2026-04-13 01:10:56.316791
2	42	2026-04-13 01:10:56.320723
16	42	2026-04-13 01:10:56.325093
8	42	2026-04-13 01:10:56.328954
23	42	2026-04-13 01:10:56.333024
3	42	2026-04-13 01:10:56.336807
48	42	2026-04-13 01:10:56.341268
74	43	2026-04-13 01:10:56.369526
43	43	2026-04-13 01:10:56.37392
28	43	2026-04-13 01:10:56.378193
86	43	2026-04-13 01:10:56.381835
16	44	2026-04-13 01:10:56.416244
49	44	2026-04-13 01:10:56.420237
38	44	2026-04-13 01:10:56.424439
99	44	2026-04-13 01:10:56.428114
56	44	2026-04-13 01:10:56.431467
26	45	2026-04-13 01:10:56.473651
72	45	2026-04-13 01:10:56.478406
55	45	2026-04-13 01:10:56.481774
22	45	2026-04-13 01:10:56.485283
62	45	2026-04-13 01:10:56.488719
28	45	2026-04-13 01:10:56.493356
34	45	2026-04-13 01:10:56.496991
39	46	2026-04-13 01:10:56.519759
66	46	2026-04-13 01:10:56.524854
69	46	2026-04-13 01:10:56.533025
33	46	2026-04-13 01:10:56.537185
99	46	2026-04-13 01:10:56.542778
5	46	2026-04-13 01:10:56.547093
43	47	2026-04-13 01:10:56.554941
77	47	2026-04-13 01:10:56.560145
51	47	2026-04-13 01:10:56.564224
21	47	2026-04-13 01:10:56.568051
8	47	2026-04-13 01:10:56.572035
46	47	2026-04-13 01:10:56.577958
70	47	2026-04-13 01:10:56.582235
67	47	2026-04-13 01:10:56.586304
82	48	2026-04-13 01:10:56.619174
13	48	2026-04-13 01:10:56.622232
45	48	2026-04-13 01:10:56.626971
78	48	2026-04-13 01:10:56.63036
86	49	2026-04-13 01:10:56.704616
77	49	2026-04-13 01:10:56.709178
98	49	2026-04-13 01:10:56.714189
94	49	2026-04-13 01:10:56.718266
5	49	2026-04-13 01:10:56.722055
40	49	2026-04-13 01:10:56.727074
77	50	2026-04-13 01:10:56.757412
84	50	2026-04-13 01:10:56.761888
10	50	2026-04-13 01:10:56.765676
20	50	2026-04-13 01:10:56.770126
72	50	2026-04-13 01:10:56.774232
79	51	2026-04-13 01:10:56.8056
43	51	2026-04-13 01:10:56.810047
17	52	2026-04-13 01:10:56.831881
83	52	2026-04-13 01:10:56.835239
2	53	2026-04-13 01:10:56.867639
17	53	2026-04-13 01:10:56.87158
44	53	2026-04-13 01:10:56.876109
11	53	2026-04-13 01:10:56.879597
6	53	2026-04-13 01:10:56.882743
60	53	2026-04-13 01:10:56.885416
73	53	2026-04-13 01:10:56.889459
49	53	2026-04-13 01:10:56.893708
62	54	2026-04-13 01:10:56.91267
64	54	2026-04-13 01:10:56.916223
37	54	2026-04-13 01:10:56.919417
20	54	2026-04-13 01:10:56.925189
59	55	2026-04-13 01:10:56.945542
17	55	2026-04-13 01:10:56.948885
30	55	2026-04-13 01:10:56.95256
10	55	2026-04-13 01:10:56.956524
52	55	2026-04-13 01:10:56.960553
76	55	2026-04-13 01:10:56.963827
45	55	2026-04-13 01:10:56.966978
9	55	2026-04-13 01:10:56.970142
85	55	2026-04-13 01:10:56.973524
61	55	2026-04-13 01:10:56.977452
75	56	2026-04-13 01:10:57.004537
100	56	2026-04-13 01:10:57.008998
33	56	2026-04-13 01:10:57.012674
42	56	2026-04-13 01:10:57.015689
85	56	2026-04-13 01:10:57.018731
41	56	2026-04-13 01:10:57.022216
32	56	2026-04-13 01:10:57.02661
35	56	2026-04-13 01:10:57.035838
56	56	2026-04-13 01:10:57.04097
63	56	2026-04-13 01:10:57.045611
53	57	2026-04-13 01:10:57.065913
12	57	2026-04-13 01:10:57.069547
58	57	2026-04-13 01:10:57.073788
66	57	2026-04-13 01:10:57.078047
71	57	2026-04-13 01:10:57.080812
43	57	2026-04-13 01:10:57.08363
29	57	2026-04-13 01:10:57.086689
45	57	2026-04-13 01:10:57.090909
22	58	2026-04-13 01:10:57.103846
78	58	2026-04-13 01:10:57.108383
51	58	2026-04-13 01:10:57.11247
100	59	2026-04-13 01:10:57.14503
95	59	2026-04-13 01:10:57.148133
50	59	2026-04-13 01:10:57.151156
20	59	2026-04-13 01:10:57.153974
90	59	2026-04-13 01:10:57.15779
89	59	2026-04-13 01:10:57.162157
96	60	2026-04-13 01:10:57.175947
39	60	2026-04-13 01:10:57.180079
63	60	2026-04-13 01:10:57.183887
69	60	2026-04-13 01:10:57.187323
35	60	2026-04-13 01:10:57.191964
53	61	2026-04-13 01:10:57.238347
12	61	2026-04-13 01:10:57.242938
78	61	2026-04-13 01:10:57.246103
50	61	2026-04-13 01:10:57.249467
10	61	2026-04-13 01:10:57.253137
17	62	2026-04-13 01:10:57.287733
35	62	2026-04-13 01:10:57.291957
87	63	2026-04-13 01:10:57.313666
92	63	2026-04-13 01:10:57.316794
84	63	2026-04-13 01:10:57.319725
99	63	2026-04-13 01:10:57.322769
22	63	2026-04-13 01:10:57.327024
21	63	2026-04-13 01:10:57.331292
7	63	2026-04-13 01:10:57.334665
91	63	2026-04-13 01:10:57.337569
22	64	2026-04-13 01:10:57.369374
6	64	2026-04-13 01:10:57.372407
60	64	2026-04-13 01:10:57.376764
53	64	2026-04-13 01:10:57.379777
40	64	2026-04-13 01:10:57.383141
55	65	2026-04-13 01:10:57.41275
15	65	2026-04-13 01:10:57.415948
33	65	2026-04-13 01:10:57.419096
26	66	2026-04-13 01:10:57.447455
23	66	2026-04-13 01:10:57.450271
9	66	2026-04-13 01:10:57.453145
59	66	2026-04-13 01:10:57.457778
97	66	2026-04-13 01:10:57.461827
47	66	2026-04-13 01:10:57.465378
66	66	2026-04-13 01:10:57.468555
43	66	2026-04-13 01:10:57.471309
93	66	2026-04-13 01:10:57.476042
12	67	2026-04-13 01:10:57.500538
96	67	2026-04-13 01:10:57.504057
71	67	2026-04-13 01:10:57.507573
11	67	2026-04-13 01:10:57.512055
38	67	2026-04-13 01:10:57.515653
90	67	2026-04-13 01:10:57.519242
31	67	2026-04-13 01:10:57.523856
60	68	2026-04-13 01:10:57.56342
3	68	2026-04-13 01:10:57.567147
93	68	2026-04-13 01:10:57.570264
44	68	2026-04-13 01:10:57.573858
81	68	2026-04-13 01:10:57.578219
57	68	2026-04-13 01:10:57.581898
37	68	2026-04-13 01:10:57.585254
16	69	2026-04-13 01:10:57.616086
79	69	2026-04-13 01:10:57.619765
41	69	2026-04-13 01:10:57.624015
73	70	2026-04-13 01:10:57.653459
88	70	2026-04-13 01:10:57.658492
98	70	2026-04-13 01:10:57.66229
63	70	2026-04-13 01:10:57.665765
77	71	2026-04-13 01:10:57.682931
97	71	2026-04-13 01:10:57.686713
34	71	2026-04-13 01:10:57.69072
35	71	2026-04-13 01:10:57.695046
29	71	2026-04-13 01:10:57.698491
65	71	2026-04-13 01:10:57.702346
87	71	2026-04-13 01:10:57.706432
22	72	2026-04-13 01:10:57.728724
83	72	2026-04-13 01:10:57.732384
2	72	2026-04-13 01:10:57.73593
44	72	2026-04-13 01:10:57.740773
67	72	2026-04-13 01:10:57.744909
36	72	2026-04-13 01:10:57.747928
97	72	2026-04-13 01:10:57.751128
100	72	2026-04-13 01:10:57.754945
39	72	2026-04-13 01:10:57.760324
83	73	2026-04-13 01:10:57.804944
32	73	2026-04-13 01:10:57.809515
57	73	2026-04-13 01:10:57.813296
74	73	2026-04-13 01:10:57.815997
81	73	2026-04-13 01:10:57.818727
19	73	2026-04-13 01:10:57.822338
63	73	2026-04-13 01:10:57.82689
59	73	2026-04-13 01:10:57.830327
67	74	2026-04-13 01:10:57.8447
13	74	2026-04-13 01:10:57.848175
39	74	2026-04-13 01:10:57.851871
21	74	2026-04-13 01:10:57.854652
73	74	2026-04-13 01:10:57.858647
74	74	2026-04-13 01:10:57.861993
87	74	2026-04-13 01:10:57.864846
42	74	2026-04-13 01:10:57.867677
13	75	2026-04-13 01:10:57.901185
77	75	2026-04-13 01:10:57.904751
2	75	2026-04-13 01:10:57.909382
10	75	2026-04-13 01:10:57.912701
27	75	2026-04-13 01:10:57.91619
76	75	2026-04-13 01:10:57.91905
34	75	2026-04-13 01:10:57.921846
68	75	2026-04-13 01:10:57.926671
36	75	2026-04-13 01:10:57.929579
62	75	2026-04-13 01:10:57.932873
60	76	2026-04-13 01:10:57.952523
46	76	2026-04-13 01:10:57.95717
100	76	2026-04-13 01:10:57.961478
96	76	2026-04-13 01:10:57.964784
62	76	2026-04-13 01:10:57.967375
27	76	2026-04-13 01:10:57.970796
35	77	2026-04-13 01:10:57.997079
53	77	2026-04-13 01:10:58.000432
66	77	2026-04-13 01:10:58.003889
40	78	2026-04-13 01:10:58.027157
17	78	2026-04-13 01:10:58.031012
43	79	2026-04-13 01:10:58.038452
51	79	2026-04-13 01:10:58.048156
68	79	2026-04-13 01:10:58.055358
66	79	2026-04-13 01:10:58.065861
53	79	2026-04-13 01:10:58.07631
62	80	2026-04-13 01:10:58.118091
10	80	2026-04-13 01:10:58.122208
85	80	2026-04-13 01:10:58.126846
72	80	2026-04-13 01:10:58.130363
24	80	2026-04-13 01:10:58.134174
84	80	2026-04-13 01:10:58.138178
7	80	2026-04-13 01:10:58.142596
88	80	2026-04-13 01:10:58.147271
51	80	2026-04-13 01:10:58.150897
80	80	2026-04-13 01:10:58.1543
72	81	2026-04-13 01:10:58.187934
58	81	2026-04-13 01:10:58.19175
65	81	2026-04-13 01:10:58.195759
53	81	2026-04-13 01:10:58.198805
79	81	2026-04-13 01:10:58.201949
89	81	2026-04-13 01:10:58.205093
6	81	2026-04-13 01:10:58.209731
76	81	2026-04-13 01:10:58.213771
56	82	2026-04-13 01:10:58.244598
87	82	2026-04-13 01:10:58.248053
14	82	2026-04-13 01:10:58.251798
15	82	2026-04-13 01:10:58.254969
89	82	2026-04-13 01:10:58.259668
70	82	2026-04-13 01:10:58.263375
6	82	2026-04-13 01:10:58.266787
43	83	2026-04-13 01:10:58.28117
65	83	2026-04-13 01:10:58.283984
33	83	2026-04-13 01:10:58.286668
37	83	2026-04-13 01:10:58.290895
64	83	2026-04-13 01:10:58.294826
61	83	2026-04-13 01:10:58.29822
71	84	2026-04-13 01:10:58.329845
61	84	2026-04-13 01:10:58.332724
56	85	2026-04-13 01:10:58.345871
14	85	2026-04-13 01:10:58.349113
69	85	2026-04-13 01:10:58.35271
1	85	2026-04-13 01:10:58.356606
75	85	2026-04-13 01:10:58.361068
53	85	2026-04-13 01:10:58.364307
30	85	2026-04-13 01:10:58.367605
52	85	2026-04-13 01:10:58.370857
48	85	2026-04-13 01:10:58.375048
38	85	2026-04-13 01:10:58.378542
90	86	2026-04-13 01:10:58.403352
82	86	2026-04-13 01:10:58.407206
19	86	2026-04-13 01:10:58.411161
54	86	2026-04-13 01:10:58.41473
73	86	2026-04-13 01:10:58.417556
17	86	2026-04-13 01:10:58.420824
91	86	2026-04-13 01:10:58.424241
50	86	2026-04-13 01:10:58.428559
35	86	2026-04-13 01:10:58.432124
16	87	2026-04-13 01:10:58.459785
18	87	2026-04-13 01:10:58.463459
14	87	2026-04-13 01:10:58.466314
15	87	2026-04-13 01:10:58.469063
6	87	2026-04-13 01:10:58.472703
50	87	2026-04-13 01:10:58.476982
43	87	2026-04-13 01:10:58.480511
23	87	2026-04-13 01:10:58.483985
68	87	2026-04-13 01:10:58.487647
77	87	2026-04-13 01:10:58.492009
2	88	2026-04-13 01:10:58.518844
80	88	2026-04-13 01:10:58.522149
36	88	2026-04-13 01:10:58.526407
84	88	2026-04-13 01:10:58.530178
81	88	2026-04-13 01:10:58.533365
90	88	2026-04-13 01:10:58.536862
88	88	2026-04-13 01:10:58.540821
29	88	2026-04-13 01:10:58.545666
24	88	2026-04-13 01:10:58.549074
45	88	2026-04-13 01:10:58.552199
88	89	2026-04-13 01:10:58.581316
7	89	2026-04-13 01:10:58.584619
78	89	2026-04-13 01:10:58.5881
10	89	2026-04-13 01:10:58.592396
50	89	2026-04-13 01:10:58.596207
46	89	2026-04-13 01:10:58.598817
37	89	2026-04-13 01:10:58.60198
60	89	2026-04-13 01:10:58.604774
93	90	2026-04-13 01:10:58.627873
24	90	2026-04-13 01:10:58.631985
45	90	2026-04-13 01:10:58.634995
1	90	2026-04-13 01:10:58.637813
79	90	2026-04-13 01:10:58.6419
74	90	2026-04-13 01:10:58.646105
48	90	2026-04-13 01:10:58.649506
21	91	2026-04-13 01:10:58.673517
9	91	2026-04-13 01:10:58.677877
27	91	2026-04-13 01:10:58.681426
52	91	2026-04-13 01:10:58.684135
5	91	2026-04-13 01:10:58.687293
81	91	2026-04-13 01:10:58.691592
24	91	2026-04-13 01:10:58.695432
34	92	2026-04-13 01:10:58.729806
51	92	2026-04-13 01:10:58.732979
68	93	2026-04-13 01:10:58.751705
22	93	2026-04-13 01:10:58.75637
95	93	2026-04-13 01:10:58.760713
71	93	2026-04-13 01:10:58.7641
23	94	2026-04-13 01:10:58.791972
54	94	2026-04-13 01:10:58.795585
47	94	2026-04-13 01:10:58.798396
74	94	2026-04-13 01:10:58.801205
29	94	2026-04-13 01:10:58.804424
72	94	2026-04-13 01:10:58.807862
41	94	2026-04-13 01:10:58.811737
65	94	2026-04-13 01:10:58.81494
82	95	2026-04-13 01:10:58.836178
67	95	2026-04-13 01:10:58.839296
65	95	2026-04-13 01:10:58.843506
42	95	2026-04-13 01:10:58.846683
97	95	2026-04-13 01:10:58.849711
25	95	2026-04-13 01:10:58.853039
35	95	2026-04-13 01:10:58.856744
85	96	2026-04-13 01:10:58.87677
40	96	2026-04-13 01:10:58.880609
19	96	2026-04-13 01:10:58.883431
66	97	2026-04-13 01:10:58.913638
76	97	2026-04-13 01:10:58.91698
5	97	2026-04-13 01:10:58.919999
55	97	2026-04-13 01:10:58.92397
50	97	2026-04-13 01:10:58.92792
20	97	2026-04-13 01:10:58.931435
41	97	2026-04-13 01:10:58.936301
26	97	2026-04-13 01:10:58.939323
48	97	2026-04-13 01:10:58.943748
57	97	2026-04-13 01:10:58.947702
66	98	2026-04-13 01:10:58.993693
3	98	2026-04-13 01:10:58.996623
97	98	2026-04-13 01:10:58.999331
16	98	2026-04-13 01:10:59.002875
74	98	2026-04-13 01:10:59.006508
43	98	2026-04-13 01:10:59.010591
31	98	2026-04-13 01:10:59.013601
84	98	2026-04-13 01:10:59.016369
19	98	2026-04-13 01:10:59.019288
71	99	2026-04-13 01:10:59.034652
2	99	2026-04-13 01:10:59.038126
29	99	2026-04-13 01:10:59.042568
13	100	2026-04-13 01:10:59.067666
1	100	2026-04-13 01:10:59.071182
49	100	2026-04-13 01:10:59.075186
72	100	2026-04-13 01:10:59.078961
7	100	2026-04-13 01:10:59.082515
37	100	2026-04-13 01:10:59.08596
70	100	2026-04-13 01:10:59.090106
101	2	2026-04-23 02:14:39.591196
101	3	2026-04-23 02:14:42.289347
101	1	2026-04-23 02:14:51.678545
\.


--
-- Data for Name: post_hashtags; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.post_hashtags (post_id, hashtag_id) FROM stdin;
1	4
1	19
2	2
3	1
3	20
4	10
5	6
5	20
5	1
6	2
7	13
8	20
8	9
9	16
10	1
10	3
10	5
11	3
12	4
13	12
13	7
13	2
14	3
14	7
14	10
15	16
15	1
16	16
17	19
18	16
18	18
19	16
20	4
20	8
20	18
21	9
21	1
22	18
22	6
23	9
23	11
24	17
25	4
25	5
26	15
26	8
26	2
27	19
28	1
28	8
28	2
29	11
29	2
29	7
30	4
30	1
31	4
32	16
32	18
33	19
33	6
33	8
34	2
34	4
35	14
35	15
36	5
37	16
38	13
38	16
38	14
39	14
39	4
39	19
40	13
40	20
40	10
41	20
41	19
41	10
42	14
42	13
42	7
43	18
44	11
45	20
45	1
45	11
46	5
47	19
48	4
49	14
49	20
49	1
50	5
50	12
50	3
51	4
51	17
51	14
52	5
53	13
53	5
53	2
54	12
55	20
56	8
57	15
58	2
59	7
59	15
59	8
60	13
61	8
61	14
62	8
63	19
64	8
65	12
65	1
66	10
66	3
67	19
68	6
68	20
68	8
69	4
69	14
69	15
70	7
70	6
71	17
71	5
72	2
72	4
72	20
73	7
73	12
73	10
74	5
74	17
74	18
75	4
75	3
75	17
76	8
76	18
77	20
77	6
78	4
78	14
78	19
79	15
80	7
80	11
81	17
81	19
82	20
82	13
83	16
84	11
84	4
84	10
85	12
86	10
86	9
87	14
88	5
88	6
88	2
89	13
89	10
89	14
90	17
91	9
92	7
92	9
93	16
93	20
94	2
95	13
95	4
95	14
96	8
97	7
97	9
97	14
98	1
98	19
99	12
99	1
99	14
100	15
100	16
\.


--
-- Data for Name: post_media; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.post_media (id, media_url, media_type, sequence_order, created_at, post_id) FROM stdin;
1	https://picsum.photos/seed/3W42hMFEPE/640/480	video	1	2026-04-13 01:10:53.332679	1
2	https://picsum.photos/seed/paVXjj/640/480	video	2	2026-04-13 01:10:53.337242	1
3	https://picsum.photos/seed/iC37HDobD5/640/480	image	3	2026-04-13 01:10:53.341988	1
4	https://picsum.photos/seed/xuY8l6KELl/640/480	video	4	2026-04-13 01:10:53.34595	1
5	https://picsum.photos/seed/7C7SLl2/640/480	video	1	2026-04-13 01:10:53.349639	2
6	https://picsum.photos/seed/Vwr7D/640/480	video	2	2026-04-13 01:10:53.353289	2
7	https://picsum.photos/seed/GLZNm/640/480	image	1	2026-04-13 01:10:53.35737	3
8	https://picsum.photos/seed/HKAgVV9vv/640/480	video	2	2026-04-13 01:10:53.361297	3
9	https://picsum.photos/seed/4HPMW1/640/480	image	3	2026-04-13 01:10:53.36456	3
10	https://picsum.photos/seed/47gMl/640/480	image	1	2026-04-13 01:10:53.367947	4
11	https://picsum.photos/seed/l3GzZn/640/480	video	2	2026-04-13 01:10:53.370703	4
12	https://picsum.photos/seed/IE5EwWT/640/480	video	3	2026-04-13 01:10:53.373966	4
13	https://picsum.photos/seed/7krF8I/640/480	video	4	2026-04-13 01:10:53.377879	4
14	https://picsum.photos/seed/OPdPa/640/480	image	5	2026-04-13 01:10:53.380515	4
15	https://picsum.photos/seed/SnhBeqBH/640/480	image	1	2026-04-13 01:10:53.38393	5
16	https://picsum.photos/seed/rJqaZz/640/480	video	1	2026-04-13 01:10:53.386656	6
17	https://picsum.photos/seed/3U1ZyZfI/640/480	video	2	2026-04-13 01:10:53.390281	6
18	https://picsum.photos/seed/Z68Jgb/640/480	image	3	2026-04-13 01:10:53.39391	6
19	https://picsum.photos/seed/1GsQAu/640/480	video	4	2026-04-13 01:10:53.396947	6
20	https://picsum.photos/seed/MGtoN4C/640/480	image	5	2026-04-13 01:10:53.399577	6
21	https://picsum.photos/seed/zCmbhtw/640/480	video	1	2026-04-13 01:10:53.402266	7
22	https://picsum.photos/seed/bg3JqE/640/480	video	1	2026-04-13 01:10:53.405689	8
23	https://picsum.photos/seed/DQ2AT/640/480	video	2	2026-04-13 01:10:53.410097	8
24	https://picsum.photos/seed/EH1w9HL/640/480	image	3	2026-04-13 01:10:53.41337	8
25	https://picsum.photos/seed/cc6yd7Hp/640/480	image	4	2026-04-13 01:10:53.415809	8
26	https://picsum.photos/seed/pBua4hZq9/640/480	image	1	2026-04-13 01:10:53.418198	9
27	https://picsum.photos/seed/6yEeB/640/480	video	2	2026-04-13 01:10:53.420595	9
28	https://picsum.photos/seed/aXgTlN/640/480	image	3	2026-04-13 01:10:53.424581	9
29	https://picsum.photos/seed/exrbmj4YZ/640/480	image	4	2026-04-13 01:10:53.427889	9
30	https://picsum.photos/seed/5Gd7L/640/480	image	1	2026-04-13 01:10:53.431164	10
31	https://picsum.photos/seed/0h9aW7HPXx/640/480	video	2	2026-04-13 01:10:53.433583	10
32	https://picsum.photos/seed/1AOBs78/640/480	video	3	2026-04-13 01:10:53.435874	10
33	https://picsum.photos/seed/uSbKCL/640/480	video	4	2026-04-13 01:10:53.439313	10
34	https://picsum.photos/seed/YgZpc/640/480	video	1	2026-04-13 01:10:53.443348	11
35	https://picsum.photos/seed/LHAtTVMLT/640/480	video	1	2026-04-13 01:10:53.446255	12
36	https://picsum.photos/seed/Ukk566vRd/640/480	image	1	2026-04-13 01:10:53.448869	13
37	https://picsum.photos/seed/4Y3dPPpi/640/480	video	1	2026-04-13 01:10:53.451672	14
38	https://picsum.photos/seed/1A0oQJ/640/480	video	2	2026-04-13 01:10:53.454785	14
39	https://picsum.photos/seed/eVqTR/640/480	video	1	2026-04-13 01:10:53.458992	15
40	https://picsum.photos/seed/xX77Nlll/640/480	image	2	2026-04-13 01:10:53.462561	15
41	https://picsum.photos/seed/7Rm1P4/640/480	image	1	2026-04-13 01:10:53.465922	16
42	https://picsum.photos/seed/KcjZqfpE/640/480	image	2	2026-04-13 01:10:53.469961	16
43	https://picsum.photos/seed/fOnO7Q/640/480	video	3	2026-04-13 01:10:53.472983	16
44	https://picsum.photos/seed/l3zrP/640/480	image	4	2026-04-13 01:10:53.476561	16
45	https://picsum.photos/seed/H959j/640/480	video	5	2026-04-13 01:10:53.480274	16
46	https://picsum.photos/seed/xoFlU/640/480	image	1	2026-04-13 01:10:53.48272	17
47	https://picsum.photos/seed/HLK1HEjM/640/480	image	1	2026-04-13 01:10:53.485016	18
48	https://picsum.photos/seed/s9Osw/640/480	image	2	2026-04-13 01:10:53.487545	18
49	https://picsum.photos/seed/Oumdfi/640/480	video	3	2026-04-13 01:10:53.490895	18
50	https://picsum.photos/seed/vygRouKoL/640/480	video	1	2026-04-13 01:10:53.494577	19
51	https://picsum.photos/seed/usK8ew2/640/480	video	2	2026-04-13 01:10:53.49801	19
52	https://picsum.photos/seed/CEoeA/640/480	image	3	2026-04-13 01:10:53.501119	19
53	https://picsum.photos/seed/KQGYp6qQ7/640/480	video	4	2026-04-13 01:10:53.504659	19
54	https://picsum.photos/seed/WdTTHj/640/480	image	5	2026-04-13 01:10:53.508757	19
55	https://picsum.photos/seed/qRR2Itvz1j/640/480	image	1	2026-04-13 01:10:53.512579	20
56	https://picsum.photos/seed/288DLSK/640/480	image	1	2026-04-13 01:10:53.515112	21
57	https://picsum.photos/seed/egcy8/640/480	image	2	2026-04-13 01:10:53.517997	21
58	https://picsum.photos/seed/hZv3X/640/480	image	1	2026-04-13 01:10:53.521023	22
59	https://picsum.photos/seed/zshk7CQI/640/480	image	1	2026-04-13 01:10:53.524903	23
60	https://picsum.photos/seed/iU8XT/640/480	video	2	2026-04-13 01:10:53.528844	23
61	https://picsum.photos/seed/q6iSr/640/480	video	1	2026-04-13 01:10:53.532208	24
62	https://picsum.photos/seed/qXEmohUYKw/640/480	image	2	2026-04-13 01:10:53.535529	24
63	https://picsum.photos/seed/wfZaMe/640/480	video	1	2026-04-13 01:10:53.538886	25
64	https://picsum.photos/seed/m72pg/640/480	video	2	2026-04-13 01:10:53.54239	25
65	https://picsum.photos/seed/hQdlb/640/480	image	1	2026-04-13 01:10:53.545269	26
66	https://picsum.photos/seed/ofPN9j/640/480	image	2	2026-04-13 01:10:53.548156	26
67	https://picsum.photos/seed/L1U0n2C/640/480	video	3	2026-04-13 01:10:53.551343	26
68	https://picsum.photos/seed/C3nB7R/640/480	video	4	2026-04-13 01:10:53.555263	26
69	https://picsum.photos/seed/eOKeAgdQQ/640/480	image	5	2026-04-13 01:10:53.560149	26
70	https://picsum.photos/seed/WUmOM/640/480	video	1	2026-04-13 01:10:53.562647	27
71	https://picsum.photos/seed/94OSWzmzg4/640/480	image	2	2026-04-13 01:10:53.564936	27
72	https://picsum.photos/seed/X8mplat/640/480	video	3	2026-04-13 01:10:53.567829	27
73	https://picsum.photos/seed/7PDyrc/640/480	image	4	2026-04-13 01:10:53.570842	27
74	https://picsum.photos/seed/3WY1T/640/480	image	5	2026-04-13 01:10:53.574322	27
75	https://picsum.photos/seed/8vkWu9e/640/480	image	1	2026-04-13 01:10:53.578134	28
76	https://picsum.photos/seed/6Qv28Y/640/480	video	2	2026-04-13 01:10:53.580428	28
77	https://picsum.photos/seed/FWYxzAYK/640/480	video	3	2026-04-13 01:10:53.583366	28
78	https://picsum.photos/seed/IolvJ/640/480	image	4	2026-04-13 01:10:53.58562	28
79	https://picsum.photos/seed/xNgpZfkkLD/640/480	image	5	2026-04-13 01:10:53.58892	28
80	https://picsum.photos/seed/UghleQ9m/640/480	video	1	2026-04-13 01:10:53.592763	29
81	https://picsum.photos/seed/m5WbNm8yyW/640/480	image	2	2026-04-13 01:10:53.595392	29
82	https://picsum.photos/seed/RsXO2I/640/480	image	3	2026-04-13 01:10:53.598271	29
83	https://picsum.photos/seed/3ISRYxUF/640/480	video	4	2026-04-13 01:10:53.601459	29
84	https://picsum.photos/seed/2RHGlgIZ/640/480	video	1	2026-04-13 01:10:53.603941	30
85	https://picsum.photos/seed/5QsJks/640/480	video	1	2026-04-13 01:10:53.607626	31
86	https://picsum.photos/seed/y04ZmbaD/640/480	image	2	2026-04-13 01:10:53.611002	31
87	https://picsum.photos/seed/8i4Cas0C/640/480	image	1	2026-04-13 01:10:53.613757	32
88	https://picsum.photos/seed/L02AYFNCh/640/480	image	1	2026-04-13 01:10:53.616372	33
89	https://picsum.photos/seed/Bh5Ad/640/480	video	2	2026-04-13 01:10:53.619298	33
90	https://picsum.photos/seed/qrC2d9AX/640/480	video	3	2026-04-13 01:10:53.62261	33
91	https://picsum.photos/seed/AO5gG/640/480	image	4	2026-04-13 01:10:53.626455	33
92	https://picsum.photos/seed/dteVGqMmga/640/480	video	5	2026-04-13 01:10:53.629226	33
93	https://picsum.photos/seed/exlFYu0MCY/640/480	image	1	2026-04-13 01:10:53.631844	34
94	https://picsum.photos/seed/9JxFx7O/640/480	image	2	2026-04-13 01:10:53.635064	34
95	https://picsum.photos/seed/BiJzjQX7YA/640/480	image	3	2026-04-13 01:10:53.637695	34
96	https://picsum.photos/seed/TnzqP9upC/640/480	video	4	2026-04-13 01:10:53.641958	34
97	https://picsum.photos/seed/mEQoPl/640/480	video	1	2026-04-13 01:10:53.645141	35
98	https://picsum.photos/seed/kY1dRG/640/480	video	2	2026-04-13 01:10:53.64756	35
99	https://picsum.photos/seed/Ldtr8xJe/640/480	image	3	2026-04-13 01:10:53.649822	35
100	https://picsum.photos/seed/QvHo2wBg/640/480	image	4	2026-04-13 01:10:53.652875	35
101	https://picsum.photos/seed/vTuICmLj/640/480	video	1	2026-04-13 01:10:53.655792	36
102	https://picsum.photos/seed/wvY6gC0XN/640/480	image	2	2026-04-13 01:10:53.659453	36
103	https://picsum.photos/seed/QrDQH/640/480	image	3	2026-04-13 01:10:53.662218	36
104	https://picsum.photos/seed/pMthCRW5E/640/480	video	4	2026-04-13 01:10:53.664556	36
105	https://picsum.photos/seed/DN3eNrZXrs/640/480	video	1	2026-04-13 01:10:53.667559	37
106	https://picsum.photos/seed/lN01q/640/480	image	2	2026-04-13 01:10:53.670373	37
107	https://picsum.photos/seed/J5ffllAko/640/480	video	1	2026-04-13 01:10:53.674372	38
108	https://picsum.photos/seed/wQap9yjs/640/480	video	2	2026-04-13 01:10:53.678814	38
109	https://picsum.photos/seed/s7HxB/640/480	video	3	2026-04-13 01:10:53.681886	38
110	https://picsum.photos/seed/Whofj6X/640/480	image	1	2026-04-13 01:10:53.685117	39
111	https://picsum.photos/seed/m5OTJKJ/640/480	image	2	2026-04-13 01:10:53.687806	39
112	https://picsum.photos/seed/3yCGn6/640/480	video	1	2026-04-13 01:10:53.691944	40
113	https://picsum.photos/seed/GdMn6/640/480	video	2	2026-04-13 01:10:53.6955	40
114	https://picsum.photos/seed/1aMNV/640/480	video	3	2026-04-13 01:10:53.698321	40
115	https://picsum.photos/seed/E4jkeyW/640/480	video	4	2026-04-13 01:10:53.701499	40
116	https://picsum.photos/seed/E2YxtJOy/640/480	video	1	2026-04-13 01:10:53.704413	41
117	https://picsum.photos/seed/yoh6A/640/480	image	2	2026-04-13 01:10:53.708348	41
118	https://picsum.photos/seed/kyxpKz7/640/480	video	3	2026-04-13 01:10:53.711965	41
119	https://picsum.photos/seed/bOIeXheI/640/480	image	4	2026-04-13 01:10:53.714639	41
120	https://picsum.photos/seed/0nldagrk/640/480	image	5	2026-04-13 01:10:53.71739	41
121	https://picsum.photos/seed/pUg6q4/640/480	video	1	2026-04-13 01:10:53.720367	42
122	https://picsum.photos/seed/iMRiQ/640/480	video	2	2026-04-13 01:10:53.723604	42
123	https://picsum.photos/seed/caJerBp/640/480	image	3	2026-04-13 01:10:53.72717	42
124	https://picsum.photos/seed/C23Y3pj/640/480	image	4	2026-04-13 01:10:53.730215	42
125	https://picsum.photos/seed/0ZgYqxu/640/480	image	5	2026-04-13 01:10:53.73433	42
126	https://picsum.photos/seed/D5oug/640/480	image	1	2026-04-13 01:10:53.737536	43
127	https://picsum.photos/seed/pbZrh8D/640/480	video	2	2026-04-13 01:10:53.741234	43
128	https://picsum.photos/seed/0ZWa1mFj/640/480	image	3	2026-04-13 01:10:53.745005	43
129	https://picsum.photos/seed/fNhwO0/640/480	video	4	2026-04-13 01:10:53.748504	43
130	https://picsum.photos/seed/UaIfQwypS/640/480	video	5	2026-04-13 01:10:53.751149	43
131	https://picsum.photos/seed/NznccOK/640/480	video	1	2026-04-13 01:10:53.753809	44
132	https://picsum.photos/seed/GmtpUl/640/480	image	2	2026-04-13 01:10:53.757836	44
133	https://picsum.photos/seed/1BaVvqwgy/640/480	video	3	2026-04-13 01:10:53.761355	44
134	https://picsum.photos/seed/yJ6KkuA6X/640/480	image	1	2026-04-13 01:10:53.764146	45
135	https://picsum.photos/seed/uG0gJk/640/480	video	2	2026-04-13 01:10:53.766536	45
136	https://picsum.photos/seed/RfWVVX/640/480	video	1	2026-04-13 01:10:53.769677	46
137	https://picsum.photos/seed/A5wzXm/640/480	video	2	2026-04-13 01:10:53.772772	46
138	https://picsum.photos/seed/cIkNseGZk/640/480	image	3	2026-04-13 01:10:53.77684	46
139	https://picsum.photos/seed/BkfHZUK/640/480	image	4	2026-04-13 01:10:53.77971	46
140	https://picsum.photos/seed/TEkSyb/640/480	image	1	2026-04-13 01:10:53.782866	47
141	https://picsum.photos/seed/VCzvSS/640/480	image	2	2026-04-13 01:10:53.785664	47
142	https://picsum.photos/seed/t8oNih/640/480	video	3	2026-04-13 01:10:53.788222	47
143	https://picsum.photos/seed/lZlVRn/640/480	image	4	2026-04-13 01:10:53.791611	47
144	https://picsum.photos/seed/CGngxInhL/640/480	video	5	2026-04-13 01:10:53.796064	47
145	https://picsum.photos/seed/gezfz/640/480	video	1	2026-04-13 01:10:53.798619	48
146	https://picsum.photos/seed/ALZUhh1Ng/640/480	image	2	2026-04-13 01:10:53.801264	48
147	https://picsum.photos/seed/eZf2z/640/480	image	3	2026-04-13 01:10:53.803756	48
148	https://picsum.photos/seed/mOrUPn/640/480	image	4	2026-04-13 01:10:53.80631	48
149	https://picsum.photos/seed/GI0yv/640/480	video	5	2026-04-13 01:10:53.810204	48
150	https://picsum.photos/seed/jrRT6/640/480	image	1	2026-04-13 01:10:53.812766	49
151	https://picsum.photos/seed/CgZYbJFb/640/480	image	2	2026-04-13 01:10:53.815222	49
152	https://picsum.photos/seed/Ciz0scII/640/480	image	3	2026-04-13 01:10:53.818199	49
153	https://picsum.photos/seed/Aa4J51A7/640/480	image	4	2026-04-13 01:10:53.821009	49
154	https://picsum.photos/seed/SWaziCf4Xt/640/480	image	5	2026-04-13 01:10:53.828769	49
155	https://picsum.photos/seed/5uPEYu/640/480	video	1	2026-04-13 01:10:53.833748	50
233	https://picsum.photos/seed/4oyLyi/640/480	image	4	2026-04-13 01:10:54.096799	79
156	https://picsum.photos/seed/i5deX1c/640/480	video	1	2026-04-13 01:10:53.842595	51
157	https://picsum.photos/seed/DfZrpR5ce/640/480	video	2	2026-04-13 01:10:53.850182	51
158	https://picsum.photos/seed/Ql3jT/640/480	image	3	2026-04-13 01:10:53.856408	51
159	https://picsum.photos/seed/wE8eT/640/480	image	4	2026-04-13 01:10:53.86082	51
160	https://picsum.photos/seed/uDpSH8/640/480	image	1	2026-04-13 01:10:53.867213	52
161	https://picsum.photos/seed/FIS3W7/640/480	image	2	2026-04-13 01:10:53.873311	52
162	https://picsum.photos/seed/RPDpbrw/640/480	image	3	2026-04-13 01:10:53.877442	52
163	https://picsum.photos/seed/i4ynT/640/480	video	4	2026-04-13 01:10:53.880383	52
164	https://picsum.photos/seed/mPGth6I/640/480	video	5	2026-04-13 01:10:53.883943	52
165	https://picsum.photos/seed/pmroqW/640/480	video	1	2026-04-13 01:10:53.887565	53
166	https://picsum.photos/seed/zXyCbi/640/480	image	1	2026-04-13 01:10:53.891161	54
167	https://picsum.photos/seed/hVB5tiP5/640/480	video	2	2026-04-13 01:10:53.895225	54
168	https://picsum.photos/seed/h42isHQzBb/640/480	image	3	2026-04-13 01:10:53.898392	54
169	https://picsum.photos/seed/tbXUcRgE/640/480	image	4	2026-04-13 01:10:53.902121	54
170	https://picsum.photos/seed/BEKn0xo/640/480	image	5	2026-04-13 01:10:53.905093	54
171	https://picsum.photos/seed/gOxClkA/640/480	video	1	2026-04-13 01:10:53.909256	55
172	https://picsum.photos/seed/cvXmW/640/480	image	2	2026-04-13 01:10:53.912585	55
173	https://picsum.photos/seed/Vj8v8ib7q/640/480	image	1	2026-04-13 01:10:53.915649	56
174	https://picsum.photos/seed/fDtT1W/640/480	video	2	2026-04-13 01:10:53.918314	56
175	https://picsum.photos/seed/lbh2LXY0/640/480	video	3	2026-04-13 01:10:53.921426	56
176	https://picsum.photos/seed/SRbnBVYuhz/640/480	image	4	2026-04-13 01:10:53.926001	56
177	https://picsum.photos/seed/WqgNICQ/640/480	video	1	2026-04-13 01:10:53.928555	57
178	https://picsum.photos/seed/xME17b2Ms/640/480	video	1	2026-04-13 01:10:53.930839	58
179	https://picsum.photos/seed/bWbrd0P/640/480	image	2	2026-04-13 01:10:53.933832	58
180	https://picsum.photos/seed/zSQpOvk/640/480	image	1	2026-04-13 01:10:53.936873	59
181	https://picsum.photos/seed/ssY0bCEY/640/480	image	1	2026-04-13 01:10:53.939715	60
182	https://picsum.photos/seed/5MU70f/640/480	video	2	2026-04-13 01:10:53.944575	60
183	https://picsum.photos/seed/eDF3d/640/480	image	1	2026-04-13 01:10:53.946911	61
184	https://picsum.photos/seed/2r5HxQm/640/480	video	2	2026-04-13 01:10:53.949482	61
185	https://picsum.photos/seed/Oy1Y4/640/480	image	3	2026-04-13 01:10:53.951611	61
186	https://picsum.photos/seed/D2qW0C6/640/480	image	4	2026-04-13 01:10:53.954348	61
187	https://picsum.photos/seed/9VSV6vR/640/480	video	5	2026-04-13 01:10:53.957565	61
188	https://picsum.photos/seed/4ZmPYUY/640/480	image	1	2026-04-13 01:10:53.960933	62
189	https://picsum.photos/seed/K5IZU/640/480	video	2	2026-04-13 01:10:53.963484	62
190	https://picsum.photos/seed/qA4ZLit5f/640/480	image	3	2026-04-13 01:10:53.966351	62
191	https://picsum.photos/seed/pTySfNa/640/480	image	1	2026-04-13 01:10:53.968695	63
192	https://picsum.photos/seed/aQICfPZ5VN/640/480	video	2	2026-04-13 01:10:53.972716	63
193	https://picsum.photos/seed/qRPBdX/640/480	image	3	2026-04-13 01:10:53.976375	63
194	https://picsum.photos/seed/gNY6ajStF/640/480	image	1	2026-04-13 01:10:53.978676	64
195	https://picsum.photos/seed/Uh3PyINbJ2/640/480	video	1	2026-04-13 01:10:53.980828	65
196	https://picsum.photos/seed/dYyP3J/640/480	video	1	2026-04-13 01:10:53.984101	66
197	https://picsum.photos/seed/09SlDBre/640/480	video	2	2026-04-13 01:10:53.986883	66
198	https://picsum.photos/seed/TSFg8Lz/640/480	image	3	2026-04-13 01:10:53.990835	66
199	https://picsum.photos/seed/mjNddwxP/640/480	image	4	2026-04-13 01:10:53.99408	66
200	https://picsum.photos/seed/RVmpaBgIe/640/480	image	5	2026-04-13 01:10:53.99649	66
201	https://picsum.photos/seed/LqYivLQ/640/480	image	1	2026-04-13 01:10:53.998928	67
202	https://picsum.photos/seed/caesnzH/640/480	video	2	2026-04-13 01:10:54.001483	67
203	https://picsum.photos/seed/xFJSHNI8Z/640/480	video	3	2026-04-13 01:10:54.004091	67
204	https://picsum.photos/seed/lcgH3/640/480	image	4	2026-04-13 01:10:54.007662	67
205	https://picsum.photos/seed/iyP4ma2DH/640/480	video	1	2026-04-13 01:10:54.010817	68
206	https://picsum.photos/seed/wchGpzIDu/640/480	video	2	2026-04-13 01:10:54.013768	68
207	https://picsum.photos/seed/6m8rrjB/640/480	image	3	2026-04-13 01:10:54.015891	68
208	https://picsum.photos/seed/qeZxnEn/640/480	image	4	2026-04-13 01:10:54.018474	68
209	https://picsum.photos/seed/9igwrWeYy/640/480	image	1	2026-04-13 01:10:54.021959	69
210	https://picsum.photos/seed/ppt2PQe/640/480	video	2	2026-04-13 01:10:54.025606	69
211	https://picsum.photos/seed/MdI2PAL/640/480	image	3	2026-04-13 01:10:54.028438	69
212	https://picsum.photos/seed/SKEDJ3M/640/480	image	1	2026-04-13 01:10:54.031301	70
213	https://picsum.photos/seed/kjIDn0Ae/640/480	image	2	2026-04-13 01:10:54.033554	70
214	https://picsum.photos/seed/PppxC/640/480	image	3	2026-04-13 01:10:54.036256	70
215	https://picsum.photos/seed/G05IU4qEY/640/480	video	1	2026-04-13 01:10:54.038864	71
216	https://picsum.photos/seed/DmIm4hZLCg/640/480	video	1	2026-04-13 01:10:54.043145	72
217	https://picsum.photos/seed/Ob3hW/640/480	image	2	2026-04-13 01:10:54.045834	72
218	https://picsum.photos/seed/4Jbi6L/640/480	video	1	2026-04-13 01:10:54.048827	73
219	https://picsum.photos/seed/mcUVOt/640/480	image	2	2026-04-13 01:10:54.051158	73
220	https://picsum.photos/seed/kbwyHC/640/480	video	1	2026-04-13 01:10:54.055315	74
221	https://picsum.photos/seed/AMVJE/640/480	video	2	2026-04-13 01:10:54.059679	74
222	https://picsum.photos/seed/7TV4REn/640/480	video	3	2026-04-13 01:10:54.062217	74
223	https://picsum.photos/seed/NCtZ0tu/640/480	video	1	2026-04-13 01:10:54.0652	75
224	https://picsum.photos/seed/ZQoNIM7lNy/640/480	video	2	2026-04-13 01:10:54.068249	75
225	https://picsum.photos/seed/qTsEZYfFN8/640/480	image	1	2026-04-13 01:10:54.071082	76
226	https://picsum.photos/seed/GkBJtc2jG/640/480	video	2	2026-04-13 01:10:54.07507	76
227	https://picsum.photos/seed/Wtisma9/640/480	image	3	2026-04-13 01:10:54.078592	76
228	https://picsum.photos/seed/O0G4qc/640/480	video	1	2026-04-13 01:10:54.080925	77
229	https://picsum.photos/seed/v2VbAI/640/480	video	1	2026-04-13 01:10:54.083784	78
230	https://picsum.photos/seed/ZeL8cmHjB/640/480	video	1	2026-04-13 01:10:54.086926	79
231	https://picsum.photos/seed/dTuBWRBn1/640/480	video	2	2026-04-13 01:10:54.09038	79
232	https://picsum.photos/seed/eGrAVBjLHb/640/480	video	3	2026-04-13 01:10:54.094231	79
234	https://picsum.photos/seed/gYnAc/640/480	video	5	2026-04-13 01:10:54.09984	79
235	https://picsum.photos/seed/zAK3mKz/640/480	image	1	2026-04-13 01:10:54.102593	80
236	https://picsum.photos/seed/SJ23fl/640/480	image	2	2026-04-13 01:10:54.105893	80
237	https://picsum.photos/seed/fqorV0/640/480	video	1	2026-04-13 01:10:54.10962	81
238	https://picsum.photos/seed/2Pt8WoWe7/640/480	image	2	2026-04-13 01:10:54.112757	81
239	https://picsum.photos/seed/qqHIG/640/480	video	3	2026-04-13 01:10:54.115823	81
240	https://picsum.photos/seed/GnxX9r1d/640/480	image	1	2026-04-13 01:10:54.118802	82
241	https://picsum.photos/seed/fPq2WXMmtZ/640/480	video	1	2026-04-13 01:10:54.121559	83
242	https://picsum.photos/seed/9p7FaNu/640/480	image	2	2026-04-13 01:10:54.125636	83
243	https://picsum.photos/seed/Tun1Hqdll/640/480	image	3	2026-04-13 01:10:54.128966	83
244	https://picsum.photos/seed/TUQfrCjRg1/640/480	video	4	2026-04-13 01:10:54.131519	83
245	https://picsum.photos/seed/KO1px9dtT/640/480	image	1	2026-04-13 01:10:54.133801	84
246	https://picsum.photos/seed/seOj5/640/480	image	2	2026-04-13 01:10:54.136749	84
247	https://picsum.photos/seed/ct9YR4G0Gj/640/480	image	3	2026-04-13 01:10:54.139422	84
248	https://picsum.photos/seed/kpfjs/640/480	video	4	2026-04-13 01:10:54.143146	84
249	https://picsum.photos/seed/D8bAZ1ojeb/640/480	video	5	2026-04-13 01:10:54.145799	84
250	https://picsum.photos/seed/4zFfNcn/640/480	video	1	2026-04-13 01:10:54.148678	85
251	https://picsum.photos/seed/k2Rur/640/480	video	2	2026-04-13 01:10:54.152863	85
252	https://picsum.photos/seed/v8ITB4u/640/480	video	3	2026-04-13 01:10:54.155998	85
253	https://picsum.photos/seed/L7neVe/640/480	video	1	2026-04-13 01:10:54.15986	86
254	https://picsum.photos/seed/9oKims9t/640/480	image	1	2026-04-13 01:10:54.162741	87
255	https://picsum.photos/seed/irjYLeF/640/480	video	2	2026-04-13 01:10:54.165523	87
256	https://picsum.photos/seed/K01kIsUV/640/480	video	3	2026-04-13 01:10:54.168448	87
257	https://picsum.photos/seed/qFJGvARcL/640/480	image	4	2026-04-13 01:10:54.171051	87
258	https://picsum.photos/seed/DQsmBH/640/480	image	1	2026-04-13 01:10:54.174905	88
259	https://picsum.photos/seed/Kf2gZj/640/480	video	2	2026-04-13 01:10:54.178358	88
260	https://picsum.photos/seed/2ruVswGF/640/480	video	3	2026-04-13 01:10:54.182397	88
261	https://picsum.photos/seed/mhmkPdpi7/640/480	image	4	2026-04-13 01:10:54.185372	88
262	https://picsum.photos/seed/GqTl3KmcX/640/480	image	1	2026-04-13 01:10:54.188562	89
263	https://picsum.photos/seed/VudXzV0/640/480	image	2	2026-04-13 01:10:54.192563	89
264	https://picsum.photos/seed/PnbqThHKc/640/480	video	3	2026-04-13 01:10:54.195534	89
265	https://picsum.photos/seed/zzeiyuy/640/480	image	1	2026-04-13 01:10:54.198319	90
266	https://picsum.photos/seed/dZXcNbY/640/480	image	2	2026-04-13 01:10:54.200835	90
267	https://picsum.photos/seed/bXDb3D/640/480	video	3	2026-04-13 01:10:54.204424	90
268	https://picsum.photos/seed/2uacd0cR1/640/480	image	1	2026-04-13 01:10:54.208472	91
269	https://picsum.photos/seed/lpRpAq/640/480	image	2	2026-04-13 01:10:54.211766	91
270	https://picsum.photos/seed/980CujFEm/640/480	video	1	2026-04-13 01:10:54.214566	92
271	https://picsum.photos/seed/iBVjj3a/640/480	image	2	2026-04-13 01:10:54.218034	92
272	https://picsum.photos/seed/OlvokJ/640/480	video	3	2026-04-13 01:10:54.220489	92
273	https://picsum.photos/seed/QjA9AB/640/480	video	4	2026-04-13 01:10:54.225504	92
274	https://picsum.photos/seed/JmffQpK7qu/640/480	image	1	2026-04-13 01:10:54.229758	93
275	https://picsum.photos/seed/jz9ErM2b/640/480	video	2	2026-04-13 01:10:54.234287	93
276	https://picsum.photos/seed/Ql97i1/640/480	video	3	2026-04-13 01:10:54.238322	93
277	https://picsum.photos/seed/nKskpwn/640/480	video	1	2026-04-13 01:10:54.243637	94
278	https://picsum.photos/seed/arMxu72Do/640/480	image	2	2026-04-13 01:10:54.247297	94
279	https://picsum.photos/seed/XO9HzCJA/640/480	video	1	2026-04-13 01:10:54.251348	95
280	https://picsum.photos/seed/lECm4kwg/640/480	video	2	2026-04-13 01:10:54.255944	95
281	https://picsum.photos/seed/Rm2jd/640/480	image	3	2026-04-13 01:10:54.260618	95
282	https://picsum.photos/seed/qvLd0/640/480	video	4	2026-04-13 01:10:54.263907	95
283	https://picsum.photos/seed/G0v4HDIme6/640/480	video	5	2026-04-13 01:10:54.267422	95
284	https://picsum.photos/seed/lAsg8s/640/480	image	1	2026-04-13 01:10:54.270646	96
285	https://picsum.photos/seed/o2evhNCtF/640/480	video	2	2026-04-13 01:10:54.274622	96
286	https://picsum.photos/seed/xwoPtm8/640/480	image	1	2026-04-13 01:10:54.277957	97
287	https://picsum.photos/seed/uypDrScGVt/640/480	image	2	2026-04-13 01:10:54.281423	97
288	https://picsum.photos/seed/diXY2M/640/480	image	3	2026-04-13 01:10:54.284727	97
289	https://picsum.photos/seed/NPDB2VGj0g/640/480	video	1	2026-04-13 01:10:54.289678	98
290	https://picsum.photos/seed/Y3ikr7OB0o/640/480	image	1	2026-04-13 01:10:54.294578	99
291	https://picsum.photos/seed/Gs1qzn/640/480	image	2	2026-04-13 01:10:54.298512	99
292	https://picsum.photos/seed/LQv0ktCLGn/640/480	image	3	2026-04-13 01:10:54.302263	99
293	https://picsum.photos/seed/SaqKy74wB/640/480	image	4	2026-04-13 01:10:54.306625	99
294	https://picsum.photos/seed/YelmJnd/640/480	video	1	2026-04-13 01:10:54.311313	100
295	https://picsum.photos/seed/8kobmhCW/640/480	video	2	2026-04-13 01:10:54.314963	100
296	https://picsum.photos/seed/mMpwX/640/480	video	3	2026-04-13 01:10:54.318174	100
297	https://picsum.photos/seed/aUguJ2J/640/480	video	4	2026-04-13 01:10:54.32118	100
\.


--
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.posts (id, title, status, location, created_at, user_id) FROM stdin;
1	Atrocitas delectus viscus pauper creo.	public	Carletonhaven	2026-04-13 01:10:53.319596	46
2	Amoveo speculum turbo audio concedo tantillus ventosus.	public	Lake Verner	2026-04-13 01:10:53.319596	89
3	Cuius cena sponte stabilis perspiciatis cruentus sponte vomica.	public	East Julien	2026-04-13 01:10:53.319596	76
4	Ater ipsa carus terra deludo delectus vix.	private	Daly City	2026-04-13 01:10:53.319596	74
5	Confido copia contigo utroque commodo.	private	West Keventon	2026-04-13 01:10:53.319596	80
6	Vitium virga cubo cerno accommodo cogito textus socius undique.	public	New Vincenza	2026-04-13 01:10:53.319596	72
7	Sursum exercitationem cotidie caste testimonium tricesimus subvenio tui tergeo temperantia.	private	Lake Jane	2026-04-13 01:10:53.319596	77
8	Benevolentia veniam curatio claudeo astrum convoco.	public	Wunschburgh	2026-04-13 01:10:53.319596	38
9	Vergo dens aeternus vester suggero vulgo territo.	public	New Cleve	2026-04-13 01:10:53.319596	71
10	Caelum votum pauper sollicito similique conspergo amplitudo crur aiunt baiulus.	private	North Dominiquehaven	2026-04-13 01:10:53.319596	55
11	Deduco tredecim deleniti velut peccatus sono at concedo tepidus.	public	Jakubowskiland	2026-04-13 01:10:53.319596	63
12	Depereo artificiose stabilis villa dapifer derideo aveho tantum.	private	Enid	2026-04-13 01:10:53.319596	65
13	Dolorum debilito cilicium arcus dolorem facilis totidem.	public	Potomac	2026-04-13 01:10:53.319596	41
14	Vicinus adversus triduana desparatus et.	public	Lake Celestinestead	2026-04-13 01:10:53.319596	64
15	Quia tubineus cado abscido.	private	Krajcikfort	2026-04-13 01:10:53.319596	77
16	Undique vehemens taceo spoliatio.	public	West Halside	2026-04-13 01:10:53.319596	75
17	Vinculum bellicus spargo aegrus comburo contego.	private	Emardworth	2026-04-13 01:10:53.319596	72
18	Certe spargo conicio.	public	New Sylvanbury	2026-04-13 01:10:53.319596	59
19	Supra aureus maiores brevis casso aduro.	private	West Javierstead	2026-04-13 01:10:53.319596	86
20	Cumque ascit perspiciatis decumbo depulso terra depraedor amplexus cupressus.	private	Orem	2026-04-13 01:10:53.319596	47
21	Provident cuius in nam thalassinus avarus victus celer advoco.	public	East Amosfort	2026-04-13 01:10:53.319596	25
22	Ancilla cumque distinctio unde.	private	New Joanne	2026-04-13 01:10:53.319596	36
23	Subiungo asper consequatur vito dolores in baiulus.	private	Felipefield	2026-04-13 01:10:53.319596	11
24	Arx conicio rerum centum demens eveniet vinco alo.	public	Dale City	2026-04-13 01:10:53.319596	65
25	Desino vinculum testimonium curto vivo ventus conicio amet quam.	private	South Valley	2026-04-13 01:10:53.319596	54
26	Agnitio villa cribro vapulus appono.	private	Wiegandton	2026-04-13 01:10:53.319596	95
27	Decretum succurro capio amplexus sono officia cogo absconditus demitto.	private	Brekkeworth	2026-04-13 01:10:53.319596	68
28	Cupio absque cernuus.	public	Port Anya	2026-04-13 01:10:53.319596	56
29	Artificiose laborum eligendi damnatio.	public	South Ardith	2026-04-13 01:10:53.319596	59
30	Bestia arbustum cibo appositus tutis despecto vae tertius curatio.	private	Lilianstead	2026-04-13 01:10:53.319596	98
31	Sursum tui ancilla contego quis cavus molestiae cenaculum vomer.	private	Noeport	2026-04-13 01:10:53.319596	15
32	Valeo vae subvenio provident magni copia tum curriculum.	private	Trantowfort	2026-04-13 01:10:53.319596	56
33	Caecus utroque templum.	private	Rennerstead	2026-04-13 01:10:53.319596	63
34	Allatus curriculum decimus curiositas.	public	Hassieville	2026-04-13 01:10:53.319596	31
35	Teres absens vir uter accendo adamo conatus appono pauper maiores.	public	New Britain	2026-04-13 01:10:53.319596	33
36	Doloremque veniam sub deporto minus delicate cotidie caecus calco.	private	Lake Clevelandworth	2026-04-13 01:10:53.319596	9
37	Maiores vomito crinis alias nisi arbustum vero defleo appello.	public	Breannacester	2026-04-13 01:10:53.319596	38
38	Arbor adinventitias tutamen.	public	East Providence	2026-04-13 01:10:53.319596	93
39	Asporto strues aequus nihil curia dolorum.	private	New Sigurd	2026-04-13 01:10:53.319596	64
40	Talio vesco artificiose voluptate adeptio.	private	North Eastonbury	2026-04-13 01:10:53.319596	72
41	Suppono derelinquo libero summisse teneo adamo colligo conventus corrumpo.	private	Midwest City	2026-04-13 01:10:53.319596	34
42	Aegrotatio universe adversus canto aurum textus.	private	Fort Artcester	2026-04-13 01:10:53.319596	85
43	Bos carbo numquam apud spero a tergum.	private	Lilianemouth	2026-04-13 01:10:53.319596	42
44	Tibi turbo urbanus speculum abutor.	private	Cruickshankland	2026-04-13 01:10:53.319596	56
45	Asperiores asper sperno attollo vere corrumpo condico tergiversatio.	private	Gleichnertown	2026-04-13 01:10:53.319596	68
46	Cenaculum absconditus absum alii summa cervus cultellus amplitudo absorbeo.	public	Santostown	2026-04-13 01:10:53.319596	80
47	Impedit accendo celer verecundia.	private	East Georgiannamouth	2026-04-13 01:10:53.319596	65
48	Textus abbas certus.	public	North Douglasport	2026-04-13 01:10:53.319596	54
49	Creator consectetur suffragium sto vinco textus nostrum creber caritas arceo.	public	Starkland	2026-04-13 01:10:53.319596	69
50	Callide theologus comparo somnus bellum auditor sum consequatur defungo agnitio.	private	Clearwater	2026-04-13 01:10:53.319596	70
51	Venia sit coaegresco.	public	South Mckenna	2026-04-13 01:10:53.319596	6
52	Amor debitis conservo.	public	Stiedemannboro	2026-04-13 01:10:53.319596	99
53	Sunt adficio voro apparatus arx tondeo.	public	East Edgardo	2026-04-13 01:10:53.319596	60
54	Accedo vigor avaritia aperte cena temeritas cornu alter temporibus caecus.	private	Moiseschester	2026-04-13 01:10:53.319596	12
55	Suscipio adeptio iste alius curriculum molestiae possimus volaticus.	private	Danville	2026-04-13 01:10:53.319596	66
56	Tener appositus curia.	private	Feilport	2026-04-13 01:10:53.319596	15
57	Aggredior repellat casso vos aegrus ipsa acerbitas ultra adipisci conitor.	public	York	2026-04-13 01:10:53.319596	33
58	Textor necessitatibus cohaero.	public	Destinyhaven	2026-04-13 01:10:53.319596	97
59	Calamitas constans reiciendis solum sunt.	public	North Dariotown	2026-04-13 01:10:53.319596	31
60	Voluptates tempus usitas sortitus vorago addo trado utique voro delectatio.	private	South Percy	2026-04-13 01:10:53.319596	94
61	Eum pel conservo crur vomito supellex charisma consuasor.	public	Rio Rancho	2026-04-13 01:10:53.319596	27
62	Defaeco conspergo decipio tactus aegre volaticus.	private	The Villages	2026-04-13 01:10:53.319596	90
63	Tantillus complectus undique totus blanditiis tonsor constans.	private	North Samson	2026-04-13 01:10:53.319596	56
64	Cursim corpus odio sordeo officiis desipio casus commodo coadunatio.	private	East Kylamouth	2026-04-13 01:10:53.319596	36
65	Coadunatio viridis vinco clam cultura quia.	private	Verlieview	2026-04-13 01:10:53.319596	5
66	Arma desparatus mollitia.	public	Paytonview	2026-04-13 01:10:53.319596	41
67	Pariatur victoria confido stillicidium utor unde conduco delectatio aureus.	private	Davis	2026-04-13 01:10:53.319596	25
68	Adstringo cruentus tempus conduco dens canis uredo custodia temeritas.	public	Flatleystead	2026-04-13 01:10:53.319596	76
69	Explicabo caste conspergo animadverto conspergo.	public	Cartwrightview	2026-04-13 01:10:53.319596	61
70	Bos damnatio vis cubitum vapulus compello alienus.	public	Runolfssonview	2026-04-13 01:10:53.319596	9
71	Complectus sonitus universe adinventitias desparatus tumultus absens dens.	private	Glen Burnie	2026-04-13 01:10:53.319596	2
72	Voluptatum absconditus creptio caritas creo considero.	public	Landenport	2026-04-13 01:10:53.319596	20
73	Calcar tubineus terebro virgo id argumentum thesaurus appositus blanditiis vulticulus.	private	East Pansychester	2026-04-13 01:10:53.319596	100
74	Casso vaco stabilis baiulus validus succedo volaticus.	public	Royal Oak	2026-04-13 01:10:53.319596	57
75	Absum demulceo auctus talis sufficio collum.	public	East Judsonborough	2026-04-13 01:10:53.319596	9
76	Canis tamquam coepi desidero termes comis deleo desipio.	private	Coleshire	2026-04-13 01:10:53.319596	96
77	Aedificium consuasor ea alter tantum.	private	Fort Leathachester	2026-04-13 01:10:53.319596	21
78	Cunae vaco accusator casso occaecati caelestis natus aliquid fuga bibo.	public	Collinsfort	2026-04-13 01:10:53.319596	26
79	Uxor ustilo auctor corporis vallum creator.	private	West Lacey	2026-04-13 01:10:53.319596	37
80	Sufficio ustulo cattus corpus viscus arca caste id audentia adstringo.	public	Faheyworth	2026-04-13 01:10:53.319596	69
81	Tabernus ullus odio auctor denuo.	private	Ebertboro	2026-04-13 01:10:53.319596	50
82	Conturbo unus absens vergo vorago voveo eius tantillus.	public	Port Alycia	2026-04-13 01:10:53.319596	91
83	Amor verus subiungo asporto ambitus tamdiu universe dolor dolorum.	private	West Donna	2026-04-13 01:10:53.319596	76
84	Vesco eius triumphus.	private	Rogers	2026-04-13 01:10:53.319596	52
85	Iusto allatus sonitus desino utroque conduco somniculosus terebro vehemens sequi.	public	West Zoila	2026-04-13 01:10:53.319596	80
86	Usitas coepi cognomen voluptate veritas tero.	private	New Kristinchester	2026-04-13 01:10:53.319596	42
87	Volubilis accusamus adhaero apud ultio antea desino testimonium consequuntur.	private	Gideonstad	2026-04-13 01:10:53.319596	41
88	Patruus argumentum vir celo hic.	public	North Bradley	2026-04-13 01:10:53.319596	44
89	Bardus adfero terga aestas.	public	North Westley	2026-04-13 01:10:53.319596	58
90	Tonsor supellex tibi ab placeat delego.	private	Levittown	2026-04-13 01:10:53.319596	34
91	Explicabo defleo tenetur solum adipisci dedico cum.	private	Danielton	2026-04-13 01:10:53.319596	90
92	Deficio convoco desparatus adaugeo venia.	private	Fort Ron	2026-04-13 01:10:53.319596	82
93	Tondeo acies alius capto mollitia vulgaris beatus coadunatio summisse deporto.	private	East Ashaview	2026-04-13 01:10:53.319596	20
94	Vilitas corpus copia.	public	Lake Tatyanacester	2026-04-13 01:10:53.319596	59
95	Cruentus audentia crux demergo teneo ante utor nulla tepesco.	public	Funkstad	2026-04-13 01:10:53.319596	22
96	Quasi cognatus ustilo solus earum cohaero ancilla spectaculum coadunatio.	private	Lake Jeffryport	2026-04-13 01:10:53.319596	45
97	Autus clam atqui.	public	Montgomery	2026-04-13 01:10:53.319596	18
98	Aro deinde delicate asperiores tendo creo conculco acer nulla.	public	South Noelia	2026-04-13 01:10:53.319596	50
99	Tenuis compono ademptio soluta doloremque stillicidium audacia.	private	Nolanshire	2026-04-13 01:10:53.319596	82
100	Caste spes cunctatio.	private	Fort Jerodbury	2026-04-13 01:10:53.319596	61
\.


--
-- Data for Name: saved_posts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.saved_posts (user_id, post_id, created_at) FROM stdin;
60	1	2026-04-13 01:10:54.387523
38	1	2026-04-13 01:10:54.393499
55	2	2026-04-13 01:10:54.445565
58	2	2026-04-13 01:10:54.449234
83	2	2026-04-13 01:10:54.453015
63	2	2026-04-13 01:10:54.457131
14	3	2026-04-13 01:10:54.492898
60	3	2026-04-13 01:10:54.496452
86	4	2026-04-13 01:10:54.52812
82	5	2026-04-13 01:10:54.601889
34	5	2026-04-13 01:10:54.60619
59	5	2026-04-13 01:10:54.611002
99	5	2026-04-13 01:10:54.614811
52	5	2026-04-13 01:10:54.618553
73	7	2026-04-13 01:10:54.683234
78	7	2026-04-13 01:10:54.686552
76	7	2026-04-13 01:10:54.691321
92	7	2026-04-13 01:10:54.695444
22	8	2026-04-13 01:10:54.738078
10	8	2026-04-13 01:10:54.742007
79	8	2026-04-13 01:10:54.745723
18	8	2026-04-13 01:10:54.749282
3	8	2026-04-13 01:10:54.752669
13	9	2026-04-13 01:10:54.789859
54	9	2026-04-13 01:10:54.793741
79	9	2026-04-13 01:10:54.797734
84	10	2026-04-13 01:10:54.837363
96	10	2026-04-13 01:10:54.842776
1	10	2026-04-13 01:10:54.846466
93	12	2026-04-13 01:10:54.895165
61	13	2026-04-13 01:10:54.928113
97	13	2026-04-13 01:10:54.931104
78	13	2026-04-13 01:10:54.934636
53	13	2026-04-13 01:10:54.939036
30	13	2026-04-13 01:10:54.943428
76	14	2026-04-13 01:10:54.989153
52	14	2026-04-13 01:10:54.993731
51	14	2026-04-13 01:10:54.996783
72	14	2026-04-13 01:10:54.999878
61	15	2026-04-13 01:10:55.050699
66	15	2026-04-13 01:10:55.054094
65	15	2026-04-13 01:10:55.057493
100	15	2026-04-13 01:10:55.061776
38	15	2026-04-13 01:10:55.065185
82	17	2026-04-13 01:10:55.118823
46	17	2026-04-13 01:10:55.123031
11	17	2026-04-13 01:10:55.127521
99	17	2026-04-13 01:10:55.131269
90	17	2026-04-13 01:10:55.134161
45	18	2026-04-13 01:10:55.16388
68	18	2026-04-13 01:10:55.167347
34	18	2026-04-13 01:10:55.170852
31	18	2026-04-13 01:10:55.175557
43	19	2026-04-13 01:10:55.210537
48	19	2026-04-13 01:10:55.214335
37	20	2026-04-13 01:10:55.276414
63	21	2026-04-13 01:10:55.321441
79	21	2026-04-13 01:10:55.326084
48	22	2026-04-13 01:10:55.371228
39	22	2026-04-13 01:10:55.376606
11	22	2026-04-13 01:10:55.380376
70	22	2026-04-13 01:10:55.384175
22	22	2026-04-13 01:10:55.387441
25	23	2026-04-13 01:10:55.4273
8	23	2026-04-13 01:10:55.43111
11	25	2026-04-13 01:10:55.515566
80	26	2026-04-13 01:10:55.565737
66	26	2026-04-13 01:10:55.56939
36	28	2026-04-13 01:10:55.663506
42	28	2026-04-13 01:10:55.666288
2	28	2026-04-13 01:10:55.669832
71	29	2026-04-13 01:10:55.721637
34	29	2026-04-13 01:10:55.726496
33	29	2026-04-13 01:10:55.730187
36	29	2026-04-13 01:10:55.733221
52	29	2026-04-13 01:10:55.737708
79	30	2026-04-13 01:10:55.766257
32	30	2026-04-13 01:10:55.76966
86	30	2026-04-13 01:10:55.774229
83	31	2026-04-13 01:10:55.798505
75	31	2026-04-13 01:10:55.80138
19	31	2026-04-13 01:10:55.804165
86	32	2026-04-13 01:10:55.848127
29	32	2026-04-13 01:10:55.851915
72	32	2026-04-13 01:10:55.856415
79	32	2026-04-13 01:10:55.860732
91	33	2026-04-13 01:10:55.90253
90	33	2026-04-13 01:10:55.90691
17	33	2026-04-13 01:10:55.911798
51	35	2026-04-13 01:10:56.015569
5	35	2026-04-13 01:10:56.018315
15	35	2026-04-13 01:10:56.02136
50	35	2026-04-13 01:10:56.026681
22	36	2026-04-13 01:10:56.053109
85	36	2026-04-13 01:10:56.057666
92	38	2026-04-13 01:10:56.144063
28	40	2026-04-13 01:10:56.221529
34	41	2026-04-13 01:10:56.266309
64	41	2026-04-13 01:10:56.270112
5	41	2026-04-13 01:10:56.274564
38	41	2026-04-13 01:10:56.279117
65	41	2026-04-13 01:10:56.283161
55	42	2026-04-13 01:10:56.345985
50	42	2026-04-13 01:10:56.349798
98	42	2026-04-13 01:10:56.353613
37	42	2026-04-13 01:10:56.358254
21	43	2026-04-13 01:10:56.385573
14	43	2026-04-13 01:10:56.389146
77	43	2026-04-13 01:10:56.393418
76	43	2026-04-13 01:10:56.39725
54	44	2026-04-13 01:10:56.434857
63	44	2026-04-13 01:10:56.439302
27	44	2026-04-13 01:10:56.44451
5	44	2026-04-13 01:10:56.448476
69	44	2026-04-13 01:10:56.452094
68	45	2026-04-13 01:10:56.500629
53	47	2026-04-13 01:10:56.590863
96	47	2026-04-13 01:10:56.595827
18	47	2026-04-13 01:10:56.599764
44	47	2026-04-13 01:10:56.603501
78	48	2026-04-13 01:10:56.637817
90	48	2026-04-13 01:10:56.645112
37	48	2026-04-13 01:10:56.651963
45	48	2026-04-13 01:10:56.660159
87	49	2026-04-13 01:10:56.731482
67	49	2026-04-13 01:10:56.73521
40	50	2026-04-13 01:10:56.778352
16	51	2026-04-13 01:10:56.814226
99	51	2026-04-13 01:10:56.817889
16	52	2026-04-13 01:10:56.839411
61	52	2026-04-13 01:10:56.843601
11	54	2026-04-13 01:10:56.928952
95	55	2026-04-13 01:10:56.981117
7	55	2026-04-13 01:10:56.985156
38	56	2026-04-13 01:10:57.049137
87	57	2026-04-13 01:10:57.095024
58	58	2026-04-13 01:10:57.115862
56	58	2026-04-13 01:10:57.11871
79	59	2026-04-13 01:10:57.16561
19	59	2026-04-13 01:10:57.168912
68	60	2026-04-13 01:10:57.196875
35	60	2026-04-13 01:10:57.20066
57	60	2026-04-13 01:10:57.204079
42	60	2026-04-13 01:10:57.207925
15	60	2026-04-13 01:10:57.21187
83	61	2026-04-13 01:10:57.256997
100	61	2026-04-13 01:10:57.261005
79	61	2026-04-13 01:10:57.264142
77	61	2026-04-13 01:10:57.267255
52	61	2026-04-13 01:10:57.270774
23	62	2026-04-13 01:10:57.295651
75	63	2026-04-13 01:10:57.341828
14	63	2026-04-13 01:10:57.345567
83	63	2026-04-13 01:10:57.349395
96	63	2026-04-13 01:10:57.35227
51	63	2026-04-13 01:10:57.356349
57	64	2026-04-13 01:10:57.386383
10	64	2026-04-13 01:10:57.390337
52	64	2026-04-13 01:10:57.394377
76	64	2026-04-13 01:10:57.397707
74	65	2026-04-13 01:10:57.422988
92	65	2026-04-13 01:10:57.427622
87	65	2026-04-13 01:10:57.431227
41	65	2026-04-13 01:10:57.434444
95	66	2026-04-13 01:10:57.480652
70	67	2026-04-13 01:10:57.528432
58	67	2026-04-13 01:10:57.532144
84	67	2026-04-13 01:10:57.535787
38	67	2026-04-13 01:10:57.538745
71	67	2026-04-13 01:10:57.542863
36	68	2026-04-13 01:10:57.588548
40	68	2026-04-13 01:10:57.593856
53	68	2026-04-13 01:10:57.597203
19	68	2026-04-13 01:10:57.60028
8	69	2026-04-13 01:10:57.628161
93	69	2026-04-13 01:10:57.631857
24	69	2026-04-13 01:10:57.634602
59	72	2026-04-13 01:10:57.764115
100	72	2026-04-13 01:10:57.768033
51	72	2026-04-13 01:10:57.771593
67	72	2026-04-13 01:10:57.776116
74	72	2026-04-13 01:10:57.779525
92	74	2026-04-13 01:10:57.870507
70	74	2026-04-13 01:10:57.874591
13	75	2026-04-13 01:10:57.936596
60	76	2026-04-13 01:10:57.974622
61	76	2026-04-13 01:10:57.978567
17	77	2026-04-13 01:10:58.008186
16	79	2026-04-13 01:10:58.082847
60	79	2026-04-13 01:10:58.089621
53	79	2026-04-13 01:10:58.094299
38	79	2026-04-13 01:10:58.098313
33	79	2026-04-13 01:10:58.10257
66	80	2026-04-13 01:10:58.158841
36	80	2026-04-13 01:10:58.162804
37	80	2026-04-13 01:10:58.166666
58	80	2026-04-13 01:10:58.17019
77	80	2026-04-13 01:10:58.17387
50	81	2026-04-13 01:10:58.216915
20	81	2026-04-13 01:10:58.221043
36	82	2026-04-13 01:10:58.269972
77	82	2026-04-13 01:10:58.273305
23	83	2026-04-13 01:10:58.302068
48	83	2026-04-13 01:10:58.305657
67	83	2026-04-13 01:10:58.309956
5	84	2026-04-13 01:10:58.335404
15	86	2026-04-13 01:10:58.435506
67	86	2026-04-13 01:10:58.438742
75	86	2026-04-13 01:10:58.443186
66	86	2026-04-13 01:10:58.446839
73	87	2026-04-13 01:10:58.496327
76	87	2026-04-13 01:10:58.49921
92	87	2026-04-13 01:10:58.502126
63	87	2026-04-13 01:10:58.504741
68	88	2026-04-13 01:10:58.556108
94	88	2026-04-13 01:10:58.560632
34	88	2026-04-13 01:10:58.563871
56	88	2026-04-13 01:10:58.567168
94	89	2026-04-13 01:10:58.609099
24	89	2026-04-13 01:10:58.612631
49	90	2026-04-13 01:10:58.652595
35	90	2026-04-13 01:10:58.656649
57	90	2026-04-13 01:10:58.660993
64	90	2026-04-13 01:10:58.664652
60	91	2026-04-13 01:10:58.69912
16	91	2026-04-13 01:10:58.702664
42	91	2026-04-13 01:10:58.706701
32	91	2026-04-13 01:10:58.710881
9	91	2026-04-13 01:10:58.714212
61	92	2026-04-13 01:10:58.73591
56	93	2026-04-13 01:10:58.767679
24	93	2026-04-13 01:10:58.770828
63	93	2026-04-13 01:10:58.775952
15	93	2026-04-13 01:10:58.779285
91	94	2026-04-13 01:10:58.817991
7	94	2026-04-13 01:10:58.82143
56	96	2026-04-13 01:10:58.886872
7	96	2026-04-13 01:10:58.891193
68	97	2026-04-13 01:10:58.950742
75	97	2026-04-13 01:10:58.954058
9	97	2026-04-13 01:10:58.959034
12	97	2026-04-13 01:10:58.96313
86	97	2026-04-13 01:10:58.966892
5	99	2026-04-13 01:10:59.046137
17	99	2026-04-13 01:10:59.049526
9	99	2026-04-13 01:10:59.052745
88	99	2026-04-13 01:10:59.056305
3	100	2026-04-13 01:10:59.094057
\.


--
-- Data for Name: stories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.stories (id, media_url, expires_at, created_at, user_id) FROM stdin;
1	https://picsum.photos/seed/wikE2PYe/1080/1920	2026-04-13 16:37:03.508	2026-04-13 01:10:52.818673	4
2	https://picsum.photos/seed/1sxp9bmmB9/1080/1920	2026-04-13 20:16:17.632	2026-04-13 01:10:52.828363	5
3	https://picsum.photos/seed/OohaKRwQuo/1080/1920	2026-04-14 03:02:29.628	2026-04-13 01:10:52.840871	89
4	https://picsum.photos/seed/6M0VvCyKXg/1080/1920	2026-04-14 05:15:57.47	2026-04-13 01:10:52.848756	14
5	https://picsum.photos/seed/b5CkkPty/1080/1920	2026-04-13 17:46:35.189	2026-04-13 01:10:52.856502	90
6	https://picsum.photos/seed/moq0rC/1080/1920	2026-04-13 20:26:22.145	2026-04-13 01:10:52.868951	2
7	https://picsum.photos/seed/iLEQpKq9AF/1080/1920	2026-04-14 06:43:14.758	2026-04-13 01:10:52.898154	15
8	https://picsum.photos/seed/DvEvv/1080/1920	2026-04-13 11:08:06.165	2026-04-13 01:10:52.907754	17
9	https://picsum.photos/seed/pdLpQDCL/1080/1920	2026-04-13 09:55:01.77	2026-04-13 01:10:52.915472	18
10	https://picsum.photos/seed/U1jRf/1080/1920	2026-04-13 13:48:01.887	2026-04-13 01:10:52.922283	19
11	https://picsum.photos/seed/urKoRg8Xc/1080/1920	2026-04-13 16:49:37.01	2026-04-13 01:10:52.929705	20
12	https://picsum.photos/seed/BWi10ZFxDn/1080/1920	2026-04-13 14:11:59.574	2026-04-13 01:10:52.944393	23
13	https://picsum.photos/seed/L7yQbiaIM/1080/1920	2026-04-13 21:57:47.72	2026-04-13 01:10:52.953958	25
14	https://picsum.photos/seed/R7XROa/1080/1920	2026-04-13 18:26:38.222	2026-04-13 01:10:52.96298	26
15	https://picsum.photos/seed/MDhWGTk/1080/1920	2026-04-14 07:56:24.623	2026-04-13 01:10:52.981052	30
16	https://picsum.photos/seed/IrjOSqP/1080/1920	2026-04-14 07:39:18.678	2026-04-13 01:10:52.989884	31
17	https://picsum.photos/seed/38XjC/1080/1920	2026-04-14 00:57:50.846	2026-04-13 01:10:53.014771	36
18	https://picsum.photos/seed/1hJwcj9of/1080/1920	2026-04-14 07:18:43.685	2026-04-13 01:10:53.021225	37
19	https://picsum.photos/seed/A3aaQMlc6/1080/1920	2026-04-13 12:04:56.418	2026-04-13 01:10:53.064018	48
20	https://picsum.photos/seed/Sr3VrJH6/1080/1920	2026-04-14 03:11:53.831	2026-04-13 01:10:53.087514	54
21	https://picsum.photos/seed/vb0NP/1080/1920	2026-04-13 20:59:47.634	2026-04-13 01:10:53.095401	55
22	https://picsum.photos/seed/E9c3CK/1080/1920	2026-04-14 03:44:16.163	2026-04-13 01:10:53.113296	59
23	https://picsum.photos/seed/MUXaCYkJne/1080/1920	2026-04-13 09:05:44.528	2026-04-13 01:10:53.125658	62
24	https://picsum.photos/seed/60fRNN/1080/1920	2026-04-13 16:21:26.206	2026-04-13 01:10:53.135789	64
25	https://picsum.photos/seed/yFzG2skOX/1080/1920	2026-04-13 18:31:26.477	2026-04-13 01:10:53.153842	69
26	https://picsum.photos/seed/V15YJf/1080/1920	2026-04-13 11:21:16.61	2026-04-13 01:10:53.170537	73
27	https://picsum.photos/seed/6kCH9v2HZI/1080/1920	2026-04-14 00:51:31.993	2026-04-13 01:10:53.218132	86
28	https://picsum.photos/seed/UR9QHOf/1080/1920	2026-04-13 13:56:15.468	2026-04-13 01:10:53.224873	87
29	https://picsum.photos/seed/689Aa/1080/1920	2026-04-13 09:34:03.732	2026-04-13 01:10:53.233553	92
30	https://picsum.photos/seed/ZBvFqiWMR/1080/1920	2026-04-13 20:43:24.367	2026-04-13 01:10:53.240474	93
31	https://picsum.photos/seed/BZlVU/1080/1920	2026-04-13 20:46:43.727	2026-04-13 01:10:53.252469	96
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, user_name, email, role, avatar_url, bio, created_at) FROM stdin;
1	Wellington_Lynch35LhfHE	Phoebe_Jerde@gmail.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/599.jpg	interpretation fan	2026-04-13 01:10:52.497709
2	Lois11496O9	Roy.Feeney@hotmail.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/318.jpg	parent, coach	2026-04-13 01:10:52.670823
3	Osvaldo.Bartell47lpC8B	Ressie67@hotmail.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/526.jpg	load fan, developer 💸	2026-04-13 01:10:52.676136
4	Briana23Vjq4n	Isac86@gmail.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1165.jpg	kayak devotee	2026-04-13 01:10:52.676791
5	Corine48Ck1Cl	Eunice.Lehner32@yahoo.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/299.jpg	educator, filmmaker, entrepreneur #️⃣	2026-04-13 01:10:52.677238
6	Peter_Maggio65XdQAY	Joanie.Littel72@gmail.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/51.jpg	patriot	2026-04-13 01:10:52.677818
7	Jerrold.FadelHlxvU	Ed.Jones@gmail.com	user	https://avatars.githubusercontent.com/u/95554481	link supporter, coach	2026-04-13 01:10:52.681118
8	Raven_OConnell51ItP98	Johnathon.Ratke8@yahoo.com	user	https://avatars.githubusercontent.com/u/58868045	founder, student	2026-04-13 01:10:52.685438
9	Kacey8k0Ml8	Jayda85@gmail.com	user	https://avatars.githubusercontent.com/u/84124424	scientist, developer, educator 🍥	2026-04-13 01:10:52.686259
10	Chris37WUXUX	Kaden.Marquardt@hotmail.com	user	https://avatars.githubusercontent.com/u/33823158	singer, entrepreneur	2026-04-13 01:10:52.687155
11	Amani75gypEU	Era48@yahoo.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1095.jpg	friend, writer	2026-04-13 01:10:52.688701
12	Joe.Osinski8MLYba	Marcelle.Steuber@hotmail.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1067.jpg	filmmaker, geek, entrepreneur	2026-04-13 01:10:52.689074
13	Kaylee18NRJT	Isidro_Reichert1@gmail.com	user	https://avatars.githubusercontent.com/u/59710207	artist, film lover, dreamer 🇩🇰	2026-04-13 01:10:52.694352
14	Diana_West51xa2g0	Lina.Hayes@gmail.com	user	https://avatars.githubusercontent.com/u/34323162	dwelling enthusiast  🌮	2026-04-13 01:10:52.694851
15	Laney68ivCp8	Savannah_Lindgren-Hodkiewicz75@gmail.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/669.jpg	teacher, activist, inventor 🪥	2026-04-13 01:10:52.697445
16	Ellen_OConnellQF3MX	Rashawn.Flatley19@hotmail.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/537.jpg	foodie, photographer, scientist	2026-04-13 01:10:52.699206
17	Yasmeen_Aufderhar22hZ7r6	Fleta17@hotmail.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/292.jpg	spy enthusiast, founder	2026-04-13 01:10:52.700315
18	Herminio.Hettingern1zy4	Buddy47@yahoo.com	user	https://avatars.githubusercontent.com/u/61111402	voter advocate, musician	2026-04-13 01:10:52.70136
19	Jesse.Spencer21N2OmD	Angel71@gmail.com	user	https://avatars.githubusercontent.com/u/73038980	engineer, public speaker, dreamer 👻	2026-04-13 01:10:52.702514
20	Breanna_Wehner31Nb7Qa	Kellen_Crist98@yahoo.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/328.jpg	engineer, writer, musician	2026-04-13 01:10:52.703434
21	Monroe_Connelly6yC38	Jay_Sporer33@hotmail.com	user	https://avatars.githubusercontent.com/u/65439497	streamer, teacher, photographer ➰	2026-04-13 01:10:52.703918
22	Moises_Bailey18nu142	Ashton.Steuber47@yahoo.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/781.jpg	public speaker	2026-04-13 01:10:52.704684
23	Andreane_JerdeZkWZr	Ellen.Cruickshank@hotmail.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/564.jpg	cummerbund junkie	2026-04-13 01:10:52.706004
24	Addison.Dare69h9HTG	Madie90@hotmail.com	user	https://avatars.githubusercontent.com/u/77608591	dreamer, musician, model 🐴	2026-04-13 01:10:52.707247
25	Johnathan_WalkerNGana	Ibrahim_Streich72@hotmail.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/590.jpg	copyright junkie  🎇	2026-04-13 01:10:52.708171
26	Roberto.HudsonojjJp	Myrna_Smith@hotmail.com	user	https://avatars.githubusercontent.com/u/82638565	sponsorship enthusiast, artist 🎗️	2026-04-13 01:10:52.709111
27	Connie.Hoppe12idMhN	Penelope_Lakin@gmail.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1245.jpg	park junkie  👄	2026-04-13 01:10:52.710855
28	Alisa_Christiansen-HillsT9s7y	Nona.Keebler@hotmail.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/181.jpg	chronometer junkie	2026-04-13 01:10:52.710951
29	Chelsea.LarsonXcWXA	Vivienne35@gmail.com	user	https://avatars.githubusercontent.com/u/20479283	educator, educator	2026-04-13 01:10:52.711736
30	Georgianna_Mohr18Vm4gc	Burley.Conroy95@gmail.com	user	https://avatars.githubusercontent.com/u/22920310	head junkie  🆒	2026-04-13 01:10:52.713137
31	Makenzie.Rolfson88vMtED	Joany_Hamill@hotmail.com	user	https://avatars.githubusercontent.com/u/79434843	photographer	2026-04-13 01:10:52.713382
32	Briana_HicklelL5Zw	Abe38@hotmail.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1010.jpg	leader, developer, dreamer	2026-04-13 01:10:52.714429
33	Josue.Lynch67MEPfl	Shanon_Kirlin31@hotmail.com	user	https://avatars.githubusercontent.com/u/26699232	business owner, environmentalist, traveler 😮‍💨	2026-04-13 01:10:52.714626
34	Clement.Streichuvv42	Arthur.Jenkins50@yahoo.com	user	https://avatars.githubusercontent.com/u/79544787	fruit advocate  😸	2026-04-13 01:10:52.716522
35	Zackery_DAmore38ZFz5Z	Allene88@gmail.com	user	https://avatars.githubusercontent.com/u/21020441	tourist advocate	2026-04-13 01:10:52.718043
36	Wilton97mLV8z	Lavada.Crooks@hotmail.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/282.jpg	database lover  🙈	2026-04-13 01:10:52.718383
37	Euna_Hahn20VZfUb	Isai_Hayes@yahoo.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/331.jpg	model	2026-04-13 01:10:52.719512
38	Idella30n3J5j	Fannie_Kessler@hotmail.com	user	https://avatars.githubusercontent.com/u/78298227	blogger, streamer	2026-04-13 01:10:52.720901
39	Tomas.YundtAQQfZ	Wiley.Simonis88@gmail.com	user	https://avatars.githubusercontent.com/u/76871227	week fan, public speaker 🦑	2026-04-13 01:10:52.721202
40	Lourdes.Emard99Bs9IP	Casimir.Terry@hotmail.com	user	https://avatars.githubusercontent.com/u/79568468	tea enthusiast  🍞	2026-04-13 01:10:52.722738
41	Johnpaul.McClure742mFpX	Alena_Toy@yahoo.com	user	https://avatars.githubusercontent.com/u/94461562	shopper lover, gamer 👨🏿‍❤️‍💋‍👨🏽	2026-04-13 01:10:52.725531
42	Ceasar.StehrwAC0E	Harmon_Gislason59@yahoo.com	user	https://avatars.githubusercontent.com/u/92548044	shoreline fan, founder 🦛	2026-04-13 01:10:52.726549
43	Conner.Skiles42cWdEV	Thora_Will@yahoo.com	user	https://avatars.githubusercontent.com/u/10839973	musculature lover	2026-04-13 01:10:52.7275
44	Frida80FoP4D	Caleb6@yahoo.com	user	https://avatars.githubusercontent.com/u/8857766	entrepreneur	2026-04-13 01:10:52.727945
51	Shemar_RutherfordIhivk	Jeramie1@yahoo.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1224.jpg	priest fan  🧙🏾	2026-04-13 01:10:52.735584
58	Velva_Beatty38DMIYC	Amy.Welch@yahoo.com	user	https://avatars.githubusercontent.com/u/11256451	nerd, coach	2026-04-13 01:10:52.742351
65	Cornelius.KohleroZ8GQ	Isac_Metz@yahoo.com	user	https://avatars.githubusercontent.com/u/88971558	engineer	2026-04-13 01:10:52.750451
71	Barton.Tromp77PEunM	Karley1@hotmail.com	user	https://avatars.githubusercontent.com/u/49614742	writer, blogger, designer	2026-04-13 01:10:52.75931
78	Monte.DenesikpXkDg	Allan.Price@yahoo.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1136.jpg	survivor enthusiast	2026-04-13 01:10:52.767649
85	Ava.Schaden2264P95	Earline_Schulist@yahoo.com	user	https://avatars.githubusercontent.com/u/62303637	alluvium devotee  🍈	2026-04-13 01:10:52.777324
95	Anthony_Abshire11vD5RI	Annie_Stroman-Grady@yahoo.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/696.jpg	philosopher, grad	2026-04-13 01:10:52.787586
45	Amalia.WardffDSO	Madie_Greenholt@gmail.com	user	https://avatars.githubusercontent.com/u/21150968	writer enthusiast, musician 🗜️	2026-04-13 01:10:52.728789
53	Unique34Av6G8	Renee.Padberg71@gmail.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/106.jpg	cemetery supporter  ♋	2026-04-13 01:10:52.737112
60	Sylvan_JakubowskiZKZUq	Milan15@hotmail.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/902.jpg	name devotee, designer	2026-04-13 01:10:52.745403
67	Kurtis.OKeefe12vP3qJ	Krystal_OConnell@hotmail.com	user	https://avatars.githubusercontent.com/u/12707399	traveler	2026-04-13 01:10:52.753026
74	Cortez.Bahringer293nsPx	Johan_Murray70@hotmail.com	user	https://avatars.githubusercontent.com/u/92464783	counseling lover	2026-04-13 01:10:52.763027
81	Marlon_Mills1S3Eni	Sofia_Kunde-Hessel90@gmail.com	user	https://avatars.githubusercontent.com/u/61431914	nerd, photographer, engineer	2026-04-13 01:10:52.770501
88	Noemi44ckYTp	Bridget_Feil7@gmail.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1231.jpg	person, public speaker, philosopher	2026-04-13 01:10:52.779936
98	Emil932ncF9	Scot50@yahoo.com	user	https://avatars.githubusercontent.com/u/25576505	rust enthusiast, traveler	2026-04-13 01:10:52.791707
46	Zelda.Mertz67uMNfd	Dariana_Klocko@hotmail.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/23.jpg	grenade advocate, student	2026-04-13 01:10:52.729023
52	Leann94DoA7X	Glen_Murray@hotmail.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/233.jpg	friend	2026-04-13 01:10:52.736938
59	Kyra.LefflerGLMX1	Elva1@yahoo.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1142.jpg	patriot, educator, person	2026-04-13 01:10:52.743532
66	Nikita_KuvalisOSWqB	Belle65@yahoo.com	user	https://avatars.githubusercontent.com/u/23057634	crayon devotee	2026-04-13 01:10:52.751311
73	Peggie_BrekkeYChZ0	Jalyn_Kunde@hotmail.com	user	https://avatars.githubusercontent.com/u/55952295	worshiper fan, blogger	2026-04-13 01:10:52.760317
80	Keeley.Stanton32BFFv9	Velma79@hotmail.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/595.jpg	foodie, coach, writer 📬	2026-04-13 01:10:52.769235
87	Mitchel58sDuU5	Percival.Veum65@hotmail.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/832.jpg	artist, musician	2026-04-13 01:10:52.778996
97	Clay.HarrisL9XE2	Pansy11@gmail.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/448.jpg	disengagement devotee	2026-04-13 01:10:52.790662
47	Warren.GutkowskiueC4t	Audrey76@hotmail.com	user	https://avatars.githubusercontent.com/u/67257641	hat supporter, author	2026-04-13 01:10:52.730529
55	Marcel_Schillerd4Xg1	Mathias_Jacobi@gmail.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1172.jpg	handball fan, traveler 🍗	2026-04-13 01:10:52.738381
62	Sebastian50YeBrj	Waylon_Price@yahoo.com	user	https://avatars.githubusercontent.com/u/71543564	ford advocate, teacher 🍄	2026-04-13 01:10:52.747418
69	Armando_BoscocwUas	Valerie_Stracke55@hotmail.com	user	https://avatars.githubusercontent.com/u/64463364	student, parent	2026-04-13 01:10:52.75449
76	Angel_SimonismzoQv	Destini13@hotmail.com	user	https://avatars.githubusercontent.com/u/32988069	designer, student, artist 🇧🇯	2026-04-13 01:10:52.76512
83	Marco.Marks88qkxFu	Alessia_Cruickshank@yahoo.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/844.jpg	spite fan  🟩	2026-04-13 01:10:52.773308
93	Christophe_FritschEH21I	Foster.Conroy21@yahoo.com	user	https://avatars.githubusercontent.com/u/63380250	designer	2026-04-13 01:10:52.783954
48	Carli_MosciskiJvBCc	Stanford_Botsford49@gmail.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/455.jpg	singer, founder, designer	2026-04-13 01:10:52.731911
54	Fabiola_KassulkeT774I	Dahlia.Hermann17@yahoo.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/57.jpg	filmmaker, student	2026-04-13 01:10:52.738058
61	Domenica.Ernser6501P2J	Imogene.Kozey0@yahoo.com	user	https://avatars.githubusercontent.com/u/12257589	pelt junkie  ➡️	2026-04-13 01:10:52.746178
68	Haven_Jacobson41q61c8	Rose99@gmail.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/303.jpg	firewall supporter  🗑️	2026-04-13 01:10:52.753745
75	Abe.White44uBNm5	Emmy_Torp6@yahoo.com	user	https://avatars.githubusercontent.com/u/11166983	activist, nerd	2026-04-13 01:10:52.763736
82	Karley_Steuber-Labadie22P3f4R	Abagail.Nader65@hotmail.com	user	https://avatars.githubusercontent.com/u/44288367	breakthrough junkie  🗡️	2026-04-13 01:10:52.772305
92	Carmelo_LindgrenE7Fbh	Coralie_Lockman@hotmail.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/11.jpg	situation junkie	2026-04-13 01:10:52.782256
49	Juanita43Wwuf8	Kaleb_Trantow@hotmail.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/702.jpg	miracle supporter  🖍️	2026-04-13 01:10:52.732973
57	Wanda30J0qXF	Frederick_Bradtke@gmail.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1027.jpg	shoat fan	2026-04-13 01:10:52.741461
64	Earlene_DAmore384eYoe	Orville61@yahoo.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1025.jpg	preface fan, patriot 👨‍🦯	2026-04-13 01:10:52.75015
72	Karlee_Kassulke9Y260	Kamryn.West@hotmail.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/436.jpg	alligator junkie, educator 🖕🏿	2026-04-13 01:10:52.759678
79	Franco_Hettinger38kD34q	Mallory86@gmail.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1223.jpg	explanation lover, writer	2026-04-13 01:10:52.768993
86	Jerald_DAmore88MV98g	Robert_Steuber@hotmail.com	user	https://avatars.githubusercontent.com/u/39585250	founder, designer, creator	2026-04-13 01:10:52.778417
96	Arely_LittelUbJls	Marlon.Ortiz7@hotmail.com	user	https://avatars.githubusercontent.com/u/68752016	major-league junkie  💐	2026-04-13 01:10:52.788419
50	Candice_Smith1vra5	Emmitt.Satterfield-Reichert@yahoo.com	user	https://avatars.githubusercontent.com/u/12438658	debate supporter  🫒	2026-04-13 01:10:52.7338
56	Palma.Steuber43XNoMF	Kristofer37@gmail.com	user	https://avatars.githubusercontent.com/u/60852916	ikebana enthusiast, blogger 🧙🏾‍♀️	2026-04-13 01:10:52.741094
63	Alejandra474gisa	Conrad87@yahoo.com	user	https://avatars.githubusercontent.com/u/77989248	airforce lover, designer	2026-04-13 01:10:52.74956
70	Amber.Okuneva76gqdtu	Arvid38@gmail.com	user	https://avatars.githubusercontent.com/u/17475679	philosopher	2026-04-13 01:10:52.75842
77	Francisco.Huel45c8QpB	Laurel_Harvey-Moore@yahoo.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/121.jpg	shield supporter, model	2026-04-13 01:10:52.767009
84	Estell.Crooks453zfWG	Keven_Gusikowski@hotmail.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/26.jpg	encouragement enthusiast  💅	2026-04-13 01:10:52.774297
89	Frieda.Rodriguez51FFEWa	Elmore_Kris19@yahoo.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/206.jpg	impostor supporter, artist	2026-04-13 01:10:52.780977
90	Cara.KiehnVCs5N	Fabian39@hotmail.com	user	https://avatars.githubusercontent.com/u/85831797	hatchling lover, public speaker	2026-04-13 01:10:52.781238
91	Marty66YlUWf	Sheridan_Feest38@yahoo.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/873.jpg	public speaker, artist, photographer 🍕	2026-04-13 01:10:52.78154
94	Anabelle_Lowe39FSiM3	Jonatan_Effertz@gmail.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1049.jpg	western enthusiast, friend 🇮🇶	2026-04-13 01:10:52.785987
99	Noe_Adams55hy7iT	Abner.Boyer@yahoo.com	user	https://avatars.githubusercontent.com/u/93825655	significance advocate, scientist	2026-04-13 01:10:52.792272
100	Kevon.Olson75ZOxXc	Conrad32@hotmail.com	user	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/261.jpg	traveler	2026-04-13 01:10:52.793318
101	duck goose	duckygoose74@gmail.com	user	\N	\N	2026-04-22 08:13:09.971779
\.


--
-- Name: auth_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_id_seq', 101, true);


--
-- Name: comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.comments_id_seq', 221, true);


--
-- Name: hashtags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.hashtags_id_seq', 20, true);


--
-- Name: post_media_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.post_media_id_seq', 297, true);


--
-- Name: posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.posts_id_seq', 100, true);


--
-- Name: stories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.stories_id_seq', 31, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 101, true);


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

\unrestrict OUfAsRbpYIe0kskZxHM2M82b8ObmOR2yAyDgpmRgFQAdu3tegU3fcs2XvSb5olk

