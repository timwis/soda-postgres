--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: sites; Type: TABLE; Schema: public; Owner: tim; Tablespace: 
--

CREATE TABLE sites (
    id integer NOT NULL,
    date character varying,
    "time" character varying,
    address character varying,
    location character varying,
    city character varying,
    state character varying,
    zip_code integer,
    screening_type character varying,
    contact_information character varying,
    phone_number character varying,
    geom geometry
);


ALTER TABLE sites OWNER TO tim;

--
-- Name: ogrgeojson_ogc_fid_seq1; Type: SEQUENCE; Schema: public; Owner: tim
--

CREATE SEQUENCE ogrgeojson_ogc_fid_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ogrgeojson_ogc_fid_seq1 OWNER TO tim;

--
-- Name: ogrgeojson_ogc_fid_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: tim
--

ALTER SEQUENCE ogrgeojson_ogc_fid_seq1 OWNED BY sites.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: tim
--

ALTER TABLE ONLY sites ALTER COLUMN id SET DEFAULT nextval('ogrgeojson_ogc_fid_seq1'::regclass);


--
-- Name: ogrgeojson_ogc_fid_seq1; Type: SEQUENCE SET; Schema: public; Owner: tim
--

SELECT pg_catalog.setval('ogrgeojson_ogc_fid_seq1', 62, true);


--
-- Data for Name: sites; Type: TABLE DATA; Schema: public; Owner: tim
--

