--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.3
-- Dumped by pg_dump version 9.6.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;


--
-- Name: airports_data; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.airports_data (
    airport_code character(3) NOT NULL,
    airport_name jsonb NOT NULL,
    city jsonb NOT NULL,
    coordinates point NOT NULL,
    timezone text NOT NULL
);


ALTER TABLE public.airports_data OWNER TO postgres;

--
-- Name: TABLE airports_data; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.airports_data IS 'Airports (internal data)';


--
-- Name: COLUMN airports_data.airport_code; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.airports_data.airport_code IS 'Airport code';


--
-- Name: COLUMN airports_data.airport_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.airports_data.airport_name IS 'Airport name';


--
-- Name: COLUMN airports_data.city; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.airports_data.city IS 'City';


--
-- Name: COLUMN airports_data.coordinates; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.airports_data.coordinates IS 'Airport coordinates (longitude and latitude)';


--
-- Name: COLUMN airports_data.timezone; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.airports_data.timezone IS 'Airport time zone';


--
-- Name: flights_flight_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.flights_flight_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.flights_flight_id_seq OWNER TO postgres;

--
-- Data for Name: airports_data; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.airports_data (airport_code, airport_name, city, coordinates, timezone) FROM stdin;
YKS	{"en": "Yakutsk Airport", "ru": "Якутск"}	{"en": "Yakutsk", "ru": "Якутск"}	(129.77099609375,62.093299865722656)	Asia/Yakutsk
MJZ	{"en": "Mirny Airport", "ru": "Мирный"}	{"en": "Mirnyj", "ru": "Мирный"}	(114.03900146484375,62.534698486328125)	Asia/Yakutsk
KHV	{"en": "Khabarovsk-Novy Airport", "ru": "Хабаровск-Новый"}	{"en": "Khabarovsk", "ru": "Хабаровск"}	(135.18800354004,48.52799987793)	Asia/Vladivostok
PKC	{"en": "Yelizovo Airport", "ru": "Елизово"}	{"en": "Petropavlovsk", "ru": "Петропавловск-Камчатский"}	(158.45399475097656,53.16790008544922)	Asia/Kamchatka
UUS	{"en": "Yuzhno-Sakhalinsk Airport", "ru": "Хомутово"}	{"en": "Yuzhno-Sakhalinsk", "ru": "Южно-Сахалинск"}	(142.71800231933594,46.88869857788086)	Asia/Sakhalin
VVO	{"en": "Vladivostok International Airport", "ru": "Владивосток"}	{"en": "Vladivostok", "ru": "Владивосток"}	(132.1479949951172,43.39899826049805)	Asia/Vladivostok
LED	{"en": "Pulkovo Airport", "ru": "Пулково"}	{"en": "St. Petersburg", "ru": "Санкт-Петербург"}	(30.262500762939453,59.80030059814453)	Europe/Moscow
KGD	{"en": "Khrabrovo Airport", "ru": "Храброво"}	{"en": "Kaliningrad", "ru": "Калининград"}	(20.592599868774414,54.88999938964844)	Europe/Kaliningrad
KEJ	{"en": "Kemerovo Airport", "ru": "Кемерово"}	{"en": "Kemorovo", "ru": "Кемерово"}	(86.1072006225586,55.27009963989258)	Asia/Novokuznetsk
CEK	{"en": "Chelyabinsk Balandino Airport", "ru": "Челябинск"}	{"en": "Chelyabinsk", "ru": "Челябинск"}	(61.5033,55.305801)	Asia/Yekaterinburg
MQF	{"en": "Magnitogorsk International Airport", "ru": "Магнитогорск"}	{"en": "Magnetiogorsk", "ru": "Магнитогорск"}	(58.755699157714844,53.39310073852539)	Asia/Yekaterinburg
PEE	{"en": "Bolshoye Savino Airport", "ru": "Пермь"}	{"en": "Perm", "ru": "Пермь"}	(56.021198272705,57.914501190186)	Asia/Yekaterinburg
SGC	{"en": "Surgut Airport", "ru": "Сургут"}	{"en": "Surgut", "ru": "Сургут"}	(73.40180206298828,61.34370040893555)	Asia/Yekaterinburg
BZK	{"en": "Bryansk Airport", "ru": "Брянск"}	{"en": "Bryansk", "ru": "Брянск"}	(34.176399231,53.214199066199996)	Europe/Moscow
MRV	{"en": "Mineralnyye Vody Airport", "ru": "Минеральные Воды"}	{"en": "Mineralnye Vody", "ru": "Минеральные Воды"}	(43.08190155029297,44.225101470947266)	Europe/Moscow
STW	{"en": "Stavropol Shpakovskoye Airport", "ru": "Ставрополь"}	{"en": "Stavropol", "ru": "Ставрополь"}	(42.11280059814453,45.10919952392578)	Europe/Moscow
ASF	{"en": "Astrakhan Airport", "ru": "Астрахань"}	{"en": "Astrakhan", "ru": "Астрахань"}	(48.0063018799,46.2832984924)	Europe/Samara
NJC	{"en": "Nizhnevartovsk Airport", "ru": "Нижневартовск"}	{"en": "Nizhnevartovsk", "ru": "Нижневартовск"}	(76.48359680175781,60.94929885864258)	Asia/Yekaterinburg
SVX	{"en": "Koltsovo Airport", "ru": "Кольцово"}	{"en": "Yekaterinburg", "ru": "Екатеринбург"}	(60.802700042725,56.743099212646)	Asia/Yekaterinburg
SVO	{"en": "Sheremetyevo International Airport", "ru": "Шереметьево"}	{"en": "Moscow", "ru": "Москва"}	(37.4146,55.972599)	Europe/Moscow
VOZ	{"en": "Voronezh International Airport", "ru": "Воронеж"}	{"en": "Voronezh", "ru": "Воронеж"}	(39.22959899902344,51.81420135498047)	Europe/Moscow
VKO	{"en": "Vnukovo International Airport", "ru": "Внуково"}	{"en": "Moscow", "ru": "Москва"}	(37.2615013123,55.5914993286)	Europe/Moscow
SCW	{"en": "Syktyvkar Airport", "ru": "Сыктывкар"}	{"en": "Syktyvkar", "ru": "Сыктывкар"}	(50.84510040283203,61.64699935913086)	Europe/Moscow
KUF	{"en": "Kurumoch International Airport", "ru": "Курумоч"}	{"en": "Samara", "ru": "Самара"}	(50.16429901123,53.504901885986)	Europe/Samara
DME	{"en": "Domodedovo International Airport", "ru": "Домодедово"}	{"en": "Moscow", "ru": "Москва"}	(37.90629959106445,55.40879821777344)	Europe/Moscow
TJM	{"en": "Roshchino International Airport", "ru": "Рощино"}	{"en": "Tyumen", "ru": "Тюмень"}	(65.3243026733,57.189601898199996)	Asia/Yekaterinburg
GOJ	{"en": "Nizhny Novgorod Strigino International Airport", "ru": "Стригино"}	{"en": "Nizhniy Novgorod", "ru": "Нижний Новгород"}	(43.784000396729,56.230098724365)	Europe/Moscow
TOF	{"en": "Bogashevo Airport", "ru": "Богашёво"}	{"en": "Tomsk", "ru": "Томск"}	(85.208297729492,56.380298614502)	Asia/Krasnoyarsk
UIK	{"en": "Ust-Ilimsk Airport", "ru": "Усть-Илимск"}	{"en": "Ust Ilimsk", "ru": "Усть-Илимск"}	(102.56500244140625,58.13610076904297)	Asia/Irkutsk
NSK	{"en": "Norilsk-Alykel Airport", "ru": "Норильск"}	{"en": "Norilsk", "ru": "Норильск"}	(87.33219909667969,69.31109619140625)	Asia/Krasnoyarsk
ARH	{"en": "Talagi Airport", "ru": "Талаги"}	{"en": "Arkhangelsk", "ru": "Архангельск"}	(40.71670150756836,64.60030364990234)	Europe/Moscow
RTW	{"en": "Saratov Central Airport", "ru": "Саратов-Центральный"}	{"en": "Saratov", "ru": "Саратов"}	(46.04669952392578,51.564998626708984)	Europe/Volgograd
NUX	{"en": "Novy Urengoy Airport", "ru": "Новый Уренгой"}	{"en": "Novy Urengoy", "ru": "Новый Уренгой"}	(76.52030181884766,66.06939697265625)	Asia/Yekaterinburg
NOJ	{"en": "Noyabrsk Airport", "ru": "Ноябрьск"}	{"en": "Noyabrsk", "ru": "Ноябрьск"}	(75.2699966430664,63.18330001831055)	Asia/Yekaterinburg
UCT	{"en": "Ukhta Airport", "ru": "Ухта"}	{"en": "Ukhta", "ru": "Ухта"}	(53.8046989440918,63.566898345947266)	Europe/Moscow
USK	{"en": "Usinsk Airport", "ru": "Усинск"}	{"en": "Usinsk", "ru": "Усинск"}	(57.3671989440918,66.00469970703125)	Europe/Moscow
NNM	{"en": "Naryan Mar Airport", "ru": "Нарьян-Мар"}	{"en": "Naryan-Mar", "ru": "Нарьян-Мар"}	(53.12189865112305,67.63999938964844)	Europe/Moscow
PKV	{"en": "Pskov Airport", "ru": "Псков"}	{"en": "Pskov", "ru": "Псков"}	(28.395599365234375,57.78390121459961)	Europe/Moscow
KGP	{"en": "Kogalym International Airport", "ru": "Когалым"}	{"en": "Kogalym", "ru": "Когалым"}	(74.53379821777344,62.190399169921875)	Asia/Yekaterinburg
KJA	{"en": "Yemelyanovo Airport", "ru": "Емельяново"}	{"en": "Krasnoyarsk", "ru": "Красноярск"}	(92.493301391602,56.172901153564)	Asia/Krasnoyarsk
URJ	{"en": "Uray Airport", "ru": "Петрозаводск"}	{"en": "Uraj", "ru": "Урай"}	(64.82669830322266,60.10329818725586)	Asia/Yekaterinburg
IWA	{"en": "Ivanovo South Airport", "ru": "Иваново-Южный"}	{"en": "Ivanovo", "ru": "Иваново"}	(40.940799713134766,56.93939971923828)	Europe/Moscow
PYJ	{"en": "Polyarny Airport", "ru": "Полярный"}	{"en": "Yakutia", "ru": "Удачный"}	(112.029998779,66.4003982544)	Asia/Yakutsk
KXK	{"en": "Komsomolsk-on-Amur Airport", "ru": "Хурба"}	{"en": "Komsomolsk-on-Amur", "ru": "Комсомольск-на-Амуре"}	(136.9340057373047,50.409000396728516)	Asia/Vladivostok
DYR	{"en": "Ugolny Airport", "ru": "Анадырь"}	{"en": "Anadyr", "ru": "Анадырь"}	(177.74099731445312,64.73490142822266)	Asia/Anadyr
PES	{"en": "Petrozavodsk Airport", "ru": "Бесовец"}	{"en": "Petrozavodsk", "ru": "Петрозаводск"}	(34.154701232910156,61.88520050048828)	Europe/Moscow
KYZ	{"en": "Kyzyl Airport", "ru": "Кызыл"}	{"en": "Kyzyl", "ru": "Кызыл"}	(94.40059661865234,51.66939926147461)	Asia/Krasnoyarsk
NOZ	{"en": "Spichenkovo Airport", "ru": "Спиченково"}	{"en": "Novokuznetsk", "ru": "Новокузнецк"}	(86.877197265625,53.8114013671875)	Asia/Novokuznetsk
GRV	{"en": "Khankala Air Base", "ru": "Грозный"}	{"en": "Grozny", "ru": "Грозный"}	(45.78409957885742,43.298099517822266)	Europe/Moscow
NAL	{"en": "Nalchik Airport", "ru": "Нальчик"}	{"en": "Nalchik", "ru": "Нальчик"}	(43.636600494384766,43.512901306152344)	Europe/Moscow
OGZ	{"en": "Beslan Airport", "ru": "Беслан"}	{"en": "Beslan", "ru": "Владикавказ"}	(44.6066017151,43.2051010132)	Europe/Moscow
ESL	{"en": "Elista Airport", "ru": "Элиста"}	{"en": "Elista", "ru": "Элиста"}	(44.33089828491211,46.3739013671875)	Europe/Moscow
SLY	{"en": "Salekhard Airport", "ru": "Салехард"}	{"en": "Salekhard", "ru": "Салехард"}	(66.61100006103516,66.5907974243164)	Asia/Yekaterinburg
HMA	{"en": "Khanty Mansiysk Airport", "ru": "Ханты-Мансийск"}	{"en": "Khanty-Mansiysk", "ru": "Ханты-Мансийск"}	(69.08609771728516,61.028499603271484)	Asia/Yekaterinburg
NYA	{"en": "Nyagan Airport", "ru": "Нягань"}	{"en": "Nyagan", "ru": "Нягань"}	(65.61499786376953,62.11000061035156)	Asia/Yekaterinburg
OVS	{"en": "Sovetskiy Airport", "ru": "Советский"}	{"en": "Sovetskiy", "ru": "Советский"}	(63.60191345214844,61.326622009277344)	Asia/Yekaterinburg
IJK	{"en": "Izhevsk Airport", "ru": "Ижевск"}	{"en": "Izhevsk", "ru": "Ижевск"}	(53.45750045776367,56.82809829711914)	Europe/Samara
KVX	{"en": "Pobedilovo Airport", "ru": "Победилово"}	{"en": "Kirov", "ru": "Киров"}	(49.348300933838,58.503299713135)	Europe/Moscow
NYM	{"en": "Nadym Airport", "ru": "Надым"}	{"en": "Nadym", "ru": "Надым"}	(72.69889831542969,65.48090362548828)	Asia/Yekaterinburg
NFG	{"en": "Nefteyugansk Airport", "ru": "Нефтеюганск"}	{"en": "Nefteyugansk", "ru": "Нефтеюганск"}	(72.6500015258789,61.108299255371094)	Asia/Yekaterinburg
KRO	{"en": "Kurgan Airport", "ru": "Курган"}	{"en": "Kurgan", "ru": "Курган"}	(65.41560363769531,55.47529983520508)	Asia/Yekaterinburg
EGO	{"en": "Belgorod International Airport", "ru": "Белгород"}	{"en": "Belgorod", "ru": "Белгород"}	(36.5900993347168,50.643798828125)	Europe/Moscow
URS	{"en": "Kursk East Airport", "ru": "Курск-Восточный"}	{"en": "Kursk", "ru": "Курск"}	(36.29560089111328,51.7505989074707)	Europe/Moscow
LPK	{"en": "Lipetsk Airport", "ru": "Липецк"}	{"en": "Lipetsk", "ru": "Липецк"}	(39.53779983520508,52.70280075073242)	Europe/Moscow
VKT	{"en": "Vorkuta Airport", "ru": "Воркута"}	{"en": "Vorkuta", "ru": "Воркута"}	(63.993099212646484,67.48860168457031)	Europe/Moscow
UUA	{"en": "Bugulma Airport", "ru": "Бугульма"}	{"en": "Bugulma", "ru": "Бугульма"}	(52.801700592041016,54.63999938964844)	Europe/Moscow
JOK	{"en": "Yoshkar-Ola Airport", "ru": "Йошкар-Ола"}	{"en": "Yoshkar-Ola", "ru": "Йошкар-Ола"}	(47.904701232910156,56.700599670410156)	Europe/Moscow
CSY	{"en": "Cheboksary Airport", "ru": "Чебоксары"}	{"en": "Cheboksary", "ru": "Чебоксары"}	(47.3473014831543,56.090301513671875)	Europe/Moscow
ULY	{"en": "Ulyanovsk East Airport", "ru": "Ульяновск-Восточный"}	{"en": "Ulyanovsk", "ru": "Ульяновск"}	(48.80270004272461,54.4010009765625)	Europe/Samara
OSW	{"en": "Orsk Airport", "ru": "Орск"}	{"en": "Orsk", "ru": "Орск"}	(58.59560012817383,51.0724983215332)	Asia/Yekaterinburg
PEZ	{"en": "Penza Airport", "ru": "Пенза"}	{"en": "Penza", "ru": "Пенза"}	(45.02109909057617,53.110599517822266)	Europe/Moscow
SKX	{"en": "Saransk Airport", "ru": "Саранск"}	{"en": "Saransk", "ru": "Саранск"}	(45.212257385253906,54.12512969970703)	Europe/Moscow
TBW	{"en": "Donskoye Airport", "ru": "Донское"}	{"en": "Tambow", "ru": "Тамбов"}	(41.482799530029,52.806098937988)	Europe/Moscow
UKX	{"en": "Ust-Kut Airport", "ru": "Усть-Кут"}	{"en": "Ust-Kut", "ru": "Усть-Кут"}	(105.7300033569336,56.8567008972168)	Asia/Irkutsk
GDZ	{"en": "Gelendzhik Airport", "ru": "Геленджик"}	{"en": "Gelendzhik", "ru": "Геленджик"}	(38.0124807358,44.5820926295)	Europe/Moscow
IAR	{"en": "Tunoshna Airport", "ru": "Туношна"}	{"en": "Yaroslavl", "ru": "Ярославль"}	(40.15739822387695,57.560699462890625)	Europe/Moscow
NBC	{"en": "Begishevo Airport", "ru": "Бегишево"}	{"en": "Nizhnekamsk", "ru": "Нижнекамск"}	(52.092498779296875,55.564701080322266)	Europe/Moscow
ULV	{"en": "Ulyanovsk Baratayevka Airport", "ru": "Баратаевка"}	{"en": "Ulyanovsk", "ru": "Ульяновск"}	(48.226699829100006,54.26829910279999)	Europe/Samara
SWT	{"en": "Strezhevoy Airport", "ru": "Стрежевой"}	{"en": "Strezhevoy", "ru": "Стрежевой"}	(77.66000366210001,60.709400177)	Asia/Krasnoyarsk
EYK	{"en": "Beloyarskiy Airport", "ru": "Белоярский"}	{"en": "Beloyarsky", "ru": "Белоярский"}	(66.698600769,63.686901092499994)	Asia/Yekaterinburg
KLF	{"en": "Grabtsevo Airport", "ru": "Калуга"}	{"en": "Kaluga", "ru": "Калуга"}	(36.3666687012,54.5499992371)	Europe/Moscow
RGK	{"en": "Gorno-Altaysk Airport", "ru": "Горно-Алтайск"}	{"en": "Gorno-Altaysk", "ru": "Горно-Алтайск"}	(85.8332977295,51.9667015076)	Asia/Krasnoyarsk
KRR	{"en": "Krasnodar Pashkovsky International Airport", "ru": "Краснодар"}	{"en": "Krasnodar", "ru": "Краснодар"}	(39.170501708984,45.034698486328)	Europe/Moscow
MCX	{"en": "Uytash Airport", "ru": "Уйташ"}	{"en": "Makhachkala", "ru": "Махачкала"}	(47.65230178833008,42.81679916381836)	Europe/Moscow
KZN	{"en": "Kazan International Airport", "ru": "Казань"}	{"en": "Kazan", "ru": "Казань"}	(49.278701782227,55.606201171875)	Europe/Moscow
REN	{"en": "Orenburg Central Airport", "ru": "Оренбург-Центральный"}	{"en": "Orenburg", "ru": "Оренбург"}	(55.45669937133789,51.795799255371094)	Asia/Yekaterinburg
UFA	{"en": "Ufa International Airport", "ru": "Уфа"}	{"en": "Ufa", "ru": "Уфа"}	(55.874401092529,54.557498931885)	Asia/Yekaterinburg
OVB	{"en": "Tolmachevo Airport", "ru": "Толмачёво"}	{"en": "Novosibirsk", "ru": "Новосибирск"}	(82.650703430176,55.012599945068)	Asia/Novosibirsk
CEE	{"en": "Cherepovets Airport", "ru": "Череповец"}	{"en": "Cherepovets", "ru": "Череповец"}	(38.015800476100004,59.273601532)	Europe/Moscow
OMS	{"en": "Omsk Central Airport", "ru": "Омск-Центральный"}	{"en": "Omsk", "ru": "Омск"}	(73.31050109863281,54.96699905395508)	Asia/Omsk
ROV	{"en": "Rostov-on-Don Airport", "ru": "Ростов-на-Дону"}	{"en": "Rostov", "ru": "Ростов-на-Дону"}	(39.8180999756,47.2582015991)	Europe/Moscow
AER	{"en": "Sochi International Airport", "ru": "Сочи"}	{"en": "Sochi", "ru": "Сочи"}	(39.956600189209,43.449901580811)	Europe/Moscow
VOG	{"en": "Volgograd International Airport", "ru": "Гумрак"}	{"en": "Volgograd", "ru": "Волгоград"}	(44.34550094604492,48.782501220703125)	Europe/Volgograd
BQS	{"en": "Ignatyevo Airport", "ru": "Игнатьево"}	{"en": "Blagoveschensk", "ru": "Благовещенск"}	(127.41200256347656,50.42539978027344)	Asia/Yakutsk
GDX	{"en": "Sokol Airport", "ru": "Магадан"}	{"en": "Magadan", "ru": "Магадан"}	(150.72000122070312,59.9109992980957)	Asia/Magadan
HTA	{"en": "Chita-Kadala Airport", "ru": "Чита"}	{"en": "Chita", "ru": "Чита"}	(113.306,52.026299)	Asia/Chita
BTK	{"en": "Bratsk Airport", "ru": "Братск"}	{"en": "Bratsk", "ru": "Братск"}	(101.697998046875,56.370601654052734)	Asia/Irkutsk
IKT	{"en": "Irkutsk Airport", "ru": "Иркутск"}	{"en": "Irkutsk", "ru": "Иркутск"}	(104.38899993896,52.268001556396)	Asia/Irkutsk
UUD	{"en": "Ulan-Ude Airport (Mukhino)", "ru": "Байкал"}	{"en": "Ulan-ude", "ru": "Улан-Удэ"}	(107.43800354003906,51.80780029296875)	Asia/Irkutsk
MMK	{"en": "Murmansk Airport", "ru": "Мурманск"}	{"en": "Murmansk", "ru": "Мурманск"}	(32.75080108642578,68.78170013427734)	Europe/Moscow
ABA	{"en": "Abakan Airport", "ru": "Абакан"}	{"en": "Abakan", "ru": "Абакан"}	(91.38500213623047,53.7400016784668)	Asia/Krasnoyarsk
BAX	{"en": "Barnaul Airport", "ru": "Барнаул"}	{"en": "Barnaul", "ru": "Барнаул"}	(83.53849792480469,53.363800048828125)	Asia/Krasnoyarsk
AAQ	{"en": "Anapa Vityazevo Airport", "ru": "Витязево"}	{"en": "Anapa", "ru": "Анапа"}	(37.347301483154,45.002101898193)	Europe/Moscow
CNN	{"en": "Chulman Airport", "ru": "Чульман"}	{"en": "Neryungri", "ru": "Нерюнгри"}	(124.91400146484,56.913898468018)	Asia/Yakutsk
\.


--
-- Name: flights_flight_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.flights_flight_id_seq', 1, false);


--
-- PostgreSQL database dump complete
--

