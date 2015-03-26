--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: definitions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE definitions (
    id integer NOT NULL,
    word_id integer NOT NULL,
    "position" integer NOT NULL,
    part_of_speech character varying NOT NULL,
    body character varying NOT NULL,
    string_padding_1 character varying DEFAULT 'Lorem ipsum dolor sit amet'::character varying NOT NULL,
    string_padding_2 character varying DEFAULT 'consectetur adipisicing elit'::character varying NOT NULL,
    integer_padding_1 integer DEFAULT 0 NOT NULL,
    integer_padding_2 integer DEFAULT 0 NOT NULL,
    date_padding_1 date DEFAULT '2013-01-01'::date NOT NULL,
    date_padding_2 date DEFAULT '2013-01-01'::date NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: definitions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE definitions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: definitions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE definitions_id_seq OWNED BY definitions.id;


--
-- Name: quotes; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE quotes (
    id integer NOT NULL,
    word_id integer NOT NULL,
    body character varying NOT NULL,
    source character varying NOT NULL,
    string_padding_1 character varying DEFAULT 'Lorem ipsum dolor sit amet'::character varying NOT NULL,
    string_padding_2 character varying DEFAULT 'consectetur adipisicing elit'::character varying NOT NULL,
    integer_padding_1 integer DEFAULT 0 NOT NULL,
    integer_padding_2 integer DEFAULT 0 NOT NULL,
    date_padding_1 date DEFAULT '2013-01-01'::date NOT NULL,
    date_padding_2 date DEFAULT '2013-01-01'::date NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: quotes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE quotes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: quotes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE quotes_id_seq OWNED BY quotes.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: word_relationships; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE word_relationships (
    id integer NOT NULL,
    relationship character varying NOT NULL,
    source_id integer NOT NULL,
    destination_id integer NOT NULL
);


--
-- Name: word_relationships_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE word_relationships_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: word_relationships_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE word_relationships_id_seq OWNED BY word_relationships.id;


--
-- Name: words; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE words (
    id integer NOT NULL,
    text character varying NOT NULL,
    pronunciation character varying NOT NULL,
    string_padding_1 character varying DEFAULT 'Lorem ipsum dolor sit amet'::character varying NOT NULL,
    string_padding_2 character varying DEFAULT 'consectetur adipisicing elit'::character varying NOT NULL,
    integer_padding_1 integer DEFAULT 0 NOT NULL,
    integer_padding_2 integer DEFAULT 0 NOT NULL,
    date_padding_1 date DEFAULT '2013-01-01'::date NOT NULL,
    date_padding_2 date DEFAULT '2013-01-01'::date NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: words_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE words_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: words_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE words_id_seq OWNED BY words.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY definitions ALTER COLUMN id SET DEFAULT nextval('definitions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY quotes ALTER COLUMN id SET DEFAULT nextval('quotes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY word_relationships ALTER COLUMN id SET DEFAULT nextval('word_relationships_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY words ALTER COLUMN id SET DEFAULT nextval('words_id_seq'::regclass);


--
-- Name: definitions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY definitions
    ADD CONSTRAINT definitions_pkey PRIMARY KEY (id);


--
-- Name: quotes_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY quotes
    ADD CONSTRAINT quotes_pkey PRIMARY KEY (id);


--
-- Name: word_relationships_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY word_relationships
    ADD CONSTRAINT word_relationships_pkey PRIMARY KEY (id);


--
-- Name: words_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY words
    ADD CONSTRAINT words_pkey PRIMARY KEY (id);


--
-- Name: definitions_word_id_position_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX definitions_word_id_position_idx ON definitions USING btree (word_id, "position");


--
-- Name: quotes_word_id_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX quotes_word_id_idx ON quotes USING btree (word_id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: word_relationships_source_id_destination_id_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX word_relationships_source_id_destination_id_idx ON word_relationships USING btree (source_id, destination_id);


--
-- Name: words_text_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX words_text_idx ON words USING btree (text varchar_pattern_ops);


--
-- Name: definitions_word_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY definitions
    ADD CONSTRAINT definitions_word_id_fkey FOREIGN KEY (word_id) REFERENCES words(id);


--
-- Name: quotes_word_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY quotes
    ADD CONSTRAINT quotes_word_id_fkey FOREIGN KEY (word_id) REFERENCES words(id);


--
-- Name: word_relationships_destination_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY word_relationships
    ADD CONSTRAINT word_relationships_destination_id_fkey FOREIGN KEY (destination_id) REFERENCES words(id);


--
-- Name: word_relationships_source_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY word_relationships
    ADD CONSTRAINT word_relationships_source_id_fkey FOREIGN KEY (source_id) REFERENCES words(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20130114233033');

INSERT INTO schema_migrations (version) VALUES ('20130114233931');

INSERT INTO schema_migrations (version) VALUES ('20130114234642');

INSERT INTO schema_migrations (version) VALUES ('20130114235036');