COPY sites (id, date, "time", address, location, city, state, zip_code, screening_type, contact_information, phone_number, geom) FROM stdin;
1	2015-04-01T00:00:00.000Z	12 PM - 3:30 PM	Broad St and Snyder St 	\N	Philadelphia	PA	19148	HIV & STD Testing	Contact the Mazzoni Center	215-563-0652	01010000006A33C71CDDCA52C02113DC1453F64340
2	2015-04-01T00:00:00.000Z	1 PM - 4 PM	1200 W Godfrey Avenue            	\N	Philadelphia	PA	19141	Vision Screening Only	Contact The Eye Institute	215-276-6111	010100000033609EF3E7C852C0D1505D6C02064440
3	2015-04-01T00:00:00.000Z	11:30 AM - 1 PM	2500 Jackson Street                                                                         	\N	Philadelphia	PA	19145	Blood Pressure Only	Contact Jefferson University Hospital - Blood Pressure Plus	215-955-3817	01010000009D6BFC250BCC52C0288D780275F64340
4	2015-04-02T00:00:00.000Z	11:30 AM - 1:30 PM	4900 Frankford Avenue                                                     	\N	Philadelphia	PA	19124	Blood Pressure Only	Contact Aria Hospital	877-808-2742	01010000006AF709F736C552C03989C04077024440
5	2015-04-02T00:00:00.000Z	8 AM - 12 PM	Red Lion Rd and Knights Rd  	\N	Philadelphia	PA	19144	Blood Pressure Only	Contact Aria Hospital	877-808-2742	01010000007BD9057FCABE52C00E82BFB138094440
6	2015-04-02T00:00:00.000Z	10 AM - 12 PM	2208 N. Broad Street 	\N	Philadelphia	PA	19132	Blood Pressure Only	Contact Jefferson University Hospital - Blood Pressure Plus	215-955-3817	010100000094A51A15FFC952C03B14818D43FE4340
7	2015-04-02T00:00:00.000Z	12 PM - 3:30 PM	Broad St and Oxford St	\N	Philadelphia	PA	19121	HIV & STD Testing	Contact the Mazzoni Center	215-563-0652	0101000000A623109920CA52C0874D008F17FD4340
8	2015-04-03T00:00:00.000Z	12 PM - 3:30 PM	5th St and Bainbridge St         	Philly AIDS Thrift	Philadelphia	PA	19147	HIV & STD Testing	Contact the Mazzoni Center	215-563-0652	0101000000BD29874EA9C952C006643AC170F84340
9	2015-04-06T00:00:00.000Z	12 PM - 3:30 PM	56th St and Market St  	Fresh Grocer Parking Lot	Philadelphia	PA	19139	HIV & STD Testing	Contact the Mazzoni Center	215-563-0652	010100000025395C25E7CE52C04B48734B01FB4340
10	2015-04-06T00:00:00.000Z	10:30 AM - 12 PM	1941 Christian Street  	\N	Philadelphia	PA	19146	Blood Pressure Only	Contact Jefferson University Hospital - Blood Pressure Plus	215-955-3817	0101000000281B4D1B3BCB52C07445541C7AF84340
11	2015-04-06T00:00:00.000Z	1 PM - 4 PM	1200 W Godfrey Avenue            	\N	Philadelphia	PA	19141	Vision Screening Only	Contact The Eye Institute	215-276-6111	010100000033609EF3E7C852C0D1505D6C02064440
12	2015-04-07T00:00:00.000Z	10 AM - 12 PM	2952 N. 5th Street                                   	\N	Philadelphia	PA	19133	Blood Pressure Only	Contact Jefferson University Hospital - Blood Pressure Plus	215-955-3817	0101000000BF06DF92EAC852C00924EE738AFF4340
13	2015-04-07T00:00:00.000Z	1 PM - 3 PM	727 N. 10th Street                                  	\N	Philadelphia	PA	19123	Blood Pressure Only	Contact Jefferson University Hospital - Blood Pressure Plus	215-955-3817	010100000025E0C91BD3C952C051C4F87AA7FB4340
14	2015-04-07T00:00:00.000Z	1 PM - 4 PM	1200 W Godfrey Avenue            	\N	Philadelphia	PA	19141	Vision Screening Only	Contact The Eye Institute	215-276-6111	010100000033609EF3E7C852C0D1505D6C02064440
15	2015-04-08T00:00:00.000Z	7 PM - 8:30 PM	Red Lion Rd and Knights Rd	\N	Philadelphia	PA	19144	Free Smoking Cessation (5 Week Program)	Registration Required Contact Aria Hospital	877-808-2742      Option 2	01010000007BD9057FCABE52C00E82BFB138094440
16	2015-04-08T00:00:00.000Z	5 PM - 7 PM	 2110 Chestnut Street 	Lutheran Church of the Holy Communion    	Philadelphia	PA	19103	Hepatitis C Testing	Contact Jazz Bridge	215-517-8337	0101000000CD3C11F443CB52C03E96620DE6F94340
17	2015-04-08T00:00:00.000Z	12 PM - 3:30 PM	Broad St and Snyder St	\N	Philadelphia	PA	19148	HIV & STD Testing	Contact the Mazzoni Center	215-563-0652	01010000006A33C71CDDCA52C02113DC1453F64340
18	2015-04-08T00:00:00.000Z	1 PM - 4 PM	1200 W Godfrey Avenue            	\N	Philadelphia	PA	19141	Vision Screening Only	Contact The Eye Institute	215-276-6111	010100000033609EF3E7C852C0D1505D6C02064440
19	2015-04-09T00:00:00.000Z	8 AM - 12 PM	4900 Frankford Avenue                                                     	\N	Philadelphia	PA	19124	Blood Pressure Only	Contact Aria Hospital	877-808-2742	01010000006AF709F736C552C03989C04077024440
20	2015-04-09T00:00:00.000Z	8 AM - 12 PM	Red Lion Rd and Knights Rd 	\N	Philadelphia	PA	19144	Blood Pressure Only	Contact Aria Hospital	877-808-2742	01010000002A6C937CCABE52C0E2EA9F2939094440
21	2015-04-09T00:00:00.000Z	12 PM - 3:30 PM	17th St and Spring Garden St	\N	Philadelphia	PA	19130	HIV & STD Testing	Contact the Mazzoni Center	215-563-0652	01010000008E3A50E1A3CA52C044A2DD4F43FB4340
22	2015-04-10T00:00:00.000Z	12 PM - 3:30 PM	Broad St and Oxford St	\N	Philadelphia	PA	19121	HIV & STD Testing	Contact the Mazzoni Center	215-563-0652	0101000000A623109920CA52C0874D008F17FD4340
23	2015-04-11T00:00:00.000Z	11 AM - 2 PM	5800 Walnut Street 	Rear	Philadelphia	PA	19139	Private rapid HIV testing, Eye exams, Blood Pressure	Contact Sayre Health Center	215-474-4444	010100000009CCFBCF42CF52C0AC2A2F08B0FA4340
24	2015-04-13T00:00:00.000Z	12 PM - 3:30 PM	56th St and Market St    	Fresh Grocer Parking Lot	Philadelphia	PA	19139	HIV & STD Testing	Contact the Mazzoni Center	215-563-0652	010100000025395C25E7CE52C04B48734B01FB4340
25	2015-04-13T00:00:00.000Z	1 PM - 4 PM	1200 W Godfrey Avenue            	\N	Philadelphia	PA	19141	Vision Screening Only	Contact The Eye Institute	215-276-6111	010100000033609EF3E7C852C0D1505D6C02064440
26	2015-04-14T00:00:00.000Z	10:30 AM - 12 PM	1724 Christian Street 	\N	Philadelphia	PA	19146	Blood Pressure Only	Contact Jefferson University Hospital - Blood Pressure Plus	215-955-3817	01010000005B5E0A6503CB52C0FF89300F69F84340
27	2015-04-14T00:00:00.000Z	1 PM - 4 PM	1200 W Godfrey Avenue            	\N	Philadelphia	PA	19141	Vision Screening Only	Contact The Eye Institute	215-276-6111	010100000033609EF3E7C852C0D1505D6C02064440
28	2015-04-15T00:00:00.000Z	7 PM - 8:30 PM	Red Lion Rd and Knights Rd	\N	Philadelphia	PA	19144	Free Smoking Cessation (5 Week Program)	Registration Required Contact Aria Hospital	877-808-2742      Option 2	01010000002E3698CACABE52C02E6D622D39094440
29	2015-04-15T00:00:00.000Z	12 PM - 3:30 PM	Broad St and Snyder St 	\N	Philadelphia	PA	19148	HIV & STD Testing	Contact the Mazzoni Center	215-563-0652	01010000006A33C71CDDCA52C02113DC1453F64340
30	2015-04-15T00:00:00.000Z	1 PM - 4 PM	1200 W Godfrey Avenue            	\N	Philadelphia	PA	19141	Vision Screening Only	Contact The Eye Institute	215-276-6111	010100000033609EF3E7C852C0D1505D6C02064440
31	2015-04-16T00:00:00.000Z	8 AM - 12 PM	4900 Frankford Avenue                                                            	\N	Philadelphia	PA	19124	Blood Pressure Only	Contact Aria Hospital	877-808-2742	01010000006AF709F736C552C03989C04077024440
32	2015-04-16T00:00:00.000Z	8 AM - 12 PM	Red Lion Rd and Knights Rd  	\N	Philadelphia	PA	19144	Blood Pressure Only	Contact Aria Hospital	877-808-2742	01010000006CA20ACDCABE52C04A0482B538094440
33	2015-04-16T00:00:00.000Z	12 PM - 3:30 PM	Broad St and Oxford St	\N	Philadelphia	PA	19121	HIV & STD Testing	Contact the Mazzoni Center	215-563-0652	0101000000A623109920CA52C0874D008F17FD4340
34	2015-04-17T00:00:00.000Z	12 PM - 3:30 PM	5th St and Bainbridge St	Philly AIDS Thrift	Philadelphia	PA	19147	HIV & STD Testing	Contact the Mazzoni Center	215-563-0652	0101000000BD29874EA9C952C006643AC170F84340
35	2015-04-20T00:00:00.000Z	12 PM - 3:30 PM	56th St and Market St     	Fresh Grocer Parking Lot	Philadelphia	PA	19139	HIV & STD Testing	Contact the Mazzoni Center	215-563-0652	010100000025395C25E7CE52C04B48734B01FB4340
36	2015-04-20T00:00:00.000Z	1 PM - 4 PM	1200 W Godfrey Avenue            	\N	Philadelphia	PA	19141	Vision Screening Only	Contact The Eye Institute	215-276-6111	010100000033609EF3E7C852C0D1505D6C02064440
37	2015-04-21T00:00:00.000Z	10 AM - 12 PM	623 Fairmount Avenue             	\N	Philadelphia	PA	19123	Blood Pressure Only	Contact Jefferson University Hospital - Blood Pressure Plus	215-955-3817	0101000000DA40CA6E88C952C073C3E93061FB4340
38	2015-04-21T00:00:00.000Z	10 AM - 3 PM	172 W. Norris Street                       	\N	Philadelphia	PA	19122	Blood Pressure Only	Contact Jefferson University Hospital - Blood Pressure Plus	215-955-3817	01010000003168E1D9B3C852C046831DBD7FFD4340
39	2015-04-21T00:00:00.000Z	1 PM - 4 PM	1200 W Godfrey Avenue            	\N	Philadelphia	PA	19141	Vision Screening Only	Contact The Eye Institute	215-276-6111	010100000033609EF3E7C852C0D1505D6C02064440
40	2015-04-22T00:00:00.000Z	7 PM - 8:30 PM	Red Lion Rd and Knights Rd	\N	Philadelphia	PA	19144	Free Smoking Cessation (5 Week Program)	Registration Required Contact Aria Hospital	877-808-2742      Option 2	0101000000BB467881CABE52C03419DF3938094440
41	2015-04-22T00:00:00.000Z	12 PM - 3:30 PM	Broad St and Snyder St	\N	Philadelphia	PA	19148	HIV & STD Testing	Contact the Mazzoni Center	215-563-0652	01010000006A33C71CDDCA52C02113DC1453F64340
42	2015-04-22T00:00:00.000Z	1 PM - 4 PM	1200 W Godfrey Avenue            	\N	Philadelphia	PA	19141	Vision Screening Only	Contact The Eye Institute	215-276-6111	010100000033609EF3E7C852C0D1505D6C02064440
43	2015-04-22T00:00:00.000Z	11 AM - 12 PM	750 S. Broad Street                                                                                     	\N	Philadelphia	PA	19146	Blood Pressure Only	Contact Jefferson University Hospital - Blood Pressure Plus	215-955-3817	01010000009B01E586A1CA52C0FC31C04981F84340
44	2015-04-23T00:00:00.000Z	8 AM - 12 PM	4900 Frankford Avenue                                                            	\N	Philadelphia	PA	19124	Blood Pressure Only	Contact Aria Hospital	877-808-2742	01010000006AF709F736C552C03989C04077024440
45	2015-04-23T00:00:00.000Z	8 AM - 12 PM	Red Lion Rd and Knights Rd	\N	Philadelphia	PA	19144	Blood Pressure Only	Contact Aria Hospital	877-808-2742	01010000002E3698CACABE52C02E6D622D39094440
46	2015-04-23T00:00:00.000Z	10 AM - 12 PM	2243 Christian Street                             	\N	Philadelphia	PA	19146	Blood Pressure Only	Contact Jefferson University Hospital - Blood Pressure Plus	215-955-3817	0101000000F8FC484F92CB52C0FE70ADB18FF84340
47	2015-04-23T00:00:00.000Z	12 PM - 3:30 PM	17th St and Spring Garden St	\N	Philadelphia	PA	19130	HIV & STD Testing	Contact the Mazzoni Center	215-563-0652	01010000008E3A50E1A3CA52C044A2DD4F43FB4340
48	2015-04-23T00:00:00.000Z	9 AM - 4 PM	5320-22 Cedar Avenue 	\N	Philadelphia	PA	19143	Blood Pressure Only	Registration Required Contact Outreach Center	215-748-9600	010100000040D3ABFDAFCE52C0B3802781B1F94340
49	2015-04-23T00:00:00.000Z	1 PM - 3 PM	1718 Wharton Street                       	\N	Philadelphia	PA	19146	Blood Pressure Only	Contact Jefferson University Hospital - Blood Pressure Plus	215-955-3817	01010000007B90479715CB52C072F899D8A7F74340
50	2015-04-24T00:00:00.000Z	10 AM - 2:30 PM	1401 John F Kennedy Boulevard 	Municipal Services Plaza   	Philadelphia	PA	19102	Blood Pressure Screenings, HIV Testing, Hepatitis C Testing, Dental Screenings, Kidney Screenings* (*while supplies last)	Philadelphia Department of Public Health	215-686-5193	0101000000A45FF2E382CA52C0524141DF0FFA4340
51	2015-04-24T00:00:00.000Z	12 PM - 3:30 PM	Broad St and Oxford St	\N	Philadelphia	PA	19121	HIV & STD Testing	Contact the Mazzoni Center	215-563-0652	0101000000A623109920CA52C0874D008F17FD4340
52	2015-04-25T00:00:00.000Z	8 AM - 2 PM	1001 Locust Street	Dorrance H Hamilton Building 	Philadelphia	PA	19107	Glaucoma Screening	Registration Required Contact Rita Stern	215-928-3190 or 484-678-4535	01010000003156517623CA52C055C03E2047F94340
53	2015-04-27T00:00:00.000Z	11 AM - 12 PM	2433 S. 15th Street                                                                                                    	\N	Philadelphia	PA	19145	Blood Pressure Only	Contact Jefferson University Hospital - Blood Pressure Plus	215-955-3817	01010000002D2E20E207CB52C073A6BA81BEF54340
54	2015-04-27T00:00:00.000Z	12 PM - 3:30 PM	56th St and Market St	Fresh Grocer Parking Lot	Philadelphia	PA	19139	HIV & STD Testing	Contact the Mazzoni Center	215-563-0652	010100000025395C25E7CE52C04B48734B01FB4340
55	2015-04-27T00:00:00.000Z	1 PM - 4 PM	1200 W Godfrey Avenue            	\N	Philadelphia	PA	19141	Vision Screening Only	Contact The Eye Institute	215-276-6111	010100000033609EF3E7C852C0D1505D6C02064440
56	2015-04-28T00:00:00.000Z	1 PM - 3 PM	1918 W. Susquehanna Avenue                                          	\N	Philadelphia	PA	19121	Blood Pressure Only	Contact Jefferson University Hospital - Blood Pressure Plus	215-955-3817	0101000000624279238BCA52C0755F081161FE4340
57	2015-04-28T00:00:00.000Z	1 PM - 4 PM	1200 W Godfrey Avenue            	\N	Philadelphia	PA	19141	Vision Screening Only	Contact The Eye Institute	215-276-6111	010100000033609EF3E7C852C0D1505D6C02064440
58	2015-04-29T00:00:00.000Z	7 PM - 8:30 PM	Red Lion Rd and Knights Rd	\N	Philadelphia	PA	19144	Free Smoking Cessation (5 Week Program)	Registration Required Contact Aria Hospital	877-808-2742      Option 2	01010000007BD9057FCABE52C00E82BFB138094440
59	2015-04-29T00:00:00.000Z	12 PM - 3:30 PM	Broad St and Snyder St	\N	Philadelphia	PA	19148	HIV & STD Testing	Contact the Mazzoni Center	215-563-0652	01010000006A33C71CDDCA52C02113DC1453F64340
60	2015-04-29T00:00:00.000Z	1 PM - 4 PM	1200 W Godfrey Avenue            	\N	Philadelphia	PA	19141	Vision Screening Only	Contact The Eye Institute	215-276-6111	010100000033609EF3E7C852C0D1505D6C02064440
61	2015-04-30T00:00:00.000Z	8 AM - 12 PM	4900 Frankford Avenue                                                            	\N	Philadelphia	PA	19124	Blood Pressure Only	Contact Aria Hospital	877-808-2742	01010000006AF709F736C552C03989C04077024440
62	2015-04-30T00:00:00.000Z	8 AM - 12 PM	Red Lion Rd and Knights Rd	\N	Philadelphia	PA	19144	Blood Pressure Only	Contact Aria Hospital	877-808-2742	01010000002E3698CACABE52C02E6D622D39094440
\.


--
-- Name: ogrgeojson_pkey; Type: CONSTRAINT; Schema: public; Owner: tim; Tablespace: 
--

ALTER TABLE ONLY sites
    ADD CONSTRAINT ogrgeojson_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

