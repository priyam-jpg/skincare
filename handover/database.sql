--
-- PostgreSQL database dump
--

\restrict GVOVapZ0bh6YR2lGFyXNyUc99M8QNjfxq5bJGFEgFSvR6gfe3HXdw6KdBHZIId5

-- Dumped from database version 17.11
-- Dumped by pg_dump version 17.11

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

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

-- *not* creating schema, since initdb creates it


--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS '';


--
-- Name: _locales; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public._locales AS ENUM (
    'de',
    'fr',
    'it',
    'en'
);


--
-- Name: enum__products_v_published_locale; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.enum__products_v_published_locale AS ENUM (
    'de',
    'fr',
    'it',
    'en'
);


--
-- Name: enum__products_v_version_badge; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.enum__products_v_version_badge AS ENUM (
    'none',
    'new',
    'bestseller',
    'limited'
);


--
-- Name: enum__products_v_version_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.enum__products_v_version_status AS ENUM (
    'draft',
    'published'
);


--
-- Name: enum__variants_v_published_locale; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.enum__variants_v_published_locale AS ENUM (
    'de',
    'fr',
    'it',
    'en'
);


--
-- Name: enum__variants_v_version_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.enum__variants_v_version_status AS ENUM (
    'draft',
    'published'
);


--
-- Name: enum_addresses_country; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.enum_addresses_country AS ENUM (
    'CH',
    'LI'
);


--
-- Name: enum_carts_currency; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.enum_carts_currency AS ENUM (
    'CHF'
);


--
-- Name: enum_orders_currency; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.enum_orders_currency AS ENUM (
    'CHF'
);


--
-- Name: enum_orders_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.enum_orders_status AS ENUM (
    'processing',
    'completed',
    'cancelled',
    'refunded'
);


--
-- Name: enum_products_badge; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.enum_products_badge AS ENUM (
    'none',
    'new',
    'bestseller',
    'limited'
);


--
-- Name: enum_products_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.enum_products_status AS ENUM (
    'draft',
    'published'
);


--
-- Name: enum_transactions_currency; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.enum_transactions_currency AS ENUM (
    'CHF'
);


--
-- Name: enum_transactions_payment_method; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.enum_transactions_payment_method AS ENUM (
    'stripe'
);


--
-- Name: enum_transactions_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.enum_transactions_status AS ENUM (
    'pending',
    'processing',
    'succeeded',
    'failed',
    'cancelled',
    'expired',
    'refunded'
);


--
-- Name: enum_users_roles; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.enum_users_roles AS ENUM (
    'admin',
    'customer'
);


--
-- Name: enum_variants_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.enum_variants_status AS ENUM (
    'draft',
    'published'
);


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: _products_v; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public._products_v (
    id integer NOT NULL,
    parent_id integer,
    version_size character varying,
    version_inventory numeric DEFAULT 0,
    version_enable_variants boolean,
    version_price_in_c_h_f_enabled boolean,
    version_price_in_c_h_f numeric,
    version_compare_at_price_in_c_h_f numeric,
    version_low_stock_threshold numeric DEFAULT 5,
    version_badge public.enum__products_v_version_badge DEFAULT 'none'::public.enum__products_v_version_badge,
    version_generate_slug boolean DEFAULT true,
    version_slug character varying,
    version_updated_at timestamp(3) with time zone,
    version_created_at timestamp(3) with time zone,
    version_deleted_at timestamp(3) with time zone,
    version__status public.enum__products_v_version_status DEFAULT 'draft'::public.enum__products_v_version_status,
    created_at timestamp(3) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(3) with time zone DEFAULT now() NOT NULL,
    latest boolean,
    autosave boolean,
    snapshot boolean,
    published_locale public.enum__products_v_published_locale
);


--
-- Name: _products_v_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public._products_v_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: _products_v_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public._products_v_id_seq OWNED BY public._products_v.id;


--
-- Name: _products_v_locales; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public._products_v_locales (
    version_title character varying,
    version_tagline character varying,
    version_description character varying,
    version_how_to_use character varying,
    version_ingredients character varying,
    id integer NOT NULL,
    _locale public._locales NOT NULL,
    _parent_id integer NOT NULL
);


--
-- Name: _products_v_locales_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public._products_v_locales_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: _products_v_locales_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public._products_v_locales_id_seq OWNED BY public._products_v_locales.id;


--
-- Name: _products_v_rels; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public._products_v_rels (
    id integer NOT NULL,
    "order" integer,
    parent_id integer NOT NULL,
    path character varying NOT NULL,
    variant_types_id integer,
    categories_id integer,
    products_id integer
);


--
-- Name: _products_v_rels_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public._products_v_rels_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: _products_v_rels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public._products_v_rels_id_seq OWNED BY public._products_v_rels.id;


--
-- Name: _products_v_version_gallery; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public._products_v_version_gallery (
    _order integer NOT NULL,
    _parent_id integer NOT NULL,
    id integer NOT NULL,
    image_id integer,
    _uuid character varying
);


--
-- Name: _products_v_version_gallery_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public._products_v_version_gallery_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: _products_v_version_gallery_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public._products_v_version_gallery_id_seq OWNED BY public._products_v_version_gallery.id;


--
-- Name: _variants_v; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public._variants_v (
    id integer NOT NULL,
    parent_id integer,
    version_title character varying,
    version_product_id integer,
    version_inventory numeric DEFAULT 0,
    version_price_in_c_h_f_enabled boolean,
    version_price_in_c_h_f numeric,
    version_updated_at timestamp(3) with time zone,
    version_created_at timestamp(3) with time zone,
    version_deleted_at timestamp(3) with time zone,
    version__status public.enum__variants_v_version_status DEFAULT 'draft'::public.enum__variants_v_version_status,
    created_at timestamp(3) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(3) with time zone DEFAULT now() NOT NULL,
    latest boolean,
    autosave boolean,
    snapshot boolean,
    published_locale public.enum__variants_v_published_locale
);


--
-- Name: _variants_v_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public._variants_v_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: _variants_v_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public._variants_v_id_seq OWNED BY public._variants_v.id;


--
-- Name: _variants_v_rels; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public._variants_v_rels (
    id integer NOT NULL,
    "order" integer,
    parent_id integer NOT NULL,
    path character varying NOT NULL,
    variant_options_id integer
);


--
-- Name: _variants_v_rels_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public._variants_v_rels_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: _variants_v_rels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public._variants_v_rels_id_seq OWNED BY public._variants_v_rels.id;


--
-- Name: addresses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.addresses (
    id integer NOT NULL,
    customer_id integer,
    title character varying,
    first_name character varying,
    last_name character varying,
    company character varying,
    address_line1 character varying,
    address_line2 character varying,
    city character varying,
    state character varying,
    postal_code character varying,
    country public.enum_addresses_country NOT NULL,
    phone character varying,
    updated_at timestamp(3) with time zone DEFAULT now() NOT NULL,
    created_at timestamp(3) with time zone DEFAULT now() NOT NULL
);


--
-- Name: addresses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.addresses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.addresses_id_seq OWNED BY public.addresses.id;


--
-- Name: carts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.carts (
    id integer NOT NULL,
    secret character varying,
    customer_id integer,
    purchased_at timestamp(3) with time zone,
    subtotal numeric,
    currency public.enum_carts_currency DEFAULT 'CHF'::public.enum_carts_currency,
    updated_at timestamp(3) with time zone DEFAULT now() NOT NULL,
    created_at timestamp(3) with time zone DEFAULT now() NOT NULL
);


--
-- Name: carts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.carts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: carts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.carts_id_seq OWNED BY public.carts.id;


--
-- Name: carts_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.carts_items (
    _order integer NOT NULL,
    _parent_id integer NOT NULL,
    id character varying NOT NULL,
    product_id integer,
    variant_id integer,
    quantity numeric DEFAULT 1 NOT NULL
);


--
-- Name: categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.categories (
    id integer NOT NULL,
    generate_slug boolean DEFAULT true,
    slug character varying NOT NULL,
    updated_at timestamp(3) with time zone DEFAULT now() NOT NULL,
    created_at timestamp(3) with time zone DEFAULT now() NOT NULL
);


--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: categories_locales; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.categories_locales (
    title character varying NOT NULL,
    id integer NOT NULL,
    _locale public._locales NOT NULL,
    _parent_id integer NOT NULL
);


--
-- Name: categories_locales_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.categories_locales_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: categories_locales_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.categories_locales_id_seq OWNED BY public.categories_locales.id;


--
-- Name: home; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.home (
    id integer NOT NULL,
    updated_at timestamp(3) with time zone,
    created_at timestamp(3) with time zone
);


--
-- Name: home_announcements; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.home_announcements (
    _order integer NOT NULL,
    _parent_id integer NOT NULL,
    id character varying NOT NULL
);


--
-- Name: home_announcements_locales; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.home_announcements_locales (
    text character varying NOT NULL,
    id integer NOT NULL,
    _locale public._locales NOT NULL,
    _parent_id character varying NOT NULL
);


--
-- Name: home_announcements_locales_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.home_announcements_locales_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: home_announcements_locales_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.home_announcements_locales_id_seq OWNED BY public.home_announcements_locales.id;


--
-- Name: home_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.home_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: home_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.home_id_seq OWNED BY public.home.id;


--
-- Name: home_locales; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.home_locales (
    hero_title character varying DEFAULT 'Skincare that fits every skin.'::character varying,
    hero_lede character varying DEFAULT 'Korean-formulated routines, made simple and gentle on every skin.'::character varying,
    id integer NOT NULL,
    _locale public._locales NOT NULL,
    _parent_id integer NOT NULL
);


--
-- Name: home_locales_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.home_locales_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: home_locales_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.home_locales_id_seq OWNED BY public.home_locales.id;


--
-- Name: home_rels; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.home_rels (
    id integer NOT NULL,
    "order" integer,
    parent_id integer NOT NULL,
    path character varying NOT NULL,
    products_id integer
);


--
-- Name: home_rels_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.home_rels_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: home_rels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.home_rels_id_seq OWNED BY public.home_rels.id;


--
-- Name: home_routine; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.home_routine (
    _order integer NOT NULL,
    _parent_id integer NOT NULL,
    id character varying NOT NULL,
    korean character varying,
    product_id integer
);


--
-- Name: home_routine_locales; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.home_routine_locales (
    title character varying NOT NULL,
    note character varying,
    id integer NOT NULL,
    _locale public._locales NOT NULL,
    _parent_id character varying NOT NULL
);


--
-- Name: home_routine_locales_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.home_routine_locales_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: home_routine_locales_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.home_routine_locales_id_seq OWNED BY public.home_routine_locales.id;


--
-- Name: media; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.media (
    id integer NOT NULL,
    alt character varying NOT NULL,
    updated_at timestamp(3) with time zone DEFAULT now() NOT NULL,
    created_at timestamp(3) with time zone DEFAULT now() NOT NULL,
    url character varying,
    thumbnail_u_r_l character varying,
    filename character varying,
    mime_type character varying,
    filesize numeric,
    width numeric,
    height numeric,
    focal_x numeric,
    focal_y numeric
);


--
-- Name: media_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.media_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: media_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.media_id_seq OWNED BY public.media.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.orders (
    id integer NOT NULL,
    shipping_address_title character varying,
    shipping_address_first_name character varying,
    shipping_address_last_name character varying,
    shipping_address_company character varying,
    shipping_address_address_line1 character varying,
    shipping_address_address_line2 character varying,
    shipping_address_city character varying,
    shipping_address_state character varying,
    shipping_address_postal_code character varying,
    shipping_address_country character varying,
    shipping_address_phone character varying,
    customer_id integer,
    customer_email character varying,
    status public.enum_orders_status DEFAULT 'processing'::public.enum_orders_status,
    amount numeric,
    currency public.enum_orders_currency DEFAULT 'CHF'::public.enum_orders_currency,
    access_token character varying,
    updated_at timestamp(3) with time zone DEFAULT now() NOT NULL,
    created_at timestamp(3) with time zone DEFAULT now() NOT NULL
);


--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- Name: orders_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.orders_items (
    _order integer NOT NULL,
    _parent_id integer NOT NULL,
    id character varying NOT NULL,
    product_id integer,
    variant_id integer,
    quantity numeric DEFAULT 1 NOT NULL
);


--
-- Name: orders_rels; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.orders_rels (
    id integer NOT NULL,
    "order" integer,
    parent_id integer NOT NULL,
    path character varying NOT NULL,
    transactions_id integer
);


--
-- Name: orders_rels_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.orders_rels_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: orders_rels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.orders_rels_id_seq OWNED BY public.orders_rels.id;


--
-- Name: payload_kv; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payload_kv (
    id integer NOT NULL,
    key character varying NOT NULL,
    data jsonb NOT NULL
);


--
-- Name: payload_kv_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.payload_kv_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: payload_kv_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.payload_kv_id_seq OWNED BY public.payload_kv.id;


--
-- Name: payload_locked_documents; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payload_locked_documents (
    id integer NOT NULL,
    global_slug character varying,
    updated_at timestamp(3) with time zone DEFAULT now() NOT NULL,
    created_at timestamp(3) with time zone DEFAULT now() NOT NULL
);


--
-- Name: payload_locked_documents_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.payload_locked_documents_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: payload_locked_documents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.payload_locked_documents_id_seq OWNED BY public.payload_locked_documents.id;


--
-- Name: payload_locked_documents_rels; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payload_locked_documents_rels (
    id integer NOT NULL,
    "order" integer,
    parent_id integer NOT NULL,
    path character varying NOT NULL,
    users_id integer,
    categories_id integer,
    media_id integer,
    addresses_id integer,
    variants_id integer,
    variant_types_id integer,
    variant_options_id integer,
    products_id integer,
    carts_id integer,
    orders_id integer,
    transactions_id integer
);


--
-- Name: payload_locked_documents_rels_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.payload_locked_documents_rels_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: payload_locked_documents_rels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.payload_locked_documents_rels_id_seq OWNED BY public.payload_locked_documents_rels.id;


--
-- Name: payload_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payload_migrations (
    id integer NOT NULL,
    name character varying,
    batch numeric,
    updated_at timestamp(3) with time zone DEFAULT now() NOT NULL,
    created_at timestamp(3) with time zone DEFAULT now() NOT NULL
);


--
-- Name: payload_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.payload_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: payload_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.payload_migrations_id_seq OWNED BY public.payload_migrations.id;


--
-- Name: payload_preferences; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payload_preferences (
    id integer NOT NULL,
    key character varying,
    value jsonb,
    updated_at timestamp(3) with time zone DEFAULT now() NOT NULL,
    created_at timestamp(3) with time zone DEFAULT now() NOT NULL
);


--
-- Name: payload_preferences_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.payload_preferences_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: payload_preferences_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.payload_preferences_id_seq OWNED BY public.payload_preferences.id;


--
-- Name: payload_preferences_rels; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payload_preferences_rels (
    id integer NOT NULL,
    "order" integer,
    parent_id integer NOT NULL,
    path character varying NOT NULL,
    users_id integer
);


--
-- Name: payload_preferences_rels_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.payload_preferences_rels_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: payload_preferences_rels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.payload_preferences_rels_id_seq OWNED BY public.payload_preferences_rels.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.products (
    id integer NOT NULL,
    size character varying,
    inventory numeric DEFAULT 0,
    enable_variants boolean,
    price_in_c_h_f_enabled boolean,
    price_in_c_h_f numeric,
    compare_at_price_in_c_h_f numeric,
    low_stock_threshold numeric DEFAULT 5,
    badge public.enum_products_badge DEFAULT 'none'::public.enum_products_badge,
    generate_slug boolean DEFAULT true,
    slug character varying,
    updated_at timestamp(3) with time zone DEFAULT now() NOT NULL,
    created_at timestamp(3) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(3) with time zone,
    _status public.enum_products_status DEFAULT 'draft'::public.enum_products_status
);


--
-- Name: products_gallery; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.products_gallery (
    _order integer NOT NULL,
    _parent_id integer NOT NULL,
    id character varying NOT NULL,
    image_id integer
);


--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: products_locales; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.products_locales (
    title character varying,
    tagline character varying,
    description character varying,
    how_to_use character varying,
    ingredients character varying,
    id integer NOT NULL,
    _locale public._locales NOT NULL,
    _parent_id integer NOT NULL
);


--
-- Name: products_locales_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.products_locales_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: products_locales_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.products_locales_id_seq OWNED BY public.products_locales.id;


--
-- Name: products_rels; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.products_rels (
    id integer NOT NULL,
    "order" integer,
    parent_id integer NOT NULL,
    path character varying NOT NULL,
    variant_types_id integer,
    categories_id integer,
    products_id integer
);


--
-- Name: products_rels_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.products_rels_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: products_rels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.products_rels_id_seq OWNED BY public.products_rels.id;


--
-- Name: transactions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.transactions (
    id integer NOT NULL,
    payment_method public.enum_transactions_payment_method,
    stripe_customer_i_d character varying,
    stripe_payment_intent_i_d character varying,
    billing_address_title character varying,
    billing_address_first_name character varying,
    billing_address_last_name character varying,
    billing_address_company character varying,
    billing_address_address_line1 character varying,
    billing_address_address_line2 character varying,
    billing_address_city character varying,
    billing_address_state character varying,
    billing_address_postal_code character varying,
    billing_address_country character varying,
    billing_address_phone character varying,
    status public.enum_transactions_status DEFAULT 'pending'::public.enum_transactions_status NOT NULL,
    customer_id integer,
    customer_email character varying,
    order_id integer,
    cart_id integer,
    amount numeric,
    currency public.enum_transactions_currency DEFAULT 'CHF'::public.enum_transactions_currency,
    updated_at timestamp(3) with time zone DEFAULT now() NOT NULL,
    created_at timestamp(3) with time zone DEFAULT now() NOT NULL
);


--
-- Name: transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.transactions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.transactions_id_seq OWNED BY public.transactions.id;


--
-- Name: transactions_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.transactions_items (
    _order integer NOT NULL,
    _parent_id integer NOT NULL,
    id character varying NOT NULL,
    product_id integer,
    variant_id integer,
    quantity numeric DEFAULT 1 NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying,
    updated_at timestamp(3) with time zone DEFAULT now() NOT NULL,
    created_at timestamp(3) with time zone DEFAULT now() NOT NULL,
    email character varying NOT NULL,
    reset_password_token character varying,
    reset_password_expiration timestamp(3) with time zone,
    salt character varying,
    hash character varying,
    reset_password_requested_at timestamp(3) with time zone,
    login_attempts numeric DEFAULT 0,
    lock_until timestamp(3) with time zone
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: users_roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users_roles (
    "order" integer NOT NULL,
    parent_id integer NOT NULL,
    value public.enum_users_roles,
    id integer NOT NULL
);


--
-- Name: users_roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_roles_id_seq OWNED BY public.users_roles.id;


--
-- Name: users_sessions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users_sessions (
    _order integer NOT NULL,
    _parent_id integer NOT NULL,
    id character varying NOT NULL,
    created_at timestamp(3) with time zone,
    expires_at timestamp(3) with time zone NOT NULL
);


--
-- Name: variant_options; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.variant_options (
    id integer NOT NULL,
    _variantoptions_options_order character varying,
    variant_type_id integer NOT NULL,
    label character varying NOT NULL,
    value character varying NOT NULL,
    updated_at timestamp(3) with time zone DEFAULT now() NOT NULL,
    created_at timestamp(3) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(3) with time zone
);


--
-- Name: variant_options_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.variant_options_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: variant_options_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.variant_options_id_seq OWNED BY public.variant_options.id;


--
-- Name: variant_types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.variant_types (
    id integer NOT NULL,
    label character varying NOT NULL,
    name character varying NOT NULL,
    updated_at timestamp(3) with time zone DEFAULT now() NOT NULL,
    created_at timestamp(3) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(3) with time zone
);


--
-- Name: variant_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.variant_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: variant_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.variant_types_id_seq OWNED BY public.variant_types.id;


--
-- Name: variants; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.variants (
    id integer NOT NULL,
    title character varying,
    product_id integer,
    inventory numeric DEFAULT 0,
    price_in_c_h_f_enabled boolean,
    price_in_c_h_f numeric,
    updated_at timestamp(3) with time zone DEFAULT now() NOT NULL,
    created_at timestamp(3) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(3) with time zone,
    _status public.enum_variants_status DEFAULT 'draft'::public.enum_variants_status
);


--
-- Name: variants_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.variants_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: variants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.variants_id_seq OWNED BY public.variants.id;


--
-- Name: variants_rels; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.variants_rels (
    id integer NOT NULL,
    "order" integer,
    parent_id integer NOT NULL,
    path character varying NOT NULL,
    variant_options_id integer
);


--
-- Name: variants_rels_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.variants_rels_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: variants_rels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.variants_rels_id_seq OWNED BY public.variants_rels.id;


--
-- Name: _products_v id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._products_v ALTER COLUMN id SET DEFAULT nextval('public._products_v_id_seq'::regclass);


--
-- Name: _products_v_locales id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._products_v_locales ALTER COLUMN id SET DEFAULT nextval('public._products_v_locales_id_seq'::regclass);


--
-- Name: _products_v_rels id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._products_v_rels ALTER COLUMN id SET DEFAULT nextval('public._products_v_rels_id_seq'::regclass);


--
-- Name: _products_v_version_gallery id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._products_v_version_gallery ALTER COLUMN id SET DEFAULT nextval('public._products_v_version_gallery_id_seq'::regclass);


--
-- Name: _variants_v id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._variants_v ALTER COLUMN id SET DEFAULT nextval('public._variants_v_id_seq'::regclass);


--
-- Name: _variants_v_rels id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._variants_v_rels ALTER COLUMN id SET DEFAULT nextval('public._variants_v_rels_id_seq'::regclass);


--
-- Name: addresses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.addresses ALTER COLUMN id SET DEFAULT nextval('public.addresses_id_seq'::regclass);


--
-- Name: carts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.carts ALTER COLUMN id SET DEFAULT nextval('public.carts_id_seq'::regclass);


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: categories_locales id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories_locales ALTER COLUMN id SET DEFAULT nextval('public.categories_locales_id_seq'::regclass);


--
-- Name: home id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.home ALTER COLUMN id SET DEFAULT nextval('public.home_id_seq'::regclass);


--
-- Name: home_announcements_locales id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.home_announcements_locales ALTER COLUMN id SET DEFAULT nextval('public.home_announcements_locales_id_seq'::regclass);


--
-- Name: home_locales id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.home_locales ALTER COLUMN id SET DEFAULT nextval('public.home_locales_id_seq'::regclass);


--
-- Name: home_rels id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.home_rels ALTER COLUMN id SET DEFAULT nextval('public.home_rels_id_seq'::regclass);


--
-- Name: home_routine_locales id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.home_routine_locales ALTER COLUMN id SET DEFAULT nextval('public.home_routine_locales_id_seq'::regclass);


--
-- Name: media id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.media ALTER COLUMN id SET DEFAULT nextval('public.media_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Name: orders_rels id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders_rels ALTER COLUMN id SET DEFAULT nextval('public.orders_rels_id_seq'::regclass);


--
-- Name: payload_kv id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payload_kv ALTER COLUMN id SET DEFAULT nextval('public.payload_kv_id_seq'::regclass);


--
-- Name: payload_locked_documents id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payload_locked_documents ALTER COLUMN id SET DEFAULT nextval('public.payload_locked_documents_id_seq'::regclass);


--
-- Name: payload_locked_documents_rels id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payload_locked_documents_rels ALTER COLUMN id SET DEFAULT nextval('public.payload_locked_documents_rels_id_seq'::regclass);


--
-- Name: payload_migrations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payload_migrations ALTER COLUMN id SET DEFAULT nextval('public.payload_migrations_id_seq'::regclass);


--
-- Name: payload_preferences id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payload_preferences ALTER COLUMN id SET DEFAULT nextval('public.payload_preferences_id_seq'::regclass);


--
-- Name: payload_preferences_rels id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payload_preferences_rels ALTER COLUMN id SET DEFAULT nextval('public.payload_preferences_rels_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: products_locales id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products_locales ALTER COLUMN id SET DEFAULT nextval('public.products_locales_id_seq'::regclass);


--
-- Name: products_rels id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products_rels ALTER COLUMN id SET DEFAULT nextval('public.products_rels_id_seq'::regclass);


--
-- Name: transactions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.transactions ALTER COLUMN id SET DEFAULT nextval('public.transactions_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: users_roles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users_roles ALTER COLUMN id SET DEFAULT nextval('public.users_roles_id_seq'::regclass);


--
-- Name: variant_options id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variant_options ALTER COLUMN id SET DEFAULT nextval('public.variant_options_id_seq'::regclass);


--
-- Name: variant_types id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variant_types ALTER COLUMN id SET DEFAULT nextval('public.variant_types_id_seq'::regclass);


--
-- Name: variants id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variants ALTER COLUMN id SET DEFAULT nextval('public.variants_id_seq'::regclass);


--
-- Name: variants_rels id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variants_rels ALTER COLUMN id SET DEFAULT nextval('public.variants_rels_id_seq'::regclass);


--
-- Data for Name: _products_v; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public._products_v (id, parent_id, version_size, version_inventory, version_enable_variants, version_price_in_c_h_f_enabled, version_price_in_c_h_f, version_compare_at_price_in_c_h_f, version_low_stock_threshold, version_badge, version_generate_slug, version_slug, version_updated_at, version_created_at, version_deleted_at, version__status, created_at, updated_at, latest, autosave, snapshot, published_locale) FROM stdin;
312	43	250 ml	20	\N	t	2490	4900	5	bestseller	f	anua-heartleaf-77-soothing-toner	2026-11-13 17:23:40.612+05:30	2026-11-13 10:13:50.965+05:30	\N	published	2026-11-13 17:23:40.689+05:30	2026-11-13 17:23:40.689+05:30	t	f	\N	\N
132	30	\N	20	\N	t	1990	\N	5	none	f	illiyoon-ceramide-ato-6-0-top-to-toe-wash	2026-11-13 10:13:32.129+05:30	2026-11-13 10:13:32.129+05:30	\N	published	2026-11-13 10:13:32.135+05:30	2026-11-13 10:13:32.135+05:30	f	f	\N	\N
133	30	\N	20	\N	t	1990	\N	5	none	f	illiyoon-ceramide-ato-6-0-top-to-toe-wash	2026-11-13 10:13:32.164+05:30	2026-11-13 10:13:32.129+05:30	\N	published	2026-11-13 10:13:32.194+05:30	2026-11-13 10:13:32.194+05:30	f	f	\N	\N
136	31	75 ml	20	\N	t	1690	\N	5	none	f	illiyoon-ceramide-ato-concentrate-cream	2026-11-13 10:13:33.374+05:30	2026-11-13 10:13:33.374+05:30	\N	published	2026-11-13 10:13:33.38+05:30	2026-11-13 10:13:33.38+05:30	f	f	\N	\N
137	31	75 ml	20	\N	t	1690	\N	5	none	f	illiyoon-ceramide-ato-concentrate-cream	2026-11-13 10:13:33.4+05:30	2026-11-13 10:13:33.374+05:30	\N	published	2026-11-13 10:13:33.411+05:30	2026-11-13 10:13:33.411+05:30	f	f	\N	\N
140	32	\N	20	\N	t	2990	\N	5	bestseller	f	dr-althea-345-relief-cream	2026-11-13 10:13:35.673+05:30	2026-11-13 10:13:35.672+05:30	\N	published	2026-11-13 10:13:35.683+05:30	2026-11-13 10:13:35.683+05:30	f	f	\N	\N
141	32	\N	20	\N	t	2990	\N	5	bestseller	f	dr-althea-345-relief-cream	2026-11-13 10:13:35.718+05:30	2026-11-13 10:13:35.672+05:30	\N	published	2026-11-13 10:13:35.726+05:30	2026-11-13 10:13:35.726+05:30	f	f	\N	\N
144	33	100 ml	20	\N	t	2390	\N	5	none	f	purito-oat-in-calming-gel-cream	2026-11-13 10:13:37.092+05:30	2026-11-13 10:13:37.092+05:30	\N	published	2026-11-13 10:13:37.097+05:30	2026-11-13 10:13:37.097+05:30	f	f	\N	\N
145	33	100 ml	20	\N	t	2390	\N	5	none	f	purito-oat-in-calming-gel-cream	2026-11-13 10:13:37.123+05:30	2026-11-13 10:13:37.092+05:30	\N	published	2026-11-13 10:13:37.13+05:30	2026-11-13 10:13:37.13+05:30	f	f	\N	\N
148	34	100 g	20	\N	t	2490	\N	5	none	f	cosrx-advanced-snail-92-all-in-one-cream	2026-11-13 10:13:38.42+05:30	2026-11-13 10:13:38.42+05:30	\N	published	2026-11-13 10:13:38.426+05:30	2026-11-13 10:13:38.426+05:30	f	f	\N	\N
149	34	100 g	20	\N	t	2490	\N	5	none	f	cosrx-advanced-snail-92-all-in-one-cream	2026-11-13 10:13:38.453+05:30	2026-11-13 10:13:38.42+05:30	\N	published	2026-11-13 10:13:38.461+05:30	2026-11-13 10:13:38.461+05:30	f	f	\N	\N
152	35	60 g	20	\N	t	2490	\N	5	none	f	some-by-mi-snail-truecica-miracle-repair-cream	2026-11-13 10:13:39.557+05:30	2026-11-13 10:13:39.556+05:30	\N	published	2026-11-13 10:13:39.563+05:30	2026-11-13 10:13:39.563+05:30	f	f	\N	\N
153	35	60 g	20	\N	t	2490	\N	5	none	f	some-by-mi-snail-truecica-miracle-repair-cream	2026-11-13 10:13:39.594+05:30	2026-11-13 10:13:39.556+05:30	\N	published	2026-11-13 10:13:39.601+05:30	2026-11-13 10:13:39.601+05:30	f	f	\N	\N
157	36	150 ml	20	\N	t	1890	\N	5	none	f	round-lab-mugwort-cleansing-foam	2026-11-13 10:13:40.649+05:30	2026-11-13 10:13:40.636+05:30	\N	published	2026-11-13 10:13:40.659+05:30	2026-11-13 10:13:40.659+05:30	f	f	\N	\N
156	36	150 ml	20	\N	t	1890	\N	5	none	f	round-lab-mugwort-cleansing-foam	2026-11-13 10:13:40.636+05:30	2026-11-13 10:13:40.636+05:30	\N	published	2026-11-13 10:13:40.64+05:30	2026-11-13 10:13:40.64+05:30	f	f	\N	\N
160	37	150 ml	20	\N	t	1390	\N	5	bestseller	f	cosrx-low-ph-good-morning-gel-cleanser	2026-11-13 10:13:42.112+05:30	2026-11-13 10:13:42.112+05:30	\N	published	2026-11-13 10:13:42.147+05:30	2026-11-13 10:13:42.147+05:30	f	f	\N	\N
161	37	150 ml	20	\N	t	1390	\N	5	bestseller	f	cosrx-low-ph-good-morning-gel-cleanser	2026-11-13 10:13:42.175+05:30	2026-11-13 10:13:42.112+05:30	\N	published	2026-11-13 10:13:42.183+05:30	2026-11-13 10:13:42.183+05:30	f	f	\N	\N
166	38	120 ml	20	\N	t	2290	\N	5	none	f	lagom-cellup-micro-foam-cleanser	2026-11-13 10:13:43.766+05:30	2026-11-13 10:13:43.693+05:30	\N	published	2026-11-13 10:13:43.774+05:30	2026-11-13 10:13:43.774+05:30	f	f	\N	\N
164	38	120 ml	20	\N	t	2290	\N	5	none	f	lagom-cellup-micro-foam-cleanser	2026-11-13 10:13:43.693+05:30	2026-11-13 10:13:43.693+05:30	\N	published	2026-11-13 10:13:43.699+05:30	2026-11-13 10:13:43.699+05:30	f	f	\N	\N
168	39	\N	20	\N	t	1990	\N	5	none	f	b-plain-mung-bean-cleansing-foam	2026-11-13 10:13:45.314+05:30	2026-11-13 10:13:45.314+05:30	\N	published	2026-11-13 10:13:45.326+05:30	2026-11-13 10:13:45.326+05:30	f	f	\N	\N
169	39	\N	20	\N	t	1990	\N	5	none	f	b-plain-mung-bean-cleansing-foam	2026-11-13 10:13:45.343+05:30	2026-11-13 10:13:45.314+05:30	\N	published	2026-11-13 10:13:45.359+05:30	2026-11-13 10:13:45.359+05:30	f	f	\N	\N
173	40	30 ml	20	\N	t	1290	\N	5	new	f	jipu-cleansing-balm	2026-11-13 10:13:46.807+05:30	2026-11-13 10:13:46.754+05:30	\N	published	2026-11-13 10:13:46.816+05:30	2026-11-13 10:13:46.816+05:30	f	f	\N	\N
175	40	30 ml	20	\N	t	1290	\N	5	new	f	jipu-cleansing-balm	2026-11-13 10:13:46.879+05:30	2026-11-13 10:13:46.754+05:30	\N	published	2026-11-13 10:13:46.888+05:30	2026-11-13 10:13:46.888+05:30	f	f	\N	\N
128	29	350 ml	20	\N	t	2290	\N	5	none	f	illiyoon-ceramide-ato-lotion	2026-11-13 10:13:30.847+05:30	2026-11-13 10:13:30.847+05:30	\N	published	2026-11-13 10:13:30.87+05:30	2026-11-13 10:13:30.87+05:30	f	f	\N	\N
129	29	350 ml	20	\N	t	2290	\N	5	none	f	illiyoon-ceramide-ato-lotion	2026-11-13 10:13:30.899+05:30	2026-11-13 10:13:30.847+05:30	\N	published	2026-11-13 10:13:30.904+05:30	2026-11-13 10:13:30.904+05:30	f	f	\N	\N
131	29	350 ml	20	\N	t	2290	\N	5	none	f	illiyoon-ceramide-ato-lotion	2026-11-13 10:13:30.952+05:30	2026-11-13 10:13:30.847+05:30	\N	published	2026-11-13 10:13:30.957+05:30	2026-11-13 10:13:30.957+05:30	f	f	\N	\N
135	30	\N	20	\N	t	1990	\N	5	none	f	illiyoon-ceramide-ato-6-0-top-to-toe-wash	2026-11-13 10:13:32.235+05:30	2026-11-13 10:13:32.129+05:30	\N	published	2026-11-13 10:13:32.242+05:30	2026-11-13 10:13:32.242+05:30	f	f	\N	\N
134	30	\N	20	\N	t	1990	\N	5	none	f	illiyoon-ceramide-ato-6-0-top-to-toe-wash	2026-11-13 10:13:32.214+05:30	2026-11-13 10:13:32.129+05:30	\N	published	2026-11-13 10:13:32.221+05:30	2026-11-13 10:13:32.221+05:30	f	f	\N	\N
139	31	75 ml	20	\N	t	1690	\N	5	none	f	illiyoon-ceramide-ato-concentrate-cream	2026-11-13 10:13:33.482+05:30	2026-11-13 10:13:33.374+05:30	\N	published	2026-11-13 10:13:33.49+05:30	2026-11-13 10:13:33.49+05:30	f	f	\N	\N
138	31	75 ml	20	\N	t	1690	\N	5	none	f	illiyoon-ceramide-ato-concentrate-cream	2026-11-13 10:13:33.432+05:30	2026-11-13 10:13:33.374+05:30	\N	published	2026-11-13 10:13:33.44+05:30	2026-11-13 10:13:33.44+05:30	f	f	\N	\N
143	32	\N	20	\N	t	2990	\N	5	bestseller	f	dr-althea-345-relief-cream	2026-11-13 10:13:35.779+05:30	2026-11-13 10:13:35.672+05:30	\N	published	2026-11-13 10:13:35.788+05:30	2026-11-13 10:13:35.788+05:30	f	f	\N	\N
142	32	\N	20	\N	t	2990	\N	5	bestseller	f	dr-althea-345-relief-cream	2026-11-13 10:13:35.747+05:30	2026-11-13 10:13:35.672+05:30	\N	published	2026-11-13 10:13:35.755+05:30	2026-11-13 10:13:35.755+05:30	f	f	\N	\N
147	33	100 ml	20	\N	t	2390	\N	5	none	f	purito-oat-in-calming-gel-cream	2026-11-13 10:13:37.185+05:30	2026-11-13 10:13:37.092+05:30	\N	published	2026-11-13 10:13:37.193+05:30	2026-11-13 10:13:37.193+05:30	f	f	\N	\N
146	33	100 ml	20	\N	t	2390	\N	5	none	f	purito-oat-in-calming-gel-cream	2026-11-13 10:13:37.153+05:30	2026-11-13 10:13:37.092+05:30	\N	published	2026-11-13 10:13:37.162+05:30	2026-11-13 10:13:37.162+05:30	f	f	\N	\N
151	34	100 g	20	\N	t	2490	\N	5	none	f	cosrx-advanced-snail-92-all-in-one-cream	2026-11-13 10:13:38.509+05:30	2026-11-13 10:13:38.42+05:30	\N	published	2026-11-13 10:13:38.516+05:30	2026-11-13 10:13:38.516+05:30	f	f	\N	\N
150	34	100 g	20	\N	t	2490	\N	5	none	f	cosrx-advanced-snail-92-all-in-one-cream	2026-11-13 10:13:38.483+05:30	2026-11-13 10:13:38.42+05:30	\N	published	2026-11-13 10:13:38.49+05:30	2026-11-13 10:13:38.49+05:30	f	f	\N	\N
155	35	60 g	20	\N	t	2490	\N	5	none	f	some-by-mi-snail-truecica-miracle-repair-cream	2026-11-13 10:13:39.651+05:30	2026-11-13 10:13:39.556+05:30	\N	published	2026-11-13 10:13:39.66+05:30	2026-11-13 10:13:39.66+05:30	f	f	\N	\N
159	36	150 ml	20	\N	t	1890	\N	5	none	f	round-lab-mugwort-cleansing-foam	2026-11-13 10:13:40.713+05:30	2026-11-13 10:13:40.636+05:30	\N	published	2026-11-13 10:13:40.723+05:30	2026-11-13 10:13:40.723+05:30	f	f	\N	\N
158	36	150 ml	20	\N	t	1890	\N	5	none	f	round-lab-mugwort-cleansing-foam	2026-11-13 10:13:40.681+05:30	2026-11-13 10:13:40.636+05:30	\N	published	2026-11-13 10:13:40.69+05:30	2026-11-13 10:13:40.69+05:30	f	f	\N	\N
163	37	150 ml	20	\N	t	1390	\N	5	bestseller	f	cosrx-low-ph-good-morning-gel-cleanser	2026-11-13 10:13:42.246+05:30	2026-11-13 10:13:42.112+05:30	\N	published	2026-11-13 10:13:42.254+05:30	2026-11-13 10:13:42.254+05:30	f	f	\N	\N
162	37	150 ml	20	\N	t	1390	\N	5	bestseller	f	cosrx-low-ph-good-morning-gel-cleanser	2026-11-13 10:13:42.209+05:30	2026-11-13 10:13:42.112+05:30	\N	published	2026-11-13 10:13:42.225+05:30	2026-11-13 10:13:42.225+05:30	f	f	\N	\N
165	38	120 ml	20	\N	t	2290	\N	5	none	f	lagom-cellup-micro-foam-cleanser	2026-11-13 10:13:43.73+05:30	2026-11-13 10:13:43.693+05:30	\N	published	2026-11-13 10:13:43.737+05:30	2026-11-13 10:13:43.737+05:30	f	f	\N	\N
167	38	120 ml	20	\N	t	2290	\N	5	none	f	lagom-cellup-micro-foam-cleanser	2026-11-13 10:13:43.802+05:30	2026-11-13 10:13:43.693+05:30	\N	published	2026-11-13 10:13:43.81+05:30	2026-11-13 10:13:43.81+05:30	f	f	\N	\N
171	39	\N	20	\N	t	1990	\N	5	none	f	b-plain-mung-bean-cleansing-foam	2026-11-13 10:13:45.418+05:30	2026-11-13 10:13:45.314+05:30	\N	published	2026-11-13 10:13:45.426+05:30	2026-11-13 10:13:45.426+05:30	f	f	\N	\N
170	39	\N	20	\N	t	1990	\N	5	none	f	b-plain-mung-bean-cleansing-foam	2026-11-13 10:13:45.387+05:30	2026-11-13 10:13:45.314+05:30	\N	published	2026-11-13 10:13:45.397+05:30	2026-11-13 10:13:45.397+05:30	f	f	\N	\N
174	40	30 ml	20	\N	t	1290	\N	5	new	f	jipu-cleansing-balm	2026-11-13 10:13:46.838+05:30	2026-11-13 10:13:46.754+05:30	\N	published	2026-11-13 10:13:46.858+05:30	2026-11-13 10:13:46.858+05:30	f	f	\N	\N
184	43	250 ml	20	\N	t	2490	\N	5	bestseller	f	anua-heartleaf-77-soothing-toner	2026-11-13 10:13:50.965+05:30	2026-11-13 10:13:50.965+05:30	\N	published	2026-11-13 10:13:50.975+05:30	2026-11-13 10:13:50.975+05:30	f	f	\N	\N
185	43	250 ml	20	\N	t	2490	\N	5	bestseller	f	anua-heartleaf-77-soothing-toner	2026-11-13 10:13:50.996+05:30	2026-11-13 10:13:50.965+05:30	\N	published	2026-11-13 10:13:51+05:30	2026-11-13 10:13:51+05:30	f	f	\N	\N
187	43	250 ml	20	\N	t	2490	\N	5	bestseller	f	anua-heartleaf-77-soothing-toner	2026-11-13 10:13:51.045+05:30	2026-11-13 10:13:50.965+05:30	\N	published	2026-11-13 10:13:51.052+05:30	2026-11-13 10:13:51.052+05:30	f	f	\N	\N
186	43	250 ml	20	\N	t	2490	\N	5	bestseller	f	anua-heartleaf-77-soothing-toner	2026-11-13 10:13:51.01+05:30	2026-11-13 10:13:50.965+05:30	\N	published	2026-11-13 10:13:51.021+05:30	2026-11-13 10:13:51.021+05:30	f	f	\N	\N
180	42	50 ml	20	\N	t	2990	\N	5	none	f	mixsoon-bean-essence	2026-11-13 10:13:49.419+05:30	2026-11-13 10:13:49.419+05:30	\N	published	2026-11-13 10:13:49.421+05:30	2026-11-13 10:13:49.421+05:30	f	f	\N	\N
181	42	50 ml	20	\N	t	2990	\N	5	none	f	mixsoon-bean-essence	2026-11-13 10:13:49.431+05:30	2026-11-13 10:13:49.419+05:30	\N	published	2026-11-13 10:13:49.434+05:30	2026-11-13 10:13:49.434+05:30	f	f	\N	\N
188	44	100 ml	20	\N	t	2490	\N	5	bestseller	f	cosrx-advanced-snail-96-mucin-power-essence	2026-11-13 10:13:52.495+05:30	2026-11-13 10:13:52.495+05:30	\N	published	2026-11-13 10:13:52.501+05:30	2026-11-13 10:13:52.501+05:30	f	f	\N	\N
189	44	100 ml	20	\N	t	2490	\N	5	bestseller	f	cosrx-advanced-snail-96-mucin-power-essence	2026-11-13 10:13:52.527+05:30	2026-11-13 10:13:52.495+05:30	\N	published	2026-11-13 10:13:52.535+05:30	2026-11-13 10:13:52.535+05:30	f	f	\N	\N
196	46	80 ml	20	\N	t	3490	\N	5	none	f	innisfree-green-tea-seed-hyaluronic-serum	2026-11-13 10:13:54.986+05:30	2026-11-13 10:13:54.986+05:30	\N	published	2026-11-13 10:13:54.992+05:30	2026-11-13 10:13:54.992+05:30	f	f	\N	\N
193	45	60 pads	20	\N	t	2690	\N	5	none	f	anua-pdrn-hyaluronic-glow-pad	2026-11-13 10:13:53.867+05:30	2026-11-13 10:13:53.842+05:30	\N	published	2026-11-13 10:13:53.875+05:30	2026-11-13 10:13:53.875+05:30	f	f	\N	\N
195	45	60 pads	20	\N	t	2690	\N	5	none	f	anua-pdrn-hyaluronic-glow-pad	2026-11-13 10:13:53.934+05:30	2026-11-13 10:13:53.842+05:30	\N	published	2026-11-13 10:13:53.948+05:30	2026-11-13 10:13:53.948+05:30	f	f	\N	\N
197	46	80 ml	20	\N	t	3490	\N	5	none	f	innisfree-green-tea-seed-hyaluronic-serum	2026-11-13 10:13:55.01+05:30	2026-11-13 10:13:54.986+05:30	\N	published	2026-11-13 10:13:55.026+05:30	2026-11-13 10:13:55.026+05:30	f	f	\N	\N
80	16	\N	0	\N	\N	\N	\N	5	none	t	\N	2026-11-07 11:03:28.797+05:30	2026-11-07 10:58:16.077+05:30	2026-11-07 11:03:28.651+05:30	draft	2026-11-07 11:03:28.812+05:30	2026-11-07 11:03:28.812+05:30	t	f	\N	\N
72	16	\N	0	\N	\N	\N	\N	5	none	t	\N	2026-11-07 10:58:16.077+05:30	2026-11-07 10:58:16.077+05:30	\N	draft	2026-11-07 10:58:16.092+05:30	2026-11-07 10:58:16.092+05:30	f	f	\N	\N
200	47	\N	20	\N	t	2290	\N	5	none	f	beauty-of-joseon-revive-eye-serum-ginseng-retinal	2026-11-13 10:13:56.305+05:30	2026-11-13 10:13:56.304+05:30	\N	published	2026-11-13 10:13:56.314+05:30	2026-11-13 10:13:56.314+05:30	f	f	\N	\N
201	47	\N	20	\N	t	2290	\N	5	none	f	beauty-of-joseon-revive-eye-serum-ginseng-retinal	2026-11-13 10:13:56.333+05:30	2026-11-13 10:13:56.304+05:30	\N	published	2026-11-13 10:13:56.342+05:30	2026-11-13 10:13:56.342+05:30	f	f	\N	\N
204	48	\N	20	\N	t	1990	\N	5	bestseller	f	beauty-of-joseon-glow-serum-propolis-niacinamide	2026-11-13 10:13:57.595+05:30	2026-11-13 10:13:57.595+05:30	\N	published	2026-11-13 10:13:57.601+05:30	2026-11-13 10:13:57.601+05:30	f	f	\N	\N
205	48	\N	20	\N	t	1990	\N	5	bestseller	f	beauty-of-joseon-glow-serum-propolis-niacinamide	2026-11-13 10:13:57.619+05:30	2026-11-13 10:13:57.595+05:30	\N	published	2026-11-13 10:13:57.627+05:30	2026-11-13 10:13:57.627+05:30	f	f	\N	\N
208	49	\N	20	\N	t	2490	\N	5	none	f	torriden-dive-in-serum	2026-11-13 10:13:58.93+05:30	2026-11-13 10:13:58.93+05:30	\N	published	2026-11-13 10:13:58.933+05:30	2026-11-13 10:13:58.933+05:30	f	f	\N	\N
209	49	\N	20	\N	t	2490	\N	5	none	f	torriden-dive-in-serum	2026-11-13 10:13:58.957+05:30	2026-11-13 10:13:58.93+05:30	\N	published	2026-11-13 10:13:58.965+05:30	2026-11-13 10:13:58.965+05:30	f	f	\N	\N
212	50	30 ml	20	\N	t	2790	\N	5	none	f	anua-100-hyaluron-serum	2026-11-13 10:14:00.084+05:30	2026-11-13 10:14:00.083+05:30	\N	published	2026-11-13 10:14:00.09+05:30	2026-11-13 10:14:00.09+05:30	f	f	\N	\N
213	50	30 ml	20	\N	t	2790	\N	5	none	f	anua-100-hyaluron-serum	2026-11-13 10:14:00.108+05:30	2026-11-13 10:14:00.083+05:30	\N	published	2026-11-13 10:14:00.124+05:30	2026-11-13 10:14:00.124+05:30	f	f	\N	\N
216	51	30 ml	20	\N	t	3490	\N	5	none	f	medicube-pdrn-pink-peptide-serum	2026-11-13 10:14:01.287+05:30	2026-11-13 10:14:01.286+05:30	\N	published	2026-11-13 10:14:01.293+05:30	2026-11-13 10:14:01.293+05:30	f	f	\N	\N
217	51	30 ml	20	\N	t	3490	\N	5	none	f	medicube-pdrn-pink-peptide-serum	2026-11-13 10:14:01.311+05:30	2026-11-13 10:14:01.286+05:30	\N	published	2026-11-13 10:14:01.322+05:30	2026-11-13 10:14:01.322+05:30	f	f	\N	\N
172	40	30 ml	20	\N	t	1290	\N	5	new	f	jipu-cleansing-balm	2026-11-13 10:13:46.754+05:30	2026-11-13 10:13:46.754+05:30	\N	published	2026-11-13 10:13:46.771+05:30	2026-11-13 10:13:46.771+05:30	f	f	\N	\N
176	41	150 g	20	\N	t	1490	\N	5	none	f	innisfree-green-tea-amino-hydrating-cleansing-foam	2026-11-13 10:13:48.428+05:30	2026-11-13 10:13:48.428+05:30	\N	published	2026-11-13 10:13:48.439+05:30	2026-11-13 10:13:48.439+05:30	f	f	\N	\N
177	41	150 g	20	\N	t	1490	\N	5	none	f	innisfree-green-tea-amino-hydrating-cleansing-foam	2026-11-13 10:13:48.481+05:30	2026-11-13 10:13:48.428+05:30	\N	published	2026-11-13 10:13:48.492+05:30	2026-11-13 10:13:48.492+05:30	f	f	\N	\N
179	41	150 g	20	\N	t	1490	\N	5	none	f	innisfree-green-tea-amino-hydrating-cleansing-foam	2026-11-13 10:13:48.554+05:30	2026-11-13 10:13:48.428+05:30	\N	published	2026-11-13 10:13:48.563+05:30	2026-11-13 10:13:48.563+05:30	f	f	\N	\N
183	42	50 ml	20	\N	t	2990	\N	5	none	f	mixsoon-bean-essence	2026-11-13 10:13:49.496+05:30	2026-11-13 10:13:49.419+05:30	\N	published	2026-11-13 10:13:49.503+05:30	2026-11-13 10:13:49.503+05:30	f	f	\N	\N
182	42	50 ml	20	\N	t	2990	\N	5	none	f	mixsoon-bean-essence	2026-11-13 10:13:49.448+05:30	2026-11-13 10:13:49.419+05:30	\N	published	2026-11-13 10:13:49.461+05:30	2026-11-13 10:13:49.461+05:30	f	f	\N	\N
191	44	100 ml	20	\N	t	2490	\N	5	bestseller	f	cosrx-advanced-snail-96-mucin-power-essence	2026-11-13 10:13:52.587+05:30	2026-11-13 10:13:52.495+05:30	\N	published	2026-11-13 10:13:52.597+05:30	2026-11-13 10:13:52.597+05:30	f	f	\N	\N
190	44	100 ml	20	\N	t	2490	\N	5	bestseller	f	cosrx-advanced-snail-96-mucin-power-essence	2026-11-13 10:13:52.551+05:30	2026-11-13 10:13:52.495+05:30	\N	published	2026-11-13 10:13:52.557+05:30	2026-11-13 10:13:52.557+05:30	f	f	\N	\N
192	45	60 pads	20	\N	t	2690	\N	5	none	f	anua-pdrn-hyaluronic-glow-pad	2026-11-13 10:13:53.842+05:30	2026-11-13 10:13:53.842+05:30	\N	published	2026-11-13 10:13:53.848+05:30	2026-11-13 10:13:53.848+05:30	f	f	\N	\N
194	45	60 pads	20	\N	t	2690	\N	5	none	f	anua-pdrn-hyaluronic-glow-pad	2026-11-13 10:13:53.901+05:30	2026-11-13 10:13:53.842+05:30	\N	published	2026-11-13 10:13:53.913+05:30	2026-11-13 10:13:53.913+05:30	f	f	\N	\N
199	46	80 ml	20	\N	t	3490	\N	5	none	f	innisfree-green-tea-seed-hyaluronic-serum	2026-11-13 10:13:55.063+05:30	2026-11-13 10:13:54.986+05:30	\N	published	2026-11-13 10:13:55.074+05:30	2026-11-13 10:13:55.074+05:30	f	f	\N	\N
198	46	80 ml	20	\N	t	3490	\N	5	none	f	innisfree-green-tea-seed-hyaluronic-serum	2026-11-13 10:13:55.046+05:30	2026-11-13 10:13:54.986+05:30	\N	published	2026-11-13 10:13:55.05+05:30	2026-11-13 10:13:55.05+05:30	f	f	\N	\N
203	47	\N	20	\N	t	2290	\N	5	none	f	beauty-of-joseon-revive-eye-serum-ginseng-retinal	2026-11-13 10:13:56.4+05:30	2026-11-13 10:13:56.304+05:30	\N	published	2026-11-13 10:13:56.415+05:30	2026-11-13 10:13:56.415+05:30	f	f	\N	\N
202	47	\N	20	\N	t	2290	\N	5	none	f	beauty-of-joseon-revive-eye-serum-ginseng-retinal	2026-11-13 10:13:56.367+05:30	2026-11-13 10:13:56.304+05:30	\N	published	2026-11-13 10:13:56.377+05:30	2026-11-13 10:13:56.377+05:30	f	f	\N	\N
207	48	\N	20	\N	t	1990	\N	5	bestseller	f	beauty-of-joseon-glow-serum-propolis-niacinamide	2026-11-13 10:13:57.7+05:30	2026-11-13 10:13:57.595+05:30	\N	published	2026-11-13 10:13:57.708+05:30	2026-11-13 10:13:57.708+05:30	f	f	\N	\N
206	48	\N	20	\N	t	1990	\N	5	bestseller	f	beauty-of-joseon-glow-serum-propolis-niacinamide	2026-11-13 10:13:57.657+05:30	2026-11-13 10:13:57.595+05:30	\N	published	2026-11-13 10:13:57.673+05:30	2026-11-13 10:13:57.673+05:30	f	f	\N	\N
211	49	\N	20	\N	t	2490	\N	5	none	f	torriden-dive-in-serum	2026-11-13 10:13:59.032+05:30	2026-11-13 10:13:58.93+05:30	\N	published	2026-11-13 10:13:59.041+05:30	2026-11-13 10:13:59.041+05:30	f	f	\N	\N
210	49	\N	20	\N	t	2490	\N	5	none	f	torriden-dive-in-serum	2026-11-13 10:13:59+05:30	2026-11-13 10:13:58.93+05:30	\N	published	2026-11-13 10:13:59.009+05:30	2026-11-13 10:13:59.009+05:30	f	f	\N	\N
215	50	30 ml	20	\N	t	2790	\N	5	none	f	anua-100-hyaluron-serum	2026-11-13 10:14:00.181+05:30	2026-11-13 10:14:00.083+05:30	\N	published	2026-11-13 10:14:00.189+05:30	2026-11-13 10:14:00.189+05:30	f	f	\N	\N
214	50	30 ml	20	\N	t	2790	\N	5	none	f	anua-100-hyaluron-serum	2026-11-13 10:14:00.148+05:30	2026-11-13 10:14:00.083+05:30	\N	published	2026-11-13 10:14:00.157+05:30	2026-11-13 10:14:00.157+05:30	f	f	\N	\N
219	51	30 ml	20	\N	t	3490	\N	5	none	f	medicube-pdrn-pink-peptide-serum	2026-11-13 10:14:01.372+05:30	2026-11-13 10:14:01.286+05:30	\N	published	2026-11-13 10:14:01.381+05:30	2026-11-13 10:14:01.381+05:30	f	f	\N	\N
218	51	30 ml	20	\N	t	3490	\N	5	none	f	medicube-pdrn-pink-peptide-serum	2026-11-13 10:14:01.342+05:30	2026-11-13 10:14:01.286+05:30	\N	published	2026-11-13 10:14:01.35+05:30	2026-11-13 10:14:01.35+05:30	f	f	\N	\N
223	52	\N	20	\N	t	1990	\N	5	bestseller	f	beauty-of-joseon-relief-sun-rice-probiotics-spf50-pa	2026-11-13 10:14:02.711+05:30	2026-11-13 10:14:02.603+05:30	\N	published	2026-11-13 10:14:02.727+05:30	2026-11-13 10:14:02.727+05:30	t	f	\N	\N
222	52	\N	20	\N	t	1990	\N	5	bestseller	f	beauty-of-joseon-relief-sun-rice-probiotics-spf50-pa	2026-11-13 10:14:02.668+05:30	2026-11-13 10:14:02.603+05:30	\N	published	2026-11-13 10:14:02.676+05:30	2026-11-13 10:14:02.676+05:30	f	f	\N	\N
221	52	\N	20	\N	t	1990	\N	5	bestseller	f	beauty-of-joseon-relief-sun-rice-probiotics-spf50-pa	2026-11-13 10:14:02.637+05:30	2026-11-13 10:14:02.603+05:30	\N	published	2026-11-13 10:14:02.644+05:30	2026-11-13 10:14:02.644+05:30	f	f	\N	\N
220	52	\N	20	\N	t	1990	\N	5	bestseller	f	beauty-of-joseon-relief-sun-rice-probiotics-spf50-pa	2026-11-13 10:14:02.603+05:30	2026-11-13 10:14:02.603+05:30	\N	published	2026-11-13 10:14:02.617+05:30	2026-11-13 10:14:02.617+05:30	f	f	\N	\N
95	20	\N	20	\N	t	1390	\N	5	new	f	mise-en-scene-perfect-serum	2026-11-13 10:13:18.226+05:30	2026-11-13 10:13:18.136+05:30	\N	published	2026-11-13 10:13:18.235+05:30	2026-11-13 10:13:18.235+05:30	f	f	\N	\N
94	20	\N	20	\N	t	1390	\N	5	new	f	mise-en-scene-perfect-serum	2026-11-13 10:13:18.194+05:30	2026-11-13 10:13:18.136+05:30	\N	published	2026-11-13 10:13:18.203+05:30	2026-11-13 10:13:18.203+05:30	f	f	\N	\N
99	21	500 ml	20	\N	t	2990	\N	5	new	f	dr-forhair-folligen-original-shampoo	2026-11-13 10:13:19.411+05:30	2026-11-13 10:13:19.313+05:30	\N	published	2026-11-13 10:13:19.421+05:30	2026-11-13 10:13:19.421+05:30	f	f	\N	\N
98	21	500 ml	20	\N	t	2990	\N	5	new	f	dr-forhair-folligen-original-shampoo	2026-11-13 10:13:19.379+05:30	2026-11-13 10:13:19.313+05:30	\N	published	2026-11-13 10:13:19.388+05:30	2026-11-13 10:13:19.388+05:30	f	f	\N	\N
91	19	80 ml	20	\N	t	1490	\N	5	new	f	mise-en-scene-perfect-serum-original	2026-11-13 10:13:17.055+05:30	2026-11-13 10:13:16.965+05:30	\N	published	2026-11-13 10:13:17.062+05:30	2026-11-13 10:13:17.062+05:30	f	f	\N	\N
103	22	530 ml	20	\N	t	1990	\N	5	new	f	lador-hydro-lpp-treatment	2026-11-13 10:13:20.618+05:30	2026-11-13 10:13:20.521+05:30	\N	published	2026-11-13 10:13:20.626+05:30	2026-11-13 10:13:20.626+05:30	f	f	\N	\N
102	22	530 ml	20	\N	t	1990	\N	5	new	f	lador-hydro-lpp-treatment	2026-11-13 10:13:20.576+05:30	2026-11-13 10:13:20.521+05:30	\N	published	2026-11-13 10:13:20.584+05:30	2026-11-13 10:13:20.584+05:30	f	f	\N	\N
90	19	80 ml	20	\N	t	1490	\N	5	new	f	mise-en-scene-perfect-serum-original	2026-11-13 10:13:17.026+05:30	2026-11-13 10:13:16.965+05:30	\N	published	2026-11-13 10:13:17.033+05:30	2026-11-13 10:13:17.033+05:30	f	f	\N	\N
89	19	80 ml	20	\N	t	1490	\N	5	new	f	mise-en-scene-perfect-serum-original	2026-11-13 10:13:16.997+05:30	2026-11-13 10:13:16.965+05:30	\N	published	2026-11-13 10:13:17.005+05:30	2026-11-13 10:13:17.005+05:30	f	f	\N	\N
107	23	\N	20	\N	t	2690	\N	5	new	f	aromatica-rosemary-scalp-scrub	2026-11-13 10:13:21.625+05:30	2026-11-13 10:13:21.535+05:30	\N	published	2026-11-13 10:13:21.635+05:30	2026-11-13 10:13:21.635+05:30	f	f	\N	\N
106	23	\N	20	\N	t	2690	\N	5	new	f	aromatica-rosemary-scalp-scrub	2026-11-13 10:13:21.593+05:30	2026-11-13 10:13:21.535+05:30	\N	published	2026-11-13 10:13:21.603+05:30	2026-11-13 10:13:21.603+05:30	f	f	\N	\N
93	20	\N	20	\N	t	1390	\N	5	new	f	mise-en-scene-perfect-serum	2026-11-13 10:13:18.163+05:30	2026-11-13 10:13:18.136+05:30	\N	published	2026-11-13 10:13:18.171+05:30	2026-11-13 10:13:18.171+05:30	f	f	\N	\N
111	24	100 ml	20	\N	t	2490	\N	5	new	f	aromatica-rosemary-root-enhancer	2026-11-13 10:13:22.631+05:30	2026-11-13 10:13:22.528+05:30	\N	published	2026-11-13 10:13:22.639+05:30	2026-11-13 10:13:22.639+05:30	f	f	\N	\N
110	24	100 ml	20	\N	t	2490	\N	5	new	f	aromatica-rosemary-root-enhancer	2026-11-13 10:13:22.602+05:30	2026-11-13 10:13:22.528+05:30	\N	published	2026-11-13 10:13:22.61+05:30	2026-11-13 10:13:22.61+05:30	f	f	\N	\N
92	20	\N	20	\N	t	1390	\N	5	new	f	mise-en-scene-perfect-serum	2026-11-13 10:13:18.136+05:30	2026-11-13 10:13:18.136+05:30	\N	published	2026-11-13 10:13:18.143+05:30	2026-11-13 10:13:18.143+05:30	f	f	\N	\N
97	21	500 ml	20	\N	t	2990	\N	5	new	f	dr-forhair-folligen-original-shampoo	2026-11-13 10:13:19.341+05:30	2026-11-13 10:13:19.313+05:30	\N	published	2026-11-13 10:13:19.354+05:30	2026-11-13 10:13:19.354+05:30	f	f	\N	\N
96	21	500 ml	20	\N	t	2990	\N	5	new	f	dr-forhair-folligen-original-shampoo	2026-11-13 10:13:19.314+05:30	2026-11-13 10:13:19.313+05:30	\N	published	2026-11-13 10:13:19.32+05:30	2026-11-13 10:13:19.32+05:30	f	f	\N	\N
115	25	400 ml	20	\N	t	2490	\N	5	new	f	aromatica-rosemary-scalp-scaling-shampoo	2026-11-13 10:13:23.859+05:30	2026-11-13 10:13:23.775+05:30	\N	published	2026-11-13 10:13:23.867+05:30	2026-11-13 10:13:23.867+05:30	f	f	\N	\N
114	25	400 ml	20	\N	t	2490	\N	5	new	f	aromatica-rosemary-scalp-scaling-shampoo	2026-11-13 10:13:23.829+05:30	2026-11-13 10:13:23.775+05:30	\N	published	2026-11-13 10:13:23.837+05:30	2026-11-13 10:13:23.837+05:30	f	f	\N	\N
101	22	530 ml	20	\N	t	1990	\N	5	new	f	lador-hydro-lpp-treatment	2026-11-13 10:13:20.545+05:30	2026-11-13 10:13:20.521+05:30	\N	published	2026-11-13 10:13:20.553+05:30	2026-11-13 10:13:20.553+05:30	f	f	\N	\N
100	22	530 ml	20	\N	t	1990	\N	5	new	f	lador-hydro-lpp-treatment	2026-11-13 10:13:20.521+05:30	2026-11-13 10:13:20.521+05:30	\N	published	2026-11-13 10:13:20.527+05:30	2026-11-13 10:13:20.527+05:30	f	f	\N	\N
105	23	\N	20	\N	t	2690	\N	5	new	f	aromatica-rosemary-scalp-scrub	2026-11-13 10:13:21.563+05:30	2026-11-13 10:13:21.535+05:30	\N	published	2026-11-13 10:13:21.572+05:30	2026-11-13 10:13:21.572+05:30	f	f	\N	\N
104	23	\N	20	\N	t	2690	\N	5	new	f	aromatica-rosemary-scalp-scrub	2026-11-13 10:13:21.536+05:30	2026-11-13 10:13:21.535+05:30	\N	published	2026-11-13 10:13:21.544+05:30	2026-11-13 10:13:21.544+05:30	f	f	\N	\N
119	26	750 ml	20	\N	t	2990	\N	5	none	f	labo-h-scalp-strengthening-shampoo	2026-11-13 10:13:25.003+05:30	2026-11-13 10:13:24.861+05:30	\N	published	2026-11-13 10:13:25.013+05:30	2026-11-13 10:13:25.013+05:30	f	f	\N	\N
118	26	750 ml	20	\N	t	2990	\N	5	none	f	labo-h-scalp-strengthening-shampoo	2026-11-13 10:13:24.943+05:30	2026-11-13 10:13:24.861+05:30	\N	published	2026-11-13 10:13:24.955+05:30	2026-11-13 10:13:24.955+05:30	f	f	\N	\N
109	24	100 ml	20	\N	t	2490	\N	5	new	f	aromatica-rosemary-root-enhancer	2026-11-13 10:13:22.571+05:30	2026-11-13 10:13:22.528+05:30	\N	published	2026-11-13 10:13:22.58+05:30	2026-11-13 10:13:22.58+05:30	f	f	\N	\N
108	24	100 ml	20	\N	t	2490	\N	5	new	f	aromatica-rosemary-root-enhancer	2026-11-13 10:13:22.529+05:30	2026-11-13 10:13:22.528+05:30	\N	published	2026-11-13 10:13:22.536+05:30	2026-11-13 10:13:22.536+05:30	f	f	\N	\N
123	27	500 ml	20	\N	t	1890	\N	5	none	f	illiyoon-ultra-repair-deep-moisture-wash	2026-11-13 10:13:26.605+05:30	2026-11-13 10:13:26.512+05:30	\N	published	2026-11-13 10:13:26.61+05:30	2026-11-13 10:13:26.61+05:30	f	f	\N	\N
122	27	500 ml	20	\N	t	1890	\N	5	none	f	illiyoon-ultra-repair-deep-moisture-wash	2026-11-13 10:13:26.57+05:30	2026-11-13 10:13:26.512+05:30	\N	published	2026-11-13 10:13:26.584+05:30	2026-11-13 10:13:26.584+05:30	f	f	\N	\N
113	25	400 ml	20	\N	t	2490	\N	5	new	f	aromatica-rosemary-scalp-scaling-shampoo	2026-11-13 10:13:23.8+05:30	2026-11-13 10:13:23.775+05:30	\N	published	2026-11-13 10:13:23.808+05:30	2026-11-13 10:13:23.808+05:30	f	f	\N	\N
112	25	400 ml	20	\N	t	2490	\N	5	new	f	aromatica-rosemary-scalp-scaling-shampoo	2026-11-13 10:13:23.775+05:30	2026-11-13 10:13:23.775+05:30	\N	published	2026-11-13 10:13:23.781+05:30	2026-11-13 10:13:23.781+05:30	f	f	\N	\N
117	26	750 ml	20	\N	t	2990	\N	5	none	f	labo-h-scalp-strengthening-shampoo	2026-11-13 10:13:24.903+05:30	2026-11-13 10:13:24.861+05:30	\N	published	2026-11-13 10:13:24.91+05:30	2026-11-13 10:13:24.91+05:30	f	f	\N	\N
126	28	500 ml	20	\N	t	1890	\N	5	none	f	illiyoon-ultra-moisture-scrub-wash	2026-11-13 10:13:28.838+05:30	2026-11-13 10:13:28.766+05:30	\N	published	2026-11-13 10:13:28.847+05:30	2026-11-13 10:13:28.847+05:30	f	f	\N	\N
127	28	500 ml	20	\N	t	1890	\N	5	none	f	illiyoon-ultra-moisture-scrub-wash	2026-11-13 10:13:28.879+05:30	2026-11-13 10:13:28.766+05:30	\N	published	2026-11-13 10:13:28.887+05:30	2026-11-13 10:13:28.887+05:30	f	f	\N	\N
116	26	750 ml	20	\N	t	2990	\N	5	none	f	labo-h-scalp-strengthening-shampoo	2026-11-13 10:13:24.862+05:30	2026-11-13 10:13:24.861+05:30	\N	published	2026-11-13 10:13:24.876+05:30	2026-11-13 10:13:24.876+05:30	f	f	\N	\N
121	27	500 ml	20	\N	t	1890	\N	5	none	f	illiyoon-ultra-repair-deep-moisture-wash	2026-11-13 10:13:26.538+05:30	2026-11-13 10:13:26.512+05:30	\N	published	2026-11-13 10:13:26.546+05:30	2026-11-13 10:13:26.546+05:30	f	f	\N	\N
120	27	500 ml	20	\N	t	1890	\N	5	none	f	illiyoon-ultra-repair-deep-moisture-wash	2026-11-13 10:13:26.512+05:30	2026-11-13 10:13:26.512+05:30	\N	published	2026-11-13 10:13:26.518+05:30	2026-11-13 10:13:26.518+05:30	f	f	\N	\N
225	53	70 ml	20	\N	t	3290	\N	5	none	f	laneige-water-sleeping-mask	2026-11-13 10:14:03.745+05:30	2026-11-13 10:14:03.716+05:30	\N	published	2026-11-13 10:14:03.752+05:30	2026-11-13 10:14:03.752+05:30	f	f	\N	\N
227	53	70 ml	20	\N	t	3290	\N	5	none	f	laneige-water-sleeping-mask	2026-11-13 10:14:03.811+05:30	2026-11-13 10:14:03.716+05:30	\N	published	2026-11-13 10:14:03.826+05:30	2026-11-13 10:14:03.826+05:30	f	f	\N	\N
125	28	500 ml	20	\N	t	1890	\N	5	none	f	illiyoon-ultra-moisture-scrub-wash	2026-11-13 10:13:28.801+05:30	2026-11-13 10:13:28.766+05:30	\N	published	2026-11-13 10:13:28.817+05:30	2026-11-13 10:13:28.817+05:30	f	f	\N	\N
124	28	500 ml	20	\N	t	1890	\N	5	none	f	illiyoon-ultra-moisture-scrub-wash	2026-11-13 10:13:28.766+05:30	2026-11-13 10:13:28.766+05:30	\N	published	2026-11-13 10:13:28.779+05:30	2026-11-13 10:13:28.779+05:30	f	f	\N	\N
226	53	70 ml	20	\N	t	3290	\N	5	none	f	laneige-water-sleeping-mask	2026-11-13 10:14:03.775+05:30	2026-11-13 10:14:03.716+05:30	\N	published	2026-11-13 10:14:03.785+05:30	2026-11-13 10:14:03.785+05:30	f	f	\N	\N
232	55	\N	20	\N	t	390	\N	5	none	f	torriden-balanceful-cica-mask	2026-11-13 10:14:06.61+05:30	2026-11-13 10:14:06.61+05:30	\N	published	2026-11-13 10:14:06.616+05:30	2026-11-13 10:14:06.616+05:30	f	f	\N	\N
233	55	\N	20	\N	t	390	\N	5	none	f	torriden-balanceful-cica-mask	2026-11-13 10:14:06.632+05:30	2026-11-13 10:14:06.61+05:30	\N	published	2026-11-13 10:14:06.64+05:30	2026-11-13 10:14:06.64+05:30	f	f	\N	\N
236	56	\N	20	\N	t	350	\N	5	none	f	mediheal-collagen-mask	2026-11-13 10:14:07.851+05:30	2026-11-13 10:14:07.851+05:30	\N	published	2026-11-13 10:14:07.857+05:30	2026-11-13 10:14:07.857+05:30	f	f	\N	\N
237	56	\N	20	\N	t	350	\N	5	none	f	mediheal-collagen-mask	2026-11-13 10:14:07.874+05:30	2026-11-13 10:14:07.851+05:30	\N	published	2026-11-13 10:14:07.881+05:30	2026-11-13 10:14:07.881+05:30	f	f	\N	\N
240	57	\N	20	\N	t	490	\N	5	none	f	abib-gummy-sheet-mask-heartleaf-sticker	2026-11-13 10:14:08.968+05:30	2026-11-13 10:14:08.968+05:30	\N	published	2026-11-13 10:14:08.985+05:30	2026-11-13 10:14:08.985+05:30	f	f	\N	\N
241	57	\N	20	\N	t	490	\N	5	none	f	abib-gummy-sheet-mask-heartleaf-sticker	2026-11-13 10:14:09.002+05:30	2026-11-13 10:14:08.968+05:30	\N	published	2026-11-13 10:14:09.009+05:30	2026-11-13 10:14:09.009+05:30	f	f	\N	\N
244	58	\N	20	\N	t	350	\N	5	none	f	mediheal-vitamin-c-mask	2026-11-13 10:14:09.938+05:30	2026-11-13 10:14:09.937+05:30	\N	published	2026-11-13 10:14:09.948+05:30	2026-11-13 10:14:09.948+05:30	f	f	\N	\N
245	58	\N	20	\N	t	350	\N	5	none	f	mediheal-vitamin-c-mask	2026-11-13 10:14:09.968+05:30	2026-11-13 10:14:09.937+05:30	\N	published	2026-11-13 10:14:09.978+05:30	2026-11-13 10:14:09.978+05:30	f	f	\N	\N
248	59	\N	20	\N	t	1490	\N	5	none	f	torriden-solid-in-lip-essence	2026-11-13 10:14:10.983+05:30	2026-11-13 10:14:10.983+05:30	\N	published	2026-11-13 10:14:10.986+05:30	2026-11-13 10:14:10.986+05:30	f	f	\N	\N
249	59	\N	20	\N	t	1490	\N	5	none	f	torriden-solid-in-lip-essence	2026-11-13 10:14:10.995+05:30	2026-11-13 10:14:10.983+05:30	\N	published	2026-11-13 10:14:11.003+05:30	2026-11-13 10:14:11.003+05:30	f	f	\N	\N
260	62	\N	20	\N	t	8990	\N	5	none	f	korean-routine-set-clear-hydrated-protected	2026-11-13 10:14:14.527+05:30	2026-11-13 10:14:14.527+05:30	\N	published	2026-11-13 10:14:14.537+05:30	2026-11-13 10:14:14.537+05:30	f	f	\N	\N
252	60	20 g	20	\N	t	2290	\N	5	new	f	laneige-lip-sleeping-mask-peach-iced-tea	2026-11-13 10:14:12.136+05:30	2026-11-13 10:14:12.136+05:30	\N	published	2026-11-13 10:14:12.175+05:30	2026-11-13 10:14:12.175+05:30	f	f	\N	\N
253	60	20 g	20	\N	t	2290	\N	5	new	f	laneige-lip-sleeping-mask-peach-iced-tea	2026-11-13 10:14:12.19+05:30	2026-11-13 10:14:12.136+05:30	\N	published	2026-11-13 10:14:12.197+05:30	2026-11-13 10:14:12.197+05:30	f	f	\N	\N
259	61	\N	20	\N	t	6490	\N	5	none	f	round-lab-dokdo-hydration-routine	2026-11-13 10:14:13.228+05:30	2026-11-13 10:14:13.162+05:30	\N	published	2026-11-13 10:14:13.236+05:30	2026-11-13 10:14:13.236+05:30	f	f	\N	\N
258	61	\N	20	\N	t	6490	\N	5	none	f	round-lab-dokdo-hydration-routine	2026-11-13 10:14:13.192+05:30	2026-11-13 10:14:13.162+05:30	\N	published	2026-11-13 10:14:13.197+05:30	2026-11-13 10:14:13.197+05:30	f	f	\N	\N
261	62	\N	20	\N	t	8990	\N	5	none	f	korean-routine-set-clear-hydrated-protected	2026-11-13 10:14:14.555+05:30	2026-11-13 10:14:14.527+05:30	\N	published	2026-11-13 10:14:14.565+05:30	2026-11-13 10:14:14.565+05:30	f	f	\N	\N
268	19	80 ml	20	\N	t	1490	\N	5	new	f	mise-en-scene-perfect-serum-original	2026-11-13 10:14:15.87+05:30	2026-11-13 10:13:16.965+05:30	\N	published	2026-11-13 10:14:15.881+05:30	2026-11-13 10:14:15.881+05:30	t	f	\N	\N
264	63	\N	20	\N	t	8490	\N	5	none	f	korean-skincare-set-glow-gentle	2026-11-13 10:14:15.757+05:30	2026-11-13 10:14:15.757+05:30	\N	published	2026-11-13 10:14:15.763+05:30	2026-11-13 10:14:15.763+05:30	f	f	\N	\N
265	63	\N	20	\N	t	8490	\N	5	none	f	korean-skincare-set-glow-gentle	2026-11-13 10:14:15.781+05:30	2026-11-13 10:14:15.757+05:30	\N	published	2026-11-13 10:14:15.789+05:30	2026-11-13 10:14:15.789+05:30	f	f	\N	\N
271	22	530 ml	20	\N	t	1990	\N	5	new	f	lador-hydro-lpp-treatment	2026-11-13 10:14:15.994+05:30	2026-11-13 10:13:20.521+05:30	\N	published	2026-11-13 10:14:16.008+05:30	2026-11-13 10:14:16.008+05:30	t	f	\N	\N
88	19	80 ml	20	\N	t	1490	\N	5	new	f	mise-en-scene-perfect-serum-original	2026-11-13 10:13:16.966+05:30	2026-11-13 10:13:16.965+05:30	\N	published	2026-11-13 10:13:16.974+05:30	2026-11-13 10:13:16.974+05:30	f	f	\N	\N
269	20	\N	20	\N	t	1390	\N	5	new	f	mise-en-scene-perfect-serum	2026-11-13 10:14:15.913+05:30	2026-11-13 10:13:18.136+05:30	\N	published	2026-11-13 10:14:15.917+05:30	2026-11-13 10:14:15.917+05:30	t	f	\N	\N
270	21	500 ml	20	\N	t	2990	\N	5	new	f	dr-forhair-folligen-original-shampoo	2026-11-13 10:14:15.951+05:30	2026-11-13 10:13:19.313+05:30	\N	published	2026-11-13 10:14:15.959+05:30	2026-11-13 10:14:15.959+05:30	t	f	\N	\N
272	23	\N	20	\N	t	2690	\N	5	new	f	aromatica-rosemary-scalp-scrub	2026-11-13 10:14:16.041+05:30	2026-11-13 10:13:21.535+05:30	\N	published	2026-11-13 10:14:16.049+05:30	2026-11-13 10:14:16.049+05:30	t	f	\N	\N
273	24	100 ml	20	\N	t	2490	\N	5	new	f	aromatica-rosemary-root-enhancer	2026-11-13 10:14:16.089+05:30	2026-11-13 10:13:22.528+05:30	\N	published	2026-11-13 10:14:16.101+05:30	2026-11-13 10:14:16.101+05:30	t	f	\N	\N
274	25	400 ml	20	\N	t	2490	\N	5	new	f	aromatica-rosemary-scalp-scaling-shampoo	2026-11-13 10:14:16.136+05:30	2026-11-13 10:13:23.775+05:30	\N	published	2026-11-13 10:14:16.145+05:30	2026-11-13 10:14:16.145+05:30	t	f	\N	\N
275	26	750 ml	20	\N	t	2990	\N	5	none	f	labo-h-scalp-strengthening-shampoo	2026-11-13 10:14:16.175+05:30	2026-11-13 10:13:24.861+05:30	\N	published	2026-11-13 10:14:16.184+05:30	2026-11-13 10:14:16.184+05:30	t	f	\N	\N
276	27	500 ml	20	\N	t	1890	\N	5	none	f	illiyoon-ultra-repair-deep-moisture-wash	2026-11-13 10:14:16.218+05:30	2026-11-13 10:13:26.512+05:30	\N	published	2026-11-13 10:14:16.226+05:30	2026-11-13 10:14:16.226+05:30	t	f	\N	\N
277	28	500 ml	20	\N	t	1890	\N	5	none	f	illiyoon-ultra-moisture-scrub-wash	2026-11-13 10:14:16.256+05:30	2026-11-13 10:13:28.766+05:30	\N	published	2026-11-13 10:14:16.263+05:30	2026-11-13 10:14:16.263+05:30	t	f	\N	\N
228	54	\N	20	\N	t	2890	\N	5	none	f	merikit-regenerating-calming-mask	2026-11-13 10:14:05.18+05:30	2026-11-13 10:14:05.18+05:30	\N	published	2026-11-13 10:14:05.185+05:30	2026-11-13 10:14:05.185+05:30	f	f	\N	\N
235	55	\N	20	\N	t	390	\N	5	none	f	torriden-balanceful-cica-mask	2026-11-13 10:14:06.674+05:30	2026-11-13 10:14:06.61+05:30	\N	published	2026-11-13 10:14:06.682+05:30	2026-11-13 10:14:06.682+05:30	f	f	\N	\N
234	55	\N	20	\N	t	390	\N	5	none	f	torriden-balanceful-cica-mask	2026-11-13 10:14:06.655+05:30	2026-11-13 10:14:06.61+05:30	\N	published	2026-11-13 10:14:06.659+05:30	2026-11-13 10:14:06.659+05:30	f	f	\N	\N
239	56	\N	20	\N	t	350	\N	5	none	f	mediheal-collagen-mask	2026-11-13 10:14:07.936+05:30	2026-11-13 10:14:07.851+05:30	\N	published	2026-11-13 10:14:07.944+05:30	2026-11-13 10:14:07.944+05:30	f	f	\N	\N
238	56	\N	20	\N	t	350	\N	5	none	f	mediheal-collagen-mask	2026-11-13 10:14:07.901+05:30	2026-11-13 10:14:07.851+05:30	\N	published	2026-11-13 10:14:07.909+05:30	2026-11-13 10:14:07.909+05:30	f	f	\N	\N
243	57	\N	20	\N	t	490	\N	5	none	f	abib-gummy-sheet-mask-heartleaf-sticker	2026-11-13 10:14:09.056+05:30	2026-11-13 10:14:08.968+05:30	\N	published	2026-11-13 10:14:09.063+05:30	2026-11-13 10:14:09.063+05:30	f	f	\N	\N
242	57	\N	20	\N	t	490	\N	5	none	f	abib-gummy-sheet-mask-heartleaf-sticker	2026-11-13 10:14:09.029+05:30	2026-11-13 10:14:08.968+05:30	\N	published	2026-11-13 10:14:09.037+05:30	2026-11-13 10:14:09.037+05:30	f	f	\N	\N
247	58	\N	20	\N	t	350	\N	5	none	f	mediheal-vitamin-c-mask	2026-11-13 10:14:10.029+05:30	2026-11-13 10:14:09.937+05:30	\N	published	2026-11-13 10:14:10.04+05:30	2026-11-13 10:14:10.04+05:30	f	f	\N	\N
246	58	\N	20	\N	t	350	\N	5	none	f	mediheal-vitamin-c-mask	2026-11-13 10:14:09.999+05:30	2026-11-13 10:14:09.937+05:30	\N	published	2026-11-13 10:14:10.007+05:30	2026-11-13 10:14:10.007+05:30	f	f	\N	\N
251	59	\N	20	\N	t	1490	\N	5	none	f	torriden-solid-in-lip-essence	2026-11-13 10:14:11.035+05:30	2026-11-13 10:14:10.983+05:30	\N	published	2026-11-13 10:14:11.047+05:30	2026-11-13 10:14:11.047+05:30	f	f	\N	\N
250	59	\N	20	\N	t	1490	\N	5	none	f	torriden-solid-in-lip-essence	2026-11-13 10:14:11.02+05:30	2026-11-13 10:14:10.983+05:30	\N	published	2026-11-13 10:14:11.025+05:30	2026-11-13 10:14:11.025+05:30	f	f	\N	\N
255	60	20 g	20	\N	t	2290	\N	5	new	f	laneige-lip-sleeping-mask-peach-iced-tea	2026-11-13 10:14:12.231+05:30	2026-11-13 10:14:12.136+05:30	\N	published	2026-11-13 10:14:12.234+05:30	2026-11-13 10:14:12.234+05:30	f	f	\N	\N
256	61	\N	20	\N	t	6490	\N	5	none	f	round-lab-dokdo-hydration-routine	2026-11-13 10:14:13.162+05:30	2026-11-13 10:14:13.162+05:30	\N	published	2026-11-13 10:14:13.165+05:30	2026-11-13 10:14:13.165+05:30	f	f	\N	\N
257	61	\N	20	\N	t	6490	\N	5	none	f	round-lab-dokdo-hydration-routine	2026-11-13 10:14:13.174+05:30	2026-11-13 10:14:13.162+05:30	\N	published	2026-11-13 10:14:13.178+05:30	2026-11-13 10:14:13.178+05:30	f	f	\N	\N
263	62	\N	20	\N	t	8990	\N	5	none	f	korean-routine-set-clear-hydrated-protected	2026-11-13 10:14:14.622+05:30	2026-11-13 10:14:14.527+05:30	\N	published	2026-11-13 10:14:14.63+05:30	2026-11-13 10:14:14.63+05:30	f	f	\N	\N
262	62	\N	20	\N	t	8990	\N	5	none	f	korean-routine-set-clear-hydrated-protected	2026-11-13 10:14:14.593+05:30	2026-11-13 10:14:14.527+05:30	\N	published	2026-11-13 10:14:14.601+05:30	2026-11-13 10:14:14.601+05:30	f	f	\N	\N
267	63	\N	20	\N	t	8490	\N	5	none	f	korean-skincare-set-glow-gentle	2026-11-13 10:14:15.833+05:30	2026-11-13 10:14:15.757+05:30	\N	published	2026-11-13 10:14:15.842+05:30	2026-11-13 10:14:15.842+05:30	f	f	\N	\N
266	63	\N	20	\N	t	8490	\N	5	none	f	korean-skincare-set-glow-gentle	2026-11-13 10:14:15.806+05:30	2026-11-13 10:14:15.757+05:30	\N	published	2026-11-13 10:14:15.815+05:30	2026-11-13 10:14:15.815+05:30	f	f	\N	\N
278	29	350 ml	20	\N	t	2290	\N	5	none	f	illiyoon-ceramide-ato-lotion	2026-11-13 10:14:16.293+05:30	2026-11-13 10:13:30.847+05:30	\N	published	2026-11-13 10:14:16.307+05:30	2026-11-13 10:14:16.307+05:30	t	f	\N	\N
130	29	350 ml	20	\N	t	2290	\N	5	none	f	illiyoon-ceramide-ato-lotion	2026-11-13 10:13:30.922+05:30	2026-11-13 10:13:30.847+05:30	\N	published	2026-11-13 10:13:30.931+05:30	2026-11-13 10:13:30.931+05:30	f	f	\N	\N
279	30	\N	20	\N	t	1990	\N	5	none	f	illiyoon-ceramide-ato-6-0-top-to-toe-wash	2026-11-13 10:14:16.338+05:30	2026-11-13 10:13:32.129+05:30	\N	published	2026-11-13 10:14:16.346+05:30	2026-11-13 10:14:16.346+05:30	t	f	\N	\N
280	31	75 ml	20	\N	t	1690	\N	5	none	f	illiyoon-ceramide-ato-concentrate-cream	2026-11-13 10:14:16.386+05:30	2026-11-13 10:13:33.374+05:30	\N	published	2026-11-13 10:14:16.394+05:30	2026-11-13 10:14:16.394+05:30	t	f	\N	\N
281	32	\N	20	\N	t	2990	\N	5	bestseller	f	dr-althea-345-relief-cream	2026-11-13 10:14:16.429+05:30	2026-11-13 10:13:35.672+05:30	\N	published	2026-11-13 10:14:16.437+05:30	2026-11-13 10:14:16.437+05:30	t	f	\N	\N
282	33	100 ml	20	\N	t	2390	\N	5	none	f	purito-oat-in-calming-gel-cream	2026-11-13 10:14:16.475+05:30	2026-11-13 10:13:37.092+05:30	\N	published	2026-11-13 10:14:16.484+05:30	2026-11-13 10:14:16.484+05:30	t	f	\N	\N
283	34	100 g	20	\N	t	2490	\N	5	none	f	cosrx-advanced-snail-92-all-in-one-cream	2026-11-13 10:14:16.517+05:30	2026-11-13 10:13:38.42+05:30	\N	published	2026-11-13 10:14:16.526+05:30	2026-11-13 10:14:16.526+05:30	t	f	\N	\N
284	35	60 g	20	\N	t	2490	\N	5	none	f	some-by-mi-snail-truecica-miracle-repair-cream	2026-11-13 10:14:16.567+05:30	2026-11-13 10:13:39.556+05:30	\N	published	2026-11-13 10:14:16.576+05:30	2026-11-13 10:14:16.576+05:30	t	f	\N	\N
154	35	60 g	20	\N	t	2490	\N	5	none	f	some-by-mi-snail-truecica-miracle-repair-cream	2026-11-13 10:13:39.623+05:30	2026-11-13 10:13:39.556+05:30	\N	published	2026-11-13 10:13:39.631+05:30	2026-11-13 10:13:39.631+05:30	f	f	\N	\N
285	36	150 ml	20	\N	t	1890	\N	5	none	f	round-lab-mugwort-cleansing-foam	2026-11-13 10:14:16.618+05:30	2026-11-13 10:13:40.636+05:30	\N	published	2026-11-13 10:14:16.627+05:30	2026-11-13 10:14:16.627+05:30	t	f	\N	\N
286	37	150 ml	20	\N	t	1390	\N	5	bestseller	f	cosrx-low-ph-good-morning-gel-cleanser	2026-11-13 10:14:16.658+05:30	2026-11-13 10:13:42.112+05:30	\N	published	2026-11-13 10:14:16.666+05:30	2026-11-13 10:14:16.666+05:30	t	f	\N	\N
287	38	120 ml	20	\N	t	2290	\N	5	none	f	lagom-cellup-micro-foam-cleanser	2026-11-13 10:14:16.698+05:30	2026-11-13 10:13:43.693+05:30	\N	published	2026-11-13 10:14:16.706+05:30	2026-11-13 10:14:16.706+05:30	t	f	\N	\N
288	39	\N	20	\N	t	1990	\N	5	none	f	b-plain-mung-bean-cleansing-foam	2026-11-13 10:14:16.734+05:30	2026-11-13 10:13:45.314+05:30	\N	published	2026-11-13 10:14:16.745+05:30	2026-11-13 10:14:16.745+05:30	t	f	\N	\N
289	40	30 ml	20	\N	t	1290	\N	5	new	f	jipu-cleansing-balm	2026-11-13 10:14:16.791+05:30	2026-11-13 10:13:46.754+05:30	\N	published	2026-11-13 10:14:16.8+05:30	2026-11-13 10:14:16.8+05:30	t	f	\N	\N
290	41	150 g	20	\N	t	1490	\N	5	none	f	innisfree-green-tea-amino-hydrating-cleansing-foam	2026-11-13 10:14:16.832+05:30	2026-11-13 10:13:48.428+05:30	\N	published	2026-11-13 10:14:16.841+05:30	2026-11-13 10:14:16.841+05:30	t	f	\N	\N
178	41	150 g	20	\N	t	1490	\N	5	none	f	innisfree-green-tea-amino-hydrating-cleansing-foam	2026-11-13 10:13:48.518+05:30	2026-11-13 10:13:48.428+05:30	\N	published	2026-11-13 10:13:48.527+05:30	2026-11-13 10:13:48.527+05:30	f	f	\N	\N
291	42	50 ml	20	\N	t	2990	\N	5	none	f	mixsoon-bean-essence	2026-11-13 10:14:16.872+05:30	2026-11-13 10:13:49.419+05:30	\N	published	2026-11-13 10:14:16.88+05:30	2026-11-13 10:14:16.88+05:30	t	f	\N	\N
293	44	100 ml	20	\N	t	2490	\N	5	bestseller	f	cosrx-advanced-snail-96-mucin-power-essence	2026-11-13 10:14:16.951+05:30	2026-11-13 10:13:52.495+05:30	\N	published	2026-11-13 10:14:16.96+05:30	2026-11-13 10:14:16.96+05:30	t	f	\N	\N
294	45	60 pads	20	\N	t	2690	\N	5	none	f	anua-pdrn-hyaluronic-glow-pad	2026-11-13 10:14:16.991+05:30	2026-11-13 10:13:53.842+05:30	\N	published	2026-11-13 10:14:17+05:30	2026-11-13 10:14:17+05:30	t	f	\N	\N
295	46	80 ml	20	\N	t	3490	\N	5	none	f	innisfree-green-tea-seed-hyaluronic-serum	2026-11-13 10:14:17.031+05:30	2026-11-13 10:13:54.986+05:30	\N	published	2026-11-13 10:14:17.04+05:30	2026-11-13 10:14:17.04+05:30	t	f	\N	\N
296	47	\N	20	\N	t	2290	\N	5	none	f	beauty-of-joseon-revive-eye-serum-ginseng-retinal	2026-11-13 10:14:17.071+05:30	2026-11-13 10:13:56.304+05:30	\N	published	2026-11-13 10:14:17.08+05:30	2026-11-13 10:14:17.08+05:30	t	f	\N	\N
297	48	\N	20	\N	t	1990	\N	5	bestseller	f	beauty-of-joseon-glow-serum-propolis-niacinamide	2026-11-13 10:14:17.108+05:30	2026-11-13 10:13:57.595+05:30	\N	published	2026-11-13 10:14:17.112+05:30	2026-11-13 10:14:17.112+05:30	t	f	\N	\N
298	49	\N	20	\N	t	2490	\N	5	none	f	torriden-dive-in-serum	2026-11-13 10:14:17.128+05:30	2026-11-13 10:13:58.93+05:30	\N	published	2026-11-13 10:14:17.132+05:30	2026-11-13 10:14:17.132+05:30	t	f	\N	\N
299	50	30 ml	20	\N	t	2790	\N	5	none	f	anua-100-hyaluron-serum	2026-11-13 10:14:17.149+05:30	2026-11-13 10:14:00.083+05:30	\N	published	2026-11-13 10:14:17.157+05:30	2026-11-13 10:14:17.157+05:30	t	f	\N	\N
300	51	30 ml	20	\N	t	3490	\N	5	none	f	medicube-pdrn-pink-peptide-serum	2026-11-13 10:14:17.188+05:30	2026-11-13 10:14:01.286+05:30	\N	published	2026-11-13 10:14:17.204+05:30	2026-11-13 10:14:17.204+05:30	t	f	\N	\N
301	53	70 ml	20	\N	t	3290	\N	5	none	f	laneige-water-sleeping-mask	2026-11-13 10:14:17.239+05:30	2026-11-13 10:14:03.716+05:30	\N	published	2026-11-13 10:14:17.248+05:30	2026-11-13 10:14:17.248+05:30	t	f	\N	\N
224	53	70 ml	20	\N	t	3290	\N	5	none	f	laneige-water-sleeping-mask	2026-11-13 10:14:03.716+05:30	2026-11-13 10:14:03.716+05:30	\N	published	2026-11-13 10:14:03.728+05:30	2026-11-13 10:14:03.728+05:30	f	f	\N	\N
302	54	\N	20	\N	t	2890	\N	5	none	f	merikit-regenerating-calming-mask	2026-11-13 10:14:17.283+05:30	2026-11-13 10:14:05.18+05:30	\N	published	2026-11-13 10:14:17.292+05:30	2026-11-13 10:14:17.292+05:30	t	f	\N	\N
229	54	\N	20	\N	t	2890	\N	5	none	f	merikit-regenerating-calming-mask	2026-11-13 10:14:05.255+05:30	2026-11-13 10:14:05.18+05:30	\N	published	2026-11-13 10:14:05.264+05:30	2026-11-13 10:14:05.264+05:30	f	f	\N	\N
231	54	\N	20	\N	t	2890	\N	5	none	f	merikit-regenerating-calming-mask	2026-11-13 10:14:05.318+05:30	2026-11-13 10:14:05.18+05:30	\N	published	2026-11-13 10:14:05.327+05:30	2026-11-13 10:14:05.327+05:30	f	f	\N	\N
230	54	\N	20	\N	t	2890	\N	5	none	f	merikit-regenerating-calming-mask	2026-11-13 10:14:05.282+05:30	2026-11-13 10:14:05.18+05:30	\N	published	2026-11-13 10:14:05.291+05:30	2026-11-13 10:14:05.291+05:30	f	f	\N	\N
303	55	\N	20	\N	t	390	\N	5	none	f	torriden-balanceful-cica-mask	2026-11-13 10:14:17.324+05:30	2026-11-13 10:14:06.61+05:30	\N	published	2026-11-13 10:14:17.34+05:30	2026-11-13 10:14:17.34+05:30	t	f	\N	\N
304	56	\N	20	\N	t	350	\N	5	none	f	mediheal-collagen-mask	2026-11-13 10:14:17.369+05:30	2026-11-13 10:14:07.851+05:30	\N	published	2026-11-13 10:14:17.373+05:30	2026-11-13 10:14:17.373+05:30	t	f	\N	\N
305	57	\N	20	\N	t	490	\N	5	none	f	abib-gummy-sheet-mask-heartleaf-sticker	2026-11-13 10:14:17.398+05:30	2026-11-13 10:14:08.968+05:30	\N	published	2026-11-13 10:14:17.41+05:30	2026-11-13 10:14:17.41+05:30	t	f	\N	\N
306	58	\N	20	\N	t	350	\N	5	none	f	mediheal-vitamin-c-mask	2026-11-13 10:14:17.437+05:30	2026-11-13 10:14:09.937+05:30	\N	published	2026-11-13 10:14:17.445+05:30	2026-11-13 10:14:17.445+05:30	t	f	\N	\N
307	59	\N	20	\N	t	1490	\N	5	none	f	torriden-solid-in-lip-essence	2026-11-13 10:14:17.479+05:30	2026-11-13 10:14:10.983+05:30	\N	published	2026-11-13 10:14:17.49+05:30	2026-11-13 10:14:17.49+05:30	t	f	\N	\N
308	60	20 g	20	\N	t	2290	\N	5	new	f	laneige-lip-sleeping-mask-peach-iced-tea	2026-11-13 10:14:17.519+05:30	2026-11-13 10:14:12.136+05:30	\N	published	2026-11-13 10:14:17.532+05:30	2026-11-13 10:14:17.532+05:30	t	f	\N	\N
254	60	20 g	20	\N	t	2290	\N	5	new	f	laneige-lip-sleeping-mask-peach-iced-tea	2026-11-13 10:14:12.215+05:30	2026-11-13 10:14:12.136+05:30	\N	published	2026-11-13 10:14:12.22+05:30	2026-11-13 10:14:12.22+05:30	f	f	\N	\N
309	61	\N	20	\N	t	6490	\N	5	none	f	round-lab-dokdo-hydration-routine	2026-11-13 10:14:17.562+05:30	2026-11-13 10:14:13.162+05:30	\N	published	2026-11-13 10:14:17.57+05:30	2026-11-13 10:14:17.57+05:30	t	f	\N	\N
310	62	\N	20	\N	t	8990	\N	5	none	f	korean-routine-set-clear-hydrated-protected	2026-11-13 10:14:17.609+05:30	2026-11-13 10:14:14.527+05:30	\N	published	2026-11-13 10:14:17.617+05:30	2026-11-13 10:14:17.617+05:30	t	f	\N	\N
311	63	\N	20	\N	t	8490	\N	5	none	f	korean-skincare-set-glow-gentle	2026-11-13 10:14:17.641+05:30	2026-11-13 10:14:15.757+05:30	\N	published	2026-11-13 10:14:17.645+05:30	2026-11-13 10:14:17.645+05:30	t	f	\N	\N
292	43	250 ml	20	\N	t	2490	\N	5	bestseller	f	anua-heartleaf-77-soothing-toner	2026-11-13 10:14:16.912+05:30	2026-11-13 10:13:50.965+05:30	\N	published	2026-11-13 10:14:16.92+05:30	2026-11-13 10:14:16.92+05:30	f	f	\N	\N
\.


--
-- Data for Name: _products_v_locales; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public._products_v_locales (version_title, version_tagline, version_description, version_how_to_use, version_ingredients, id, _locale, _parent_id) FROM stdin;
Illiyoon Ceramide Ato Lotion	Body lotion	A light daily moisturising lotion with Illiyoon’s Ceramide Skin Complex to strengthen the skin barrier. It absorbs quickly without feeling sticky and keeps sensitive and dry skin moisturised for 24 hours. Fragrance-free and hypoallergenic.	Apply generously to slightly damp skin after showering.	Ceramide Skin Complex™. Fragrance-free, hypoallergenic.	445	en	128
Illiyoon Ceramide Ato Lotion	Körperlotion	Leichte, tägliche Feuchtigkeitspflege mit Ceramide Skin Complex™ zur Stärkung der Hautbarriere. Zieht schnell ein, klebt nicht und spendet 24 Stunden Feuchtigkeit für empfindliche und trockene Haut. Parfümfrei und hypoallergen.	Nach dem Duschen grosszügig auf die leicht feuchte Haut auftragen.	Ceramide Skin Complex™. Parfümfrei, hypoallergen.	446	de	129
Illiyoon Ceramide Ato Lotion	Body lotion	A light daily moisturising lotion with Illiyoon’s Ceramide Skin Complex to strengthen the skin barrier. It absorbs quickly without feeling sticky and keeps sensitive and dry skin moisturised for 24 hours. Fragrance-free and hypoallergenic.	Apply generously to slightly damp skin after showering.	Ceramide Skin Complex™. Fragrance-free, hypoallergenic.	447	en	129
Illiyoon Ceramide Ato Lotion	Körperlotion	Leichte, tägliche Feuchtigkeitspflege mit Ceramide Skin Complex™ zur Stärkung der Hautbarriere. Zieht schnell ein, klebt nicht und spendet 24 Stunden Feuchtigkeit für empfindliche und trockene Haut. Parfümfrei und hypoallergen.	Nach dem Duschen grosszügig auf die leicht feuchte Haut auftragen.	Ceramide Skin Complex™. Parfümfrei, hypoallergen.	448	de	130
Illiyoon Ceramide Ato Lotion	Lait corporel	Un lait hydratant léger au quotidien, avec le Ceramide Skin Complex™ d’Illiyoon pour renforcer la barrière cutanée. Il pénètre vite sans coller et hydrate 24 heures les peaux sensibles et sèches. Sans parfum et hypoallergénique.	Appliquer généreusement sur la peau légèrement humide après la douche.	Ceramide Skin Complex™. Sans parfum, hypoallergénique.	449	fr	130
Illiyoon Ceramide Ato Lotion	Body lotion	A light daily moisturising lotion with Illiyoon’s Ceramide Skin Complex to strengthen the skin barrier. It absorbs quickly without feeling sticky and keeps sensitive and dry skin moisturised for 24 hours. Fragrance-free and hypoallergenic.	Apply generously to slightly damp skin after showering.	Ceramide Skin Complex™. Fragrance-free, hypoallergenic.	450	en	130
Illiyoon Ceramide Ato Lotion	Körperlotion	Leichte, tägliche Feuchtigkeitspflege mit Ceramide Skin Complex™ zur Stärkung der Hautbarriere. Zieht schnell ein, klebt nicht und spendet 24 Stunden Feuchtigkeit für empfindliche und trockene Haut. Parfümfrei und hypoallergen.	Nach dem Duschen grosszügig auf die leicht feuchte Haut auftragen.	Ceramide Skin Complex™. Parfümfrei, hypoallergen.	451	de	131
Illiyoon Ceramide Ato Lotion	Lait corporel	Un lait hydratant léger au quotidien, avec le Ceramide Skin Complex™ d’Illiyoon pour renforcer la barrière cutanée. Il pénètre vite sans coller et hydrate 24 heures les peaux sensibles et sèches. Sans parfum et hypoallergénique.	Appliquer généreusement sur la peau légèrement humide après la douche.	Ceramide Skin Complex™. Sans parfum, hypoallergénique.	452	fr	131
Illiyoon Ceramide Ato Lotion	Lozione corpo	Una lozione idratante leggera per tutti i giorni, con il Ceramide Skin Complex™ di Illiyoon per rafforzare la barriera cutanea. Si assorbe in fretta senza appiccicare e idrata per 24 ore la pelle sensibile e secca. Senza profumo e ipoallergenica.	Applicare generosamente sulla pelle leggermente umida dopo la doccia.	Ceramide Skin Complex™. Senza profumo, ipoallergenica.	453	it	131
Illiyoon Ceramide Ato Lotion	Body lotion	A light daily moisturising lotion with Illiyoon’s Ceramide Skin Complex to strengthen the skin barrier. It absorbs quickly without feeling sticky and keeps sensitive and dry skin moisturised for 24 hours. Fragrance-free and hypoallergenic.	Apply generously to slightly damp skin after showering.	Ceramide Skin Complex™. Fragrance-free, hypoallergenic.	454	en	131
Illiyoon Ceramide Ato 6.0 Top to Toe Wash	Body wash	A mild, fragrance-free wash for hair and body, made for the whole family, including sensitive skin. Ceramides help strengthen the skin barrier while it cleanses gently and keeps skin hydrated. Dermatologically tested, made in Korea.	Lather on wet skin and rinse.	Ceramides. No added fragrance.	455	en	132
Illiyoon Ceramide Ato 6.0 Top to Toe Wash	Duschgel	Eine milde, parfümfreie Wäsche für Haar und Körper, für die ganze Familie und auch für empfindliche Haut. Ceramide stärken die Hautbarriere, während sie sanft reinigt und Feuchtigkeit spendet. Dermatologisch getestet, hergestellt in Korea.	Auf der nassen Haut aufschäumen und abspülen.	Ceramide. Ohne zugesetztes Parfüm.	456	de	133
Illiyoon Ceramide Ato 6.0 Top to Toe Wash	Body wash	A mild, fragrance-free wash for hair and body, made for the whole family, including sensitive skin. Ceramides help strengthen the skin barrier while it cleanses gently and keeps skin hydrated. Dermatologically tested, made in Korea.	Lather on wet skin and rinse.	Ceramides. No added fragrance.	457	en	133
Illiyoon Ceramide Ato 6.0 Top to Toe Wash	Duschgel	Eine milde, parfümfreie Wäsche für Haar und Körper, für die ganze Familie und auch für empfindliche Haut. Ceramide stärken die Hautbarriere, während sie sanft reinigt und Feuchtigkeit spendet. Dermatologisch getestet, hergestellt in Korea.	Auf der nassen Haut aufschäumen und abspülen.	Ceramide. Ohne zugesetztes Parfüm.	458	de	134
Illiyoon Ceramide Ato 6.0 Top to Toe Wash	Gel douche	Un nettoyant doux sans parfum pour les cheveux et le corps, pour toute la famille, y compris les peaux sensibles. Les céramides renforcent la barrière cutanée tout en nettoyant en douceur et en hydratant. Testé dermatologiquement, fabriqué en Corée.	Faire mousser sur peau mouillée puis rincer.	Céramides. Sans parfum ajouté.	459	fr	134
Illiyoon Ceramide Ato 6.0 Top to Toe Wash	Body wash	A mild, fragrance-free wash for hair and body, made for the whole family, including sensitive skin. Ceramides help strengthen the skin barrier while it cleanses gently and keeps skin hydrated. Dermatologically tested, made in Korea.	Lather on wet skin and rinse.	Ceramides. No added fragrance.	460	en	134
Illiyoon Ceramide Ato 6.0 Top to Toe Wash	Duschgel	Eine milde, parfümfreie Wäsche für Haar und Körper, für die ganze Familie und auch für empfindliche Haut. Ceramide stärken die Hautbarriere, während sie sanft reinigt und Feuchtigkeit spendet. Dermatologisch getestet, hergestellt in Korea.	Auf der nassen Haut aufschäumen und abspülen.	Ceramide. Ohne zugesetztes Parfüm.	461	de	135
Illiyoon Ceramide Ato 6.0 Top to Toe Wash	Gel douche	Un nettoyant doux sans parfum pour les cheveux et le corps, pour toute la famille, y compris les peaux sensibles. Les céramides renforcent la barrière cutanée tout en nettoyant en douceur et en hydratant. Testé dermatologiquement, fabriqué en Corée.	Faire mousser sur peau mouillée puis rincer.	Céramides. Sans parfum ajouté.	462	fr	135
Illiyoon Ceramide Ato 6.0 Top to Toe Wash	Bagnoschiuma	Un detergente delicato senza profumo per capelli e corpo, per tutta la famiglia e anche per pelli sensibili. Le ceramidi rafforzano la barriera cutanea mentre deterge delicatamente e idrata. Dermatologicamente testato, prodotto in Corea.	Emulsionare sulla pelle bagnata e risciacquare.	Ceramidi. Senza profumo aggiunto.	463	it	135
Illiyoon Ceramide Ato 6.0 Top to Toe Wash	Body wash	A mild, fragrance-free wash for hair and body, made for the whole family, including sensitive skin. Ceramides help strengthen the skin barrier while it cleanses gently and keeps skin hydrated. Dermatologically tested, made in Korea.	Lather on wet skin and rinse.	Ceramides. No added fragrance.	464	en	135
Illiyoon Ceramide Ato Concentrate Cream	Face cream	An intensive cream for sensitive skin with Illiyoon’s Ceramide Skin Complex to strengthen the skin barrier. It gives long-lasting moisture and suits dry and sensitive skin on face and body. Fragrance-free and gentle.	As the last step of your routine, morning and evening, smooth over face and neck.	Ceramide Skin Complex™. Fragrance-free.	465	en	136
Illiyoon Ceramide Ato Concentrate Cream	Gesichtscreme	Intensive Feuchtigkeit für empfindliche Haut, mit Ceramide Skin Complex™ zur Stärkung der Hautbarriere. Spendet langanhaltende Feuchtigkeit, ideal für trockene und empfindliche Haut. Parfümfrei und sanft.	Als letzten Schritt der Routine morgens und abends auf Gesicht und Hals verteilen.	Ceramide Skin Complex™. Parfümfrei.	466	de	137
Illiyoon Ceramide Ato Concentrate Cream	Face cream	An intensive cream for sensitive skin with Illiyoon’s Ceramide Skin Complex to strengthen the skin barrier. It gives long-lasting moisture and suits dry and sensitive skin on face and body. Fragrance-free and gentle.	As the last step of your routine, morning and evening, smooth over face and neck.	Ceramide Skin Complex™. Fragrance-free.	467	en	137
Illiyoon Ceramide Ato Concentrate Cream	Gesichtscreme	Intensive Feuchtigkeit für empfindliche Haut, mit Ceramide Skin Complex™ zur Stärkung der Hautbarriere. Spendet langanhaltende Feuchtigkeit, ideal für trockene und empfindliche Haut. Parfümfrei und sanft.	Als letzten Schritt der Routine morgens und abends auf Gesicht und Hals verteilen.	Ceramide Skin Complex™. Parfümfrei.	468	de	138
Illiyoon Ceramide Ato Concentrate Cream	Crème visage	Une crème intensive pour peaux sensibles, avec le Ceramide Skin Complex™ d’Illiyoon pour renforcer la barrière cutanée. Elle hydrate durablement les peaux sèches et sensibles du visage et du corps. Sans parfum et douce.	En dernière étape de la routine, matin et soir, appliquer sur le visage et le cou.	Ceramide Skin Complex™. Sans parfum.	469	fr	138
Illiyoon Ceramide Ato Concentrate Cream	Face cream	An intensive cream for sensitive skin with Illiyoon’s Ceramide Skin Complex to strengthen the skin barrier. It gives long-lasting moisture and suits dry and sensitive skin on face and body. Fragrance-free and gentle.	As the last step of your routine, morning and evening, smooth over face and neck.	Ceramide Skin Complex™. Fragrance-free.	470	en	138
Illiyoon Ceramide Ato Concentrate Cream	Gesichtscreme	Intensive Feuchtigkeit für empfindliche Haut, mit Ceramide Skin Complex™ zur Stärkung der Hautbarriere. Spendet langanhaltende Feuchtigkeit, ideal für trockene und empfindliche Haut. Parfümfrei und sanft.	Als letzten Schritt der Routine morgens und abends auf Gesicht und Hals verteilen.	Ceramide Skin Complex™. Parfümfrei.	471	de	139
Illiyoon Ceramide Ato Concentrate Cream	Crème visage	Une crème intensive pour peaux sensibles, avec le Ceramide Skin Complex™ d’Illiyoon pour renforcer la barrière cutanée. Elle hydrate durablement les peaux sèches et sensibles du visage et du corps. Sans parfum et douce.	En dernière étape de la routine, matin et soir, appliquer sur le visage et le cou.	Ceramide Skin Complex™. Sans parfum.	472	fr	139
Illiyoon Ceramide Ato Concentrate Cream	Crema viso	Una crema intensiva per pelli sensibili, con il Ceramide Skin Complex™ di Illiyoon per rafforzare la barriera cutanea. Idrata a lungo la pelle secca e sensibile di viso e corpo. Senza profumo e delicata.	Come ultimo passaggio della routine, mattina e sera, stendere su viso e collo.	Ceramide Skin Complex™. Senza profumo.	473	it	139
Illiyoon Ceramide Ato Concentrate Cream	Face cream	An intensive cream for sensitive skin with Illiyoon’s Ceramide Skin Complex to strengthen the skin barrier. It gives long-lasting moisture and suits dry and sensitive skin on face and body. Fragrance-free and gentle.	As the last step of your routine, morning and evening, smooth over face and neck.	Ceramide Skin Complex™. Fragrance-free.	474	en	139
Dr. Althea 345 Relief Cream	Face cream	A multi-tasking cream with the 3-4-5 formula: three key ingredients to soothe, four to care and five to protect. It calms irritation and redness, strengthens the skin barrier and supports regeneration with a light, non-sticky texture. For all skin types, including sensitive skin.	As the last step of your routine, morning and evening, smooth over face and neck.	Niacinamide, centella asiatica, madecassoside, ceramide NP, panthenol, hyaluronic acid, beta-glucan and plant extracts. Free from artificial fragrance, parabens and mineral oils.	475	en	140
Dr. Althea 345 Relief Cream	Gesichtscreme	Die multifunktionale Creme mit der 3-4-5 Formel: drei Schlüsselwirkstoffe für Beruhigung, vier für Pflege und fünf für Schutz. Beruhigt Irritationen und Rötungen, stärkt die Hautbarriere und fördert die Regeneration – leicht und nicht klebend. Für alle Hauttypen, auch für empfindliche Haut.	Als letzten Schritt der Routine morgens und abends auf Gesicht und Hals verteilen.	Niacinamid, Centella Asiatica, Madecassoside, Ceramid NP, Panthenol, Hyaluronsäure, Beta-Glucan und Pflanzenextrakte. Frei von künstlichen Duftstoffen, Parabenen und Mineralölen.	476	de	141
Dr. Althea 345 Relief Cream	Face cream	A multi-tasking cream with the 3-4-5 formula: three key ingredients to soothe, four to care and five to protect. It calms irritation and redness, strengthens the skin barrier and supports regeneration with a light, non-sticky texture. For all skin types, including sensitive skin.	As the last step of your routine, morning and evening, smooth over face and neck.	Niacinamide, centella asiatica, madecassoside, ceramide NP, panthenol, hyaluronic acid, beta-glucan and plant extracts. Free from artificial fragrance, parabens and mineral oils.	477	en	141
Dr. Althea 345 Relief Cream	Gesichtscreme	Die multifunktionale Creme mit der 3-4-5 Formel: drei Schlüsselwirkstoffe für Beruhigung, vier für Pflege und fünf für Schutz. Beruhigt Irritationen und Rötungen, stärkt die Hautbarriere und fördert die Regeneration – leicht und nicht klebend. Für alle Hauttypen, auch für empfindliche Haut.	Als letzten Schritt der Routine morgens und abends auf Gesicht und Hals verteilen.	Niacinamid, Centella Asiatica, Madecassoside, Ceramid NP, Panthenol, Hyaluronsäure, Beta-Glucan und Pflanzenextrakte. Frei von künstlichen Duftstoffen, Parabenen und Mineralölen.	478	de	142
Dr. Althea 345 Relief Cream	Crème visage	Une crème multifonction à la formule 3-4-5 : trois actifs pour apaiser, quatre pour soigner et cinq pour protéger. Elle calme irritations et rougeurs, renforce la barrière cutanée et favorise la régénération, avec une texture légère et non collante. Pour tous les types de peau, même sensibles.	En dernière étape de la routine, matin et soir, appliquer sur le visage et le cou.	Niacinamide, centella asiatica, madécassoside, céramide NP, panthénol, acide hyaluronique, bêta-glucane et extraits de plantes. Sans parfum artificiel, parabènes ni huiles minérales.	479	fr	142
Dr. Althea 345 Relief Cream	Face cream	A multi-tasking cream with the 3-4-5 formula: three key ingredients to soothe, four to care and five to protect. It calms irritation and redness, strengthens the skin barrier and supports regeneration with a light, non-sticky texture. For all skin types, including sensitive skin.	As the last step of your routine, morning and evening, smooth over face and neck.	Niacinamide, centella asiatica, madecassoside, ceramide NP, panthenol, hyaluronic acid, beta-glucan and plant extracts. Free from artificial fragrance, parabens and mineral oils.	480	en	142
Dr. Althea 345 Relief Cream	Gesichtscreme	Die multifunktionale Creme mit der 3-4-5 Formel: drei Schlüsselwirkstoffe für Beruhigung, vier für Pflege und fünf für Schutz. Beruhigt Irritationen und Rötungen, stärkt die Hautbarriere und fördert die Regeneration – leicht und nicht klebend. Für alle Hauttypen, auch für empfindliche Haut.	Als letzten Schritt der Routine morgens und abends auf Gesicht und Hals verteilen.	Niacinamid, Centella Asiatica, Madecassoside, Ceramid NP, Panthenol, Hyaluronsäure, Beta-Glucan und Pflanzenextrakte. Frei von künstlichen Duftstoffen, Parabenen und Mineralölen.	481	de	143
Dr. Althea 345 Relief Cream	Crème visage	Une crème multifonction à la formule 3-4-5 : trois actifs pour apaiser, quatre pour soigner et cinq pour protéger. Elle calme irritations et rougeurs, renforce la barrière cutanée et favorise la régénération, avec une texture légère et non collante. Pour tous les types de peau, même sensibles.	En dernière étape de la routine, matin et soir, appliquer sur le visage et le cou.	Niacinamide, centella asiatica, madécassoside, céramide NP, panthénol, acide hyaluronique, bêta-glucane et extraits de plantes. Sans parfum artificiel, parabènes ni huiles minérales.	482	fr	143
Dr. Althea 345 Relief Cream	Crema viso	Una crema multifunzione con la formula 3-4-5: tre attivi per lenire, quattro per curare e cinque per proteggere. Calma irritazioni e rossori, rafforza la barriera cutanea e favorisce la rigenerazione con una texture leggera e non appiccicosa. Per tutti i tipi di pelle, anche sensibile.	Come ultimo passaggio della routine, mattina e sera, stendere su viso e collo.	Niacinamide, centella asiatica, madecassoside, ceramide NP, pantenolo, acido ialuronico, beta-glucano ed estratti vegetali. Senza profumi artificiali, parabeni e oli minerali.	483	it	143
Dr. Althea 345 Relief Cream	Face cream	A multi-tasking cream with the 3-4-5 formula: three key ingredients to soothe, four to care and five to protect. It calms irritation and redness, strengthens the skin barrier and supports regeneration with a light, non-sticky texture. For all skin types, including sensitive skin.	As the last step of your routine, morning and evening, smooth over face and neck.	Niacinamide, centella asiatica, madecassoside, ceramide NP, panthenol, hyaluronic acid, beta-glucan and plant extracts. Free from artificial fragrance, parabens and mineral oils.	484	en	143
Purito Oat-In Calming Gel Cream	Gel cream	A soothing gel cream with oat water and oat extract that gives intense, long-lasting moisture. It calms irritation and redness, leaves a refreshing, cooling feel and strengthens the skin barrier. Light, non-sticky texture for sensitive, irritated and dry skin.	After cleansing and toning, smooth an even layer over face and neck, morning and evening.	Oat seed water, oat extract and squalane. Free from parabens, silicones, mineral oils and artificial colours.	485	en	144
Purito Oat-In Calming Gel Cream	Gel-Creme	Die beruhigende Gel-Creme mit Haferwasser und Haferextrakt spendet intensive Feuchtigkeit, mildert Rötungen und stärkt die natürliche Schutzbarriere. Kühlt angenehm, zieht schnell ein und klebt nicht. Ideal für empfindliche, gereizte und trockene Haut.	Nach Reinigung und Gesichtswasser morgens und abends gleichmässig auf Gesicht und Hals auftragen.	Haferwasser, Haferextrakt und Squalan. Frei von Parabenen, Silikonen, Mineralölen und künstlichen Farbstoffen.	486	de	145
Purito Oat-In Calming Gel Cream	Gel cream	A soothing gel cream with oat water and oat extract that gives intense, long-lasting moisture. It calms irritation and redness, leaves a refreshing, cooling feel and strengthens the skin barrier. Light, non-sticky texture for sensitive, irritated and dry skin.	After cleansing and toning, smooth an even layer over face and neck, morning and evening.	Oat seed water, oat extract and squalane. Free from parabens, silicones, mineral oils and artificial colours.	487	en	145
Purito Oat-In Calming Gel Cream	Gel-Creme	Die beruhigende Gel-Creme mit Haferwasser und Haferextrakt spendet intensive Feuchtigkeit, mildert Rötungen und stärkt die natürliche Schutzbarriere. Kühlt angenehm, zieht schnell ein und klebt nicht. Ideal für empfindliche, gereizte und trockene Haut.	Nach Reinigung und Gesichtswasser morgens und abends gleichmässig auf Gesicht und Hals auftragen.	Haferwasser, Haferextrakt und Squalan. Frei von Parabenen, Silikonen, Mineralölen und künstlichen Farbstoffen.	488	de	146
Purito Oat-In Calming Gel Cream	Gel-crème	Un gel-crème apaisant à l’eau et à l’extrait d’avoine qui hydrate intensément et durablement. Il calme irritations et rougeurs, procure une sensation de fraîcheur et renforce la barrière cutanée. Texture légère et non collante pour peaux sensibles, irritées et sèches.	Après le nettoyage et la lotion, appliquer une couche uniforme sur le visage et le cou, matin et soir.	Eau d’avoine, extrait d’avoine et squalane. Sans parabènes, silicones, huiles minérales ni colorants artificiels.	489	fr	146
Purito Oat-In Calming Gel Cream	Gel cream	A soothing gel cream with oat water and oat extract that gives intense, long-lasting moisture. It calms irritation and redness, leaves a refreshing, cooling feel and strengthens the skin barrier. Light, non-sticky texture for sensitive, irritated and dry skin.	After cleansing and toning, smooth an even layer over face and neck, morning and evening.	Oat seed water, oat extract and squalane. Free from parabens, silicones, mineral oils and artificial colours.	490	en	146
Purito Oat-In Calming Gel Cream	Gel-Creme	Die beruhigende Gel-Creme mit Haferwasser und Haferextrakt spendet intensive Feuchtigkeit, mildert Rötungen und stärkt die natürliche Schutzbarriere. Kühlt angenehm, zieht schnell ein und klebt nicht. Ideal für empfindliche, gereizte und trockene Haut.	Nach Reinigung und Gesichtswasser morgens und abends gleichmässig auf Gesicht und Hals auftragen.	Haferwasser, Haferextrakt und Squalan. Frei von Parabenen, Silikonen, Mineralölen und künstlichen Farbstoffen.	491	de	147
Purito Oat-In Calming Gel Cream	Gel-crème	Un gel-crème apaisant à l’eau et à l’extrait d’avoine qui hydrate intensément et durablement. Il calme irritations et rougeurs, procure une sensation de fraîcheur et renforce la barrière cutanée. Texture légère et non collante pour peaux sensibles, irritées et sèches.	Après le nettoyage et la lotion, appliquer une couche uniforme sur le visage et le cou, matin et soir.	Eau d’avoine, extrait d’avoine et squalane. Sans parabènes, silicones, huiles minérales ni colorants artificiels.	492	fr	147
Purito Oat-In Calming Gel Cream	Gel crema	Un gel crema lenitivo con acqua e estratto d’avena che idrata intensamente e a lungo. Calma irritazioni e rossori, rinfresca e rafforza la barriera cutanea. Texture leggera e non appiccicosa per pelli sensibili, irritate e secche.	Dopo detersione e tonico, stendere uno strato uniforme su viso e collo, mattina e sera.	Acqua d’avena, estratto d’avena e squalano. Senza parabeni, siliconi, oli minerali e coloranti artificiali.	493	it	147
Purito Oat-In Calming Gel Cream	Gel cream	A soothing gel cream with oat water and oat extract that gives intense, long-lasting moisture. It calms irritation and redness, leaves a refreshing, cooling feel and strengthens the skin barrier. Light, non-sticky texture for sensitive, irritated and dry skin.	After cleansing and toning, smooth an even layer over face and neck, morning and evening.	Oat seed water, oat extract and squalane. Free from parabens, silicones, mineral oils and artificial colours.	494	en	147
COSRX Advanced Snail 92 All in One Cream	Face cream	A daily all-in-one cream with 92 % snail secretion filtrate for healthy, radiant skin. It gives intense moisture, supports regeneration and strengthens the skin barrier, with a light texture that absorbs quickly. Suitable for all skin types.	As the last step of your routine, morning and evening, smooth over face and neck.	92 % snail secretion filtrate (mucin).	495	en	148
COSRX Advanced Snail 92 All in One Cream	Gesichtscreme	Tägliche Pflege für gesunde, strahlende Haut mit 92 % Schneckensekret-Filtrat. Spendet intensive Feuchtigkeit, unterstützt die Regeneration und stärkt die Hautbarriere – mit leichter Textur, die schnell einzieht. Für alle Hauttypen.	Als letzten Schritt der Routine morgens und abends auf Gesicht und Hals verteilen.	92 % Schneckensekret-Filtrat (Mucin).	496	de	149
COSRX Advanced Snail 92 All in One Cream	Face cream	A daily all-in-one cream with 92 % snail secretion filtrate for healthy, radiant skin. It gives intense moisture, supports regeneration and strengthens the skin barrier, with a light texture that absorbs quickly. Suitable for all skin types.	As the last step of your routine, morning and evening, smooth over face and neck.	92 % snail secretion filtrate (mucin).	497	en	149
COSRX Advanced Snail 92 All in One Cream	Gesichtscreme	Tägliche Pflege für gesunde, strahlende Haut mit 92 % Schneckensekret-Filtrat. Spendet intensive Feuchtigkeit, unterstützt die Regeneration und stärkt die Hautbarriere – mit leichter Textur, die schnell einzieht. Für alle Hauttypen.	Als letzten Schritt der Routine morgens und abends auf Gesicht und Hals verteilen.	92 % Schneckensekret-Filtrat (Mucin).	498	de	150
COSRX Advanced Snail 92 All in One Cream	Crème visage	Une crème tout-en-un au quotidien avec 92 % de filtrat de bave d’escargot pour une peau saine et lumineuse. Elle hydrate intensément, soutient la régénération et renforce la barrière cutanée, avec une texture légère qui pénètre vite. Pour tous les types de peau.	En dernière étape de la routine, matin et soir, appliquer sur le visage et le cou.	92 % de filtrat de bave d’escargot (mucine).	499	fr	150
COSRX Advanced Snail 92 All in One Cream	Face cream	A daily all-in-one cream with 92 % snail secretion filtrate for healthy, radiant skin. It gives intense moisture, supports regeneration and strengthens the skin barrier, with a light texture that absorbs quickly. Suitable for all skin types.	As the last step of your routine, morning and evening, smooth over face and neck.	92 % snail secretion filtrate (mucin).	500	en	150
COSRX Advanced Snail 92 All in One Cream	Gesichtscreme	Tägliche Pflege für gesunde, strahlende Haut mit 92 % Schneckensekret-Filtrat. Spendet intensive Feuchtigkeit, unterstützt die Regeneration und stärkt die Hautbarriere – mit leichter Textur, die schnell einzieht. Für alle Hauttypen.	Als letzten Schritt der Routine morgens und abends auf Gesicht und Hals verteilen.	92 % Schneckensekret-Filtrat (Mucin).	501	de	151
COSRX Advanced Snail 92 All in One Cream	Crème visage	Une crème tout-en-un au quotidien avec 92 % de filtrat de bave d’escargot pour une peau saine et lumineuse. Elle hydrate intensément, soutient la régénération et renforce la barrière cutanée, avec une texture légère qui pénètre vite. Pour tous les types de peau.	En dernière étape de la routine, matin et soir, appliquer sur le visage et le cou.	92 % de filtrat de bave d’escargot (mucine).	502	fr	151
COSRX Advanced Snail 92 All in One Cream	Crema viso	Una crema tutto-in-uno quotidiana con il 92 % di filtrato di bava di lumaca per una pelle sana e luminosa. Idrata intensamente, sostiene la rigenerazione e rafforza la barriera cutanea con una texture leggera che si assorbe in fretta. Per tutti i tipi di pelle.	Come ultimo passaggio della routine, mattina e sera, stendere su viso e collo.	92 % di filtrato di bava di lumaca (mucina).	503	it	151
COSRX Advanced Snail 92 All in One Cream	Face cream	A daily all-in-one cream with 92 % snail secretion filtrate for healthy, radiant skin. It gives intense moisture, supports regeneration and strengthens the skin barrier, with a light texture that absorbs quickly. Suitable for all skin types.	As the last step of your routine, morning and evening, smooth over face and neck.	92 % snail secretion filtrate (mucin).	504	en	151
Some By Mi Snail Truecica Miracle Repair Cream	Face cream	A regenerating and protective cream for healthy, radiant skin. 42 % Snail Truecica™ repairs damaged skin and gives intense moisture, while five types of ceramides strengthen the skin barrier. Dermatologically tested and suitable for sensitive skin.	As the last step of your routine, morning and evening, smooth over face and neck.	42 % Snail Truecica™ and 5 types of ceramides.	505	en	152
Some By Mi Snail Truecica Miracle Repair Cream	Gesichtscreme	Regeneration und Schutz für eine gesunde, strahlende Haut. 42 % Snail Truecica™ regeneriert und spendet Feuchtigkeit, fünf Arten von Ceramiden stärken die Hautbarriere. Leichte Textur, zieht schnell ein. Dermatologisch getestet und für empfindliche Haut geeignet.	Als letzten Schritt der Routine morgens und abends auf Gesicht und Hals verteilen.	42 % Snail Truecica™ und 5 Arten von Ceramiden.	506	de	153
Some By Mi Snail Truecica Miracle Repair Cream	Face cream	A regenerating and protective cream for healthy, radiant skin. 42 % Snail Truecica™ repairs damaged skin and gives intense moisture, while five types of ceramides strengthen the skin barrier. Dermatologically tested and suitable for sensitive skin.	As the last step of your routine, morning and evening, smooth over face and neck.	42 % Snail Truecica™ and 5 types of ceramides.	507	en	153
Some By Mi Snail Truecica Miracle Repair Cream	Gesichtscreme	Regeneration und Schutz für eine gesunde, strahlende Haut. 42 % Snail Truecica™ regeneriert und spendet Feuchtigkeit, fünf Arten von Ceramiden stärken die Hautbarriere. Leichte Textur, zieht schnell ein. Dermatologisch getestet und für empfindliche Haut geeignet.	Als letzten Schritt der Routine morgens und abends auf Gesicht und Hals verteilen.	42 % Snail Truecica™ und 5 Arten von Ceramiden.	508	de	154
Some By Mi Snail Truecica Miracle Repair Cream	Crème visage	Une crème régénérante et protectrice pour une peau saine et lumineuse. 42 % de Snail Truecica™ répare et hydrate intensément, tandis que cinq types de céramides renforcent la barrière cutanée. Testée dermatologiquement, convient aux peaux sensibles.	En dernière étape de la routine, matin et soir, appliquer sur le visage et le cou.	42 % de Snail Truecica™ et 5 types de céramides.	509	fr	154
Some By Mi Snail Truecica Miracle Repair Cream	Face cream	A regenerating and protective cream for healthy, radiant skin. 42 % Snail Truecica™ repairs damaged skin and gives intense moisture, while five types of ceramides strengthen the skin barrier. Dermatologically tested and suitable for sensitive skin.	As the last step of your routine, morning and evening, smooth over face and neck.	42 % Snail Truecica™ and 5 types of ceramides.	510	en	154
Some By Mi Snail Truecica Miracle Repair Cream	Gesichtscreme	Regeneration und Schutz für eine gesunde, strahlende Haut. 42 % Snail Truecica™ regeneriert und spendet Feuchtigkeit, fünf Arten von Ceramiden stärken die Hautbarriere. Leichte Textur, zieht schnell ein. Dermatologisch getestet und für empfindliche Haut geeignet.	Als letzten Schritt der Routine morgens und abends auf Gesicht und Hals verteilen.	42 % Snail Truecica™ und 5 Arten von Ceramiden.	511	de	155
Some By Mi Snail Truecica Miracle Repair Cream	Crème visage	Une crème régénérante et protectrice pour une peau saine et lumineuse. 42 % de Snail Truecica™ répare et hydrate intensément, tandis que cinq types de céramides renforcent la barrière cutanée. Testée dermatologiquement, convient aux peaux sensibles.	En dernière étape de la routine, matin et soir, appliquer sur le visage et le cou.	42 % de Snail Truecica™ et 5 types de céramides.	512	fr	155
Some By Mi Snail Truecica Miracle Repair Cream	Crema viso	Una crema rigenerante e protettiva per una pelle sana e luminosa. Il 42 % di Snail Truecica™ ripara e idrata intensamente, mentre cinque tipi di ceramidi rafforzano la barriera cutanea. Dermatologicamente testata, adatta alle pelli sensibili.	Come ultimo passaggio della routine, mattina e sera, stendere su viso e collo.	42 % di Snail Truecica™ e 5 tipi di ceramidi.	513	it	155
Some By Mi Snail Truecica Miracle Repair Cream	Face cream	A regenerating and protective cream for healthy, radiant skin. 42 % Snail Truecica™ repairs damaged skin and gives intense moisture, while five types of ceramides strengthen the skin barrier. Dermatologically tested and suitable for sensitive skin.	As the last step of your routine, morning and evening, smooth over face and neck.	42 % Snail Truecica™ and 5 types of ceramides.	514	en	155
Round Lab Mugwort Cleansing Foam	Cleansing foam	A gentle cleansing foam with mugwort extract that cleanses deeply while calming sensitive skin. Its dense foam removes impurities, excess oil and make-up residue without drying, and supports the natural protective barrier. For all skin types, especially sensitive and blemish-prone skin.	Lather a small amount with water, massage over damp skin and rinse with lukewarm water.	Mugwort extract. Free from parabens, silicones, mineral oils, artificial colours and PEGs.	515	en	156
Round Lab Mugwort Cleansing Foam	Reinigungsschaum	Sanfte Reinigung, die beruhigt und schützt. Der Reinigungsschaum mit Beifussextrakt reinigt porentief, entfernt Unreinheiten, überschüssigen Talg und Make-up-Reste, ohne auszutrocknen, und stärkt die natürliche Schutzbarriere. Für alle Hauttypen, besonders für empfindliche und zu Unreinheiten neigende Haut.	Eine kleine Menge mit Wasser aufschäumen, auf der feuchten Haut einmassieren und mit lauwarmem Wasser abspülen.	Beifussextrakt. Frei von Parabenen, Silikonen, Mineralölen, künstlichen Farbstoffen und PEGs.	516	de	157
Round Lab Mugwort Cleansing Foam	Cleansing foam	A gentle cleansing foam with mugwort extract that cleanses deeply while calming sensitive skin. Its dense foam removes impurities, excess oil and make-up residue without drying, and supports the natural protective barrier. For all skin types, especially sensitive and blemish-prone skin.	Lather a small amount with water, massage over damp skin and rinse with lukewarm water.	Mugwort extract. Free from parabens, silicones, mineral oils, artificial colours and PEGs.	517	en	157
Round Lab Mugwort Cleansing Foam	Reinigungsschaum	Sanfte Reinigung, die beruhigt und schützt. Der Reinigungsschaum mit Beifussextrakt reinigt porentief, entfernt Unreinheiten, überschüssigen Talg und Make-up-Reste, ohne auszutrocknen, und stärkt die natürliche Schutzbarriere. Für alle Hauttypen, besonders für empfindliche und zu Unreinheiten neigende Haut.	Eine kleine Menge mit Wasser aufschäumen, auf der feuchten Haut einmassieren und mit lauwarmem Wasser abspülen.	Beifussextrakt. Frei von Parabenen, Silikonen, Mineralölen, künstlichen Farbstoffen und PEGs.	518	de	158
Round Lab Mugwort Cleansing Foam	Mousse nettoyante	Une mousse nettoyante douce à l’extrait d’armoise qui nettoie en profondeur tout en apaisant. Sa mousse dense élimine impuretés, excès de sébum et résidus de maquillage sans dessécher et soutient la barrière naturelle. Pour tous les types de peau, en particulier sensibles et à imperfections.	Faire mousser une petite quantité avec de l’eau, masser sur peau humide et rincer à l’eau tiède.	Extrait d’armoise. Sans parabènes, silicones, huiles minérales, colorants artificiels ni PEG.	519	fr	158
Round Lab Mugwort Cleansing Foam	Cleansing foam	A gentle cleansing foam with mugwort extract that cleanses deeply while calming sensitive skin. Its dense foam removes impurities, excess oil and make-up residue without drying, and supports the natural protective barrier. For all skin types, especially sensitive and blemish-prone skin.	Lather a small amount with water, massage over damp skin and rinse with lukewarm water.	Mugwort extract. Free from parabens, silicones, mineral oils, artificial colours and PEGs.	520	en	158
Round Lab Mugwort Cleansing Foam	Reinigungsschaum	Sanfte Reinigung, die beruhigt und schützt. Der Reinigungsschaum mit Beifussextrakt reinigt porentief, entfernt Unreinheiten, überschüssigen Talg und Make-up-Reste, ohne auszutrocknen, und stärkt die natürliche Schutzbarriere. Für alle Hauttypen, besonders für empfindliche und zu Unreinheiten neigende Haut.	Eine kleine Menge mit Wasser aufschäumen, auf der feuchten Haut einmassieren und mit lauwarmem Wasser abspülen.	Beifussextrakt. Frei von Parabenen, Silikonen, Mineralölen, künstlichen Farbstoffen und PEGs.	521	de	159
Anua PDRN Hyaluronic Glow Pad	Toner pads	Toner pads with PDRN and hyaluronic acid for radiant, hydrated and calm skin every day. They give deep hydration, refine the skin texture for a natural glow and soothe sensitive skin. One pad, one step: perfect for a quick daily routine.	After cleansing, sweep a pad over the face and pat the remaining essence into the skin.	PDRN and hyaluronic acid.	610	en	194
Round Lab Mugwort Cleansing Foam	Mousse nettoyante	Une mousse nettoyante douce à l’extrait d’armoise qui nettoie en profondeur tout en apaisant. Sa mousse dense élimine impuretés, excès de sébum et résidus de maquillage sans dessécher et soutient la barrière naturelle. Pour tous les types de peau, en particulier sensibles et à imperfections.	Faire mousser une petite quantité avec de l’eau, masser sur peau humide et rincer à l’eau tiède.	Extrait d’armoise. Sans parabènes, silicones, huiles minérales, colorants artificiels ni PEG.	522	fr	159
Round Lab Mugwort Cleansing Foam	Schiuma detergente	Una schiuma detergente delicata all’estratto di artemisia che pulisce in profondità e lenisce. La schiuma densa rimuove impurità, sebo in eccesso e residui di trucco senza seccare e sostiene la barriera naturale. Per tutti i tipi di pelle, soprattutto sensibili e con imperfezioni.	Emulsionare una piccola quantità con acqua, massaggiare sulla pelle umida e risciacquare con acqua tiepida.	Estratto di artemisia. Senza parabeni, siliconi, oli minerali, coloranti artificiali e PEG.	523	it	159
Round Lab Mugwort Cleansing Foam	Cleansing foam	A gentle cleansing foam with mugwort extract that cleanses deeply while calming sensitive skin. Its dense foam removes impurities, excess oil and make-up residue without drying, and supports the natural protective barrier. For all skin types, especially sensitive and blemish-prone skin.	Lather a small amount with water, massage over damp skin and rinse with lukewarm water.	Mugwort extract. Free from parabens, silicones, mineral oils, artificial colours and PEGs.	524	en	159
COSRX Low pH Good Morning Gel Cleanser	Gel cleanser	A mild, low-pH gel cleanser for a fresh start to the day. With a pH of about 5.0 it cleanses thoroughly without drying, respects the skin’s natural barrier and removes excess oil and impurities. Tea tree oil and botanical extracts keep skin calm and clear.	Massage a small amount over damp skin, morning and evening, and rinse with lukewarm water.	Tea tree oil and botanical extracts, pH about 5.0. Free from parabens, silicones, artificial colours and mineral oils.	525	en	160
COSRX Low pH Good Morning Gel Cleanser	Gel-Reiniger	Sanfte Reinigung für einen frischen Start in den Tag. Mit einem pH-Wert von ca. 5,0 reinigt der Gel-Reiniger gründlich, ohne auszutrocknen, bewahrt die natürliche Schutzbarriere und entfernt Talg und Unreinheiten. Teebaumöl und botanische Extrakte sorgen für eine ruhige, klare Haut.	Morgens und abends eine kleine Menge auf der feuchten Haut einmassieren und mit lauwarmem Wasser abspülen.	Teebaumöl und botanische Extrakte, pH-Wert ca. 5,0. Frei von Parabenen, Silikonen, künstlichen Farbstoffen und Mineralölen.	526	de	161
COSRX Low pH Good Morning Gel Cleanser	Gel cleanser	A mild, low-pH gel cleanser for a fresh start to the day. With a pH of about 5.0 it cleanses thoroughly without drying, respects the skin’s natural barrier and removes excess oil and impurities. Tea tree oil and botanical extracts keep skin calm and clear.	Massage a small amount over damp skin, morning and evening, and rinse with lukewarm water.	Tea tree oil and botanical extracts, pH about 5.0. Free from parabens, silicones, artificial colours and mineral oils.	527	en	161
COSRX Low pH Good Morning Gel Cleanser	Gel-Reiniger	Sanfte Reinigung für einen frischen Start in den Tag. Mit einem pH-Wert von ca. 5,0 reinigt der Gel-Reiniger gründlich, ohne auszutrocknen, bewahrt die natürliche Schutzbarriere und entfernt Talg und Unreinheiten. Teebaumöl und botanische Extrakte sorgen für eine ruhige, klare Haut.	Morgens und abends eine kleine Menge auf der feuchten Haut einmassieren und mit lauwarmem Wasser abspülen.	Teebaumöl und botanische Extrakte, pH-Wert ca. 5,0. Frei von Parabenen, Silikonen, künstlichen Farbstoffen und Mineralölen.	528	de	162
COSRX Low pH Good Morning Gel Cleanser	Gel nettoyant	Un gel nettoyant doux au pH bas pour bien commencer la journée. Avec un pH d’environ 5,0, il nettoie en profondeur sans dessécher, respecte la barrière naturelle et élimine sébum et impuretés. L’huile d’arbre à thé et des extraits botaniques gardent la peau calme et nette.	Matin et soir, masser une petite quantité sur peau humide et rincer à l’eau tiède.	Huile d’arbre à thé et extraits botaniques, pH d’environ 5,0. Sans parabènes, silicones, colorants artificiels ni huiles minérales.	529	fr	162
COSRX Low pH Good Morning Gel Cleanser	Gel cleanser	A mild, low-pH gel cleanser for a fresh start to the day. With a pH of about 5.0 it cleanses thoroughly without drying, respects the skin’s natural barrier and removes excess oil and impurities. Tea tree oil and botanical extracts keep skin calm and clear.	Massage a small amount over damp skin, morning and evening, and rinse with lukewarm water.	Tea tree oil and botanical extracts, pH about 5.0. Free from parabens, silicones, artificial colours and mineral oils.	530	en	162
COSRX Low pH Good Morning Gel Cleanser	Gel-Reiniger	Sanfte Reinigung für einen frischen Start in den Tag. Mit einem pH-Wert von ca. 5,0 reinigt der Gel-Reiniger gründlich, ohne auszutrocknen, bewahrt die natürliche Schutzbarriere und entfernt Talg und Unreinheiten. Teebaumöl und botanische Extrakte sorgen für eine ruhige, klare Haut.	Morgens und abends eine kleine Menge auf der feuchten Haut einmassieren und mit lauwarmem Wasser abspülen.	Teebaumöl und botanische Extrakte, pH-Wert ca. 5,0. Frei von Parabenen, Silikonen, künstlichen Farbstoffen und Mineralölen.	531	de	163
COSRX Low pH Good Morning Gel Cleanser	Gel nettoyant	Un gel nettoyant doux au pH bas pour bien commencer la journée. Avec un pH d’environ 5,0, il nettoie en profondeur sans dessécher, respecte la barrière naturelle et élimine sébum et impuretés. L’huile d’arbre à thé et des extraits botaniques gardent la peau calme et nette.	Matin et soir, masser une petite quantité sur peau humide et rincer à l’eau tiède.	Huile d’arbre à thé et extraits botaniques, pH d’environ 5,0. Sans parabènes, silicones, colorants artificiels ni huiles minérales.	532	fr	163
COSRX Low pH Good Morning Gel Cleanser	Gel detergente	Un gel detergente delicato a pH basso per iniziare bene la giornata. Con un pH di circa 5,0 deterge a fondo senza seccare, rispetta la barriera naturale e rimuove sebo e impurità. Olio di tea tree ed estratti botanici mantengono la pelle calma e pulita.	Mattina e sera massaggiare una piccola quantità sulla pelle umida e risciacquare con acqua tiepida.	Olio di tea tree ed estratti botanici, pH circa 5,0. Senza parabeni, siliconi, coloranti artificiali e oli minerali.	533	it	163
COSRX Low pH Good Morning Gel Cleanser	Gel cleanser	A mild, low-pH gel cleanser for a fresh start to the day. With a pH of about 5.0 it cleanses thoroughly without drying, respects the skin’s natural barrier and removes excess oil and impurities. Tea tree oil and botanical extracts keep skin calm and clear.	Massage a small amount over damp skin, morning and evening, and rinse with lukewarm water.	Tea tree oil and botanical extracts, pH about 5.0. Free from parabens, silicones, artificial colours and mineral oils.	534	en	163
Lagom Cellup Micro Foam Cleanser	Cleansing foam	A gentle micro-foam cleanser for beautifully clear skin. Its fine foam cleanses pores and removes dirt and excess oil, while the pH-neutral formula keeps skin moisturised and balanced. Gentle enough for daily use, even on sensitive skin.	Lather a small amount with water, massage over damp skin and rinse with lukewarm water.	Plant-based surfactants and moisturising agents. pH-neutral.	535	en	164
Lagom Cellup Micro Foam Cleanser	Reinigungsschaum	Sanfte Reinigung für strahlend schöne Haut. Die Mikro-Schaum-Technologie reinigt porentief und entfernt Schmutz und überschüssiges Öl, die pH-hautneutrale Formel bewahrt die natürliche Feuchtigkeitsbalance. Täglich anwendbar, auch bei sensibler Haut.	Eine kleine Menge mit Wasser aufschäumen, auf der feuchten Haut einmassieren und mit lauwarmem Wasser abspülen.	Pflanzliche Tenside und Feuchtigkeitsspender. pH-hautneutral.	536	de	165
Lagom Cellup Micro Foam Cleanser	Cleansing foam	A gentle micro-foam cleanser for beautifully clear skin. Its fine foam cleanses pores and removes dirt and excess oil, while the pH-neutral formula keeps skin moisturised and balanced. Gentle enough for daily use, even on sensitive skin.	Lather a small amount with water, massage over damp skin and rinse with lukewarm water.	Plant-based surfactants and moisturising agents. pH-neutral.	537	en	165
Lagom Cellup Micro Foam Cleanser	Reinigungsschaum	Sanfte Reinigung für strahlend schöne Haut. Die Mikro-Schaum-Technologie reinigt porentief und entfernt Schmutz und überschüssiges Öl, die pH-hautneutrale Formel bewahrt die natürliche Feuchtigkeitsbalance. Täglich anwendbar, auch bei sensibler Haut.	Eine kleine Menge mit Wasser aufschäumen, auf der feuchten Haut einmassieren und mit lauwarmem Wasser abspülen.	Pflanzliche Tenside und Feuchtigkeitsspender. pH-hautneutral.	538	de	166
Lagom Cellup Micro Foam Cleanser	Mousse nettoyante	Une mousse micro-bulles douce pour une peau nette et lumineuse. Sa mousse fine nettoie les pores et élimine impuretés et excès de sébum, tandis que la formule au pH neutre préserve l’hydratation. Assez douce pour un usage quotidien, même sur peau sensible.	Faire mousser une petite quantité avec de l’eau, masser sur peau humide et rincer à l’eau tiède.	Tensioactifs végétaux et agents hydratants. pH neutre.	539	fr	166
Lagom Cellup Micro Foam Cleanser	Cleansing foam	A gentle micro-foam cleanser for beautifully clear skin. Its fine foam cleanses pores and removes dirt and excess oil, while the pH-neutral formula keeps skin moisturised and balanced. Gentle enough for daily use, even on sensitive skin.	Lather a small amount with water, massage over damp skin and rinse with lukewarm water.	Plant-based surfactants and moisturising agents. pH-neutral.	540	en	166
Lagom Cellup Micro Foam Cleanser	Reinigungsschaum	Sanfte Reinigung für strahlend schöne Haut. Die Mikro-Schaum-Technologie reinigt porentief und entfernt Schmutz und überschüssiges Öl, die pH-hautneutrale Formel bewahrt die natürliche Feuchtigkeitsbalance. Täglich anwendbar, auch bei sensibler Haut.	Eine kleine Menge mit Wasser aufschäumen, auf der feuchten Haut einmassieren und mit lauwarmem Wasser abspülen.	Pflanzliche Tenside und Feuchtigkeitsspender. pH-hautneutral.	541	de	167
Lagom Cellup Micro Foam Cleanser	Mousse nettoyante	Une mousse micro-bulles douce pour une peau nette et lumineuse. Sa mousse fine nettoie les pores et élimine impuretés et excès de sébum, tandis que la formule au pH neutre préserve l’hydratation. Assez douce pour un usage quotidien, même sur peau sensible.	Faire mousser une petite quantité avec de l’eau, masser sur peau humide et rincer à l’eau tiède.	Tensioactifs végétaux et agents hydratants. pH neutre.	542	fr	167
Lagom Cellup Micro Foam Cleanser	Schiuma detergente	Una schiuma a micro-bolle delicata per una pelle pulita e luminosa. La schiuma fine pulisce i pori e rimuove impurità e sebo in eccesso, mentre la formula a pH neutro preserva l’idratazione. Delicata per l’uso quotidiano, anche su pelle sensibile.	Emulsionare una piccola quantità con acqua, massaggiare sulla pelle umida e risciacquare con acqua tiepida.	Tensioattivi vegetali e agenti idratanti. pH neutro.	543	it	167
Lagom Cellup Micro Foam Cleanser	Cleansing foam	A gentle micro-foam cleanser for beautifully clear skin. Its fine foam cleanses pores and removes dirt and excess oil, while the pH-neutral formula keeps skin moisturised and balanced. Gentle enough for daily use, even on sensitive skin.	Lather a small amount with water, massage over damp skin and rinse with lukewarm water.	Plant-based surfactants and moisturising agents. pH-neutral.	544	en	167
b:plain Mung Bean Cleansing Foam	Cleansing foam	A gentle cleansing foam powered by mung bean for a natural glow every day. It removes dirt and excess oil softly, leaves skin fresher and brighter, and keeps moisture in without a tight feeling. Suitable for all skin types, including sensitive skin.	Lather a small amount with water, massage over damp skin and rinse with lukewarm water.	Mung bean extract. Vegan, free from parabens, sulfates and artificial fragrance.	545	en	168
b:plain Mung Bean Cleansing Foam	Reinigungsschaum	Sanfte Reinigung mit der Kraft der Mungbohne – für einen natürlichen Glow jeden Tag. Entfernt Schmutz und Überschuss sanft, sorgt für reinere, strahlendere Haut und bewahrt die Feuchtigkeit ohne Spannungsgefühl. Für alle Hauttypen, auch für empfindliche Haut.	Eine kleine Menge mit Wasser aufschäumen, auf der feuchten Haut einmassieren und mit lauwarmem Wasser abspülen.	Mungbohnen-Extrakt. Vegan, frei von Parabenen, Sulfaten und künstlichen Duftstoffen.	546	de	169
b:plain Mung Bean Cleansing Foam	Cleansing foam	A gentle cleansing foam powered by mung bean for a natural glow every day. It removes dirt and excess oil softly, leaves skin fresher and brighter, and keeps moisture in without a tight feeling. Suitable for all skin types, including sensitive skin.	Lather a small amount with water, massage over damp skin and rinse with lukewarm water.	Mung bean extract. Vegan, free from parabens, sulfates and artificial fragrance.	547	en	169
b:plain Mung Bean Cleansing Foam	Reinigungsschaum	Sanfte Reinigung mit der Kraft der Mungbohne – für einen natürlichen Glow jeden Tag. Entfernt Schmutz und Überschuss sanft, sorgt für reinere, strahlendere Haut und bewahrt die Feuchtigkeit ohne Spannungsgefühl. Für alle Hauttypen, auch für empfindliche Haut.	Eine kleine Menge mit Wasser aufschäumen, auf der feuchten Haut einmassieren und mit lauwarmem Wasser abspülen.	Mungbohnen-Extrakt. Vegan, frei von Parabenen, Sulfaten und künstlichen Duftstoffen.	548	de	170
b:plain Mung Bean Cleansing Foam	Mousse nettoyante	Une mousse nettoyante douce à la puissance du haricot mungo pour un éclat naturel au quotidien. Elle élimine en douceur impuretés et excès de sébum, rend la peau plus nette et lumineuse et préserve l’hydratation sans tiraillement. Pour tous les types de peau, même sensibles.	Faire mousser une petite quantité avec de l’eau, masser sur peau humide et rincer à l’eau tiède.	Extrait de haricot mungo. Vegan, sans parabènes, sulfates ni parfums artificiels.	549	fr	170
b:plain Mung Bean Cleansing Foam	Cleansing foam	A gentle cleansing foam powered by mung bean for a natural glow every day. It removes dirt and excess oil softly, leaves skin fresher and brighter, and keeps moisture in without a tight feeling. Suitable for all skin types, including sensitive skin.	Lather a small amount with water, massage over damp skin and rinse with lukewarm water.	Mung bean extract. Vegan, free from parabens, sulfates and artificial fragrance.	550	en	170
b:plain Mung Bean Cleansing Foam	Reinigungsschaum	Sanfte Reinigung mit der Kraft der Mungbohne – für einen natürlichen Glow jeden Tag. Entfernt Schmutz und Überschuss sanft, sorgt für reinere, strahlendere Haut und bewahrt die Feuchtigkeit ohne Spannungsgefühl. Für alle Hauttypen, auch für empfindliche Haut.	Eine kleine Menge mit Wasser aufschäumen, auf der feuchten Haut einmassieren und mit lauwarmem Wasser abspülen.	Mungbohnen-Extrakt. Vegan, frei von Parabenen, Sulfaten und künstlichen Duftstoffen.	551	de	171
b:plain Mung Bean Cleansing Foam	Mousse nettoyante	Une mousse nettoyante douce à la puissance du haricot mungo pour un éclat naturel au quotidien. Elle élimine en douceur impuretés et excès de sébum, rend la peau plus nette et lumineuse et préserve l’hydratation sans tiraillement. Pour tous les types de peau, même sensibles.	Faire mousser une petite quantité avec de l’eau, masser sur peau humide et rincer à l’eau tiède.	Extrait de haricot mungo. Vegan, sans parabènes, sulfates ni parfums artificiels.	552	fr	171
b:plain Mung Bean Cleansing Foam	Schiuma detergente	Una schiuma detergente delicata con la forza del fagiolo mungo per un glow naturale ogni giorno. Rimuove delicatamente impurità e sebo in eccesso, rende la pelle più pulita e luminosa e preserva l’idratazione senza tirare. Per tutti i tipi di pelle, anche sensibili.	Emulsionare una piccola quantità con acqua, massaggiare sulla pelle umida e risciacquare con acqua tiepida.	Estratto di fagiolo mungo. Vegano, senza parabeni, solfati e profumi artificiali.	553	it	171
b:plain Mung Bean Cleansing Foam	Cleansing foam	A gentle cleansing foam powered by mung bean for a natural glow every day. It removes dirt and excess oil softly, leaves skin fresher and brighter, and keeps moisture in without a tight feeling. Suitable for all skin types, including sensitive skin.	Lather a small amount with water, massage over damp skin and rinse with lukewarm water.	Mung bean extract. Vegan, free from parabens, sulfates and artificial fragrance.	554	en	171
JIPU Cleansing Balm	Cleansing balm	A hydrating cleansing balm that effectively removes make-up, sunscreen, dirt and excess oil for clean, fresh skin. The soft balm melts on contact and rinses off easily, cleanses pores and leaves skin supple. Vegan and dermatologically tested, suitable for sensitive skin.	Massage onto dry skin to dissolve make-up and sunscreen, add a little water to emulsify and rinse. Follow with a foam cleanser.	\N	555	en	172
JIPU Cleansing Balm	Reinigungsbalsam	Der JIPU Cleansing Balm entfernt effektiv Make-up, Schmutz und überschüssiges Öl – für eine saubere, gepflegte und frische Haut. Die angenehme Balm-Textur löst sich leicht auf und lässt sich einfach abwaschen, reinigt die Poren und spendet Feuchtigkeit. Vegan, dermatologisch getestet und für empfindliche Haut geeignet.	Auf die trockene Haut einmassieren, um Make-up und Sonnenschutz zu lösen, mit etwas Wasser emulgieren und abspülen. Danach einen Schaumreiniger verwenden.	\N	556	de	173
JIPU Cleansing Balm	Cleansing balm	A hydrating cleansing balm that effectively removes make-up, sunscreen, dirt and excess oil for clean, fresh skin. The soft balm melts on contact and rinses off easily, cleanses pores and leaves skin supple. Vegan and dermatologically tested, suitable for sensitive skin.	Massage onto dry skin to dissolve make-up and sunscreen, add a little water to emulsify and rinse. Follow with a foam cleanser.	\N	557	en	173
JIPU Cleansing Balm	Reinigungsbalsam	Der JIPU Cleansing Balm entfernt effektiv Make-up, Schmutz und überschüssiges Öl – für eine saubere, gepflegte und frische Haut. Die angenehme Balm-Textur löst sich leicht auf und lässt sich einfach abwaschen, reinigt die Poren und spendet Feuchtigkeit. Vegan, dermatologisch getestet und für empfindliche Haut geeignet.	Auf die trockene Haut einmassieren, um Make-up und Sonnenschutz zu lösen, mit etwas Wasser emulgieren und abspülen. Danach einen Schaumreiniger verwenden.	\N	558	de	174
JIPU Cleansing Balm	Baume démaquillant	Un baume démaquillant hydratant qui élimine efficacement maquillage, crème solaire, impuretés et excès de sébum pour une peau nette et fraîche. Le baume fondant se rince facilement, nettoie les pores et laisse la peau souple. Vegan et testé dermatologiquement, convient aux peaux sensibles.	Masser sur peau sèche pour dissoudre maquillage et crème solaire, émulsionner avec un peu d’eau puis rincer. Poursuivre avec une mousse nettoyante.	\N	559	fr	174
JIPU Cleansing Balm	Cleansing balm	A hydrating cleansing balm that effectively removes make-up, sunscreen, dirt and excess oil for clean, fresh skin. The soft balm melts on contact and rinses off easily, cleanses pores and leaves skin supple. Vegan and dermatologically tested, suitable for sensitive skin.	Massage onto dry skin to dissolve make-up and sunscreen, add a little water to emulsify and rinse. Follow with a foam cleanser.	\N	560	en	174
JIPU Cleansing Balm	Reinigungsbalsam	Der JIPU Cleansing Balm entfernt effektiv Make-up, Schmutz und überschüssiges Öl – für eine saubere, gepflegte und frische Haut. Die angenehme Balm-Textur löst sich leicht auf und lässt sich einfach abwaschen, reinigt die Poren und spendet Feuchtigkeit. Vegan, dermatologisch getestet und für empfindliche Haut geeignet.	Auf die trockene Haut einmassieren, um Make-up und Sonnenschutz zu lösen, mit etwas Wasser emulgieren und abspülen. Danach einen Schaumreiniger verwenden.	\N	561	de	175
JIPU Cleansing Balm	Baume démaquillant	Un baume démaquillant hydratant qui élimine efficacement maquillage, crème solaire, impuretés et excès de sébum pour une peau nette et fraîche. Le baume fondant se rince facilement, nettoie les pores et laisse la peau souple. Vegan et testé dermatologiquement, convient aux peaux sensibles.	Masser sur peau sèche pour dissoudre maquillage et crème solaire, émulsionner avec un peu d’eau puis rincer. Poursuivre avec une mousse nettoyante.	\N	562	fr	175
JIPU Cleansing Balm	Balsamo detergente	Un balsamo detergente idratante che rimuove efficacemente trucco, protezione solare, impurità e sebo in eccesso per una pelle pulita e fresca. Il balsamo si scioglie a contatto e si risciacqua facilmente, pulisce i pori e lascia la pelle morbida. Vegano e dermatologicamente testato, adatto alle pelli sensibili.	Massaggiare sulla pelle asciutta per sciogliere trucco e protezione solare, emulsionare con poca acqua e risciacquare. Proseguire con una schiuma detergente.	\N	563	it	175
JIPU Cleansing Balm	Cleansing balm	A hydrating cleansing balm that effectively removes make-up, sunscreen, dirt and excess oil for clean, fresh skin. The soft balm melts on contact and rinses off easily, cleanses pores and leaves skin supple. Vegan and dermatologically tested, suitable for sensitive skin.	Massage onto dry skin to dissolve make-up and sunscreen, add a little water to emulsify and rinse. Follow with a foam cleanser.	\N	564	en	175
Innisfree Green Tea Amino Hydrating Cleansing Foam	Cleansing foam	A gentle hydrating cleansing foam with green tea and amino acids. It cleanses softly while keeping skin supple and comfortable, and removes impurities and excess oil for a fresh, luminous complexion. Suitable for all skin types.	Lather a small amount with water, massage over damp skin and rinse with lukewarm water.	Green tea and amino acids. Free from parabens and mineral oils.	565	en	176
Innisfree Green Tea Amino Hydrating Cleansing Foam	Reinigungsschaum	Ein sanfter, feuchtigkeitsspendender Reinigungsschaum mit Grüntee und Aminosäuren. Reinigt mild und hält die Haut geschmeidig und angenehm, entfernt Unreinheiten und überschüssigen Talg für einen frischen, strahlenden Teint. Für alle Hauttypen.	Eine kleine Menge mit Wasser aufschäumen, auf der feuchten Haut einmassieren und mit lauwarmem Wasser abspülen.	Grüntee und Aminosäuren. Frei von Parabenen und Mineralölen.	566	de	177
Innisfree Green Tea Amino Hydrating Cleansing Foam	Cleansing foam	A gentle hydrating cleansing foam with green tea and amino acids. It cleanses softly while keeping skin supple and comfortable, and removes impurities and excess oil for a fresh, luminous complexion. Suitable for all skin types.	Lather a small amount with water, massage over damp skin and rinse with lukewarm water.	Green tea and amino acids. Free from parabens and mineral oils.	567	en	177
Innisfree Green Tea Amino Hydrating Cleansing Foam	Reinigungsschaum	Ein sanfter, feuchtigkeitsspendender Reinigungsschaum mit Grüntee und Aminosäuren. Reinigt mild und hält die Haut geschmeidig und angenehm, entfernt Unreinheiten und überschüssigen Talg für einen frischen, strahlenden Teint. Für alle Hauttypen.	Eine kleine Menge mit Wasser aufschäumen, auf der feuchten Haut einmassieren und mit lauwarmem Wasser abspülen.	Grüntee und Aminosäuren. Frei von Parabenen und Mineralölen.	568	de	178
Innisfree Green Tea Amino Hydrating Cleansing Foam	Mousse nettoyante	Une mousse nettoyante hydratante au thé vert et aux acides aminés. Elle nettoie en douceur tout en gardant la peau souple et confortable, et élimine impuretés et excès de sébum pour un teint frais et lumineux. Pour tous les types de peau.	Faire mousser une petite quantité avec de l’eau, masser sur peau humide et rincer à l’eau tiède.	Thé vert et acides aminés. Sans parabènes ni huiles minérales.	569	fr	178
Innisfree Green Tea Amino Hydrating Cleansing Foam	Cleansing foam	A gentle hydrating cleansing foam with green tea and amino acids. It cleanses softly while keeping skin supple and comfortable, and removes impurities and excess oil for a fresh, luminous complexion. Suitable for all skin types.	Lather a small amount with water, massage over damp skin and rinse with lukewarm water.	Green tea and amino acids. Free from parabens and mineral oils.	570	en	178
Innisfree Green Tea Amino Hydrating Cleansing Foam	Reinigungsschaum	Ein sanfter, feuchtigkeitsspendender Reinigungsschaum mit Grüntee und Aminosäuren. Reinigt mild und hält die Haut geschmeidig und angenehm, entfernt Unreinheiten und überschüssigen Talg für einen frischen, strahlenden Teint. Für alle Hauttypen.	Eine kleine Menge mit Wasser aufschäumen, auf der feuchten Haut einmassieren und mit lauwarmem Wasser abspülen.	Grüntee und Aminosäuren. Frei von Parabenen und Mineralölen.	571	de	179
Innisfree Green Tea Amino Hydrating Cleansing Foam	Mousse nettoyante	Une mousse nettoyante hydratante au thé vert et aux acides aminés. Elle nettoie en douceur tout en gardant la peau souple et confortable, et élimine impuretés et excès de sébum pour un teint frais et lumineux. Pour tous les types de peau.	Faire mousser une petite quantité avec de l’eau, masser sur peau humide et rincer à l’eau tiède.	Thé vert et acides aminés. Sans parabènes ni huiles minérales.	572	fr	179
Innisfree Green Tea Amino Hydrating Cleansing Foam	Schiuma detergente	Una schiuma detergente idratante al tè verde e aminoacidi. Deterge delicatamente mantenendo la pelle morbida e confortevole e rimuove impurità e sebo in eccesso per un incarnato fresco e luminoso. Per tutti i tipi di pelle.	Emulsionare una piccola quantità con acqua, massaggiare sulla pelle umida e risciacquare con acqua tiepida.	Tè verde e aminoacidi. Senza parabeni e oli minerali.	573	it	179
Innisfree Green Tea Amino Hydrating Cleansing Foam	Cleansing foam	A gentle hydrating cleansing foam with green tea and amino acids. It cleanses softly while keeping skin supple and comfortable, and removes impurities and excess oil for a fresh, luminous complexion. Suitable for all skin types.	Lather a small amount with water, massage over damp skin and rinse with lukewarm water.	Green tea and amino acids. Free from parabens and mineral oils.	574	en	179
Mixsoon Bean Essence	Essence	A pure essence made from 100 % fermented soybean extract. It gives long-lasting moisture, refines and evens the skin tone for a natural glow, and strengthens the skin barrier. Minimal and effective, for sensitive, dry and irritated skin.	After toner, pat a few drops into the skin before serum and cream.	100 % fermented soybean extract. No additives, colours or essential oils.	575	en	180
Mixsoon Bean Essence	Essenz	Die Bean Essence von mixsoon besteht aus 100 % fermentiertem Sojabohnenextrakt. Sie spendet intensive Feuchtigkeit, verbessert den Hautton und stärkt die Hautbarriere – für eine gesunde, strahlende Haut. Minimal und effektiv, besonders für empfindliche, trockene und gereizte Haut.	Nach dem Gesichtswasser einige Tropfen in die Haut einklopfen, vor Serum und Creme.	100 % fermentierter Sojabohnenextrakt. Ohne Zusatzstoffe, Farbstoffe und ätherische Öle.	576	de	181
Mixsoon Bean Essence	Essence	A pure essence made from 100 % fermented soybean extract. It gives long-lasting moisture, refines and evens the skin tone for a natural glow, and strengthens the skin barrier. Minimal and effective, for sensitive, dry and irritated skin.	After toner, pat a few drops into the skin before serum and cream.	100 % fermented soybean extract. No additives, colours or essential oils.	577	en	181
Mixsoon Bean Essence	Essenz	Die Bean Essence von mixsoon besteht aus 100 % fermentiertem Sojabohnenextrakt. Sie spendet intensive Feuchtigkeit, verbessert den Hautton und stärkt die Hautbarriere – für eine gesunde, strahlende Haut. Minimal und effektiv, besonders für empfindliche, trockene und gereizte Haut.	Nach dem Gesichtswasser einige Tropfen in die Haut einklopfen, vor Serum und Creme.	100 % fermentierter Sojabohnenextrakt. Ohne Zusatzstoffe, Farbstoffe und ätherische Öle.	578	de	182
Mixsoon Bean Essence	Essence	Une essence pure composée à 100 % d’extrait de soja fermenté. Elle hydrate durablement, affine et unifie le teint pour un éclat naturel et renforce la barrière cutanée. Minimaliste et efficace, pour peaux sensibles, sèches et irritées.	Après la lotion, faire pénétrer quelques gouttes en tapotant, avant le sérum et la crème.	100 % d’extrait de soja fermenté. Sans additifs, colorants ni huiles essentielles.	579	fr	182
\N	\N	\N	\N	\N	225	de	72
\N	\N	\N	\N	\N	226	fr	72
\N	\N	\N	\N	\N	227	it	72
\N	\N	\N	\N	\N	228	en	72
\N	\N	\N	\N	\N	309	de	80
\N	\N	\N	\N	\N	310	fr	80
\N	\N	\N	\N	\N	311	it	80
\N	\N	\N	\N	\N	312	en	80
Mise en Scène Perfect Serum Original	Hair serum	The cult Korean hair serum for smooth, glossy, healthy-looking hair without weighing it down. It adds intense shine, helps protect against heat, UV and everyday damage, and nourishes with a light, non-greasy formula.	Apply 1–2 pumps to towel-dried or dry lengths and ends, avoiding the scalp. Do not rinse.	\N	345	en	88
Mise en Scène Perfect Serum Original	Haarserum	Das beliebte Haarserum aus Korea für glattes, glänzendes und gesund aussehendes Haar – ohne zu beschweren. Es verleiht intensiven Glanz, hilft vor Hitze, UV-Strahlen und äusseren Einflüssen zu schützen und pflegt mit einer leichten, nicht fettenden Formel.	1–2 Pumpstösse in handtuchtrockene oder trockene Längen und Spitzen geben, Kopfhaut aussparen. Nicht ausspülen.	\N	346	de	89
Mise en Scène Perfect Serum Original	Hair serum	The cult Korean hair serum for smooth, glossy, healthy-looking hair without weighing it down. It adds intense shine, helps protect against heat, UV and everyday damage, and nourishes with a light, non-greasy formula.	Apply 1–2 pumps to towel-dried or dry lengths and ends, avoiding the scalp. Do not rinse.	\N	347	en	89
Mise en Scène Perfect Serum Original	Haarserum	Das beliebte Haarserum aus Korea für glattes, glänzendes und gesund aussehendes Haar – ohne zu beschweren. Es verleiht intensiven Glanz, hilft vor Hitze, UV-Strahlen und äusseren Einflüssen zu schützen und pflegt mit einer leichten, nicht fettenden Formel.	1–2 Pumpstösse in handtuchtrockene oder trockene Längen und Spitzen geben, Kopfhaut aussparen. Nicht ausspülen.	\N	348	de	90
Mise en Scène Perfect Serum Original	Sérum capillaire	Le sérum capillaire coréen culte pour des cheveux lisses, brillants et en pleine santé, sans les alourdir. Il apporte une brillance intense, aide à protéger de la chaleur, des UV et des agressions extérieures et nourrit grâce à une formule légère et non grasse.	Appliquer 1 à 2 pressions sur les longueurs et pointes essorées ou sèches, sans toucher le cuir chevelu. Ne pas rincer.	\N	349	fr	90
Mise en Scène Perfect Serum Original	Hair serum	The cult Korean hair serum for smooth, glossy, healthy-looking hair without weighing it down. It adds intense shine, helps protect against heat, UV and everyday damage, and nourishes with a light, non-greasy formula.	Apply 1–2 pumps to towel-dried or dry lengths and ends, avoiding the scalp. Do not rinse.	\N	350	en	90
Mise en Scène Perfect Serum Original	Haarserum	Das beliebte Haarserum aus Korea für glattes, glänzendes und gesund aussehendes Haar – ohne zu beschweren. Es verleiht intensiven Glanz, hilft vor Hitze, UV-Strahlen und äusseren Einflüssen zu schützen und pflegt mit einer leichten, nicht fettenden Formel.	1–2 Pumpstösse in handtuchtrockene oder trockene Längen und Spitzen geben, Kopfhaut aussparen. Nicht ausspülen.	\N	351	de	91
Mise en Scène Perfect Serum Original	Sérum capillaire	Le sérum capillaire coréen culte pour des cheveux lisses, brillants et en pleine santé, sans les alourdir. Il apporte une brillance intense, aide à protéger de la chaleur, des UV et des agressions extérieures et nourrit grâce à une formule légère et non grasse.	Appliquer 1 à 2 pressions sur les longueurs et pointes essorées ou sèches, sans toucher le cuir chevelu. Ne pas rincer.	\N	352	fr	91
Mise en Scène Perfect Serum Original	Siero per capelli	Il siero coreano di culto per capelli lisci, lucenti e dall’aspetto sano, senza appesantirli. Dona una brillantezza intensa, aiuta a proteggere da calore, raggi UV e agenti esterni e nutre con una formula leggera e non grassa.	Applicare 1–2 erogazioni su lunghezze e punte tamponate o asciutte, evitando la cute. Non risciacquare.	\N	353	it	91
Mise en Scène Perfect Serum Original	Hair serum	The cult Korean hair serum for smooth, glossy, healthy-looking hair without weighing it down. It adds intense shine, helps protect against heat, UV and everyday damage, and nourishes with a light, non-greasy formula.	Apply 1–2 pumps to towel-dried or dry lengths and ends, avoiding the scalp. Do not rinse.	\N	354	en	91
Mise en Scène Perfect Serum	Hair serum	The classic Korean hair serum for visibly smoother, glossier and healthier-looking hair. Gives instant shine and easy combing, helps protect against heat and UV, and helps reduce split ends with a fast-absorbing formula that never feels greasy.	Apply 1–2 pumps to towel-dried or dry lengths and ends, avoiding the scalp. Do not rinse.	\N	355	en	92
Mise en Scène Perfect Serum	Haarserum	Das Kult-Haarserum aus Korea für sichtbar glatteres, glänzenderes und gesünder aussehendes Haar. Sorgt sofort für Glanz und leichte Kämmbarkeit, schützt vor Hitze und UV-Strahlen und hilft, Spliss zu reduzieren – mit einer schnell einziehenden Formel ohne fettiges Gefühl.	1–2 Pumpstösse in handtuchtrockene oder trockene Längen und Spitzen geben, Kopfhaut aussparen. Nicht ausspülen.	\N	356	de	93
Mise en Scène Perfect Serum	Hair serum	The classic Korean hair serum for visibly smoother, glossier and healthier-looking hair. Gives instant shine and easy combing, helps protect against heat and UV, and helps reduce split ends with a fast-absorbing formula that never feels greasy.	Apply 1–2 pumps to towel-dried or dry lengths and ends, avoiding the scalp. Do not rinse.	\N	357	en	93
Mise en Scène Perfect Serum	Haarserum	Das Kult-Haarserum aus Korea für sichtbar glatteres, glänzenderes und gesünder aussehendes Haar. Sorgt sofort für Glanz und leichte Kämmbarkeit, schützt vor Hitze und UV-Strahlen und hilft, Spliss zu reduzieren – mit einer schnell einziehenden Formel ohne fettiges Gefühl.	1–2 Pumpstösse in handtuchtrockene oder trockene Längen und Spitzen geben, Kopfhaut aussparen. Nicht ausspülen.	\N	358	de	94
Mise en Scène Perfect Serum	Sérum capillaire	Le sérum capillaire coréen culte pour des cheveux visiblement plus lisses, plus brillants et en meilleure santé. Brillance immédiate et démêlage facile, protection contre la chaleur et les UV et moins de fourches, grâce à une formule qui pénètre vite sans effet gras.	Appliquer 1 à 2 pressions sur les longueurs et pointes essorées ou sèches, sans toucher le cuir chevelu. Ne pas rincer.	\N	359	fr	94
Mise en Scène Perfect Serum	Hair serum	The classic Korean hair serum for visibly smoother, glossier and healthier-looking hair. Gives instant shine and easy combing, helps protect against heat and UV, and helps reduce split ends with a fast-absorbing formula that never feels greasy.	Apply 1–2 pumps to towel-dried or dry lengths and ends, avoiding the scalp. Do not rinse.	\N	360	en	94
Mise en Scène Perfect Serum	Haarserum	Das Kult-Haarserum aus Korea für sichtbar glatteres, glänzenderes und gesünder aussehendes Haar. Sorgt sofort für Glanz und leichte Kämmbarkeit, schützt vor Hitze und UV-Strahlen und hilft, Spliss zu reduzieren – mit einer schnell einziehenden Formel ohne fettiges Gefühl.	1–2 Pumpstösse in handtuchtrockene oder trockene Längen und Spitzen geben, Kopfhaut aussparen. Nicht ausspülen.	\N	361	de	95
Illiyoon Ultra Repair Deep Moisture Wash	Body wash	A gentle, moisture-giving body wash that cleanses without drying the skin out. Its ceramide and moisturising complex cares for dry and sensitive skin, and the pH-neutral formula suits the whole family.	Lather on wet skin and rinse.	Ceramides and moisturising complex. pH-neutral.	425	en	120
Mise en Scène Perfect Serum	Sérum capillaire	Le sérum capillaire coréen culte pour des cheveux visiblement plus lisses, plus brillants et en meilleure santé. Brillance immédiate et démêlage facile, protection contre la chaleur et les UV et moins de fourches, grâce à une formule qui pénètre vite sans effet gras.	Appliquer 1 à 2 pressions sur les longueurs et pointes essorées ou sèches, sans toucher le cuir chevelu. Ne pas rincer.	\N	362	fr	95
Mise en Scène Perfect Serum	Siero per capelli	Il siero coreano di culto per capelli visibilmente più lisci, lucenti e sani. Brillantezza immediata e pettinabilità facile, protezione da calore e UV e meno doppie punte, con una formula che si assorbe in fretta senza ungere.	Applicare 1–2 erogazioni su lunghezze e punte tamponate o asciutte, evitando la cute. Non risciacquare.	\N	363	it	95
Mise en Scène Perfect Serum	Hair serum	The classic Korean hair serum for visibly smoother, glossier and healthier-looking hair. Gives instant shine and easy combing, helps protect against heat and UV, and helps reduce split ends with a fast-absorbing formula that never feels greasy.	Apply 1–2 pumps to towel-dried or dry lengths and ends, avoiding the scalp. Do not rinse.	\N	364	en	95
Dr.FORHAIR Folligen Original Shampoo	Shampoo	A clinically tested shampoo for an oily, troubled scalp and thinning hair. Developed by the Dr.FORHAIR Scalp & Hair Research Center, it reduces excess sebum by up to 71.4 % and increases scalp strength by up to 40.2 %, with a gentle, paraben-free formula.	Massage into wet hair and scalp, lather and rinse thoroughly.	\N	365	en	96
Dr.FORHAIR Folligen Original Shampoo	Shampoo	Klinisch bewährte Pflege gegen übermässigen Talg und Kopfhautprobleme, ideal für dünner werdendes Haar. Entwickelt vom Dr.FORHAIR Scalp & Hair Research Center, reduziert überschüssigen Talg um bis zu 71,4 % und erhöht die Widerstandskraft der Kopfhaut um bis zu 40,2 % – sanft und frei von Parabenen.	In das nasse Haar und die Kopfhaut einmassieren, aufschäumen und gründlich ausspülen.	\N	366	de	97
Dr.FORHAIR Folligen Original Shampoo	Shampoo	A clinically tested shampoo for an oily, troubled scalp and thinning hair. Developed by the Dr.FORHAIR Scalp & Hair Research Center, it reduces excess sebum by up to 71.4 % and increases scalp strength by up to 40.2 %, with a gentle, paraben-free formula.	Massage into wet hair and scalp, lather and rinse thoroughly.	\N	367	en	97
Dr.FORHAIR Folligen Original Shampoo	Shampoo	Klinisch bewährte Pflege gegen übermässigen Talg und Kopfhautprobleme, ideal für dünner werdendes Haar. Entwickelt vom Dr.FORHAIR Scalp & Hair Research Center, reduziert überschüssigen Talg um bis zu 71,4 % und erhöht die Widerstandskraft der Kopfhaut um bis zu 40,2 % – sanft und frei von Parabenen.	In das nasse Haar und die Kopfhaut einmassieren, aufschäumen und gründlich ausspülen.	\N	368	de	98
Dr.FORHAIR Folligen Original Shampoo	Shampooing	Un shampooing cliniquement testé pour le cuir chevelu gras et sensible et les cheveux qui s’affinent. Développé par le Dr.FORHAIR Scalp & Hair Research Center, il réduit l’excès de sébum jusqu’à 71,4 % et renforce le cuir chevelu jusqu’à 40,2 %, avec une formule douce sans parabènes.	Masser sur cheveux et cuir chevelu mouillés, faire mousser puis rincer abondamment.	\N	369	fr	98
Dr.FORHAIR Folligen Original Shampoo	Shampoo	A clinically tested shampoo for an oily, troubled scalp and thinning hair. Developed by the Dr.FORHAIR Scalp & Hair Research Center, it reduces excess sebum by up to 71.4 % and increases scalp strength by up to 40.2 %, with a gentle, paraben-free formula.	Massage into wet hair and scalp, lather and rinse thoroughly.	\N	370	en	98
Dr.FORHAIR Folligen Original Shampoo	Shampoo	Klinisch bewährte Pflege gegen übermässigen Talg und Kopfhautprobleme, ideal für dünner werdendes Haar. Entwickelt vom Dr.FORHAIR Scalp & Hair Research Center, reduziert überschüssigen Talg um bis zu 71,4 % und erhöht die Widerstandskraft der Kopfhaut um bis zu 40,2 % – sanft und frei von Parabenen.	In das nasse Haar und die Kopfhaut einmassieren, aufschäumen und gründlich ausspülen.	\N	371	de	99
Dr.FORHAIR Folligen Original Shampoo	Shampooing	Un shampooing cliniquement testé pour le cuir chevelu gras et sensible et les cheveux qui s’affinent. Développé par le Dr.FORHAIR Scalp & Hair Research Center, il réduit l’excès de sébum jusqu’à 71,4 % et renforce le cuir chevelu jusqu’à 40,2 %, avec une formule douce sans parabènes.	Masser sur cheveux et cuir chevelu mouillés, faire mousser puis rincer abondamment.	\N	372	fr	99
Dr.FORHAIR Folligen Original Shampoo	Shampoo	Uno shampoo testato clinicamente per cute grassa e problematica e capelli che si diradano. Sviluppato dal Dr.FORHAIR Scalp & Hair Research Center, riduce il sebo in eccesso fino al 71,4 % e rafforza la cute fino al 40,2 %, con una formula delicata senza parabeni.	Massaggiare su capelli e cute bagnati, emulsionare e risciacquare accuratamente.	\N	373	it	99
Dr.FORHAIR Folligen Original Shampoo	Shampoo	A clinically tested shampoo for an oily, troubled scalp and thinning hair. Developed by the Dr.FORHAIR Scalp & Hair Research Center, it reduces excess sebum by up to 71.4 % and increases scalp strength by up to 40.2 %, with a gentle, paraben-free formula.	Massage into wet hair and scalp, lather and rinse thoroughly.	\N	374	en	99
Lador Hydro LPP Treatment	Hair treatment	A professional salon treatment with low-molecular PPT that deeply repairs dry and damaged hair. Strengthens the hair from within, restores moisture and elasticity, and helps protect colour-treated hair, without silicones or parabens.	After shampooing, apply to the lengths and ends, leave on for a few minutes and rinse.	Low-molecular proteins (PPT) and collagen. Free from silicones and parabens.	375	en	100
Lador Hydro LPP Treatment	Haarkur	Die professionelle Salonbehandlung mit niedrigmolekularem PPT versorgt trockenes und geschädigtes Haar tiefenwirksam mit Feuchtigkeit und Nährstoffen. Stärkt die Haarstruktur von innen, verbessert die Elastizität und schützt coloriertes Haar – silikon- und parabenfrei.	Nach dem Shampoo in Längen und Spitzen verteilen, einige Minuten einwirken lassen und ausspülen.	Niedrigmolekulare Proteine (PPT) und Kollagen. Frei von Silikonen und Parabenen.	376	de	101
Lador Hydro LPP Treatment	Hair treatment	A professional salon treatment with low-molecular PPT that deeply repairs dry and damaged hair. Strengthens the hair from within, restores moisture and elasticity, and helps protect colour-treated hair, without silicones or parabens.	After shampooing, apply to the lengths and ends, leave on for a few minutes and rinse.	Low-molecular proteins (PPT) and collagen. Free from silicones and parabens.	377	en	101
Lador Hydro LPP Treatment	Haarkur	Die professionelle Salonbehandlung mit niedrigmolekularem PPT versorgt trockenes und geschädigtes Haar tiefenwirksam mit Feuchtigkeit und Nährstoffen. Stärkt die Haarstruktur von innen, verbessert die Elastizität und schützt coloriertes Haar – silikon- und parabenfrei.	Nach dem Shampoo in Längen und Spitzen verteilen, einige Minuten einwirken lassen und ausspülen.	Niedrigmolekulare Proteine (PPT) und Kollagen. Frei von Silikonen und Parabenen.	378	de	102
Lador Hydro LPP Treatment	Soin capillaire	Un soin professionnel de salon au PPT de faible poids moléculaire qui répare en profondeur les cheveux secs et abîmés. Il renforce la fibre de l’intérieur, redonne hydratation et élasticité et protège les cheveux colorés, sans silicones ni parabènes.	Après le shampooing, appliquer sur les longueurs et pointes, laisser poser quelques minutes puis rincer.	Protéines de faible poids moléculaire (PPT) et collagène. Sans silicones ni parabènes.	379	fr	102
Lador Hydro LPP Treatment	Hair treatment	A professional salon treatment with low-molecular PPT that deeply repairs dry and damaged hair. Strengthens the hair from within, restores moisture and elasticity, and helps protect colour-treated hair, without silicones or parabens.	After shampooing, apply to the lengths and ends, leave on for a few minutes and rinse.	Low-molecular proteins (PPT) and collagen. Free from silicones and parabens.	380	en	102
Lador Hydro LPP Treatment	Haarkur	Die professionelle Salonbehandlung mit niedrigmolekularem PPT versorgt trockenes und geschädigtes Haar tiefenwirksam mit Feuchtigkeit und Nährstoffen. Stärkt die Haarstruktur von innen, verbessert die Elastizität und schützt coloriertes Haar – silikon- und parabenfrei.	Nach dem Shampoo in Längen und Spitzen verteilen, einige Minuten einwirken lassen und ausspülen.	Niedrigmolekulare Proteine (PPT) und Kollagen. Frei von Silikonen und Parabenen.	381	de	103
Lador Hydro LPP Treatment	Soin capillaire	Un soin professionnel de salon au PPT de faible poids moléculaire qui répare en profondeur les cheveux secs et abîmés. Il renforce la fibre de l’intérieur, redonne hydratation et élasticité et protège les cheveux colorés, sans silicones ni parabènes.	Après le shampooing, appliquer sur les longueurs et pointes, laisser poser quelques minutes puis rincer.	Protéines de faible poids moléculaire (PPT) et collagène. Sans silicones ni parabènes.	382	fr	103
Lador Hydro LPP Treatment	Trattamento per capelli	Un trattamento professionale da salone con PPT a basso peso molecolare che ripara in profondità i capelli secchi e danneggiati. Rinforza la fibra dall’interno, ridona idratazione ed elasticità e protegge i capelli colorati, senza siliconi né parabeni.	Dopo lo shampoo applicare su lunghezze e punte, lasciare in posa qualche minuto e risciacquare.	Proteine a basso peso molecolare (PPT) e collagene. Senza siliconi né parabeni.	383	it	103
Lador Hydro LPP Treatment	Hair treatment	A professional salon treatment with low-molecular PPT that deeply repairs dry and damaged hair. Strengthens the hair from within, restores moisture and elasticity, and helps protect colour-treated hair, without silicones or parabens.	After shampooing, apply to the lengths and ends, leave on for a few minutes and rinse.	Low-molecular proteins (PPT) and collagen. Free from silicones and parabens.	384	en	103
Aromatica Rosemary Scalp Scrub	Scalp scrub	A deep-cleansing scalp exfoliator with rosemary and sea salt. Gently removes dead skin cells and product build-up, leaves the scalp feeling fresh and clean, and supports healthy-looking hair growth. Vegan, without silicones.	Before shampooing, massage gently into the wet scalp for 1–2 minutes and rinse. Use 1–2 times a week.	Rosemary extract, sea salt, plant-based exfoliating particles. Vegan, free from silicones.	385	en	104
Aromatica Rosemary Scalp Scrub	Kopfhautpeeling	Tiefenreinigendes Peeling für die Kopfhaut mit Rosmarin und Meersalz. Entfernt sanft abgestorbene Hautzellen und Produktablagerungen, sorgt für ein frisches, belebtes Gefühl und fördert ein gesundes Haarwachstum. Vegan und ohne Silikone.	Vor dem Shampoo 1–2 Minuten sanft in die nasse Kopfhaut einmassieren und ausspülen. 1–2 Mal pro Woche anwenden.	Rosmarin-Extrakt, Meersalz, pflanzliche Peeling-Partikel. Vegan, frei von Silikonen.	386	de	105
Aromatica Rosemary Scalp Scrub	Scalp scrub	A deep-cleansing scalp exfoliator with rosemary and sea salt. Gently removes dead skin cells and product build-up, leaves the scalp feeling fresh and clean, and supports healthy-looking hair growth. Vegan, without silicones.	Before shampooing, massage gently into the wet scalp for 1–2 minutes and rinse. Use 1–2 times a week.	Rosemary extract, sea salt, plant-based exfoliating particles. Vegan, free from silicones.	387	en	105
Aromatica Rosemary Scalp Scrub	Kopfhautpeeling	Tiefenreinigendes Peeling für die Kopfhaut mit Rosmarin und Meersalz. Entfernt sanft abgestorbene Hautzellen und Produktablagerungen, sorgt für ein frisches, belebtes Gefühl und fördert ein gesundes Haarwachstum. Vegan und ohne Silikone.	Vor dem Shampoo 1–2 Minuten sanft in die nasse Kopfhaut einmassieren und ausspülen. 1–2 Mal pro Woche anwenden.	Rosmarin-Extrakt, Meersalz, pflanzliche Peeling-Partikel. Vegan, frei von Silikonen.	388	de	106
Aromatica Rosemary Scalp Scrub	Gommage du cuir chevelu	Un gommage purifiant du cuir chevelu au romarin et au sel marin. Il élimine en douceur cellules mortes et résidus de produits, laisse une sensation de fraîcheur et favorise une pousse saine. Vegan, sans silicones.	Avant le shampooing, masser délicatement le cuir chevelu mouillé pendant 1 à 2 minutes puis rincer. 1 à 2 fois par semaine.	Extrait de romarin, sel marin, particules exfoliantes végétales. Vegan, sans silicones.	389	fr	106
Aromatica Rosemary Scalp Scrub	Scalp scrub	A deep-cleansing scalp exfoliator with rosemary and sea salt. Gently removes dead skin cells and product build-up, leaves the scalp feeling fresh and clean, and supports healthy-looking hair growth. Vegan, without silicones.	Before shampooing, massage gently into the wet scalp for 1–2 minutes and rinse. Use 1–2 times a week.	Rosemary extract, sea salt, plant-based exfoliating particles. Vegan, free from silicones.	390	en	106
Aromatica Rosemary Scalp Scrub	Kopfhautpeeling	Tiefenreinigendes Peeling für die Kopfhaut mit Rosmarin und Meersalz. Entfernt sanft abgestorbene Hautzellen und Produktablagerungen, sorgt für ein frisches, belebtes Gefühl und fördert ein gesundes Haarwachstum. Vegan und ohne Silikone.	Vor dem Shampoo 1–2 Minuten sanft in die nasse Kopfhaut einmassieren und ausspülen. 1–2 Mal pro Woche anwenden.	Rosmarin-Extrakt, Meersalz, pflanzliche Peeling-Partikel. Vegan, frei von Silikonen.	391	de	107
Aromatica Rosemary Scalp Scrub	Gommage du cuir chevelu	Un gommage purifiant du cuir chevelu au romarin et au sel marin. Il élimine en douceur cellules mortes et résidus de produits, laisse une sensation de fraîcheur et favorise une pousse saine. Vegan, sans silicones.	Avant le shampooing, masser délicatement le cuir chevelu mouillé pendant 1 à 2 minutes puis rincer. 1 à 2 fois par semaine.	Extrait de romarin, sel marin, particules exfoliantes végétales. Vegan, sans silicones.	392	fr	107
Aromatica Rosemary Scalp Scrub	Scrub per il cuoio capelluto	Uno scrub purificante per la cute con rosmarino e sale marino. Rimuove delicatamente cellule morte e residui di prodotti, lascia una sensazione di freschezza e favorisce una crescita sana. Vegano, senza siliconi.	Prima dello shampoo massaggiare delicatamente la cute bagnata per 1–2 minuti e risciacquare. 1–2 volte a settimana.	Estratto di rosmarino, sale marino, particelle esfolianti vegetali. Vegano, senza siliconi.	393	it	107
Aromatica Rosemary Scalp Scrub	Scalp scrub	A deep-cleansing scalp exfoliator with rosemary and sea salt. Gently removes dead skin cells and product build-up, leaves the scalp feeling fresh and clean, and supports healthy-looking hair growth. Vegan, without silicones.	Before shampooing, massage gently into the wet scalp for 1–2 minutes and rinse. Use 1–2 times a week.	Rosemary extract, sea salt, plant-based exfoliating particles. Vegan, free from silicones.	394	en	107
Aromatica Rosemary Root Enhancer	Scalp tonic	A scalp tonic with rosemary extract for stronger roots and fuller, healthier-looking hair. Revitalises the scalp, nourishes the hair roots to help prevent hair loss caused by breakage, and soothes a sensitive or irritated scalp.	Apply to the clean scalp, section by section, and massage in. Do not rinse. Use daily.	Rosemary extract. Vegan, free from silicones, parabens and artificial fragrance. Dermatologically tested.	395	en	108
Aromatica Rosemary Root Enhancer	Kopfhaut-Tonikum	Kopfhaut-Tonikum mit Rosmarin-Extrakt für kräftigere Haarwurzeln und volleres, gesünder aussehendes Haar. Revitalisiert die Kopfhaut, nährt die Haarwurzeln, hilft Haarausfall durch Haarbruch vorzubeugen und beruhigt empfindliche Kopfhaut.	Partienweise auf die saubere Kopfhaut auftragen und einmassieren. Nicht ausspülen. Täglich anwenden.	Rosmarin-Extrakt. Vegan, frei von Silikonen, Parabenen und künstlichen Duftstoffen. Dermatologisch getestet.	396	de	109
Aromatica Rosemary Root Enhancer	Scalp tonic	A scalp tonic with rosemary extract for stronger roots and fuller, healthier-looking hair. Revitalises the scalp, nourishes the hair roots to help prevent hair loss caused by breakage, and soothes a sensitive or irritated scalp.	Apply to the clean scalp, section by section, and massage in. Do not rinse. Use daily.	Rosemary extract. Vegan, free from silicones, parabens and artificial fragrance. Dermatologically tested.	397	en	109
Aromatica Rosemary Root Enhancer	Kopfhaut-Tonikum	Kopfhaut-Tonikum mit Rosmarin-Extrakt für kräftigere Haarwurzeln und volleres, gesünder aussehendes Haar. Revitalisiert die Kopfhaut, nährt die Haarwurzeln, hilft Haarausfall durch Haarbruch vorzubeugen und beruhigt empfindliche Kopfhaut.	Partienweise auf die saubere Kopfhaut auftragen und einmassieren. Nicht ausspülen. Täglich anwenden.	Rosmarin-Extrakt. Vegan, frei von Silikonen, Parabenen und künstlichen Duftstoffen. Dermatologisch getestet.	398	de	110
Aromatica Rosemary Root Enhancer	Tonique pour le cuir chevelu	Un tonique pour le cuir chevelu à l’extrait de romarin pour des racines plus fortes et des cheveux plus denses. Il revitalise le cuir chevelu, nourrit les racines, aide à prévenir la chute liée à la casse et apaise le cuir chevelu sensible.	Appliquer mèche par mèche sur le cuir chevelu propre et masser. Ne pas rincer. Usage quotidien.	Extrait de romarin. Vegan, sans silicones, parabènes ni parfums artificiels. Testé dermatologiquement.	399	fr	110
Aromatica Rosemary Root Enhancer	Scalp tonic	A scalp tonic with rosemary extract for stronger roots and fuller, healthier-looking hair. Revitalises the scalp, nourishes the hair roots to help prevent hair loss caused by breakage, and soothes a sensitive or irritated scalp.	Apply to the clean scalp, section by section, and massage in. Do not rinse. Use daily.	Rosemary extract. Vegan, free from silicones, parabens and artificial fragrance. Dermatologically tested.	400	en	110
Aromatica Rosemary Root Enhancer	Kopfhaut-Tonikum	Kopfhaut-Tonikum mit Rosmarin-Extrakt für kräftigere Haarwurzeln und volleres, gesünder aussehendes Haar. Revitalisiert die Kopfhaut, nährt die Haarwurzeln, hilft Haarausfall durch Haarbruch vorzubeugen und beruhigt empfindliche Kopfhaut.	Partienweise auf die saubere Kopfhaut auftragen und einmassieren. Nicht ausspülen. Täglich anwenden.	Rosmarin-Extrakt. Vegan, frei von Silikonen, Parabenen und künstlichen Duftstoffen. Dermatologisch getestet.	401	de	111
Aromatica Rosemary Root Enhancer	Tonique pour le cuir chevelu	Un tonique pour le cuir chevelu à l’extrait de romarin pour des racines plus fortes et des cheveux plus denses. Il revitalise le cuir chevelu, nourrit les racines, aide à prévenir la chute liée à la casse et apaise le cuir chevelu sensible.	Appliquer mèche par mèche sur le cuir chevelu propre et masser. Ne pas rincer. Usage quotidien.	Extrait de romarin. Vegan, sans silicones, parabènes ni parfums artificiels. Testé dermatologiquement.	402	fr	111
Aromatica Rosemary Root Enhancer	Tonico per il cuoio capelluto	Un tonico per la cute all’estratto di rosmarino per radici più forti e capelli più voluminosi. Rivitalizza la cute, nutre le radici, aiuta a prevenire la caduta dovuta alla rottura e lenisce la cute sensibile.	Applicare a ciocche sulla cute pulita e massaggiare. Non risciacquare. Uso quotidiano.	Estratto di rosmarino. Vegano, senza siliconi, parabeni e profumi artificiali. Dermatologicamente testato.	403	it	111
Aromatica Rosemary Root Enhancer	Scalp tonic	A scalp tonic with rosemary extract for stronger roots and fuller, healthier-looking hair. Revitalises the scalp, nourishes the hair roots to help prevent hair loss caused by breakage, and soothes a sensitive or irritated scalp.	Apply to the clean scalp, section by section, and massage in. Do not rinse. Use daily.	Rosemary extract. Vegan, free from silicones, parabens and artificial fragrance. Dermatologically tested.	404	en	111
Aromatica Rosemary Scalp Scaling Shampoo	Shampoo	A natural shampoo for a balanced scalp and stronger, shinier hair, every day. Rosemary extract revitalises the scalp while the deep-cleansing formula gently removes excess oil and residue for a fresh scalp, without silicones or sulfates.	Massage into wet hair and scalp, lather and rinse thoroughly.	Rosemary extract. Vegan, free from silicones and sulfates. Dermatologically tested.	405	en	112
Aromatica Rosemary Scalp Scaling Shampoo	Shampoo	Natürliche Pflege für eine ausgeglichene Kopfhaut und gestärktes, glänzendes Haar – jeden Tag. Rosmarin-Extrakt revitalisiert die Kopfhaut, die tiefenreinigende Formel entfernt sanft überschüssiges Öl und Rückstände – frei von Silikonen und Sulfaten.	In das nasse Haar und die Kopfhaut einmassieren, aufschäumen und gründlich ausspülen.	Rosmarin-Extrakt. Vegan, frei von Silikonen und Sulfaten. Dermatologisch getestet.	406	de	113
Aromatica Rosemary Scalp Scaling Shampoo	Shampoo	A natural shampoo for a balanced scalp and stronger, shinier hair, every day. Rosemary extract revitalises the scalp while the deep-cleansing formula gently removes excess oil and residue for a fresh scalp, without silicones or sulfates.	Massage into wet hair and scalp, lather and rinse thoroughly.	Rosemary extract. Vegan, free from silicones and sulfates. Dermatologically tested.	407	en	113
Aromatica Rosemary Scalp Scaling Shampoo	Shampoo	Natürliche Pflege für eine ausgeglichene Kopfhaut und gestärktes, glänzendes Haar – jeden Tag. Rosmarin-Extrakt revitalisiert die Kopfhaut, die tiefenreinigende Formel entfernt sanft überschüssiges Öl und Rückstände – frei von Silikonen und Sulfaten.	In das nasse Haar und die Kopfhaut einmassieren, aufschäumen und gründlich ausspülen.	Rosmarin-Extrakt. Vegan, frei von Silikonen und Sulfaten. Dermatologisch getestet.	408	de	114
Aromatica Rosemary Scalp Scaling Shampoo	Shampooing	Un shampooing naturel pour un cuir chevelu équilibré et des cheveux plus forts et brillants, au quotidien. L’extrait de romarin revitalise le cuir chevelu et la formule purifiante élimine en douceur l’excès de sébum et les résidus, sans silicones ni sulfates.	Masser sur cheveux et cuir chevelu mouillés, faire mousser puis rincer abondamment.	Extrait de romarin. Vegan, sans silicones ni sulfates. Testé dermatologiquement.	409	fr	114
Aromatica Rosemary Scalp Scaling Shampoo	Shampoo	A natural shampoo for a balanced scalp and stronger, shinier hair, every day. Rosemary extract revitalises the scalp while the deep-cleansing formula gently removes excess oil and residue for a fresh scalp, without silicones or sulfates.	Massage into wet hair and scalp, lather and rinse thoroughly.	Rosemary extract. Vegan, free from silicones and sulfates. Dermatologically tested.	410	en	114
Aromatica Rosemary Scalp Scaling Shampoo	Shampoo	Natürliche Pflege für eine ausgeglichene Kopfhaut und gestärktes, glänzendes Haar – jeden Tag. Rosmarin-Extrakt revitalisiert die Kopfhaut, die tiefenreinigende Formel entfernt sanft überschüssiges Öl und Rückstände – frei von Silikonen und Sulfaten.	In das nasse Haar und die Kopfhaut einmassieren, aufschäumen und gründlich ausspülen.	Rosmarin-Extrakt. Vegan, frei von Silikonen und Sulfaten. Dermatologisch getestet.	411	de	115
Aromatica Rosemary Scalp Scaling Shampoo	Shampooing	Un shampooing naturel pour un cuir chevelu équilibré et des cheveux plus forts et brillants, au quotidien. L’extrait de romarin revitalise le cuir chevelu et la formule purifiante élimine en douceur l’excès de sébum et les résidus, sans silicones ni sulfates.	Masser sur cheveux et cuir chevelu mouillés, faire mousser puis rincer abondamment.	Extrait de romarin. Vegan, sans silicones ni sulfates. Testé dermatologiquement.	412	fr	115
Aromatica Rosemary Scalp Scaling Shampoo	Shampoo	Uno shampoo naturale per una cute equilibrata e capelli più forti e lucenti, ogni giorno. L’estratto di rosmarino rivitalizza la cute e la formula purificante rimuove delicatamente sebo in eccesso e residui, senza siliconi né solfati.	Massaggiare su capelli e cute bagnati, emulsionare e risciacquare accuratamente.	Estratto di rosmarino. Vegano, senza siliconi né solfati. Dermatologicamente testato.	413	it	115
Aromatica Rosemary Scalp Scaling Shampoo	Shampoo	A natural shampoo for a balanced scalp and stronger, shinier hair, every day. Rosemary extract revitalises the scalp while the deep-cleansing formula gently removes excess oil and residue for a fresh scalp, without silicones or sulfates.	Massage into wet hair and scalp, lather and rinse thoroughly.	Rosemary extract. Vegan, free from silicones and sulfates. Dermatologically tested.	414	en	115
Labo-H Scalp Strengthening Shampoo	Shampoo	A strengthening shampoo for a balanced scalp and stronger, healthier hair. It helps reinforce the scalp barrier and reduce hair loss, balances the scalp microbiome and cleanses gently while adding strength and vitality. Suitable for all hair types.	Massage into wet hair and scalp, lather and rinse thoroughly.	Probiotics lysate, ceramide, PDRN, biotin and caffeine. Dermatologically tested.	415	en	116
Labo-H Scalp Strengthening Shampoo	Shampoo	Ein stärkendes Shampoo für eine ausgeglichene Kopfhaut und kräftigeres, gesünderes Haar. Hilft, die Barriere der Kopfhaut zu stärken und Haarausfall zu reduzieren, gleicht das Mikrobiom aus und reinigt sanft. Für alle Haartypen.	In das nasse Haar und die Kopfhaut einmassieren, aufschäumen und gründlich ausspülen.	Probiotika-Lysat, Ceramid, PDRN, Biotin und Koffein. Dermatologisch getestet.	416	de	117
Labo-H Scalp Strengthening Shampoo	Shampoo	A strengthening shampoo for a balanced scalp and stronger, healthier hair. It helps reinforce the scalp barrier and reduce hair loss, balances the scalp microbiome and cleanses gently while adding strength and vitality. Suitable for all hair types.	Massage into wet hair and scalp, lather and rinse thoroughly.	Probiotics lysate, ceramide, PDRN, biotin and caffeine. Dermatologically tested.	417	en	117
Labo-H Scalp Strengthening Shampoo	Shampoo	Ein stärkendes Shampoo für eine ausgeglichene Kopfhaut und kräftigeres, gesünderes Haar. Hilft, die Barriere der Kopfhaut zu stärken und Haarausfall zu reduzieren, gleicht das Mikrobiom aus und reinigt sanft. Für alle Haartypen.	In das nasse Haar und die Kopfhaut einmassieren, aufschäumen und gründlich ausspülen.	Probiotika-Lysat, Ceramid, PDRN, Biotin und Koffein. Dermatologisch getestet.	418	de	118
Labo-H Scalp Strengthening Shampoo	Shampooing	Un shampooing fortifiant pour un cuir chevelu équilibré et des cheveux plus forts et en pleine santé. Il aide à renforcer la barrière et à réduire la chute des cheveux, équilibre le microbiome et nettoie en douceur. Convient à tous les types de cheveux.	Masser sur cheveux et cuir chevelu mouillés, faire mousser puis rincer abondamment.	Lysat de probiotiques, céramide, PDRN, biotine et caféine. Testé dermatologiquement.	419	fr	118
Labo-H Scalp Strengthening Shampoo	Shampoo	A strengthening shampoo for a balanced scalp and stronger, healthier hair. It helps reinforce the scalp barrier and reduce hair loss, balances the scalp microbiome and cleanses gently while adding strength and vitality. Suitable for all hair types.	Massage into wet hair and scalp, lather and rinse thoroughly.	Probiotics lysate, ceramide, PDRN, biotin and caffeine. Dermatologically tested.	420	en	118
Labo-H Scalp Strengthening Shampoo	Shampoo	Ein stärkendes Shampoo für eine ausgeglichene Kopfhaut und kräftigeres, gesünderes Haar. Hilft, die Barriere der Kopfhaut zu stärken und Haarausfall zu reduzieren, gleicht das Mikrobiom aus und reinigt sanft. Für alle Haartypen.	In das nasse Haar und die Kopfhaut einmassieren, aufschäumen und gründlich ausspülen.	Probiotika-Lysat, Ceramid, PDRN, Biotin und Koffein. Dermatologisch getestet.	421	de	119
Labo-H Scalp Strengthening Shampoo	Shampooing	Un shampooing fortifiant pour un cuir chevelu équilibré et des cheveux plus forts et en pleine santé. Il aide à renforcer la barrière et à réduire la chute des cheveux, équilibre le microbiome et nettoie en douceur. Convient à tous les types de cheveux.	Masser sur cheveux et cuir chevelu mouillés, faire mousser puis rincer abondamment.	Lysat de probiotiques, céramide, PDRN, biotine et caféine. Testé dermatologiquement.	422	fr	119
Labo-H Scalp Strengthening Shampoo	Shampoo	Uno shampoo fortificante per una cute equilibrata e capelli più forti e sani. Aiuta a rafforzare la barriera e a ridurre la caduta dei capelli, riequilibra il microbioma e deterge delicatamente. Adatto a tutti i tipi di capelli.	Massaggiare su capelli e cute bagnati, emulsionare e risciacquare accuratamente.	Lisato di probiotici, ceramide, PDRN, biotina e caffeina. Dermatologicamente testato.	423	it	119
Labo-H Scalp Strengthening Shampoo	Shampoo	A strengthening shampoo for a balanced scalp and stronger, healthier hair. It helps reinforce the scalp barrier and reduce hair loss, balances the scalp microbiome and cleanses gently while adding strength and vitality. Suitable for all hair types.	Massage into wet hair and scalp, lather and rinse thoroughly.	Probiotics lysate, ceramide, PDRN, biotin and caffeine. Dermatologically tested.	424	en	119
Illiyoon Ultra Repair Deep Moisture Wash	Duschgel	Feuchtigkeitsspendende Körperreinigung, die sanft reinigt, ohne die Haut auszutrocknen. Mit Ceramiden und Feuchtigkeitskomplex für trockene und empfindliche Haut, pH-hautneutral und für die ganze Familie geeignet.	Auf der nassen Haut aufschäumen und abspülen.	Ceramide und Feuchtigkeitskomplex. pH-hautneutral.	426	de	121
Illiyoon Ultra Repair Deep Moisture Wash	Body wash	A gentle, moisture-giving body wash that cleanses without drying the skin out. Its ceramide and moisturising complex cares for dry and sensitive skin, and the pH-neutral formula suits the whole family.	Lather on wet skin and rinse.	Ceramides and moisturising complex. pH-neutral.	427	en	121
Illiyoon Ultra Repair Deep Moisture Wash	Duschgel	Feuchtigkeitsspendende Körperreinigung, die sanft reinigt, ohne die Haut auszutrocknen. Mit Ceramiden und Feuchtigkeitskomplex für trockene und empfindliche Haut, pH-hautneutral und für die ganze Familie geeignet.	Auf der nassen Haut aufschäumen und abspülen.	Ceramide und Feuchtigkeitskomplex. pH-hautneutral.	428	de	122
Illiyoon Ultra Repair Deep Moisture Wash	Gel douche	Un gel douche doux et hydratant qui nettoie sans dessécher. Son complexe de céramides et d’agents hydratants prend soin des peaux sèches et sensibles, et sa formule au pH neutre convient à toute la famille.	Faire mousser sur peau mouillée puis rincer.	Céramides et complexe hydratant. pH neutre.	429	fr	122
Illiyoon Ultra Repair Deep Moisture Wash	Body wash	A gentle, moisture-giving body wash that cleanses without drying the skin out. Its ceramide and moisturising complex cares for dry and sensitive skin, and the pH-neutral formula suits the whole family.	Lather on wet skin and rinse.	Ceramides and moisturising complex. pH-neutral.	430	en	122
Illiyoon Ultra Repair Deep Moisture Wash	Duschgel	Feuchtigkeitsspendende Körperreinigung, die sanft reinigt, ohne die Haut auszutrocknen. Mit Ceramiden und Feuchtigkeitskomplex für trockene und empfindliche Haut, pH-hautneutral und für die ganze Familie geeignet.	Auf der nassen Haut aufschäumen und abspülen.	Ceramide und Feuchtigkeitskomplex. pH-hautneutral.	431	de	123
Illiyoon Ultra Repair Deep Moisture Wash	Gel douche	Un gel douche doux et hydratant qui nettoie sans dessécher. Son complexe de céramides et d’agents hydratants prend soin des peaux sèches et sensibles, et sa formule au pH neutre convient à toute la famille.	Faire mousser sur peau mouillée puis rincer.	Céramides et complexe hydratant. pH neutre.	432	fr	123
Illiyoon Ultra Repair Deep Moisture Wash	Bagnoschiuma	Un bagnoschiuma delicato e idratante che deterge senza seccare la pelle. Il complesso di ceramidi e agenti idratanti si prende cura della pelle secca e sensibile, e la formula a pH neutro è adatta a tutta la famiglia.	Emulsionare sulla pelle bagnata e risciacquare.	Ceramidi e complesso idratante. pH neutro.	433	it	123
Illiyoon Ultra Repair Deep Moisture Wash	Body wash	A gentle, moisture-giving body wash that cleanses without drying the skin out. Its ceramide and moisturising complex cares for dry and sensitive skin, and the pH-neutral formula suits the whole family.	Lather on wet skin and rinse.	Ceramides and moisturising complex. pH-neutral.	434	en	123
Illiyoon Ultra Moisture Scrub Wash	Exfoliating body wash	A gentle exfoliating body wash for silky-smooth skin. Natural exfoliating particles remove dry, flaky skin softly while ceramides keep the skin moisturised. Suitable for sensitive and dry skin.	Massage onto wet skin in gentle circles and rinse. Use 2–3 times a week.	Ceramides and a natural exfoliating complex.	435	en	124
Illiyoon Ultra Moisture Scrub Wash	Peeling-Duschgel	Sanftes Peeling für geschmeidige Haut. Entfernt abgestorbene Hautschüppchen sanft, mit Ceramiden und natürlichem Peeling-Komplex, spendet Feuchtigkeit und pflegt. Für empfindliche und trockene Haut.	Mit sanften, kreisenden Bewegungen auf der nassen Haut einmassieren und abspülen. 2–3 Mal pro Woche.	Ceramide und natürlicher Peeling-Komplex.	436	de	125
Illiyoon Ultra Moisture Scrub Wash	Exfoliating body wash	A gentle exfoliating body wash for silky-smooth skin. Natural exfoliating particles remove dry, flaky skin softly while ceramides keep the skin moisturised. Suitable for sensitive and dry skin.	Massage onto wet skin in gentle circles and rinse. Use 2–3 times a week.	Ceramides and a natural exfoliating complex.	437	en	125
Illiyoon Ultra Moisture Scrub Wash	Peeling-Duschgel	Sanftes Peeling für geschmeidige Haut. Entfernt abgestorbene Hautschüppchen sanft, mit Ceramiden und natürlichem Peeling-Komplex, spendet Feuchtigkeit und pflegt. Für empfindliche und trockene Haut.	Mit sanften, kreisenden Bewegungen auf der nassen Haut einmassieren und abspülen. 2–3 Mal pro Woche.	Ceramide und natürlicher Peeling-Komplex.	438	de	126
Illiyoon Ultra Moisture Scrub Wash	Gel douche exfoliant	Un gel douche exfoliant doux pour une peau soyeuse. Des particules exfoliantes naturelles éliminent en douceur les peaux sèches et les squames, tandis que les céramides maintiennent l’hydratation. Convient aux peaux sensibles et sèches.	Masser la peau mouillée par mouvements circulaires doux puis rincer. 2 à 3 fois par semaine.	Céramides et complexe exfoliant naturel.	439	fr	126
Illiyoon Ultra Moisture Scrub Wash	Exfoliating body wash	A gentle exfoliating body wash for silky-smooth skin. Natural exfoliating particles remove dry, flaky skin softly while ceramides keep the skin moisturised. Suitable for sensitive and dry skin.	Massage onto wet skin in gentle circles and rinse. Use 2–3 times a week.	Ceramides and a natural exfoliating complex.	440	en	126
Illiyoon Ultra Moisture Scrub Wash	Peeling-Duschgel	Sanftes Peeling für geschmeidige Haut. Entfernt abgestorbene Hautschüppchen sanft, mit Ceramiden und natürlichem Peeling-Komplex, spendet Feuchtigkeit und pflegt. Für empfindliche und trockene Haut.	Mit sanften, kreisenden Bewegungen auf der nassen Haut einmassieren und abspülen. 2–3 Mal pro Woche.	Ceramide und natürlicher Peeling-Komplex.	441	de	127
Illiyoon Ultra Moisture Scrub Wash	Gel douche exfoliant	Un gel douche exfoliant doux pour une peau soyeuse. Des particules exfoliantes naturelles éliminent en douceur les peaux sèches et les squames, tandis que les céramides maintiennent l’hydratation. Convient aux peaux sensibles et sèches.	Masser la peau mouillée par mouvements circulaires doux puis rincer. 2 à 3 fois par semaine.	Céramides et complexe exfoliant naturel.	442	fr	127
Illiyoon Ultra Moisture Scrub Wash	Bagnoschiuma esfoliante	Un bagnoschiuma esfoliante delicato per una pelle setosa. Particelle esfolianti naturali rimuovono delicatamente le pellicine secche, mentre le ceramidi mantengono la pelle idratata. Adatto a pelli sensibili e secche.	Massaggiare la pelle bagnata con movimenti circolari delicati e risciacquare. 2–3 volte a settimana.	Ceramidi e complesso esfoliante naturale.	443	it	127
Illiyoon Ultra Moisture Scrub Wash	Exfoliating body wash	A gentle exfoliating body wash for silky-smooth skin. Natural exfoliating particles remove dry, flaky skin softly while ceramides keep the skin moisturised. Suitable for sensitive and dry skin.	Massage onto wet skin in gentle circles and rinse. Use 2–3 times a week.	Ceramides and a natural exfoliating complex.	444	en	127
Mixsoon Bean Essence	Essence	A pure essence made from 100 % fermented soybean extract. It gives long-lasting moisture, refines and evens the skin tone for a natural glow, and strengthens the skin barrier. Minimal and effective, for sensitive, dry and irritated skin.	After toner, pat a few drops into the skin before serum and cream.	100 % fermented soybean extract. No additives, colours or essential oils.	580	en	182
Mixsoon Bean Essence	Essenz	Die Bean Essence von mixsoon besteht aus 100 % fermentiertem Sojabohnenextrakt. Sie spendet intensive Feuchtigkeit, verbessert den Hautton und stärkt die Hautbarriere – für eine gesunde, strahlende Haut. Minimal und effektiv, besonders für empfindliche, trockene und gereizte Haut.	Nach dem Gesichtswasser einige Tropfen in die Haut einklopfen, vor Serum und Creme.	100 % fermentierter Sojabohnenextrakt. Ohne Zusatzstoffe, Farbstoffe und ätherische Öle.	581	de	183
Mixsoon Bean Essence	Essence	Une essence pure composée à 100 % d’extrait de soja fermenté. Elle hydrate durablement, affine et unifie le teint pour un éclat naturel et renforce la barrière cutanée. Minimaliste et efficace, pour peaux sensibles, sèches et irritées.	Après la lotion, faire pénétrer quelques gouttes en tapotant, avant le sérum et la crème.	100 % d’extrait de soja fermenté. Sans additifs, colorants ni huiles essentielles.	582	fr	183
Mixsoon Bean Essence	Essenza	Un’essenza pura composta al 100 % da estratto di soia fermentato. Idrata a lungo, affina e uniforma l’incarnato per un glow naturale e rafforza la barriera cutanea. Minimalista ed efficace, per pelli sensibili, secche e irritate.	Dopo il tonico picchiettare qualche goccia sulla pelle, prima di siero e crema.	100 % estratto di soia fermentato. Senza additivi, coloranti e oli essenziali.	583	it	183
Mixsoon Bean Essence	Essence	A pure essence made from 100 % fermented soybean extract. It gives long-lasting moisture, refines and evens the skin tone for a natural glow, and strengthens the skin barrier. Minimal and effective, for sensitive, dry and irritated skin.	After toner, pat a few drops into the skin before serum and cream.	100 % fermented soybean extract. No additives, colours or essential oils.	584	en	183
Anua Heartleaf 77% Soothing Toner	Toner	A mild, soothing toner with 77 % heartleaf extract and hyaluronic acid for healthy, hydrated skin. It calms sensitive skin and redness, gives long-lasting moisture and strengthens the skin barrier, with a light texture that absorbs quickly. For sensitive, dry and irritated skin.	After cleansing, apply with your hands or a cotton pad and pat in gently.	77 % heartleaf (houttuynia cordata) extract and hyaluronic acid. Free from parabens, alcohol and fragrance.	585	en	184
Anua Heartleaf 77% Soothing Toner	Gesichtswasser	Beruhigender Toner für gesunde, hydrierte Haut. Die milde Formel mit 77 % Herzblatt-Extrakt und Hyaluronsäure spendet intensiv Feuchtigkeit, beruhigt gereizte Haut und stärkt die Hautbarriere. Leichte Textur, zieht schnell ein. Besonders für empfindliche, trockene und gereizte Haut.	Nach der Reinigung mit den Händen oder einem Wattepad auftragen und sanft einklopfen.	77 % Herzblatt-Extrakt (Houttuynia Cordata) und Hyaluronsäure. Frei von Parabenen, Alkohol und Duftstoffen.	586	de	185
Anua Heartleaf 77% Soothing Toner	Toner	A mild, soothing toner with 77 % heartleaf extract and hyaluronic acid for healthy, hydrated skin. It calms sensitive skin and redness, gives long-lasting moisture and strengthens the skin barrier, with a light texture that absorbs quickly. For sensitive, dry and irritated skin.	After cleansing, apply with your hands or a cotton pad and pat in gently.	77 % heartleaf (houttuynia cordata) extract and hyaluronic acid. Free from parabens, alcohol and fragrance.	587	en	185
Anua Heartleaf 77% Soothing Toner	Gesichtswasser	Beruhigender Toner für gesunde, hydrierte Haut. Die milde Formel mit 77 % Herzblatt-Extrakt und Hyaluronsäure spendet intensiv Feuchtigkeit, beruhigt gereizte Haut und stärkt die Hautbarriere. Leichte Textur, zieht schnell ein. Besonders für empfindliche, trockene und gereizte Haut.	Nach der Reinigung mit den Händen oder einem Wattepad auftragen und sanft einklopfen.	77 % Herzblatt-Extrakt (Houttuynia Cordata) und Hyaluronsäure. Frei von Parabenen, Alkohol und Duftstoffen.	588	de	186
Anua Heartleaf 77% Soothing Toner	Lotion tonique	Une lotion tonique douce et apaisante à 77 % d’extrait de houttuynia et acide hyaluronique pour une peau saine et hydratée. Elle calme les peaux sensibles et les rougeurs, hydrate durablement et renforce la barrière cutanée, avec une texture légère. Pour peaux sensibles, sèches et irritées.	Après le nettoyage, appliquer avec les mains ou un coton et faire pénétrer en tapotant.	77 % d’extrait de houttuynia cordata et acide hyaluronique. Sans parabènes, alcool ni parfum.	589	fr	186
Anua Heartleaf 77% Soothing Toner	Toner	A mild, soothing toner with 77 % heartleaf extract and hyaluronic acid for healthy, hydrated skin. It calms sensitive skin and redness, gives long-lasting moisture and strengthens the skin barrier, with a light texture that absorbs quickly. For sensitive, dry and irritated skin.	After cleansing, apply with your hands or a cotton pad and pat in gently.	77 % heartleaf (houttuynia cordata) extract and hyaluronic acid. Free from parabens, alcohol and fragrance.	590	en	186
Anua Heartleaf 77% Soothing Toner	Gesichtswasser	Beruhigender Toner für gesunde, hydrierte Haut. Die milde Formel mit 77 % Herzblatt-Extrakt und Hyaluronsäure spendet intensiv Feuchtigkeit, beruhigt gereizte Haut und stärkt die Hautbarriere. Leichte Textur, zieht schnell ein. Besonders für empfindliche, trockene und gereizte Haut.	Nach der Reinigung mit den Händen oder einem Wattepad auftragen und sanft einklopfen.	77 % Herzblatt-Extrakt (Houttuynia Cordata) und Hyaluronsäure. Frei von Parabenen, Alkohol und Duftstoffen.	591	de	187
Anua Heartleaf 77% Soothing Toner	Lotion tonique	Une lotion tonique douce et apaisante à 77 % d’extrait de houttuynia et acide hyaluronique pour une peau saine et hydratée. Elle calme les peaux sensibles et les rougeurs, hydrate durablement et renforce la barrière cutanée, avec une texture légère. Pour peaux sensibles, sèches et irritées.	Après le nettoyage, appliquer avec les mains ou un coton et faire pénétrer en tapotant.	77 % d’extrait de houttuynia cordata et acide hyaluronique. Sans parabènes, alcool ni parfum.	592	fr	187
Anua Heartleaf 77% Soothing Toner	Tonico	Un tonico delicato e lenitivo con il 77 % di estratto di houttuynia e acido ialuronico per una pelle sana e idratata. Calma pelli sensibili e rossori, idrata a lungo e rafforza la barriera cutanea, con una texture leggera. Per pelli sensibili, secche e irritate.	Dopo la detersione applicare con le mani o un dischetto e picchiettare delicatamente.	77 % di estratto di houttuynia cordata e acido ialuronico. Senza parabeni, alcol e profumo.	593	it	187
Anua Heartleaf 77% Soothing Toner	Toner	A mild, soothing toner with 77 % heartleaf extract and hyaluronic acid for healthy, hydrated skin. It calms sensitive skin and redness, gives long-lasting moisture and strengthens the skin barrier, with a light texture that absorbs quickly. For sensitive, dry and irritated skin.	After cleansing, apply with your hands or a cotton pad and pat in gently.	77 % heartleaf (houttuynia cordata) extract and hyaluronic acid. Free from parabens, alcohol and fragrance.	594	en	187
COSRX Advanced Snail 96 Mucin Power Essence	Essence	A light essence with 96 % snail secretion filtrate that repairs, hydrates and regenerates. It strengthens the skin barrier, plumps the skin with long-lasting moisture and refines the skin texture, while calming blemishes and redness. Especially good for dry and damaged skin.	After toner, pat a few drops into the skin before serum and cream.	96 % snail secretion filtrate. Free from parabens and silicones.	595	en	188
COSRX Advanced Snail 96 Mucin Power Essence	Essenz	Diese leichte Essence mit 96 % Schneckenschleimfiltrat versorgt die Haut intensiv mit Feuchtigkeit, unterstützt die Regeneration und verleiht ein gesundes, strahlendes Hautbild. Repariert die Hautbarriere, verbessert die Hauttextur und mildert Unreinheiten und Rötungen. Besonders für trockene und geschädigte Haut.	Nach dem Gesichtswasser einige Tropfen in die Haut einklopfen, vor Serum und Creme.	96 % Schneckenschleimfiltrat. Frei von Parabenen und Silikonen.	596	de	189
COSRX Advanced Snail 96 Mucin Power Essence	Essence	A light essence with 96 % snail secretion filtrate that repairs, hydrates and regenerates. It strengthens the skin barrier, plumps the skin with long-lasting moisture and refines the skin texture, while calming blemishes and redness. Especially good for dry and damaged skin.	After toner, pat a few drops into the skin before serum and cream.	96 % snail secretion filtrate. Free from parabens and silicones.	597	en	189
COSRX Advanced Snail 96 Mucin Power Essence	Essenz	Diese leichte Essence mit 96 % Schneckenschleimfiltrat versorgt die Haut intensiv mit Feuchtigkeit, unterstützt die Regeneration und verleiht ein gesundes, strahlendes Hautbild. Repariert die Hautbarriere, verbessert die Hauttextur und mildert Unreinheiten und Rötungen. Besonders für trockene und geschädigte Haut.	Nach dem Gesichtswasser einige Tropfen in die Haut einklopfen, vor Serum und Creme.	96 % Schneckenschleimfiltrat. Frei von Parabenen und Silikonen.	598	de	190
COSRX Advanced Snail 96 Mucin Power Essence	Essence	Une essence légère à 96 % de filtrat de bave d’escargot qui répare, hydrate et régénère. Elle renforce la barrière cutanée, repulpe la peau d’une hydratation durable et affine le grain de peau tout en apaisant imperfections et rougeurs. Idéale pour les peaux sèches et abîmées.	Après la lotion, faire pénétrer quelques gouttes en tapotant, avant le sérum et la crème.	96 % de filtrat de bave d’escargot. Sans parabènes ni silicones.	599	fr	190
COSRX Advanced Snail 96 Mucin Power Essence	Essence	A light essence with 96 % snail secretion filtrate that repairs, hydrates and regenerates. It strengthens the skin barrier, plumps the skin with long-lasting moisture and refines the skin texture, while calming blemishes and redness. Especially good for dry and damaged skin.	After toner, pat a few drops into the skin before serum and cream.	96 % snail secretion filtrate. Free from parabens and silicones.	600	en	190
COSRX Advanced Snail 96 Mucin Power Essence	Essenz	Diese leichte Essence mit 96 % Schneckenschleimfiltrat versorgt die Haut intensiv mit Feuchtigkeit, unterstützt die Regeneration und verleiht ein gesundes, strahlendes Hautbild. Repariert die Hautbarriere, verbessert die Hauttextur und mildert Unreinheiten und Rötungen. Besonders für trockene und geschädigte Haut.	Nach dem Gesichtswasser einige Tropfen in die Haut einklopfen, vor Serum und Creme.	96 % Schneckenschleimfiltrat. Frei von Parabenen und Silikonen.	601	de	191
COSRX Advanced Snail 96 Mucin Power Essence	Essence	Une essence légère à 96 % de filtrat de bave d’escargot qui répare, hydrate et régénère. Elle renforce la barrière cutanée, repulpe la peau d’une hydratation durable et affine le grain de peau tout en apaisant imperfections et rougeurs. Idéale pour les peaux sèches et abîmées.	Après la lotion, faire pénétrer quelques gouttes en tapotant, avant le sérum et la crème.	96 % de filtrat de bave d’escargot. Sans parabènes ni silicones.	602	fr	191
COSRX Advanced Snail 96 Mucin Power Essence	Essenza	Un’essenza leggera con il 96 % di filtrato di bava di lumaca che ripara, idrata e rigenera. Rafforza la barriera cutanea, rimpolpa la pelle con un’idratazione duratura e affina la grana della pelle, lenendo imperfezioni e rossori. Ideale per pelli secche e danneggiate.	Dopo il tonico picchiettare qualche goccia sulla pelle, prima di siero e crema.	96 % di filtrato di bava di lumaca. Senza parabeni e siliconi.	603	it	191
COSRX Advanced Snail 96 Mucin Power Essence	Essence	A light essence with 96 % snail secretion filtrate that repairs, hydrates and regenerates. It strengthens the skin barrier, plumps the skin with long-lasting moisture and refines the skin texture, while calming blemishes and redness. Especially good for dry and damaged skin.	After toner, pat a few drops into the skin before serum and cream.	96 % snail secretion filtrate. Free from parabens and silicones.	604	en	191
Anua PDRN Hyaluronic Glow Pad	Toner pads	Toner pads with PDRN and hyaluronic acid for radiant, hydrated and calm skin every day. They give deep hydration, refine the skin texture for a natural glow and soothe sensitive skin. One pad, one step: perfect for a quick daily routine.	After cleansing, sweep a pad over the face and pat the remaining essence into the skin.	PDRN and hyaluronic acid.	605	en	192
Anua PDRN Hyaluronic Glow Pad	Toner-Pads	Für strahlende, hydratisierte und beruhigte Haut – jeden Tag. Mit PDRN und Hyaluronsäure für tiefenwirksame Hydration, verfeinert das Hautbild für einen natürlichen Glow und beruhigt empfindliche Haut. Einfach in der Anwendung, perfekt für die tägliche Skincare-Routine.	Nach der Reinigung mit einem Pad über das Gesicht streichen und die restliche Essenz einklopfen.	PDRN und Hyaluronsäure.	606	de	193
Anua PDRN Hyaluronic Glow Pad	Toner pads	Toner pads with PDRN and hyaluronic acid for radiant, hydrated and calm skin every day. They give deep hydration, refine the skin texture for a natural glow and soothe sensitive skin. One pad, one step: perfect for a quick daily routine.	After cleansing, sweep a pad over the face and pat the remaining essence into the skin.	PDRN and hyaluronic acid.	607	en	193
Anua PDRN Hyaluronic Glow Pad	Toner-Pads	Für strahlende, hydratisierte und beruhigte Haut – jeden Tag. Mit PDRN und Hyaluronsäure für tiefenwirksame Hydration, verfeinert das Hautbild für einen natürlichen Glow und beruhigt empfindliche Haut. Einfach in der Anwendung, perfekt für die tägliche Skincare-Routine.	Nach der Reinigung mit einem Pad über das Gesicht streichen und die restliche Essenz einklopfen.	PDRN und Hyaluronsäure.	608	de	194
Anua PDRN Hyaluronic Glow Pad	Disques tonifiants	Des disques tonifiants au PDRN et à l’acide hyaluronique pour une peau lumineuse, hydratée et apaisée au quotidien. Ils hydratent en profondeur, affinent le grain de peau pour un éclat naturel et apaisent les peaux sensibles. Un disque, une étape : idéal pour une routine rapide.	Après le nettoyage, passer un disque sur le visage et faire pénétrer l’essence restante en tapotant.	PDRN et acide hyaluronique.	609	fr	194
Mediheal Collagen Mask	Masque en tissu, 1 pièce	Un masque en tissu au collagène qui hydrate et améliore l’élasticité de la peau. Pour les peaux sèches ou fatiguées qui ont besoin de rebond. Pour tous les types de peau.	Après la lotion, poser le masque 15 à 20 minutes, le retirer et faire pénétrer l’essence restante.	\N	719	fr	238
Anua PDRN Hyaluronic Glow Pad	Toner-Pads	Für strahlende, hydratisierte und beruhigte Haut – jeden Tag. Mit PDRN und Hyaluronsäure für tiefenwirksame Hydration, verfeinert das Hautbild für einen natürlichen Glow und beruhigt empfindliche Haut. Einfach in der Anwendung, perfekt für die tägliche Skincare-Routine.	Nach der Reinigung mit einem Pad über das Gesicht streichen und die restliche Essenz einklopfen.	PDRN und Hyaluronsäure.	611	de	195
Anua PDRN Hyaluronic Glow Pad	Disques tonifiants	Des disques tonifiants au PDRN et à l’acide hyaluronique pour une peau lumineuse, hydratée et apaisée au quotidien. Ils hydratent en profondeur, affinent le grain de peau pour un éclat naturel et apaisent les peaux sensibles. Un disque, une étape : idéal pour une routine rapide.	Après le nettoyage, passer un disque sur le visage et faire pénétrer l’essence restante en tapotant.	PDRN et acide hyaluronique.	612	fr	195
Anua PDRN Hyaluronic Glow Pad	Dischetti tonificanti	Dischetti tonificanti con PDRN e acido ialuronico per una pelle luminosa, idratata e calma ogni giorno. Idratano in profondità, affinano la grana per un glow naturale e leniscono le pelli sensibili. Un dischetto, un passaggio: perfetti per una routine veloce.	Dopo la detersione passare un dischetto sul viso e picchiettare l’essenza rimasta.	PDRN e acido ialuronico.	613	it	195
Anua PDRN Hyaluronic Glow Pad	Toner pads	Toner pads with PDRN and hyaluronic acid for radiant, hydrated and calm skin every day. They give deep hydration, refine the skin texture for a natural glow and soothe sensitive skin. One pad, one step: perfect for a quick daily routine.	After cleansing, sweep a pad over the face and pat the remaining essence into the skin.	PDRN and hyaluronic acid.	614	en	195
Innisfree Green Tea Seed Hyaluronic Serum	Serum	A hydrating serum with hyaluronic acid and green tea from Jeju for moisture, balance and radiant skin. It prevents dryness, calms and protects with amino acids and antioxidants, and leaves skin revitalised and glowing. Light, fast-absorbing and never sticky.	After toner, apply 2–3 drops to the face and pat in before your cream.	Hyaluronic acid and green tea from Jeju (amino acids, antioxidants). Vegan.	615	en	196
Innisfree Green Tea Seed Hyaluronic Serum	Serum	Feuchtigkeit. Balance. Strahlende Haut. Hyaluronsäure spendet Feuchtigkeit und bewahrt die Haut vor dem Austrocknen, grüner Tee aus Jeju liefert Aminosäuren und Antioxidantien, beruhigt und schützt. Für einen frischen, strahlenden Teint – leicht, schnell einziehend und ohne zu kleben.	Nach dem Gesichtswasser 2–3 Tropfen auf das Gesicht geben und vor der Creme einklopfen.	Hyaluronsäure und grüner Tee aus Jeju (Aminosäuren, Antioxidantien). Vegan.	616	de	197
Innisfree Green Tea Seed Hyaluronic Serum	Serum	A hydrating serum with hyaluronic acid and green tea from Jeju for moisture, balance and radiant skin. It prevents dryness, calms and protects with amino acids and antioxidants, and leaves skin revitalised and glowing. Light, fast-absorbing and never sticky.	After toner, apply 2–3 drops to the face and pat in before your cream.	Hyaluronic acid and green tea from Jeju (amino acids, antioxidants). Vegan.	617	en	197
Innisfree Green Tea Seed Hyaluronic Serum	Serum	Feuchtigkeit. Balance. Strahlende Haut. Hyaluronsäure spendet Feuchtigkeit und bewahrt die Haut vor dem Austrocknen, grüner Tee aus Jeju liefert Aminosäuren und Antioxidantien, beruhigt und schützt. Für einen frischen, strahlenden Teint – leicht, schnell einziehend und ohne zu kleben.	Nach dem Gesichtswasser 2–3 Tropfen auf das Gesicht geben und vor der Creme einklopfen.	Hyaluronsäure und grüner Tee aus Jeju (Aminosäuren, Antioxidantien). Vegan.	618	de	198
Innisfree Green Tea Seed Hyaluronic Serum	Sérum	Un sérum hydratant à l’acide hyaluronique et au thé vert de Jeju pour une peau hydratée, équilibrée et lumineuse. Il prévient le dessèchement, apaise et protège grâce aux acides aminés et antioxydants. Léger, il pénètre vite sans coller.	Après la lotion, appliquer 2 à 3 gouttes sur le visage et tapoter avant la crème.	Acide hyaluronique et thé vert de Jeju (acides aminés, antioxydants). Vegan.	619	fr	198
Innisfree Green Tea Seed Hyaluronic Serum	Serum	A hydrating serum with hyaluronic acid and green tea from Jeju for moisture, balance and radiant skin. It prevents dryness, calms and protects with amino acids and antioxidants, and leaves skin revitalised and glowing. Light, fast-absorbing and never sticky.	After toner, apply 2–3 drops to the face and pat in before your cream.	Hyaluronic acid and green tea from Jeju (amino acids, antioxidants). Vegan.	620	en	198
Innisfree Green Tea Seed Hyaluronic Serum	Serum	Feuchtigkeit. Balance. Strahlende Haut. Hyaluronsäure spendet Feuchtigkeit und bewahrt die Haut vor dem Austrocknen, grüner Tee aus Jeju liefert Aminosäuren und Antioxidantien, beruhigt und schützt. Für einen frischen, strahlenden Teint – leicht, schnell einziehend und ohne zu kleben.	Nach dem Gesichtswasser 2–3 Tropfen auf das Gesicht geben und vor der Creme einklopfen.	Hyaluronsäure und grüner Tee aus Jeju (Aminosäuren, Antioxidantien). Vegan.	621	de	199
Innisfree Green Tea Seed Hyaluronic Serum	Sérum	Un sérum hydratant à l’acide hyaluronique et au thé vert de Jeju pour une peau hydratée, équilibrée et lumineuse. Il prévient le dessèchement, apaise et protège grâce aux acides aminés et antioxydants. Léger, il pénètre vite sans coller.	Après la lotion, appliquer 2 à 3 gouttes sur le visage et tapoter avant la crème.	Acide hyaluronique et thé vert de Jeju (acides aminés, antioxydants). Vegan.	622	fr	199
Innisfree Green Tea Seed Hyaluronic Serum	Siero	Un siero idratante con acido ialuronico e tè verde di Jeju per una pelle idratata, equilibrata e luminosa. Previene la secchezza, lenisce e protegge con aminoacidi e antiossidanti. Leggero, si assorbe in fretta senza appiccicare.	Dopo il tonico applicare 2–3 gocce sul viso e picchiettare prima della crema.	Acido ialuronico e tè verde di Jeju (aminoacidi, antiossidanti). Vegano.	623	it	199
Innisfree Green Tea Seed Hyaluronic Serum	Serum	A hydrating serum with hyaluronic acid and green tea from Jeju for moisture, balance and radiant skin. It prevents dryness, calms and protects with amino acids and antioxidants, and leaves skin revitalised and glowing. Light, fast-absorbing and never sticky.	After toner, apply 2–3 drops to the face and pat in before your cream.	Hyaluronic acid and green tea from Jeju (amino acids, antioxidants). Vegan.	624	en	199
Beauty of Joseon Revive Eye Serum Ginseng + Retinal	Eye serum	A highly effective eye serum with ginseng and retinal for a visibly smoother, firmer and brighter eye area. Ginseng revitalises and strengthens delicate skin, retinal supports cell renewal and reduces fine lines, and intense moisture keeps the area supple. Gentle enough for sensitive skin.	Morning and evening, tap a small amount gently around the eye area.	Ginseng extract and retinal. Vegan, cruelty-free.	625	en	200
Beauty of Joseon Glow Serum Propolis + Niacinamide	Serum	A glow serum with 60 % propolis extract and niacinamide for radiant, deeply cared-for skin. Propolis nourishes and strengthens the skin barrier, niacinamide refines the complexion and evens the skin tone, and the light texture absorbs quickly. Suitable for all skin types, including sensitive skin.	After toner, apply 2–3 drops to the face and pat in before your cream.	60 % propolis extract and niacinamide. Vegan, cruelty-free.	640	en	206
Beauty of Joseon Revive Eye Serum Ginseng + Retinal	Augenserum	Ein hochwirksames Augenserum mit Ginseng und Retinal für sichtbar glattere, straffere und strahlendere Augenpartie. Ginseng-Extrakt vitalisiert und stärkt, Retinal unterstützt die Zellerneuerung und mindert feine Linien, intensive Feuchtigkeit bewahrt die Elastizität. Speziell für die empfindliche Augenpartie entwickelt.	Morgens und abends eine kleine Menge sanft um die Augenpartie einklopfen.	Ginseng-Extrakt und Retinal. Vegan, tierversuchsfrei.	626	de	201
Beauty of Joseon Revive Eye Serum Ginseng + Retinal	Eye serum	A highly effective eye serum with ginseng and retinal for a visibly smoother, firmer and brighter eye area. Ginseng revitalises and strengthens delicate skin, retinal supports cell renewal and reduces fine lines, and intense moisture keeps the area supple. Gentle enough for sensitive skin.	Morning and evening, tap a small amount gently around the eye area.	Ginseng extract and retinal. Vegan, cruelty-free.	627	en	201
Beauty of Joseon Revive Eye Serum Ginseng + Retinal	Augenserum	Ein hochwirksames Augenserum mit Ginseng und Retinal für sichtbar glattere, straffere und strahlendere Augenpartie. Ginseng-Extrakt vitalisiert und stärkt, Retinal unterstützt die Zellerneuerung und mindert feine Linien, intensive Feuchtigkeit bewahrt die Elastizität. Speziell für die empfindliche Augenpartie entwickelt.	Morgens und abends eine kleine Menge sanft um die Augenpartie einklopfen.	Ginseng-Extrakt und Retinal. Vegan, tierversuchsfrei.	628	de	202
Beauty of Joseon Revive Eye Serum Ginseng + Retinal	Sérum contour des yeux	Un sérum contour des yeux très efficace au ginseng et au rétinal pour un regard visiblement plus lisse, plus ferme et plus lumineux. Le ginseng revitalise, le rétinal soutient le renouvellement cellulaire et atténue les ridules, et une hydratation intense préserve la souplesse. Spécialement conçu pour la zone délicate des yeux.	Matin et soir, tapoter délicatement une petite quantité sur le contour des yeux.	Extrait de ginseng et rétinal. Vegan, non testé sur les animaux.	629	fr	202
Beauty of Joseon Revive Eye Serum Ginseng + Retinal	Eye serum	A highly effective eye serum with ginseng and retinal for a visibly smoother, firmer and brighter eye area. Ginseng revitalises and strengthens delicate skin, retinal supports cell renewal and reduces fine lines, and intense moisture keeps the area supple. Gentle enough for sensitive skin.	Morning and evening, tap a small amount gently around the eye area.	Ginseng extract and retinal. Vegan, cruelty-free.	630	en	202
Beauty of Joseon Revive Eye Serum Ginseng + Retinal	Augenserum	Ein hochwirksames Augenserum mit Ginseng und Retinal für sichtbar glattere, straffere und strahlendere Augenpartie. Ginseng-Extrakt vitalisiert und stärkt, Retinal unterstützt die Zellerneuerung und mindert feine Linien, intensive Feuchtigkeit bewahrt die Elastizität. Speziell für die empfindliche Augenpartie entwickelt.	Morgens und abends eine kleine Menge sanft um die Augenpartie einklopfen.	Ginseng-Extrakt und Retinal. Vegan, tierversuchsfrei.	631	de	203
Beauty of Joseon Revive Eye Serum Ginseng + Retinal	Sérum contour des yeux	Un sérum contour des yeux très efficace au ginseng et au rétinal pour un regard visiblement plus lisse, plus ferme et plus lumineux. Le ginseng revitalise, le rétinal soutient le renouvellement cellulaire et atténue les ridules, et une hydratation intense préserve la souplesse. Spécialement conçu pour la zone délicate des yeux.	Matin et soir, tapoter délicatement une petite quantité sur le contour des yeux.	Extrait de ginseng et rétinal. Vegan, non testé sur les animaux.	632	fr	203
Beauty of Joseon Revive Eye Serum Ginseng + Retinal	Siero contorno occhi	Un siero contorno occhi molto efficace con ginseng e retinale per uno sguardo visibilmente più liscio, tonico e luminoso. Il ginseng rivitalizza, il retinale sostiene il rinnovamento cellulare e attenua le linee sottili, e un’idratazione intensa preserva l’elasticità. Studiato per la zona delicata degli occhi.	Mattina e sera picchiettare delicatamente una piccola quantità sul contorno occhi.	Estratto di ginseng e retinale. Vegano, cruelty-free.	633	it	203
Beauty of Joseon Revive Eye Serum Ginseng + Retinal	Eye serum	A highly effective eye serum with ginseng and retinal for a visibly smoother, firmer and brighter eye area. Ginseng revitalises and strengthens delicate skin, retinal supports cell renewal and reduces fine lines, and intense moisture keeps the area supple. Gentle enough for sensitive skin.	Morning and evening, tap a small amount gently around the eye area.	Ginseng extract and retinal. Vegan, cruelty-free.	634	en	203
Beauty of Joseon Glow Serum Propolis + Niacinamide	Serum	A glow serum with 60 % propolis extract and niacinamide for radiant, deeply cared-for skin. Propolis nourishes and strengthens the skin barrier, niacinamide refines the complexion and evens the skin tone, and the light texture absorbs quickly. Suitable for all skin types, including sensitive skin.	After toner, apply 2–3 drops to the face and pat in before your cream.	60 % propolis extract and niacinamide. Vegan, cruelty-free.	635	en	204
Beauty of Joseon Glow Serum Propolis + Niacinamide	Serum	Strahlende Haut, tiefenwirksam gepflegt. Propolis-Extrakt (60 %) nährt und stärkt die Hautbarriere, Niacinamid verfeinert das Hautbild und sorgt für einen ebenmässigen Teint. Leichte, nicht klebrige Textur, zieht schnell ein und spendet intensive Feuchtigkeit. Für alle Hauttypen, auch für empfindliche Haut.	Nach dem Gesichtswasser 2–3 Tropfen auf das Gesicht geben und vor der Creme einklopfen.	60 % Propolis-Extrakt und Niacinamid. Vegan, tierversuchsfrei.	636	de	205
Beauty of Joseon Glow Serum Propolis + Niacinamide	Serum	A glow serum with 60 % propolis extract and niacinamide for radiant, deeply cared-for skin. Propolis nourishes and strengthens the skin barrier, niacinamide refines the complexion and evens the skin tone, and the light texture absorbs quickly. Suitable for all skin types, including sensitive skin.	After toner, apply 2–3 drops to the face and pat in before your cream.	60 % propolis extract and niacinamide. Vegan, cruelty-free.	637	en	205
Beauty of Joseon Glow Serum Propolis + Niacinamide	Serum	Strahlende Haut, tiefenwirksam gepflegt. Propolis-Extrakt (60 %) nährt und stärkt die Hautbarriere, Niacinamid verfeinert das Hautbild und sorgt für einen ebenmässigen Teint. Leichte, nicht klebrige Textur, zieht schnell ein und spendet intensive Feuchtigkeit. Für alle Hauttypen, auch für empfindliche Haut.	Nach dem Gesichtswasser 2–3 Tropfen auf das Gesicht geben und vor der Creme einklopfen.	60 % Propolis-Extrakt und Niacinamid. Vegan, tierversuchsfrei.	638	de	206
Beauty of Joseon Glow Serum Propolis + Niacinamide	Sérum	Un sérum éclat à 60 % d’extrait de propolis et niacinamide pour une peau lumineuse et nourrie en profondeur. La propolis nourrit et renforce la barrière cutanée, la niacinamide affine le grain de peau et unifie le teint, et la texture légère pénètre vite. Pour tous les types de peau, même sensibles.	Après la lotion, appliquer 2 à 3 gouttes sur le visage et tapoter avant la crème.	60 % d’extrait de propolis et niacinamide. Vegan, non testé sur les animaux.	639	fr	206
Beauty of Joseon Glow Serum Propolis + Niacinamide	Serum	Strahlende Haut, tiefenwirksam gepflegt. Propolis-Extrakt (60 %) nährt und stärkt die Hautbarriere, Niacinamid verfeinert das Hautbild und sorgt für einen ebenmässigen Teint. Leichte, nicht klebrige Textur, zieht schnell ein und spendet intensive Feuchtigkeit. Für alle Hauttypen, auch für empfindliche Haut.	Nach dem Gesichtswasser 2–3 Tropfen auf das Gesicht geben und vor der Creme einklopfen.	60 % Propolis-Extrakt und Niacinamid. Vegan, tierversuchsfrei.	641	de	207
Beauty of Joseon Glow Serum Propolis + Niacinamide	Sérum	Un sérum éclat à 60 % d’extrait de propolis et niacinamide pour une peau lumineuse et nourrie en profondeur. La propolis nourrit et renforce la barrière cutanée, la niacinamide affine le grain de peau et unifie le teint, et la texture légère pénètre vite. Pour tous les types de peau, même sensibles.	Après la lotion, appliquer 2 à 3 gouttes sur le visage et tapoter avant la crème.	60 % d’extrait de propolis et niacinamide. Vegan, non testé sur les animaux.	642	fr	207
Beauty of Joseon Glow Serum Propolis + Niacinamide	Siero	Un siero illuminante con il 60 % di estratto di propoli e niacinamide per una pelle luminosa e nutrita in profondità. La propoli nutre e rafforza la barriera cutanea, la niacinamide affina la grana e uniforma l’incarnato, e la texture leggera si assorbe in fretta. Per tutti i tipi di pelle, anche sensibili.	Dopo il tonico applicare 2–3 gocce sul viso e picchiettare prima della crema.	60 % di estratto di propoli e niacinamide. Vegano, cruelty-free.	643	it	207
Beauty of Joseon Glow Serum Propolis + Niacinamide	Serum	A glow serum with 60 % propolis extract and niacinamide for radiant, deeply cared-for skin. Propolis nourishes and strengthens the skin barrier, niacinamide refines the complexion and evens the skin tone, and the light texture absorbs quickly. Suitable for all skin types, including sensitive skin.	After toner, apply 2–3 drops to the face and pat in before your cream.	60 % propolis extract and niacinamide. Vegan, cruelty-free.	644	en	207
Torriden Dive-In Serum	Serum	A hydrating serum with low-molecular hyaluronic acid for plump, healthy-looking skin. It penetrates deeply for long-lasting moisture, strengthens the skin barrier and leaves a refreshing, non-sticky finish. Mild enough for sensitive skin and for all skin types.	After toner, apply 2–3 drops to the face and pat in before your cream.	Low-molecular hyaluronic acid. Free from parabens, mineral oils and alcohol. Cruelty-free.	645	en	208
Torriden Dive-In Serum	Serum	Intensive Feuchtigkeit für pralle, gesunde Haut. Das DIVE IN Serum mit niedermolekularer Hyaluronsäure spendet tiefenwirksam Feuchtigkeit, beruhigt die Haut und stärkt die natürliche Hautbarriere. Leichte, nicht klebrige Textur – perfekt für jeden Hauttyp, auch für empfindliche Haut.	Nach dem Gesichtswasser 2–3 Tropfen auf das Gesicht geben und vor der Creme einklopfen.	Niedermolekulare Hyaluronsäure. Frei von Parabenen, Mineralölen und Alkohol. Tierversuchsfrei.	646	de	209
Torriden Dive-In Serum	Serum	A hydrating serum with low-molecular hyaluronic acid for plump, healthy-looking skin. It penetrates deeply for long-lasting moisture, strengthens the skin barrier and leaves a refreshing, non-sticky finish. Mild enough for sensitive skin and for all skin types.	After toner, apply 2–3 drops to the face and pat in before your cream.	Low-molecular hyaluronic acid. Free from parabens, mineral oils and alcohol. Cruelty-free.	647	en	209
Torriden Dive-In Serum	Serum	Intensive Feuchtigkeit für pralle, gesunde Haut. Das DIVE IN Serum mit niedermolekularer Hyaluronsäure spendet tiefenwirksam Feuchtigkeit, beruhigt die Haut und stärkt die natürliche Hautbarriere. Leichte, nicht klebrige Textur – perfekt für jeden Hauttyp, auch für empfindliche Haut.	Nach dem Gesichtswasser 2–3 Tropfen auf das Gesicht geben und vor der Creme einklopfen.	Niedermolekulare Hyaluronsäure. Frei von Parabenen, Mineralölen und Alkohol. Tierversuchsfrei.	648	de	210
Torriden Dive-In Serum	Sérum	Un sérum hydratant à l’acide hyaluronique de faible poids moléculaire pour une peau repulpée et saine. Il pénètre en profondeur pour une hydratation durable, renforce la barrière cutanée et laisse un fini frais et non collant. Assez doux pour les peaux sensibles et tous les types de peau.	Après la lotion, appliquer 2 à 3 gouttes sur le visage et tapoter avant la crème.	Acide hyaluronique de faible poids moléculaire. Sans parabènes, huiles minérales ni alcool. Non testé sur les animaux.	649	fr	210
Torriden Dive-In Serum	Serum	A hydrating serum with low-molecular hyaluronic acid for plump, healthy-looking skin. It penetrates deeply for long-lasting moisture, strengthens the skin barrier and leaves a refreshing, non-sticky finish. Mild enough for sensitive skin and for all skin types.	After toner, apply 2–3 drops to the face and pat in before your cream.	Low-molecular hyaluronic acid. Free from parabens, mineral oils and alcohol. Cruelty-free.	650	en	210
Torriden Dive-In Serum	Serum	Intensive Feuchtigkeit für pralle, gesunde Haut. Das DIVE IN Serum mit niedermolekularer Hyaluronsäure spendet tiefenwirksam Feuchtigkeit, beruhigt die Haut und stärkt die natürliche Hautbarriere. Leichte, nicht klebrige Textur – perfekt für jeden Hauttyp, auch für empfindliche Haut.	Nach dem Gesichtswasser 2–3 Tropfen auf das Gesicht geben und vor der Creme einklopfen.	Niedermolekulare Hyaluronsäure. Frei von Parabenen, Mineralölen und Alkohol. Tierversuchsfrei.	651	de	211
Torriden Dive-In Serum	Sérum	Un sérum hydratant à l’acide hyaluronique de faible poids moléculaire pour une peau repulpée et saine. Il pénètre en profondeur pour une hydratation durable, renforce la barrière cutanée et laisse un fini frais et non collant. Assez doux pour les peaux sensibles et tous les types de peau.	Après la lotion, appliquer 2 à 3 gouttes sur le visage et tapoter avant la crème.	Acide hyaluronique de faible poids moléculaire. Sans parabènes, huiles minérales ni alcool. Non testé sur les animaux.	652	fr	211
Torriden Dive-In Serum	Siero	Un siero idratante con acido ialuronico a basso peso molecolare per una pelle rimpolpata e sana. Penetra in profondità per un’idratazione duratura, rafforza la barriera cutanea e lascia un finish fresco e non appiccicoso. Delicato per pelli sensibili e tutti i tipi di pelle.	Dopo il tonico applicare 2–3 gocce sul viso e picchiettare prima della crema.	Acido ialuronico a basso peso molecolare. Senza parabeni, oli minerali e alcol. Cruelty-free.	653	it	211
Torriden Dive-In Serum	Serum	A hydrating serum with low-molecular hyaluronic acid for plump, healthy-looking skin. It penetrates deeply for long-lasting moisture, strengthens the skin barrier and leaves a refreshing, non-sticky finish. Mild enough for sensitive skin and for all skin types.	After toner, apply 2–3 drops to the face and pat in before your cream.	Low-molecular hyaluronic acid. Free from parabens, mineral oils and alcohol. Cruelty-free.	654	en	211
Anua 100+ Hyaluron Serum	Serum	An intensive hydrating serum with 10 types of hyaluronic acid for plump, glowing skin. It gives long-lasting moisture, smooths fine lines, strengthens the skin barrier and absorbs quickly, perfect for daily care and under make-up. Suitable for all skin types.	After toner, apply 2–3 drops to the face and pat in before your cream.	10 types of hyaluronic acid, including FORN hyaluronic acid capsules.	655	en	212
Anua 100+ Hyaluron Serum	Serum	Intensive Feuchtigkeit für pralle, gesunde Haut. Mit 10 Arten von Hyaluronsäure für maximale Feuchtigkeitsversorgung: polstert auf und glättet feine Linien, stärkt die Hautbarriere und zieht schnell ein – perfekt für die tägliche Pflege, auch unter Make-up. Für alle Hauttypen.	Nach dem Gesichtswasser 2–3 Tropfen auf das Gesicht geben und vor der Creme einklopfen.	10 Arten von Hyaluronsäure, darunter FORN-Hyaluronsäure-Kapseln.	656	de	213
Anua 100+ Hyaluron Serum	Serum	An intensive hydrating serum with 10 types of hyaluronic acid for plump, glowing skin. It gives long-lasting moisture, smooths fine lines, strengthens the skin barrier and absorbs quickly, perfect for daily care and under make-up. Suitable for all skin types.	After toner, apply 2–3 drops to the face and pat in before your cream.	10 types of hyaluronic acid, including FORN hyaluronic acid capsules.	657	en	213
Anua 100+ Hyaluron Serum	Serum	Intensive Feuchtigkeit für pralle, gesunde Haut. Mit 10 Arten von Hyaluronsäure für maximale Feuchtigkeitsversorgung: polstert auf und glättet feine Linien, stärkt die Hautbarriere und zieht schnell ein – perfekt für die tägliche Pflege, auch unter Make-up. Für alle Hauttypen.	Nach dem Gesichtswasser 2–3 Tropfen auf das Gesicht geben und vor der Creme einklopfen.	10 Arten von Hyaluronsäure, darunter FORN-Hyaluronsäure-Kapseln.	658	de	214
Anua 100+ Hyaluron Serum	Sérum	Un sérum hydratant intensif à 10 types d’acide hyaluronique pour une peau repulpée et éclatante. Il hydrate durablement, lisse les ridules, renforce la barrière cutanée et pénètre vite, idéal au quotidien et sous le maquillage. Pour tous les types de peau.	Après la lotion, appliquer 2 à 3 gouttes sur le visage et tapoter avant la crème.	10 types d’acide hyaluronique, dont des capsules d’acide hyaluronique FORN.	659	fr	214
Anua 100+ Hyaluron Serum	Serum	An intensive hydrating serum with 10 types of hyaluronic acid for plump, glowing skin. It gives long-lasting moisture, smooths fine lines, strengthens the skin barrier and absorbs quickly, perfect for daily care and under make-up. Suitable for all skin types.	After toner, apply 2–3 drops to the face and pat in before your cream.	10 types of hyaluronic acid, including FORN hyaluronic acid capsules.	660	en	214
Anua 100+ Hyaluron Serum	Serum	Intensive Feuchtigkeit für pralle, gesunde Haut. Mit 10 Arten von Hyaluronsäure für maximale Feuchtigkeitsversorgung: polstert auf und glättet feine Linien, stärkt die Hautbarriere und zieht schnell ein – perfekt für die tägliche Pflege, auch unter Make-up. Für alle Hauttypen.	Nach dem Gesichtswasser 2–3 Tropfen auf das Gesicht geben und vor der Creme einklopfen.	10 Arten von Hyaluronsäure, darunter FORN-Hyaluronsäure-Kapseln.	661	de	215
Anua 100+ Hyaluron Serum	Sérum	Un sérum hydratant intensif à 10 types d’acide hyaluronique pour une peau repulpée et éclatante. Il hydrate durablement, lisse les ridules, renforce la barrière cutanée et pénètre vite, idéal au quotidien et sous le maquillage. Pour tous les types de peau.	Après la lotion, appliquer 2 à 3 gouttes sur le visage et tapoter avant la crème.	10 types d’acide hyaluronique, dont des capsules d’acide hyaluronique FORN.	662	fr	215
Anua 100+ Hyaluron Serum	Siero	Un siero idratante intensivo con 10 tipi di acido ialuronico per una pelle rimpolpata e luminosa. Idrata a lungo, leviga le linee sottili, rafforza la barriera cutanea e si assorbe in fretta, perfetto ogni giorno e sotto il trucco. Per tutti i tipi di pelle.	Dopo il tonico applicare 2–3 gocce sul viso e picchiettare prima della crema.	10 tipi di acido ialuronico, tra cui capsule di acido ialuronico FORN.	663	it	215
Anua 100+ Hyaluron Serum	Serum	An intensive hydrating serum with 10 types of hyaluronic acid for plump, glowing skin. It gives long-lasting moisture, smooths fine lines, strengthens the skin barrier and absorbs quickly, perfect for daily care and under make-up. Suitable for all skin types.	After toner, apply 2–3 drops to the face and pat in before your cream.	10 types of hyaluronic acid, including FORN hyaluronic acid capsules.	664	en	215
Medicube PDRN Pink Peptide Serum	Serum	A regenerating serum with PDRN and peptides for radiant, smooth and healthy-looking skin. PDRN supports skin renewal and recovery, peptides improve elasticity and firmness, and deep hydration leaves a fresh, natural glow. Dermatologically tested and suitable for all skin types.	After toner, apply 2–3 drops to the face and pat in before your cream.	PDRN (sodium DNA) and a 5-type peptide complex. Vegan, free from parabens and artificial colours. Made in Korea.	665	en	216
Medicube PDRN Pink Peptide Serum	Serum	Für strahlende, glatte und gesunde Haut. PDRN fördert die Hauterneuerung und unterstützt die Heilung, Peptide verbessern die Hautstruktur und sorgen für mehr Spannkraft, tiefenwirksame Feuchtigkeit verleiht einen natürlichen Glow. Dermatologisch getestet und für alle Hauttypen geeignet.	Nach dem Gesichtswasser 2–3 Tropfen auf das Gesicht geben und vor der Creme einklopfen.	PDRN (Natrium-DNA) und ein Komplex aus 5 Peptiden. Vegan, frei von Parabenen und künstlichen Farbstoffen. Hergestellt in Korea.	666	de	217
Medicube PDRN Pink Peptide Serum	Serum	A regenerating serum with PDRN and peptides for radiant, smooth and healthy-looking skin. PDRN supports skin renewal and recovery, peptides improve elasticity and firmness, and deep hydration leaves a fresh, natural glow. Dermatologically tested and suitable for all skin types.	After toner, apply 2–3 drops to the face and pat in before your cream.	PDRN (sodium DNA) and a 5-type peptide complex. Vegan, free from parabens and artificial colours. Made in Korea.	667	en	217
Medicube PDRN Pink Peptide Serum	Serum	Für strahlende, glatte und gesunde Haut. PDRN fördert die Hauterneuerung und unterstützt die Heilung, Peptide verbessern die Hautstruktur und sorgen für mehr Spannkraft, tiefenwirksame Feuchtigkeit verleiht einen natürlichen Glow. Dermatologisch getestet und für alle Hauttypen geeignet.	Nach dem Gesichtswasser 2–3 Tropfen auf das Gesicht geben und vor der Creme einklopfen.	PDRN (Natrium-DNA) und ein Komplex aus 5 Peptiden. Vegan, frei von Parabenen und künstlichen Farbstoffen. Hergestellt in Korea.	668	de	218
Medicube PDRN Pink Peptide Serum	Sérum	Un sérum régénérant au PDRN et aux peptides pour une peau lumineuse, lisse et saine. Le PDRN soutient le renouvellement et la réparation de la peau, les peptides améliorent élasticité et fermeté, et une hydratation profonde apporte un éclat naturel. Testé dermatologiquement, pour tous les types de peau.	Après la lotion, appliquer 2 à 3 gouttes sur le visage et tapoter avant la crème.	PDRN (ADN de sodium) et complexe de 5 peptides. Vegan, sans parabènes ni colorants artificiels. Fabriqué en Corée.	669	fr	218
Medicube PDRN Pink Peptide Serum	Serum	A regenerating serum with PDRN and peptides for radiant, smooth and healthy-looking skin. PDRN supports skin renewal and recovery, peptides improve elasticity and firmness, and deep hydration leaves a fresh, natural glow. Dermatologically tested and suitable for all skin types.	After toner, apply 2–3 drops to the face and pat in before your cream.	PDRN (sodium DNA) and a 5-type peptide complex. Vegan, free from parabens and artificial colours. Made in Korea.	670	en	218
Medicube PDRN Pink Peptide Serum	Serum	Für strahlende, glatte und gesunde Haut. PDRN fördert die Hauterneuerung und unterstützt die Heilung, Peptide verbessern die Hautstruktur und sorgen für mehr Spannkraft, tiefenwirksame Feuchtigkeit verleiht einen natürlichen Glow. Dermatologisch getestet und für alle Hauttypen geeignet.	Nach dem Gesichtswasser 2–3 Tropfen auf das Gesicht geben und vor der Creme einklopfen.	PDRN (Natrium-DNA) und ein Komplex aus 5 Peptiden. Vegan, frei von Parabenen und künstlichen Farbstoffen. Hergestellt in Korea.	671	de	219
Medicube PDRN Pink Peptide Serum	Sérum	Un sérum régénérant au PDRN et aux peptides pour une peau lumineuse, lisse et saine. Le PDRN soutient le renouvellement et la réparation de la peau, les peptides améliorent élasticité et fermeté, et une hydratation profonde apporte un éclat naturel. Testé dermatologiquement, pour tous les types de peau.	Après la lotion, appliquer 2 à 3 gouttes sur le visage et tapoter avant la crème.	PDRN (ADN de sodium) et complexe de 5 peptides. Vegan, sans parabènes ni colorants artificiels. Fabriqué en Corée.	672	fr	219
Medicube PDRN Pink Peptide Serum	Siero	Un siero rigenerante con PDRN e peptidi per una pelle luminosa, liscia e sana. Il PDRN sostiene il rinnovamento e la riparazione della pelle, i peptidi migliorano elasticità e tonicità e un’idratazione profonda dona un glow naturale. Dermatologicamente testato, per tutti i tipi di pelle.	Dopo il tonico applicare 2–3 gocce sul viso e picchiettare prima della crema.	PDRN (DNA di sodio) e complesso di 5 peptidi. Vegano, senza parabeni e coloranti artificiali. Prodotto in Corea.	673	it	219
Medicube PDRN Pink Peptide Serum	Serum	A regenerating serum with PDRN and peptides for radiant, smooth and healthy-looking skin. PDRN supports skin renewal and recovery, peptides improve elasticity and firmness, and deep hydration leaves a fresh, natural glow. Dermatologically tested and suitable for all skin types.	After toner, apply 2–3 drops to the face and pat in before your cream.	PDRN (sodium DNA) and a 5-type peptide complex. Vegan, free from parabens and artificial colours. Made in Korea.	674	en	219
Beauty of Joseon Relief Sun Rice + Probiotics SPF50+ PA++++	Sunscreen SPF 50+	A light, moisturising sunscreen with rice bran extract and probiotics for healthy, radiant skin. SPF50+ PA++++ gives reliable protection against UVA and UVB, while the non-greasy texture absorbs quickly and suits all skin types, including sensitive skin.	As the last step of your morning routine, apply evenly to face and neck. Reapply during long sun exposure.	Rice bran extract and probiotics. Free from parabens and artificial fragrance. Cruelty-free.	675	en	220
Beauty of Joseon Relief Sun Rice + Probiotics SPF50+ PA++++	Sonnenschutz LSF 50+	Sonnenschutz. Pflege. Strahlender Teint. Leichte, feuchtigkeitsspendende Sonnencreme mit Reiskleie-Extrakt und probiotischen Inhaltsstoffen. SPF50+ PA++++ schützt zuverlässig vor UVA- und UVB-Strahlung, zieht schnell ein und hinterlässt kein fettiges Gefühl. Für alle Hauttypen, auch für empfindliche Haut.	Als letzten Schritt der Morgenroutine gleichmässig auf Gesicht und Hals auftragen. Bei längerer Sonneneinstrahlung nachcremen.	Reiskleie-Extrakt und Probiotika. Frei von Parabenen und künstlichen Duftstoffen. Tierversuchsfrei.	676	de	221
Beauty of Joseon Relief Sun Rice + Probiotics SPF50+ PA++++	Sunscreen SPF 50+	A light, moisturising sunscreen with rice bran extract and probiotics for healthy, radiant skin. SPF50+ PA++++ gives reliable protection against UVA and UVB, while the non-greasy texture absorbs quickly and suits all skin types, including sensitive skin.	As the last step of your morning routine, apply evenly to face and neck. Reapply during long sun exposure.	Rice bran extract and probiotics. Free from parabens and artificial fragrance. Cruelty-free.	677	en	221
Beauty of Joseon Relief Sun Rice + Probiotics SPF50+ PA++++	Sonnenschutz LSF 50+	Sonnenschutz. Pflege. Strahlender Teint. Leichte, feuchtigkeitsspendende Sonnencreme mit Reiskleie-Extrakt und probiotischen Inhaltsstoffen. SPF50+ PA++++ schützt zuverlässig vor UVA- und UVB-Strahlung, zieht schnell ein und hinterlässt kein fettiges Gefühl. Für alle Hauttypen, auch für empfindliche Haut.	Als letzten Schritt der Morgenroutine gleichmässig auf Gesicht und Hals auftragen. Bei längerer Sonneneinstrahlung nachcremen.	Reiskleie-Extrakt und Probiotika. Frei von Parabenen und künstlichen Duftstoffen. Tierversuchsfrei.	678	de	222
Beauty of Joseon Relief Sun Rice + Probiotics SPF50+ PA++++	Protection solaire SPF 50+	Une crème solaire légère et hydratante à l’extrait de son de riz et aux probiotiques pour une peau saine et lumineuse. SPF50+ PA++++ protège efficacement des UVA et UVB, avec une texture non grasse qui pénètre vite. Pour tous les types de peau, même sensibles.	En dernière étape de la routine du matin, appliquer uniformément sur le visage et le cou. Renouveler en cas d’exposition prolongée.	Extrait de son de riz et probiotiques. Sans parabènes ni parfums artificiels. Non testé sur les animaux.	679	fr	222
Beauty of Joseon Relief Sun Rice + Probiotics SPF50+ PA++++	Sunscreen SPF 50+	A light, moisturising sunscreen with rice bran extract and probiotics for healthy, radiant skin. SPF50+ PA++++ gives reliable protection against UVA and UVB, while the non-greasy texture absorbs quickly and suits all skin types, including sensitive skin.	As the last step of your morning routine, apply evenly to face and neck. Reapply during long sun exposure.	Rice bran extract and probiotics. Free from parabens and artificial fragrance. Cruelty-free.	680	en	222
Beauty of Joseon Relief Sun Rice + Probiotics SPF50+ PA++++	Sonnenschutz LSF 50+	Sonnenschutz. Pflege. Strahlender Teint. Leichte, feuchtigkeitsspendende Sonnencreme mit Reiskleie-Extrakt und probiotischen Inhaltsstoffen. SPF50+ PA++++ schützt zuverlässig vor UVA- und UVB-Strahlung, zieht schnell ein und hinterlässt kein fettiges Gefühl. Für alle Hauttypen, auch für empfindliche Haut.	Als letzten Schritt der Morgenroutine gleichmässig auf Gesicht und Hals auftragen. Bei längerer Sonneneinstrahlung nachcremen.	Reiskleie-Extrakt und Probiotika. Frei von Parabenen und künstlichen Duftstoffen. Tierversuchsfrei.	681	de	223
Beauty of Joseon Relief Sun Rice + Probiotics SPF50+ PA++++	Protection solaire SPF 50+	Une crème solaire légère et hydratante à l’extrait de son de riz et aux probiotiques pour une peau saine et lumineuse. SPF50+ PA++++ protège efficacement des UVA et UVB, avec une texture non grasse qui pénètre vite. Pour tous les types de peau, même sensibles.	En dernière étape de la routine du matin, appliquer uniformément sur le visage et le cou. Renouveler en cas d’exposition prolongée.	Extrait de son de riz et probiotiques. Sans parabènes ni parfums artificiels. Non testé sur les animaux.	682	fr	223
Beauty of Joseon Relief Sun Rice + Probiotics SPF50+ PA++++	Protezione solare SPF 50+	Una crema solare leggera e idratante con estratto di crusca di riso e probiotici per una pelle sana e luminosa. SPF50+ PA++++ protegge efficacemente da UVA e UVB, con una texture non grassa che si assorbe in fretta. Per tutti i tipi di pelle, anche sensibili.	Come ultimo passaggio della routine mattutina applicare uniformemente su viso e collo. Riapplicare in caso di esposizione prolungata.	Estratto di crusca di riso e probiotici. Senza parabeni e profumi artificiali. Cruelty-free.	683	it	223
Beauty of Joseon Relief Sun Rice + Probiotics SPF50+ PA++++	Sunscreen SPF 50+	A light, moisturising sunscreen with rice bran extract and probiotics for healthy, radiant skin. SPF50+ PA++++ gives reliable protection against UVA and UVB, while the non-greasy texture absorbs quickly and suits all skin types, including sensitive skin.	As the last step of your morning routine, apply evenly to face and neck. Reapply during long sun exposure.	Rice bran extract and probiotics. Free from parabens and artificial fragrance. Cruelty-free.	684	en	223
Laneige Water Sleeping Mask	Overnight mask	An overnight mask for radiant, hydrated skin by morning. It moisturises intensively while you sleep, leaves a fresh glow and smoother, softer skin, with a light gel texture that absorbs quickly. Dermatologically tested and suitable for all skin types.	As the last step of your evening routine, apply a thin layer and leave on overnight. Rinse in the morning.	\N	685	en	224
Laneige Water Sleeping Mask	Schlafmaske	Über Nacht zu strahlender, hydratisierter Haut. Versorgt die Haut über Nacht intensiv mit Feuchtigkeit, für einen frischen, strahlenden Teint am Morgen, verbessert die Hautstruktur und macht sie zart und geschmeidig. Leichte Gel-Textur, zieht schnell ein. Dermatologisch getestet, für alle Hauttypen.	Als letzten Schritt der Abendroutine dünn auftragen und über Nacht einwirken lassen. Am Morgen abwaschen.	\N	686	de	225
Laneige Water Sleeping Mask	Overnight mask	An overnight mask for radiant, hydrated skin by morning. It moisturises intensively while you sleep, leaves a fresh glow and smoother, softer skin, with a light gel texture that absorbs quickly. Dermatologically tested and suitable for all skin types.	As the last step of your evening routine, apply a thin layer and leave on overnight. Rinse in the morning.	\N	687	en	225
Laneige Water Sleeping Mask	Schlafmaske	Über Nacht zu strahlender, hydratisierter Haut. Versorgt die Haut über Nacht intensiv mit Feuchtigkeit, für einen frischen, strahlenden Teint am Morgen, verbessert die Hautstruktur und macht sie zart und geschmeidig. Leichte Gel-Textur, zieht schnell ein. Dermatologisch getestet, für alle Hauttypen.	Als letzten Schritt der Abendroutine dünn auftragen und über Nacht einwirken lassen. Am Morgen abwaschen.	\N	688	de	226
Laneige Water Sleeping Mask	Masque de nuit	Un masque de nuit pour une peau lumineuse et hydratée au réveil. Il hydrate intensément pendant le sommeil, apporte un éclat frais et une peau plus lisse et plus douce, avec une texture gel légère qui pénètre vite. Testé dermatologiquement, pour tous les types de peau.	En dernière étape de la routine du soir, appliquer une fine couche et laisser agir toute la nuit. Rincer le matin.	\N	689	fr	226
Laneige Water Sleeping Mask	Overnight mask	An overnight mask for radiant, hydrated skin by morning. It moisturises intensively while you sleep, leaves a fresh glow and smoother, softer skin, with a light gel texture that absorbs quickly. Dermatologically tested and suitable for all skin types.	As the last step of your evening routine, apply a thin layer and leave on overnight. Rinse in the morning.	\N	690	en	226
Laneige Water Sleeping Mask	Schlafmaske	Über Nacht zu strahlender, hydratisierter Haut. Versorgt die Haut über Nacht intensiv mit Feuchtigkeit, für einen frischen, strahlenden Teint am Morgen, verbessert die Hautstruktur und macht sie zart und geschmeidig. Leichte Gel-Textur, zieht schnell ein. Dermatologisch getestet, für alle Hauttypen.	Als letzten Schritt der Abendroutine dünn auftragen und über Nacht einwirken lassen. Am Morgen abwaschen.	\N	691	de	227
Laneige Water Sleeping Mask	Masque de nuit	Un masque de nuit pour une peau lumineuse et hydratée au réveil. Il hydrate intensément pendant le sommeil, apporte un éclat frais et une peau plus lisse et plus douce, avec une texture gel légère qui pénètre vite. Testé dermatologiquement, pour tous les types de peau.	En dernière étape de la routine du soir, appliquer une fine couche et laisser agir toute la nuit. Rincer le matin.	\N	692	fr	227
Laneige Water Sleeping Mask	Maschera notte	Una maschera notte per una pelle luminosa e idratata al risveglio. Idrata intensamente durante il sonno, dona un glow fresco e una pelle più liscia e morbida, con una texture in gel leggera che si assorbe in fretta. Dermatologicamente testata, per tutti i tipi di pelle.	Come ultimo passaggio della routine serale applicare uno strato sottile e lasciare agire tutta la notte. Risciacquare al mattino.	\N	693	it	227
Laneige Water Sleeping Mask	Overnight mask	An overnight mask for radiant, hydrated skin by morning. It moisturises intensively while you sleep, leaves a fresh glow and smoother, softer skin, with a light gel texture that absorbs quickly. Dermatologically tested and suitable for all skin types.	As the last step of your evening routine, apply a thin layer and leave on overnight. Rinse in the morning.	\N	694	en	227
Merikit Regenerating Calming Mask	Calming mask	A regenerating calming mask for healthy, radiant skin. It soothes irritation and redness, gives intense moisture, supports the skin’s natural regeneration and strengthens it. High-quality ingredients from nature and science, suitable for all skin types, including sensitive skin.	Apply a generous layer to clean skin, leave on for 10–15 minutes and rinse. Use 2–3 times a week.	\N	695	en	228
Merikit Regenerating Calming Mask	Beruhigende Maske	Regeneration. Beruhigung. Balance. Die Maske hilft, Rötungen zu reduzieren und die Haut spürbar zu beruhigen, spendet intensiv Feuchtigkeit, unterstützt die natürliche Regeneration und stärkt die Haut. Hochwertige Inhaltsstoffe aus Natur und Wissenschaft – für alle Hauttypen, auch für empfindliche Haut.	Grosszügig auf die gereinigte Haut auftragen, 10–15 Minuten einwirken lassen und abspülen. 2–3 Mal pro Woche.	\N	696	de	229
Merikit Regenerating Calming Mask	Calming mask	A regenerating calming mask for healthy, radiant skin. It soothes irritation and redness, gives intense moisture, supports the skin’s natural regeneration and strengthens it. High-quality ingredients from nature and science, suitable for all skin types, including sensitive skin.	Apply a generous layer to clean skin, leave on for 10–15 minutes and rinse. Use 2–3 times a week.	\N	697	en	229
Merikit Regenerating Calming Mask	Beruhigende Maske	Regeneration. Beruhigung. Balance. Die Maske hilft, Rötungen zu reduzieren und die Haut spürbar zu beruhigen, spendet intensiv Feuchtigkeit, unterstützt die natürliche Regeneration und stärkt die Haut. Hochwertige Inhaltsstoffe aus Natur und Wissenschaft – für alle Hauttypen, auch für empfindliche Haut.	Grosszügig auf die gereinigte Haut auftragen, 10–15 Minuten einwirken lassen und abspülen. 2–3 Mal pro Woche.	\N	698	de	230
Merikit Regenerating Calming Mask	Masque apaisant	Un masque apaisant et régénérant pour une peau saine et lumineuse. Il calme irritations et rougeurs, hydrate intensément, soutient la régénération naturelle et renforce la peau. Des ingrédients de qualité, entre nature et science, pour tous les types de peau, même sensibles.	Appliquer une couche généreuse sur peau propre, laisser poser 10 à 15 minutes puis rincer. 2 à 3 fois par semaine.	\N	699	fr	230
Merikit Regenerating Calming Mask	Calming mask	A regenerating calming mask for healthy, radiant skin. It soothes irritation and redness, gives intense moisture, supports the skin’s natural regeneration and strengthens it. High-quality ingredients from nature and science, suitable for all skin types, including sensitive skin.	Apply a generous layer to clean skin, leave on for 10–15 minutes and rinse. Use 2–3 times a week.	\N	700	en	230
Merikit Regenerating Calming Mask	Beruhigende Maske	Regeneration. Beruhigung. Balance. Die Maske hilft, Rötungen zu reduzieren und die Haut spürbar zu beruhigen, spendet intensiv Feuchtigkeit, unterstützt die natürliche Regeneration und stärkt die Haut. Hochwertige Inhaltsstoffe aus Natur und Wissenschaft – für alle Hauttypen, auch für empfindliche Haut.	Grosszügig auf die gereinigte Haut auftragen, 10–15 Minuten einwirken lassen und abspülen. 2–3 Mal pro Woche.	\N	701	de	231
Merikit Regenerating Calming Mask	Masque apaisant	Un masque apaisant et régénérant pour une peau saine et lumineuse. Il calme irritations et rougeurs, hydrate intensément, soutient la régénération naturelle et renforce la peau. Des ingrédients de qualité, entre nature et science, pour tous les types de peau, même sensibles.	Appliquer une couche généreuse sur peau propre, laisser poser 10 à 15 minutes puis rincer. 2 à 3 fois par semaine.	\N	702	fr	231
Merikit Regenerating Calming Mask	Maschera lenitiva	Una maschera lenitiva e rigenerante per una pelle sana e luminosa. Calma irritazioni e rossori, idrata intensamente, sostiene la rigenerazione naturale e rinforza la pelle. Ingredienti di qualità tra natura e scienza, per tutti i tipi di pelle, anche sensibili.	Applicare uno strato generoso sulla pelle pulita, lasciare in posa 10–15 minuti e risciacquare. 2–3 volte a settimana.	\N	703	it	231
Merikit Regenerating Calming Mask	Calming mask	A regenerating calming mask for healthy, radiant skin. It soothes irritation and redness, gives intense moisture, supports the skin’s natural regeneration and strengthens it. High-quality ingredients from nature and science, suitable for all skin types, including sensitive skin.	Apply a generous layer to clean skin, leave on for 10–15 minutes and rinse. Use 2–3 times a week.	\N	704	en	231
Torriden Balanceful Cica Mask	Sheet mask, 1 piece	A soothing sheet mask with cica that calms and balances the skin. Ideal after a long day or when skin feels stressed and irritated. Suitable for all skin types.	After toner, place the mask on the face for 15–20 minutes, remove and pat the remaining essence into the skin.	\N	705	en	232
Torriden Balanceful Cica Mask	Tuchmaske, 1 Stück	Eine beruhigende Tuchmaske mit Cica, die die Haut besänftigt und ins Gleichgewicht bringt. Ideal nach einem langen Tag oder wenn die Haut gestresst und gereizt ist. Für alle Hauttypen.	Nach dem Gesichtswasser 15–20 Minuten auf das Gesicht legen, abnehmen und die restliche Essenz einklopfen.	\N	706	de	233
Torriden Balanceful Cica Mask	Sheet mask, 1 piece	A soothing sheet mask with cica that calms and balances the skin. Ideal after a long day or when skin feels stressed and irritated. Suitable for all skin types.	After toner, place the mask on the face for 15–20 minutes, remove and pat the remaining essence into the skin.	\N	707	en	233
Torriden Balanceful Cica Mask	Tuchmaske, 1 Stück	Eine beruhigende Tuchmaske mit Cica, die die Haut besänftigt und ins Gleichgewicht bringt. Ideal nach einem langen Tag oder wenn die Haut gestresst und gereizt ist. Für alle Hauttypen.	Nach dem Gesichtswasser 15–20 Minuten auf das Gesicht legen, abnehmen und die restliche Essenz einklopfen.	\N	708	de	234
Torriden Balanceful Cica Mask	Masque en tissu, 1 pièce	Un masque en tissu apaisant à la cica qui calme et rééquilibre la peau. Idéal après une longue journée ou quand la peau est stressée et irritée. Pour tous les types de peau.	Après la lotion, poser le masque 15 à 20 minutes, le retirer et faire pénétrer l’essence restante.	\N	709	fr	234
Torriden Balanceful Cica Mask	Sheet mask, 1 piece	A soothing sheet mask with cica that calms and balances the skin. Ideal after a long day or when skin feels stressed and irritated. Suitable for all skin types.	After toner, place the mask on the face for 15–20 minutes, remove and pat the remaining essence into the skin.	\N	710	en	234
Torriden Balanceful Cica Mask	Tuchmaske, 1 Stück	Eine beruhigende Tuchmaske mit Cica, die die Haut besänftigt und ins Gleichgewicht bringt. Ideal nach einem langen Tag oder wenn die Haut gestresst und gereizt ist. Für alle Hauttypen.	Nach dem Gesichtswasser 15–20 Minuten auf das Gesicht legen, abnehmen und die restliche Essenz einklopfen.	\N	711	de	235
Torriden Balanceful Cica Mask	Masque en tissu, 1 pièce	Un masque en tissu apaisant à la cica qui calme et rééquilibre la peau. Idéal après une longue journée ou quand la peau est stressée et irritée. Pour tous les types de peau.	Après la lotion, poser le masque 15 à 20 minutes, le retirer et faire pénétrer l’essence restante.	\N	712	fr	235
Torriden Balanceful Cica Mask	Maschera in tessuto, 1 pezzo	Una maschera in tessuto lenitiva alla cica che calma e riequilibra la pelle. Ideale dopo una lunga giornata o quando la pelle è stressata e irritata. Per tutti i tipi di pelle.	Dopo il tonico applicare la maschera per 15–20 minuti, rimuoverla e picchiettare l’essenza rimasta.	\N	713	it	235
Torriden Balanceful Cica Mask	Sheet mask, 1 piece	A soothing sheet mask with cica that calms and balances the skin. Ideal after a long day or when skin feels stressed and irritated. Suitable for all skin types.	After toner, place the mask on the face for 15–20 minutes, remove and pat the remaining essence into the skin.	\N	714	en	235
Mediheal Collagen Mask	Sheet mask, 1 piece	A sheet mask with collagen that hydrates and improves skin elasticity. For skin that feels dry or tired and could use some extra bounce. Suitable for all skin types.	After toner, place the mask on the face for 15–20 minutes, remove and pat the remaining essence into the skin.	\N	715	en	236
Mediheal Collagen Mask	Tuchmaske, 1 Stück	Eine Tuchmaske mit Kollagen, die Feuchtigkeit spendet und die Elastizität der Haut verbessert. Für trockene oder müde Haut, die etwas mehr Spannkraft gebrauchen kann. Für alle Hauttypen.	Nach dem Gesichtswasser 15–20 Minuten auf das Gesicht legen, abnehmen und die restliche Essenz einklopfen.	\N	716	de	237
Mediheal Collagen Mask	Sheet mask, 1 piece	A sheet mask with collagen that hydrates and improves skin elasticity. For skin that feels dry or tired and could use some extra bounce. Suitable for all skin types.	After toner, place the mask on the face for 15–20 minutes, remove and pat the remaining essence into the skin.	\N	717	en	237
Mediheal Collagen Mask	Tuchmaske, 1 Stück	Eine Tuchmaske mit Kollagen, die Feuchtigkeit spendet und die Elastizität der Haut verbessert. Für trockene oder müde Haut, die etwas mehr Spannkraft gebrauchen kann. Für alle Hauttypen.	Nach dem Gesichtswasser 15–20 Minuten auf das Gesicht legen, abnehmen und die restliche Essenz einklopfen.	\N	718	de	238
Mediheal Collagen Mask	Sheet mask, 1 piece	A sheet mask with collagen that hydrates and improves skin elasticity. For skin that feels dry or tired and could use some extra bounce. Suitable for all skin types.	After toner, place the mask on the face for 15–20 minutes, remove and pat the remaining essence into the skin.	\N	720	en	238
Mediheal Collagen Mask	Sheet mask, 1 piece	A sheet mask with collagen that hydrates and improves skin elasticity. For skin that feels dry or tired and could use some extra bounce. Suitable for all skin types.	After toner, place the mask on the face for 15–20 minutes, remove and pat the remaining essence into the skin.	\N	721	en	239
Mediheal Collagen Mask	Tuchmaske, 1 Stück	Eine Tuchmaske mit Kollagen, die Feuchtigkeit spendet und die Elastizität der Haut verbessert. Für trockene oder müde Haut, die etwas mehr Spannkraft gebrauchen kann. Für alle Hauttypen.	Nach dem Gesichtswasser 15–20 Minuten auf das Gesicht legen, abnehmen und die restliche Essenz einklopfen.	\N	722	de	239
Mediheal Collagen Mask	Masque en tissu, 1 pièce	Un masque en tissu au collagène qui hydrate et améliore l’élasticité de la peau. Pour les peaux sèches ou fatiguées qui ont besoin de rebond. Pour tous les types de peau.	Après la lotion, poser le masque 15 à 20 minutes, le retirer et faire pénétrer l’essence restante.	\N	723	fr	239
Mediheal Collagen Mask	Maschera in tessuto, 1 pezzo	Una maschera in tessuto al collagene che idrata e migliora l’elasticità della pelle. Per pelli secche o stanche che hanno bisogno di più tono. Per tutti i tipi di pelle.	Dopo il tonico applicare la maschera per 15–20 minuti, rimuoverla e picchiettare l’essenza rimasta.	\N	724	it	239
Abib Gummy Sheet Mask Heartleaf Sticker	Sheet mask, 1 piece	A soothing gummy sheet mask with heartleaf that calms sensitive skin. The soft, adhering sheet sits close to the skin for a comfortable treatment. Ideal for sensitive and irritated skin.	After toner, place the mask on the face for 15–20 minutes, remove and pat the remaining essence into the skin.	\N	725	en	240
Abib Gummy Sheet Mask Heartleaf Sticker	Tuchmaske, 1 Stück	Eine beruhigende Gummy-Tuchmaske mit Herzblatt, die empfindliche Haut besänftigt. Das weiche, haftende Tuch liegt eng an der Haut an. Ideal für empfindliche und gereizte Haut.	Nach dem Gesichtswasser 15–20 Minuten auf das Gesicht legen, abnehmen und die restliche Essenz einklopfen.	\N	726	de	241
Abib Gummy Sheet Mask Heartleaf Sticker	Sheet mask, 1 piece	A soothing gummy sheet mask with heartleaf that calms sensitive skin. The soft, adhering sheet sits close to the skin for a comfortable treatment. Ideal for sensitive and irritated skin.	After toner, place the mask on the face for 15–20 minutes, remove and pat the remaining essence into the skin.	\N	727	en	241
Abib Gummy Sheet Mask Heartleaf Sticker	Tuchmaske, 1 Stück	Eine beruhigende Gummy-Tuchmaske mit Herzblatt, die empfindliche Haut besänftigt. Das weiche, haftende Tuch liegt eng an der Haut an. Ideal für empfindliche und gereizte Haut.	Nach dem Gesichtswasser 15–20 Minuten auf das Gesicht legen, abnehmen und die restliche Essenz einklopfen.	\N	728	de	242
Abib Gummy Sheet Mask Heartleaf Sticker	Masque en tissu, 1 pièce	Un masque gummy apaisant au houttuynia qui calme les peaux sensibles. Le tissu doux et adhérent épouse parfaitement la peau. Idéal pour les peaux sensibles et irritées.	Après la lotion, poser le masque 15 à 20 minutes, le retirer et faire pénétrer l’essence restante.	\N	729	fr	242
Abib Gummy Sheet Mask Heartleaf Sticker	Sheet mask, 1 piece	A soothing gummy sheet mask with heartleaf that calms sensitive skin. The soft, adhering sheet sits close to the skin for a comfortable treatment. Ideal for sensitive and irritated skin.	After toner, place the mask on the face for 15–20 minutes, remove and pat the remaining essence into the skin.	\N	730	en	242
Abib Gummy Sheet Mask Heartleaf Sticker	Tuchmaske, 1 Stück	Eine beruhigende Gummy-Tuchmaske mit Herzblatt, die empfindliche Haut besänftigt. Das weiche, haftende Tuch liegt eng an der Haut an. Ideal für empfindliche und gereizte Haut.	Nach dem Gesichtswasser 15–20 Minuten auf das Gesicht legen, abnehmen und die restliche Essenz einklopfen.	\N	731	de	243
Abib Gummy Sheet Mask Heartleaf Sticker	Masque en tissu, 1 pièce	Un masque gummy apaisant au houttuynia qui calme les peaux sensibles. Le tissu doux et adhérent épouse parfaitement la peau. Idéal pour les peaux sensibles et irritées.	Après la lotion, poser le masque 15 à 20 minutes, le retirer et faire pénétrer l’essence restante.	\N	732	fr	243
Abib Gummy Sheet Mask Heartleaf Sticker	Maschera in tessuto, 1 pezzo	Una maschera gummy lenitiva all’houttuynia che calma le pelli sensibili. Il tessuto morbido e aderente si adatta perfettamente alla pelle. Ideale per pelli sensibili e irritate.	Dopo il tonico applicare la maschera per 15–20 minuti, rimuoverla e picchiettare l’essenza rimasta.	\N	733	it	243
Abib Gummy Sheet Mask Heartleaf Sticker	Sheet mask, 1 piece	A soothing gummy sheet mask with heartleaf that calms sensitive skin. The soft, adhering sheet sits close to the skin for a comfortable treatment. Ideal for sensitive and irritated skin.	After toner, place the mask on the face for 15–20 minutes, remove and pat the remaining essence into the skin.	\N	734	en	243
Mediheal Vitamin C Mask	Sheet mask, 1 piece	A brightening sheet mask with vitamin C that revitalises the skin for a more luminous complexion. Perfect when skin looks dull or tired. Suitable for all skin types.	After toner, place the mask on the face for 15–20 minutes, remove and pat the remaining essence into the skin.	\N	735	en	244
Mediheal Vitamin C Mask	Tuchmaske, 1 Stück	Eine Tuchmaske mit Vitamin C, die die Haut belebt und für einen strahlenderen Teint sorgt. Perfekt, wenn die Haut fahl oder müde aussieht. Für alle Hauttypen.	Nach dem Gesichtswasser 15–20 Minuten auf das Gesicht legen, abnehmen und die restliche Essenz einklopfen.	\N	736	de	245
Mediheal Vitamin C Mask	Sheet mask, 1 piece	A brightening sheet mask with vitamin C that revitalises the skin for a more luminous complexion. Perfect when skin looks dull or tired. Suitable for all skin types.	After toner, place the mask on the face for 15–20 minutes, remove and pat the remaining essence into the skin.	\N	737	en	245
Mediheal Vitamin C Mask	Tuchmaske, 1 Stück	Eine Tuchmaske mit Vitamin C, die die Haut belebt und für einen strahlenderen Teint sorgt. Perfekt, wenn die Haut fahl oder müde aussieht. Für alle Hauttypen.	Nach dem Gesichtswasser 15–20 Minuten auf das Gesicht legen, abnehmen und die restliche Essenz einklopfen.	\N	738	de	246
Mediheal Vitamin C Mask	Masque en tissu, 1 pièce	Un masque en tissu à la vitamine C qui revitalise la peau pour un teint plus lumineux. Parfait quand le teint est terne ou fatigué. Pour tous les types de peau.	Après la lotion, poser le masque 15 à 20 minutes, le retirer et faire pénétrer l’essence restante.	\N	739	fr	246
Mediheal Vitamin C Mask	Sheet mask, 1 piece	A brightening sheet mask with vitamin C that revitalises the skin for a more luminous complexion. Perfect when skin looks dull or tired. Suitable for all skin types.	After toner, place the mask on the face for 15–20 minutes, remove and pat the remaining essence into the skin.	\N	740	en	246
Mediheal Vitamin C Mask	Tuchmaske, 1 Stück	Eine Tuchmaske mit Vitamin C, die die Haut belebt und für einen strahlenderen Teint sorgt. Perfekt, wenn die Haut fahl oder müde aussieht. Für alle Hauttypen.	Nach dem Gesichtswasser 15–20 Minuten auf das Gesicht legen, abnehmen und die restliche Essenz einklopfen.	\N	741	de	247
Mediheal Vitamin C Mask	Masque en tissu, 1 pièce	Un masque en tissu à la vitamine C qui revitalise la peau pour un teint plus lumineux. Parfait quand le teint est terne ou fatigué. Pour tous les types de peau.	Après la lotion, poser le masque 15 à 20 minutes, le retirer et faire pénétrer l’essence restante.	\N	742	fr	247
Mediheal Vitamin C Mask	Maschera in tessuto, 1 pezzo	Una maschera in tessuto alla vitamina C che rivitalizza la pelle per un incarnato più luminoso. Perfetta quando la pelle appare spenta o stanca. Per tutti i tipi di pelle.	Dopo il tonico applicare la maschera per 15–20 minuti, rimuoverla e picchiettare l’essenza rimasta.	\N	743	it	247
Mediheal Vitamin C Mask	Sheet mask, 1 piece	A brightening sheet mask with vitamin C that revitalises the skin for a more luminous complexion. Perfect when skin looks dull or tired. Suitable for all skin types.	After toner, place the mask on the face for 15–20 minutes, remove and pat the remaining essence into the skin.	\N	744	en	247
Torriden Solid-In Lip Essence	Lip essence	A rich lip essence for soft, cared-for and healthy lips. It gives long-lasting moisture and protects against drying out, smooths and softens the lips and strengthens their natural barrier. Mild, vegan formula in a handy tube for on the go.	Apply to the lips whenever they feel dry. Handy for on the go.	\N	745	en	248
Torriden Solid-In Lip Essence	Lippenessenz	Intensive Pflege für zarte Lippen. Reichhaltige Essenz für geschmeidige, gepflegte und gesunde Lippen: spendet langanhaltend Feuchtigkeit, schützt vor dem Austrocknen und stärkt die natürliche Lippenbarriere. Milde, vegane Formel, praktisch und kompakt für unterwegs.	Bei Bedarf auf die Lippen auftragen. Praktisch für unterwegs.	\N	746	de	249
Torriden Solid-In Lip Essence	Lip essence	A rich lip essence for soft, cared-for and healthy lips. It gives long-lasting moisture and protects against drying out, smooths and softens the lips and strengthens their natural barrier. Mild, vegan formula in a handy tube for on the go.	Apply to the lips whenever they feel dry. Handy for on the go.	\N	747	en	249
Torriden Solid-In Lip Essence	Lippenessenz	Intensive Pflege für zarte Lippen. Reichhaltige Essenz für geschmeidige, gepflegte und gesunde Lippen: spendet langanhaltend Feuchtigkeit, schützt vor dem Austrocknen und stärkt die natürliche Lippenbarriere. Milde, vegane Formel, praktisch und kompakt für unterwegs.	Bei Bedarf auf die Lippen auftragen. Praktisch für unterwegs.	\N	748	de	250
Torriden Solid-In Lip Essence	Essence pour les lèvres	Une essence riche pour des lèvres douces, soignées et en bonne santé. Elle hydrate durablement et protège du dessèchement, lisse et adoucit les lèvres et renforce leur barrière naturelle. Formule douce et vegan, dans un tube pratique à emporter.	Appliquer sur les lèvres dès qu’elles tiraillent. Pratique à emporter.	\N	749	fr	250
Torriden Solid-In Lip Essence	Lip essence	A rich lip essence for soft, cared-for and healthy lips. It gives long-lasting moisture and protects against drying out, smooths and softens the lips and strengthens their natural barrier. Mild, vegan formula in a handy tube for on the go.	Apply to the lips whenever they feel dry. Handy for on the go.	\N	750	en	250
Torriden Solid-In Lip Essence	Lippenessenz	Intensive Pflege für zarte Lippen. Reichhaltige Essenz für geschmeidige, gepflegte und gesunde Lippen: spendet langanhaltend Feuchtigkeit, schützt vor dem Austrocknen und stärkt die natürliche Lippenbarriere. Milde, vegane Formel, praktisch und kompakt für unterwegs.	Bei Bedarf auf die Lippen auftragen. Praktisch für unterwegs.	\N	751	de	251
Torriden Solid-In Lip Essence	Essence pour les lèvres	Une essence riche pour des lèvres douces, soignées et en bonne santé. Elle hydrate durablement et protège du dessèchement, lisse et adoucit les lèvres et renforce leur barrière naturelle. Formule douce et vegan, dans un tube pratique à emporter.	Appliquer sur les lèvres dès qu’elles tiraillent. Pratique à emporter.	\N	752	fr	251
Torriden Solid-In Lip Essence	Essenza labbra	Un’essenza ricca per labbra morbide, curate e sane. Idrata a lungo e protegge dalla secchezza, leviga e ammorbidisce le labbra e ne rafforza la barriera naturale. Formula delicata e vegana, in un pratico tubetto da portare con sé.	Applicare sulle labbra quando serve. Comoda da portare con sé.	\N	753	it	251
Torriden Solid-In Lip Essence	Lip essence	A rich lip essence for soft, cared-for and healthy lips. It gives long-lasting moisture and protects against drying out, smooths and softens the lips and strengthens their natural barrier. Mild, vegan formula in a handy tube for on the go.	Apply to the lips whenever they feel dry. Handy for on the go.	\N	754	en	251
Laneige Lip Sleeping Mask Peach Iced Tea	Lip sleeping mask	The much-loved overnight lip mask from Laneige with a fruity peach iced tea scent. It gives intense, long-lasting moisture, supports the lips’ natural regeneration while you sleep, and leaves them visibly softer and smoother by morning.	Apply a generous layer before bed and leave on overnight. Can also be used during the day.	\N	755	en	252
Laneige Lip Sleeping Mask Peach Iced Tea	Lippen-Schlafmaske	Die beliebte Lippenmaske von LANEIGE mit fruchtigem Pfirsich-Eistee-Duft. Spendet langanhaltende Feuchtigkeit, beugt trockenen Lippen vor und unterstützt über Nacht die natürliche Regeneration – für sichtbar weichere, glattere und gesünder aussehende Lippen am Morgen.	Vor dem Schlafengehen grosszügig auftragen und über Nacht einwirken lassen. Auch tagsüber verwendbar.	\N	756	de	253
Laneige Lip Sleeping Mask Peach Iced Tea	Lip sleeping mask	The much-loved overnight lip mask from Laneige with a fruity peach iced tea scent. It gives intense, long-lasting moisture, supports the lips’ natural regeneration while you sleep, and leaves them visibly softer and smoother by morning.	Apply a generous layer before bed and leave on overnight. Can also be used during the day.	\N	757	en	253
Laneige Lip Sleeping Mask Peach Iced Tea	Lippen-Schlafmaske	Die beliebte Lippenmaske von LANEIGE mit fruchtigem Pfirsich-Eistee-Duft. Spendet langanhaltende Feuchtigkeit, beugt trockenen Lippen vor und unterstützt über Nacht die natürliche Regeneration – für sichtbar weichere, glattere und gesünder aussehende Lippen am Morgen.	Vor dem Schlafengehen grosszügig auftragen und über Nacht einwirken lassen. Auch tagsüber verwendbar.	\N	758	de	254
Laneige Lip Sleeping Mask Peach Iced Tea	Masque de nuit pour les lèvres	Le masque de nuit pour les lèvres culte de Laneige, au parfum fruité de thé glacé à la pêche. Il hydrate intensément et durablement, soutient la régénération naturelle des lèvres pendant le sommeil et les laisse visiblement plus douces et plus lisses au réveil.	Appliquer une couche généreuse avant le coucher et laisser agir toute la nuit. Utilisable aussi en journée.	\N	759	fr	254
Laneige Lip Sleeping Mask Peach Iced Tea	Lip sleeping mask	The much-loved overnight lip mask from Laneige with a fruity peach iced tea scent. It gives intense, long-lasting moisture, supports the lips’ natural regeneration while you sleep, and leaves them visibly softer and smoother by morning.	Apply a generous layer before bed and leave on overnight. Can also be used during the day.	\N	760	en	254
Laneige Lip Sleeping Mask Peach Iced Tea	Lippen-Schlafmaske	Die beliebte Lippenmaske von LANEIGE mit fruchtigem Pfirsich-Eistee-Duft. Spendet langanhaltende Feuchtigkeit, beugt trockenen Lippen vor und unterstützt über Nacht die natürliche Regeneration – für sichtbar weichere, glattere und gesünder aussehende Lippen am Morgen.	Vor dem Schlafengehen grosszügig auftragen und über Nacht einwirken lassen. Auch tagsüber verwendbar.	\N	761	de	255
Laneige Lip Sleeping Mask Peach Iced Tea	Masque de nuit pour les lèvres	Le masque de nuit pour les lèvres culte de Laneige, au parfum fruité de thé glacé à la pêche. Il hydrate intensément et durablement, soutient la régénération naturelle des lèvres pendant le sommeil et les laisse visiblement plus douces et plus lisses au réveil.	Appliquer une couche généreuse avant le coucher et laisser agir toute la nuit. Utilisable aussi en journée.	\N	762	fr	255
Laneige Lip Sleeping Mask Peach Iced Tea	Maschera notte labbra	L’amatissima maschera notte per le labbra di Laneige, con un profumo fruttato di tè freddo alla pesca. Idrata intensamente e a lungo, sostiene la rigenerazione naturale delle labbra durante il sonno e le lascia visibilmente più morbide e lisce al risveglio.	Applicare uno strato generoso prima di dormire e lasciare agire tutta la notte. Utilizzabile anche di giorno.	\N	763	it	255
Laneige Lip Sleeping Mask Peach Iced Tea	Lip sleeping mask	The much-loved overnight lip mask from Laneige with a fruity peach iced tea scent. It gives intense, long-lasting moisture, supports the lips’ natural regeneration while you sleep, and leaves them visibly softer and smoother by morning.	Apply a generous layer before bed and leave on overnight. Can also be used during the day.	\N	764	en	255
Round Lab Dokdo Hydration Routine	Routine set	A three-step hydration routine for skin that’s moisturised, calm and protected every day. Includes Round Lab Dokdo 1025 Toner (deep hydration), Birch Juice Moisturizing Sun Cream (moisture and UV protection) and Dokdo 1025 Mist Toner (refreshes any time). Gentle formulas for all skin types.	1. Toner after cleansing. 2. Sun cream as the last step in the morning. 3. Mist whenever skin needs a refresh, also over make-up.	\N	765	en	256
Round Lab Dokdo Hydration Routine	Routine-Set	Eine dreistufige Feuchtigkeitsroutine für hydratisierte, beruhigte und geschützte Haut – jeden Tag. Enthält Round Lab Dokdo 1025 Toner (tiefenwirksame Feuchtigkeit), Birch Juice Moisturizing Sun Cream (Feuchtigkeit und UV-Schutz) und Dokdo 1025 Mist Toner (erfrischt jederzeit). Sanfte Formeln für alle Hauttypen.	1. Toner nach der Reinigung. 2. Sonnencreme als letzter Schritt am Morgen. 3. Mist jederzeit zur Erfrischung, auch über dem Make-up.	\N	766	de	257
Round Lab Dokdo Hydration Routine	Routine set	A three-step hydration routine for skin that’s moisturised, calm and protected every day. Includes Round Lab Dokdo 1025 Toner (deep hydration), Birch Juice Moisturizing Sun Cream (moisture and UV protection) and Dokdo 1025 Mist Toner (refreshes any time). Gentle formulas for all skin types.	1. Toner after cleansing. 2. Sun cream as the last step in the morning. 3. Mist whenever skin needs a refresh, also over make-up.	\N	767	en	257
Round Lab Dokdo Hydration Routine	Routine-Set	Eine dreistufige Feuchtigkeitsroutine für hydratisierte, beruhigte und geschützte Haut – jeden Tag. Enthält Round Lab Dokdo 1025 Toner (tiefenwirksame Feuchtigkeit), Birch Juice Moisturizing Sun Cream (Feuchtigkeit und UV-Schutz) und Dokdo 1025 Mist Toner (erfrischt jederzeit). Sanfte Formeln für alle Hauttypen.	1. Toner nach der Reinigung. 2. Sonnencreme als letzter Schritt am Morgen. 3. Mist jederzeit zur Erfrischung, auch über dem Make-up.	\N	768	de	258
Round Lab Dokdo Hydration Routine	Coffret routine	Une routine hydratation en trois étapes pour une peau hydratée, apaisée et protégée au quotidien. Comprend Round Lab Dokdo 1025 Toner (hydratation profonde), Birch Juice Moisturizing Sun Cream (hydratation et protection UV) et Dokdo 1025 Mist Toner (rafraîchit à tout moment). Formules douces pour tous les types de peau.	1. Lotion après le nettoyage. 2. Crème solaire en dernière étape le matin. 3. Brume à tout moment pour rafraîchir, même sur le maquillage.	\N	769	fr	258
Round Lab Dokdo Hydration Routine	Routine set	A three-step hydration routine for skin that’s moisturised, calm and protected every day. Includes Round Lab Dokdo 1025 Toner (deep hydration), Birch Juice Moisturizing Sun Cream (moisture and UV protection) and Dokdo 1025 Mist Toner (refreshes any time). Gentle formulas for all skin types.	1. Toner after cleansing. 2. Sun cream as the last step in the morning. 3. Mist whenever skin needs a refresh, also over make-up.	\N	770	en	258
Round Lab Dokdo Hydration Routine	Routine-Set	Eine dreistufige Feuchtigkeitsroutine für hydratisierte, beruhigte und geschützte Haut – jeden Tag. Enthält Round Lab Dokdo 1025 Toner (tiefenwirksame Feuchtigkeit), Birch Juice Moisturizing Sun Cream (Feuchtigkeit und UV-Schutz) und Dokdo 1025 Mist Toner (erfrischt jederzeit). Sanfte Formeln für alle Hauttypen.	1. Toner nach der Reinigung. 2. Sonnencreme als letzter Schritt am Morgen. 3. Mist jederzeit zur Erfrischung, auch über dem Make-up.	\N	771	de	259
Round Lab Dokdo Hydration Routine	Coffret routine	Une routine hydratation en trois étapes pour une peau hydratée, apaisée et protégée au quotidien. Comprend Round Lab Dokdo 1025 Toner (hydratation profonde), Birch Juice Moisturizing Sun Cream (hydratation et protection UV) et Dokdo 1025 Mist Toner (rafraîchit à tout moment). Formules douces pour tous les types de peau.	1. Lotion après le nettoyage. 2. Crème solaire en dernière étape le matin. 3. Brume à tout moment pour rafraîchir, même sur le maquillage.	\N	772	fr	259
Round Lab Dokdo Hydration Routine	Set routine	Una routine idratante in tre passaggi per una pelle idratata, calma e protetta ogni giorno. Include Round Lab Dokdo 1025 Toner (idratazione profonda), Birch Juice Moisturizing Sun Cream (idratazione e protezione UV) e Dokdo 1025 Mist Toner (rinfresca in ogni momento). Formule delicate per tutti i tipi di pelle.	1. Tonico dopo la detersione. 2. Crema solare come ultimo passaggio al mattino. 3. Mist in qualsiasi momento per rinfrescare, anche sopra il trucco.	\N	773	it	259
Round Lab Dokdo Hydration Routine	Routine set	A three-step hydration routine for skin that’s moisturised, calm and protected every day. Includes Round Lab Dokdo 1025 Toner (deep hydration), Birch Juice Moisturizing Sun Cream (moisture and UV protection) and Dokdo 1025 Mist Toner (refreshes any time). Gentle formulas for all skin types.	1. Toner after cleansing. 2. Sun cream as the last step in the morning. 3. Mist whenever skin needs a refresh, also over make-up.	\N	774	en	259
Korean Routine Set: Clear, Hydrated & Protected	Routine set	A complete Korean routine to cleanse, soothe, hydrate and protect. Includes Lagom Cellup Micro Foam Cleanser, Anua toner pads, Manyo Pure Soybean Cleansing Oil and Mediheal Madecassoside Moisture Sun Serum. Gentle formulas for all skin types, including sensitive skin.	Evening: cleansing oil, then foam cleanser, then a toner pad. Morning: foam cleanser, toner pad and the sun serum as the last step.	\N	775	en	260
Korean Routine Set: Clear, Hydrated & Protected	Routine-Set	Eine komplette koreanische Routine: reinigen, beruhigen, hydratisieren und schützen. Enthält Lagom Cellup Micro Foam Cleanser, Anua Toner-Pads, Manyo Pure Soybean Cleansing Oil und Mediheal Madecassoside Moisture Sun Serum. Sanfte Formeln für alle Hauttypen, auch für empfindliche Haut.	Abends: Reinigungsöl, danach Schaumreiniger, dann ein Toner-Pad. Morgens: Schaumreiniger, Toner-Pad und als letzten Schritt das Sonnenserum.	\N	776	de	261
Korean Routine Set: Clear, Hydrated & Protected	Routine set	A complete Korean routine to cleanse, soothe, hydrate and protect. Includes Lagom Cellup Micro Foam Cleanser, Anua toner pads, Manyo Pure Soybean Cleansing Oil and Mediheal Madecassoside Moisture Sun Serum. Gentle formulas for all skin types, including sensitive skin.	Evening: cleansing oil, then foam cleanser, then a toner pad. Morning: foam cleanser, toner pad and the sun serum as the last step.	\N	777	en	261
Korean Routine Set: Clear, Hydrated & Protected	Routine-Set	Eine komplette koreanische Routine: reinigen, beruhigen, hydratisieren und schützen. Enthält Lagom Cellup Micro Foam Cleanser, Anua Toner-Pads, Manyo Pure Soybean Cleansing Oil und Mediheal Madecassoside Moisture Sun Serum. Sanfte Formeln für alle Hauttypen, auch für empfindliche Haut.	Abends: Reinigungsöl, danach Schaumreiniger, dann ein Toner-Pad. Morgens: Schaumreiniger, Toner-Pad und als letzten Schritt das Sonnenserum.	\N	778	de	262
Korean Routine Set: Clear, Hydrated & Protected	Coffret routine	Une routine coréenne complète pour nettoyer, apaiser, hydrater et protéger. Comprend Lagom Cellup Micro Foam Cleanser, les disques tonifiants Anua, Manyo Pure Soybean Cleansing Oil et Mediheal Madecassoside Moisture Sun Serum. Formules douces pour tous les types de peau, même sensibles.	Le soir : huile démaquillante, puis mousse nettoyante, puis un disque tonifiant. Le matin : mousse nettoyante, disque tonifiant et le sérum solaire en dernière étape.	\N	779	fr	262
Korean Routine Set: Clear, Hydrated & Protected	Routine set	A complete Korean routine to cleanse, soothe, hydrate and protect. Includes Lagom Cellup Micro Foam Cleanser, Anua toner pads, Manyo Pure Soybean Cleansing Oil and Mediheal Madecassoside Moisture Sun Serum. Gentle formulas for all skin types, including sensitive skin.	Evening: cleansing oil, then foam cleanser, then a toner pad. Morning: foam cleanser, toner pad and the sun serum as the last step.	\N	780	en	262
Korean Routine Set: Clear, Hydrated & Protected	Routine-Set	Eine komplette koreanische Routine: reinigen, beruhigen, hydratisieren und schützen. Enthält Lagom Cellup Micro Foam Cleanser, Anua Toner-Pads, Manyo Pure Soybean Cleansing Oil und Mediheal Madecassoside Moisture Sun Serum. Sanfte Formeln für alle Hauttypen, auch für empfindliche Haut.	Abends: Reinigungsöl, danach Schaumreiniger, dann ein Toner-Pad. Morgens: Schaumreiniger, Toner-Pad und als letzten Schritt das Sonnenserum.	\N	781	de	263
Korean Routine Set: Clear, Hydrated & Protected	Coffret routine	Une routine coréenne complète pour nettoyer, apaiser, hydrater et protéger. Comprend Lagom Cellup Micro Foam Cleanser, les disques tonifiants Anua, Manyo Pure Soybean Cleansing Oil et Mediheal Madecassoside Moisture Sun Serum. Formules douces pour tous les types de peau, même sensibles.	Le soir : huile démaquillante, puis mousse nettoyante, puis un disque tonifiant. Le matin : mousse nettoyante, disque tonifiant et le sérum solaire en dernière étape.	\N	782	fr	263
Korean Routine Set: Clear, Hydrated & Protected	Set routine	Una routine coreana completa per detergere, lenire, idratare e proteggere. Include Lagom Cellup Micro Foam Cleanser, i dischetti tonificanti Anua, Manyo Pure Soybean Cleansing Oil e Mediheal Madecassoside Moisture Sun Serum. Formule delicate per tutti i tipi di pelle, anche sensibili.	La sera: olio detergente, poi schiuma detergente, poi un dischetto tonificante. Al mattino: schiuma detergente, dischetto e il siero solare come ultimo passaggio.	\N	783	it	263
Korean Routine Set: Clear, Hydrated & Protected	Routine set	A complete Korean routine to cleanse, soothe, hydrate and protect. Includes Lagom Cellup Micro Foam Cleanser, Anua toner pads, Manyo Pure Soybean Cleansing Oil and Mediheal Madecassoside Moisture Sun Serum. Gentle formulas for all skin types, including sensitive skin.	Evening: cleansing oil, then foam cleanser, then a toner pad. Morning: foam cleanser, toner pad and the sun serum as the last step.	\N	784	en	263
Korean Skincare Set: Glow & Gentle	Routine set	A glow and gentle-care routine with four steps. Includes an SPF 50+ PA++++ sun cream, Bringgreen Tea Tree Cica Soothing Toner, a brightening peeling gel and Aromatica Rosemary 3-in-1 Treatment for hair. Gentle, clean formulas suitable for sensitive skin.	Toner after cleansing, sun cream every morning, peeling gel 1–2 times a week on clean, dry skin, rosemary treatment after shampooing.	\N	785	en	264
Korean Skincare Set: Glow & Gentle	Routine-Set	Eine Routine für Glow und sanfte Pflege in vier Schritten. Enthält eine Sonnencreme SPF 50+ PA++++, Bringgreen Tea Tree Cica Soothing Toner, ein aufhellendes Peeling-Gel und Aromatica Rosemary 3-in-1 Treatment für die Haare. Sanfte, cleane Formeln, auch für empfindliche Haut.	Toner nach der Reinigung, Sonnencreme jeden Morgen, Peeling-Gel 1–2 Mal pro Woche auf sauberer, trockener Haut, Rosmarin-Treatment nach dem Shampoo.	\N	786	de	265
Korean Skincare Set: Glow & Gentle	Routine set	A glow and gentle-care routine with four steps. Includes an SPF 50+ PA++++ sun cream, Bringgreen Tea Tree Cica Soothing Toner, a brightening peeling gel and Aromatica Rosemary 3-in-1 Treatment for hair. Gentle, clean formulas suitable for sensitive skin.	Toner after cleansing, sun cream every morning, peeling gel 1–2 times a week on clean, dry skin, rosemary treatment after shampooing.	\N	787	en	265
Korean Skincare Set: Glow & Gentle	Routine-Set	Eine Routine für Glow und sanfte Pflege in vier Schritten. Enthält eine Sonnencreme SPF 50+ PA++++, Bringgreen Tea Tree Cica Soothing Toner, ein aufhellendes Peeling-Gel und Aromatica Rosemary 3-in-1 Treatment für die Haare. Sanfte, cleane Formeln, auch für empfindliche Haut.	Toner nach der Reinigung, Sonnencreme jeden Morgen, Peeling-Gel 1–2 Mal pro Woche auf sauberer, trockener Haut, Rosmarin-Treatment nach dem Shampoo.	\N	788	de	266
Korean Skincare Set: Glow & Gentle	Coffret routine	Une routine éclat et douceur en quatre étapes. Comprend une crème solaire SPF 50+ PA++++, Bringgreen Tea Tree Cica Soothing Toner, un gel peeling éclat et Aromatica Rosemary 3-in-1 Treatment pour les cheveux. Formules douces et clean, adaptées aux peaux sensibles.	Lotion après le nettoyage, crème solaire chaque matin, gel peeling 1 à 2 fois par semaine sur peau propre et sèche, soin au romarin après le shampooing.	\N	789	fr	266
Korean Skincare Set: Glow & Gentle	Routine set	A glow and gentle-care routine with four steps. Includes an SPF 50+ PA++++ sun cream, Bringgreen Tea Tree Cica Soothing Toner, a brightening peeling gel and Aromatica Rosemary 3-in-1 Treatment for hair. Gentle, clean formulas suitable for sensitive skin.	Toner after cleansing, sun cream every morning, peeling gel 1–2 times a week on clean, dry skin, rosemary treatment after shampooing.	\N	790	en	266
Korean Skincare Set: Glow & Gentle	Routine-Set	Eine Routine für Glow und sanfte Pflege in vier Schritten. Enthält eine Sonnencreme SPF 50+ PA++++, Bringgreen Tea Tree Cica Soothing Toner, ein aufhellendes Peeling-Gel und Aromatica Rosemary 3-in-1 Treatment für die Haare. Sanfte, cleane Formeln, auch für empfindliche Haut.	Toner nach der Reinigung, Sonnencreme jeden Morgen, Peeling-Gel 1–2 Mal pro Woche auf sauberer, trockener Haut, Rosmarin-Treatment nach dem Shampoo.	\N	791	de	267
Korean Skincare Set: Glow & Gentle	Coffret routine	Une routine éclat et douceur en quatre étapes. Comprend une crème solaire SPF 50+ PA++++, Bringgreen Tea Tree Cica Soothing Toner, un gel peeling éclat et Aromatica Rosemary 3-in-1 Treatment pour les cheveux. Formules douces et clean, adaptées aux peaux sensibles.	Lotion après le nettoyage, crème solaire chaque matin, gel peeling 1 à 2 fois par semaine sur peau propre et sèche, soin au romarin après le shampooing.	\N	792	fr	267
Korean Skincare Set: Glow & Gentle	Set routine	Una routine glow e delicatezza in quattro passaggi. Include una crema solare SPF 50+ PA++++, Bringgreen Tea Tree Cica Soothing Toner, un gel peeling illuminante e Aromatica Rosemary 3-in-1 Treatment per i capelli. Formule delicate e clean, adatte alle pelli sensibili.	Tonico dopo la detersione, crema solare ogni mattina, gel peeling 1–2 volte a settimana su pelle pulita e asciutta, trattamento al rosmarino dopo lo shampoo.	\N	793	it	267
Korean Skincare Set: Glow & Gentle	Routine set	A glow and gentle-care routine with four steps. Includes an SPF 50+ PA++++ sun cream, Bringgreen Tea Tree Cica Soothing Toner, a brightening peeling gel and Aromatica Rosemary 3-in-1 Treatment for hair. Gentle, clean formulas suitable for sensitive skin.	Toner after cleansing, sun cream every morning, peeling gel 1–2 times a week on clean, dry skin, rosemary treatment after shampooing.	\N	794	en	267
Mise en Scène Perfect Serum Original	Haarserum	Das beliebte Haarserum aus Korea für glattes, glänzendes und gesund aussehendes Haar – ohne zu beschweren. Es verleiht intensiven Glanz, hilft vor Hitze, UV-Strahlen und äusseren Einflüssen zu schützen und pflegt mit einer leichten, nicht fettenden Formel.	1–2 Pumpstösse in handtuchtrockene oder trockene Längen und Spitzen geben, Kopfhaut aussparen. Nicht ausspülen.	\N	795	de	268
Mise en Scène Perfect Serum Original	Sérum capillaire	Le sérum capillaire coréen culte pour des cheveux lisses, brillants et en pleine santé, sans les alourdir. Il apporte une brillance intense, aide à protéger de la chaleur, des UV et des agressions extérieures et nourrit grâce à une formule légère et non grasse.	Appliquer 1 à 2 pressions sur les longueurs et pointes essorées ou sèches, sans toucher le cuir chevelu. Ne pas rincer.	\N	796	fr	268
Mise en Scène Perfect Serum Original	Siero per capelli	Il siero coreano di culto per capelli lisci, lucenti e dall’aspetto sano, senza appesantirli. Dona una brillantezza intensa, aiuta a proteggere da calore, raggi UV e agenti esterni e nutre con una formula leggera e non grassa.	Applicare 1–2 erogazioni su lunghezze e punte tamponate o asciutte, evitando la cute. Non risciacquare.	\N	797	it	268
Mise en Scène Perfect Serum Original	Hair serum	The cult Korean hair serum for smooth, glossy, healthy-looking hair without weighing it down. It adds intense shine, helps protect against heat, UV and everyday damage, and nourishes with a light, non-greasy formula.	Apply 1–2 pumps to towel-dried or dry lengths and ends, avoiding the scalp. Do not rinse.	\N	798	en	268
Mise en Scène Perfect Serum	Haarserum	Das Kult-Haarserum aus Korea für sichtbar glatteres, glänzenderes und gesünder aussehendes Haar. Sorgt sofort für Glanz und leichte Kämmbarkeit, schützt vor Hitze und UV-Strahlen und hilft, Spliss zu reduzieren – mit einer schnell einziehenden Formel ohne fettiges Gefühl.	1–2 Pumpstösse in handtuchtrockene oder trockene Längen und Spitzen geben, Kopfhaut aussparen. Nicht ausspülen.	\N	799	de	269
Mise en Scène Perfect Serum	Sérum capillaire	Le sérum capillaire coréen culte pour des cheveux visiblement plus lisses, plus brillants et en meilleure santé. Brillance immédiate et démêlage facile, protection contre la chaleur et les UV et moins de fourches, grâce à une formule qui pénètre vite sans effet gras.	Appliquer 1 à 2 pressions sur les longueurs et pointes essorées ou sèches, sans toucher le cuir chevelu. Ne pas rincer.	\N	800	fr	269
Mise en Scène Perfect Serum	Siero per capelli	Il siero coreano di culto per capelli visibilmente più lisci, lucenti e sani. Brillantezza immediata e pettinabilità facile, protezione da calore e UV e meno doppie punte, con una formula che si assorbe in fretta senza ungere.	Applicare 1–2 erogazioni su lunghezze e punte tamponate o asciutte, evitando la cute. Non risciacquare.	\N	801	it	269
Mise en Scène Perfect Serum	Hair serum	The classic Korean hair serum for visibly smoother, glossier and healthier-looking hair. Gives instant shine and easy combing, helps protect against heat and UV, and helps reduce split ends with a fast-absorbing formula that never feels greasy.	Apply 1–2 pumps to towel-dried or dry lengths and ends, avoiding the scalp. Do not rinse.	\N	802	en	269
Dr.FORHAIR Folligen Original Shampoo	Shampoo	Klinisch bewährte Pflege gegen übermässigen Talg und Kopfhautprobleme, ideal für dünner werdendes Haar. Entwickelt vom Dr.FORHAIR Scalp & Hair Research Center, reduziert überschüssigen Talg um bis zu 71,4 % und erhöht die Widerstandskraft der Kopfhaut um bis zu 40,2 % – sanft und frei von Parabenen.	In das nasse Haar und die Kopfhaut einmassieren, aufschäumen und gründlich ausspülen.	\N	803	de	270
Dr.FORHAIR Folligen Original Shampoo	Shampooing	Un shampooing cliniquement testé pour le cuir chevelu gras et sensible et les cheveux qui s’affinent. Développé par le Dr.FORHAIR Scalp & Hair Research Center, il réduit l’excès de sébum jusqu’à 71,4 % et renforce le cuir chevelu jusqu’à 40,2 %, avec une formule douce sans parabènes.	Masser sur cheveux et cuir chevelu mouillés, faire mousser puis rincer abondamment.	\N	804	fr	270
Dr.FORHAIR Folligen Original Shampoo	Shampoo	Uno shampoo testato clinicamente per cute grassa e problematica e capelli che si diradano. Sviluppato dal Dr.FORHAIR Scalp & Hair Research Center, riduce il sebo in eccesso fino al 71,4 % e rafforza la cute fino al 40,2 %, con una formula delicata senza parabeni.	Massaggiare su capelli e cute bagnati, emulsionare e risciacquare accuratamente.	\N	805	it	270
Dr.FORHAIR Folligen Original Shampoo	Shampoo	A clinically tested shampoo for an oily, troubled scalp and thinning hair. Developed by the Dr.FORHAIR Scalp & Hair Research Center, it reduces excess sebum by up to 71.4 % and increases scalp strength by up to 40.2 %, with a gentle, paraben-free formula.	Massage into wet hair and scalp, lather and rinse thoroughly.	\N	806	en	270
Lador Hydro LPP Treatment	Haarkur	Die professionelle Salonbehandlung mit niedrigmolekularem PPT versorgt trockenes und geschädigtes Haar tiefenwirksam mit Feuchtigkeit und Nährstoffen. Stärkt die Haarstruktur von innen, verbessert die Elastizität und schützt coloriertes Haar – silikon- und parabenfrei.	Nach dem Shampoo in Längen und Spitzen verteilen, einige Minuten einwirken lassen und ausspülen.	Niedrigmolekulare Proteine (PPT) und Kollagen. Frei von Silikonen und Parabenen.	807	de	271
Lador Hydro LPP Treatment	Soin capillaire	Un soin professionnel de salon au PPT de faible poids moléculaire qui répare en profondeur les cheveux secs et abîmés. Il renforce la fibre de l’intérieur, redonne hydratation et élasticité et protège les cheveux colorés, sans silicones ni parabènes.	Après le shampooing, appliquer sur les longueurs et pointes, laisser poser quelques minutes puis rincer.	Protéines de faible poids moléculaire (PPT) et collagène. Sans silicones ni parabènes.	808	fr	271
Lador Hydro LPP Treatment	Trattamento per capelli	Un trattamento professionale da salone con PPT a basso peso molecolare che ripara in profondità i capelli secchi e danneggiati. Rinforza la fibra dall’interno, ridona idratazione ed elasticità e protegge i capelli colorati, senza siliconi né parabeni.	Dopo lo shampoo applicare su lunghezze e punte, lasciare in posa qualche minuto e risciacquare.	Proteine a basso peso molecolare (PPT) e collagene. Senza siliconi né parabeni.	809	it	271
Lador Hydro LPP Treatment	Hair treatment	A professional salon treatment with low-molecular PPT that deeply repairs dry and damaged hair. Strengthens the hair from within, restores moisture and elasticity, and helps protect colour-treated hair, without silicones or parabens.	After shampooing, apply to the lengths and ends, leave on for a few minutes and rinse.	Low-molecular proteins (PPT) and collagen. Free from silicones and parabens.	810	en	271
Aromatica Rosemary Scalp Scrub	Kopfhautpeeling	Tiefenreinigendes Peeling für die Kopfhaut mit Rosmarin und Meersalz. Entfernt sanft abgestorbene Hautzellen und Produktablagerungen, sorgt für ein frisches, belebtes Gefühl und fördert ein gesundes Haarwachstum. Vegan und ohne Silikone.	Vor dem Shampoo 1–2 Minuten sanft in die nasse Kopfhaut einmassieren und ausspülen. 1–2 Mal pro Woche anwenden.	Rosmarin-Extrakt, Meersalz, pflanzliche Peeling-Partikel. Vegan, frei von Silikonen.	811	de	272
Aromatica Rosemary Scalp Scrub	Gommage du cuir chevelu	Un gommage purifiant du cuir chevelu au romarin et au sel marin. Il élimine en douceur cellules mortes et résidus de produits, laisse une sensation de fraîcheur et favorise une pousse saine. Vegan, sans silicones.	Avant le shampooing, masser délicatement le cuir chevelu mouillé pendant 1 à 2 minutes puis rincer. 1 à 2 fois par semaine.	Extrait de romarin, sel marin, particules exfoliantes végétales. Vegan, sans silicones.	812	fr	272
Aromatica Rosemary Scalp Scrub	Scrub per il cuoio capelluto	Uno scrub purificante per la cute con rosmarino e sale marino. Rimuove delicatamente cellule morte e residui di prodotti, lascia una sensazione di freschezza e favorisce una crescita sana. Vegano, senza siliconi.	Prima dello shampoo massaggiare delicatamente la cute bagnata per 1–2 minuti e risciacquare. 1–2 volte a settimana.	Estratto di rosmarino, sale marino, particelle esfolianti vegetali. Vegano, senza siliconi.	813	it	272
Aromatica Rosemary Scalp Scrub	Scalp scrub	A deep-cleansing scalp exfoliator with rosemary and sea salt. Gently removes dead skin cells and product build-up, leaves the scalp feeling fresh and clean, and supports healthy-looking hair growth. Vegan, without silicones.	Before shampooing, massage gently into the wet scalp for 1–2 minutes and rinse. Use 1–2 times a week.	Rosemary extract, sea salt, plant-based exfoliating particles. Vegan, free from silicones.	814	en	272
Aromatica Rosemary Root Enhancer	Kopfhaut-Tonikum	Kopfhaut-Tonikum mit Rosmarin-Extrakt für kräftigere Haarwurzeln und volleres, gesünder aussehendes Haar. Revitalisiert die Kopfhaut, nährt die Haarwurzeln, hilft Haarausfall durch Haarbruch vorzubeugen und beruhigt empfindliche Kopfhaut.	Partienweise auf die saubere Kopfhaut auftragen und einmassieren. Nicht ausspülen. Täglich anwenden.	Rosmarin-Extrakt. Vegan, frei von Silikonen, Parabenen und künstlichen Duftstoffen. Dermatologisch getestet.	815	de	273
Aromatica Rosemary Root Enhancer	Tonique pour le cuir chevelu	Un tonique pour le cuir chevelu à l’extrait de romarin pour des racines plus fortes et des cheveux plus denses. Il revitalise le cuir chevelu, nourrit les racines, aide à prévenir la chute liée à la casse et apaise le cuir chevelu sensible.	Appliquer mèche par mèche sur le cuir chevelu propre et masser. Ne pas rincer. Usage quotidien.	Extrait de romarin. Vegan, sans silicones, parabènes ni parfums artificiels. Testé dermatologiquement.	816	fr	273
Aromatica Rosemary Root Enhancer	Tonico per il cuoio capelluto	Un tonico per la cute all’estratto di rosmarino per radici più forti e capelli più voluminosi. Rivitalizza la cute, nutre le radici, aiuta a prevenire la caduta dovuta alla rottura e lenisce la cute sensibile.	Applicare a ciocche sulla cute pulita e massaggiare. Non risciacquare. Uso quotidiano.	Estratto di rosmarino. Vegano, senza siliconi, parabeni e profumi artificiali. Dermatologicamente testato.	817	it	273
Aromatica Rosemary Root Enhancer	Scalp tonic	A scalp tonic with rosemary extract for stronger roots and fuller, healthier-looking hair. Revitalises the scalp, nourishes the hair roots to help prevent hair loss caused by breakage, and soothes a sensitive or irritated scalp.	Apply to the clean scalp, section by section, and massage in. Do not rinse. Use daily.	Rosemary extract. Vegan, free from silicones, parabens and artificial fragrance. Dermatologically tested.	818	en	273
Aromatica Rosemary Scalp Scaling Shampoo	Shampoo	Natürliche Pflege für eine ausgeglichene Kopfhaut und gestärktes, glänzendes Haar – jeden Tag. Rosmarin-Extrakt revitalisiert die Kopfhaut, die tiefenreinigende Formel entfernt sanft überschüssiges Öl und Rückstände – frei von Silikonen und Sulfaten.	In das nasse Haar und die Kopfhaut einmassieren, aufschäumen und gründlich ausspülen.	Rosmarin-Extrakt. Vegan, frei von Silikonen und Sulfaten. Dermatologisch getestet.	819	de	274
Aromatica Rosemary Scalp Scaling Shampoo	Shampooing	Un shampooing naturel pour un cuir chevelu équilibré et des cheveux plus forts et brillants, au quotidien. L’extrait de romarin revitalise le cuir chevelu et la formule purifiante élimine en douceur l’excès de sébum et les résidus, sans silicones ni sulfates.	Masser sur cheveux et cuir chevelu mouillés, faire mousser puis rincer abondamment.	Extrait de romarin. Vegan, sans silicones ni sulfates. Testé dermatologiquement.	820	fr	274
Aromatica Rosemary Scalp Scaling Shampoo	Shampoo	Uno shampoo naturale per una cute equilibrata e capelli più forti e lucenti, ogni giorno. L’estratto di rosmarino rivitalizza la cute e la formula purificante rimuove delicatamente sebo in eccesso e residui, senza siliconi né solfati.	Massaggiare su capelli e cute bagnati, emulsionare e risciacquare accuratamente.	Estratto di rosmarino. Vegano, senza siliconi né solfati. Dermatologicamente testato.	821	it	274
Aromatica Rosemary Scalp Scaling Shampoo	Shampoo	A natural shampoo for a balanced scalp and stronger, shinier hair, every day. Rosemary extract revitalises the scalp while the deep-cleansing formula gently removes excess oil and residue for a fresh scalp, without silicones or sulfates.	Massage into wet hair and scalp, lather and rinse thoroughly.	Rosemary extract. Vegan, free from silicones and sulfates. Dermatologically tested.	822	en	274
Labo-H Scalp Strengthening Shampoo	Shampoo	Ein stärkendes Shampoo für eine ausgeglichene Kopfhaut und kräftigeres, gesünderes Haar. Hilft, die Barriere der Kopfhaut zu stärken und Haarausfall zu reduzieren, gleicht das Mikrobiom aus und reinigt sanft. Für alle Haartypen.	In das nasse Haar und die Kopfhaut einmassieren, aufschäumen und gründlich ausspülen.	Probiotika-Lysat, Ceramid, PDRN, Biotin und Koffein. Dermatologisch getestet.	823	de	275
Labo-H Scalp Strengthening Shampoo	Shampooing	Un shampooing fortifiant pour un cuir chevelu équilibré et des cheveux plus forts et en pleine santé. Il aide à renforcer la barrière et à réduire la chute des cheveux, équilibre le microbiome et nettoie en douceur. Convient à tous les types de cheveux.	Masser sur cheveux et cuir chevelu mouillés, faire mousser puis rincer abondamment.	Lysat de probiotiques, céramide, PDRN, biotine et caféine. Testé dermatologiquement.	824	fr	275
Labo-H Scalp Strengthening Shampoo	Shampoo	Uno shampoo fortificante per una cute equilibrata e capelli più forti e sani. Aiuta a rafforzare la barriera e a ridurre la caduta dei capelli, riequilibra il microbioma e deterge delicatamente. Adatto a tutti i tipi di capelli.	Massaggiare su capelli e cute bagnati, emulsionare e risciacquare accuratamente.	Lisato di probiotici, ceramide, PDRN, biotina e caffeina. Dermatologicamente testato.	825	it	275
Labo-H Scalp Strengthening Shampoo	Shampoo	A strengthening shampoo for a balanced scalp and stronger, healthier hair. It helps reinforce the scalp barrier and reduce hair loss, balances the scalp microbiome and cleanses gently while adding strength and vitality. Suitable for all hair types.	Massage into wet hair and scalp, lather and rinse thoroughly.	Probiotics lysate, ceramide, PDRN, biotin and caffeine. Dermatologically tested.	826	en	275
Illiyoon Ultra Repair Deep Moisture Wash	Body wash	A gentle, moisture-giving body wash that cleanses without drying the skin out. Its ceramide and moisturising complex cares for dry and sensitive skin, and the pH-neutral formula suits the whole family.	Lather on wet skin and rinse.	Ceramides and moisturising complex. pH-neutral.	827	en	276
Illiyoon Ultra Repair Deep Moisture Wash	Duschgel	Feuchtigkeitsspendende Körperreinigung, die sanft reinigt, ohne die Haut auszutrocknen. Mit Ceramiden und Feuchtigkeitskomplex für trockene und empfindliche Haut, pH-hautneutral und für die ganze Familie geeignet.	Auf der nassen Haut aufschäumen und abspülen.	Ceramide und Feuchtigkeitskomplex. pH-hautneutral.	828	de	276
Illiyoon Ultra Repair Deep Moisture Wash	Gel douche	Un gel douche doux et hydratant qui nettoie sans dessécher. Son complexe de céramides et d’agents hydratants prend soin des peaux sèches et sensibles, et sa formule au pH neutre convient à toute la famille.	Faire mousser sur peau mouillée puis rincer.	Céramides et complexe hydratant. pH neutre.	829	fr	276
Illiyoon Ultra Repair Deep Moisture Wash	Bagnoschiuma	Un bagnoschiuma delicato e idratante che deterge senza seccare la pelle. Il complesso di ceramidi e agenti idratanti si prende cura della pelle secca e sensibile, e la formula a pH neutro è adatta a tutta la famiglia.	Emulsionare sulla pelle bagnata e risciacquare.	Ceramidi e complesso idratante. pH neutro.	830	it	276
Illiyoon Ultra Moisture Scrub Wash	Peeling-Duschgel	Sanftes Peeling für geschmeidige Haut. Entfernt abgestorbene Hautschüppchen sanft, mit Ceramiden und natürlichem Peeling-Komplex, spendet Feuchtigkeit und pflegt. Für empfindliche und trockene Haut.	Mit sanften, kreisenden Bewegungen auf der nassen Haut einmassieren und abspülen. 2–3 Mal pro Woche.	Ceramide und natürlicher Peeling-Komplex.	831	de	277
Illiyoon Ultra Moisture Scrub Wash	Gel douche exfoliant	Un gel douche exfoliant doux pour une peau soyeuse. Des particules exfoliantes naturelles éliminent en douceur les peaux sèches et les squames, tandis que les céramides maintiennent l’hydratation. Convient aux peaux sensibles et sèches.	Masser la peau mouillée par mouvements circulaires doux puis rincer. 2 à 3 fois par semaine.	Céramides et complexe exfoliant naturel.	832	fr	277
Illiyoon Ultra Moisture Scrub Wash	Bagnoschiuma esfoliante	Un bagnoschiuma esfoliante delicato per una pelle setosa. Particelle esfolianti naturali rimuovono delicatamente le pellicine secche, mentre le ceramidi mantengono la pelle idratata. Adatto a pelli sensibili e secche.	Massaggiare la pelle bagnata con movimenti circolari delicati e risciacquare. 2–3 volte a settimana.	Ceramidi e complesso esfoliante naturale.	833	it	277
Illiyoon Ultra Moisture Scrub Wash	Exfoliating body wash	A gentle exfoliating body wash for silky-smooth skin. Natural exfoliating particles remove dry, flaky skin softly while ceramides keep the skin moisturised. Suitable for sensitive and dry skin.	Massage onto wet skin in gentle circles and rinse. Use 2–3 times a week.	Ceramides and a natural exfoliating complex.	834	en	277
Illiyoon Ceramide Ato Lotion	Körperlotion	Leichte, tägliche Feuchtigkeitspflege mit Ceramide Skin Complex™ zur Stärkung der Hautbarriere. Zieht schnell ein, klebt nicht und spendet 24 Stunden Feuchtigkeit für empfindliche und trockene Haut. Parfümfrei und hypoallergen.	Nach dem Duschen grosszügig auf die leicht feuchte Haut auftragen.	Ceramide Skin Complex™. Parfümfrei, hypoallergen.	835	de	278
Illiyoon Ceramide Ato Lotion	Lait corporel	Un lait hydratant léger au quotidien, avec le Ceramide Skin Complex™ d’Illiyoon pour renforcer la barrière cutanée. Il pénètre vite sans coller et hydrate 24 heures les peaux sensibles et sèches. Sans parfum et hypoallergénique.	Appliquer généreusement sur la peau légèrement humide après la douche.	Ceramide Skin Complex™. Sans parfum, hypoallergénique.	836	fr	278
Illiyoon Ceramide Ato Lotion	Lozione corpo	Una lozione idratante leggera per tutti i giorni, con il Ceramide Skin Complex™ di Illiyoon per rafforzare la barriera cutanea. Si assorbe in fretta senza appiccicare e idrata per 24 ore la pelle sensibile e secca. Senza profumo e ipoallergenica.	Applicare generosamente sulla pelle leggermente umida dopo la doccia.	Ceramide Skin Complex™. Senza profumo, ipoallergenica.	837	it	278
Illiyoon Ceramide Ato Lotion	Body lotion	A light daily moisturising lotion with Illiyoon’s Ceramide Skin Complex to strengthen the skin barrier. It absorbs quickly without feeling sticky and keeps sensitive and dry skin moisturised for 24 hours. Fragrance-free and hypoallergenic.	Apply generously to slightly damp skin after showering.	Ceramide Skin Complex™. Fragrance-free, hypoallergenic.	838	en	278
Illiyoon Ceramide Ato 6.0 Top to Toe Wash	Duschgel	Eine milde, parfümfreie Wäsche für Haar und Körper, für die ganze Familie und auch für empfindliche Haut. Ceramide stärken die Hautbarriere, während sie sanft reinigt und Feuchtigkeit spendet. Dermatologisch getestet, hergestellt in Korea.	Auf der nassen Haut aufschäumen und abspülen.	Ceramide. Ohne zugesetztes Parfüm.	839	de	279
Illiyoon Ceramide Ato 6.0 Top to Toe Wash	Gel douche	Un nettoyant doux sans parfum pour les cheveux et le corps, pour toute la famille, y compris les peaux sensibles. Les céramides renforcent la barrière cutanée tout en nettoyant en douceur et en hydratant. Testé dermatologiquement, fabriqué en Corée.	Faire mousser sur peau mouillée puis rincer.	Céramides. Sans parfum ajouté.	840	fr	279
Illiyoon Ceramide Ato 6.0 Top to Toe Wash	Bagnoschiuma	Un detergente delicato senza profumo per capelli e corpo, per tutta la famiglia e anche per pelli sensibili. Le ceramidi rafforzano la barriera cutanea mentre deterge delicatamente e idrata. Dermatologicamente testato, prodotto in Corea.	Emulsionare sulla pelle bagnata e risciacquare.	Ceramidi. Senza profumo aggiunto.	841	it	279
Illiyoon Ceramide Ato 6.0 Top to Toe Wash	Body wash	A mild, fragrance-free wash for hair and body, made for the whole family, including sensitive skin. Ceramides help strengthen the skin barrier while it cleanses gently and keeps skin hydrated. Dermatologically tested, made in Korea.	Lather on wet skin and rinse.	Ceramides. No added fragrance.	842	en	279
Illiyoon Ceramide Ato Concentrate Cream	Gesichtscreme	Intensive Feuchtigkeit für empfindliche Haut, mit Ceramide Skin Complex™ zur Stärkung der Hautbarriere. Spendet langanhaltende Feuchtigkeit, ideal für trockene und empfindliche Haut. Parfümfrei und sanft.	Als letzten Schritt der Routine morgens und abends auf Gesicht und Hals verteilen.	Ceramide Skin Complex™. Parfümfrei.	843	de	280
Illiyoon Ceramide Ato Concentrate Cream	Crème visage	Une crème intensive pour peaux sensibles, avec le Ceramide Skin Complex™ d’Illiyoon pour renforcer la barrière cutanée. Elle hydrate durablement les peaux sèches et sensibles du visage et du corps. Sans parfum et douce.	En dernière étape de la routine, matin et soir, appliquer sur le visage et le cou.	Ceramide Skin Complex™. Sans parfum.	844	fr	280
Illiyoon Ceramide Ato Concentrate Cream	Crema viso	Una crema intensiva per pelli sensibili, con il Ceramide Skin Complex™ di Illiyoon per rafforzare la barriera cutanea. Idrata a lungo la pelle secca e sensibile di viso e corpo. Senza profumo e delicata.	Come ultimo passaggio della routine, mattina e sera, stendere su viso e collo.	Ceramide Skin Complex™. Senza profumo.	845	it	280
Illiyoon Ceramide Ato Concentrate Cream	Face cream	An intensive cream for sensitive skin with Illiyoon’s Ceramide Skin Complex to strengthen the skin barrier. It gives long-lasting moisture and suits dry and sensitive skin on face and body. Fragrance-free and gentle.	As the last step of your routine, morning and evening, smooth over face and neck.	Ceramide Skin Complex™. Fragrance-free.	846	en	280
Dr. Althea 345 Relief Cream	Gesichtscreme	Die multifunktionale Creme mit der 3-4-5 Formel: drei Schlüsselwirkstoffe für Beruhigung, vier für Pflege und fünf für Schutz. Beruhigt Irritationen und Rötungen, stärkt die Hautbarriere und fördert die Regeneration – leicht und nicht klebend. Für alle Hauttypen, auch für empfindliche Haut.	Als letzten Schritt der Routine morgens und abends auf Gesicht und Hals verteilen.	Niacinamid, Centella Asiatica, Madecassoside, Ceramid NP, Panthenol, Hyaluronsäure, Beta-Glucan und Pflanzenextrakte. Frei von künstlichen Duftstoffen, Parabenen und Mineralölen.	847	de	281
Dr. Althea 345 Relief Cream	Crème visage	Une crème multifonction à la formule 3-4-5 : trois actifs pour apaiser, quatre pour soigner et cinq pour protéger. Elle calme irritations et rougeurs, renforce la barrière cutanée et favorise la régénération, avec une texture légère et non collante. Pour tous les types de peau, même sensibles.	En dernière étape de la routine, matin et soir, appliquer sur le visage et le cou.	Niacinamide, centella asiatica, madécassoside, céramide NP, panthénol, acide hyaluronique, bêta-glucane et extraits de plantes. Sans parfum artificiel, parabènes ni huiles minérales.	848	fr	281
Dr. Althea 345 Relief Cream	Crema viso	Una crema multifunzione con la formula 3-4-5: tre attivi per lenire, quattro per curare e cinque per proteggere. Calma irritazioni e rossori, rafforza la barriera cutanea e favorisce la rigenerazione con una texture leggera e non appiccicosa. Per tutti i tipi di pelle, anche sensibile.	Come ultimo passaggio della routine, mattina e sera, stendere su viso e collo.	Niacinamide, centella asiatica, madecassoside, ceramide NP, pantenolo, acido ialuronico, beta-glucano ed estratti vegetali. Senza profumi artificiali, parabeni e oli minerali.	849	it	281
Dr. Althea 345 Relief Cream	Face cream	A multi-tasking cream with the 3-4-5 formula: three key ingredients to soothe, four to care and five to protect. It calms irritation and redness, strengthens the skin barrier and supports regeneration with a light, non-sticky texture. For all skin types, including sensitive skin.	As the last step of your routine, morning and evening, smooth over face and neck.	Niacinamide, centella asiatica, madecassoside, ceramide NP, panthenol, hyaluronic acid, beta-glucan and plant extracts. Free from artificial fragrance, parabens and mineral oils.	850	en	281
Purito Oat-In Calming Gel Cream	Gel-Creme	Die beruhigende Gel-Creme mit Haferwasser und Haferextrakt spendet intensive Feuchtigkeit, mildert Rötungen und stärkt die natürliche Schutzbarriere. Kühlt angenehm, zieht schnell ein und klebt nicht. Ideal für empfindliche, gereizte und trockene Haut.	Nach Reinigung und Gesichtswasser morgens und abends gleichmässig auf Gesicht und Hals auftragen.	Haferwasser, Haferextrakt und Squalan. Frei von Parabenen, Silikonen, Mineralölen und künstlichen Farbstoffen.	851	de	282
Purito Oat-In Calming Gel Cream	Gel-crème	Un gel-crème apaisant à l’eau et à l’extrait d’avoine qui hydrate intensément et durablement. Il calme irritations et rougeurs, procure une sensation de fraîcheur et renforce la barrière cutanée. Texture légère et non collante pour peaux sensibles, irritées et sèches.	Après le nettoyage et la lotion, appliquer une couche uniforme sur le visage et le cou, matin et soir.	Eau d’avoine, extrait d’avoine et squalane. Sans parabènes, silicones, huiles minérales ni colorants artificiels.	852	fr	282
Purito Oat-In Calming Gel Cream	Gel crema	Un gel crema lenitivo con acqua e estratto d’avena che idrata intensamente e a lungo. Calma irritazioni e rossori, rinfresca e rafforza la barriera cutanea. Texture leggera e non appiccicosa per pelli sensibili, irritate e secche.	Dopo detersione e tonico, stendere uno strato uniforme su viso e collo, mattina e sera.	Acqua d’avena, estratto d’avena e squalano. Senza parabeni, siliconi, oli minerali e coloranti artificiali.	853	it	282
Purito Oat-In Calming Gel Cream	Gel cream	A soothing gel cream with oat water and oat extract that gives intense, long-lasting moisture. It calms irritation and redness, leaves a refreshing, cooling feel and strengthens the skin barrier. Light, non-sticky texture for sensitive, irritated and dry skin.	After cleansing and toning, smooth an even layer over face and neck, morning and evening.	Oat seed water, oat extract and squalane. Free from parabens, silicones, mineral oils and artificial colours.	854	en	282
COSRX Advanced Snail 92 All in One Cream	Gesichtscreme	Tägliche Pflege für gesunde, strahlende Haut mit 92 % Schneckensekret-Filtrat. Spendet intensive Feuchtigkeit, unterstützt die Regeneration und stärkt die Hautbarriere – mit leichter Textur, die schnell einzieht. Für alle Hauttypen.	Als letzten Schritt der Routine morgens und abends auf Gesicht und Hals verteilen.	92 % Schneckensekret-Filtrat (Mucin).	855	de	283
COSRX Advanced Snail 92 All in One Cream	Crème visage	Une crème tout-en-un au quotidien avec 92 % de filtrat de bave d’escargot pour une peau saine et lumineuse. Elle hydrate intensément, soutient la régénération et renforce la barrière cutanée, avec une texture légère qui pénètre vite. Pour tous les types de peau.	En dernière étape de la routine, matin et soir, appliquer sur le visage et le cou.	92 % de filtrat de bave d’escargot (mucine).	856	fr	283
COSRX Advanced Snail 92 All in One Cream	Crema viso	Una crema tutto-in-uno quotidiana con il 92 % di filtrato di bava di lumaca per una pelle sana e luminosa. Idrata intensamente, sostiene la rigenerazione e rafforza la barriera cutanea con una texture leggera che si assorbe in fretta. Per tutti i tipi di pelle.	Come ultimo passaggio della routine, mattina e sera, stendere su viso e collo.	92 % di filtrato di bava di lumaca (mucina).	857	it	283
COSRX Advanced Snail 92 All in One Cream	Face cream	A daily all-in-one cream with 92 % snail secretion filtrate for healthy, radiant skin. It gives intense moisture, supports regeneration and strengthens the skin barrier, with a light texture that absorbs quickly. Suitable for all skin types.	As the last step of your routine, morning and evening, smooth over face and neck.	92 % snail secretion filtrate (mucin).	858	en	283
Some By Mi Snail Truecica Miracle Repair Cream	Gesichtscreme	Regeneration und Schutz für eine gesunde, strahlende Haut. 42 % Snail Truecica™ regeneriert und spendet Feuchtigkeit, fünf Arten von Ceramiden stärken die Hautbarriere. Leichte Textur, zieht schnell ein. Dermatologisch getestet und für empfindliche Haut geeignet.	Als letzten Schritt der Routine morgens und abends auf Gesicht und Hals verteilen.	42 % Snail Truecica™ und 5 Arten von Ceramiden.	859	de	284
Some By Mi Snail Truecica Miracle Repair Cream	Crème visage	Une crème régénérante et protectrice pour une peau saine et lumineuse. 42 % de Snail Truecica™ répare et hydrate intensément, tandis que cinq types de céramides renforcent la barrière cutanée. Testée dermatologiquement, convient aux peaux sensibles.	En dernière étape de la routine, matin et soir, appliquer sur le visage et le cou.	42 % de Snail Truecica™ et 5 types de céramides.	860	fr	284
Some By Mi Snail Truecica Miracle Repair Cream	Crema viso	Una crema rigenerante e protettiva per una pelle sana e luminosa. Il 42 % di Snail Truecica™ ripara e idrata intensamente, mentre cinque tipi di ceramidi rafforzano la barriera cutanea. Dermatologicamente testata, adatta alle pelli sensibili.	Come ultimo passaggio della routine, mattina e sera, stendere su viso e collo.	42 % di Snail Truecica™ e 5 tipi di ceramidi.	861	it	284
Some By Mi Snail Truecica Miracle Repair Cream	Face cream	A regenerating and protective cream for healthy, radiant skin. 42 % Snail Truecica™ repairs damaged skin and gives intense moisture, while five types of ceramides strengthen the skin barrier. Dermatologically tested and suitable for sensitive skin.	As the last step of your routine, morning and evening, smooth over face and neck.	42 % Snail Truecica™ and 5 types of ceramides.	862	en	284
Round Lab Mugwort Cleansing Foam	Reinigungsschaum	Sanfte Reinigung, die beruhigt und schützt. Der Reinigungsschaum mit Beifussextrakt reinigt porentief, entfernt Unreinheiten, überschüssigen Talg und Make-up-Reste, ohne auszutrocknen, und stärkt die natürliche Schutzbarriere. Für alle Hauttypen, besonders für empfindliche und zu Unreinheiten neigende Haut.	Eine kleine Menge mit Wasser aufschäumen, auf der feuchten Haut einmassieren und mit lauwarmem Wasser abspülen.	Beifussextrakt. Frei von Parabenen, Silikonen, Mineralölen, künstlichen Farbstoffen und PEGs.	863	de	285
Round Lab Mugwort Cleansing Foam	Mousse nettoyante	Une mousse nettoyante douce à l’extrait d’armoise qui nettoie en profondeur tout en apaisant. Sa mousse dense élimine impuretés, excès de sébum et résidus de maquillage sans dessécher et soutient la barrière naturelle. Pour tous les types de peau, en particulier sensibles et à imperfections.	Faire mousser une petite quantité avec de l’eau, masser sur peau humide et rincer à l’eau tiède.	Extrait d’armoise. Sans parabènes, silicones, huiles minérales, colorants artificiels ni PEG.	864	fr	285
Round Lab Mugwort Cleansing Foam	Schiuma detergente	Una schiuma detergente delicata all’estratto di artemisia che pulisce in profondità e lenisce. La schiuma densa rimuove impurità, sebo in eccesso e residui di trucco senza seccare e sostiene la barriera naturale. Per tutti i tipi di pelle, soprattutto sensibili e con imperfezioni.	Emulsionare una piccola quantità con acqua, massaggiare sulla pelle umida e risciacquare con acqua tiepida.	Estratto di artemisia. Senza parabeni, siliconi, oli minerali, coloranti artificiali e PEG.	865	it	285
Round Lab Mugwort Cleansing Foam	Cleansing foam	A gentle cleansing foam with mugwort extract that cleanses deeply while calming sensitive skin. Its dense foam removes impurities, excess oil and make-up residue without drying, and supports the natural protective barrier. For all skin types, especially sensitive and blemish-prone skin.	Lather a small amount with water, massage over damp skin and rinse with lukewarm water.	Mugwort extract. Free from parabens, silicones, mineral oils, artificial colours and PEGs.	866	en	285
COSRX Low pH Good Morning Gel Cleanser	Gel-Reiniger	Sanfte Reinigung für einen frischen Start in den Tag. Mit einem pH-Wert von ca. 5,0 reinigt der Gel-Reiniger gründlich, ohne auszutrocknen, bewahrt die natürliche Schutzbarriere und entfernt Talg und Unreinheiten. Teebaumöl und botanische Extrakte sorgen für eine ruhige, klare Haut.	Morgens und abends eine kleine Menge auf der feuchten Haut einmassieren und mit lauwarmem Wasser abspülen.	Teebaumöl und botanische Extrakte, pH-Wert ca. 5,0. Frei von Parabenen, Silikonen, künstlichen Farbstoffen und Mineralölen.	867	de	286
COSRX Low pH Good Morning Gel Cleanser	Gel nettoyant	Un gel nettoyant doux au pH bas pour bien commencer la journée. Avec un pH d’environ 5,0, il nettoie en profondeur sans dessécher, respecte la barrière naturelle et élimine sébum et impuretés. L’huile d’arbre à thé et des extraits botaniques gardent la peau calme et nette.	Matin et soir, masser une petite quantité sur peau humide et rincer à l’eau tiède.	Huile d’arbre à thé et extraits botaniques, pH d’environ 5,0. Sans parabènes, silicones, colorants artificiels ni huiles minérales.	868	fr	286
COSRX Low pH Good Morning Gel Cleanser	Gel detergente	Un gel detergente delicato a pH basso per iniziare bene la giornata. Con un pH di circa 5,0 deterge a fondo senza seccare, rispetta la barriera naturale e rimuove sebo e impurità. Olio di tea tree ed estratti botanici mantengono la pelle calma e pulita.	Mattina e sera massaggiare una piccola quantità sulla pelle umida e risciacquare con acqua tiepida.	Olio di tea tree ed estratti botanici, pH circa 5,0. Senza parabeni, siliconi, coloranti artificiali e oli minerali.	869	it	286
COSRX Low pH Good Morning Gel Cleanser	Gel cleanser	A mild, low-pH gel cleanser for a fresh start to the day. With a pH of about 5.0 it cleanses thoroughly without drying, respects the skin’s natural barrier and removes excess oil and impurities. Tea tree oil and botanical extracts keep skin calm and clear.	Massage a small amount over damp skin, morning and evening, and rinse with lukewarm water.	Tea tree oil and botanical extracts, pH about 5.0. Free from parabens, silicones, artificial colours and mineral oils.	870	en	286
Lagom Cellup Micro Foam Cleanser	Reinigungsschaum	Sanfte Reinigung für strahlend schöne Haut. Die Mikro-Schaum-Technologie reinigt porentief und entfernt Schmutz und überschüssiges Öl, die pH-hautneutrale Formel bewahrt die natürliche Feuchtigkeitsbalance. Täglich anwendbar, auch bei sensibler Haut.	Eine kleine Menge mit Wasser aufschäumen, auf der feuchten Haut einmassieren und mit lauwarmem Wasser abspülen.	Pflanzliche Tenside und Feuchtigkeitsspender. pH-hautneutral.	871	de	287
Lagom Cellup Micro Foam Cleanser	Mousse nettoyante	Une mousse micro-bulles douce pour une peau nette et lumineuse. Sa mousse fine nettoie les pores et élimine impuretés et excès de sébum, tandis que la formule au pH neutre préserve l’hydratation. Assez douce pour un usage quotidien, même sur peau sensible.	Faire mousser une petite quantité avec de l’eau, masser sur peau humide et rincer à l’eau tiède.	Tensioactifs végétaux et agents hydratants. pH neutre.	872	fr	287
Lagom Cellup Micro Foam Cleanser	Schiuma detergente	Una schiuma a micro-bolle delicata per una pelle pulita e luminosa. La schiuma fine pulisce i pori e rimuove impurità e sebo in eccesso, mentre la formula a pH neutro preserva l’idratazione. Delicata per l’uso quotidiano, anche su pelle sensibile.	Emulsionare una piccola quantità con acqua, massaggiare sulla pelle umida e risciacquare con acqua tiepida.	Tensioattivi vegetali e agenti idratanti. pH neutro.	873	it	287
Lagom Cellup Micro Foam Cleanser	Cleansing foam	A gentle micro-foam cleanser for beautifully clear skin. Its fine foam cleanses pores and removes dirt and excess oil, while the pH-neutral formula keeps skin moisturised and balanced. Gentle enough for daily use, even on sensitive skin.	Lather a small amount with water, massage over damp skin and rinse with lukewarm water.	Plant-based surfactants and moisturising agents. pH-neutral.	874	en	287
b:plain Mung Bean Cleansing Foam	Reinigungsschaum	Sanfte Reinigung mit der Kraft der Mungbohne – für einen natürlichen Glow jeden Tag. Entfernt Schmutz und Überschuss sanft, sorgt für reinere, strahlendere Haut und bewahrt die Feuchtigkeit ohne Spannungsgefühl. Für alle Hauttypen, auch für empfindliche Haut.	Eine kleine Menge mit Wasser aufschäumen, auf der feuchten Haut einmassieren und mit lauwarmem Wasser abspülen.	Mungbohnen-Extrakt. Vegan, frei von Parabenen, Sulfaten und künstlichen Duftstoffen.	875	de	288
b:plain Mung Bean Cleansing Foam	Mousse nettoyante	Une mousse nettoyante douce à la puissance du haricot mungo pour un éclat naturel au quotidien. Elle élimine en douceur impuretés et excès de sébum, rend la peau plus nette et lumineuse et préserve l’hydratation sans tiraillement. Pour tous les types de peau, même sensibles.	Faire mousser une petite quantité avec de l’eau, masser sur peau humide et rincer à l’eau tiède.	Extrait de haricot mungo. Vegan, sans parabènes, sulfates ni parfums artificiels.	876	fr	288
b:plain Mung Bean Cleansing Foam	Schiuma detergente	Una schiuma detergente delicata con la forza del fagiolo mungo per un glow naturale ogni giorno. Rimuove delicatamente impurità e sebo in eccesso, rende la pelle più pulita e luminosa e preserva l’idratazione senza tirare. Per tutti i tipi di pelle, anche sensibili.	Emulsionare una piccola quantità con acqua, massaggiare sulla pelle umida e risciacquare con acqua tiepida.	Estratto di fagiolo mungo. Vegano, senza parabeni, solfati e profumi artificiali.	877	it	288
b:plain Mung Bean Cleansing Foam	Cleansing foam	A gentle cleansing foam powered by mung bean for a natural glow every day. It removes dirt and excess oil softly, leaves skin fresher and brighter, and keeps moisture in without a tight feeling. Suitable for all skin types, including sensitive skin.	Lather a small amount with water, massage over damp skin and rinse with lukewarm water.	Mung bean extract. Vegan, free from parabens, sulfates and artificial fragrance.	878	en	288
JIPU Cleansing Balm	Reinigungsbalsam	Der JIPU Cleansing Balm entfernt effektiv Make-up, Schmutz und überschüssiges Öl – für eine saubere, gepflegte und frische Haut. Die angenehme Balm-Textur löst sich leicht auf und lässt sich einfach abwaschen, reinigt die Poren und spendet Feuchtigkeit. Vegan, dermatologisch getestet und für empfindliche Haut geeignet.	Auf die trockene Haut einmassieren, um Make-up und Sonnenschutz zu lösen, mit etwas Wasser emulgieren und abspülen. Danach einen Schaumreiniger verwenden.	\N	879	de	289
JIPU Cleansing Balm	Baume démaquillant	Un baume démaquillant hydratant qui élimine efficacement maquillage, crème solaire, impuretés et excès de sébum pour une peau nette et fraîche. Le baume fondant se rince facilement, nettoie les pores et laisse la peau souple. Vegan et testé dermatologiquement, convient aux peaux sensibles.	Masser sur peau sèche pour dissoudre maquillage et crème solaire, émulsionner avec un peu d’eau puis rincer. Poursuivre avec une mousse nettoyante.	\N	880	fr	289
JIPU Cleansing Balm	Balsamo detergente	Un balsamo detergente idratante che rimuove efficacemente trucco, protezione solare, impurità e sebo in eccesso per una pelle pulita e fresca. Il balsamo si scioglie a contatto e si risciacqua facilmente, pulisce i pori e lascia la pelle morbida. Vegano e dermatologicamente testato, adatto alle pelli sensibili.	Massaggiare sulla pelle asciutta per sciogliere trucco e protezione solare, emulsionare con poca acqua e risciacquare. Proseguire con una schiuma detergente.	\N	881	it	289
JIPU Cleansing Balm	Cleansing balm	A hydrating cleansing balm that effectively removes make-up, sunscreen, dirt and excess oil for clean, fresh skin. The soft balm melts on contact and rinses off easily, cleanses pores and leaves skin supple. Vegan and dermatologically tested, suitable for sensitive skin.	Massage onto dry skin to dissolve make-up and sunscreen, add a little water to emulsify and rinse. Follow with a foam cleanser.	\N	882	en	289
Innisfree Green Tea Amino Hydrating Cleansing Foam	Schiuma detergente	Una schiuma detergente idratante al tè verde e aminoacidi. Deterge delicatamente mantenendo la pelle morbida e confortevole e rimuove impurità e sebo in eccesso per un incarnato fresco e luminoso. Per tutti i tipi di pelle.	Emulsionare una piccola quantità con acqua, massaggiare sulla pelle umida e risciacquare con acqua tiepida.	Tè verde e aminoacidi. Senza parabeni e oli minerali.	883	it	290
Innisfree Green Tea Amino Hydrating Cleansing Foam	Reinigungsschaum	Ein sanfter, feuchtigkeitsspendender Reinigungsschaum mit Grüntee und Aminosäuren. Reinigt mild und hält die Haut geschmeidig und angenehm, entfernt Unreinheiten und überschüssigen Talg für einen frischen, strahlenden Teint. Für alle Hauttypen.	Eine kleine Menge mit Wasser aufschäumen, auf der feuchten Haut einmassieren und mit lauwarmem Wasser abspülen.	Grüntee und Aminosäuren. Frei von Parabenen und Mineralölen.	884	de	290
Innisfree Green Tea Amino Hydrating Cleansing Foam	Mousse nettoyante	Une mousse nettoyante hydratante au thé vert et aux acides aminés. Elle nettoie en douceur tout en gardant la peau souple et confortable, et élimine impuretés et excès de sébum pour un teint frais et lumineux. Pour tous les types de peau.	Faire mousser une petite quantité avec de l’eau, masser sur peau humide et rincer à l’eau tiède.	Thé vert et acides aminés. Sans parabènes ni huiles minérales.	885	fr	290
Innisfree Green Tea Amino Hydrating Cleansing Foam	Cleansing foam	A gentle hydrating cleansing foam with green tea and amino acids. It cleanses softly while keeping skin supple and comfortable, and removes impurities and excess oil for a fresh, luminous complexion. Suitable for all skin types.	Lather a small amount with water, massage over damp skin and rinse with lukewarm water.	Green tea and amino acids. Free from parabens and mineral oils.	886	en	290
Mixsoon Bean Essence	Essenz	Die Bean Essence von mixsoon besteht aus 100 % fermentiertem Sojabohnenextrakt. Sie spendet intensive Feuchtigkeit, verbessert den Hautton und stärkt die Hautbarriere – für eine gesunde, strahlende Haut. Minimal und effektiv, besonders für empfindliche, trockene und gereizte Haut.	Nach dem Gesichtswasser einige Tropfen in die Haut einklopfen, vor Serum und Creme.	100 % fermentierter Sojabohnenextrakt. Ohne Zusatzstoffe, Farbstoffe und ätherische Öle.	887	de	291
Mixsoon Bean Essence	Essence	Une essence pure composée à 100 % d’extrait de soja fermenté. Elle hydrate durablement, affine et unifie le teint pour un éclat naturel et renforce la barrière cutanée. Minimaliste et efficace, pour peaux sensibles, sèches et irritées.	Après la lotion, faire pénétrer quelques gouttes en tapotant, avant le sérum et la crème.	100 % d’extrait de soja fermenté. Sans additifs, colorants ni huiles essentielles.	888	fr	291
Mixsoon Bean Essence	Essenza	Un’essenza pura composta al 100 % da estratto di soia fermentato. Idrata a lungo, affina e uniforma l’incarnato per un glow naturale e rafforza la barriera cutanea. Minimalista ed efficace, per pelli sensibili, secche e irritate.	Dopo il tonico picchiettare qualche goccia sulla pelle, prima di siero e crema.	100 % estratto di soia fermentato. Senza additivi, coloranti e oli essenziali.	889	it	291
Mixsoon Bean Essence	Essence	A pure essence made from 100 % fermented soybean extract. It gives long-lasting moisture, refines and evens the skin tone for a natural glow, and strengthens the skin barrier. Minimal and effective, for sensitive, dry and irritated skin.	After toner, pat a few drops into the skin before serum and cream.	100 % fermented soybean extract. No additives, colours or essential oils.	890	en	291
Anua Heartleaf 77% Soothing Toner	Gesichtswasser	Beruhigender Toner für gesunde, hydrierte Haut. Die milde Formel mit 77 % Herzblatt-Extrakt und Hyaluronsäure spendet intensiv Feuchtigkeit, beruhigt gereizte Haut und stärkt die Hautbarriere. Leichte Textur, zieht schnell ein. Besonders für empfindliche, trockene und gereizte Haut.	Nach der Reinigung mit den Händen oder einem Wattepad auftragen und sanft einklopfen.	77 % Herzblatt-Extrakt (Houttuynia Cordata) und Hyaluronsäure. Frei von Parabenen, Alkohol und Duftstoffen.	891	de	292
Anua Heartleaf 77% Soothing Toner	Lotion tonique	Une lotion tonique douce et apaisante à 77 % d’extrait de houttuynia et acide hyaluronique pour une peau saine et hydratée. Elle calme les peaux sensibles et les rougeurs, hydrate durablement et renforce la barrière cutanée, avec une texture légère. Pour peaux sensibles, sèches et irritées.	Après le nettoyage, appliquer avec les mains ou un coton et faire pénétrer en tapotant.	77 % d’extrait de houttuynia cordata et acide hyaluronique. Sans parabènes, alcool ni parfum.	892	fr	292
Anua Heartleaf 77% Soothing Toner	Tonico	Un tonico delicato e lenitivo con il 77 % di estratto di houttuynia e acido ialuronico per una pelle sana e idratata. Calma pelli sensibili e rossori, idrata a lungo e rafforza la barriera cutanea, con una texture leggera. Per pelli sensibili, secche e irritate.	Dopo la detersione applicare con le mani o un dischetto e picchiettare delicatamente.	77 % di estratto di houttuynia cordata e acido ialuronico. Senza parabeni, alcol e profumo.	893	it	292
Anua Heartleaf 77% Soothing Toner	Toner	A mild, soothing toner with 77 % heartleaf extract and hyaluronic acid for healthy, hydrated skin. It calms sensitive skin and redness, gives long-lasting moisture and strengthens the skin barrier, with a light texture that absorbs quickly. For sensitive, dry and irritated skin.	After cleansing, apply with your hands or a cotton pad and pat in gently.	77 % heartleaf (houttuynia cordata) extract and hyaluronic acid. Free from parabens, alcohol and fragrance.	894	en	292
COSRX Advanced Snail 96 Mucin Power Essence	Essenz	Diese leichte Essence mit 96 % Schneckenschleimfiltrat versorgt die Haut intensiv mit Feuchtigkeit, unterstützt die Regeneration und verleiht ein gesundes, strahlendes Hautbild. Repariert die Hautbarriere, verbessert die Hauttextur und mildert Unreinheiten und Rötungen. Besonders für trockene und geschädigte Haut.	Nach dem Gesichtswasser einige Tropfen in die Haut einklopfen, vor Serum und Creme.	96 % Schneckenschleimfiltrat. Frei von Parabenen und Silikonen.	895	de	293
COSRX Advanced Snail 96 Mucin Power Essence	Essence	Une essence légère à 96 % de filtrat de bave d’escargot qui répare, hydrate et régénère. Elle renforce la barrière cutanée, repulpe la peau d’une hydratation durable et affine le grain de peau tout en apaisant imperfections et rougeurs. Idéale pour les peaux sèches et abîmées.	Après la lotion, faire pénétrer quelques gouttes en tapotant, avant le sérum et la crème.	96 % de filtrat de bave d’escargot. Sans parabènes ni silicones.	896	fr	293
COSRX Advanced Snail 96 Mucin Power Essence	Essenza	Un’essenza leggera con il 96 % di filtrato di bava di lumaca che ripara, idrata e rigenera. Rafforza la barriera cutanea, rimpolpa la pelle con un’idratazione duratura e affina la grana della pelle, lenendo imperfezioni e rossori. Ideale per pelli secche e danneggiate.	Dopo il tonico picchiettare qualche goccia sulla pelle, prima di siero e crema.	96 % di filtrato di bava di lumaca. Senza parabeni e siliconi.	897	it	293
COSRX Advanced Snail 96 Mucin Power Essence	Essence	A light essence with 96 % snail secretion filtrate that repairs, hydrates and regenerates. It strengthens the skin barrier, plumps the skin with long-lasting moisture and refines the skin texture, while calming blemishes and redness. Especially good for dry and damaged skin.	After toner, pat a few drops into the skin before serum and cream.	96 % snail secretion filtrate. Free from parabens and silicones.	898	en	293
Anua PDRN Hyaluronic Glow Pad	Toner-Pads	Für strahlende, hydratisierte und beruhigte Haut – jeden Tag. Mit PDRN und Hyaluronsäure für tiefenwirksame Hydration, verfeinert das Hautbild für einen natürlichen Glow und beruhigt empfindliche Haut. Einfach in der Anwendung, perfekt für die tägliche Skincare-Routine.	Nach der Reinigung mit einem Pad über das Gesicht streichen und die restliche Essenz einklopfen.	PDRN und Hyaluronsäure.	899	de	294
Anua PDRN Hyaluronic Glow Pad	Disques tonifiants	Des disques tonifiants au PDRN et à l’acide hyaluronique pour une peau lumineuse, hydratée et apaisée au quotidien. Ils hydratent en profondeur, affinent le grain de peau pour un éclat naturel et apaisent les peaux sensibles. Un disque, une étape : idéal pour une routine rapide.	Après le nettoyage, passer un disque sur le visage et faire pénétrer l’essence restante en tapotant.	PDRN et acide hyaluronique.	900	fr	294
Anua PDRN Hyaluronic Glow Pad	Dischetti tonificanti	Dischetti tonificanti con PDRN e acido ialuronico per una pelle luminosa, idratata e calma ogni giorno. Idratano in profondità, affinano la grana per un glow naturale e leniscono le pelli sensibili. Un dischetto, un passaggio: perfetti per una routine veloce.	Dopo la detersione passare un dischetto sul viso e picchiettare l’essenza rimasta.	PDRN e acido ialuronico.	901	it	294
Anua PDRN Hyaluronic Glow Pad	Toner pads	Toner pads with PDRN and hyaluronic acid for radiant, hydrated and calm skin every day. They give deep hydration, refine the skin texture for a natural glow and soothe sensitive skin. One pad, one step: perfect for a quick daily routine.	After cleansing, sweep a pad over the face and pat the remaining essence into the skin.	PDRN and hyaluronic acid.	902	en	294
Innisfree Green Tea Seed Hyaluronic Serum	Serum	Feuchtigkeit. Balance. Strahlende Haut. Hyaluronsäure spendet Feuchtigkeit und bewahrt die Haut vor dem Austrocknen, grüner Tee aus Jeju liefert Aminosäuren und Antioxidantien, beruhigt und schützt. Für einen frischen, strahlenden Teint – leicht, schnell einziehend und ohne zu kleben.	Nach dem Gesichtswasser 2–3 Tropfen auf das Gesicht geben und vor der Creme einklopfen.	Hyaluronsäure und grüner Tee aus Jeju (Aminosäuren, Antioxidantien). Vegan.	903	de	295
Innisfree Green Tea Seed Hyaluronic Serum	Sérum	Un sérum hydratant à l’acide hyaluronique et au thé vert de Jeju pour une peau hydratée, équilibrée et lumineuse. Il prévient le dessèchement, apaise et protège grâce aux acides aminés et antioxydants. Léger, il pénètre vite sans coller.	Après la lotion, appliquer 2 à 3 gouttes sur le visage et tapoter avant la crème.	Acide hyaluronique et thé vert de Jeju (acides aminés, antioxydants). Vegan.	904	fr	295
Innisfree Green Tea Seed Hyaluronic Serum	Siero	Un siero idratante con acido ialuronico e tè verde di Jeju per una pelle idratata, equilibrata e luminosa. Previene la secchezza, lenisce e protegge con aminoacidi e antiossidanti. Leggero, si assorbe in fretta senza appiccicare.	Dopo il tonico applicare 2–3 gocce sul viso e picchiettare prima della crema.	Acido ialuronico e tè verde di Jeju (aminoacidi, antiossidanti). Vegano.	905	it	295
Innisfree Green Tea Seed Hyaluronic Serum	Serum	A hydrating serum with hyaluronic acid and green tea from Jeju for moisture, balance and radiant skin. It prevents dryness, calms and protects with amino acids and antioxidants, and leaves skin revitalised and glowing. Light, fast-absorbing and never sticky.	After toner, apply 2–3 drops to the face and pat in before your cream.	Hyaluronic acid and green tea from Jeju (amino acids, antioxidants). Vegan.	906	en	295
Beauty of Joseon Revive Eye Serum Ginseng + Retinal	Augenserum	Ein hochwirksames Augenserum mit Ginseng und Retinal für sichtbar glattere, straffere und strahlendere Augenpartie. Ginseng-Extrakt vitalisiert und stärkt, Retinal unterstützt die Zellerneuerung und mindert feine Linien, intensive Feuchtigkeit bewahrt die Elastizität. Speziell für die empfindliche Augenpartie entwickelt.	Morgens und abends eine kleine Menge sanft um die Augenpartie einklopfen.	Ginseng-Extrakt und Retinal. Vegan, tierversuchsfrei.	907	de	296
Beauty of Joseon Revive Eye Serum Ginseng + Retinal	Sérum contour des yeux	Un sérum contour des yeux très efficace au ginseng et au rétinal pour un regard visiblement plus lisse, plus ferme et plus lumineux. Le ginseng revitalise, le rétinal soutient le renouvellement cellulaire et atténue les ridules, et une hydratation intense préserve la souplesse. Spécialement conçu pour la zone délicate des yeux.	Matin et soir, tapoter délicatement une petite quantité sur le contour des yeux.	Extrait de ginseng et rétinal. Vegan, non testé sur les animaux.	908	fr	296
Beauty of Joseon Revive Eye Serum Ginseng + Retinal	Siero contorno occhi	Un siero contorno occhi molto efficace con ginseng e retinale per uno sguardo visibilmente più liscio, tonico e luminoso. Il ginseng rivitalizza, il retinale sostiene il rinnovamento cellulare e attenua le linee sottili, e un’idratazione intensa preserva l’elasticità. Studiato per la zona delicata degli occhi.	Mattina e sera picchiettare delicatamente una piccola quantità sul contorno occhi.	Estratto di ginseng e retinale. Vegano, cruelty-free.	909	it	296
Beauty of Joseon Revive Eye Serum Ginseng + Retinal	Eye serum	A highly effective eye serum with ginseng and retinal for a visibly smoother, firmer and brighter eye area. Ginseng revitalises and strengthens delicate skin, retinal supports cell renewal and reduces fine lines, and intense moisture keeps the area supple. Gentle enough for sensitive skin.	Morning and evening, tap a small amount gently around the eye area.	Ginseng extract and retinal. Vegan, cruelty-free.	910	en	296
Beauty of Joseon Glow Serum Propolis + Niacinamide	Serum	Strahlende Haut, tiefenwirksam gepflegt. Propolis-Extrakt (60 %) nährt und stärkt die Hautbarriere, Niacinamid verfeinert das Hautbild und sorgt für einen ebenmässigen Teint. Leichte, nicht klebrige Textur, zieht schnell ein und spendet intensive Feuchtigkeit. Für alle Hauttypen, auch für empfindliche Haut.	Nach dem Gesichtswasser 2–3 Tropfen auf das Gesicht geben und vor der Creme einklopfen.	60 % Propolis-Extrakt und Niacinamid. Vegan, tierversuchsfrei.	911	de	297
Beauty of Joseon Glow Serum Propolis + Niacinamide	Sérum	Un sérum éclat à 60 % d’extrait de propolis et niacinamide pour une peau lumineuse et nourrie en profondeur. La propolis nourrit et renforce la barrière cutanée, la niacinamide affine le grain de peau et unifie le teint, et la texture légère pénètre vite. Pour tous les types de peau, même sensibles.	Après la lotion, appliquer 2 à 3 gouttes sur le visage et tapoter avant la crème.	60 % d’extrait de propolis et niacinamide. Vegan, non testé sur les animaux.	912	fr	297
Beauty of Joseon Glow Serum Propolis + Niacinamide	Siero	Un siero illuminante con il 60 % di estratto di propoli e niacinamide per una pelle luminosa e nutrita in profondità. La propoli nutre e rafforza la barriera cutanea, la niacinamide affina la grana e uniforma l’incarnato, e la texture leggera si assorbe in fretta. Per tutti i tipi di pelle, anche sensibili.	Dopo il tonico applicare 2–3 gocce sul viso e picchiettare prima della crema.	60 % di estratto di propoli e niacinamide. Vegano, cruelty-free.	913	it	297
Beauty of Joseon Glow Serum Propolis + Niacinamide	Serum	A glow serum with 60 % propolis extract and niacinamide for radiant, deeply cared-for skin. Propolis nourishes and strengthens the skin barrier, niacinamide refines the complexion and evens the skin tone, and the light texture absorbs quickly. Suitable for all skin types, including sensitive skin.	After toner, apply 2–3 drops to the face and pat in before your cream.	60 % propolis extract and niacinamide. Vegan, cruelty-free.	914	en	297
Torriden Dive-In Serum	Serum	Intensive Feuchtigkeit für pralle, gesunde Haut. Das DIVE IN Serum mit niedermolekularer Hyaluronsäure spendet tiefenwirksam Feuchtigkeit, beruhigt die Haut und stärkt die natürliche Hautbarriere. Leichte, nicht klebrige Textur – perfekt für jeden Hauttyp, auch für empfindliche Haut.	Nach dem Gesichtswasser 2–3 Tropfen auf das Gesicht geben und vor der Creme einklopfen.	Niedermolekulare Hyaluronsäure. Frei von Parabenen, Mineralölen und Alkohol. Tierversuchsfrei.	915	de	298
Torriden Dive-In Serum	Sérum	Un sérum hydratant à l’acide hyaluronique de faible poids moléculaire pour une peau repulpée et saine. Il pénètre en profondeur pour une hydratation durable, renforce la barrière cutanée et laisse un fini frais et non collant. Assez doux pour les peaux sensibles et tous les types de peau.	Après la lotion, appliquer 2 à 3 gouttes sur le visage et tapoter avant la crème.	Acide hyaluronique de faible poids moléculaire. Sans parabènes, huiles minérales ni alcool. Non testé sur les animaux.	916	fr	298
Torriden Dive-In Serum	Siero	Un siero idratante con acido ialuronico a basso peso molecolare per una pelle rimpolpata e sana. Penetra in profondità per un’idratazione duratura, rafforza la barriera cutanea e lascia un finish fresco e non appiccicoso. Delicato per pelli sensibili e tutti i tipi di pelle.	Dopo il tonico applicare 2–3 gocce sul viso e picchiettare prima della crema.	Acido ialuronico a basso peso molecolare. Senza parabeni, oli minerali e alcol. Cruelty-free.	917	it	298
Torriden Dive-In Serum	Serum	A hydrating serum with low-molecular hyaluronic acid for plump, healthy-looking skin. It penetrates deeply for long-lasting moisture, strengthens the skin barrier and leaves a refreshing, non-sticky finish. Mild enough for sensitive skin and for all skin types.	After toner, apply 2–3 drops to the face and pat in before your cream.	Low-molecular hyaluronic acid. Free from parabens, mineral oils and alcohol. Cruelty-free.	918	en	298
Anua 100+ Hyaluron Serum	Serum	Intensive Feuchtigkeit für pralle, gesunde Haut. Mit 10 Arten von Hyaluronsäure für maximale Feuchtigkeitsversorgung: polstert auf und glättet feine Linien, stärkt die Hautbarriere und zieht schnell ein – perfekt für die tägliche Pflege, auch unter Make-up. Für alle Hauttypen.	Nach dem Gesichtswasser 2–3 Tropfen auf das Gesicht geben und vor der Creme einklopfen.	10 Arten von Hyaluronsäure, darunter FORN-Hyaluronsäure-Kapseln.	919	de	299
Anua 100+ Hyaluron Serum	Sérum	Un sérum hydratant intensif à 10 types d’acide hyaluronique pour une peau repulpée et éclatante. Il hydrate durablement, lisse les ridules, renforce la barrière cutanée et pénètre vite, idéal au quotidien et sous le maquillage. Pour tous les types de peau.	Après la lotion, appliquer 2 à 3 gouttes sur le visage et tapoter avant la crème.	10 types d’acide hyaluronique, dont des capsules d’acide hyaluronique FORN.	920	fr	299
Anua 100+ Hyaluron Serum	Siero	Un siero idratante intensivo con 10 tipi di acido ialuronico per una pelle rimpolpata e luminosa. Idrata a lungo, leviga le linee sottili, rafforza la barriera cutanea e si assorbe in fretta, perfetto ogni giorno e sotto il trucco. Per tutti i tipi di pelle.	Dopo il tonico applicare 2–3 gocce sul viso e picchiettare prima della crema.	10 tipi di acido ialuronico, tra cui capsule di acido ialuronico FORN.	921	it	299
Anua 100+ Hyaluron Serum	Serum	An intensive hydrating serum with 10 types of hyaluronic acid for plump, glowing skin. It gives long-lasting moisture, smooths fine lines, strengthens the skin barrier and absorbs quickly, perfect for daily care and under make-up. Suitable for all skin types.	After toner, apply 2–3 drops to the face and pat in before your cream.	10 types of hyaluronic acid, including FORN hyaluronic acid capsules.	922	en	299
Medicube PDRN Pink Peptide Serum	Serum	Für strahlende, glatte und gesunde Haut. PDRN fördert die Hauterneuerung und unterstützt die Heilung, Peptide verbessern die Hautstruktur und sorgen für mehr Spannkraft, tiefenwirksame Feuchtigkeit verleiht einen natürlichen Glow. Dermatologisch getestet und für alle Hauttypen geeignet.	Nach dem Gesichtswasser 2–3 Tropfen auf das Gesicht geben und vor der Creme einklopfen.	PDRN (Natrium-DNA) und ein Komplex aus 5 Peptiden. Vegan, frei von Parabenen und künstlichen Farbstoffen. Hergestellt in Korea.	923	de	300
Medicube PDRN Pink Peptide Serum	Sérum	Un sérum régénérant au PDRN et aux peptides pour une peau lumineuse, lisse et saine. Le PDRN soutient le renouvellement et la réparation de la peau, les peptides améliorent élasticité et fermeté, et une hydratation profonde apporte un éclat naturel. Testé dermatologiquement, pour tous les types de peau.	Après la lotion, appliquer 2 à 3 gouttes sur le visage et tapoter avant la crème.	PDRN (ADN de sodium) et complexe de 5 peptides. Vegan, sans parabènes ni colorants artificiels. Fabriqué en Corée.	924	fr	300
Medicube PDRN Pink Peptide Serum	Siero	Un siero rigenerante con PDRN e peptidi per una pelle luminosa, liscia e sana. Il PDRN sostiene il rinnovamento e la riparazione della pelle, i peptidi migliorano elasticità e tonicità e un’idratazione profonda dona un glow naturale. Dermatologicamente testato, per tutti i tipi di pelle.	Dopo il tonico applicare 2–3 gocce sul viso e picchiettare prima della crema.	PDRN (DNA di sodio) e complesso di 5 peptidi. Vegano, senza parabeni e coloranti artificiali. Prodotto in Corea.	925	it	300
Medicube PDRN Pink Peptide Serum	Serum	A regenerating serum with PDRN and peptides for radiant, smooth and healthy-looking skin. PDRN supports skin renewal and recovery, peptides improve elasticity and firmness, and deep hydration leaves a fresh, natural glow. Dermatologically tested and suitable for all skin types.	After toner, apply 2–3 drops to the face and pat in before your cream.	PDRN (sodium DNA) and a 5-type peptide complex. Vegan, free from parabens and artificial colours. Made in Korea.	926	en	300
Laneige Water Sleeping Mask	Schlafmaske	Über Nacht zu strahlender, hydratisierter Haut. Versorgt die Haut über Nacht intensiv mit Feuchtigkeit, für einen frischen, strahlenden Teint am Morgen, verbessert die Hautstruktur und macht sie zart und geschmeidig. Leichte Gel-Textur, zieht schnell ein. Dermatologisch getestet, für alle Hauttypen.	Als letzten Schritt der Abendroutine dünn auftragen und über Nacht einwirken lassen. Am Morgen abwaschen.	\N	927	de	301
Laneige Water Sleeping Mask	Masque de nuit	Un masque de nuit pour une peau lumineuse et hydratée au réveil. Il hydrate intensément pendant le sommeil, apporte un éclat frais et une peau plus lisse et plus douce, avec une texture gel légère qui pénètre vite. Testé dermatologiquement, pour tous les types de peau.	En dernière étape de la routine du soir, appliquer une fine couche et laisser agir toute la nuit. Rincer le matin.	\N	928	fr	301
Laneige Water Sleeping Mask	Maschera notte	Una maschera notte per una pelle luminosa e idratata al risveglio. Idrata intensamente durante il sonno, dona un glow fresco e una pelle più liscia e morbida, con una texture in gel leggera che si assorbe in fretta. Dermatologicamente testata, per tutti i tipi di pelle.	Come ultimo passaggio della routine serale applicare uno strato sottile e lasciare agire tutta la notte. Risciacquare al mattino.	\N	929	it	301
Laneige Water Sleeping Mask	Overnight mask	An overnight mask for radiant, hydrated skin by morning. It moisturises intensively while you sleep, leaves a fresh glow and smoother, softer skin, with a light gel texture that absorbs quickly. Dermatologically tested and suitable for all skin types.	As the last step of your evening routine, apply a thin layer and leave on overnight. Rinse in the morning.	\N	930	en	301
Merikit Regenerating Calming Mask	Beruhigende Maske	Regeneration. Beruhigung. Balance. Die Maske hilft, Rötungen zu reduzieren und die Haut spürbar zu beruhigen, spendet intensiv Feuchtigkeit, unterstützt die natürliche Regeneration und stärkt die Haut. Hochwertige Inhaltsstoffe aus Natur und Wissenschaft – für alle Hauttypen, auch für empfindliche Haut.	Grosszügig auf die gereinigte Haut auftragen, 10–15 Minuten einwirken lassen und abspülen. 2–3 Mal pro Woche.	\N	931	de	302
Merikit Regenerating Calming Mask	Masque apaisant	Un masque apaisant et régénérant pour une peau saine et lumineuse. Il calme irritations et rougeurs, hydrate intensément, soutient la régénération naturelle et renforce la peau. Des ingrédients de qualité, entre nature et science, pour tous les types de peau, même sensibles.	Appliquer une couche généreuse sur peau propre, laisser poser 10 à 15 minutes puis rincer. 2 à 3 fois par semaine.	\N	932	fr	302
Merikit Regenerating Calming Mask	Maschera lenitiva	Una maschera lenitiva e rigenerante per una pelle sana e luminosa. Calma irritazioni e rossori, idrata intensamente, sostiene la rigenerazione naturale e rinforza la pelle. Ingredienti di qualità tra natura e scienza, per tutti i tipi di pelle, anche sensibili.	Applicare uno strato generoso sulla pelle pulita, lasciare in posa 10–15 minuti e risciacquare. 2–3 volte a settimana.	\N	933	it	302
Merikit Regenerating Calming Mask	Calming mask	A regenerating calming mask for healthy, radiant skin. It soothes irritation and redness, gives intense moisture, supports the skin’s natural regeneration and strengthens it. High-quality ingredients from nature and science, suitable for all skin types, including sensitive skin.	Apply a generous layer to clean skin, leave on for 10–15 minutes and rinse. Use 2–3 times a week.	\N	934	en	302
Torriden Balanceful Cica Mask	Tuchmaske, 1 Stück	Eine beruhigende Tuchmaske mit Cica, die die Haut besänftigt und ins Gleichgewicht bringt. Ideal nach einem langen Tag oder wenn die Haut gestresst und gereizt ist. Für alle Hauttypen.	Nach dem Gesichtswasser 15–20 Minuten auf das Gesicht legen, abnehmen und die restliche Essenz einklopfen.	\N	935	de	303
Torriden Balanceful Cica Mask	Masque en tissu, 1 pièce	Un masque en tissu apaisant à la cica qui calme et rééquilibre la peau. Idéal après une longue journée ou quand la peau est stressée et irritée. Pour tous les types de peau.	Après la lotion, poser le masque 15 à 20 minutes, le retirer et faire pénétrer l’essence restante.	\N	936	fr	303
Torriden Balanceful Cica Mask	Maschera in tessuto, 1 pezzo	Una maschera in tessuto lenitiva alla cica che calma e riequilibra la pelle. Ideale dopo una lunga giornata o quando la pelle è stressata e irritata. Per tutti i tipi di pelle.	Dopo il tonico applicare la maschera per 15–20 minuti, rimuoverla e picchiettare l’essenza rimasta.	\N	937	it	303
Torriden Balanceful Cica Mask	Sheet mask, 1 piece	A soothing sheet mask with cica that calms and balances the skin. Ideal after a long day or when skin feels stressed and irritated. Suitable for all skin types.	After toner, place the mask on the face for 15–20 minutes, remove and pat the remaining essence into the skin.	\N	938	en	303
Mediheal Collagen Mask	Tuchmaske, 1 Stück	Eine Tuchmaske mit Kollagen, die Feuchtigkeit spendet und die Elastizität der Haut verbessert. Für trockene oder müde Haut, die etwas mehr Spannkraft gebrauchen kann. Für alle Hauttypen.	Nach dem Gesichtswasser 15–20 Minuten auf das Gesicht legen, abnehmen und die restliche Essenz einklopfen.	\N	939	de	304
Mediheal Collagen Mask	Masque en tissu, 1 pièce	Un masque en tissu au collagène qui hydrate et améliore l’élasticité de la peau. Pour les peaux sèches ou fatiguées qui ont besoin de rebond. Pour tous les types de peau.	Après la lotion, poser le masque 15 à 20 minutes, le retirer et faire pénétrer l’essence restante.	\N	940	fr	304
Mediheal Collagen Mask	Maschera in tessuto, 1 pezzo	Una maschera in tessuto al collagene che idrata e migliora l’elasticità della pelle. Per pelli secche o stanche che hanno bisogno di più tono. Per tutti i tipi di pelle.	Dopo il tonico applicare la maschera per 15–20 minuti, rimuoverla e picchiettare l’essenza rimasta.	\N	941	it	304
Mediheal Collagen Mask	Sheet mask, 1 piece	A sheet mask with collagen that hydrates and improves skin elasticity. For skin that feels dry or tired and could use some extra bounce. Suitable for all skin types.	After toner, place the mask on the face for 15–20 minutes, remove and pat the remaining essence into the skin.	\N	942	en	304
Abib Gummy Sheet Mask Heartleaf Sticker	Tuchmaske, 1 Stück	Eine beruhigende Gummy-Tuchmaske mit Herzblatt, die empfindliche Haut besänftigt. Das weiche, haftende Tuch liegt eng an der Haut an. Ideal für empfindliche und gereizte Haut.	Nach dem Gesichtswasser 15–20 Minuten auf das Gesicht legen, abnehmen und die restliche Essenz einklopfen.	\N	943	de	305
Abib Gummy Sheet Mask Heartleaf Sticker	Masque en tissu, 1 pièce	Un masque gummy apaisant au houttuynia qui calme les peaux sensibles. Le tissu doux et adhérent épouse parfaitement la peau. Idéal pour les peaux sensibles et irritées.	Après la lotion, poser le masque 15 à 20 minutes, le retirer et faire pénétrer l’essence restante.	\N	944	fr	305
Abib Gummy Sheet Mask Heartleaf Sticker	Maschera in tessuto, 1 pezzo	Una maschera gummy lenitiva all’houttuynia che calma le pelli sensibili. Il tessuto morbido e aderente si adatta perfettamente alla pelle. Ideale per pelli sensibili e irritate.	Dopo il tonico applicare la maschera per 15–20 minuti, rimuoverla e picchiettare l’essenza rimasta.	\N	945	it	305
Abib Gummy Sheet Mask Heartleaf Sticker	Sheet mask, 1 piece	A soothing gummy sheet mask with heartleaf that calms sensitive skin. The soft, adhering sheet sits close to the skin for a comfortable treatment. Ideal for sensitive and irritated skin.	After toner, place the mask on the face for 15–20 minutes, remove and pat the remaining essence into the skin.	\N	946	en	305
Mediheal Vitamin C Mask	Tuchmaske, 1 Stück	Eine Tuchmaske mit Vitamin C, die die Haut belebt und für einen strahlenderen Teint sorgt. Perfekt, wenn die Haut fahl oder müde aussieht. Für alle Hauttypen.	Nach dem Gesichtswasser 15–20 Minuten auf das Gesicht legen, abnehmen und die restliche Essenz einklopfen.	\N	947	de	306
Mediheal Vitamin C Mask	Masque en tissu, 1 pièce	Un masque en tissu à la vitamine C qui revitalise la peau pour un teint plus lumineux. Parfait quand le teint est terne ou fatigué. Pour tous les types de peau.	Après la lotion, poser le masque 15 à 20 minutes, le retirer et faire pénétrer l’essence restante.	\N	948	fr	306
Mediheal Vitamin C Mask	Maschera in tessuto, 1 pezzo	Una maschera in tessuto alla vitamina C che rivitalizza la pelle per un incarnato più luminoso. Perfetta quando la pelle appare spenta o stanca. Per tutti i tipi di pelle.	Dopo il tonico applicare la maschera per 15–20 minuti, rimuoverla e picchiettare l’essenza rimasta.	\N	949	it	306
Mediheal Vitamin C Mask	Sheet mask, 1 piece	A brightening sheet mask with vitamin C that revitalises the skin for a more luminous complexion. Perfect when skin looks dull or tired. Suitable for all skin types.	After toner, place the mask on the face for 15–20 minutes, remove and pat the remaining essence into the skin.	\N	950	en	306
Torriden Solid-In Lip Essence	Lippenessenz	Intensive Pflege für zarte Lippen. Reichhaltige Essenz für geschmeidige, gepflegte und gesunde Lippen: spendet langanhaltend Feuchtigkeit, schützt vor dem Austrocknen und stärkt die natürliche Lippenbarriere. Milde, vegane Formel, praktisch und kompakt für unterwegs.	Bei Bedarf auf die Lippen auftragen. Praktisch für unterwegs.	\N	951	de	307
Torriden Solid-In Lip Essence	Essence pour les lèvres	Une essence riche pour des lèvres douces, soignées et en bonne santé. Elle hydrate durablement et protège du dessèchement, lisse et adoucit les lèvres et renforce leur barrière naturelle. Formule douce et vegan, dans un tube pratique à emporter.	Appliquer sur les lèvres dès qu’elles tiraillent. Pratique à emporter.	\N	952	fr	307
Torriden Solid-In Lip Essence	Essenza labbra	Un’essenza ricca per labbra morbide, curate e sane. Idrata a lungo e protegge dalla secchezza, leviga e ammorbidisce le labbra e ne rafforza la barriera naturale. Formula delicata e vegana, in un pratico tubetto da portare con sé.	Applicare sulle labbra quando serve. Comoda da portare con sé.	\N	953	it	307
Torriden Solid-In Lip Essence	Lip essence	A rich lip essence for soft, cared-for and healthy lips. It gives long-lasting moisture and protects against drying out, smooths and softens the lips and strengthens their natural barrier. Mild, vegan formula in a handy tube for on the go.	Apply to the lips whenever they feel dry. Handy for on the go.	\N	954	en	307
Laneige Lip Sleeping Mask Peach Iced Tea	Lippen-Schlafmaske	Die beliebte Lippenmaske von LANEIGE mit fruchtigem Pfirsich-Eistee-Duft. Spendet langanhaltende Feuchtigkeit, beugt trockenen Lippen vor und unterstützt über Nacht die natürliche Regeneration – für sichtbar weichere, glattere und gesünder aussehende Lippen am Morgen.	Vor dem Schlafengehen grosszügig auftragen und über Nacht einwirken lassen. Auch tagsüber verwendbar.	\N	955	de	308
Laneige Lip Sleeping Mask Peach Iced Tea	Masque de nuit pour les lèvres	Le masque de nuit pour les lèvres culte de Laneige, au parfum fruité de thé glacé à la pêche. Il hydrate intensément et durablement, soutient la régénération naturelle des lèvres pendant le sommeil et les laisse visiblement plus douces et plus lisses au réveil.	Appliquer une couche généreuse avant le coucher et laisser agir toute la nuit. Utilisable aussi en journée.	\N	956	fr	308
Laneige Lip Sleeping Mask Peach Iced Tea	Maschera notte labbra	L’amatissima maschera notte per le labbra di Laneige, con un profumo fruttato di tè freddo alla pesca. Idrata intensamente e a lungo, sostiene la rigenerazione naturale delle labbra durante il sonno e le lascia visibilmente più morbide e lisce al risveglio.	Applicare uno strato generoso prima di dormire e lasciare agire tutta la notte. Utilizzabile anche di giorno.	\N	957	it	308
Laneige Lip Sleeping Mask Peach Iced Tea	Lip sleeping mask	The much-loved overnight lip mask from Laneige with a fruity peach iced tea scent. It gives intense, long-lasting moisture, supports the lips’ natural regeneration while you sleep, and leaves them visibly softer and smoother by morning.	Apply a generous layer before bed and leave on overnight. Can also be used during the day.	\N	958	en	308
Round Lab Dokdo Hydration Routine	Routine-Set	Eine dreistufige Feuchtigkeitsroutine für hydratisierte, beruhigte und geschützte Haut – jeden Tag. Enthält Round Lab Dokdo 1025 Toner (tiefenwirksame Feuchtigkeit), Birch Juice Moisturizing Sun Cream (Feuchtigkeit und UV-Schutz) und Dokdo 1025 Mist Toner (erfrischt jederzeit). Sanfte Formeln für alle Hauttypen.	1. Toner nach der Reinigung. 2. Sonnencreme als letzter Schritt am Morgen. 3. Mist jederzeit zur Erfrischung, auch über dem Make-up.	\N	959	de	309
Round Lab Dokdo Hydration Routine	Coffret routine	Une routine hydratation en trois étapes pour une peau hydratée, apaisée et protégée au quotidien. Comprend Round Lab Dokdo 1025 Toner (hydratation profonde), Birch Juice Moisturizing Sun Cream (hydratation et protection UV) et Dokdo 1025 Mist Toner (rafraîchit à tout moment). Formules douces pour tous les types de peau.	1. Lotion après le nettoyage. 2. Crème solaire en dernière étape le matin. 3. Brume à tout moment pour rafraîchir, même sur le maquillage.	\N	960	fr	309
Round Lab Dokdo Hydration Routine	Set routine	Una routine idratante in tre passaggi per una pelle idratata, calma e protetta ogni giorno. Include Round Lab Dokdo 1025 Toner (idratazione profonda), Birch Juice Moisturizing Sun Cream (idratazione e protezione UV) e Dokdo 1025 Mist Toner (rinfresca in ogni momento). Formule delicate per tutti i tipi di pelle.	1. Tonico dopo la detersione. 2. Crema solare come ultimo passaggio al mattino. 3. Mist in qualsiasi momento per rinfrescare, anche sopra il trucco.	\N	961	it	309
Round Lab Dokdo Hydration Routine	Routine set	A three-step hydration routine for skin that’s moisturised, calm and protected every day. Includes Round Lab Dokdo 1025 Toner (deep hydration), Birch Juice Moisturizing Sun Cream (moisture and UV protection) and Dokdo 1025 Mist Toner (refreshes any time). Gentle formulas for all skin types.	1. Toner after cleansing. 2. Sun cream as the last step in the morning. 3. Mist whenever skin needs a refresh, also over make-up.	\N	962	en	309
Korean Routine Set: Clear, Hydrated & Protected	Routine-Set	Eine komplette koreanische Routine: reinigen, beruhigen, hydratisieren und schützen. Enthält Lagom Cellup Micro Foam Cleanser, Anua Toner-Pads, Manyo Pure Soybean Cleansing Oil und Mediheal Madecassoside Moisture Sun Serum. Sanfte Formeln für alle Hauttypen, auch für empfindliche Haut.	Abends: Reinigungsöl, danach Schaumreiniger, dann ein Toner-Pad. Morgens: Schaumreiniger, Toner-Pad und als letzten Schritt das Sonnenserum.	\N	963	de	310
Korean Routine Set: Clear, Hydrated & Protected	Coffret routine	Une routine coréenne complète pour nettoyer, apaiser, hydrater et protéger. Comprend Lagom Cellup Micro Foam Cleanser, les disques tonifiants Anua, Manyo Pure Soybean Cleansing Oil et Mediheal Madecassoside Moisture Sun Serum. Formules douces pour tous les types de peau, même sensibles.	Le soir : huile démaquillante, puis mousse nettoyante, puis un disque tonifiant. Le matin : mousse nettoyante, disque tonifiant et le sérum solaire en dernière étape.	\N	964	fr	310
Korean Routine Set: Clear, Hydrated & Protected	Set routine	Una routine coreana completa per detergere, lenire, idratare e proteggere. Include Lagom Cellup Micro Foam Cleanser, i dischetti tonificanti Anua, Manyo Pure Soybean Cleansing Oil e Mediheal Madecassoside Moisture Sun Serum. Formule delicate per tutti i tipi di pelle, anche sensibili.	La sera: olio detergente, poi schiuma detergente, poi un dischetto tonificante. Al mattino: schiuma detergente, dischetto e il siero solare come ultimo passaggio.	\N	965	it	310
Korean Routine Set: Clear, Hydrated & Protected	Routine set	A complete Korean routine to cleanse, soothe, hydrate and protect. Includes Lagom Cellup Micro Foam Cleanser, Anua toner pads, Manyo Pure Soybean Cleansing Oil and Mediheal Madecassoside Moisture Sun Serum. Gentle formulas for all skin types, including sensitive skin.	Evening: cleansing oil, then foam cleanser, then a toner pad. Morning: foam cleanser, toner pad and the sun serum as the last step.	\N	966	en	310
Korean Skincare Set: Glow & Gentle	Routine-Set	Eine Routine für Glow und sanfte Pflege in vier Schritten. Enthält eine Sonnencreme SPF 50+ PA++++, Bringgreen Tea Tree Cica Soothing Toner, ein aufhellendes Peeling-Gel und Aromatica Rosemary 3-in-1 Treatment für die Haare. Sanfte, cleane Formeln, auch für empfindliche Haut.	Toner nach der Reinigung, Sonnencreme jeden Morgen, Peeling-Gel 1–2 Mal pro Woche auf sauberer, trockener Haut, Rosmarin-Treatment nach dem Shampoo.	\N	967	de	311
Korean Skincare Set: Glow & Gentle	Coffret routine	Une routine éclat et douceur en quatre étapes. Comprend une crème solaire SPF 50+ PA++++, Bringgreen Tea Tree Cica Soothing Toner, un gel peeling éclat et Aromatica Rosemary 3-in-1 Treatment pour les cheveux. Formules douces et clean, adaptées aux peaux sensibles.	Lotion après le nettoyage, crème solaire chaque matin, gel peeling 1 à 2 fois par semaine sur peau propre et sèche, soin au romarin après le shampooing.	\N	968	fr	311
Korean Skincare Set: Glow & Gentle	Set routine	Una routine glow e delicatezza in quattro passaggi. Include una crema solare SPF 50+ PA++++, Bringgreen Tea Tree Cica Soothing Toner, un gel peeling illuminante e Aromatica Rosemary 3-in-1 Treatment per i capelli. Formule delicate e clean, adatte alle pelli sensibili.	Tonico dopo la detersione, crema solare ogni mattina, gel peeling 1–2 volte a settimana su pelle pulita e asciutta, trattamento al rosmarino dopo lo shampoo.	\N	969	it	311
Korean Skincare Set: Glow & Gentle	Routine set	A glow and gentle-care routine with four steps. Includes an SPF 50+ PA++++ sun cream, Bringgreen Tea Tree Cica Soothing Toner, a brightening peeling gel and Aromatica Rosemary 3-in-1 Treatment for hair. Gentle, clean formulas suitable for sensitive skin.	Toner after cleansing, sun cream every morning, peeling gel 1–2 times a week on clean, dry skin, rosemary treatment after shampooing.	\N	970	en	311
Anua Heartleaf 77% Soothing Toner	Gesichtswasser	Beruhigender Toner für gesunde, hydrierte Haut. Die milde Formel mit 77 % Herzblatt-Extrakt und Hyaluronsäure spendet intensiv Feuchtigkeit, beruhigt gereizte Haut und stärkt die Hautbarriere. Leichte Textur, zieht schnell ein. Besonders für empfindliche, trockene und gereizte Haut.	Nach der Reinigung mit den Händen oder einem Wattepad auftragen und sanft einklopfen.	77 % Herzblatt-Extrakt (Houttuynia Cordata) und Hyaluronsäure. Frei von Parabenen, Alkohol und Duftstoffen.	971	de	312
Anua Heartleaf 77% Soothing Toner	Lotion tonique	Une lotion tonique douce et apaisante à 77 % d’extrait de houttuynia et acide hyaluronique pour une peau saine et hydratée. Elle calme les peaux sensibles et les rougeurs, hydrate durablement et renforce la barrière cutanée, avec une texture légère. Pour peaux sensibles, sèches et irritées.	Après le nettoyage, appliquer avec les mains ou un coton et faire pénétrer en tapotant.	77 % d’extrait de houttuynia cordata et acide hyaluronique. Sans parabènes, alcool ni parfum.	972	fr	312
Anua Heartleaf 77% Soothing Toner	Tonico	Un tonico delicato e lenitivo con il 77 % di estratto di houttuynia e acido ialuronico per una pelle sana e idratata. Calma pelli sensibili e rossori, idrata a lungo e rafforza la barriera cutanea, con una texture leggera. Per pelli sensibili, secche e irritate.	Dopo la detersione applicare con le mani o un dischetto e picchiettare delicatamente.	77 % di estratto di houttuynia cordata e acido ialuronico. Senza parabeni, alcol e profumo.	973	it	312
Anua Heartleaf 77% Soothing Toner	Toner	A mild, soothing toner with 77 % heartleaf extract and hyaluronic acid for healthy, hydrated skin. It calms sensitive skin and redness, gives long-lasting moisture and strengthens the skin barrier, with a light texture that absorbs quickly. For sensitive, dry and irritated skin.	After cleansing, apply with your hands or a cotton pad and pat in gently.	77 % heartleaf (houttuynia cordata) extract and hyaluronic acid. Free from parabens, alcohol and fragrance.	974	en	312
\.


--
-- Data for Name: _products_v_rels; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public._products_v_rels (id, "order", parent_id, path, variant_types_id, categories_id, products_id) FROM stdin;
254	1	128	version.categories	\N	9	\N
255	1	129	version.categories	\N	9	\N
256	1	130	version.categories	\N	9	\N
257	1	131	version.categories	\N	9	\N
258	1	132	version.categories	\N	9	\N
259	1	133	version.categories	\N	9	\N
260	1	134	version.categories	\N	9	\N
261	1	135	version.categories	\N	9	\N
262	1	136	version.categories	\N	4	\N
263	1	137	version.categories	\N	4	\N
264	1	138	version.categories	\N	4	\N
265	1	139	version.categories	\N	4	\N
266	1	140	version.categories	\N	4	\N
267	1	141	version.categories	\N	4	\N
268	1	142	version.categories	\N	4	\N
269	1	143	version.categories	\N	4	\N
270	1	144	version.categories	\N	4	\N
271	1	145	version.categories	\N	4	\N
272	1	146	version.categories	\N	4	\N
273	1	147	version.categories	\N	4	\N
274	1	148	version.categories	\N	4	\N
275	1	149	version.categories	\N	4	\N
276	1	150	version.categories	\N	4	\N
277	1	151	version.categories	\N	4	\N
278	1	152	version.categories	\N	4	\N
279	1	153	version.categories	\N	4	\N
280	1	154	version.categories	\N	4	\N
281	1	155	version.categories	\N	4	\N
282	1	156	version.categories	\N	1	\N
283	1	157	version.categories	\N	1	\N
284	1	158	version.categories	\N	1	\N
285	1	159	version.categories	\N	1	\N
286	1	160	version.categories	\N	1	\N
287	1	161	version.categories	\N	1	\N
288	1	162	version.categories	\N	1	\N
289	1	163	version.categories	\N	1	\N
290	1	164	version.categories	\N	1	\N
291	1	165	version.categories	\N	1	\N
292	1	166	version.categories	\N	1	\N
293	1	167	version.categories	\N	1	\N
294	1	168	version.categories	\N	1	\N
295	1	169	version.categories	\N	1	\N
296	1	170	version.categories	\N	1	\N
297	1	171	version.categories	\N	1	\N
298	1	172	version.categories	\N	1	\N
299	1	173	version.categories	\N	1	\N
300	1	174	version.categories	\N	1	\N
301	1	175	version.categories	\N	1	\N
302	1	176	version.categories	\N	1	\N
303	1	177	version.categories	\N	1	\N
304	1	178	version.categories	\N	1	\N
305	1	179	version.categories	\N	1	\N
306	1	180	version.categories	\N	2	\N
307	1	181	version.categories	\N	2	\N
308	1	182	version.categories	\N	2	\N
309	1	183	version.categories	\N	2	\N
310	1	184	version.categories	\N	2	\N
311	1	185	version.categories	\N	2	\N
312	1	186	version.categories	\N	2	\N
313	1	187	version.categories	\N	2	\N
314	1	188	version.categories	\N	2	\N
315	1	189	version.categories	\N	2	\N
316	1	190	version.categories	\N	2	\N
317	1	191	version.categories	\N	2	\N
318	1	192	version.categories	\N	2	\N
319	1	193	version.categories	\N	2	\N
320	1	194	version.categories	\N	2	\N
321	1	195	version.categories	\N	2	\N
322	1	196	version.categories	\N	3	\N
323	1	197	version.categories	\N	3	\N
324	1	198	version.categories	\N	3	\N
325	1	199	version.categories	\N	3	\N
326	1	200	version.categories	\N	3	\N
327	1	201	version.categories	\N	3	\N
328	1	202	version.categories	\N	3	\N
329	1	203	version.categories	\N	3	\N
330	1	204	version.categories	\N	3	\N
331	1	205	version.categories	\N	3	\N
332	1	206	version.categories	\N	3	\N
333	1	207	version.categories	\N	3	\N
334	1	208	version.categories	\N	3	\N
335	1	209	version.categories	\N	3	\N
336	1	210	version.categories	\N	3	\N
337	1	211	version.categories	\N	3	\N
338	1	212	version.categories	\N	3	\N
339	1	213	version.categories	\N	3	\N
340	1	214	version.categories	\N	3	\N
341	1	215	version.categories	\N	3	\N
342	1	216	version.categories	\N	3	\N
343	1	217	version.categories	\N	3	\N
344	1	218	version.categories	\N	3	\N
345	1	219	version.categories	\N	3	\N
346	1	220	version.categories	\N	5	\N
347	1	221	version.categories	\N	5	\N
348	1	222	version.categories	\N	5	\N
349	1	223	version.categories	\N	5	\N
350	1	224	version.categories	\N	6	\N
351	1	225	version.categories	\N	6	\N
352	1	226	version.categories	\N	6	\N
353	1	227	version.categories	\N	6	\N
354	1	228	version.categories	\N	6	\N
355	1	229	version.categories	\N	6	\N
356	1	230	version.categories	\N	6	\N
357	1	231	version.categories	\N	6	\N
358	1	232	version.categories	\N	6	\N
359	1	233	version.categories	\N	6	\N
360	1	234	version.categories	\N	6	\N
361	1	235	version.categories	\N	6	\N
362	1	236	version.categories	\N	6	\N
363	1	237	version.categories	\N	6	\N
364	1	238	version.categories	\N	6	\N
365	1	239	version.categories	\N	6	\N
366	1	240	version.categories	\N	6	\N
367	1	241	version.categories	\N	6	\N
368	1	242	version.categories	\N	6	\N
369	1	243	version.categories	\N	6	\N
370	1	244	version.categories	\N	6	\N
371	1	245	version.categories	\N	6	\N
372	1	246	version.categories	\N	6	\N
373	1	247	version.categories	\N	6	\N
374	1	248	version.categories	\N	10	\N
375	1	249	version.categories	\N	10	\N
376	1	250	version.categories	\N	10	\N
377	1	251	version.categories	\N	10	\N
378	1	252	version.categories	\N	10	\N
379	1	253	version.categories	\N	10	\N
380	1	254	version.categories	\N	10	\N
381	1	255	version.categories	\N	10	\N
382	1	256	version.categories	\N	7	\N
383	1	257	version.categories	\N	7	\N
384	1	258	version.categories	\N	7	\N
385	1	259	version.categories	\N	7	\N
386	1	260	version.categories	\N	7	\N
387	1	261	version.categories	\N	7	\N
388	1	262	version.categories	\N	7	\N
389	1	263	version.categories	\N	7	\N
390	1	264	version.categories	\N	7	\N
391	1	265	version.categories	\N	7	\N
392	1	266	version.categories	\N	7	\N
393	1	267	version.categories	\N	7	\N
394	1	268	version.categories	\N	8	\N
395	1	268	version.relatedProducts	\N	\N	20
396	2	268	version.relatedProducts	\N	\N	21
397	3	268	version.relatedProducts	\N	\N	22
398	4	268	version.relatedProducts	\N	\N	23
399	1	269	version.categories	\N	8	\N
400	1	269	version.relatedProducts	\N	\N	19
401	2	269	version.relatedProducts	\N	\N	21
402	3	269	version.relatedProducts	\N	\N	22
403	4	269	version.relatedProducts	\N	\N	23
404	1	270	version.categories	\N	8	\N
405	1	270	version.relatedProducts	\N	\N	19
406	2	270	version.relatedProducts	\N	\N	20
407	3	270	version.relatedProducts	\N	\N	22
408	4	270	version.relatedProducts	\N	\N	23
409	1	271	version.categories	\N	8	\N
410	1	271	version.relatedProducts	\N	\N	19
411	2	271	version.relatedProducts	\N	\N	20
412	3	271	version.relatedProducts	\N	\N	21
413	4	271	version.relatedProducts	\N	\N	23
414	1	272	version.categories	\N	8	\N
415	1	272	version.relatedProducts	\N	\N	19
416	2	272	version.relatedProducts	\N	\N	20
417	3	272	version.relatedProducts	\N	\N	21
418	4	272	version.relatedProducts	\N	\N	22
419	1	273	version.categories	\N	8	\N
420	1	273	version.relatedProducts	\N	\N	19
421	2	273	version.relatedProducts	\N	\N	20
422	3	273	version.relatedProducts	\N	\N	21
423	4	273	version.relatedProducts	\N	\N	22
424	1	274	version.categories	\N	8	\N
425	1	274	version.relatedProducts	\N	\N	19
426	2	274	version.relatedProducts	\N	\N	20
427	3	274	version.relatedProducts	\N	\N	21
428	4	274	version.relatedProducts	\N	\N	22
429	1	275	version.categories	\N	8	\N
430	1	275	version.relatedProducts	\N	\N	19
431	2	275	version.relatedProducts	\N	\N	20
432	3	275	version.relatedProducts	\N	\N	21
433	4	275	version.relatedProducts	\N	\N	22
434	1	276	version.categories	\N	9	\N
435	1	276	version.relatedProducts	\N	\N	28
436	2	276	version.relatedProducts	\N	\N	29
437	3	276	version.relatedProducts	\N	\N	30
438	1	277	version.categories	\N	9	\N
439	1	277	version.relatedProducts	\N	\N	27
440	2	277	version.relatedProducts	\N	\N	29
441	3	277	version.relatedProducts	\N	\N	30
442	1	278	version.categories	\N	9	\N
443	1	278	version.relatedProducts	\N	\N	27
444	2	278	version.relatedProducts	\N	\N	28
445	3	278	version.relatedProducts	\N	\N	30
446	1	279	version.categories	\N	9	\N
447	1	279	version.relatedProducts	\N	\N	27
448	2	279	version.relatedProducts	\N	\N	28
449	3	279	version.relatedProducts	\N	\N	29
450	1	280	version.categories	\N	4	\N
451	1	280	version.relatedProducts	\N	\N	32
452	2	280	version.relatedProducts	\N	\N	33
214	1	88	version.categories	\N	8	\N
215	1	89	version.categories	\N	8	\N
216	1	90	version.categories	\N	8	\N
217	1	91	version.categories	\N	8	\N
218	1	92	version.categories	\N	8	\N
219	1	93	version.categories	\N	8	\N
220	1	94	version.categories	\N	8	\N
221	1	95	version.categories	\N	8	\N
222	1	96	version.categories	\N	8	\N
223	1	97	version.categories	\N	8	\N
224	1	98	version.categories	\N	8	\N
225	1	99	version.categories	\N	8	\N
226	1	100	version.categories	\N	8	\N
227	1	101	version.categories	\N	8	\N
228	1	102	version.categories	\N	8	\N
229	1	103	version.categories	\N	8	\N
230	1	104	version.categories	\N	8	\N
231	1	105	version.categories	\N	8	\N
232	1	106	version.categories	\N	8	\N
233	1	107	version.categories	\N	8	\N
234	1	108	version.categories	\N	8	\N
235	1	109	version.categories	\N	8	\N
236	1	110	version.categories	\N	8	\N
237	1	111	version.categories	\N	8	\N
238	1	112	version.categories	\N	8	\N
239	1	113	version.categories	\N	8	\N
240	1	114	version.categories	\N	8	\N
241	1	115	version.categories	\N	8	\N
242	1	116	version.categories	\N	8	\N
243	1	117	version.categories	\N	8	\N
244	1	118	version.categories	\N	8	\N
245	1	119	version.categories	\N	8	\N
246	1	120	version.categories	\N	9	\N
247	1	121	version.categories	\N	9	\N
248	1	122	version.categories	\N	9	\N
249	1	123	version.categories	\N	9	\N
250	1	124	version.categories	\N	9	\N
251	1	125	version.categories	\N	9	\N
252	1	126	version.categories	\N	9	\N
253	1	127	version.categories	\N	9	\N
453	3	280	version.relatedProducts	\N	\N	34
454	4	280	version.relatedProducts	\N	\N	35
455	1	281	version.categories	\N	4	\N
456	1	281	version.relatedProducts	\N	\N	31
457	2	281	version.relatedProducts	\N	\N	33
458	3	281	version.relatedProducts	\N	\N	34
459	4	281	version.relatedProducts	\N	\N	35
460	1	282	version.categories	\N	4	\N
461	1	282	version.relatedProducts	\N	\N	31
462	2	282	version.relatedProducts	\N	\N	32
463	3	282	version.relatedProducts	\N	\N	34
464	4	282	version.relatedProducts	\N	\N	35
465	1	283	version.categories	\N	4	\N
466	1	283	version.relatedProducts	\N	\N	31
467	2	283	version.relatedProducts	\N	\N	32
468	3	283	version.relatedProducts	\N	\N	33
469	4	283	version.relatedProducts	\N	\N	35
470	1	284	version.categories	\N	4	\N
471	1	284	version.relatedProducts	\N	\N	31
472	2	284	version.relatedProducts	\N	\N	32
473	3	284	version.relatedProducts	\N	\N	33
474	4	284	version.relatedProducts	\N	\N	34
475	1	285	version.categories	\N	1	\N
476	1	285	version.relatedProducts	\N	\N	37
477	2	285	version.relatedProducts	\N	\N	38
478	3	285	version.relatedProducts	\N	\N	39
479	4	285	version.relatedProducts	\N	\N	40
480	1	286	version.categories	\N	1	\N
481	1	286	version.relatedProducts	\N	\N	36
482	2	286	version.relatedProducts	\N	\N	38
483	3	286	version.relatedProducts	\N	\N	39
484	4	286	version.relatedProducts	\N	\N	40
485	1	287	version.categories	\N	1	\N
486	1	287	version.relatedProducts	\N	\N	36
487	2	287	version.relatedProducts	\N	\N	37
488	3	287	version.relatedProducts	\N	\N	39
489	4	287	version.relatedProducts	\N	\N	40
490	1	288	version.categories	\N	1	\N
491	1	288	version.relatedProducts	\N	\N	36
492	2	288	version.relatedProducts	\N	\N	37
493	3	288	version.relatedProducts	\N	\N	38
494	4	288	version.relatedProducts	\N	\N	40
495	1	289	version.categories	\N	1	\N
496	1	289	version.relatedProducts	\N	\N	36
497	2	289	version.relatedProducts	\N	\N	37
498	3	289	version.relatedProducts	\N	\N	38
499	4	289	version.relatedProducts	\N	\N	39
500	1	290	version.categories	\N	1	\N
501	1	290	version.relatedProducts	\N	\N	36
502	2	290	version.relatedProducts	\N	\N	37
503	3	290	version.relatedProducts	\N	\N	38
504	4	290	version.relatedProducts	\N	\N	39
505	1	291	version.categories	\N	2	\N
506	1	291	version.relatedProducts	\N	\N	43
507	2	291	version.relatedProducts	\N	\N	44
508	3	291	version.relatedProducts	\N	\N	45
509	1	292	version.categories	\N	2	\N
510	1	292	version.relatedProducts	\N	\N	42
511	2	292	version.relatedProducts	\N	\N	44
512	3	292	version.relatedProducts	\N	\N	45
513	1	293	version.categories	\N	2	\N
514	1	293	version.relatedProducts	\N	\N	42
515	2	293	version.relatedProducts	\N	\N	43
516	3	293	version.relatedProducts	\N	\N	45
517	1	294	version.categories	\N	2	\N
518	1	294	version.relatedProducts	\N	\N	42
519	2	294	version.relatedProducts	\N	\N	43
520	3	294	version.relatedProducts	\N	\N	44
521	1	295	version.categories	\N	3	\N
522	1	295	version.relatedProducts	\N	\N	47
523	2	295	version.relatedProducts	\N	\N	48
524	3	295	version.relatedProducts	\N	\N	49
525	4	295	version.relatedProducts	\N	\N	50
526	1	296	version.categories	\N	3	\N
527	1	296	version.relatedProducts	\N	\N	46
528	2	296	version.relatedProducts	\N	\N	48
529	3	296	version.relatedProducts	\N	\N	49
530	4	296	version.relatedProducts	\N	\N	50
531	1	297	version.categories	\N	3	\N
532	1	297	version.relatedProducts	\N	\N	46
533	2	297	version.relatedProducts	\N	\N	47
534	3	297	version.relatedProducts	\N	\N	49
535	4	297	version.relatedProducts	\N	\N	50
536	1	298	version.categories	\N	3	\N
537	1	298	version.relatedProducts	\N	\N	46
538	2	298	version.relatedProducts	\N	\N	47
539	3	298	version.relatedProducts	\N	\N	48
540	4	298	version.relatedProducts	\N	\N	50
541	1	299	version.categories	\N	3	\N
542	1	299	version.relatedProducts	\N	\N	46
543	2	299	version.relatedProducts	\N	\N	47
544	3	299	version.relatedProducts	\N	\N	48
545	4	299	version.relatedProducts	\N	\N	49
546	1	300	version.categories	\N	3	\N
547	1	300	version.relatedProducts	\N	\N	46
548	2	300	version.relatedProducts	\N	\N	47
549	3	300	version.relatedProducts	\N	\N	48
550	4	300	version.relatedProducts	\N	\N	49
551	1	301	version.categories	\N	6	\N
552	1	301	version.relatedProducts	\N	\N	54
553	2	301	version.relatedProducts	\N	\N	55
554	3	301	version.relatedProducts	\N	\N	56
555	4	301	version.relatedProducts	\N	\N	57
556	1	302	version.categories	\N	6	\N
557	1	302	version.relatedProducts	\N	\N	53
558	2	302	version.relatedProducts	\N	\N	55
559	3	302	version.relatedProducts	\N	\N	56
560	4	302	version.relatedProducts	\N	\N	57
561	1	303	version.categories	\N	6	\N
562	1	303	version.relatedProducts	\N	\N	53
563	2	303	version.relatedProducts	\N	\N	54
564	3	303	version.relatedProducts	\N	\N	56
565	4	303	version.relatedProducts	\N	\N	57
566	1	304	version.categories	\N	6	\N
567	1	304	version.relatedProducts	\N	\N	53
568	2	304	version.relatedProducts	\N	\N	54
569	3	304	version.relatedProducts	\N	\N	55
570	4	304	version.relatedProducts	\N	\N	57
571	1	305	version.categories	\N	6	\N
572	1	305	version.relatedProducts	\N	\N	53
573	2	305	version.relatedProducts	\N	\N	54
574	3	305	version.relatedProducts	\N	\N	55
575	4	305	version.relatedProducts	\N	\N	56
576	1	306	version.categories	\N	6	\N
577	1	306	version.relatedProducts	\N	\N	53
578	2	306	version.relatedProducts	\N	\N	54
579	3	306	version.relatedProducts	\N	\N	55
580	4	306	version.relatedProducts	\N	\N	56
581	1	307	version.categories	\N	10	\N
582	1	307	version.relatedProducts	\N	\N	60
583	1	308	version.categories	\N	10	\N
584	1	308	version.relatedProducts	\N	\N	59
585	1	309	version.categories	\N	7	\N
586	1	309	version.relatedProducts	\N	\N	62
587	2	309	version.relatedProducts	\N	\N	63
588	1	310	version.categories	\N	7	\N
589	1	310	version.relatedProducts	\N	\N	61
590	2	310	version.relatedProducts	\N	\N	63
591	1	311	version.categories	\N	7	\N
592	1	311	version.relatedProducts	\N	\N	61
593	2	311	version.relatedProducts	\N	\N	62
594	1	312	version.categories	\N	2	\N
595	1	312	version.relatedProducts	\N	\N	42
596	2	312	version.relatedProducts	\N	\N	44
597	3	312	version.relatedProducts	\N	\N	45
\.


--
-- Data for Name: _products_v_version_gallery; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public._products_v_version_gallery (_order, _parent_id, id, image_id, _uuid) FROM stdin;
1	128	242	50	6af695728449c441dccffb7e
2	128	243	51	6af695728449c441dccffb7f
3	128	244	52	6af695728449c441dccffb80
1	129	245	50	6af695728449c441dccffb7e
2	129	246	51	6af695728449c441dccffb7f
3	129	247	52	6af695728449c441dccffb80
1	130	248	50	6af695728449c441dccffb7e
2	130	249	51	6af695728449c441dccffb7f
3	130	250	52	6af695728449c441dccffb80
1	131	251	50	6af695728449c441dccffb7e
2	131	252	51	6af695728449c441dccffb7f
3	131	253	52	6af695728449c441dccffb80
1	132	254	53	6af695748449c441dccffb81
2	132	255	54	6af695748449c441dccffb82
1	133	256	53	6af695748449c441dccffb81
2	133	257	54	6af695748449c441dccffb82
1	134	258	53	6af695748449c441dccffb81
2	134	259	54	6af695748449c441dccffb82
1	135	260	53	6af695748449c441dccffb81
2	135	261	54	6af695748449c441dccffb82
1	136	262	55	6af695758449c441dccffb83
2	136	263	56	6af695758449c441dccffb84
1	137	264	55	6af695758449c441dccffb83
2	137	265	56	6af695758449c441dccffb84
1	138	266	55	6af695758449c441dccffb83
2	138	267	56	6af695758449c441dccffb84
1	139	268	55	6af695758449c441dccffb83
2	139	269	56	6af695758449c441dccffb84
1	140	270	57	6af695778449c441dccffb85
2	140	271	58	6af695778449c441dccffb86
3	140	272	59	6af695778449c441dccffb87
4	140	273	60	6af695778449c441dccffb88
1	141	274	57	6af695778449c441dccffb85
2	141	275	58	6af695778449c441dccffb86
3	141	276	59	6af695778449c441dccffb87
4	141	277	60	6af695778449c441dccffb88
1	142	278	57	6af695778449c441dccffb85
2	142	279	58	6af695778449c441dccffb86
3	142	280	59	6af695778449c441dccffb87
4	142	281	60	6af695778449c441dccffb88
1	143	282	57	6af695778449c441dccffb85
2	143	283	58	6af695778449c441dccffb86
3	143	284	59	6af695778449c441dccffb87
4	143	285	60	6af695778449c441dccffb88
1	144	286	61	6af695798449c441dccffb89
2	144	287	62	6af695798449c441dccffb8a
1	145	288	61	6af695798449c441dccffb89
2	145	289	62	6af695798449c441dccffb8a
1	146	290	61	6af695798449c441dccffb89
2	146	291	62	6af695798449c441dccffb8a
1	147	292	61	6af695798449c441dccffb89
2	147	293	62	6af695798449c441dccffb8a
1	148	294	63	6af6957a8449c441dccffb8b
2	148	295	64	6af6957a8449c441dccffb8c
1	149	296	63	6af6957a8449c441dccffb8b
2	149	297	64	6af6957a8449c441dccffb8c
1	150	298	63	6af6957a8449c441dccffb8b
2	150	299	64	6af6957a8449c441dccffb8c
1	151	300	63	6af6957a8449c441dccffb8b
2	151	301	64	6af6957a8449c441dccffb8c
1	152	302	65	6af6957b8449c441dccffb8d
2	152	303	66	6af6957b8449c441dccffb8e
1	153	304	65	6af6957b8449c441dccffb8d
2	153	305	66	6af6957b8449c441dccffb8e
1	154	306	65	6af6957b8449c441dccffb8d
2	154	307	66	6af6957b8449c441dccffb8e
1	155	308	65	6af6957b8449c441dccffb8d
2	155	309	66	6af6957b8449c441dccffb8e
1	156	310	67	6af6957c8449c441dccffb8f
2	156	311	68	6af6957c8449c441dccffb90
1	157	312	67	6af6957c8449c441dccffb8f
2	157	313	68	6af6957c8449c441dccffb90
1	158	314	67	6af6957c8449c441dccffb8f
2	158	315	68	6af6957c8449c441dccffb90
1	159	316	67	6af6957c8449c441dccffb8f
2	159	317	68	6af6957c8449c441dccffb90
1	160	318	69	6af6957e8449c441dccffb91
2	160	319	70	6af6957e8449c441dccffb92
1	161	320	69	6af6957e8449c441dccffb91
2	161	321	70	6af6957e8449c441dccffb92
1	162	322	69	6af6957e8449c441dccffb91
2	162	323	70	6af6957e8449c441dccffb92
1	163	324	69	6af6957e8449c441dccffb91
2	163	325	70	6af6957e8449c441dccffb92
1	164	326	71	6af6957f8449c441dccffb93
2	164	327	72	6af6957f8449c441dccffb94
1	165	328	71	6af6957f8449c441dccffb93
2	165	329	72	6af6957f8449c441dccffb94
1	166	330	71	6af6957f8449c441dccffb93
2	166	331	72	6af6957f8449c441dccffb94
1	167	332	71	6af6957f8449c441dccffb93
2	167	333	72	6af6957f8449c441dccffb94
1	168	334	73	6af695818449c441dccffb95
2	168	335	74	6af695818449c441dccffb96
1	169	336	73	6af695818449c441dccffb95
2	169	337	74	6af695818449c441dccffb96
1	170	338	73	6af695818449c441dccffb95
2	170	339	74	6af695818449c441dccffb96
1	171	340	73	6af695818449c441dccffb95
2	171	341	74	6af695818449c441dccffb96
1	172	342	75	6af695828449c441dccffb97
2	172	343	76	6af695828449c441dccffb98
1	173	344	75	6af695828449c441dccffb97
2	173	345	76	6af695828449c441dccffb98
1	174	346	75	6af695828449c441dccffb97
2	174	347	76	6af695828449c441dccffb98
1	175	348	75	6af695828449c441dccffb97
2	175	349	76	6af695828449c441dccffb98
1	176	350	77	6af695848449c441dccffb99
2	176	351	78	6af695848449c441dccffb9a
1	177	352	77	6af695848449c441dccffb99
2	177	353	78	6af695848449c441dccffb9a
1	178	354	77	6af695848449c441dccffb99
2	178	355	78	6af695848449c441dccffb9a
1	179	356	77	6af695848449c441dccffb99
2	179	357	78	6af695848449c441dccffb9a
1	180	358	79	6af695858449c441dccffb9b
2	180	359	80	6af695858449c441dccffb9c
1	181	360	79	6af695858449c441dccffb9b
2	181	361	80	6af695858449c441dccffb9c
1	182	362	79	6af695858449c441dccffb9b
2	182	363	80	6af695858449c441dccffb9c
1	183	364	79	6af695858449c441dccffb9b
2	183	365	80	6af695858449c441dccffb9c
1	184	366	81	6af695868449c441dccffb9d
2	184	367	82	6af695868449c441dccffb9e
1	185	368	81	6af695868449c441dccffb9d
2	185	369	82	6af695868449c441dccffb9e
1	88	158	29	6af695648449c441dccffb69
2	88	159	30	6af695648449c441dccffb6a
1	89	160	29	6af695648449c441dccffb69
2	89	161	30	6af695648449c441dccffb6a
1	90	162	29	6af695648449c441dccffb69
2	90	163	30	6af695648449c441dccffb6a
1	91	164	29	6af695648449c441dccffb69
2	91	165	30	6af695648449c441dccffb6a
1	92	166	31	6af695668449c441dccffb6b
2	92	167	32	6af695668449c441dccffb6c
1	93	168	31	6af695668449c441dccffb6b
2	93	169	32	6af695668449c441dccffb6c
1	94	170	31	6af695668449c441dccffb6b
2	94	171	32	6af695668449c441dccffb6c
1	95	172	31	6af695668449c441dccffb6b
2	95	173	32	6af695668449c441dccffb6c
1	96	174	33	6af695678449c441dccffb6d
2	96	175	34	6af695678449c441dccffb6e
1	97	176	33	6af695678449c441dccffb6d
2	97	177	34	6af695678449c441dccffb6e
1	98	178	33	6af695678449c441dccffb6d
2	98	179	34	6af695678449c441dccffb6e
1	99	180	33	6af695678449c441dccffb6d
2	99	181	34	6af695678449c441dccffb6e
1	100	182	35	6af695688449c441dccffb6f
2	100	183	36	6af695688449c441dccffb70
1	101	184	35	6af695688449c441dccffb6f
2	101	185	36	6af695688449c441dccffb70
1	102	186	35	6af695688449c441dccffb6f
2	102	187	36	6af695688449c441dccffb70
1	103	188	35	6af695688449c441dccffb6f
2	103	189	36	6af695688449c441dccffb70
1	104	190	37	6af695698449c441dccffb71
2	104	191	38	6af695698449c441dccffb72
1	105	192	37	6af695698449c441dccffb71
2	105	193	38	6af695698449c441dccffb72
1	106	194	37	6af695698449c441dccffb71
2	106	195	38	6af695698449c441dccffb72
1	107	196	37	6af695698449c441dccffb71
2	107	197	38	6af695698449c441dccffb72
1	108	198	39	6af6956a8449c441dccffb73
2	108	199	40	6af6956a8449c441dccffb74
1	109	200	39	6af6956a8449c441dccffb73
2	109	201	40	6af6956a8449c441dccffb74
1	110	202	39	6af6956a8449c441dccffb73
2	110	203	40	6af6956a8449c441dccffb74
1	111	204	39	6af6956a8449c441dccffb73
2	111	205	40	6af6956a8449c441dccffb74
1	112	206	41	6af6956b8449c441dccffb75
2	112	207	42	6af6956b8449c441dccffb76
1	113	208	41	6af6956b8449c441dccffb75
2	113	209	42	6af6956b8449c441dccffb76
1	114	210	41	6af6956b8449c441dccffb75
2	114	211	42	6af6956b8449c441dccffb76
1	115	212	41	6af6956b8449c441dccffb75
2	115	213	42	6af6956b8449c441dccffb76
1	116	214	43	6af6956c8449c441dccffb77
2	116	215	44	6af6956c8449c441dccffb78
1	117	216	43	6af6956c8449c441dccffb77
2	117	217	44	6af6956c8449c441dccffb78
1	118	218	43	6af6956c8449c441dccffb77
2	118	219	44	6af6956c8449c441dccffb78
1	119	220	43	6af6956c8449c441dccffb77
2	119	221	44	6af6956c8449c441dccffb78
1	120	222	45	6af6956e8449c441dccffb79
2	120	223	46	6af6956e8449c441dccffb7a
1	121	224	45	6af6956e8449c441dccffb79
2	121	225	46	6af6956e8449c441dccffb7a
1	122	226	45	6af6956e8449c441dccffb79
2	122	227	46	6af6956e8449c441dccffb7a
1	123	228	45	6af6956e8449c441dccffb79
2	123	229	46	6af6956e8449c441dccffb7a
1	124	230	47	6af695708449c441dccffb7b
2	124	231	48	6af695708449c441dccffb7c
3	124	232	49	6af695708449c441dccffb7d
1	125	233	47	6af695708449c441dccffb7b
2	125	234	48	6af695708449c441dccffb7c
3	125	235	49	6af695708449c441dccffb7d
1	126	236	47	6af695708449c441dccffb7b
2	126	237	48	6af695708449c441dccffb7c
3	126	238	49	6af695708449c441dccffb7d
1	127	239	47	6af695708449c441dccffb7b
2	127	240	48	6af695708449c441dccffb7c
3	127	241	49	6af695708449c441dccffb7d
1	186	370	81	6af695868449c441dccffb9d
2	186	371	82	6af695868449c441dccffb9e
1	187	372	81	6af695868449c441dccffb9d
2	187	373	82	6af695868449c441dccffb9e
1	188	374	83	6af695888449c441dccffb9f
2	188	375	84	6af695888449c441dccffba0
1	189	376	83	6af695888449c441dccffb9f
2	189	377	84	6af695888449c441dccffba0
1	190	378	83	6af695888449c441dccffb9f
2	190	379	84	6af695888449c441dccffba0
1	191	380	83	6af695888449c441dccffb9f
2	191	381	84	6af695888449c441dccffba0
1	192	382	85	6af695898449c441dccffba1
2	192	383	86	6af695898449c441dccffba2
1	193	384	85	6af695898449c441dccffba1
2	193	385	86	6af695898449c441dccffba2
1	194	386	85	6af695898449c441dccffba1
2	194	387	86	6af695898449c441dccffba2
1	195	388	85	6af695898449c441dccffba1
2	195	389	86	6af695898449c441dccffba2
1	196	390	87	6af6958a8449c441dccffba3
2	196	391	88	6af6958a8449c441dccffba4
1	197	392	87	6af6958a8449c441dccffba3
2	197	393	88	6af6958a8449c441dccffba4
1	198	394	87	6af6958a8449c441dccffba3
2	198	395	88	6af6958a8449c441dccffba4
1	199	396	87	6af6958a8449c441dccffba3
2	199	397	88	6af6958a8449c441dccffba4
1	200	398	89	6af6958c8449c441dccffba5
2	200	399	90	6af6958c8449c441dccffba6
1	201	400	89	6af6958c8449c441dccffba5
2	201	401	90	6af6958c8449c441dccffba6
1	202	402	89	6af6958c8449c441dccffba5
2	202	403	90	6af6958c8449c441dccffba6
1	203	404	89	6af6958c8449c441dccffba5
2	203	405	90	6af6958c8449c441dccffba6
1	204	406	91	6af6958d8449c441dccffba7
2	204	407	92	6af6958d8449c441dccffba8
1	205	408	91	6af6958d8449c441dccffba7
2	205	409	92	6af6958d8449c441dccffba8
1	206	410	91	6af6958d8449c441dccffba7
2	206	411	92	6af6958d8449c441dccffba8
1	207	412	91	6af6958d8449c441dccffba7
2	207	413	92	6af6958d8449c441dccffba8
1	208	414	93	6af6958e8449c441dccffba9
2	208	415	94	6af6958e8449c441dccffbaa
1	209	416	93	6af6958e8449c441dccffba9
2	209	417	94	6af6958e8449c441dccffbaa
1	210	418	93	6af6958e8449c441dccffba9
2	210	419	94	6af6958e8449c441dccffbaa
1	211	420	93	6af6958e8449c441dccffba9
2	211	421	94	6af6958e8449c441dccffbaa
1	212	422	95	6af695908449c441dccffbab
2	212	423	96	6af695908449c441dccffbac
1	213	424	95	6af695908449c441dccffbab
2	213	425	96	6af695908449c441dccffbac
1	214	426	95	6af695908449c441dccffbab
2	214	427	96	6af695908449c441dccffbac
1	215	428	95	6af695908449c441dccffbab
2	215	429	96	6af695908449c441dccffbac
1	216	430	97	6af695918449c441dccffbad
2	216	431	98	6af695918449c441dccffbae
1	217	432	97	6af695918449c441dccffbad
2	217	433	98	6af695918449c441dccffbae
1	218	434	97	6af695918449c441dccffbad
2	218	435	98	6af695918449c441dccffbae
1	219	436	97	6af695918449c441dccffbad
2	219	437	98	6af695918449c441dccffbae
1	220	438	99	6af695928449c441dccffbaf
2	220	439	100	6af695928449c441dccffbb0
1	221	440	99	6af695928449c441dccffbaf
2	221	441	100	6af695928449c441dccffbb0
1	222	442	99	6af695928449c441dccffbaf
2	222	443	100	6af695928449c441dccffbb0
1	223	444	99	6af695928449c441dccffbaf
2	223	445	100	6af695928449c441dccffbb0
1	224	446	101	6af695938449c441dccffbb1
2	224	447	102	6af695938449c441dccffbb2
1	225	448	101	6af695938449c441dccffbb1
2	225	449	102	6af695938449c441dccffbb2
1	226	450	101	6af695938449c441dccffbb1
2	226	451	102	6af695938449c441dccffbb2
1	227	452	101	6af695938449c441dccffbb1
2	227	453	102	6af695938449c441dccffbb2
1	228	454	103	6af695958449c441dccffbb3
2	228	455	104	6af695958449c441dccffbb4
1	229	456	103	6af695958449c441dccffbb3
2	229	457	104	6af695958449c441dccffbb4
1	230	458	103	6af695958449c441dccffbb3
2	230	459	104	6af695958449c441dccffbb4
1	231	460	103	6af695958449c441dccffbb3
2	231	461	104	6af695958449c441dccffbb4
1	232	462	105	6af695968449c441dccffbb5
2	232	463	106	6af695968449c441dccffbb6
1	233	464	105	6af695968449c441dccffbb5
2	233	465	106	6af695968449c441dccffbb6
1	234	466	105	6af695968449c441dccffbb5
2	234	467	106	6af695968449c441dccffbb6
1	235	468	105	6af695968449c441dccffbb5
2	235	469	106	6af695968449c441dccffbb6
1	236	470	107	6af695978449c441dccffbb7
2	236	471	108	6af695978449c441dccffbb8
1	237	472	107	6af695978449c441dccffbb7
2	237	473	108	6af695978449c441dccffbb8
1	238	474	107	6af695978449c441dccffbb7
2	238	475	108	6af695978449c441dccffbb8
1	239	476	107	6af695978449c441dccffbb7
2	239	477	108	6af695978449c441dccffbb8
1	240	478	109	6af695988449c441dccffbb9
2	240	479	110	6af695988449c441dccffbba
1	241	480	109	6af695988449c441dccffbb9
2	241	481	110	6af695988449c441dccffbba
1	242	482	109	6af695988449c441dccffbb9
2	242	483	110	6af695988449c441dccffbba
1	243	484	109	6af695988449c441dccffbb9
2	243	485	110	6af695988449c441dccffbba
1	244	486	111	6af695998449c441dccffbbb
2	244	487	112	6af695998449c441dccffbbc
1	245	488	111	6af695998449c441dccffbbb
2	245	489	112	6af695998449c441dccffbbc
1	246	490	111	6af695998449c441dccffbbb
2	246	491	112	6af695998449c441dccffbbc
1	247	492	111	6af695998449c441dccffbbb
2	247	493	112	6af695998449c441dccffbbc
1	248	494	113	6af6959a8449c441dccffbbd
2	248	495	114	6af6959a8449c441dccffbbe
1	249	496	113	6af6959a8449c441dccffbbd
2	249	497	114	6af6959a8449c441dccffbbe
1	250	498	113	6af6959a8449c441dccffbbd
2	250	499	114	6af6959a8449c441dccffbbe
1	251	500	113	6af6959a8449c441dccffbbd
2	251	501	114	6af6959a8449c441dccffbbe
1	252	502	115	6af6959c8449c441dccffbbf
2	252	503	116	6af6959c8449c441dccffbc0
1	253	504	115	6af6959c8449c441dccffbbf
2	253	505	116	6af6959c8449c441dccffbc0
1	254	506	115	6af6959c8449c441dccffbbf
2	254	507	116	6af6959c8449c441dccffbc0
1	255	508	115	6af6959c8449c441dccffbbf
2	255	509	116	6af6959c8449c441dccffbc0
1	256	510	117	6af6959d8449c441dccffbc1
2	256	511	118	6af6959d8449c441dccffbc2
1	257	512	117	6af6959d8449c441dccffbc1
2	257	513	118	6af6959d8449c441dccffbc2
1	258	514	117	6af6959d8449c441dccffbc1
2	258	515	118	6af6959d8449c441dccffbc2
1	259	516	117	6af6959d8449c441dccffbc1
2	259	517	118	6af6959d8449c441dccffbc2
1	260	518	119	6af6959e8449c441dccffbc3
2	260	519	120	6af6959e8449c441dccffbc4
1	261	520	119	6af6959e8449c441dccffbc3
2	261	521	120	6af6959e8449c441dccffbc4
1	262	522	119	6af6959e8449c441dccffbc3
2	262	523	120	6af6959e8449c441dccffbc4
1	263	524	119	6af6959e8449c441dccffbc3
2	263	525	120	6af6959e8449c441dccffbc4
1	264	526	121	6af6959f8449c441dccffbc5
2	264	527	122	6af6959f8449c441dccffbc6
1	265	528	121	6af6959f8449c441dccffbc5
2	265	529	122	6af6959f8449c441dccffbc6
1	266	530	121	6af6959f8449c441dccffbc5
2	266	531	122	6af6959f8449c441dccffbc6
1	267	532	121	6af6959f8449c441dccffbc5
2	267	533	122	6af6959f8449c441dccffbc6
1	268	534	29	6af695648449c441dccffb69
2	268	535	30	6af695648449c441dccffb6a
1	269	536	31	6af695668449c441dccffb6b
2	269	537	32	6af695668449c441dccffb6c
1	270	538	33	6af695678449c441dccffb6d
2	270	539	34	6af695678449c441dccffb6e
1	271	540	35	6af695688449c441dccffb6f
2	271	541	36	6af695688449c441dccffb70
1	272	542	37	6af695698449c441dccffb71
2	272	543	38	6af695698449c441dccffb72
1	273	544	39	6af6956a8449c441dccffb73
2	273	545	40	6af6956a8449c441dccffb74
1	274	546	41	6af6956b8449c441dccffb75
2	274	547	42	6af6956b8449c441dccffb76
1	275	548	43	6af6956c8449c441dccffb77
2	275	549	44	6af6956c8449c441dccffb78
1	276	550	45	6af6956e8449c441dccffb79
2	276	551	46	6af6956e8449c441dccffb7a
1	277	552	47	6af695708449c441dccffb7b
2	277	553	48	6af695708449c441dccffb7c
3	277	554	49	6af695708449c441dccffb7d
1	278	555	50	6af695728449c441dccffb7e
2	278	556	51	6af695728449c441dccffb7f
3	278	557	52	6af695728449c441dccffb80
1	279	558	53	6af695748449c441dccffb81
2	279	559	54	6af695748449c441dccffb82
1	280	560	55	6af695758449c441dccffb83
2	280	561	56	6af695758449c441dccffb84
1	281	562	57	6af695778449c441dccffb85
2	281	563	58	6af695778449c441dccffb86
3	281	564	59	6af695778449c441dccffb87
4	281	565	60	6af695778449c441dccffb88
1	282	566	61	6af695798449c441dccffb89
2	282	567	62	6af695798449c441dccffb8a
1	283	568	63	6af6957a8449c441dccffb8b
2	283	569	64	6af6957a8449c441dccffb8c
1	284	570	65	6af6957b8449c441dccffb8d
2	284	571	66	6af6957b8449c441dccffb8e
1	285	572	67	6af6957c8449c441dccffb8f
2	285	573	68	6af6957c8449c441dccffb90
1	286	574	69	6af6957e8449c441dccffb91
2	286	575	70	6af6957e8449c441dccffb92
1	287	576	71	6af6957f8449c441dccffb93
2	287	577	72	6af6957f8449c441dccffb94
1	288	578	73	6af695818449c441dccffb95
2	288	579	74	6af695818449c441dccffb96
1	289	580	75	6af695828449c441dccffb97
2	289	581	76	6af695828449c441dccffb98
1	290	582	77	6af695848449c441dccffb99
2	290	583	78	6af695848449c441dccffb9a
1	291	584	79	6af695858449c441dccffb9b
2	291	585	80	6af695858449c441dccffb9c
1	292	586	81	6af695868449c441dccffb9d
2	292	587	82	6af695868449c441dccffb9e
1	293	588	83	6af695888449c441dccffb9f
2	293	589	84	6af695888449c441dccffba0
1	294	590	85	6af695898449c441dccffba1
2	294	591	86	6af695898449c441dccffba2
1	295	592	87	6af6958a8449c441dccffba3
2	295	593	88	6af6958a8449c441dccffba4
1	296	594	89	6af6958c8449c441dccffba5
2	296	595	90	6af6958c8449c441dccffba6
1	297	596	91	6af6958d8449c441dccffba7
2	297	597	92	6af6958d8449c441dccffba8
1	298	598	93	6af6958e8449c441dccffba9
2	298	599	94	6af6958e8449c441dccffbaa
1	299	600	95	6af695908449c441dccffbab
2	299	601	96	6af695908449c441dccffbac
1	300	602	97	6af695918449c441dccffbad
2	300	603	98	6af695918449c441dccffbae
1	301	604	101	6af695938449c441dccffbb1
2	301	605	102	6af695938449c441dccffbb2
1	302	606	103	6af695958449c441dccffbb3
2	302	607	104	6af695958449c441dccffbb4
1	303	608	105	6af695968449c441dccffbb5
2	303	609	106	6af695968449c441dccffbb6
1	304	610	107	6af695978449c441dccffbb7
2	304	611	108	6af695978449c441dccffbb8
1	305	612	109	6af695988449c441dccffbb9
2	305	613	110	6af695988449c441dccffbba
1	306	614	111	6af695998449c441dccffbbb
2	306	615	112	6af695998449c441dccffbbc
1	307	616	113	6af6959a8449c441dccffbbd
2	307	617	114	6af6959a8449c441dccffbbe
1	308	618	115	6af6959c8449c441dccffbbf
2	308	619	116	6af6959c8449c441dccffbc0
1	309	620	117	6af6959d8449c441dccffbc1
2	309	621	118	6af6959d8449c441dccffbc2
1	310	622	119	6af6959e8449c441dccffbc3
2	310	623	120	6af6959e8449c441dccffbc4
1	311	624	121	6af6959f8449c441dccffbc5
2	311	625	122	6af6959f8449c441dccffbc6
1	312	626	81	6af695868449c441dccffb9d
2	312	627	82	6af695868449c441dccffb9e
\.


--
-- Data for Name: _variants_v; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public._variants_v (id, parent_id, version_title, version_product_id, version_inventory, version_price_in_c_h_f_enabled, version_price_in_c_h_f, version_updated_at, version_created_at, version_deleted_at, version__status, created_at, updated_at, latest, autosave, snapshot, published_locale) FROM stdin;
\.


--
-- Data for Name: _variants_v_rels; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public._variants_v_rels (id, "order", parent_id, path, variant_options_id) FROM stdin;
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.categories (id, generate_slug, slug, updated_at, created_at) FROM stdin;
8	f	hair	2026-11-13 10:13:15.686+05:30	2026-11-13 10:13:15.654+05:30
9	f	body	2026-11-13 10:13:15.719+05:30	2026-11-13 10:13:15.693+05:30
10	f	lips	2026-11-13 10:13:15.752+05:30	2026-11-13 10:13:15.724+05:30
7	f	sets	2026-11-13 10:13:15.782+05:30	2026-11-05 15:45:55.229+05:30
6	f	treatments	2026-11-13 10:13:15.799+05:30	2026-11-05 15:45:55.215+05:30
5	f	suncare	2026-11-13 10:13:15.824+05:30	2026-11-05 15:45:55.2+05:30
4	f	moisturisers	2026-11-13 10:13:15.847+05:30	2026-11-05 15:45:55.185+05:30
3	f	serums	2026-11-13 10:13:15.877+05:30	2026-11-05 15:45:55.162+05:30
2	f	toners	2026-11-13 10:13:15.903+05:30	2026-11-05 15:45:55.139+05:30
1	f	cleansers	2026-11-13 10:13:15.923+05:30	2026-11-05 15:45:55.096+05:30
\.


--
-- Data for Name: categories_locales; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.categories_locales (title, id, _locale, _parent_id) FROM stdin;
Haare & Kopfhaut	77	de	8
Cheveux & cuir chevelu	78	fr	8
Capelli & cuoio capelluto	79	it	8
Hair & scalp	80	en	8
Körperpflege	87	de	9
Soins du corps	88	fr	9
Cura del corpo	89	it	9
Body care	90	en	9
Lippenpflege	97	de	10
Soins des lèvres	98	fr	10
Cura delle labbra	99	it	10
Lip care	100	en	10
Routine-Sets	109	de	7
Coffrets routine	110	fr	7
Set routine	111	it	7
Routine sets	112	en	7
Masken & Spezialpflege	121	de	6
Masques & soins ciblés	122	fr	6
Maschere & trattamenti	123	it	6
Masks & treatments	124	en	6
Sonnenschutz	133	de	5
Protection solaire	134	fr	5
Protezione solare	135	it	5
Sun care	136	en	5
Feuchtigkeitspflege	145	de	4
Hydratants	146	fr	4
Idratanti	147	it	4
Moisturisers	148	en	4
Seren & Ampullen	157	de	3
Sérums & ampoules	158	fr	3
Sieri & fiale	159	it	3
Serums & ampoules	160	en	3
Gesichtswasser & Essenzen	169	de	2
Lotions & essences	170	fr	2
Tonici & essenze	171	it	2
Toners & essences	172	en	2
Reinigung	181	de	1
Nettoyants	182	fr	1
Detergenti	183	it	1
Cleansers	184	en	1
\.


--
-- Data for Name: home; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.home (id, updated_at, created_at) FROM stdin;
1	2026-11-05 15:45:57.899+05:30	2026-11-05 15:45:57.9+05:30
\.


--
-- Data for Name: home_announcements; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.home_announcements (_order, _parent_id, id) FROM stdin;
1	1	6aec575dcbd66c557ce01658
2	1	6aec575dcbd66c557ce01659
3	1	6aec575dcbd66c557ce0165a
\.


--
-- Data for Name: home_announcements_locales; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.home_announcements_locales (text, id, _locale, _parent_id) FROM stdin;
Kostenloser Versand in die Schweiz & nach Liechtenstein	31	de	6aec575dcbd66c557ce01658
Livraison gratuite en Suisse et au Liechtenstein	32	fr	6aec575dcbd66c557ce01658
Spedizione gratuita in Svizzera e nel Liechtenstein	33	it	6aec575dcbd66c557ce01658
Free shipping in Switzerland & Liechtenstein	34	en	6aec575dcbd66c557ce01658
Bezahle mit TWINT, Karte, Apple Pay oder Google Pay	35	de	6aec575dcbd66c557ce01659
Payez avec TWINT, carte, Apple Pay ou Google Pay	36	fr	6aec575dcbd66c557ce01659
Paga con TWINT, carta, Apple Pay o Google Pay	37	it	6aec575dcbd66c557ce01659
Pay with TWINT, card, Apple Pay or Google Pay	38	en	6aec575dcbd66c557ce01659
Gratis-Probe zu deiner ersten Bestellung	39	de	6aec575dcbd66c557ce0165a
Échantillon offert avec votre première commande	40	fr	6aec575dcbd66c557ce0165a
Campione omaggio con il tuo primo ordine	41	it	6aec575dcbd66c557ce0165a
Free sample with your first order	42	en	6aec575dcbd66c557ce0165a
\.


--
-- Data for Name: home_locales; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.home_locales (hero_title, hero_lede, id, _locale, _parent_id) FROM stdin;
Hautpflege, die zu jeder Haut passt.	Koreanisch formulierte Routinen, einfach und sanft zu jeder Haut.	11	de	1
Des soins pour toutes les peaux.	Des routines de formulation coréenne, simples et douces pour toutes les peaux.	12	fr	1
Skincare adatta a ogni pelle.	Routine di formulazione coreana, semplici e delicate su ogni pelle.	13	it	1
Skincare that fits every skin.	Korean-formulated routines, made simple and gentle on every skin.	14	en	1
\.


--
-- Data for Name: home_rels; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.home_rels (id, "order", parent_id, path, products_id) FROM stdin;
33	1	1	bestsellers	44
34	2	1	bestsellers	52
35	3	1	bestsellers	43
36	4	1	bestsellers	32
37	5	1	bestsellers	48
38	6	1	bestsellers	19
39	1	1	sets	61
40	2	1	sets	62
\.


--
-- Data for Name: home_routine; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.home_routine (_order, _parent_id, id, korean, product_id) FROM stdin;
1	1	6aec575dcbd66c557ce0165b	세안	37
2	1	6aec575dcbd66c557ce0165c	토너	43
3	1	6aec575dcbd66c557ce0165d	에센스	48
4	1	6aec575dcbd66c557ce0165e	보습	32
5	1	6aec575dcbd66c557ce0165f	선케어	52
\.


--
-- Data for Name: home_routine_locales; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.home_routine_locales (title, note, id, _locale, _parent_id) FROM stdin;
Reinigen	Entfernt Öl und Sonnenschutz, ohne auszutrocknen.	51	de	6aec575dcbd66c557ce0165b
Nettoyer	Élimine le sébum et la protection solaire sans dessécher.	52	fr	6aec575dcbd66c557ce0165b
Detergere	Rimuove sebo e protezione solare senza seccare.	53	it	6aec575dcbd66c557ce0165b
Cleanse	Lift away oil and sunscreen without stripping.	54	en	6aec575dcbd66c557ce0165b
Klären	Bereitet die Haut vor, damit alles Weitere besser einzieht.	55	de	6aec575dcbd66c557ce0165c
Tonifier	Prépare la peau pour que la suite pénètre mieux.	56	fr	6aec575dcbd66c557ce0165c
Tonificare	Prepara la pelle perché tutto il resto si assorba meglio.	57	it	6aec575dcbd66c557ce0165c
Tone	Prep skin so everything after absorbs better.	58	en	6aec575dcbd66c557ce0165c
Pflegen	Ein Serum für das Anliegen, das dir am wichtigsten ist.	59	de	6aec575dcbd66c557ce0165d
Traiter	Un sérum pour la préoccupation qui compte le plus pour vous.	60	fr	6aec575dcbd66c557ce0165d
Trattare	Un siero per l’esigenza che ti sta più a cuore.	61	it	6aec575dcbd66c557ce0165d
Treat	One serum for the concern you care about most.	62	en	6aec575dcbd66c557ce0165d
Feuchtigkeit	Mit einer Creme, die zu deiner Haut passt, versiegeln.	63	de	6aec575dcbd66c557ce0165e
Hydrater	Scellez le tout avec une crème adaptée à votre peau.	64	fr	6aec575dcbd66c557ce0165e
Idratare	Sigilla il tutto con una crema adatta alla tua pelle.	65	it	6aec575dcbd66c557ce0165e
Moisturise	Seal it in with a cream suited to your skin.	66	en	6aec575dcbd66c557ce0165e
Schützen	Jeden Morgen mit Breitband-Sonnenschutz abschliessen.	67	de	6aec575dcbd66c557ce0165f
Protéger	Terminez chaque matin par une protection solaire à large spectre.	68	fr	6aec575dcbd66c557ce0165f
Proteggere	Concludi ogni mattina con una protezione solare ad ampio spettro.	69	it	6aec575dcbd66c557ce0165f
Protect	Finish every morning with broad-spectrum SPF.	70	en	6aec575dcbd66c557ce0165f
\.


--
-- Data for Name: media; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.media (id, alt, updated_at, created_at, url, thumbnail_u_r_l, filename, mime_type, filesize, width, height, focal_x, focal_y) FROM stdin;
29	Mise en Scène Perfect Serum Original	2026-11-13 10:13:16.729+05:30	2026-11-13 10:13:16.729+05:30	/api/media/file/mise-en-scene-perfect-serum-original-1.webp	\N	mise-en-scene-perfect-serum-original-1.webp	image/webp	19178	900	900	50	50
30	Mise en Scène Perfect Serum Original, product information	2026-11-13 10:13:16.956+05:30	2026-11-13 10:13:16.956+05:30	/api/media/file/mise-en-scene-perfect-serum-original-poster-1.webp	\N	mise-en-scene-perfect-serum-original-poster-1.webp	image/webp	47094	595	801	50	50
31	Mise en Scène Perfect Serum	2026-11-13 10:13:17.858+05:30	2026-11-13 10:13:17.858+05:30	/api/media/file/mise-en-scene-perfect-serum-1.webp	\N	mise-en-scene-perfect-serum-1.webp	image/webp	27530	900	900	50	50
32	Mise en Scène Perfect Serum, product information	2026-11-13 10:13:18.131+05:30	2026-11-13 10:13:18.131+05:30	/api/media/file/mise-en-scene-perfect-serum-poster-1.webp	\N	mise-en-scene-perfect-serum-poster-1.webp	image/webp	53988	638	797	50	50
33	Dr.FORHAIR Folligen Original Shampoo	2026-11-13 10:13:18.958+05:30	2026-11-13 10:13:18.958+05:30	/api/media/file/dr-forhair-folligen-original-shampoo-1.webp	\N	dr-forhair-folligen-original-shampoo-1.webp	image/webp	26750	900	900	50	50
34	Dr.FORHAIR Folligen Original Shampoo, product information	2026-11-13 10:13:19.296+05:30	2026-11-13 10:13:19.296+05:30	/api/media/file/dr-forhair-folligen-original-shampoo-poster-1.webp	\N	dr-forhair-folligen-original-shampoo-poster-1.webp	image/webp	53748	602	803	50	50
35	Lador Hydro LPP Treatment	2026-11-13 10:13:20.157+05:30	2026-11-13 10:13:20.157+05:30	/api/media/file/lador-hydro-lpp-treatment-1.webp	\N	lador-hydro-lpp-treatment-1.webp	image/webp	26912	900	900	50	50
36	Lador Hydro LPP Treatment, product information	2026-11-13 10:13:20.517+05:30	2026-11-13 10:13:20.516+05:30	/api/media/file/lador-hydro-lpp-treatment-poster-1.webp	\N	lador-hydro-lpp-treatment-poster-1.webp	image/webp	62466	788	805	50	50
37	Aromatica Rosemary Scalp Scrub	2026-11-13 10:13:21.288+05:30	2026-11-13 10:13:21.288+05:30	/api/media/file/aromatica-rosemary-scalp-scrub-1.webp	\N	aromatica-rosemary-scalp-scrub-1.webp	image/webp	21184	900	900	50	50
38	Aromatica Rosemary Scalp Scrub, product information	2026-11-13 10:13:21.532+05:30	2026-11-13 10:13:21.531+05:30	/api/media/file/aromatica-rosemary-scalp-scrub-poster-1.webp	\N	aromatica-rosemary-scalp-scrub-poster-1.webp	image/webp	43890	637	802	50	50
39	Aromatica Rosemary Root Enhancer	2026-11-13 10:13:22.287+05:30	2026-11-13 10:13:22.287+05:30	/api/media/file/aromatica-rosemary-root-enhancer-1.webp	\N	aromatica-rosemary-root-enhancer-1.webp	image/webp	22596	900	900	50	50
40	Aromatica Rosemary Root Enhancer, product information	2026-11-13 10:13:22.524+05:30	2026-11-13 10:13:22.524+05:30	/api/media/file/aromatica-rosemary-root-enhancer-poster-1.webp	\N	aromatica-rosemary-root-enhancer-poster-1.webp	image/webp	49686	602	805	50	50
41	Aromatica Rosemary Scalp Scaling Shampoo	2026-11-13 10:13:23.417+05:30	2026-11-13 10:13:23.417+05:30	/api/media/file/aromatica-rosemary-scalp-scaling-shampoo-1.webp	\N	aromatica-rosemary-scalp-scaling-shampoo-1.webp	image/webp	18442	900	900	50	50
42	Aromatica Rosemary Scalp Scaling Shampoo, product information	2026-11-13 10:13:23.771+05:30	2026-11-13 10:13:23.771+05:30	/api/media/file/aromatica-rosemary-scalp-scaling-shampoo-poster-1.webp	\N	aromatica-rosemary-scalp-scaling-shampoo-poster-1.webp	image/webp	41888	598	810	50	50
43	Labo-H Scalp Strengthening Shampoo	2026-11-13 10:13:24.468+05:30	2026-11-13 10:13:24.468+05:30	/api/media/file/labo-h-scalp-strengthening-shampoo-1.webp	\N	labo-h-scalp-strengthening-shampoo-1.webp	image/webp	22168	900	900	50	50
44	Labo-H Scalp Strengthening Shampoo, product information	2026-11-13 10:13:24.854+05:30	2026-11-13 10:13:24.854+05:30	/api/media/file/labo-h-scalp-strengthening-shampoo-poster-1.webp	\N	labo-h-scalp-strengthening-shampoo-poster-1.webp	image/webp	41072	676	805	50	50
45	Illiyoon Ultra Repair Deep Moisture Wash	2026-11-13 10:13:25.95+05:30	2026-11-13 10:13:25.95+05:30	/api/media/file/illiyoon-ultra-repair-deep-moisture-wash-1.webp	\N	illiyoon-ultra-repair-deep-moisture-wash-1.webp	image/webp	16720	900	900	50	50
46	Illiyoon Ultra Repair Deep Moisture Wash, product information	2026-11-13 10:13:26.506+05:30	2026-11-13 10:13:26.506+05:30	/api/media/file/illiyoon-ultra-repair-deep-moisture-wash-poster-1.webp	\N	illiyoon-ultra-repair-deep-moisture-wash-poster-1.webp	image/webp	63066	717	803	50	50
47	Illiyoon Ultra Moisture Scrub Wash	2026-11-13 10:13:27.502+05:30	2026-11-13 10:13:27.502+05:30	/api/media/file/illiyoon-ultra-moisture-scrub-wash-1.webp	\N	illiyoon-ultra-moisture-scrub-wash-1.webp	image/webp	18970	900	900	50	50
48	Illiyoon Ultra Moisture Scrub Wash	2026-11-13 10:13:28.314+05:30	2026-11-13 10:13:28.314+05:30	/api/media/file/illiyoon-ultra-moisture-scrub-wash-2.webp	\N	illiyoon-ultra-moisture-scrub-wash-2.webp	image/webp	25028	900	900	50	50
49	Illiyoon Ultra Moisture Scrub Wash, product information	2026-11-13 10:13:28.76+05:30	2026-11-13 10:13:28.76+05:30	/api/media/file/illiyoon-ultra-moisture-scrub-wash-poster-1.webp	\N	illiyoon-ultra-moisture-scrub-wash-poster-1.webp	image/webp	63066	717	803	50	50
50	Illiyoon Ceramide Ato Lotion	2026-11-13 10:13:29.596+05:30	2026-11-13 10:13:29.596+05:30	/api/media/file/illiyoon-ceramide-ato-lotion-1.webp	\N	illiyoon-ceramide-ato-lotion-1.webp	image/webp	11976	900	900	50	50
51	Illiyoon Ceramide Ato Lotion	2026-11-13 10:13:30.328+05:30	2026-11-13 10:13:30.328+05:30	/api/media/file/illiyoon-ceramide-ato-lotion-2.webp	\N	illiyoon-ceramide-ato-lotion-2.webp	image/webp	13500	900	900	50	50
52	Illiyoon Ceramide Ato Lotion, product information	2026-11-13 10:13:30.843+05:30	2026-11-13 10:13:30.843+05:30	/api/media/file/illiyoon-ceramide-ato-lotion-poster-1.webp	\N	illiyoon-ceramide-ato-lotion-poster-1.webp	image/webp	63066	717	803	50	50
53	Illiyoon Ceramide Ato 6.0 Top to Toe Wash	2026-11-13 10:13:31.77+05:30	2026-11-13 10:13:31.77+05:30	/api/media/file/illiyoon-ceramide-ato-6-0-top-to-toe-wash-1.webp	\N	illiyoon-ceramide-ato-6-0-top-to-toe-wash-1.webp	image/webp	17286	900	900	50	50
54	Illiyoon Ceramide Ato 6.0 Top to Toe Wash, product information	2026-11-13 10:13:32.127+05:30	2026-11-13 10:13:32.127+05:30	/api/media/file/illiyoon-ceramide-ato-6-0-top-to-toe-wash-poster-1.webp	\N	illiyoon-ceramide-ato-6-0-top-to-toe-wash-poster-1.webp	image/webp	42120	675	807	50	50
55	Illiyoon Ceramide Ato Concentrate Cream	2026-11-13 10:13:33.097+05:30	2026-11-13 10:13:33.097+05:30	/api/media/file/illiyoon-ceramide-ato-concentrate-cream-1.webp	\N	illiyoon-ceramide-ato-concentrate-cream-1.webp	image/webp	10854	900	900	50	50
56	Illiyoon Ceramide Ato Concentrate Cream, product information	2026-11-13 10:13:33.37+05:30	2026-11-13 10:13:33.37+05:30	/api/media/file/illiyoon-ceramide-ato-concentrate-cream-poster-1.webp	\N	illiyoon-ceramide-ato-concentrate-cream-poster-1.webp	image/webp	63066	717	803	50	50
57	Dr. Althea 345 Relief Cream	2026-11-13 10:13:34.126+05:30	2026-11-13 10:13:34.126+05:30	/api/media/file/dr-althea-345-relief-cream-1.webp	\N	dr-althea-345-relief-cream-1.webp	image/webp	23834	900	900	50	50
58	Dr. Althea 345 Relief Cream	2026-11-13 10:13:35.05+05:30	2026-11-13 10:13:35.048+05:30	/api/media/file/dr-althea-345-relief-cream-2.webp	\N	dr-althea-345-relief-cream-2.webp	image/webp	33860	900	900	50	50
59	Dr. Althea 345 Relief Cream, product information	2026-11-13 10:13:35.324+05:30	2026-11-13 10:13:35.324+05:30	/api/media/file/dr-althea-345-relief-cream-poster-1.webp	\N	dr-althea-345-relief-cream-poster-1.webp	image/webp	46700	635	802	50	50
60	Dr. Althea 345 Relief Cream, product information	2026-11-13 10:13:35.666+05:30	2026-11-13 10:13:35.666+05:30	/api/media/file/dr-althea-345-relief-cream-poster-2.webp	\N	dr-althea-345-relief-cream-poster-2.webp	image/webp	61706	682	805	50	50
61	Purito Oat-In Calming Gel Cream	2026-11-13 10:13:36.572+05:30	2026-11-13 10:13:36.572+05:30	/api/media/file/purito-oat-in-calming-gel-cream-1.webp	\N	purito-oat-in-calming-gel-cream-1.webp	image/webp	14720	900	900	50	50
62	Purito Oat-In Calming Gel Cream, product information	2026-11-13 10:13:37.08+05:30	2026-11-13 10:13:37.08+05:30	/api/media/file/purito-oat-in-calming-gel-cream-poster-1.webp	\N	purito-oat-in-calming-gel-cream-poster-1.webp	image/webp	62464	747	803	50	50
63	COSRX Advanced Snail 92 All in One Cream	2026-11-13 10:13:38.047+05:30	2026-11-13 10:13:38.047+05:30	/api/media/file/cosrx-advanced-snail-92-all-in-one-cream-1.webp	\N	cosrx-advanced-snail-92-all-in-one-cream-1.webp	image/webp	33488	900	900	50	50
64	COSRX Advanced Snail 92 All in One Cream, product information	2026-11-13 10:13:38.41+05:30	2026-11-13 10:13:38.41+05:30	/api/media/file/cosrx-advanced-snail-92-all-in-one-cream-poster-1.webp	\N	cosrx-advanced-snail-92-all-in-one-cream-poster-1.webp	image/webp	51714	712	797	50	50
65	Some By Mi Snail Truecica Miracle Repair Cream	2026-11-13 10:13:39.261+05:30	2026-11-13 10:13:39.261+05:30	/api/media/file/some-by-mi-snail-truecica-miracle-repair-cream-1.webp	\N	some-by-mi-snail-truecica-miracle-repair-cream-1.webp	image/webp	28764	900	900	50	50
66	Some By Mi Snail Truecica Miracle Repair Cream, product information	2026-11-13 10:13:39.523+05:30	2026-11-13 10:13:39.522+05:30	/api/media/file/some-by-mi-snail-truecica-miracle-repair-cream-poster-1.webp	\N	some-by-mi-snail-truecica-miracle-repair-cream-poster-1.webp	image/webp	55096	715	808	50	50
67	Round Lab Mugwort Cleansing Foam	2026-11-13 10:13:40.369+05:30	2026-11-13 10:13:40.368+05:30	/api/media/file/round-lab-mugwort-cleansing-foam-1.webp	\N	round-lab-mugwort-cleansing-foam-1.webp	image/webp	19710	900	900	50	50
68	Round Lab Mugwort Cleansing Foam, product information	2026-11-13 10:13:40.632+05:30	2026-11-13 10:13:40.632+05:30	/api/media/file/round-lab-mugwort-cleansing-foam-poster-1.webp	\N	round-lab-mugwort-cleansing-foam-poster-1.webp	image/webp	68312	698	811	50	50
69	COSRX Low pH Good Morning Gel Cleanser	2026-11-13 10:13:41.656+05:30	2026-11-13 10:13:41.656+05:30	/api/media/file/cosrx-low-ph-good-morning-gel-cleanser-1.webp	\N	cosrx-low-ph-good-morning-gel-cleanser-1.webp	image/webp	25304	900	900	50	50
70	COSRX Low pH Good Morning Gel Cleanser, product information	2026-11-13 10:13:42.104+05:30	2026-11-13 10:13:42.104+05:30	/api/media/file/cosrx-low-ph-good-morning-gel-cleanser-poster-1.webp	\N	cosrx-low-ph-good-morning-gel-cleanser-poster-1.webp	image/webp	60590	712	806	50	50
71	Lagom Cellup Micro Foam Cleanser	2026-11-13 10:13:43.254+05:30	2026-11-13 10:13:43.254+05:30	/api/media/file/lagom-cellup-micro-foam-cleanser-1.webp	\N	lagom-cellup-micro-foam-cleanser-1.webp	image/webp	14804	900	900	50	50
72	Lagom Cellup Micro Foam Cleanser, product information	2026-11-13 10:13:43.687+05:30	2026-11-13 10:13:43.687+05:30	/api/media/file/lagom-cellup-micro-foam-cleanser-poster-1.webp	\N	lagom-cellup-micro-foam-cleanser-poster-1.webp	image/webp	44882	601	806	50	50
73	b:plain Mung Bean Cleansing Foam	2026-11-13 10:13:44.89+05:30	2026-11-13 10:13:44.89+05:30	/api/media/file/b-plain-mung-bean-cleansing-foam-1.webp	\N	b-plain-mung-bean-cleansing-foam-1.webp	image/webp	22070	900	900	50	50
74	b:plain Mung Bean Cleansing Foam, product information	2026-11-13 10:13:45.309+05:30	2026-11-13 10:13:45.309+05:30	/api/media/file/b-plain-mung-bean-cleansing-foam-poster-1.webp	\N	b-plain-mung-bean-cleansing-foam-poster-1.webp	image/webp	49896	615	807	50	50
75	JIPU Cleansing Balm	2026-11-13 10:13:46.271+05:30	2026-11-13 10:13:46.271+05:30	/api/media/file/jipu-cleansing-balm-1.webp	\N	jipu-cleansing-balm-1.webp	image/webp	24124	900	900	50	50
76	JIPU Cleansing Balm, product information	2026-11-13 10:13:46.75+05:30	2026-11-13 10:13:46.75+05:30	/api/media/file/jipu-cleansing-balm-poster-1.webp	\N	jipu-cleansing-balm-poster-1.webp	image/webp	53286	680	802	50	50
77	Innisfree Green Tea Amino Hydrating Cleansing Foam	2026-11-13 10:13:48.04+05:30	2026-11-13 10:13:48.039+05:30	/api/media/file/innisfree-green-tea-amino-hydrating-cleansing-foam-1.webp	\N	innisfree-green-tea-amino-hydrating-cleansing-foam-1.webp	image/webp	31522	900	900	50	50
78	Innisfree Green Tea Amino Hydrating Cleansing Foam, product information	2026-11-13 10:13:48.423+05:30	2026-11-13 10:13:48.423+05:30	/api/media/file/innisfree-green-tea-amino-hydrating-cleansing-foam-poster-1.webp	\N	innisfree-green-tea-amino-hydrating-cleansing-foam-poster-1.webp	image/webp	48598	642	807	50	50
79	Mixsoon Bean Essence	2026-11-13 10:13:49.105+05:30	2026-11-13 10:13:49.105+05:30	/api/media/file/mixsoon-bean-essence-1.webp	\N	mixsoon-bean-essence-1.webp	image/webp	19678	900	900	50	50
80	Mixsoon Bean Essence, product information	2026-11-13 10:13:49.417+05:30	2026-11-13 10:13:49.417+05:30	/api/media/file/mixsoon-bean-essence-poster-1.webp	\N	mixsoon-bean-essence-poster-1.webp	image/webp	63838	803	800	50	50
81	Anua Heartleaf 77% Soothing Toner	2026-11-13 10:13:50.369+05:30	2026-11-13 10:13:50.369+05:30	/api/media/file/anua-heartleaf-77-soothing-toner-1.webp	\N	anua-heartleaf-77-soothing-toner-1.webp	image/webp	25868	900	900	50	50
82	Anua Heartleaf 77% Soothing Toner, product information	2026-11-13 10:13:50.96+05:30	2026-11-13 10:13:50.96+05:30	/api/media/file/anua-heartleaf-77-soothing-toner-poster-1.webp	\N	anua-heartleaf-77-soothing-toner-poster-1.webp	image/webp	59340	802	807	50	50
83	COSRX Advanced Snail 96 Mucin Power Essence	2026-11-13 10:13:52.069+05:30	2026-11-13 10:13:52.069+05:30	/api/media/file/cosrx-advanced-snail-96-mucin-power-essence-1.webp	\N	cosrx-advanced-snail-96-mucin-power-essence-1.webp	image/webp	23514	900	900	50	50
84	COSRX Advanced Snail 96 Mucin Power Essence, product information	2026-11-13 10:13:52.491+05:30	2026-11-13 10:13:52.491+05:30	/api/media/file/cosrx-advanced-snail-96-mucin-power-essence-poster-1.webp	\N	cosrx-advanced-snail-96-mucin-power-essence-poster-1.webp	image/webp	57224	798	802	50	50
85	Anua PDRN Hyaluronic Glow Pad	2026-11-13 10:13:53.465+05:30	2026-11-13 10:13:53.465+05:30	/api/media/file/anua-pdrn-hyaluronic-glow-pad-1.webp	\N	anua-pdrn-hyaluronic-glow-pad-1.webp	image/webp	20594	900	900	50	50
86	Anua PDRN Hyaluronic Glow Pad, product information	2026-11-13 10:13:53.835+05:30	2026-11-13 10:13:53.835+05:30	/api/media/file/anua-pdrn-hyaluronic-glow-pad-poster-1.webp	\N	anua-pdrn-hyaluronic-glow-pad-poster-1.webp	image/webp	43180	600	775	50	50
87	Innisfree Green Tea Seed Hyaluronic Serum	2026-11-13 10:13:54.626+05:30	2026-11-13 10:13:54.626+05:30	/api/media/file/innisfree-green-tea-seed-hyaluronic-serum-1.webp	\N	innisfree-green-tea-seed-hyaluronic-serum-1.webp	image/webp	24758	900	900	50	50
88	Innisfree Green Tea Seed Hyaluronic Serum, product information	2026-11-13 10:13:54.98+05:30	2026-11-13 10:13:54.98+05:30	/api/media/file/innisfree-green-tea-seed-hyaluronic-serum-poster-1.webp	\N	innisfree-green-tea-seed-hyaluronic-serum-poster-1.webp	image/webp	47080	732	803	50	50
89	Beauty of Joseon Revive Eye Serum Ginseng + Retinal	2026-11-13 10:13:55.853+05:30	2026-11-13 10:13:55.853+05:30	/api/media/file/beauty-of-joseon-revive-eye-serum-ginseng-retinal-1.webp	\N	beauty-of-joseon-revive-eye-serum-ginseng-retinal-1.webp	image/webp	14732	900	900	50	50
90	Beauty of Joseon Revive Eye Serum Ginseng + Retinal, product information	2026-11-13 10:13:56.298+05:30	2026-11-13 10:13:56.298+05:30	/api/media/file/beauty-of-joseon-revive-eye-serum-ginseng-retinal-poster-1.webp	\N	beauty-of-joseon-revive-eye-serum-ginseng-retinal-poster-1.webp	image/webp	38352	740	808	50	50
91	Beauty of Joseon Glow Serum Propolis + Niacinamide	2026-11-13 10:13:57.127+05:30	2026-11-13 10:13:57.127+05:30	/api/media/file/beauty-of-joseon-glow-serum-propolis-niacinamide-1.webp	\N	beauty-of-joseon-glow-serum-propolis-niacinamide-1.webp	image/webp	15732	900	900	50	50
92	Beauty of Joseon Glow Serum Propolis + Niacinamide, product information	2026-11-13 10:13:57.59+05:30	2026-11-13 10:13:57.589+05:30	/api/media/file/beauty-of-joseon-glow-serum-propolis-niacinamide-poster-1.webp	\N	beauty-of-joseon-glow-serum-propolis-niacinamide-poster-1.webp	image/webp	35060	642	791	50	50
93	Torriden Dive-In Serum	2026-11-13 10:13:58.572+05:30	2026-11-13 10:13:58.572+05:30	/api/media/file/torriden-dive-in-serum-1.webp	\N	torriden-dive-in-serum-1.webp	image/webp	21954	900	900	50	50
94	Torriden Dive-In Serum, product information	2026-11-13 10:13:58.927+05:30	2026-11-13 10:13:58.927+05:30	/api/media/file/torriden-dive-in-serum-poster-1.webp	\N	torriden-dive-in-serum-poster-1.webp	image/webp	53812	642	802	50	50
95	Anua 100+ Hyaluron Serum	2026-11-13 10:13:59.73+05:30	2026-11-13 10:13:59.73+05:30	/api/media/file/anua-100-hyaluron-serum-1.webp	\N	anua-100-hyaluron-serum-1.webp	image/webp	28606	900	900	50	50
96	Anua 100+ Hyaluron Serum, product information	2026-11-13 10:14:00.079+05:30	2026-11-13 10:14:00.079+05:30	/api/media/file/anua-100-hyaluron-serum-poster-1.webp	\N	anua-100-hyaluron-serum-poster-1.webp	image/webp	65602	736	793	50	50
97	Medicube PDRN Pink Peptide Serum	2026-11-13 10:14:00.904+05:30	2026-11-13 10:14:00.904+05:30	/api/media/file/medicube-pdrn-pink-peptide-serum-1.webp	\N	medicube-pdrn-pink-peptide-serum-1.webp	image/webp	17812	900	900	50	50
98	Medicube PDRN Pink Peptide Serum, product information	2026-11-13 10:14:01.282+05:30	2026-11-13 10:14:01.282+05:30	/api/media/file/medicube-pdrn-pink-peptide-serum-poster-1.webp	\N	medicube-pdrn-pink-peptide-serum-poster-1.webp	image/webp	37802	617	807	50	50
99	Beauty of Joseon Relief Sun Rice + Probiotics SPF50+ PA++++	2026-11-13 10:14:02.215+05:30	2026-11-13 10:14:02.215+05:30	/api/media/file/beauty-of-joseon-relief-sun-rice-probiotics-spf50-pa-1.webp	\N	beauty-of-joseon-relief-sun-rice-probiotics-spf50-pa-1.webp	image/webp	26004	900	900	50	50
100	Beauty of Joseon Relief Sun Rice + Probiotics SPF50+ PA++++, product information	2026-11-13 10:14:02.59+05:30	2026-11-13 10:14:02.59+05:30	/api/media/file/beauty-of-joseon-relief-sun-rice-probiotics-spf50-pa-poster-1.webp	\N	beauty-of-joseon-relief-sun-rice-probiotics-spf50-pa-poster-1.webp	image/webp	55418	806	802	50	50
101	Laneige Water Sleeping Mask	2026-11-13 10:14:03.337+05:30	2026-11-13 10:14:03.337+05:30	/api/media/file/laneige-water-sleeping-mask-1.webp	\N	laneige-water-sleeping-mask-1.webp	image/webp	25328	900	900	50	50
102	Laneige Water Sleeping Mask, product information	2026-11-13 10:14:03.712+05:30	2026-11-13 10:14:03.712+05:30	/api/media/file/laneige-water-sleeping-mask-poster-1.webp	\N	laneige-water-sleeping-mask-poster-1.webp	image/webp	46792	798	540	50	50
103	Merikit Regenerating Calming Mask	2026-11-13 10:14:04.706+05:30	2026-11-13 10:14:04.706+05:30	/api/media/file/merikit-regenerating-calming-mask-1.webp	\N	merikit-regenerating-calming-mask-1.webp	image/webp	26200	900	900	50	50
104	Merikit Regenerating Calming Mask, product information	2026-11-13 10:14:05.175+05:30	2026-11-13 10:14:05.175+05:30	/api/media/file/merikit-regenerating-calming-mask-poster-1.webp	\N	merikit-regenerating-calming-mask-poster-1.webp	image/webp	51336	816	742	50	50
105	Torriden Balanceful Cica Mask	2026-11-13 10:14:06.24+05:30	2026-11-13 10:14:06.24+05:30	/api/media/file/torriden-balanceful-cica-mask-1.webp	\N	torriden-balanceful-cica-mask-1.webp	image/webp	20204	900	900	50	50
106	Torriden Balanceful Cica Mask, product information	2026-11-13 10:14:06.605+05:30	2026-11-13 10:14:06.605+05:30	/api/media/file/torriden-balanceful-cica-mask-poster-1.webp	\N	torriden-balanceful-cica-mask-poster-1.webp	image/webp	48104	815	542	50	50
107	Mediheal Collagen Mask	2026-11-13 10:14:07.521+05:30	2026-11-13 10:14:07.521+05:30	/api/media/file/mediheal-collagen-mask-1.webp	\N	mediheal-collagen-mask-1.webp	image/webp	16092	900	900	50	50
108	Mediheal Collagen Mask, product information	2026-11-13 10:14:07.846+05:30	2026-11-13 10:14:07.846+05:30	/api/media/file/mediheal-collagen-mask-poster-1.webp	\N	mediheal-collagen-mask-poster-1.webp	image/webp	48104	815	542	50	50
109	Abib Gummy Sheet Mask Heartleaf Sticker	2026-11-13 10:14:08.649+05:30	2026-11-13 10:14:08.649+05:30	/api/media/file/abib-gummy-sheet-mask-heartleaf-sticker-1.webp	\N	abib-gummy-sheet-mask-heartleaf-sticker-1.webp	image/webp	18270	900	900	50	50
110	Abib Gummy Sheet Mask Heartleaf Sticker, product information	2026-11-13 10:14:08.958+05:30	2026-11-13 10:14:08.958+05:30	/api/media/file/abib-gummy-sheet-mask-heartleaf-sticker-poster-1.webp	\N	abib-gummy-sheet-mask-heartleaf-sticker-poster-1.webp	image/webp	48104	815	542	50	50
111	Mediheal Vitamin C Mask	2026-11-13 10:14:09.714+05:30	2026-11-13 10:14:09.714+05:30	/api/media/file/mediheal-vitamin-c-mask-1.webp	\N	mediheal-vitamin-c-mask-1.webp	image/webp	22630	900	900	50	50
112	Mediheal Vitamin C Mask, product information	2026-11-13 10:14:09.934+05:30	2026-11-13 10:14:09.934+05:30	/api/media/file/mediheal-vitamin-c-mask-poster-1.webp	\N	mediheal-vitamin-c-mask-poster-1.webp	image/webp	48104	815	542	50	50
113	Torriden Solid-In Lip Essence	2026-11-13 10:14:10.707+05:30	2026-11-13 10:14:10.707+05:30	/api/media/file/torriden-solid-in-lip-essence-1.webp	\N	torriden-solid-in-lip-essence-1.webp	image/webp	16352	900	900	50	50
114	Torriden Solid-In Lip Essence, product information	2026-11-13 10:14:10.978+05:30	2026-11-13 10:14:10.978+05:30	/api/media/file/torriden-solid-in-lip-essence-poster-1.webp	\N	torriden-solid-in-lip-essence-poster-1.webp	image/webp	38620	606	802	50	50
115	Laneige Lip Sleeping Mask Peach Iced Tea	2026-11-13 10:14:11.767+05:30	2026-11-13 10:14:11.767+05:30	/api/media/file/laneige-lip-sleeping-mask-peach-iced-tea-1.webp	\N	laneige-lip-sleeping-mask-peach-iced-tea-1.webp	image/webp	23378	900	900	50	50
116	Laneige Lip Sleeping Mask Peach Iced Tea, product information	2026-11-13 10:14:12.127+05:30	2026-11-13 10:14:12.127+05:30	/api/media/file/laneige-lip-sleeping-mask-peach-iced-tea-poster-1.webp	\N	laneige-lip-sleeping-mask-peach-iced-tea-poster-1.webp	image/webp	52004	603	807	50	50
117	Round Lab Dokdo Hydration Routine	2026-11-13 10:14:12.893+05:30	2026-11-13 10:14:12.893+05:30	/api/media/file/round-lab-dokdo-hydration-routine-1.webp	\N	round-lab-dokdo-hydration-routine-1.webp	image/webp	24468	900	900	50	50
118	Round Lab Dokdo Hydration Routine, product information	2026-11-13 10:14:13.158+05:30	2026-11-13 10:14:13.157+05:30	/api/media/file/round-lab-dokdo-hydration-routine-poster-1.webp	\N	round-lab-dokdo-hydration-routine-poster-1.webp	image/webp	44196	815	657	50	50
119	Korean Routine Set: Clear, Hydrated & Protected	2026-11-13 10:14:14.162+05:30	2026-11-13 10:14:14.162+05:30	/api/media/file/korean-routine-set-clear-hydrated-protected-1.webp	\N	korean-routine-set-clear-hydrated-protected-1.webp	image/webp	28516	900	900	50	50
120	Korean Routine Set: Clear, Hydrated & Protected, product information	2026-11-13 10:14:14.523+05:30	2026-11-13 10:14:14.523+05:30	/api/media/file/korean-routine-set-clear-hydrated-protected-poster-1.webp	\N	korean-routine-set-clear-hydrated-protected-poster-1.webp	image/webp	53980	812	546	50	50
121	Korean Skincare Set: Glow & Gentle	2026-11-13 10:14:15.354+05:30	2026-11-13 10:14:15.354+05:30	/api/media/file/korean-skincare-set-glow-gentle-1.webp	\N	korean-skincare-set-glow-gentle-1.webp	image/webp	45660	900	900	50	50
122	Korean Skincare Set: Glow & Gentle, product information	2026-11-13 10:14:15.754+05:30	2026-11-13 10:14:15.753+05:30	/api/media/file/korean-skincare-set-glow-gentle-poster-1.webp	\N	korean-skincare-set-glow-gentle-poster-1.webp	image/webp	52224	607	797	50	50
\.


--
-- Data for Name: payload_migrations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.payload_migrations (id, name, batch, updated_at, created_at) FROM stdin;
1	20261105_074825_initial	1	2026-11-05 15:45:43.069+05:30	2026-11-05 15:45:43.068+05:30
2	20261105_101518_localization	1	2026-11-05 15:45:43.138+05:30	2026-11-05 15:45:43.138+05:30
3	dev	-1	2026-11-15 14:41:58.155+05:30	2026-11-05 15:45:55.017+05:30
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.products (id, size, inventory, enable_variants, price_in_c_h_f_enabled, price_in_c_h_f, compare_at_price_in_c_h_f, low_stock_threshold, badge, generate_slug, slug, updated_at, created_at, deleted_at, _status) FROM stdin;
43	250 ml	20	\N	t	2490	4900	5	bestseller	f	anua-heartleaf-77-soothing-toner	2026-11-13 17:23:40.612+05:30	2026-11-13 10:13:50.965+05:30	\N	published
16	\N	0	\N	\N	\N	\N	5	none	t	\N	2026-11-07 11:03:28.797+05:30	2026-11-07 10:58:16.077+05:30	2026-11-07 11:03:28.651+05:30	draft
52	\N	20	\N	t	1990	\N	5	bestseller	f	beauty-of-joseon-relief-sun-rice-probiotics-spf50-pa	2026-11-13 10:14:02.711+05:30	2026-11-13 10:14:02.603+05:30	\N	published
19	80 ml	20	\N	t	1490	\N	5	new	f	mise-en-scene-perfect-serum-original	2026-11-13 10:14:15.87+05:30	2026-11-13 10:13:16.965+05:30	\N	published
20	\N	20	\N	t	1390	\N	5	new	f	mise-en-scene-perfect-serum	2026-11-13 10:14:15.913+05:30	2026-11-13 10:13:18.136+05:30	\N	published
21	500 ml	20	\N	t	2990	\N	5	new	f	dr-forhair-folligen-original-shampoo	2026-11-13 10:14:15.951+05:30	2026-11-13 10:13:19.313+05:30	\N	published
22	530 ml	20	\N	t	1990	\N	5	new	f	lador-hydro-lpp-treatment	2026-11-13 10:14:15.994+05:30	2026-11-13 10:13:20.521+05:30	\N	published
23	\N	20	\N	t	2690	\N	5	new	f	aromatica-rosemary-scalp-scrub	2026-11-13 10:14:16.041+05:30	2026-11-13 10:13:21.535+05:30	\N	published
24	100 ml	20	\N	t	2490	\N	5	new	f	aromatica-rosemary-root-enhancer	2026-11-13 10:14:16.089+05:30	2026-11-13 10:13:22.528+05:30	\N	published
25	400 ml	20	\N	t	2490	\N	5	new	f	aromatica-rosemary-scalp-scaling-shampoo	2026-11-13 10:14:16.136+05:30	2026-11-13 10:13:23.775+05:30	\N	published
26	750 ml	20	\N	t	2990	\N	5	none	f	labo-h-scalp-strengthening-shampoo	2026-11-13 10:14:16.175+05:30	2026-11-13 10:13:24.861+05:30	\N	published
27	500 ml	20	\N	t	1890	\N	5	none	f	illiyoon-ultra-repair-deep-moisture-wash	2026-11-13 10:14:16.218+05:30	2026-11-13 10:13:26.512+05:30	\N	published
28	500 ml	20	\N	t	1890	\N	5	none	f	illiyoon-ultra-moisture-scrub-wash	2026-11-13 10:14:16.256+05:30	2026-11-13 10:13:28.766+05:30	\N	published
29	350 ml	20	\N	t	2290	\N	5	none	f	illiyoon-ceramide-ato-lotion	2026-11-13 10:14:16.293+05:30	2026-11-13 10:13:30.847+05:30	\N	published
30	\N	20	\N	t	1990	\N	5	none	f	illiyoon-ceramide-ato-6-0-top-to-toe-wash	2026-11-13 10:14:16.338+05:30	2026-11-13 10:13:32.129+05:30	\N	published
31	75 ml	20	\N	t	1690	\N	5	none	f	illiyoon-ceramide-ato-concentrate-cream	2026-11-13 10:14:16.386+05:30	2026-11-13 10:13:33.374+05:30	\N	published
32	\N	20	\N	t	2990	\N	5	bestseller	f	dr-althea-345-relief-cream	2026-11-13 10:14:16.429+05:30	2026-11-13 10:13:35.672+05:30	\N	published
33	100 ml	20	\N	t	2390	\N	5	none	f	purito-oat-in-calming-gel-cream	2026-11-13 10:14:16.475+05:30	2026-11-13 10:13:37.092+05:30	\N	published
34	100 g	20	\N	t	2490	\N	5	none	f	cosrx-advanced-snail-92-all-in-one-cream	2026-11-13 10:14:16.517+05:30	2026-11-13 10:13:38.42+05:30	\N	published
35	60 g	20	\N	t	2490	\N	5	none	f	some-by-mi-snail-truecica-miracle-repair-cream	2026-11-13 10:14:16.567+05:30	2026-11-13 10:13:39.556+05:30	\N	published
36	150 ml	20	\N	t	1890	\N	5	none	f	round-lab-mugwort-cleansing-foam	2026-11-13 10:14:16.618+05:30	2026-11-13 10:13:40.636+05:30	\N	published
37	150 ml	20	\N	t	1390	\N	5	bestseller	f	cosrx-low-ph-good-morning-gel-cleanser	2026-11-13 10:14:16.658+05:30	2026-11-13 10:13:42.112+05:30	\N	published
38	120 ml	20	\N	t	2290	\N	5	none	f	lagom-cellup-micro-foam-cleanser	2026-11-13 10:14:16.698+05:30	2026-11-13 10:13:43.693+05:30	\N	published
39	\N	20	\N	t	1990	\N	5	none	f	b-plain-mung-bean-cleansing-foam	2026-11-13 10:14:16.734+05:30	2026-11-13 10:13:45.314+05:30	\N	published
40	30 ml	20	\N	t	1290	\N	5	new	f	jipu-cleansing-balm	2026-11-13 10:14:16.791+05:30	2026-11-13 10:13:46.754+05:30	\N	published
41	150 g	20	\N	t	1490	\N	5	none	f	innisfree-green-tea-amino-hydrating-cleansing-foam	2026-11-13 10:14:16.832+05:30	2026-11-13 10:13:48.428+05:30	\N	published
42	50 ml	20	\N	t	2990	\N	5	none	f	mixsoon-bean-essence	2026-11-13 10:14:16.872+05:30	2026-11-13 10:13:49.419+05:30	\N	published
44	100 ml	20	\N	t	2490	\N	5	bestseller	f	cosrx-advanced-snail-96-mucin-power-essence	2026-11-13 10:14:16.951+05:30	2026-11-13 10:13:52.495+05:30	\N	published
45	60 pads	20	\N	t	2690	\N	5	none	f	anua-pdrn-hyaluronic-glow-pad	2026-11-13 10:14:16.991+05:30	2026-11-13 10:13:53.842+05:30	\N	published
46	80 ml	20	\N	t	3490	\N	5	none	f	innisfree-green-tea-seed-hyaluronic-serum	2026-11-13 10:14:17.031+05:30	2026-11-13 10:13:54.986+05:30	\N	published
47	\N	20	\N	t	2290	\N	5	none	f	beauty-of-joseon-revive-eye-serum-ginseng-retinal	2026-11-13 10:14:17.071+05:30	2026-11-13 10:13:56.304+05:30	\N	published
48	\N	20	\N	t	1990	\N	5	bestseller	f	beauty-of-joseon-glow-serum-propolis-niacinamide	2026-11-13 10:14:17.108+05:30	2026-11-13 10:13:57.595+05:30	\N	published
49	\N	20	\N	t	2490	\N	5	none	f	torriden-dive-in-serum	2026-11-13 10:14:17.128+05:30	2026-11-13 10:13:58.93+05:30	\N	published
50	30 ml	20	\N	t	2790	\N	5	none	f	anua-100-hyaluron-serum	2026-11-13 10:14:17.149+05:30	2026-11-13 10:14:00.083+05:30	\N	published
51	30 ml	20	\N	t	3490	\N	5	none	f	medicube-pdrn-pink-peptide-serum	2026-11-13 10:14:17.188+05:30	2026-11-13 10:14:01.286+05:30	\N	published
53	70 ml	20	\N	t	3290	\N	5	none	f	laneige-water-sleeping-mask	2026-11-13 10:14:17.239+05:30	2026-11-13 10:14:03.716+05:30	\N	published
54	\N	20	\N	t	2890	\N	5	none	f	merikit-regenerating-calming-mask	2026-11-13 10:14:17.283+05:30	2026-11-13 10:14:05.18+05:30	\N	published
55	\N	20	\N	t	390	\N	5	none	f	torriden-balanceful-cica-mask	2026-11-13 10:14:17.324+05:30	2026-11-13 10:14:06.61+05:30	\N	published
56	\N	20	\N	t	350	\N	5	none	f	mediheal-collagen-mask	2026-11-13 10:14:17.369+05:30	2026-11-13 10:14:07.851+05:30	\N	published
57	\N	20	\N	t	490	\N	5	none	f	abib-gummy-sheet-mask-heartleaf-sticker	2026-11-13 10:14:17.398+05:30	2026-11-13 10:14:08.968+05:30	\N	published
58	\N	20	\N	t	350	\N	5	none	f	mediheal-vitamin-c-mask	2026-11-13 10:14:17.437+05:30	2026-11-13 10:14:09.937+05:30	\N	published
59	\N	20	\N	t	1490	\N	5	none	f	torriden-solid-in-lip-essence	2026-11-13 10:14:17.479+05:30	2026-11-13 10:14:10.983+05:30	\N	published
60	20 g	20	\N	t	2290	\N	5	new	f	laneige-lip-sleeping-mask-peach-iced-tea	2026-11-13 10:14:17.519+05:30	2026-11-13 10:14:12.136+05:30	\N	published
61	\N	20	\N	t	6490	\N	5	none	f	round-lab-dokdo-hydration-routine	2026-11-13 10:14:17.562+05:30	2026-11-13 10:14:13.162+05:30	\N	published
62	\N	20	\N	t	8990	\N	5	none	f	korean-routine-set-clear-hydrated-protected	2026-11-13 10:14:17.609+05:30	2026-11-13 10:14:14.527+05:30	\N	published
63	\N	20	\N	t	8490	\N	5	none	f	korean-skincare-set-glow-gentle	2026-11-13 10:14:17.641+05:30	2026-11-13 10:14:15.757+05:30	\N	published
\.


--
-- Data for Name: products_gallery; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.products_gallery (_order, _parent_id, id, image_id) FROM stdin;
1	43	6af695868449c441dccffb9d	81
2	43	6af695868449c441dccffb9e	82
1	52	6af695928449c441dccffbaf	99
2	52	6af695928449c441dccffbb0	100
1	19	6af695648449c441dccffb69	29
2	19	6af695648449c441dccffb6a	30
1	20	6af695668449c441dccffb6b	31
2	20	6af695668449c441dccffb6c	32
1	21	6af695678449c441dccffb6d	33
2	21	6af695678449c441dccffb6e	34
1	22	6af695688449c441dccffb6f	35
2	22	6af695688449c441dccffb70	36
1	23	6af695698449c441dccffb71	37
2	23	6af695698449c441dccffb72	38
1	24	6af6956a8449c441dccffb73	39
2	24	6af6956a8449c441dccffb74	40
1	25	6af6956b8449c441dccffb75	41
2	25	6af6956b8449c441dccffb76	42
1	26	6af6956c8449c441dccffb77	43
2	26	6af6956c8449c441dccffb78	44
1	27	6af6956e8449c441dccffb79	45
2	27	6af6956e8449c441dccffb7a	46
1	28	6af695708449c441dccffb7b	47
2	28	6af695708449c441dccffb7c	48
3	28	6af695708449c441dccffb7d	49
1	29	6af695728449c441dccffb7e	50
2	29	6af695728449c441dccffb7f	51
3	29	6af695728449c441dccffb80	52
1	30	6af695748449c441dccffb81	53
2	30	6af695748449c441dccffb82	54
1	31	6af695758449c441dccffb83	55
2	31	6af695758449c441dccffb84	56
1	32	6af695778449c441dccffb85	57
2	32	6af695778449c441dccffb86	58
3	32	6af695778449c441dccffb87	59
4	32	6af695778449c441dccffb88	60
1	33	6af695798449c441dccffb89	61
2	33	6af695798449c441dccffb8a	62
1	34	6af6957a8449c441dccffb8b	63
2	34	6af6957a8449c441dccffb8c	64
1	35	6af6957b8449c441dccffb8d	65
2	35	6af6957b8449c441dccffb8e	66
1	36	6af6957c8449c441dccffb8f	67
2	36	6af6957c8449c441dccffb90	68
1	37	6af6957e8449c441dccffb91	69
2	37	6af6957e8449c441dccffb92	70
1	38	6af6957f8449c441dccffb93	71
2	38	6af6957f8449c441dccffb94	72
1	39	6af695818449c441dccffb95	73
2	39	6af695818449c441dccffb96	74
1	40	6af695828449c441dccffb97	75
2	40	6af695828449c441dccffb98	76
1	41	6af695848449c441dccffb99	77
2	41	6af695848449c441dccffb9a	78
1	42	6af695858449c441dccffb9b	79
2	42	6af695858449c441dccffb9c	80
1	44	6af695888449c441dccffb9f	83
2	44	6af695888449c441dccffba0	84
1	45	6af695898449c441dccffba1	85
2	45	6af695898449c441dccffba2	86
1	46	6af6958a8449c441dccffba3	87
2	46	6af6958a8449c441dccffba4	88
1	47	6af6958c8449c441dccffba5	89
2	47	6af6958c8449c441dccffba6	90
1	48	6af6958d8449c441dccffba7	91
2	48	6af6958d8449c441dccffba8	92
1	49	6af6958e8449c441dccffba9	93
2	49	6af6958e8449c441dccffbaa	94
1	50	6af695908449c441dccffbab	95
2	50	6af695908449c441dccffbac	96
1	51	6af695918449c441dccffbad	97
2	51	6af695918449c441dccffbae	98
1	53	6af695938449c441dccffbb1	101
2	53	6af695938449c441dccffbb2	102
1	54	6af695958449c441dccffbb3	103
2	54	6af695958449c441dccffbb4	104
1	55	6af695968449c441dccffbb5	105
2	55	6af695968449c441dccffbb6	106
1	56	6af695978449c441dccffbb7	107
2	56	6af695978449c441dccffbb8	108
1	57	6af695988449c441dccffbb9	109
2	57	6af695988449c441dccffbba	110
1	58	6af695998449c441dccffbbb	111
2	58	6af695998449c441dccffbbc	112
1	59	6af6959a8449c441dccffbbd	113
2	59	6af6959a8449c441dccffbbe	114
1	60	6af6959c8449c441dccffbbf	115
2	60	6af6959c8449c441dccffbc0	116
1	61	6af6959d8449c441dccffbc1	117
2	61	6af6959d8449c441dccffbc2	118
1	62	6af6959e8449c441dccffbc3	119
2	62	6af6959e8449c441dccffbc4	120
1	63	6af6959f8449c441dccffbc5	121
2	63	6af6959f8449c441dccffbc6	122
\.


--
-- Data for Name: products_locales; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.products_locales (title, tagline, description, how_to_use, ingredients, id, _locale, _parent_id) FROM stdin;
Anua Heartleaf 77% Soothing Toner	Gesichtswasser	Beruhigender Toner für gesunde, hydrierte Haut. Die milde Formel mit 77 % Herzblatt-Extrakt und Hyaluronsäure spendet intensiv Feuchtigkeit, beruhigt gereizte Haut und stärkt die Hautbarriere. Leichte Textur, zieht schnell ein. Besonders für empfindliche, trockene und gereizte Haut.	Nach der Reinigung mit den Händen oder einem Wattepad auftragen und sanft einklopfen.	77 % Herzblatt-Extrakt (Houttuynia Cordata) und Hyaluronsäure. Frei von Parabenen, Alkohol und Duftstoffen.	847	de	43
Anua Heartleaf 77% Soothing Toner	Lotion tonique	Une lotion tonique douce et apaisante à 77 % d’extrait de houttuynia et acide hyaluronique pour une peau saine et hydratée. Elle calme les peaux sensibles et les rougeurs, hydrate durablement et renforce la barrière cutanée, avec une texture légère. Pour peaux sensibles, sèches et irritées.	Après le nettoyage, appliquer avec les mains ou un coton et faire pénétrer en tapotant.	77 % d’extrait de houttuynia cordata et acide hyaluronique. Sans parabènes, alcool ni parfum.	848	fr	43
Anua Heartleaf 77% Soothing Toner	Tonico	Un tonico delicato e lenitivo con il 77 % di estratto di houttuynia e acido ialuronico per una pelle sana e idratata. Calma pelli sensibili e rossori, idrata a lungo e rafforza la barriera cutanea, con una texture leggera. Per pelli sensibili, secche e irritate.	Dopo la detersione applicare con le mani o un dischetto e picchiettare delicatamente.	77 % di estratto di houttuynia cordata e acido ialuronico. Senza parabeni, alcol e profumo.	849	it	43
Anua Heartleaf 77% Soothing Toner	Toner	A mild, soothing toner with 77 % heartleaf extract and hyaluronic acid for healthy, hydrated skin. It calms sensitive skin and redness, gives long-lasting moisture and strengthens the skin barrier, with a light texture that absorbs quickly. For sensitive, dry and irritated skin.	After cleansing, apply with your hands or a cotton pad and pat in gently.	77 % heartleaf (houttuynia cordata) extract and hyaluronic acid. Free from parabens, alcohol and fragrance.	850	en	43
\N	\N	\N	\N	\N	205	de	16
\N	\N	\N	\N	\N	206	fr	16
\N	\N	\N	\N	\N	207	it	16
\N	\N	\N	\N	\N	208	en	16
Illiyoon Ultra Repair Deep Moisture Wash	Body wash	A gentle, moisture-giving body wash that cleanses without drying the skin out. Its ceramide and moisturising complex cares for dry and sensitive skin, and the pH-neutral formula suits the whole family.	Lather on wet skin and rinse.	Ceramides and moisturising complex. pH-neutral.	706	en	27
Illiyoon Ultra Moisture Scrub Wash	Peeling-Duschgel	Sanftes Peeling für geschmeidige Haut. Entfernt abgestorbene Hautschüppchen sanft, mit Ceramiden und natürlichem Peeling-Komplex, spendet Feuchtigkeit und pflegt. Für empfindliche und trockene Haut.	Mit sanften, kreisenden Bewegungen auf der nassen Haut einmassieren und abspülen. 2–3 Mal pro Woche.	Ceramide und natürlicher Peeling-Komplex.	707	de	28
Illiyoon Ultra Moisture Scrub Wash	Gel douche exfoliant	Un gel douche exfoliant doux pour une peau soyeuse. Des particules exfoliantes naturelles éliminent en douceur les peaux sèches et les squames, tandis que les céramides maintiennent l’hydratation. Convient aux peaux sensibles et sèches.	Masser la peau mouillée par mouvements circulaires doux puis rincer. 2 à 3 fois par semaine.	Céramides et complexe exfoliant naturel.	708	fr	28
Illiyoon Ultra Moisture Scrub Wash	Bagnoschiuma esfoliante	Un bagnoschiuma esfoliante delicato per una pelle setosa. Particelle esfolianti naturali rimuovono delicatamente le pellicine secche, mentre le ceramidi mantengono la pelle idratata. Adatto a pelli sensibili e secche.	Massaggiare la pelle bagnata con movimenti circolari delicati e risciacquare. 2–3 volte a settimana.	Ceramidi e complesso esfoliante naturale.	709	it	28
Illiyoon Ultra Moisture Scrub Wash	Exfoliating body wash	A gentle exfoliating body wash for silky-smooth skin. Natural exfoliating particles remove dry, flaky skin softly while ceramides keep the skin moisturised. Suitable for sensitive and dry skin.	Massage onto wet skin in gentle circles and rinse. Use 2–3 times a week.	Ceramides and a natural exfoliating complex.	710	en	28
Illiyoon Ceramide Ato Lotion	Körperlotion	Leichte, tägliche Feuchtigkeitspflege mit Ceramide Skin Complex™ zur Stärkung der Hautbarriere. Zieht schnell ein, klebt nicht und spendet 24 Stunden Feuchtigkeit für empfindliche und trockene Haut. Parfümfrei und hypoallergen.	Nach dem Duschen grosszügig auf die leicht feuchte Haut auftragen.	Ceramide Skin Complex™. Parfümfrei, hypoallergen.	711	de	29
Illiyoon Ceramide Ato Lotion	Lait corporel	Un lait hydratant léger au quotidien, avec le Ceramide Skin Complex™ d’Illiyoon pour renforcer la barrière cutanée. Il pénètre vite sans coller et hydrate 24 heures les peaux sensibles et sèches. Sans parfum et hypoallergénique.	Appliquer généreusement sur la peau légèrement humide après la douche.	Ceramide Skin Complex™. Sans parfum, hypoallergénique.	712	fr	29
Illiyoon Ceramide Ato Lotion	Lozione corpo	Una lozione idratante leggera per tutti i giorni, con il Ceramide Skin Complex™ di Illiyoon per rafforzare la barriera cutanea. Si assorbe in fretta senza appiccicare e idrata per 24 ore la pelle sensibile e secca. Senza profumo e ipoallergenica.	Applicare generosamente sulla pelle leggermente umida dopo la doccia.	Ceramide Skin Complex™. Senza profumo, ipoallergenica.	713	it	29
Illiyoon Ceramide Ato Lotion	Body lotion	A light daily moisturising lotion with Illiyoon’s Ceramide Skin Complex to strengthen the skin barrier. It absorbs quickly without feeling sticky and keeps sensitive and dry skin moisturised for 24 hours. Fragrance-free and hypoallergenic.	Apply generously to slightly damp skin after showering.	Ceramide Skin Complex™. Fragrance-free, hypoallergenic.	714	en	29
Illiyoon Ceramide Ato 6.0 Top to Toe Wash	Duschgel	Eine milde, parfümfreie Wäsche für Haar und Körper, für die ganze Familie und auch für empfindliche Haut. Ceramide stärken die Hautbarriere, während sie sanft reinigt und Feuchtigkeit spendet. Dermatologisch getestet, hergestellt in Korea.	Auf der nassen Haut aufschäumen und abspülen.	Ceramide. Ohne zugesetztes Parfüm.	715	de	30
Illiyoon Ceramide Ato 6.0 Top to Toe Wash	Gel douche	Un nettoyant doux sans parfum pour les cheveux et le corps, pour toute la famille, y compris les peaux sensibles. Les céramides renforcent la barrière cutanée tout en nettoyant en douceur et en hydratant. Testé dermatologiquement, fabriqué en Corée.	Faire mousser sur peau mouillée puis rincer.	Céramides. Sans parfum ajouté.	716	fr	30
Beauty of Joseon Relief Sun Rice + Probiotics SPF50+ PA++++	Sonnenschutz LSF 50+	Sonnenschutz. Pflege. Strahlender Teint. Leichte, feuchtigkeitsspendende Sonnencreme mit Reiskleie-Extrakt und probiotischen Inhaltsstoffen. SPF50+ PA++++ schützt zuverlässig vor UVA- und UVB-Strahlung, zieht schnell ein und hinterlässt kein fettiges Gefühl. Für alle Hauttypen, auch für empfindliche Haut.	Als letzten Schritt der Morgenroutine gleichmässig auf Gesicht und Hals auftragen. Bei längerer Sonneneinstrahlung nachcremen.	Reiskleie-Extrakt und Probiotika. Frei von Parabenen und künstlichen Duftstoffen. Tierversuchsfrei.	557	de	52
Beauty of Joseon Relief Sun Rice + Probiotics SPF50+ PA++++	Protection solaire SPF 50+	Une crème solaire légère et hydratante à l’extrait de son de riz et aux probiotiques pour une peau saine et lumineuse. SPF50+ PA++++ protège efficacement des UVA et UVB, avec une texture non grasse qui pénètre vite. Pour tous les types de peau, même sensibles.	En dernière étape de la routine du matin, appliquer uniformément sur le visage et le cou. Renouveler en cas d’exposition prolongée.	Extrait de son de riz et probiotiques. Sans parabènes ni parfums artificiels. Non testé sur les animaux.	558	fr	52
Beauty of Joseon Relief Sun Rice + Probiotics SPF50+ PA++++	Protezione solare SPF 50+	Una crema solare leggera e idratante con estratto di crusca di riso e probiotici per una pelle sana e luminosa. SPF50+ PA++++ protegge efficacemente da UVA e UVB, con una texture non grassa che si assorbe in fretta. Per tutti i tipi di pelle, anche sensibili.	Come ultimo passaggio della routine mattutina applicare uniformemente su viso e collo. Riapplicare in caso di esposizione prolungata.	Estratto di crusca di riso e probiotici. Senza parabeni e profumi artificiali. Cruelty-free.	559	it	52
Beauty of Joseon Relief Sun Rice + Probiotics SPF50+ PA++++	Sunscreen SPF 50+	A light, moisturising sunscreen with rice bran extract and probiotics for healthy, radiant skin. SPF50+ PA++++ gives reliable protection against UVA and UVB, while the non-greasy texture absorbs quickly and suits all skin types, including sensitive skin.	As the last step of your morning routine, apply evenly to face and neck. Reapply during long sun exposure.	Rice bran extract and probiotics. Free from parabens and artificial fragrance. Cruelty-free.	560	en	52
Illiyoon Ultra Repair Deep Moisture Wash	Duschgel	Feuchtigkeitsspendende Körperreinigung, die sanft reinigt, ohne die Haut auszutrocknen. Mit Ceramiden und Feuchtigkeitskomplex für trockene und empfindliche Haut, pH-hautneutral und für die ganze Familie geeignet.	Auf der nassen Haut aufschäumen und abspülen.	Ceramide und Feuchtigkeitskomplex. pH-hautneutral.	703	de	27
Illiyoon Ultra Repair Deep Moisture Wash	Gel douche	Un gel douche doux et hydratant qui nettoie sans dessécher. Son complexe de céramides et d’agents hydratants prend soin des peaux sèches et sensibles, et sa formule au pH neutre convient à toute la famille.	Faire mousser sur peau mouillée puis rincer.	Céramides et complexe hydratant. pH neutre.	704	fr	27
Illiyoon Ultra Repair Deep Moisture Wash	Bagnoschiuma	Un bagnoschiuma delicato e idratante che deterge senza seccare la pelle. Il complesso di ceramidi e agenti idratanti si prende cura della pelle secca e sensibile, e la formula a pH neutro è adatta a tutta la famiglia.	Emulsionare sulla pelle bagnata e risciacquare.	Ceramidi e complesso idratante. pH neutro.	705	it	27
Mise en Scène Perfect Serum Original	Haarserum	Das beliebte Haarserum aus Korea für glattes, glänzendes und gesund aussehendes Haar – ohne zu beschweren. Es verleiht intensiven Glanz, hilft vor Hitze, UV-Strahlen und äusseren Einflüssen zu schützen und pflegt mit einer leichten, nicht fettenden Formel.	1–2 Pumpstösse in handtuchtrockene oder trockene Längen und Spitzen geben, Kopfhaut aussparen. Nicht ausspülen.	\N	671	de	19
Mise en Scène Perfect Serum Original	Sérum capillaire	Le sérum capillaire coréen culte pour des cheveux lisses, brillants et en pleine santé, sans les alourdir. Il apporte une brillance intense, aide à protéger de la chaleur, des UV et des agressions extérieures et nourrit grâce à une formule légère et non grasse.	Appliquer 1 à 2 pressions sur les longueurs et pointes essorées ou sèches, sans toucher le cuir chevelu. Ne pas rincer.	\N	672	fr	19
Mise en Scène Perfect Serum Original	Siero per capelli	Il siero coreano di culto per capelli lisci, lucenti e dall’aspetto sano, senza appesantirli. Dona una brillantezza intensa, aiuta a proteggere da calore, raggi UV e agenti esterni e nutre con una formula leggera e non grassa.	Applicare 1–2 erogazioni su lunghezze e punte tamponate o asciutte, evitando la cute. Non risciacquare.	\N	673	it	19
Mise en Scène Perfect Serum Original	Hair serum	The cult Korean hair serum for smooth, glossy, healthy-looking hair without weighing it down. It adds intense shine, helps protect against heat, UV and everyday damage, and nourishes with a light, non-greasy formula.	Apply 1–2 pumps to towel-dried or dry lengths and ends, avoiding the scalp. Do not rinse.	\N	674	en	19
Mise en Scène Perfect Serum	Haarserum	Das Kult-Haarserum aus Korea für sichtbar glatteres, glänzenderes und gesünder aussehendes Haar. Sorgt sofort für Glanz und leichte Kämmbarkeit, schützt vor Hitze und UV-Strahlen und hilft, Spliss zu reduzieren – mit einer schnell einziehenden Formel ohne fettiges Gefühl.	1–2 Pumpstösse in handtuchtrockene oder trockene Längen und Spitzen geben, Kopfhaut aussparen. Nicht ausspülen.	\N	675	de	20
Mise en Scène Perfect Serum	Sérum capillaire	Le sérum capillaire coréen culte pour des cheveux visiblement plus lisses, plus brillants et en meilleure santé. Brillance immédiate et démêlage facile, protection contre la chaleur et les UV et moins de fourches, grâce à une formule qui pénètre vite sans effet gras.	Appliquer 1 à 2 pressions sur les longueurs et pointes essorées ou sèches, sans toucher le cuir chevelu. Ne pas rincer.	\N	676	fr	20
Mise en Scène Perfect Serum	Siero per capelli	Il siero coreano di culto per capelli visibilmente più lisci, lucenti e sani. Brillantezza immediata e pettinabilità facile, protezione da calore e UV e meno doppie punte, con una formula che si assorbe in fretta senza ungere.	Applicare 1–2 erogazioni su lunghezze e punte tamponate o asciutte, evitando la cute. Non risciacquare.	\N	677	it	20
Mise en Scène Perfect Serum	Hair serum	The classic Korean hair serum for visibly smoother, glossier and healthier-looking hair. Gives instant shine and easy combing, helps protect against heat and UV, and helps reduce split ends with a fast-absorbing formula that never feels greasy.	Apply 1–2 pumps to towel-dried or dry lengths and ends, avoiding the scalp. Do not rinse.	\N	678	en	20
Dr.FORHAIR Folligen Original Shampoo	Shampoo	Klinisch bewährte Pflege gegen übermässigen Talg und Kopfhautprobleme, ideal für dünner werdendes Haar. Entwickelt vom Dr.FORHAIR Scalp & Hair Research Center, reduziert überschüssigen Talg um bis zu 71,4 % und erhöht die Widerstandskraft der Kopfhaut um bis zu 40,2 % – sanft und frei von Parabenen.	In das nasse Haar und die Kopfhaut einmassieren, aufschäumen und gründlich ausspülen.	\N	679	de	21
Dr.FORHAIR Folligen Original Shampoo	Shampooing	Un shampooing cliniquement testé pour le cuir chevelu gras et sensible et les cheveux qui s’affinent. Développé par le Dr.FORHAIR Scalp & Hair Research Center, il réduit l’excès de sébum jusqu’à 71,4 % et renforce le cuir chevelu jusqu’à 40,2 %, avec une formule douce sans parabènes.	Masser sur cheveux et cuir chevelu mouillés, faire mousser puis rincer abondamment.	\N	680	fr	21
Dr.FORHAIR Folligen Original Shampoo	Shampoo	Uno shampoo testato clinicamente per cute grassa e problematica e capelli che si diradano. Sviluppato dal Dr.FORHAIR Scalp & Hair Research Center, riduce il sebo in eccesso fino al 71,4 % e rafforza la cute fino al 40,2 %, con una formula delicata senza parabeni.	Massaggiare su capelli e cute bagnati, emulsionare e risciacquare accuratamente.	\N	681	it	21
Dr.FORHAIR Folligen Original Shampoo	Shampoo	A clinically tested shampoo for an oily, troubled scalp and thinning hair. Developed by the Dr.FORHAIR Scalp & Hair Research Center, it reduces excess sebum by up to 71.4 % and increases scalp strength by up to 40.2 %, with a gentle, paraben-free formula.	Massage into wet hair and scalp, lather and rinse thoroughly.	\N	682	en	21
Lador Hydro LPP Treatment	Haarkur	Die professionelle Salonbehandlung mit niedrigmolekularem PPT versorgt trockenes und geschädigtes Haar tiefenwirksam mit Feuchtigkeit und Nährstoffen. Stärkt die Haarstruktur von innen, verbessert die Elastizität und schützt coloriertes Haar – silikon- und parabenfrei.	Nach dem Shampoo in Längen und Spitzen verteilen, einige Minuten einwirken lassen und ausspülen.	Niedrigmolekulare Proteine (PPT) und Kollagen. Frei von Silikonen und Parabenen.	683	de	22
Lador Hydro LPP Treatment	Soin capillaire	Un soin professionnel de salon au PPT de faible poids moléculaire qui répare en profondeur les cheveux secs et abîmés. Il renforce la fibre de l’intérieur, redonne hydratation et élasticité et protège les cheveux colorés, sans silicones ni parabènes.	Après le shampooing, appliquer sur les longueurs et pointes, laisser poser quelques minutes puis rincer.	Protéines de faible poids moléculaire (PPT) et collagène. Sans silicones ni parabènes.	684	fr	22
Lador Hydro LPP Treatment	Trattamento per capelli	Un trattamento professionale da salone con PPT a basso peso molecolare che ripara in profondità i capelli secchi e danneggiati. Rinforza la fibra dall’interno, ridona idratazione ed elasticità e protegge i capelli colorati, senza siliconi né parabeni.	Dopo lo shampoo applicare su lunghezze e punte, lasciare in posa qualche minuto e risciacquare.	Proteine a basso peso molecolare (PPT) e collagene. Senza siliconi né parabeni.	685	it	22
Lador Hydro LPP Treatment	Hair treatment	A professional salon treatment with low-molecular PPT that deeply repairs dry and damaged hair. Strengthens the hair from within, restores moisture and elasticity, and helps protect colour-treated hair, without silicones or parabens.	After shampooing, apply to the lengths and ends, leave on for a few minutes and rinse.	Low-molecular proteins (PPT) and collagen. Free from silicones and parabens.	686	en	22
Aromatica Rosemary Scalp Scrub	Kopfhautpeeling	Tiefenreinigendes Peeling für die Kopfhaut mit Rosmarin und Meersalz. Entfernt sanft abgestorbene Hautzellen und Produktablagerungen, sorgt für ein frisches, belebtes Gefühl und fördert ein gesundes Haarwachstum. Vegan und ohne Silikone.	Vor dem Shampoo 1–2 Minuten sanft in die nasse Kopfhaut einmassieren und ausspülen. 1–2 Mal pro Woche anwenden.	Rosmarin-Extrakt, Meersalz, pflanzliche Peeling-Partikel. Vegan, frei von Silikonen.	687	de	23
Aromatica Rosemary Scalp Scrub	Gommage du cuir chevelu	Un gommage purifiant du cuir chevelu au romarin et au sel marin. Il élimine en douceur cellules mortes et résidus de produits, laisse une sensation de fraîcheur et favorise une pousse saine. Vegan, sans silicones.	Avant le shampooing, masser délicatement le cuir chevelu mouillé pendant 1 à 2 minutes puis rincer. 1 à 2 fois par semaine.	Extrait de romarin, sel marin, particules exfoliantes végétales. Vegan, sans silicones.	688	fr	23
Aromatica Rosemary Scalp Scrub	Scrub per il cuoio capelluto	Uno scrub purificante per la cute con rosmarino e sale marino. Rimuove delicatamente cellule morte e residui di prodotti, lascia una sensazione di freschezza e favorisce una crescita sana. Vegano, senza siliconi.	Prima dello shampoo massaggiare delicatamente la cute bagnata per 1–2 minuti e risciacquare. 1–2 volte a settimana.	Estratto di rosmarino, sale marino, particelle esfolianti vegetali. Vegano, senza siliconi.	689	it	23
Aromatica Rosemary Scalp Scrub	Scalp scrub	A deep-cleansing scalp exfoliator with rosemary and sea salt. Gently removes dead skin cells and product build-up, leaves the scalp feeling fresh and clean, and supports healthy-looking hair growth. Vegan, without silicones.	Before shampooing, massage gently into the wet scalp for 1–2 minutes and rinse. Use 1–2 times a week.	Rosemary extract, sea salt, plant-based exfoliating particles. Vegan, free from silicones.	690	en	23
Aromatica Rosemary Root Enhancer	Kopfhaut-Tonikum	Kopfhaut-Tonikum mit Rosmarin-Extrakt für kräftigere Haarwurzeln und volleres, gesünder aussehendes Haar. Revitalisiert die Kopfhaut, nährt die Haarwurzeln, hilft Haarausfall durch Haarbruch vorzubeugen und beruhigt empfindliche Kopfhaut.	Partienweise auf die saubere Kopfhaut auftragen und einmassieren. Nicht ausspülen. Täglich anwenden.	Rosmarin-Extrakt. Vegan, frei von Silikonen, Parabenen und künstlichen Duftstoffen. Dermatologisch getestet.	691	de	24
Aromatica Rosemary Root Enhancer	Tonique pour le cuir chevelu	Un tonique pour le cuir chevelu à l’extrait de romarin pour des racines plus fortes et des cheveux plus denses. Il revitalise le cuir chevelu, nourrit les racines, aide à prévenir la chute liée à la casse et apaise le cuir chevelu sensible.	Appliquer mèche par mèche sur le cuir chevelu propre et masser. Ne pas rincer. Usage quotidien.	Extrait de romarin. Vegan, sans silicones, parabènes ni parfums artificiels. Testé dermatologiquement.	692	fr	24
Aromatica Rosemary Root Enhancer	Tonico per il cuoio capelluto	Un tonico per la cute all’estratto di rosmarino per radici più forti e capelli più voluminosi. Rivitalizza la cute, nutre le radici, aiuta a prevenire la caduta dovuta alla rottura e lenisce la cute sensibile.	Applicare a ciocche sulla cute pulita e massaggiare. Non risciacquare. Uso quotidiano.	Estratto di rosmarino. Vegano, senza siliconi, parabeni e profumi artificiali. Dermatologicamente testato.	693	it	24
Aromatica Rosemary Root Enhancer	Scalp tonic	A scalp tonic with rosemary extract for stronger roots and fuller, healthier-looking hair. Revitalises the scalp, nourishes the hair roots to help prevent hair loss caused by breakage, and soothes a sensitive or irritated scalp.	Apply to the clean scalp, section by section, and massage in. Do not rinse. Use daily.	Rosemary extract. Vegan, free from silicones, parabens and artificial fragrance. Dermatologically tested.	694	en	24
Aromatica Rosemary Scalp Scaling Shampoo	Shampoo	Natürliche Pflege für eine ausgeglichene Kopfhaut und gestärktes, glänzendes Haar – jeden Tag. Rosmarin-Extrakt revitalisiert die Kopfhaut, die tiefenreinigende Formel entfernt sanft überschüssiges Öl und Rückstände – frei von Silikonen und Sulfaten.	In das nasse Haar und die Kopfhaut einmassieren, aufschäumen und gründlich ausspülen.	Rosmarin-Extrakt. Vegan, frei von Silikonen und Sulfaten. Dermatologisch getestet.	695	de	25
Aromatica Rosemary Scalp Scaling Shampoo	Shampooing	Un shampooing naturel pour un cuir chevelu équilibré et des cheveux plus forts et brillants, au quotidien. L’extrait de romarin revitalise le cuir chevelu et la formule purifiante élimine en douceur l’excès de sébum et les résidus, sans silicones ni sulfates.	Masser sur cheveux et cuir chevelu mouillés, faire mousser puis rincer abondamment.	Extrait de romarin. Vegan, sans silicones ni sulfates. Testé dermatologiquement.	696	fr	25
Aromatica Rosemary Scalp Scaling Shampoo	Shampoo	Uno shampoo naturale per una cute equilibrata e capelli più forti e lucenti, ogni giorno. L’estratto di rosmarino rivitalizza la cute e la formula purificante rimuove delicatamente sebo in eccesso e residui, senza siliconi né solfati.	Massaggiare su capelli e cute bagnati, emulsionare e risciacquare accuratamente.	Estratto di rosmarino. Vegano, senza siliconi né solfati. Dermatologicamente testato.	697	it	25
Aromatica Rosemary Scalp Scaling Shampoo	Shampoo	A natural shampoo for a balanced scalp and stronger, shinier hair, every day. Rosemary extract revitalises the scalp while the deep-cleansing formula gently removes excess oil and residue for a fresh scalp, without silicones or sulfates.	Massage into wet hair and scalp, lather and rinse thoroughly.	Rosemary extract. Vegan, free from silicones and sulfates. Dermatologically tested.	698	en	25
Labo-H Scalp Strengthening Shampoo	Shampoo	Ein stärkendes Shampoo für eine ausgeglichene Kopfhaut und kräftigeres, gesünderes Haar. Hilft, die Barriere der Kopfhaut zu stärken und Haarausfall zu reduzieren, gleicht das Mikrobiom aus und reinigt sanft. Für alle Haartypen.	In das nasse Haar und die Kopfhaut einmassieren, aufschäumen und gründlich ausspülen.	Probiotika-Lysat, Ceramid, PDRN, Biotin und Koffein. Dermatologisch getestet.	699	de	26
Labo-H Scalp Strengthening Shampoo	Shampooing	Un shampooing fortifiant pour un cuir chevelu équilibré et des cheveux plus forts et en pleine santé. Il aide à renforcer la barrière et à réduire la chute des cheveux, équilibre le microbiome et nettoie en douceur. Convient à tous les types de cheveux.	Masser sur cheveux et cuir chevelu mouillés, faire mousser puis rincer abondamment.	Lysat de probiotiques, céramide, PDRN, biotine et caféine. Testé dermatologiquement.	700	fr	26
Labo-H Scalp Strengthening Shampoo	Shampoo	Uno shampoo fortificante per una cute equilibrata e capelli più forti e sani. Aiuta a rafforzare la barriera e a ridurre la caduta dei capelli, riequilibra il microbioma e deterge delicatamente. Adatto a tutti i tipi di capelli.	Massaggiare su capelli e cute bagnati, emulsionare e risciacquare accuratamente.	Lisato di probiotici, ceramide, PDRN, biotina e caffeina. Dermatologicamente testato.	701	it	26
Labo-H Scalp Strengthening Shampoo	Shampoo	A strengthening shampoo for a balanced scalp and stronger, healthier hair. It helps reinforce the scalp barrier and reduce hair loss, balances the scalp microbiome and cleanses gently while adding strength and vitality. Suitable for all hair types.	Massage into wet hair and scalp, lather and rinse thoroughly.	Probiotics lysate, ceramide, PDRN, biotin and caffeine. Dermatologically tested.	702	en	26
Illiyoon Ceramide Ato 6.0 Top to Toe Wash	Bagnoschiuma	Un detergente delicato senza profumo per capelli e corpo, per tutta la famiglia e anche per pelli sensibili. Le ceramidi rafforzano la barriera cutanea mentre deterge delicatamente e idrata. Dermatologicamente testato, prodotto in Corea.	Emulsionare sulla pelle bagnata e risciacquare.	Ceramidi. Senza profumo aggiunto.	717	it	30
Illiyoon Ceramide Ato 6.0 Top to Toe Wash	Body wash	A mild, fragrance-free wash for hair and body, made for the whole family, including sensitive skin. Ceramides help strengthen the skin barrier while it cleanses gently and keeps skin hydrated. Dermatologically tested, made in Korea.	Lather on wet skin and rinse.	Ceramides. No added fragrance.	718	en	30
Illiyoon Ceramide Ato Concentrate Cream	Gesichtscreme	Intensive Feuchtigkeit für empfindliche Haut, mit Ceramide Skin Complex™ zur Stärkung der Hautbarriere. Spendet langanhaltende Feuchtigkeit, ideal für trockene und empfindliche Haut. Parfümfrei und sanft.	Als letzten Schritt der Routine morgens und abends auf Gesicht und Hals verteilen.	Ceramide Skin Complex™. Parfümfrei.	719	de	31
Illiyoon Ceramide Ato Concentrate Cream	Crème visage	Une crème intensive pour peaux sensibles, avec le Ceramide Skin Complex™ d’Illiyoon pour renforcer la barrière cutanée. Elle hydrate durablement les peaux sèches et sensibles du visage et du corps. Sans parfum et douce.	En dernière étape de la routine, matin et soir, appliquer sur le visage et le cou.	Ceramide Skin Complex™. Sans parfum.	720	fr	31
Illiyoon Ceramide Ato Concentrate Cream	Crema viso	Una crema intensiva per pelli sensibili, con il Ceramide Skin Complex™ di Illiyoon per rafforzare la barriera cutanea. Idrata a lungo la pelle secca e sensibile di viso e corpo. Senza profumo e delicata.	Come ultimo passaggio della routine, mattina e sera, stendere su viso e collo.	Ceramide Skin Complex™. Senza profumo.	721	it	31
Illiyoon Ceramide Ato Concentrate Cream	Face cream	An intensive cream for sensitive skin with Illiyoon’s Ceramide Skin Complex to strengthen the skin barrier. It gives long-lasting moisture and suits dry and sensitive skin on face and body. Fragrance-free and gentle.	As the last step of your routine, morning and evening, smooth over face and neck.	Ceramide Skin Complex™. Fragrance-free.	722	en	31
Dr. Althea 345 Relief Cream	Gesichtscreme	Die multifunktionale Creme mit der 3-4-5 Formel: drei Schlüsselwirkstoffe für Beruhigung, vier für Pflege und fünf für Schutz. Beruhigt Irritationen und Rötungen, stärkt die Hautbarriere und fördert die Regeneration – leicht und nicht klebend. Für alle Hauttypen, auch für empfindliche Haut.	Als letzten Schritt der Routine morgens und abends auf Gesicht und Hals verteilen.	Niacinamid, Centella Asiatica, Madecassoside, Ceramid NP, Panthenol, Hyaluronsäure, Beta-Glucan und Pflanzenextrakte. Frei von künstlichen Duftstoffen, Parabenen und Mineralölen.	723	de	32
Dr. Althea 345 Relief Cream	Crème visage	Une crème multifonction à la formule 3-4-5 : trois actifs pour apaiser, quatre pour soigner et cinq pour protéger. Elle calme irritations et rougeurs, renforce la barrière cutanée et favorise la régénération, avec une texture légère et non collante. Pour tous les types de peau, même sensibles.	En dernière étape de la routine, matin et soir, appliquer sur le visage et le cou.	Niacinamide, centella asiatica, madécassoside, céramide NP, panthénol, acide hyaluronique, bêta-glucane et extraits de plantes. Sans parfum artificiel, parabènes ni huiles minérales.	724	fr	32
Dr. Althea 345 Relief Cream	Crema viso	Una crema multifunzione con la formula 3-4-5: tre attivi per lenire, quattro per curare e cinque per proteggere. Calma irritazioni e rossori, rafforza la barriera cutanea e favorisce la rigenerazione con una texture leggera e non appiccicosa. Per tutti i tipi di pelle, anche sensibile.	Come ultimo passaggio della routine, mattina e sera, stendere su viso e collo.	Niacinamide, centella asiatica, madecassoside, ceramide NP, pantenolo, acido ialuronico, beta-glucano ed estratti vegetali. Senza profumi artificiali, parabeni e oli minerali.	725	it	32
Dr. Althea 345 Relief Cream	Face cream	A multi-tasking cream with the 3-4-5 formula: three key ingredients to soothe, four to care and five to protect. It calms irritation and redness, strengthens the skin barrier and supports regeneration with a light, non-sticky texture. For all skin types, including sensitive skin.	As the last step of your routine, morning and evening, smooth over face and neck.	Niacinamide, centella asiatica, madecassoside, ceramide NP, panthenol, hyaluronic acid, beta-glucan and plant extracts. Free from artificial fragrance, parabens and mineral oils.	726	en	32
Purito Oat-In Calming Gel Cream	Gel-Creme	Die beruhigende Gel-Creme mit Haferwasser und Haferextrakt spendet intensive Feuchtigkeit, mildert Rötungen und stärkt die natürliche Schutzbarriere. Kühlt angenehm, zieht schnell ein und klebt nicht. Ideal für empfindliche, gereizte und trockene Haut.	Nach Reinigung und Gesichtswasser morgens und abends gleichmässig auf Gesicht und Hals auftragen.	Haferwasser, Haferextrakt und Squalan. Frei von Parabenen, Silikonen, Mineralölen und künstlichen Farbstoffen.	727	de	33
Purito Oat-In Calming Gel Cream	Gel-crème	Un gel-crème apaisant à l’eau et à l’extrait d’avoine qui hydrate intensément et durablement. Il calme irritations et rougeurs, procure une sensation de fraîcheur et renforce la barrière cutanée. Texture légère et non collante pour peaux sensibles, irritées et sèches.	Après le nettoyage et la lotion, appliquer une couche uniforme sur le visage et le cou, matin et soir.	Eau d’avoine, extrait d’avoine et squalane. Sans parabènes, silicones, huiles minérales ni colorants artificiels.	728	fr	33
Purito Oat-In Calming Gel Cream	Gel crema	Un gel crema lenitivo con acqua e estratto d’avena che idrata intensamente e a lungo. Calma irritazioni e rossori, rinfresca e rafforza la barriera cutanea. Texture leggera e non appiccicosa per pelli sensibili, irritate e secche.	Dopo detersione e tonico, stendere uno strato uniforme su viso e collo, mattina e sera.	Acqua d’avena, estratto d’avena e squalano. Senza parabeni, siliconi, oli minerali e coloranti artificiali.	729	it	33
Purito Oat-In Calming Gel Cream	Gel cream	A soothing gel cream with oat water and oat extract that gives intense, long-lasting moisture. It calms irritation and redness, leaves a refreshing, cooling feel and strengthens the skin barrier. Light, non-sticky texture for sensitive, irritated and dry skin.	After cleansing and toning, smooth an even layer over face and neck, morning and evening.	Oat seed water, oat extract and squalane. Free from parabens, silicones, mineral oils and artificial colours.	730	en	33
COSRX Advanced Snail 92 All in One Cream	Gesichtscreme	Tägliche Pflege für gesunde, strahlende Haut mit 92 % Schneckensekret-Filtrat. Spendet intensive Feuchtigkeit, unterstützt die Regeneration und stärkt die Hautbarriere – mit leichter Textur, die schnell einzieht. Für alle Hauttypen.	Als letzten Schritt der Routine morgens und abends auf Gesicht und Hals verteilen.	92 % Schneckensekret-Filtrat (Mucin).	731	de	34
COSRX Advanced Snail 92 All in One Cream	Crème visage	Une crème tout-en-un au quotidien avec 92 % de filtrat de bave d’escargot pour une peau saine et lumineuse. Elle hydrate intensément, soutient la régénération et renforce la barrière cutanée, avec une texture légère qui pénètre vite. Pour tous les types de peau.	En dernière étape de la routine, matin et soir, appliquer sur le visage et le cou.	92 % de filtrat de bave d’escargot (mucine).	732	fr	34
COSRX Advanced Snail 92 All in One Cream	Crema viso	Una crema tutto-in-uno quotidiana con il 92 % di filtrato di bava di lumaca per una pelle sana e luminosa. Idrata intensamente, sostiene la rigenerazione e rafforza la barriera cutanea con una texture leggera che si assorbe in fretta. Per tutti i tipi di pelle.	Come ultimo passaggio della routine, mattina e sera, stendere su viso e collo.	92 % di filtrato di bava di lumaca (mucina).	733	it	34
COSRX Advanced Snail 92 All in One Cream	Face cream	A daily all-in-one cream with 92 % snail secretion filtrate for healthy, radiant skin. It gives intense moisture, supports regeneration and strengthens the skin barrier, with a light texture that absorbs quickly. Suitable for all skin types.	As the last step of your routine, morning and evening, smooth over face and neck.	92 % snail secretion filtrate (mucin).	734	en	34
Some By Mi Snail Truecica Miracle Repair Cream	Gesichtscreme	Regeneration und Schutz für eine gesunde, strahlende Haut. 42 % Snail Truecica™ regeneriert und spendet Feuchtigkeit, fünf Arten von Ceramiden stärken die Hautbarriere. Leichte Textur, zieht schnell ein. Dermatologisch getestet und für empfindliche Haut geeignet.	Als letzten Schritt der Routine morgens und abends auf Gesicht und Hals verteilen.	42 % Snail Truecica™ und 5 Arten von Ceramiden.	735	de	35
Some By Mi Snail Truecica Miracle Repair Cream	Crème visage	Une crème régénérante et protectrice pour une peau saine et lumineuse. 42 % de Snail Truecica™ répare et hydrate intensément, tandis que cinq types de céramides renforcent la barrière cutanée. Testée dermatologiquement, convient aux peaux sensibles.	En dernière étape de la routine, matin et soir, appliquer sur le visage et le cou.	42 % de Snail Truecica™ et 5 types de céramides.	736	fr	35
Some By Mi Snail Truecica Miracle Repair Cream	Crema viso	Una crema rigenerante e protettiva per una pelle sana e luminosa. Il 42 % di Snail Truecica™ ripara e idrata intensamente, mentre cinque tipi di ceramidi rafforzano la barriera cutanea. Dermatologicamente testata, adatta alle pelli sensibili.	Come ultimo passaggio della routine, mattina e sera, stendere su viso e collo.	42 % di Snail Truecica™ e 5 tipi di ceramidi.	737	it	35
Some By Mi Snail Truecica Miracle Repair Cream	Face cream	A regenerating and protective cream for healthy, radiant skin. 42 % Snail Truecica™ repairs damaged skin and gives intense moisture, while five types of ceramides strengthen the skin barrier. Dermatologically tested and suitable for sensitive skin.	As the last step of your routine, morning and evening, smooth over face and neck.	42 % Snail Truecica™ and 5 types of ceramides.	738	en	35
Round Lab Mugwort Cleansing Foam	Reinigungsschaum	Sanfte Reinigung, die beruhigt und schützt. Der Reinigungsschaum mit Beifussextrakt reinigt porentief, entfernt Unreinheiten, überschüssigen Talg und Make-up-Reste, ohne auszutrocknen, und stärkt die natürliche Schutzbarriere. Für alle Hauttypen, besonders für empfindliche und zu Unreinheiten neigende Haut.	Eine kleine Menge mit Wasser aufschäumen, auf der feuchten Haut einmassieren und mit lauwarmem Wasser abspülen.	Beifussextrakt. Frei von Parabenen, Silikonen, Mineralölen, künstlichen Farbstoffen und PEGs.	739	de	36
Round Lab Mugwort Cleansing Foam	Mousse nettoyante	Une mousse nettoyante douce à l’extrait d’armoise qui nettoie en profondeur tout en apaisant. Sa mousse dense élimine impuretés, excès de sébum et résidus de maquillage sans dessécher et soutient la barrière naturelle. Pour tous les types de peau, en particulier sensibles et à imperfections.	Faire mousser une petite quantité avec de l’eau, masser sur peau humide et rincer à l’eau tiède.	Extrait d’armoise. Sans parabènes, silicones, huiles minérales, colorants artificiels ni PEG.	740	fr	36
Round Lab Mugwort Cleansing Foam	Schiuma detergente	Una schiuma detergente delicata all’estratto di artemisia che pulisce in profondità e lenisce. La schiuma densa rimuove impurità, sebo in eccesso e residui di trucco senza seccare e sostiene la barriera naturale. Per tutti i tipi di pelle, soprattutto sensibili e con imperfezioni.	Emulsionare una piccola quantità con acqua, massaggiare sulla pelle umida e risciacquare con acqua tiepida.	Estratto di artemisia. Senza parabeni, siliconi, oli minerali, coloranti artificiali e PEG.	741	it	36
Round Lab Mugwort Cleansing Foam	Cleansing foam	A gentle cleansing foam with mugwort extract that cleanses deeply while calming sensitive skin. Its dense foam removes impurities, excess oil and make-up residue without drying, and supports the natural protective barrier. For all skin types, especially sensitive and blemish-prone skin.	Lather a small amount with water, massage over damp skin and rinse with lukewarm water.	Mugwort extract. Free from parabens, silicones, mineral oils, artificial colours and PEGs.	742	en	36
COSRX Low pH Good Morning Gel Cleanser	Gel-Reiniger	Sanfte Reinigung für einen frischen Start in den Tag. Mit einem pH-Wert von ca. 5,0 reinigt der Gel-Reiniger gründlich, ohne auszutrocknen, bewahrt die natürliche Schutzbarriere und entfernt Talg und Unreinheiten. Teebaumöl und botanische Extrakte sorgen für eine ruhige, klare Haut.	Morgens und abends eine kleine Menge auf der feuchten Haut einmassieren und mit lauwarmem Wasser abspülen.	Teebaumöl und botanische Extrakte, pH-Wert ca. 5,0. Frei von Parabenen, Silikonen, künstlichen Farbstoffen und Mineralölen.	743	de	37
COSRX Low pH Good Morning Gel Cleanser	Gel nettoyant	Un gel nettoyant doux au pH bas pour bien commencer la journée. Avec un pH d’environ 5,0, il nettoie en profondeur sans dessécher, respecte la barrière naturelle et élimine sébum et impuretés. L’huile d’arbre à thé et des extraits botaniques gardent la peau calme et nette.	Matin et soir, masser une petite quantité sur peau humide et rincer à l’eau tiède.	Huile d’arbre à thé et extraits botaniques, pH d’environ 5,0. Sans parabènes, silicones, colorants artificiels ni huiles minérales.	744	fr	37
COSRX Low pH Good Morning Gel Cleanser	Gel detergente	Un gel detergente delicato a pH basso per iniziare bene la giornata. Con un pH di circa 5,0 deterge a fondo senza seccare, rispetta la barriera naturale e rimuove sebo e impurità. Olio di tea tree ed estratti botanici mantengono la pelle calma e pulita.	Mattina e sera massaggiare una piccola quantità sulla pelle umida e risciacquare con acqua tiepida.	Olio di tea tree ed estratti botanici, pH circa 5,0. Senza parabeni, siliconi, coloranti artificiali e oli minerali.	745	it	37
Innisfree Green Tea Amino Hydrating Cleansing Foam	Schiuma detergente	Una schiuma detergente idratante al tè verde e aminoacidi. Deterge delicatamente mantenendo la pelle morbida e confortevole e rimuove impurità e sebo in eccesso per un incarnato fresco e luminoso. Per tutti i tipi di pelle.	Emulsionare una piccola quantità con acqua, massaggiare sulla pelle umida e risciacquare con acqua tiepida.	Tè verde e aminoacidi. Senza parabeni e oli minerali.	761	it	41
COSRX Low pH Good Morning Gel Cleanser	Gel cleanser	A mild, low-pH gel cleanser for a fresh start to the day. With a pH of about 5.0 it cleanses thoroughly without drying, respects the skin’s natural barrier and removes excess oil and impurities. Tea tree oil and botanical extracts keep skin calm and clear.	Massage a small amount over damp skin, morning and evening, and rinse with lukewarm water.	Tea tree oil and botanical extracts, pH about 5.0. Free from parabens, silicones, artificial colours and mineral oils.	746	en	37
Lagom Cellup Micro Foam Cleanser	Reinigungsschaum	Sanfte Reinigung für strahlend schöne Haut. Die Mikro-Schaum-Technologie reinigt porentief und entfernt Schmutz und überschüssiges Öl, die pH-hautneutrale Formel bewahrt die natürliche Feuchtigkeitsbalance. Täglich anwendbar, auch bei sensibler Haut.	Eine kleine Menge mit Wasser aufschäumen, auf der feuchten Haut einmassieren und mit lauwarmem Wasser abspülen.	Pflanzliche Tenside und Feuchtigkeitsspender. pH-hautneutral.	747	de	38
Lagom Cellup Micro Foam Cleanser	Mousse nettoyante	Une mousse micro-bulles douce pour une peau nette et lumineuse. Sa mousse fine nettoie les pores et élimine impuretés et excès de sébum, tandis que la formule au pH neutre préserve l’hydratation. Assez douce pour un usage quotidien, même sur peau sensible.	Faire mousser une petite quantité avec de l’eau, masser sur peau humide et rincer à l’eau tiède.	Tensioactifs végétaux et agents hydratants. pH neutre.	748	fr	38
Lagom Cellup Micro Foam Cleanser	Schiuma detergente	Una schiuma a micro-bolle delicata per una pelle pulita e luminosa. La schiuma fine pulisce i pori e rimuove impurità e sebo in eccesso, mentre la formula a pH neutro preserva l’idratazione. Delicata per l’uso quotidiano, anche su pelle sensibile.	Emulsionare una piccola quantità con acqua, massaggiare sulla pelle umida e risciacquare con acqua tiepida.	Tensioattivi vegetali e agenti idratanti. pH neutro.	749	it	38
Lagom Cellup Micro Foam Cleanser	Cleansing foam	A gentle micro-foam cleanser for beautifully clear skin. Its fine foam cleanses pores and removes dirt and excess oil, while the pH-neutral formula keeps skin moisturised and balanced. Gentle enough for daily use, even on sensitive skin.	Lather a small amount with water, massage over damp skin and rinse with lukewarm water.	Plant-based surfactants and moisturising agents. pH-neutral.	750	en	38
b:plain Mung Bean Cleansing Foam	Reinigungsschaum	Sanfte Reinigung mit der Kraft der Mungbohne – für einen natürlichen Glow jeden Tag. Entfernt Schmutz und Überschuss sanft, sorgt für reinere, strahlendere Haut und bewahrt die Feuchtigkeit ohne Spannungsgefühl. Für alle Hauttypen, auch für empfindliche Haut.	Eine kleine Menge mit Wasser aufschäumen, auf der feuchten Haut einmassieren und mit lauwarmem Wasser abspülen.	Mungbohnen-Extrakt. Vegan, frei von Parabenen, Sulfaten und künstlichen Duftstoffen.	751	de	39
b:plain Mung Bean Cleansing Foam	Mousse nettoyante	Une mousse nettoyante douce à la puissance du haricot mungo pour un éclat naturel au quotidien. Elle élimine en douceur impuretés et excès de sébum, rend la peau plus nette et lumineuse et préserve l’hydratation sans tiraillement. Pour tous les types de peau, même sensibles.	Faire mousser une petite quantité avec de l’eau, masser sur peau humide et rincer à l’eau tiède.	Extrait de haricot mungo. Vegan, sans parabènes, sulfates ni parfums artificiels.	752	fr	39
b:plain Mung Bean Cleansing Foam	Schiuma detergente	Una schiuma detergente delicata con la forza del fagiolo mungo per un glow naturale ogni giorno. Rimuove delicatamente impurità e sebo in eccesso, rende la pelle più pulita e luminosa e preserva l’idratazione senza tirare. Per tutti i tipi di pelle, anche sensibili.	Emulsionare una piccola quantità con acqua, massaggiare sulla pelle umida e risciacquare con acqua tiepida.	Estratto di fagiolo mungo. Vegano, senza parabeni, solfati e profumi artificiali.	753	it	39
b:plain Mung Bean Cleansing Foam	Cleansing foam	A gentle cleansing foam powered by mung bean for a natural glow every day. It removes dirt and excess oil softly, leaves skin fresher and brighter, and keeps moisture in without a tight feeling. Suitable for all skin types, including sensitive skin.	Lather a small amount with water, massage over damp skin and rinse with lukewarm water.	Mung bean extract. Vegan, free from parabens, sulfates and artificial fragrance.	754	en	39
JIPU Cleansing Balm	Reinigungsbalsam	Der JIPU Cleansing Balm entfernt effektiv Make-up, Schmutz und überschüssiges Öl – für eine saubere, gepflegte und frische Haut. Die angenehme Balm-Textur löst sich leicht auf und lässt sich einfach abwaschen, reinigt die Poren und spendet Feuchtigkeit. Vegan, dermatologisch getestet und für empfindliche Haut geeignet.	Auf die trockene Haut einmassieren, um Make-up und Sonnenschutz zu lösen, mit etwas Wasser emulgieren und abspülen. Danach einen Schaumreiniger verwenden.	\N	755	de	40
JIPU Cleansing Balm	Baume démaquillant	Un baume démaquillant hydratant qui élimine efficacement maquillage, crème solaire, impuretés et excès de sébum pour une peau nette et fraîche. Le baume fondant se rince facilement, nettoie les pores et laisse la peau souple. Vegan et testé dermatologiquement, convient aux peaux sensibles.	Masser sur peau sèche pour dissoudre maquillage et crème solaire, émulsionner avec un peu d’eau puis rincer. Poursuivre avec une mousse nettoyante.	\N	756	fr	40
JIPU Cleansing Balm	Balsamo detergente	Un balsamo detergente idratante che rimuove efficacemente trucco, protezione solare, impurità e sebo in eccesso per una pelle pulita e fresca. Il balsamo si scioglie a contatto e si risciacqua facilmente, pulisce i pori e lascia la pelle morbida. Vegano e dermatologicamente testato, adatto alle pelli sensibili.	Massaggiare sulla pelle asciutta per sciogliere trucco e protezione solare, emulsionare con poca acqua e risciacquare. Proseguire con una schiuma detergente.	\N	757	it	40
JIPU Cleansing Balm	Cleansing balm	A hydrating cleansing balm that effectively removes make-up, sunscreen, dirt and excess oil for clean, fresh skin. The soft balm melts on contact and rinses off easily, cleanses pores and leaves skin supple. Vegan and dermatologically tested, suitable for sensitive skin.	Massage onto dry skin to dissolve make-up and sunscreen, add a little water to emulsify and rinse. Follow with a foam cleanser.	\N	758	en	40
Innisfree Green Tea Amino Hydrating Cleansing Foam	Reinigungsschaum	Ein sanfter, feuchtigkeitsspendender Reinigungsschaum mit Grüntee und Aminosäuren. Reinigt mild und hält die Haut geschmeidig und angenehm, entfernt Unreinheiten und überschüssigen Talg für einen frischen, strahlenden Teint. Für alle Hauttypen.	Eine kleine Menge mit Wasser aufschäumen, auf der feuchten Haut einmassieren und mit lauwarmem Wasser abspülen.	Grüntee und Aminosäuren. Frei von Parabenen und Mineralölen.	759	de	41
Innisfree Green Tea Amino Hydrating Cleansing Foam	Mousse nettoyante	Une mousse nettoyante hydratante au thé vert et aux acides aminés. Elle nettoie en douceur tout en gardant la peau souple et confortable, et élimine impuretés et excès de sébum pour un teint frais et lumineux. Pour tous les types de peau.	Faire mousser une petite quantité avec de l’eau, masser sur peau humide et rincer à l’eau tiède.	Thé vert et acides aminés. Sans parabènes ni huiles minérales.	760	fr	41
Innisfree Green Tea Amino Hydrating Cleansing Foam	Cleansing foam	A gentle hydrating cleansing foam with green tea and amino acids. It cleanses softly while keeping skin supple and comfortable, and removes impurities and excess oil for a fresh, luminous complexion. Suitable for all skin types.	Lather a small amount with water, massage over damp skin and rinse with lukewarm water.	Green tea and amino acids. Free from parabens and mineral oils.	762	en	41
Mixsoon Bean Essence	Essenz	Die Bean Essence von mixsoon besteht aus 100 % fermentiertem Sojabohnenextrakt. Sie spendet intensive Feuchtigkeit, verbessert den Hautton und stärkt die Hautbarriere – für eine gesunde, strahlende Haut. Minimal und effektiv, besonders für empfindliche, trockene und gereizte Haut.	Nach dem Gesichtswasser einige Tropfen in die Haut einklopfen, vor Serum und Creme.	100 % fermentierter Sojabohnenextrakt. Ohne Zusatzstoffe, Farbstoffe und ätherische Öle.	763	de	42
Mixsoon Bean Essence	Essence	Une essence pure composée à 100 % d’extrait de soja fermenté. Elle hydrate durablement, affine et unifie le teint pour un éclat naturel et renforce la barrière cutanée. Minimaliste et efficace, pour peaux sensibles, sèches et irritées.	Après la lotion, faire pénétrer quelques gouttes en tapotant, avant le sérum et la crème.	100 % d’extrait de soja fermenté. Sans additifs, colorants ni huiles essentielles.	764	fr	42
Mixsoon Bean Essence	Essenza	Un’essenza pura composta al 100 % da estratto di soia fermentato. Idrata a lungo, affina e uniforma l’incarnato per un glow naturale e rafforza la barriera cutanea. Minimalista ed efficace, per pelli sensibili, secche e irritate.	Dopo il tonico picchiettare qualche goccia sulla pelle, prima di siero e crema.	100 % estratto di soia fermentato. Senza additivi, coloranti e oli essenziali.	765	it	42
Mixsoon Bean Essence	Essence	A pure essence made from 100 % fermented soybean extract. It gives long-lasting moisture, refines and evens the skin tone for a natural glow, and strengthens the skin barrier. Minimal and effective, for sensitive, dry and irritated skin.	After toner, pat a few drops into the skin before serum and cream.	100 % fermented soybean extract. No additives, colours or essential oils.	766	en	42
COSRX Advanced Snail 96 Mucin Power Essence	Essenz	Diese leichte Essence mit 96 % Schneckenschleimfiltrat versorgt die Haut intensiv mit Feuchtigkeit, unterstützt die Regeneration und verleiht ein gesundes, strahlendes Hautbild. Repariert die Hautbarriere, verbessert die Hauttextur und mildert Unreinheiten und Rötungen. Besonders für trockene und geschädigte Haut.	Nach dem Gesichtswasser einige Tropfen in die Haut einklopfen, vor Serum und Creme.	96 % Schneckenschleimfiltrat. Frei von Parabenen und Silikonen.	771	de	44
COSRX Advanced Snail 96 Mucin Power Essence	Essence	Une essence légère à 96 % de filtrat de bave d’escargot qui répare, hydrate et régénère. Elle renforce la barrière cutanée, repulpe la peau d’une hydratation durable et affine le grain de peau tout en apaisant imperfections et rougeurs. Idéale pour les peaux sèches et abîmées.	Après la lotion, faire pénétrer quelques gouttes en tapotant, avant le sérum et la crème.	96 % de filtrat de bave d’escargot. Sans parabènes ni silicones.	772	fr	44
COSRX Advanced Snail 96 Mucin Power Essence	Essenza	Un’essenza leggera con il 96 % di filtrato di bava di lumaca che ripara, idrata e rigenera. Rafforza la barriera cutanea, rimpolpa la pelle con un’idratazione duratura e affina la grana della pelle, lenendo imperfezioni e rossori. Ideale per pelli secche e danneggiate.	Dopo il tonico picchiettare qualche goccia sulla pelle, prima di siero e crema.	96 % di filtrato di bava di lumaca. Senza parabeni e siliconi.	773	it	44
COSRX Advanced Snail 96 Mucin Power Essence	Essence	A light essence with 96 % snail secretion filtrate that repairs, hydrates and regenerates. It strengthens the skin barrier, plumps the skin with long-lasting moisture and refines the skin texture, while calming blemishes and redness. Especially good for dry and damaged skin.	After toner, pat a few drops into the skin before serum and cream.	96 % snail secretion filtrate. Free from parabens and silicones.	774	en	44
Anua PDRN Hyaluronic Glow Pad	Toner-Pads	Für strahlende, hydratisierte und beruhigte Haut – jeden Tag. Mit PDRN und Hyaluronsäure für tiefenwirksame Hydration, verfeinert das Hautbild für einen natürlichen Glow und beruhigt empfindliche Haut. Einfach in der Anwendung, perfekt für die tägliche Skincare-Routine.	Nach der Reinigung mit einem Pad über das Gesicht streichen und die restliche Essenz einklopfen.	PDRN und Hyaluronsäure.	775	de	45
Anua PDRN Hyaluronic Glow Pad	Disques tonifiants	Des disques tonifiants au PDRN et à l’acide hyaluronique pour une peau lumineuse, hydratée et apaisée au quotidien. Ils hydratent en profondeur, affinent le grain de peau pour un éclat naturel et apaisent les peaux sensibles. Un disque, une étape : idéal pour une routine rapide.	Après le nettoyage, passer un disque sur le visage et faire pénétrer l’essence restante en tapotant.	PDRN et acide hyaluronique.	776	fr	45
Anua PDRN Hyaluronic Glow Pad	Dischetti tonificanti	Dischetti tonificanti con PDRN e acido ialuronico per una pelle luminosa, idratata e calma ogni giorno. Idratano in profondità, affinano la grana per un glow naturale e leniscono le pelli sensibili. Un dischetto, un passaggio: perfetti per una routine veloce.	Dopo la detersione passare un dischetto sul viso e picchiettare l’essenza rimasta.	PDRN e acido ialuronico.	777	it	45
Anua PDRN Hyaluronic Glow Pad	Toner pads	Toner pads with PDRN and hyaluronic acid for radiant, hydrated and calm skin every day. They give deep hydration, refine the skin texture for a natural glow and soothe sensitive skin. One pad, one step: perfect for a quick daily routine.	After cleansing, sweep a pad over the face and pat the remaining essence into the skin.	PDRN and hyaluronic acid.	778	en	45
Innisfree Green Tea Seed Hyaluronic Serum	Serum	Feuchtigkeit. Balance. Strahlende Haut. Hyaluronsäure spendet Feuchtigkeit und bewahrt die Haut vor dem Austrocknen, grüner Tee aus Jeju liefert Aminosäuren und Antioxidantien, beruhigt und schützt. Für einen frischen, strahlenden Teint – leicht, schnell einziehend und ohne zu kleben.	Nach dem Gesichtswasser 2–3 Tropfen auf das Gesicht geben und vor der Creme einklopfen.	Hyaluronsäure und grüner Tee aus Jeju (Aminosäuren, Antioxidantien). Vegan.	779	de	46
Innisfree Green Tea Seed Hyaluronic Serum	Sérum	Un sérum hydratant à l’acide hyaluronique et au thé vert de Jeju pour une peau hydratée, équilibrée et lumineuse. Il prévient le dessèchement, apaise et protège grâce aux acides aminés et antioxydants. Léger, il pénètre vite sans coller.	Après la lotion, appliquer 2 à 3 gouttes sur le visage et tapoter avant la crème.	Acide hyaluronique et thé vert de Jeju (acides aminés, antioxydants). Vegan.	780	fr	46
Innisfree Green Tea Seed Hyaluronic Serum	Siero	Un siero idratante con acido ialuronico e tè verde di Jeju per una pelle idratata, equilibrata e luminosa. Previene la secchezza, lenisce e protegge con aminoacidi e antiossidanti. Leggero, si assorbe in fretta senza appiccicare.	Dopo il tonico applicare 2–3 gocce sul viso e picchiettare prima della crema.	Acido ialuronico e tè verde di Jeju (aminoacidi, antiossidanti). Vegano.	781	it	46
Innisfree Green Tea Seed Hyaluronic Serum	Serum	A hydrating serum with hyaluronic acid and green tea from Jeju for moisture, balance and radiant skin. It prevents dryness, calms and protects with amino acids and antioxidants, and leaves skin revitalised and glowing. Light, fast-absorbing and never sticky.	After toner, apply 2–3 drops to the face and pat in before your cream.	Hyaluronic acid and green tea from Jeju (amino acids, antioxidants). Vegan.	782	en	46
Beauty of Joseon Revive Eye Serum Ginseng + Retinal	Augenserum	Ein hochwirksames Augenserum mit Ginseng und Retinal für sichtbar glattere, straffere und strahlendere Augenpartie. Ginseng-Extrakt vitalisiert und stärkt, Retinal unterstützt die Zellerneuerung und mindert feine Linien, intensive Feuchtigkeit bewahrt die Elastizität. Speziell für die empfindliche Augenpartie entwickelt.	Morgens und abends eine kleine Menge sanft um die Augenpartie einklopfen.	Ginseng-Extrakt und Retinal. Vegan, tierversuchsfrei.	783	de	47
Beauty of Joseon Revive Eye Serum Ginseng + Retinal	Sérum contour des yeux	Un sérum contour des yeux très efficace au ginseng et au rétinal pour un regard visiblement plus lisse, plus ferme et plus lumineux. Le ginseng revitalise, le rétinal soutient le renouvellement cellulaire et atténue les ridules, et une hydratation intense préserve la souplesse. Spécialement conçu pour la zone délicate des yeux.	Matin et soir, tapoter délicatement une petite quantité sur le contour des yeux.	Extrait de ginseng et rétinal. Vegan, non testé sur les animaux.	784	fr	47
Beauty of Joseon Revive Eye Serum Ginseng + Retinal	Siero contorno occhi	Un siero contorno occhi molto efficace con ginseng e retinale per uno sguardo visibilmente più liscio, tonico e luminoso. Il ginseng rivitalizza, il retinale sostiene il rinnovamento cellulare e attenua le linee sottili, e un’idratazione intensa preserva l’elasticità. Studiato per la zona delicata degli occhi.	Mattina e sera picchiettare delicatamente una piccola quantità sul contorno occhi.	Estratto di ginseng e retinale. Vegano, cruelty-free.	785	it	47
Beauty of Joseon Revive Eye Serum Ginseng + Retinal	Eye serum	A highly effective eye serum with ginseng and retinal for a visibly smoother, firmer and brighter eye area. Ginseng revitalises and strengthens delicate skin, retinal supports cell renewal and reduces fine lines, and intense moisture keeps the area supple. Gentle enough for sensitive skin.	Morning and evening, tap a small amount gently around the eye area.	Ginseng extract and retinal. Vegan, cruelty-free.	786	en	47
Beauty of Joseon Glow Serum Propolis + Niacinamide	Serum	Strahlende Haut, tiefenwirksam gepflegt. Propolis-Extrakt (60 %) nährt und stärkt die Hautbarriere, Niacinamid verfeinert das Hautbild und sorgt für einen ebenmässigen Teint. Leichte, nicht klebrige Textur, zieht schnell ein und spendet intensive Feuchtigkeit. Für alle Hauttypen, auch für empfindliche Haut.	Nach dem Gesichtswasser 2–3 Tropfen auf das Gesicht geben und vor der Creme einklopfen.	60 % Propolis-Extrakt und Niacinamid. Vegan, tierversuchsfrei.	787	de	48
Beauty of Joseon Glow Serum Propolis + Niacinamide	Sérum	Un sérum éclat à 60 % d’extrait de propolis et niacinamide pour une peau lumineuse et nourrie en profondeur. La propolis nourrit et renforce la barrière cutanée, la niacinamide affine le grain de peau et unifie le teint, et la texture légère pénètre vite. Pour tous les types de peau, même sensibles.	Après la lotion, appliquer 2 à 3 gouttes sur le visage et tapoter avant la crème.	60 % d’extrait de propolis et niacinamide. Vegan, non testé sur les animaux.	788	fr	48
Beauty of Joseon Glow Serum Propolis + Niacinamide	Siero	Un siero illuminante con il 60 % di estratto di propoli e niacinamide per una pelle luminosa e nutrita in profondità. La propoli nutre e rafforza la barriera cutanea, la niacinamide affina la grana e uniforma l’incarnato, e la texture leggera si assorbe in fretta. Per tutti i tipi di pelle, anche sensibili.	Dopo il tonico applicare 2–3 gocce sul viso e picchiettare prima della crema.	60 % di estratto di propoli e niacinamide. Vegano, cruelty-free.	789	it	48
Beauty of Joseon Glow Serum Propolis + Niacinamide	Serum	A glow serum with 60 % propolis extract and niacinamide for radiant, deeply cared-for skin. Propolis nourishes and strengthens the skin barrier, niacinamide refines the complexion and evens the skin tone, and the light texture absorbs quickly. Suitable for all skin types, including sensitive skin.	After toner, apply 2–3 drops to the face and pat in before your cream.	60 % propolis extract and niacinamide. Vegan, cruelty-free.	790	en	48
Torriden Dive-In Serum	Serum	Intensive Feuchtigkeit für pralle, gesunde Haut. Das DIVE IN Serum mit niedermolekularer Hyaluronsäure spendet tiefenwirksam Feuchtigkeit, beruhigt die Haut und stärkt die natürliche Hautbarriere. Leichte, nicht klebrige Textur – perfekt für jeden Hauttyp, auch für empfindliche Haut.	Nach dem Gesichtswasser 2–3 Tropfen auf das Gesicht geben und vor der Creme einklopfen.	Niedermolekulare Hyaluronsäure. Frei von Parabenen, Mineralölen und Alkohol. Tierversuchsfrei.	791	de	49
Torriden Dive-In Serum	Sérum	Un sérum hydratant à l’acide hyaluronique de faible poids moléculaire pour une peau repulpée et saine. Il pénètre en profondeur pour une hydratation durable, renforce la barrière cutanée et laisse un fini frais et non collant. Assez doux pour les peaux sensibles et tous les types de peau.	Après la lotion, appliquer 2 à 3 gouttes sur le visage et tapoter avant la crème.	Acide hyaluronique de faible poids moléculaire. Sans parabènes, huiles minérales ni alcool. Non testé sur les animaux.	792	fr	49
Torriden Dive-In Serum	Siero	Un siero idratante con acido ialuronico a basso peso molecolare per una pelle rimpolpata e sana. Penetra in profondità per un’idratazione duratura, rafforza la barriera cutanea e lascia un finish fresco e non appiccicoso. Delicato per pelli sensibili e tutti i tipi di pelle.	Dopo il tonico applicare 2–3 gocce sul viso e picchiettare prima della crema.	Acido ialuronico a basso peso molecolare. Senza parabeni, oli minerali e alcol. Cruelty-free.	793	it	49
Torriden Dive-In Serum	Serum	A hydrating serum with low-molecular hyaluronic acid for plump, healthy-looking skin. It penetrates deeply for long-lasting moisture, strengthens the skin barrier and leaves a refreshing, non-sticky finish. Mild enough for sensitive skin and for all skin types.	After toner, apply 2–3 drops to the face and pat in before your cream.	Low-molecular hyaluronic acid. Free from parabens, mineral oils and alcohol. Cruelty-free.	794	en	49
Anua 100+ Hyaluron Serum	Serum	Intensive Feuchtigkeit für pralle, gesunde Haut. Mit 10 Arten von Hyaluronsäure für maximale Feuchtigkeitsversorgung: polstert auf und glättet feine Linien, stärkt die Hautbarriere und zieht schnell ein – perfekt für die tägliche Pflege, auch unter Make-up. Für alle Hauttypen.	Nach dem Gesichtswasser 2–3 Tropfen auf das Gesicht geben und vor der Creme einklopfen.	10 Arten von Hyaluronsäure, darunter FORN-Hyaluronsäure-Kapseln.	795	de	50
Anua 100+ Hyaluron Serum	Sérum	Un sérum hydratant intensif à 10 types d’acide hyaluronique pour une peau repulpée et éclatante. Il hydrate durablement, lisse les ridules, renforce la barrière cutanée et pénètre vite, idéal au quotidien et sous le maquillage. Pour tous les types de peau.	Après la lotion, appliquer 2 à 3 gouttes sur le visage et tapoter avant la crème.	10 types d’acide hyaluronique, dont des capsules d’acide hyaluronique FORN.	796	fr	50
Anua 100+ Hyaluron Serum	Siero	Un siero idratante intensivo con 10 tipi di acido ialuronico per una pelle rimpolpata e luminosa. Idrata a lungo, leviga le linee sottili, rafforza la barriera cutanea e si assorbe in fretta, perfetto ogni giorno e sotto il trucco. Per tutti i tipi di pelle.	Dopo il tonico applicare 2–3 gocce sul viso e picchiettare prima della crema.	10 tipi di acido ialuronico, tra cui capsule di acido ialuronico FORN.	797	it	50
Anua 100+ Hyaluron Serum	Serum	An intensive hydrating serum with 10 types of hyaluronic acid for plump, glowing skin. It gives long-lasting moisture, smooths fine lines, strengthens the skin barrier and absorbs quickly, perfect for daily care and under make-up. Suitable for all skin types.	After toner, apply 2–3 drops to the face and pat in before your cream.	10 types of hyaluronic acid, including FORN hyaluronic acid capsules.	798	en	50
Medicube PDRN Pink Peptide Serum	Serum	Für strahlende, glatte und gesunde Haut. PDRN fördert die Hauterneuerung und unterstützt die Heilung, Peptide verbessern die Hautstruktur und sorgen für mehr Spannkraft, tiefenwirksame Feuchtigkeit verleiht einen natürlichen Glow. Dermatologisch getestet und für alle Hauttypen geeignet.	Nach dem Gesichtswasser 2–3 Tropfen auf das Gesicht geben und vor der Creme einklopfen.	PDRN (Natrium-DNA) und ein Komplex aus 5 Peptiden. Vegan, frei von Parabenen und künstlichen Farbstoffen. Hergestellt in Korea.	799	de	51
Medicube PDRN Pink Peptide Serum	Sérum	Un sérum régénérant au PDRN et aux peptides pour une peau lumineuse, lisse et saine. Le PDRN soutient le renouvellement et la réparation de la peau, les peptides améliorent élasticité et fermeté, et une hydratation profonde apporte un éclat naturel. Testé dermatologiquement, pour tous les types de peau.	Après la lotion, appliquer 2 à 3 gouttes sur le visage et tapoter avant la crème.	PDRN (ADN de sodium) et complexe de 5 peptides. Vegan, sans parabènes ni colorants artificiels. Fabriqué en Corée.	800	fr	51
Medicube PDRN Pink Peptide Serum	Siero	Un siero rigenerante con PDRN e peptidi per una pelle luminosa, liscia e sana. Il PDRN sostiene il rinnovamento e la riparazione della pelle, i peptidi migliorano elasticità e tonicità e un’idratazione profonda dona un glow naturale. Dermatologicamente testato, per tutti i tipi di pelle.	Dopo il tonico applicare 2–3 gocce sul viso e picchiettare prima della crema.	PDRN (DNA di sodio) e complesso di 5 peptidi. Vegano, senza parabeni e coloranti artificiali. Prodotto in Corea.	801	it	51
Medicube PDRN Pink Peptide Serum	Serum	A regenerating serum with PDRN and peptides for radiant, smooth and healthy-looking skin. PDRN supports skin renewal and recovery, peptides improve elasticity and firmness, and deep hydration leaves a fresh, natural glow. Dermatologically tested and suitable for all skin types.	After toner, apply 2–3 drops to the face and pat in before your cream.	PDRN (sodium DNA) and a 5-type peptide complex. Vegan, free from parabens and artificial colours. Made in Korea.	802	en	51
Laneige Water Sleeping Mask	Schlafmaske	Über Nacht zu strahlender, hydratisierter Haut. Versorgt die Haut über Nacht intensiv mit Feuchtigkeit, für einen frischen, strahlenden Teint am Morgen, verbessert die Hautstruktur und macht sie zart und geschmeidig. Leichte Gel-Textur, zieht schnell ein. Dermatologisch getestet, für alle Hauttypen.	Als letzten Schritt der Abendroutine dünn auftragen und über Nacht einwirken lassen. Am Morgen abwaschen.	\N	803	de	53
Laneige Water Sleeping Mask	Masque de nuit	Un masque de nuit pour une peau lumineuse et hydratée au réveil. Il hydrate intensément pendant le sommeil, apporte un éclat frais et une peau plus lisse et plus douce, avec une texture gel légère qui pénètre vite. Testé dermatologiquement, pour tous les types de peau.	En dernière étape de la routine du soir, appliquer une fine couche et laisser agir toute la nuit. Rincer le matin.	\N	804	fr	53
Laneige Water Sleeping Mask	Maschera notte	Una maschera notte per una pelle luminosa e idratata al risveglio. Idrata intensamente durante il sonno, dona un glow fresco e una pelle più liscia e morbida, con una texture in gel leggera che si assorbe in fretta. Dermatologicamente testata, per tutti i tipi di pelle.	Come ultimo passaggio della routine serale applicare uno strato sottile e lasciare agire tutta la notte. Risciacquare al mattino.	\N	805	it	53
Laneige Water Sleeping Mask	Overnight mask	An overnight mask for radiant, hydrated skin by morning. It moisturises intensively while you sleep, leaves a fresh glow and smoother, softer skin, with a light gel texture that absorbs quickly. Dermatologically tested and suitable for all skin types.	As the last step of your evening routine, apply a thin layer and leave on overnight. Rinse in the morning.	\N	806	en	53
Merikit Regenerating Calming Mask	Beruhigende Maske	Regeneration. Beruhigung. Balance. Die Maske hilft, Rötungen zu reduzieren und die Haut spürbar zu beruhigen, spendet intensiv Feuchtigkeit, unterstützt die natürliche Regeneration und stärkt die Haut. Hochwertige Inhaltsstoffe aus Natur und Wissenschaft – für alle Hauttypen, auch für empfindliche Haut.	Grosszügig auf die gereinigte Haut auftragen, 10–15 Minuten einwirken lassen und abspülen. 2–3 Mal pro Woche.	\N	807	de	54
Merikit Regenerating Calming Mask	Masque apaisant	Un masque apaisant et régénérant pour une peau saine et lumineuse. Il calme irritations et rougeurs, hydrate intensément, soutient la régénération naturelle et renforce la peau. Des ingrédients de qualité, entre nature et science, pour tous les types de peau, même sensibles.	Appliquer une couche généreuse sur peau propre, laisser poser 10 à 15 minutes puis rincer. 2 à 3 fois par semaine.	\N	808	fr	54
Merikit Regenerating Calming Mask	Maschera lenitiva	Una maschera lenitiva e rigenerante per una pelle sana e luminosa. Calma irritazioni e rossori, idrata intensamente, sostiene la rigenerazione naturale e rinforza la pelle. Ingredienti di qualità tra natura e scienza, per tutti i tipi di pelle, anche sensibili.	Applicare uno strato generoso sulla pelle pulita, lasciare in posa 10–15 minuti e risciacquare. 2–3 volte a settimana.	\N	809	it	54
Merikit Regenerating Calming Mask	Calming mask	A regenerating calming mask for healthy, radiant skin. It soothes irritation and redness, gives intense moisture, supports the skin’s natural regeneration and strengthens it. High-quality ingredients from nature and science, suitable for all skin types, including sensitive skin.	Apply a generous layer to clean skin, leave on for 10–15 minutes and rinse. Use 2–3 times a week.	\N	810	en	54
Torriden Balanceful Cica Mask	Tuchmaske, 1 Stück	Eine beruhigende Tuchmaske mit Cica, die die Haut besänftigt und ins Gleichgewicht bringt. Ideal nach einem langen Tag oder wenn die Haut gestresst und gereizt ist. Für alle Hauttypen.	Nach dem Gesichtswasser 15–20 Minuten auf das Gesicht legen, abnehmen und die restliche Essenz einklopfen.	\N	811	de	55
Torriden Balanceful Cica Mask	Masque en tissu, 1 pièce	Un masque en tissu apaisant à la cica qui calme et rééquilibre la peau. Idéal après une longue journée ou quand la peau est stressée et irritée. Pour tous les types de peau.	Après la lotion, poser le masque 15 à 20 minutes, le retirer et faire pénétrer l’essence restante.	\N	812	fr	55
Torriden Balanceful Cica Mask	Maschera in tessuto, 1 pezzo	Una maschera in tessuto lenitiva alla cica che calma e riequilibra la pelle. Ideale dopo una lunga giornata o quando la pelle è stressata e irritata. Per tutti i tipi di pelle.	Dopo il tonico applicare la maschera per 15–20 minuti, rimuoverla e picchiettare l’essenza rimasta.	\N	813	it	55
Torriden Balanceful Cica Mask	Sheet mask, 1 piece	A soothing sheet mask with cica that calms and balances the skin. Ideal after a long day or when skin feels stressed and irritated. Suitable for all skin types.	After toner, place the mask on the face for 15–20 minutes, remove and pat the remaining essence into the skin.	\N	814	en	55
Mediheal Collagen Mask	Tuchmaske, 1 Stück	Eine Tuchmaske mit Kollagen, die Feuchtigkeit spendet und die Elastizität der Haut verbessert. Für trockene oder müde Haut, die etwas mehr Spannkraft gebrauchen kann. Für alle Hauttypen.	Nach dem Gesichtswasser 15–20 Minuten auf das Gesicht legen, abnehmen und die restliche Essenz einklopfen.	\N	815	de	56
Mediheal Collagen Mask	Masque en tissu, 1 pièce	Un masque en tissu au collagène qui hydrate et améliore l’élasticité de la peau. Pour les peaux sèches ou fatiguées qui ont besoin de rebond. Pour tous les types de peau.	Après la lotion, poser le masque 15 à 20 minutes, le retirer et faire pénétrer l’essence restante.	\N	816	fr	56
Mediheal Collagen Mask	Maschera in tessuto, 1 pezzo	Una maschera in tessuto al collagene che idrata e migliora l’elasticità della pelle. Per pelli secche o stanche che hanno bisogno di più tono. Per tutti i tipi di pelle.	Dopo il tonico applicare la maschera per 15–20 minuti, rimuoverla e picchiettare l’essenza rimasta.	\N	817	it	56
Mediheal Collagen Mask	Sheet mask, 1 piece	A sheet mask with collagen that hydrates and improves skin elasticity. For skin that feels dry or tired and could use some extra bounce. Suitable for all skin types.	After toner, place the mask on the face for 15–20 minutes, remove and pat the remaining essence into the skin.	\N	818	en	56
Abib Gummy Sheet Mask Heartleaf Sticker	Tuchmaske, 1 Stück	Eine beruhigende Gummy-Tuchmaske mit Herzblatt, die empfindliche Haut besänftigt. Das weiche, haftende Tuch liegt eng an der Haut an. Ideal für empfindliche und gereizte Haut.	Nach dem Gesichtswasser 15–20 Minuten auf das Gesicht legen, abnehmen und die restliche Essenz einklopfen.	\N	819	de	57
Abib Gummy Sheet Mask Heartleaf Sticker	Masque en tissu, 1 pièce	Un masque gummy apaisant au houttuynia qui calme les peaux sensibles. Le tissu doux et adhérent épouse parfaitement la peau. Idéal pour les peaux sensibles et irritées.	Après la lotion, poser le masque 15 à 20 minutes, le retirer et faire pénétrer l’essence restante.	\N	820	fr	57
Abib Gummy Sheet Mask Heartleaf Sticker	Maschera in tessuto, 1 pezzo	Una maschera gummy lenitiva all’houttuynia che calma le pelli sensibili. Il tessuto morbido e aderente si adatta perfettamente alla pelle. Ideale per pelli sensibili e irritate.	Dopo il tonico applicare la maschera per 15–20 minuti, rimuoverla e picchiettare l’essenza rimasta.	\N	821	it	57
Abib Gummy Sheet Mask Heartleaf Sticker	Sheet mask, 1 piece	A soothing gummy sheet mask with heartleaf that calms sensitive skin. The soft, adhering sheet sits close to the skin for a comfortable treatment. Ideal for sensitive and irritated skin.	After toner, place the mask on the face for 15–20 minutes, remove and pat the remaining essence into the skin.	\N	822	en	57
Mediheal Vitamin C Mask	Tuchmaske, 1 Stück	Eine Tuchmaske mit Vitamin C, die die Haut belebt und für einen strahlenderen Teint sorgt. Perfekt, wenn die Haut fahl oder müde aussieht. Für alle Hauttypen.	Nach dem Gesichtswasser 15–20 Minuten auf das Gesicht legen, abnehmen und die restliche Essenz einklopfen.	\N	823	de	58
Mediheal Vitamin C Mask	Masque en tissu, 1 pièce	Un masque en tissu à la vitamine C qui revitalise la peau pour un teint plus lumineux. Parfait quand le teint est terne ou fatigué. Pour tous les types de peau.	Après la lotion, poser le masque 15 à 20 minutes, le retirer et faire pénétrer l’essence restante.	\N	824	fr	58
Mediheal Vitamin C Mask	Maschera in tessuto, 1 pezzo	Una maschera in tessuto alla vitamina C che rivitalizza la pelle per un incarnato più luminoso. Perfetta quando la pelle appare spenta o stanca. Per tutti i tipi di pelle.	Dopo il tonico applicare la maschera per 15–20 minuti, rimuoverla e picchiettare l’essenza rimasta.	\N	825	it	58
Mediheal Vitamin C Mask	Sheet mask, 1 piece	A brightening sheet mask with vitamin C that revitalises the skin for a more luminous complexion. Perfect when skin looks dull or tired. Suitable for all skin types.	After toner, place the mask on the face for 15–20 minutes, remove and pat the remaining essence into the skin.	\N	826	en	58
Torriden Solid-In Lip Essence	Lippenessenz	Intensive Pflege für zarte Lippen. Reichhaltige Essenz für geschmeidige, gepflegte und gesunde Lippen: spendet langanhaltend Feuchtigkeit, schützt vor dem Austrocknen und stärkt die natürliche Lippenbarriere. Milde, vegane Formel, praktisch und kompakt für unterwegs.	Bei Bedarf auf die Lippen auftragen. Praktisch für unterwegs.	\N	827	de	59
Torriden Solid-In Lip Essence	Essence pour les lèvres	Une essence riche pour des lèvres douces, soignées et en bonne santé. Elle hydrate durablement et protège du dessèchement, lisse et adoucit les lèvres et renforce leur barrière naturelle. Formule douce et vegan, dans un tube pratique à emporter.	Appliquer sur les lèvres dès qu’elles tiraillent. Pratique à emporter.	\N	828	fr	59
Torriden Solid-In Lip Essence	Essenza labbra	Un’essenza ricca per labbra morbide, curate e sane. Idrata a lungo e protegge dalla secchezza, leviga e ammorbidisce le labbra e ne rafforza la barriera naturale. Formula delicata e vegana, in un pratico tubetto da portare con sé.	Applicare sulle labbra quando serve. Comoda da portare con sé.	\N	829	it	59
Torriden Solid-In Lip Essence	Lip essence	A rich lip essence for soft, cared-for and healthy lips. It gives long-lasting moisture and protects against drying out, smooths and softens the lips and strengthens their natural barrier. Mild, vegan formula in a handy tube for on the go.	Apply to the lips whenever they feel dry. Handy for on the go.	\N	830	en	59
Laneige Lip Sleeping Mask Peach Iced Tea	Lippen-Schlafmaske	Die beliebte Lippenmaske von LANEIGE mit fruchtigem Pfirsich-Eistee-Duft. Spendet langanhaltende Feuchtigkeit, beugt trockenen Lippen vor und unterstützt über Nacht die natürliche Regeneration – für sichtbar weichere, glattere und gesünder aussehende Lippen am Morgen.	Vor dem Schlafengehen grosszügig auftragen und über Nacht einwirken lassen. Auch tagsüber verwendbar.	\N	831	de	60
Laneige Lip Sleeping Mask Peach Iced Tea	Masque de nuit pour les lèvres	Le masque de nuit pour les lèvres culte de Laneige, au parfum fruité de thé glacé à la pêche. Il hydrate intensément et durablement, soutient la régénération naturelle des lèvres pendant le sommeil et les laisse visiblement plus douces et plus lisses au réveil.	Appliquer une couche généreuse avant le coucher et laisser agir toute la nuit. Utilisable aussi en journée.	\N	832	fr	60
Laneige Lip Sleeping Mask Peach Iced Tea	Maschera notte labbra	L’amatissima maschera notte per le labbra di Laneige, con un profumo fruttato di tè freddo alla pesca. Idrata intensamente e a lungo, sostiene la rigenerazione naturale delle labbra durante il sonno e le lascia visibilmente più morbide e lisce al risveglio.	Applicare uno strato generoso prima di dormire e lasciare agire tutta la notte. Utilizzabile anche di giorno.	\N	833	it	60
Laneige Lip Sleeping Mask Peach Iced Tea	Lip sleeping mask	The much-loved overnight lip mask from Laneige with a fruity peach iced tea scent. It gives intense, long-lasting moisture, supports the lips’ natural regeneration while you sleep, and leaves them visibly softer and smoother by morning.	Apply a generous layer before bed and leave on overnight. Can also be used during the day.	\N	834	en	60
Round Lab Dokdo Hydration Routine	Routine-Set	Eine dreistufige Feuchtigkeitsroutine für hydratisierte, beruhigte und geschützte Haut – jeden Tag. Enthält Round Lab Dokdo 1025 Toner (tiefenwirksame Feuchtigkeit), Birch Juice Moisturizing Sun Cream (Feuchtigkeit und UV-Schutz) und Dokdo 1025 Mist Toner (erfrischt jederzeit). Sanfte Formeln für alle Hauttypen.	1. Toner nach der Reinigung. 2. Sonnencreme als letzter Schritt am Morgen. 3. Mist jederzeit zur Erfrischung, auch über dem Make-up.	\N	835	de	61
Round Lab Dokdo Hydration Routine	Coffret routine	Une routine hydratation en trois étapes pour une peau hydratée, apaisée et protégée au quotidien. Comprend Round Lab Dokdo 1025 Toner (hydratation profonde), Birch Juice Moisturizing Sun Cream (hydratation et protection UV) et Dokdo 1025 Mist Toner (rafraîchit à tout moment). Formules douces pour tous les types de peau.	1. Lotion après le nettoyage. 2. Crème solaire en dernière étape le matin. 3. Brume à tout moment pour rafraîchir, même sur le maquillage.	\N	836	fr	61
Round Lab Dokdo Hydration Routine	Set routine	Una routine idratante in tre passaggi per una pelle idratata, calma e protetta ogni giorno. Include Round Lab Dokdo 1025 Toner (idratazione profonda), Birch Juice Moisturizing Sun Cream (idratazione e protezione UV) e Dokdo 1025 Mist Toner (rinfresca in ogni momento). Formule delicate per tutti i tipi di pelle.	1. Tonico dopo la detersione. 2. Crema solare come ultimo passaggio al mattino. 3. Mist in qualsiasi momento per rinfrescare, anche sopra il trucco.	\N	837	it	61
Round Lab Dokdo Hydration Routine	Routine set	A three-step hydration routine for skin that’s moisturised, calm and protected every day. Includes Round Lab Dokdo 1025 Toner (deep hydration), Birch Juice Moisturizing Sun Cream (moisture and UV protection) and Dokdo 1025 Mist Toner (refreshes any time). Gentle formulas for all skin types.	1. Toner after cleansing. 2. Sun cream as the last step in the morning. 3. Mist whenever skin needs a refresh, also over make-up.	\N	838	en	61
Korean Routine Set: Clear, Hydrated & Protected	Routine-Set	Eine komplette koreanische Routine: reinigen, beruhigen, hydratisieren und schützen. Enthält Lagom Cellup Micro Foam Cleanser, Anua Toner-Pads, Manyo Pure Soybean Cleansing Oil und Mediheal Madecassoside Moisture Sun Serum. Sanfte Formeln für alle Hauttypen, auch für empfindliche Haut.	Abends: Reinigungsöl, danach Schaumreiniger, dann ein Toner-Pad. Morgens: Schaumreiniger, Toner-Pad und als letzten Schritt das Sonnenserum.	\N	839	de	62
Korean Routine Set: Clear, Hydrated & Protected	Coffret routine	Une routine coréenne complète pour nettoyer, apaiser, hydrater et protéger. Comprend Lagom Cellup Micro Foam Cleanser, les disques tonifiants Anua, Manyo Pure Soybean Cleansing Oil et Mediheal Madecassoside Moisture Sun Serum. Formules douces pour tous les types de peau, même sensibles.	Le soir : huile démaquillante, puis mousse nettoyante, puis un disque tonifiant. Le matin : mousse nettoyante, disque tonifiant et le sérum solaire en dernière étape.	\N	840	fr	62
Korean Routine Set: Clear, Hydrated & Protected	Set routine	Una routine coreana completa per detergere, lenire, idratare e proteggere. Include Lagom Cellup Micro Foam Cleanser, i dischetti tonificanti Anua, Manyo Pure Soybean Cleansing Oil e Mediheal Madecassoside Moisture Sun Serum. Formule delicate per tutti i tipi di pelle, anche sensibili.	La sera: olio detergente, poi schiuma detergente, poi un dischetto tonificante. Al mattino: schiuma detergente, dischetto e il siero solare come ultimo passaggio.	\N	841	it	62
Korean Routine Set: Clear, Hydrated & Protected	Routine set	A complete Korean routine to cleanse, soothe, hydrate and protect. Includes Lagom Cellup Micro Foam Cleanser, Anua toner pads, Manyo Pure Soybean Cleansing Oil and Mediheal Madecassoside Moisture Sun Serum. Gentle formulas for all skin types, including sensitive skin.	Evening: cleansing oil, then foam cleanser, then a toner pad. Morning: foam cleanser, toner pad and the sun serum as the last step.	\N	842	en	62
Korean Skincare Set: Glow & Gentle	Routine-Set	Eine Routine für Glow und sanfte Pflege in vier Schritten. Enthält eine Sonnencreme SPF 50+ PA++++, Bringgreen Tea Tree Cica Soothing Toner, ein aufhellendes Peeling-Gel und Aromatica Rosemary 3-in-1 Treatment für die Haare. Sanfte, cleane Formeln, auch für empfindliche Haut.	Toner nach der Reinigung, Sonnencreme jeden Morgen, Peeling-Gel 1–2 Mal pro Woche auf sauberer, trockener Haut, Rosmarin-Treatment nach dem Shampoo.	\N	843	de	63
Korean Skincare Set: Glow & Gentle	Coffret routine	Une routine éclat et douceur en quatre étapes. Comprend une crème solaire SPF 50+ PA++++, Bringgreen Tea Tree Cica Soothing Toner, un gel peeling éclat et Aromatica Rosemary 3-in-1 Treatment pour les cheveux. Formules douces et clean, adaptées aux peaux sensibles.	Lotion après le nettoyage, crème solaire chaque matin, gel peeling 1 à 2 fois par semaine sur peau propre et sèche, soin au romarin après le shampooing.	\N	844	fr	63
Korean Skincare Set: Glow & Gentle	Set routine	Una routine glow e delicatezza in quattro passaggi. Include una crema solare SPF 50+ PA++++, Bringgreen Tea Tree Cica Soothing Toner, un gel peeling illuminante e Aromatica Rosemary 3-in-1 Treatment per i capelli. Formule delicate e clean, adatte alle pelli sensibili.	Tonico dopo la detersione, crema solare ogni mattina, gel peeling 1–2 volte a settimana su pelle pulita e asciutta, trattamento al rosmarino dopo lo shampoo.	\N	845	it	63
Korean Skincare Set: Glow & Gentle	Routine set	A glow and gentle-care routine with four steps. Includes an SPF 50+ PA++++ sun cream, Bringgreen Tea Tree Cica Soothing Toner, a brightening peeling gel and Aromatica Rosemary 3-in-1 Treatment for hair. Gentle, clean formulas suitable for sensitive skin.	Toner after cleansing, sun cream every morning, peeling gel 1–2 times a week on clean, dry skin, rosemary treatment after shampooing.	\N	846	en	63
\.


--
-- Data for Name: products_rels; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.products_rels (id, "order", parent_id, path, variant_types_id, categories_id, products_id) FROM stdin;
540	1	43	categories	\N	2	\N
541	1	43	relatedProducts	\N	\N	42
542	2	43	relatedProducts	\N	\N	44
543	3	43	relatedProducts	\N	\N	45
295	1	52	categories	\N	5	\N
340	1	19	categories	\N	8	\N
341	1	19	relatedProducts	\N	\N	20
342	2	19	relatedProducts	\N	\N	21
343	3	19	relatedProducts	\N	\N	22
344	4	19	relatedProducts	\N	\N	23
345	1	20	categories	\N	8	\N
346	1	20	relatedProducts	\N	\N	19
347	2	20	relatedProducts	\N	\N	21
348	3	20	relatedProducts	\N	\N	22
349	4	20	relatedProducts	\N	\N	23
350	1	21	categories	\N	8	\N
351	1	21	relatedProducts	\N	\N	19
352	2	21	relatedProducts	\N	\N	20
353	3	21	relatedProducts	\N	\N	22
354	4	21	relatedProducts	\N	\N	23
355	1	22	categories	\N	8	\N
356	1	22	relatedProducts	\N	\N	19
357	2	22	relatedProducts	\N	\N	20
358	3	22	relatedProducts	\N	\N	21
359	4	22	relatedProducts	\N	\N	23
360	1	23	categories	\N	8	\N
361	1	23	relatedProducts	\N	\N	19
362	2	23	relatedProducts	\N	\N	20
363	3	23	relatedProducts	\N	\N	21
364	4	23	relatedProducts	\N	\N	22
365	1	24	categories	\N	8	\N
366	1	24	relatedProducts	\N	\N	19
367	2	24	relatedProducts	\N	\N	20
368	3	24	relatedProducts	\N	\N	21
369	4	24	relatedProducts	\N	\N	22
370	1	25	categories	\N	8	\N
371	1	25	relatedProducts	\N	\N	19
372	2	25	relatedProducts	\N	\N	20
373	3	25	relatedProducts	\N	\N	21
374	4	25	relatedProducts	\N	\N	22
375	1	26	categories	\N	8	\N
376	1	26	relatedProducts	\N	\N	19
377	2	26	relatedProducts	\N	\N	20
378	3	26	relatedProducts	\N	\N	21
379	4	26	relatedProducts	\N	\N	22
380	1	27	categories	\N	9	\N
381	1	27	relatedProducts	\N	\N	28
382	2	27	relatedProducts	\N	\N	29
383	3	27	relatedProducts	\N	\N	30
384	1	28	categories	\N	9	\N
385	1	28	relatedProducts	\N	\N	27
386	2	28	relatedProducts	\N	\N	29
387	3	28	relatedProducts	\N	\N	30
388	1	29	categories	\N	9	\N
389	1	29	relatedProducts	\N	\N	27
390	2	29	relatedProducts	\N	\N	28
391	3	29	relatedProducts	\N	\N	30
392	1	30	categories	\N	9	\N
393	1	30	relatedProducts	\N	\N	27
394	2	30	relatedProducts	\N	\N	28
395	3	30	relatedProducts	\N	\N	29
396	1	31	categories	\N	4	\N
397	1	31	relatedProducts	\N	\N	32
398	2	31	relatedProducts	\N	\N	33
399	3	31	relatedProducts	\N	\N	34
400	4	31	relatedProducts	\N	\N	35
401	1	32	categories	\N	4	\N
402	1	32	relatedProducts	\N	\N	31
403	2	32	relatedProducts	\N	\N	33
404	3	32	relatedProducts	\N	\N	34
405	4	32	relatedProducts	\N	\N	35
406	1	33	categories	\N	4	\N
407	1	33	relatedProducts	\N	\N	31
408	2	33	relatedProducts	\N	\N	32
409	3	33	relatedProducts	\N	\N	34
410	4	33	relatedProducts	\N	\N	35
411	1	34	categories	\N	4	\N
412	1	34	relatedProducts	\N	\N	31
413	2	34	relatedProducts	\N	\N	32
414	3	34	relatedProducts	\N	\N	33
415	4	34	relatedProducts	\N	\N	35
416	1	35	categories	\N	4	\N
417	1	35	relatedProducts	\N	\N	31
418	2	35	relatedProducts	\N	\N	32
419	3	35	relatedProducts	\N	\N	33
420	4	35	relatedProducts	\N	\N	34
421	1	36	categories	\N	1	\N
422	1	36	relatedProducts	\N	\N	37
423	2	36	relatedProducts	\N	\N	38
424	3	36	relatedProducts	\N	\N	39
425	4	36	relatedProducts	\N	\N	40
426	1	37	categories	\N	1	\N
427	1	37	relatedProducts	\N	\N	36
428	2	37	relatedProducts	\N	\N	38
429	3	37	relatedProducts	\N	\N	39
430	4	37	relatedProducts	\N	\N	40
431	1	38	categories	\N	1	\N
432	1	38	relatedProducts	\N	\N	36
433	2	38	relatedProducts	\N	\N	37
434	3	38	relatedProducts	\N	\N	39
435	4	38	relatedProducts	\N	\N	40
436	1	39	categories	\N	1	\N
437	1	39	relatedProducts	\N	\N	36
438	2	39	relatedProducts	\N	\N	37
439	3	39	relatedProducts	\N	\N	38
440	4	39	relatedProducts	\N	\N	40
441	1	40	categories	\N	1	\N
442	1	40	relatedProducts	\N	\N	36
443	2	40	relatedProducts	\N	\N	37
444	3	40	relatedProducts	\N	\N	38
445	4	40	relatedProducts	\N	\N	39
446	1	41	categories	\N	1	\N
447	1	41	relatedProducts	\N	\N	36
448	2	41	relatedProducts	\N	\N	37
449	3	41	relatedProducts	\N	\N	38
450	4	41	relatedProducts	\N	\N	39
451	1	42	categories	\N	2	\N
452	1	42	relatedProducts	\N	\N	43
453	2	42	relatedProducts	\N	\N	44
454	3	42	relatedProducts	\N	\N	45
459	1	44	categories	\N	2	\N
460	1	44	relatedProducts	\N	\N	42
461	2	44	relatedProducts	\N	\N	43
462	3	44	relatedProducts	\N	\N	45
463	1	45	categories	\N	2	\N
464	1	45	relatedProducts	\N	\N	42
465	2	45	relatedProducts	\N	\N	43
466	3	45	relatedProducts	\N	\N	44
467	1	46	categories	\N	3	\N
468	1	46	relatedProducts	\N	\N	47
469	2	46	relatedProducts	\N	\N	48
470	3	46	relatedProducts	\N	\N	49
471	4	46	relatedProducts	\N	\N	50
472	1	47	categories	\N	3	\N
473	1	47	relatedProducts	\N	\N	46
474	2	47	relatedProducts	\N	\N	48
475	3	47	relatedProducts	\N	\N	49
476	4	47	relatedProducts	\N	\N	50
477	1	48	categories	\N	3	\N
478	1	48	relatedProducts	\N	\N	46
479	2	48	relatedProducts	\N	\N	47
480	3	48	relatedProducts	\N	\N	49
481	4	48	relatedProducts	\N	\N	50
482	1	49	categories	\N	3	\N
483	1	49	relatedProducts	\N	\N	46
484	2	49	relatedProducts	\N	\N	47
485	3	49	relatedProducts	\N	\N	48
486	4	49	relatedProducts	\N	\N	50
487	1	50	categories	\N	3	\N
488	1	50	relatedProducts	\N	\N	46
489	2	50	relatedProducts	\N	\N	47
490	3	50	relatedProducts	\N	\N	48
491	4	50	relatedProducts	\N	\N	49
492	1	51	categories	\N	3	\N
493	1	51	relatedProducts	\N	\N	46
494	2	51	relatedProducts	\N	\N	47
495	3	51	relatedProducts	\N	\N	48
496	4	51	relatedProducts	\N	\N	49
497	1	53	categories	\N	6	\N
498	1	53	relatedProducts	\N	\N	54
499	2	53	relatedProducts	\N	\N	55
500	3	53	relatedProducts	\N	\N	56
501	4	53	relatedProducts	\N	\N	57
502	1	54	categories	\N	6	\N
503	1	54	relatedProducts	\N	\N	53
504	2	54	relatedProducts	\N	\N	55
505	3	54	relatedProducts	\N	\N	56
506	4	54	relatedProducts	\N	\N	57
507	1	55	categories	\N	6	\N
508	1	55	relatedProducts	\N	\N	53
509	2	55	relatedProducts	\N	\N	54
510	3	55	relatedProducts	\N	\N	56
511	4	55	relatedProducts	\N	\N	57
512	1	56	categories	\N	6	\N
513	1	56	relatedProducts	\N	\N	53
514	2	56	relatedProducts	\N	\N	54
515	3	56	relatedProducts	\N	\N	55
516	4	56	relatedProducts	\N	\N	57
517	1	57	categories	\N	6	\N
518	1	57	relatedProducts	\N	\N	53
519	2	57	relatedProducts	\N	\N	54
520	3	57	relatedProducts	\N	\N	55
521	4	57	relatedProducts	\N	\N	56
522	1	58	categories	\N	6	\N
523	1	58	relatedProducts	\N	\N	53
524	2	58	relatedProducts	\N	\N	54
525	3	58	relatedProducts	\N	\N	55
526	4	58	relatedProducts	\N	\N	56
527	1	59	categories	\N	10	\N
528	1	59	relatedProducts	\N	\N	60
529	1	60	categories	\N	10	\N
530	1	60	relatedProducts	\N	\N	59
531	1	61	categories	\N	7	\N
532	1	61	relatedProducts	\N	\N	62
533	2	61	relatedProducts	\N	\N	63
534	1	62	categories	\N	7	\N
535	1	62	relatedProducts	\N	\N	61
536	2	62	relatedProducts	\N	\N	63
537	1	63	categories	\N	7	\N
538	1	63	relatedProducts	\N	\N	61
539	2	63	relatedProducts	\N	\N	62
\.


--
-- Data for Name: variant_options; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.variant_options (id, _variantoptions_options_order, variant_type_id, label, value, updated_at, created_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: variant_types; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.variant_types (id, label, name, updated_at, created_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: variants; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.variants (id, title, product_id, inventory, price_in_c_h_f_enabled, price_in_c_h_f, updated_at, created_at, deleted_at, _status) FROM stdin;
\.


--
-- Data for Name: variants_rels; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.variants_rels (id, "order", parent_id, path, variant_options_id) FROM stdin;
\.


--
-- Name: _products_v_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public._products_v_id_seq', 312, true);


--
-- Name: _products_v_locales_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public._products_v_locales_id_seq', 974, true);


--
-- Name: _products_v_rels_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public._products_v_rels_id_seq', 597, true);


--
-- Name: _products_v_version_gallery_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public._products_v_version_gallery_id_seq', 627, true);


--
-- Name: _variants_v_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public._variants_v_id_seq', 1, false);


--
-- Name: _variants_v_rels_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public._variants_v_rels_id_seq', 1, false);


--
-- Name: addresses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.addresses_id_seq', 1, false);


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.categories_id_seq', 10, true);


--
-- Name: categories_locales_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.categories_locales_id_seq', 184, true);


--
-- Name: home_announcements_locales_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.home_announcements_locales_id_seq', 42, true);


--
-- Name: home_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.home_id_seq', 1, true);


--
-- Name: home_locales_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.home_locales_id_seq', 14, true);


--
-- Name: home_rels_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.home_rels_id_seq', 40, true);


--
-- Name: home_routine_locales_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.home_routine_locales_id_seq', 70, true);


--
-- Name: media_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.media_id_seq', 122, true);


--
-- Name: payload_kv_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.payload_kv_id_seq', 1, false);


--
-- Name: payload_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.payload_migrations_id_seq', 3, true);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.products_id_seq', 63, true);


--
-- Name: products_locales_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.products_locales_id_seq', 850, true);


--
-- Name: products_rels_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.products_rels_id_seq', 543, true);


--
-- Name: variant_options_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.variant_options_id_seq', 1, false);


--
-- Name: variant_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.variant_types_id_seq', 1, false);


--
-- Name: variants_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.variants_id_seq', 1, false);


--
-- Name: variants_rels_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.variants_rels_id_seq', 1, false);


--
-- Name: _products_v_locales _products_v_locales_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._products_v_locales
    ADD CONSTRAINT _products_v_locales_pkey PRIMARY KEY (id);


--
-- Name: _products_v _products_v_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._products_v
    ADD CONSTRAINT _products_v_pkey PRIMARY KEY (id);


--
-- Name: _products_v_rels _products_v_rels_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._products_v_rels
    ADD CONSTRAINT _products_v_rels_pkey PRIMARY KEY (id);


--
-- Name: _products_v_version_gallery _products_v_version_gallery_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._products_v_version_gallery
    ADD CONSTRAINT _products_v_version_gallery_pkey PRIMARY KEY (id);


--
-- Name: _variants_v _variants_v_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._variants_v
    ADD CONSTRAINT _variants_v_pkey PRIMARY KEY (id);


--
-- Name: _variants_v_rels _variants_v_rels_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._variants_v_rels
    ADD CONSTRAINT _variants_v_rels_pkey PRIMARY KEY (id);


--
-- Name: addresses addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.addresses
    ADD CONSTRAINT addresses_pkey PRIMARY KEY (id);


--
-- Name: carts_items carts_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.carts_items
    ADD CONSTRAINT carts_items_pkey PRIMARY KEY (id);


--
-- Name: carts carts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.carts
    ADD CONSTRAINT carts_pkey PRIMARY KEY (id);


--
-- Name: categories_locales categories_locales_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories_locales
    ADD CONSTRAINT categories_locales_pkey PRIMARY KEY (id);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: home_announcements_locales home_announcements_locales_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.home_announcements_locales
    ADD CONSTRAINT home_announcements_locales_pkey PRIMARY KEY (id);


--
-- Name: home_announcements home_announcements_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.home_announcements
    ADD CONSTRAINT home_announcements_pkey PRIMARY KEY (id);


--
-- Name: home_locales home_locales_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.home_locales
    ADD CONSTRAINT home_locales_pkey PRIMARY KEY (id);


--
-- Name: home home_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.home
    ADD CONSTRAINT home_pkey PRIMARY KEY (id);


--
-- Name: home_rels home_rels_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.home_rels
    ADD CONSTRAINT home_rels_pkey PRIMARY KEY (id);


--
-- Name: home_routine_locales home_routine_locales_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.home_routine_locales
    ADD CONSTRAINT home_routine_locales_pkey PRIMARY KEY (id);


--
-- Name: home_routine home_routine_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.home_routine
    ADD CONSTRAINT home_routine_pkey PRIMARY KEY (id);


--
-- Name: media media_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.media
    ADD CONSTRAINT media_pkey PRIMARY KEY (id);


--
-- Name: orders_items orders_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders_items
    ADD CONSTRAINT orders_items_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: orders_rels orders_rels_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders_rels
    ADD CONSTRAINT orders_rels_pkey PRIMARY KEY (id);


--
-- Name: payload_kv payload_kv_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payload_kv
    ADD CONSTRAINT payload_kv_pkey PRIMARY KEY (id);


--
-- Name: payload_locked_documents payload_locked_documents_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payload_locked_documents
    ADD CONSTRAINT payload_locked_documents_pkey PRIMARY KEY (id);


--
-- Name: payload_locked_documents_rels payload_locked_documents_rels_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payload_locked_documents_rels
    ADD CONSTRAINT payload_locked_documents_rels_pkey PRIMARY KEY (id);


--
-- Name: payload_migrations payload_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payload_migrations
    ADD CONSTRAINT payload_migrations_pkey PRIMARY KEY (id);


--
-- Name: payload_preferences payload_preferences_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payload_preferences
    ADD CONSTRAINT payload_preferences_pkey PRIMARY KEY (id);


--
-- Name: payload_preferences_rels payload_preferences_rels_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payload_preferences_rels
    ADD CONSTRAINT payload_preferences_rels_pkey PRIMARY KEY (id);


--
-- Name: products_gallery products_gallery_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products_gallery
    ADD CONSTRAINT products_gallery_pkey PRIMARY KEY (id);


--
-- Name: products_locales products_locales_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products_locales
    ADD CONSTRAINT products_locales_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: products_rels products_rels_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products_rels
    ADD CONSTRAINT products_rels_pkey PRIMARY KEY (id);


--
-- Name: transactions_items transactions_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.transactions_items
    ADD CONSTRAINT transactions_items_pkey PRIMARY KEY (id);


--
-- Name: transactions transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users_roles users_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users_roles
    ADD CONSTRAINT users_roles_pkey PRIMARY KEY (id);


--
-- Name: users_sessions users_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users_sessions
    ADD CONSTRAINT users_sessions_pkey PRIMARY KEY (id);


--
-- Name: variant_options variant_options_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variant_options
    ADD CONSTRAINT variant_options_pkey PRIMARY KEY (id);


--
-- Name: variant_types variant_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variant_types
    ADD CONSTRAINT variant_types_pkey PRIMARY KEY (id);


--
-- Name: variants variants_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variants
    ADD CONSTRAINT variants_pkey PRIMARY KEY (id);


--
-- Name: variants_rels variants_rels_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variants_rels
    ADD CONSTRAINT variants_rels_pkey PRIMARY KEY (id);


--
-- Name: _products_v_autosave_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX _products_v_autosave_idx ON public._products_v USING btree (autosave);


--
-- Name: _products_v_created_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX _products_v_created_at_idx ON public._products_v USING btree (created_at);


--
-- Name: _products_v_latest_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX _products_v_latest_idx ON public._products_v USING btree (latest);


--
-- Name: _products_v_locales_locale_parent_id_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX _products_v_locales_locale_parent_id_unique ON public._products_v_locales USING btree (_locale, _parent_id);


--
-- Name: _products_v_locales_parent_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX _products_v_locales_parent_id_idx ON public._products_v_locales USING btree (_parent_id);


--
-- Name: _products_v_parent_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX _products_v_parent_idx ON public._products_v USING btree (parent_id);


--
-- Name: _products_v_published_locale_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX _products_v_published_locale_idx ON public._products_v USING btree (published_locale);


--
-- Name: _products_v_rels_categories_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX _products_v_rels_categories_id_idx ON public._products_v_rels USING btree (categories_id);


--
-- Name: _products_v_rels_order_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX _products_v_rels_order_idx ON public._products_v_rels USING btree ("order");


--
-- Name: _products_v_rels_parent_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX _products_v_rels_parent_idx ON public._products_v_rels USING btree (parent_id);


--
-- Name: _products_v_rels_path_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX _products_v_rels_path_idx ON public._products_v_rels USING btree (path);


--
-- Name: _products_v_rels_products_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX _products_v_rels_products_id_idx ON public._products_v_rels USING btree (products_id);


--
-- Name: _products_v_rels_variant_types_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX _products_v_rels_variant_types_id_idx ON public._products_v_rels USING btree (variant_types_id);


--
-- Name: _products_v_snapshot_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX _products_v_snapshot_idx ON public._products_v USING btree (snapshot);


--
-- Name: _products_v_updated_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX _products_v_updated_at_idx ON public._products_v USING btree (updated_at);


--
-- Name: _products_v_version_gallery_image_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX _products_v_version_gallery_image_idx ON public._products_v_version_gallery USING btree (image_id);


--
-- Name: _products_v_version_gallery_order_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX _products_v_version_gallery_order_idx ON public._products_v_version_gallery USING btree (_order);


--
-- Name: _products_v_version_gallery_parent_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX _products_v_version_gallery_parent_id_idx ON public._products_v_version_gallery USING btree (_parent_id);


--
-- Name: _products_v_version_version__status_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX _products_v_version_version__status_idx ON public._products_v USING btree (version__status);


--
-- Name: _products_v_version_version_created_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX _products_v_version_version_created_at_idx ON public._products_v USING btree (version_created_at);


--
-- Name: _products_v_version_version_deleted_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX _products_v_version_version_deleted_at_idx ON public._products_v USING btree (version_deleted_at);


--
-- Name: _products_v_version_version_slug_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX _products_v_version_version_slug_idx ON public._products_v USING btree (version_slug);


--
-- Name: _products_v_version_version_updated_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX _products_v_version_version_updated_at_idx ON public._products_v USING btree (version_updated_at);


--
-- Name: _variants_v_autosave_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX _variants_v_autosave_idx ON public._variants_v USING btree (autosave);


--
-- Name: _variants_v_created_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX _variants_v_created_at_idx ON public._variants_v USING btree (created_at);


--
-- Name: _variants_v_latest_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX _variants_v_latest_idx ON public._variants_v USING btree (latest);


--
-- Name: _variants_v_parent_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX _variants_v_parent_idx ON public._variants_v USING btree (parent_id);


--
-- Name: _variants_v_published_locale_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX _variants_v_published_locale_idx ON public._variants_v USING btree (published_locale);


--
-- Name: _variants_v_rels_order_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX _variants_v_rels_order_idx ON public._variants_v_rels USING btree ("order");


--
-- Name: _variants_v_rels_parent_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX _variants_v_rels_parent_idx ON public._variants_v_rels USING btree (parent_id);


--
-- Name: _variants_v_rels_path_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX _variants_v_rels_path_idx ON public._variants_v_rels USING btree (path);


--
-- Name: _variants_v_rels_variant_options_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX _variants_v_rels_variant_options_id_idx ON public._variants_v_rels USING btree (variant_options_id);


--
-- Name: _variants_v_snapshot_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX _variants_v_snapshot_idx ON public._variants_v USING btree (snapshot);


--
-- Name: _variants_v_updated_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX _variants_v_updated_at_idx ON public._variants_v USING btree (updated_at);


--
-- Name: _variants_v_version_version__status_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX _variants_v_version_version__status_idx ON public._variants_v USING btree (version__status);


--
-- Name: _variants_v_version_version_created_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX _variants_v_version_version_created_at_idx ON public._variants_v USING btree (version_created_at);


--
-- Name: _variants_v_version_version_deleted_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX _variants_v_version_version_deleted_at_idx ON public._variants_v USING btree (version_deleted_at);


--
-- Name: _variants_v_version_version_product_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX _variants_v_version_version_product_idx ON public._variants_v USING btree (version_product_id);


--
-- Name: _variants_v_version_version_updated_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX _variants_v_version_version_updated_at_idx ON public._variants_v USING btree (version_updated_at);


--
-- Name: addresses_created_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX addresses_created_at_idx ON public.addresses USING btree (created_at);


--
-- Name: addresses_customer_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX addresses_customer_idx ON public.addresses USING btree (customer_id);


--
-- Name: addresses_updated_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX addresses_updated_at_idx ON public.addresses USING btree (updated_at);


--
-- Name: carts_created_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX carts_created_at_idx ON public.carts USING btree (created_at);


--
-- Name: carts_customer_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX carts_customer_idx ON public.carts USING btree (customer_id);


--
-- Name: carts_items_order_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX carts_items_order_idx ON public.carts_items USING btree (_order);


--
-- Name: carts_items_parent_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX carts_items_parent_id_idx ON public.carts_items USING btree (_parent_id);


--
-- Name: carts_items_product_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX carts_items_product_idx ON public.carts_items USING btree (product_id);


--
-- Name: carts_items_variant_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX carts_items_variant_idx ON public.carts_items USING btree (variant_id);


--
-- Name: carts_secret_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX carts_secret_idx ON public.carts USING btree (secret);


--
-- Name: carts_updated_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX carts_updated_at_idx ON public.carts USING btree (updated_at);


--
-- Name: categories_created_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX categories_created_at_idx ON public.categories USING btree (created_at);


--
-- Name: categories_locales_locale_parent_id_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX categories_locales_locale_parent_id_unique ON public.categories_locales USING btree (_locale, _parent_id);


--
-- Name: categories_locales_parent_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX categories_locales_parent_id_idx ON public.categories_locales USING btree (_parent_id);


--
-- Name: categories_slug_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX categories_slug_idx ON public.categories USING btree (slug);


--
-- Name: categories_updated_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX categories_updated_at_idx ON public.categories USING btree (updated_at);


--
-- Name: home_announcements_locales_locale_parent_id_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX home_announcements_locales_locale_parent_id_unique ON public.home_announcements_locales USING btree (_locale, _parent_id);


--
-- Name: home_announcements_locales_parent_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX home_announcements_locales_parent_id_idx ON public.home_announcements_locales USING btree (_parent_id);


--
-- Name: home_announcements_order_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX home_announcements_order_idx ON public.home_announcements USING btree (_order);


--
-- Name: home_announcements_parent_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX home_announcements_parent_id_idx ON public.home_announcements USING btree (_parent_id);


--
-- Name: home_locales_locale_parent_id_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX home_locales_locale_parent_id_unique ON public.home_locales USING btree (_locale, _parent_id);


--
-- Name: home_locales_parent_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX home_locales_parent_id_idx ON public.home_locales USING btree (_parent_id);


--
-- Name: home_rels_order_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX home_rels_order_idx ON public.home_rels USING btree ("order");


--
-- Name: home_rels_parent_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX home_rels_parent_idx ON public.home_rels USING btree (parent_id);


--
-- Name: home_rels_path_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX home_rels_path_idx ON public.home_rels USING btree (path);


--
-- Name: home_rels_products_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX home_rels_products_id_idx ON public.home_rels USING btree (products_id);


--
-- Name: home_routine_locales_locale_parent_id_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX home_routine_locales_locale_parent_id_unique ON public.home_routine_locales USING btree (_locale, _parent_id);


--
-- Name: home_routine_locales_parent_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX home_routine_locales_parent_id_idx ON public.home_routine_locales USING btree (_parent_id);


--
-- Name: home_routine_order_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX home_routine_order_idx ON public.home_routine USING btree (_order);


--
-- Name: home_routine_parent_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX home_routine_parent_id_idx ON public.home_routine USING btree (_parent_id);


--
-- Name: home_routine_product_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX home_routine_product_idx ON public.home_routine USING btree (product_id);


--
-- Name: media_created_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX media_created_at_idx ON public.media USING btree (created_at);


--
-- Name: media_filename_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX media_filename_idx ON public.media USING btree (filename);


--
-- Name: media_updated_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX media_updated_at_idx ON public.media USING btree (updated_at);


--
-- Name: orders_access_token_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX orders_access_token_idx ON public.orders USING btree (access_token);


--
-- Name: orders_created_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX orders_created_at_idx ON public.orders USING btree (created_at);


--
-- Name: orders_customer_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX orders_customer_idx ON public.orders USING btree (customer_id);


--
-- Name: orders_items_order_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX orders_items_order_idx ON public.orders_items USING btree (_order);


--
-- Name: orders_items_parent_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX orders_items_parent_id_idx ON public.orders_items USING btree (_parent_id);


--
-- Name: orders_items_product_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX orders_items_product_idx ON public.orders_items USING btree (product_id);


--
-- Name: orders_items_variant_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX orders_items_variant_idx ON public.orders_items USING btree (variant_id);


--
-- Name: orders_rels_order_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX orders_rels_order_idx ON public.orders_rels USING btree ("order");


--
-- Name: orders_rels_parent_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX orders_rels_parent_idx ON public.orders_rels USING btree (parent_id);


--
-- Name: orders_rels_path_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX orders_rels_path_idx ON public.orders_rels USING btree (path);


--
-- Name: orders_rels_transactions_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX orders_rels_transactions_id_idx ON public.orders_rels USING btree (transactions_id);


--
-- Name: orders_updated_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX orders_updated_at_idx ON public.orders USING btree (updated_at);


--
-- Name: payload_kv_key_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX payload_kv_key_idx ON public.payload_kv USING btree (key);


--
-- Name: payload_locked_documents_created_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX payload_locked_documents_created_at_idx ON public.payload_locked_documents USING btree (created_at);


--
-- Name: payload_locked_documents_global_slug_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX payload_locked_documents_global_slug_idx ON public.payload_locked_documents USING btree (global_slug);


--
-- Name: payload_locked_documents_rels_addresses_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX payload_locked_documents_rels_addresses_id_idx ON public.payload_locked_documents_rels USING btree (addresses_id);


--
-- Name: payload_locked_documents_rels_carts_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX payload_locked_documents_rels_carts_id_idx ON public.payload_locked_documents_rels USING btree (carts_id);


--
-- Name: payload_locked_documents_rels_categories_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX payload_locked_documents_rels_categories_id_idx ON public.payload_locked_documents_rels USING btree (categories_id);


--
-- Name: payload_locked_documents_rels_media_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX payload_locked_documents_rels_media_id_idx ON public.payload_locked_documents_rels USING btree (media_id);


--
-- Name: payload_locked_documents_rels_order_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX payload_locked_documents_rels_order_idx ON public.payload_locked_documents_rels USING btree ("order");


--
-- Name: payload_locked_documents_rels_orders_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX payload_locked_documents_rels_orders_id_idx ON public.payload_locked_documents_rels USING btree (orders_id);


--
-- Name: payload_locked_documents_rels_parent_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX payload_locked_documents_rels_parent_idx ON public.payload_locked_documents_rels USING btree (parent_id);


--
-- Name: payload_locked_documents_rels_path_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX payload_locked_documents_rels_path_idx ON public.payload_locked_documents_rels USING btree (path);


--
-- Name: payload_locked_documents_rels_products_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX payload_locked_documents_rels_products_id_idx ON public.payload_locked_documents_rels USING btree (products_id);


--
-- Name: payload_locked_documents_rels_transactions_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX payload_locked_documents_rels_transactions_id_idx ON public.payload_locked_documents_rels USING btree (transactions_id);


--
-- Name: payload_locked_documents_rels_users_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX payload_locked_documents_rels_users_id_idx ON public.payload_locked_documents_rels USING btree (users_id);


--
-- Name: payload_locked_documents_rels_variant_options_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX payload_locked_documents_rels_variant_options_id_idx ON public.payload_locked_documents_rels USING btree (variant_options_id);


--
-- Name: payload_locked_documents_rels_variant_types_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX payload_locked_documents_rels_variant_types_id_idx ON public.payload_locked_documents_rels USING btree (variant_types_id);


--
-- Name: payload_locked_documents_rels_variants_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX payload_locked_documents_rels_variants_id_idx ON public.payload_locked_documents_rels USING btree (variants_id);


--
-- Name: payload_locked_documents_updated_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX payload_locked_documents_updated_at_idx ON public.payload_locked_documents USING btree (updated_at);


--
-- Name: payload_migrations_created_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX payload_migrations_created_at_idx ON public.payload_migrations USING btree (created_at);


--
-- Name: payload_migrations_updated_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX payload_migrations_updated_at_idx ON public.payload_migrations USING btree (updated_at);


--
-- Name: payload_preferences_created_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX payload_preferences_created_at_idx ON public.payload_preferences USING btree (created_at);


--
-- Name: payload_preferences_key_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX payload_preferences_key_idx ON public.payload_preferences USING btree (key);


--
-- Name: payload_preferences_rels_order_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX payload_preferences_rels_order_idx ON public.payload_preferences_rels USING btree ("order");


--
-- Name: payload_preferences_rels_parent_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX payload_preferences_rels_parent_idx ON public.payload_preferences_rels USING btree (parent_id);


--
-- Name: payload_preferences_rels_path_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX payload_preferences_rels_path_idx ON public.payload_preferences_rels USING btree (path);


--
-- Name: payload_preferences_rels_users_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX payload_preferences_rels_users_id_idx ON public.payload_preferences_rels USING btree (users_id);


--
-- Name: payload_preferences_updated_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX payload_preferences_updated_at_idx ON public.payload_preferences USING btree (updated_at);


--
-- Name: products__status_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX products__status_idx ON public.products USING btree (_status);


--
-- Name: products_created_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX products_created_at_idx ON public.products USING btree (created_at);


--
-- Name: products_deleted_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX products_deleted_at_idx ON public.products USING btree (deleted_at);


--
-- Name: products_gallery_image_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX products_gallery_image_idx ON public.products_gallery USING btree (image_id);


--
-- Name: products_gallery_order_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX products_gallery_order_idx ON public.products_gallery USING btree (_order);


--
-- Name: products_gallery_parent_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX products_gallery_parent_id_idx ON public.products_gallery USING btree (_parent_id);


--
-- Name: products_locales_locale_parent_id_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX products_locales_locale_parent_id_unique ON public.products_locales USING btree (_locale, _parent_id);


--
-- Name: products_locales_parent_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX products_locales_parent_id_idx ON public.products_locales USING btree (_parent_id);


--
-- Name: products_rels_categories_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX products_rels_categories_id_idx ON public.products_rels USING btree (categories_id);


--
-- Name: products_rels_order_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX products_rels_order_idx ON public.products_rels USING btree ("order");


--
-- Name: products_rels_parent_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX products_rels_parent_idx ON public.products_rels USING btree (parent_id);


--
-- Name: products_rels_path_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX products_rels_path_idx ON public.products_rels USING btree (path);


--
-- Name: products_rels_products_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX products_rels_products_id_idx ON public.products_rels USING btree (products_id);


--
-- Name: products_rels_variant_types_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX products_rels_variant_types_id_idx ON public.products_rels USING btree (variant_types_id);


--
-- Name: products_slug_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX products_slug_idx ON public.products USING btree (slug);


--
-- Name: products_updated_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX products_updated_at_idx ON public.products USING btree (updated_at);


--
-- Name: transactions_cart_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX transactions_cart_idx ON public.transactions USING btree (cart_id);


--
-- Name: transactions_created_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX transactions_created_at_idx ON public.transactions USING btree (created_at);


--
-- Name: transactions_customer_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX transactions_customer_idx ON public.transactions USING btree (customer_id);


--
-- Name: transactions_items_order_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX transactions_items_order_idx ON public.transactions_items USING btree (_order);


--
-- Name: transactions_items_parent_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX transactions_items_parent_id_idx ON public.transactions_items USING btree (_parent_id);


--
-- Name: transactions_items_product_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX transactions_items_product_idx ON public.transactions_items USING btree (product_id);


--
-- Name: transactions_items_variant_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX transactions_items_variant_idx ON public.transactions_items USING btree (variant_id);


--
-- Name: transactions_order_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX transactions_order_idx ON public.transactions USING btree (order_id);


--
-- Name: transactions_updated_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX transactions_updated_at_idx ON public.transactions USING btree (updated_at);


--
-- Name: users_created_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX users_created_at_idx ON public.users USING btree (created_at);


--
-- Name: users_email_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX users_email_idx ON public.users USING btree (email);


--
-- Name: users_roles_order_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX users_roles_order_idx ON public.users_roles USING btree ("order");


--
-- Name: users_roles_parent_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX users_roles_parent_idx ON public.users_roles USING btree (parent_id);


--
-- Name: users_sessions_order_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX users_sessions_order_idx ON public.users_sessions USING btree (_order);


--
-- Name: users_sessions_parent_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX users_sessions_parent_id_idx ON public.users_sessions USING btree (_parent_id);


--
-- Name: users_updated_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX users_updated_at_idx ON public.users USING btree (updated_at);


--
-- Name: variant_options__variantoptions_options_order_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variant_options__variantoptions_options_order_idx ON public.variant_options USING btree (_variantoptions_options_order);


--
-- Name: variant_options_created_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variant_options_created_at_idx ON public.variant_options USING btree (created_at);


--
-- Name: variant_options_deleted_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variant_options_deleted_at_idx ON public.variant_options USING btree (deleted_at);


--
-- Name: variant_options_updated_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variant_options_updated_at_idx ON public.variant_options USING btree (updated_at);


--
-- Name: variant_options_variant_type_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variant_options_variant_type_idx ON public.variant_options USING btree (variant_type_id);


--
-- Name: variant_types_created_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variant_types_created_at_idx ON public.variant_types USING btree (created_at);


--
-- Name: variant_types_deleted_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variant_types_deleted_at_idx ON public.variant_types USING btree (deleted_at);


--
-- Name: variant_types_updated_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variant_types_updated_at_idx ON public.variant_types USING btree (updated_at);


--
-- Name: variants__status_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variants__status_idx ON public.variants USING btree (_status);


--
-- Name: variants_created_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variants_created_at_idx ON public.variants USING btree (created_at);


--
-- Name: variants_deleted_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variants_deleted_at_idx ON public.variants USING btree (deleted_at);


--
-- Name: variants_product_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variants_product_idx ON public.variants USING btree (product_id);


--
-- Name: variants_rels_order_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variants_rels_order_idx ON public.variants_rels USING btree ("order");


--
-- Name: variants_rels_parent_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variants_rels_parent_idx ON public.variants_rels USING btree (parent_id);


--
-- Name: variants_rels_path_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variants_rels_path_idx ON public.variants_rels USING btree (path);


--
-- Name: variants_rels_variant_options_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variants_rels_variant_options_id_idx ON public.variants_rels USING btree (variant_options_id);


--
-- Name: variants_updated_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variants_updated_at_idx ON public.variants USING btree (updated_at);


--
-- Name: _products_v_locales _products_v_locales_parent_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._products_v_locales
    ADD CONSTRAINT _products_v_locales_parent_id_fk FOREIGN KEY (_parent_id) REFERENCES public._products_v(id) ON DELETE CASCADE;


--
-- Name: _products_v _products_v_parent_id_products_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._products_v
    ADD CONSTRAINT _products_v_parent_id_products_id_fk FOREIGN KEY (parent_id) REFERENCES public.products(id) ON DELETE SET NULL;


--
-- Name: _products_v_rels _products_v_rels_categories_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._products_v_rels
    ADD CONSTRAINT _products_v_rels_categories_fk FOREIGN KEY (categories_id) REFERENCES public.categories(id) ON DELETE CASCADE;


--
-- Name: _products_v_rels _products_v_rels_parent_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._products_v_rels
    ADD CONSTRAINT _products_v_rels_parent_fk FOREIGN KEY (parent_id) REFERENCES public._products_v(id) ON DELETE CASCADE;


--
-- Name: _products_v_rels _products_v_rels_products_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._products_v_rels
    ADD CONSTRAINT _products_v_rels_products_fk FOREIGN KEY (products_id) REFERENCES public.products(id) ON DELETE CASCADE;


--
-- Name: _products_v_rels _products_v_rels_variant_types_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._products_v_rels
    ADD CONSTRAINT _products_v_rels_variant_types_fk FOREIGN KEY (variant_types_id) REFERENCES public.variant_types(id) ON DELETE CASCADE;


--
-- Name: _products_v_version_gallery _products_v_version_gallery_image_id_media_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._products_v_version_gallery
    ADD CONSTRAINT _products_v_version_gallery_image_id_media_id_fk FOREIGN KEY (image_id) REFERENCES public.media(id) ON DELETE SET NULL;


--
-- Name: _products_v_version_gallery _products_v_version_gallery_parent_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._products_v_version_gallery
    ADD CONSTRAINT _products_v_version_gallery_parent_id_fk FOREIGN KEY (_parent_id) REFERENCES public._products_v(id) ON DELETE CASCADE;


--
-- Name: _variants_v _variants_v_parent_id_variants_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._variants_v
    ADD CONSTRAINT _variants_v_parent_id_variants_id_fk FOREIGN KEY (parent_id) REFERENCES public.variants(id) ON DELETE SET NULL;


--
-- Name: _variants_v_rels _variants_v_rels_parent_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._variants_v_rels
    ADD CONSTRAINT _variants_v_rels_parent_fk FOREIGN KEY (parent_id) REFERENCES public._variants_v(id) ON DELETE CASCADE;


--
-- Name: _variants_v_rels _variants_v_rels_variant_options_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._variants_v_rels
    ADD CONSTRAINT _variants_v_rels_variant_options_fk FOREIGN KEY (variant_options_id) REFERENCES public.variant_options(id) ON DELETE CASCADE;


--
-- Name: _variants_v _variants_v_version_product_id_products_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._variants_v
    ADD CONSTRAINT _variants_v_version_product_id_products_id_fk FOREIGN KEY (version_product_id) REFERENCES public.products(id) ON DELETE SET NULL;


--
-- Name: addresses addresses_customer_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.addresses
    ADD CONSTRAINT addresses_customer_id_users_id_fk FOREIGN KEY (customer_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: carts carts_customer_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.carts
    ADD CONSTRAINT carts_customer_id_users_id_fk FOREIGN KEY (customer_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: carts_items carts_items_parent_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.carts_items
    ADD CONSTRAINT carts_items_parent_id_fk FOREIGN KEY (_parent_id) REFERENCES public.carts(id) ON DELETE CASCADE;


--
-- Name: carts_items carts_items_product_id_products_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.carts_items
    ADD CONSTRAINT carts_items_product_id_products_id_fk FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE SET NULL;


--
-- Name: carts_items carts_items_variant_id_variants_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.carts_items
    ADD CONSTRAINT carts_items_variant_id_variants_id_fk FOREIGN KEY (variant_id) REFERENCES public.variants(id) ON DELETE SET NULL;


--
-- Name: categories_locales categories_locales_parent_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories_locales
    ADD CONSTRAINT categories_locales_parent_id_fk FOREIGN KEY (_parent_id) REFERENCES public.categories(id) ON DELETE CASCADE;


--
-- Name: home_announcements_locales home_announcements_locales_parent_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.home_announcements_locales
    ADD CONSTRAINT home_announcements_locales_parent_id_fk FOREIGN KEY (_parent_id) REFERENCES public.home_announcements(id) ON DELETE CASCADE;


--
-- Name: home_announcements home_announcements_parent_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.home_announcements
    ADD CONSTRAINT home_announcements_parent_id_fk FOREIGN KEY (_parent_id) REFERENCES public.home(id) ON DELETE CASCADE;


--
-- Name: home_locales home_locales_parent_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.home_locales
    ADD CONSTRAINT home_locales_parent_id_fk FOREIGN KEY (_parent_id) REFERENCES public.home(id) ON DELETE CASCADE;


--
-- Name: home_rels home_rels_parent_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.home_rels
    ADD CONSTRAINT home_rels_parent_fk FOREIGN KEY (parent_id) REFERENCES public.home(id) ON DELETE CASCADE;


--
-- Name: home_rels home_rels_products_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.home_rels
    ADD CONSTRAINT home_rels_products_fk FOREIGN KEY (products_id) REFERENCES public.products(id) ON DELETE CASCADE;


--
-- Name: home_routine_locales home_routine_locales_parent_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.home_routine_locales
    ADD CONSTRAINT home_routine_locales_parent_id_fk FOREIGN KEY (_parent_id) REFERENCES public.home_routine(id) ON DELETE CASCADE;


--
-- Name: home_routine home_routine_parent_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.home_routine
    ADD CONSTRAINT home_routine_parent_id_fk FOREIGN KEY (_parent_id) REFERENCES public.home(id) ON DELETE CASCADE;


--
-- Name: home_routine home_routine_product_id_products_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.home_routine
    ADD CONSTRAINT home_routine_product_id_products_id_fk FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE SET NULL;


--
-- Name: orders orders_customer_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_customer_id_users_id_fk FOREIGN KEY (customer_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: orders_items orders_items_parent_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders_items
    ADD CONSTRAINT orders_items_parent_id_fk FOREIGN KEY (_parent_id) REFERENCES public.orders(id) ON DELETE CASCADE;


--
-- Name: orders_items orders_items_product_id_products_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders_items
    ADD CONSTRAINT orders_items_product_id_products_id_fk FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE SET NULL;


--
-- Name: orders_items orders_items_variant_id_variants_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders_items
    ADD CONSTRAINT orders_items_variant_id_variants_id_fk FOREIGN KEY (variant_id) REFERENCES public.variants(id) ON DELETE SET NULL;


--
-- Name: orders_rels orders_rels_parent_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders_rels
    ADD CONSTRAINT orders_rels_parent_fk FOREIGN KEY (parent_id) REFERENCES public.orders(id) ON DELETE CASCADE;


--
-- Name: orders_rels orders_rels_transactions_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders_rels
    ADD CONSTRAINT orders_rels_transactions_fk FOREIGN KEY (transactions_id) REFERENCES public.transactions(id) ON DELETE CASCADE;


--
-- Name: payload_locked_documents_rels payload_locked_documents_rels_addresses_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payload_locked_documents_rels
    ADD CONSTRAINT payload_locked_documents_rels_addresses_fk FOREIGN KEY (addresses_id) REFERENCES public.addresses(id) ON DELETE CASCADE;


--
-- Name: payload_locked_documents_rels payload_locked_documents_rels_carts_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payload_locked_documents_rels
    ADD CONSTRAINT payload_locked_documents_rels_carts_fk FOREIGN KEY (carts_id) REFERENCES public.carts(id) ON DELETE CASCADE;


--
-- Name: payload_locked_documents_rels payload_locked_documents_rels_categories_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payload_locked_documents_rels
    ADD CONSTRAINT payload_locked_documents_rels_categories_fk FOREIGN KEY (categories_id) REFERENCES public.categories(id) ON DELETE CASCADE;


--
-- Name: payload_locked_documents_rels payload_locked_documents_rels_media_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payload_locked_documents_rels
    ADD CONSTRAINT payload_locked_documents_rels_media_fk FOREIGN KEY (media_id) REFERENCES public.media(id) ON DELETE CASCADE;


--
-- Name: payload_locked_documents_rels payload_locked_documents_rels_orders_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payload_locked_documents_rels
    ADD CONSTRAINT payload_locked_documents_rels_orders_fk FOREIGN KEY (orders_id) REFERENCES public.orders(id) ON DELETE CASCADE;


--
-- Name: payload_locked_documents_rels payload_locked_documents_rels_parent_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payload_locked_documents_rels
    ADD CONSTRAINT payload_locked_documents_rels_parent_fk FOREIGN KEY (parent_id) REFERENCES public.payload_locked_documents(id) ON DELETE CASCADE;


--
-- Name: payload_locked_documents_rels payload_locked_documents_rels_products_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payload_locked_documents_rels
    ADD CONSTRAINT payload_locked_documents_rels_products_fk FOREIGN KEY (products_id) REFERENCES public.products(id) ON DELETE CASCADE;


--
-- Name: payload_locked_documents_rels payload_locked_documents_rels_transactions_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payload_locked_documents_rels
    ADD CONSTRAINT payload_locked_documents_rels_transactions_fk FOREIGN KEY (transactions_id) REFERENCES public.transactions(id) ON DELETE CASCADE;


--
-- Name: payload_locked_documents_rels payload_locked_documents_rels_users_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payload_locked_documents_rels
    ADD CONSTRAINT payload_locked_documents_rels_users_fk FOREIGN KEY (users_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: payload_locked_documents_rels payload_locked_documents_rels_variant_options_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payload_locked_documents_rels
    ADD CONSTRAINT payload_locked_documents_rels_variant_options_fk FOREIGN KEY (variant_options_id) REFERENCES public.variant_options(id) ON DELETE CASCADE;


--
-- Name: payload_locked_documents_rels payload_locked_documents_rels_variant_types_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payload_locked_documents_rels
    ADD CONSTRAINT payload_locked_documents_rels_variant_types_fk FOREIGN KEY (variant_types_id) REFERENCES public.variant_types(id) ON DELETE CASCADE;


--
-- Name: payload_locked_documents_rels payload_locked_documents_rels_variants_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payload_locked_documents_rels
    ADD CONSTRAINT payload_locked_documents_rels_variants_fk FOREIGN KEY (variants_id) REFERENCES public.variants(id) ON DELETE CASCADE;


--
-- Name: payload_preferences_rels payload_preferences_rels_parent_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payload_preferences_rels
    ADD CONSTRAINT payload_preferences_rels_parent_fk FOREIGN KEY (parent_id) REFERENCES public.payload_preferences(id) ON DELETE CASCADE;


--
-- Name: payload_preferences_rels payload_preferences_rels_users_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payload_preferences_rels
    ADD CONSTRAINT payload_preferences_rels_users_fk FOREIGN KEY (users_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: products_gallery products_gallery_image_id_media_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products_gallery
    ADD CONSTRAINT products_gallery_image_id_media_id_fk FOREIGN KEY (image_id) REFERENCES public.media(id) ON DELETE SET NULL;


--
-- Name: products_gallery products_gallery_parent_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products_gallery
    ADD CONSTRAINT products_gallery_parent_id_fk FOREIGN KEY (_parent_id) REFERENCES public.products(id) ON DELETE CASCADE;


--
-- Name: products_locales products_locales_parent_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products_locales
    ADD CONSTRAINT products_locales_parent_id_fk FOREIGN KEY (_parent_id) REFERENCES public.products(id) ON DELETE CASCADE;


--
-- Name: products_rels products_rels_categories_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products_rels
    ADD CONSTRAINT products_rels_categories_fk FOREIGN KEY (categories_id) REFERENCES public.categories(id) ON DELETE CASCADE;


--
-- Name: products_rels products_rels_parent_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products_rels
    ADD CONSTRAINT products_rels_parent_fk FOREIGN KEY (parent_id) REFERENCES public.products(id) ON DELETE CASCADE;


--
-- Name: products_rels products_rels_products_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products_rels
    ADD CONSTRAINT products_rels_products_fk FOREIGN KEY (products_id) REFERENCES public.products(id) ON DELETE CASCADE;


--
-- Name: products_rels products_rels_variant_types_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products_rels
    ADD CONSTRAINT products_rels_variant_types_fk FOREIGN KEY (variant_types_id) REFERENCES public.variant_types(id) ON DELETE CASCADE;


--
-- Name: transactions transactions_cart_id_carts_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_cart_id_carts_id_fk FOREIGN KEY (cart_id) REFERENCES public.carts(id) ON DELETE SET NULL;


--
-- Name: transactions transactions_customer_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_customer_id_users_id_fk FOREIGN KEY (customer_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: transactions_items transactions_items_parent_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.transactions_items
    ADD CONSTRAINT transactions_items_parent_id_fk FOREIGN KEY (_parent_id) REFERENCES public.transactions(id) ON DELETE CASCADE;


--
-- Name: transactions_items transactions_items_product_id_products_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.transactions_items
    ADD CONSTRAINT transactions_items_product_id_products_id_fk FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE SET NULL;


--
-- Name: transactions_items transactions_items_variant_id_variants_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.transactions_items
    ADD CONSTRAINT transactions_items_variant_id_variants_id_fk FOREIGN KEY (variant_id) REFERENCES public.variants(id) ON DELETE SET NULL;


--
-- Name: transactions transactions_order_id_orders_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_order_id_orders_id_fk FOREIGN KEY (order_id) REFERENCES public.orders(id) ON DELETE SET NULL;


--
-- Name: users_roles users_roles_parent_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users_roles
    ADD CONSTRAINT users_roles_parent_fk FOREIGN KEY (parent_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: users_sessions users_sessions_parent_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users_sessions
    ADD CONSTRAINT users_sessions_parent_id_fk FOREIGN KEY (_parent_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: variant_options variant_options_variant_type_id_variant_types_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variant_options
    ADD CONSTRAINT variant_options_variant_type_id_variant_types_id_fk FOREIGN KEY (variant_type_id) REFERENCES public.variant_types(id) ON DELETE SET NULL;


--
-- Name: variants variants_product_id_products_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variants
    ADD CONSTRAINT variants_product_id_products_id_fk FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE SET NULL;


--
-- Name: variants_rels variants_rels_parent_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variants_rels
    ADD CONSTRAINT variants_rels_parent_fk FOREIGN KEY (parent_id) REFERENCES public.variants(id) ON DELETE CASCADE;


--
-- Name: variants_rels variants_rels_variant_options_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variants_rels
    ADD CONSTRAINT variants_rels_variant_options_fk FOREIGN KEY (variant_options_id) REFERENCES public.variant_options(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict GVOVapZ0bh6YR2lGFyXNyUc99M8QNjfxq5bJGFEgFSvR6gfe3HXdw6KdBHZIId5

