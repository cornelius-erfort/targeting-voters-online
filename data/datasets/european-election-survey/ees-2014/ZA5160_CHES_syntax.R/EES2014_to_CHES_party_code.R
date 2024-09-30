####Connect CHES party_id with EES 2014 ees_party_id variable
#this do-file is to be executed on the EES 2014 data file to bring in CHES party_id codes

#generate CHES id variable 
data$party_id<-NA  
  
  #connect CHES ID with the appropriate party EES 2014 respondent voted for


### IMPORTANT - Missing denotes that corresponding code in CHES is missing ***
  
  
  #note, must define ees_party_id variabe as either 
#qpp5_ees lastvote
#qpp6_ees todayvote
#qp2_ees epvote
#prior to running this code


# Austria
data$party_id[ees_party_id==1040520] <- 1302 # AT OVP
data$party_id[ees_party_id==1040302] <- 1301 # AT SPO 
data$party_id[ees_party_id==1040423] <- 1309 # AT NEOS 
data$party_id[ees_party_id==1040110] <- 1304 # AT Grune 
data$party_id[ees_party_id==1040420] <- 1303 # AT FPO 
data$party_id[ees_party_id==1040600] <- 1307 # AT BZO


# Belgium (Flanders & Wallonia)
data$party_id[ees_party_id==1056325] <- 119 ##  BE PVDA
data$party_id[ees_party_id==1056521] <- 109 ##  BE CD&V
data$party_id[ees_party_id==1056327] <- 103 ##  BE SPA
data$party_id[ees_party_id==1056421] <- 107 ##  BE VLD
data$party_id[ees_party_id==1056913] <- 110 ##  BE NVA
data$party_id[ees_party_id==1056112] <- 105 ##  BE Groen
data$party_id[ees_party_id==1056711] <- 112 ##  BE VB
data$party_id[ees_party_id==1056522] <- 108 #   BE cdH
data$party_id[ees_party_id==1056322] <- 102 #   BE PS
data$party_id[ees_party_id==1056427] <- 106 #   BE MR
data$party_id[ees_party_id==1056111] <- 104 #   BE ECOLO


# Bulgaria (1100300, 1100601, 1100400 missing)
data$party_id[ees_party_id==1100600] <- 2010 # BG GERB
data$party_id[ees_party_id==1100900] <- 2004 # BG DPS
data$party_id[ees_party_id==1100700] <- 2007 # BG Attack
data$party_id[ees_party_id==1100602] <- 2015 # BG BBT
data$party_id[ees_party_id==1103001] <- 2016 # BG ABV
data$party_id[ees_party_id==1100001] <- 2002 # BG SDS


# Cyrpus (1196002 is missing)
data$party_id[ees_party_id==1196711] <- 4001 # CY DISY
data$party_id[ees_party_id==1196422] <- 4004 # CY DIKO
data$party_id[ees_party_id==1196322] <- 4005 # CY EDEK
data$party_id[ees_party_id==1196321] <- 4003 # CY AKEL
data$party_id[ees_party_id==1196110] <- 4006 # CY KOP


# Czech Republic (1203321 1203110 is missing)
data$party_id[ees_party_id==1203523] <- 2104 #  CZ KDU-CSL
data$party_id[ees_party_id==1203530] <- 2109 #  CZ TOP09
data$party_id[ees_party_id==1203320] <- 2101 #  CZ CSSD
data$party_id[ees_party_id==1203413] <- 2102 #  CZ ODS
data$party_id[ees_party_id==1203220] <- 2103 #  CZ KSCM
data$party_id[ees_party_id==1203413] <- 2111 #  CZ ANO2011
data$party_id[ees_party_id==1203953] <- 2113 #  CZ SVOBODNI


# Germany
data$party_id[ees_party_id==1276521] <- 301 # GE CDU
data$party_id[ees_party_id==1276320] <- 302 # GE SPD
data$party_id[ees_party_id==1276420] <- 303 # GE FDP
data$party_id[ees_party_id==1276113] <- 304 # GE Grunen
data$party_id[ees_party_id==1276321] <- 306 # GE Linke
data$party_id[ees_party_id==1276621] <- 310 # GE AfD
data$party_id[ees_party_id==1276951] <- 311 # GE Piraten


# Denmark (FolkB is missing)
data$party_id[ees_party_id==1208320] <- 201 # DK SD
data$party_id[ees_party_id==1208420] <- 211 # DK V
data$party_id[ees_party_id==1208330] <- 206 # DK SF
data$party_id[ees_party_id==1208720] <- 215 # DK DF
data$party_id[ees_party_id==1208410] <- 202 # DK RV
data$party_id[ees_party_id==1208421] <- 218 # DK LA
data$party_id[ees_party_id==1208620] <- 203 # DK KF


# Estonia (1233003 is missing)
data$party_id[ees_party_id==1233613] <- 2201 # EE IRL
data$party_id[ees_party_id==1233410] <- 2204 # EE SDE
data$party_id[ees_party_id==1233430] <- 2203 # EE ER
data$party_id[ees_party_id==1233411] <- 2202 # EE EK
data$party_id[ees_party_id==1233100] <- 2207 # EE EER


# Greece (1300116 is missing)
data$party_id[ees_party_id==1300511] <- 402 # GR ND
data$party_id[ees_party_id==1300215] <- 403 # GR SYRIZA
data$party_id[ees_party_id==1300313] <- 401 # GR PASOK
data$party_id[ees_party_id==1300611] <- 401 # GR ANEL
data$party_id[ees_party_id==1300710] <- 415 # GR XA
data$party_id[ees_party_id==1300225] <- 414 # GR DIMAR
data$party_id[ees_party_id==1300210] <- 404 # GR KKE
data$party_id[ees_party_id==1300323] <- 413 # GR Potami
data$party_id[ees_party_id==1300703] <- 410 # GR LAOS


# Spain 
data$party_id[ees_party_id==1724610] <- 502 # ESP PP
data$party_id[ees_party_id==1724320] <- 501 # ESP PSOE
data$party_id[ees_party_id==1724220] <- 504 # ESP IU
data$party_id[ees_party_id==1724010] <- 523 # ESP UPyd
data$party_id[ees_party_id==1724905] <- 511 # ESP ERC
data$party_id[ees_party_id==1724310] <- 526 # ESP Cs
data$party_id[ees_party_id==1724230] <- 525 # ESP Podemos
data$party_id[ees_party_id==1724007] <- 505 # ESP CiU
data$party_id[ees_party_id==1724902] <- 506 # ESP EAJ-PNV
data$party_id[ees_party_id==1724908] <- 513 # ESP BNG
data$party_id[ees_party_id==1724907] <- 517 # ESP CC


# Finland
data$party_id[ees_party_id==1246620] <- 1402 # FI KOK
data$party_id[ees_party_id==1246520] <- 1409 # FI KD
data$party_id[ees_party_id==1246320] <- 1401 # FI SDP
data$party_id[ees_party_id==1246810] <- 1403 # FI KESK
data$party_id[ees_party_id==1246901] <- 1406 # FI RKP/SFP
data$party_id[ees_party_id==1246110] <- 1408 # FI VIHR
data$party_id[ees_party_id==1246223] <- 1404 # FI VAS
data$party_id[ees_party_id==1246820] <- 1405 # FI PS


# France (Please check for 1250223. 1250636, 1250233 are missing)
data$party_id[ees_party_id==1250626] <- 609 # FR UMP
data$party_id[ees_party_id==1250320] <- 602 # FR PS
data$party_id[ees_party_id==1250720] <- 610 # FR FN
data$party_id[ees_party_id==1250110] <- 605 # FR EELV
data$party_id[ees_party_id==1250223] <- 601 # FR PCF
data$party_id[ees_party_id==1250336] <- 613 # FR MODEM


# Hungary
data$party_id[ees_party_id==1348700] <- 2308 # HU JOBBIK
data$party_id[ees_party_id==1348110] <- 2309 # HU LMP
data$party_id[ees_party_id==1348421] <- 2302 # HU Fidesz
data$party_id[ees_party_id==1348220] <- 2301 # HU MSzP
data$party_id[ees_party_id==1348120] <- 2310 # HU E14
data$party_id[ees_party_id==1348330] <- 2311 # HU DK


# Ireland
data$party_id[ees_party_id==1372520] <- 702 # IE FG
data$party_id[ees_party_id==1372320] <- 703 # IE Lab
data$party_id[ees_party_id==1372620] <- 701 # IE FF
data$party_id[ees_party_id==1372110] <- 705 # IE GP
data$party_id[ees_party_id==1372951] <- 707 # IE SF
data$party_id[ees_party_id==1372220] <- 708 # IE SP


# Italy (1380902, 1380630 are missing)
data$party_id[ees_party_id==1380331] <- 837 # IT PD
data$party_id[ees_party_id==1380610] <- 815 # IT FI
data$party_id[ees_party_id==1380720] <- 811 # IT LN
data$party_id[ees_party_id==1380956] <- 845 # IT M5S
data$party_id[ees_party_id==1380523] <- 814 # IT UDC
data$party_id[ees_party_id==1380007] <- 838 # IT SEl
data$party_id[ees_party_id==1380633] <- 848 # IT NCD
data$party_id[ees_party_id==1380631] <- 844 # IT FDL
data$party_id[ees_party_id==1380958] <- 827 # IT SVP


# Lithuania (1440420 is missing)
data$party_id[ees_party_id==1440620] <- 2506 # LT TS-LKD
data$party_id[ees_party_id==1440320] <- 2501 # LT LSDP
data$party_id[ees_party_id==1440421] <- 2518 # LT LRLS
data$party_id[ees_party_id==1440322] <- 2516 # LT DP
data$party_id[ees_party_id==1440621] <- 2515 # LT TT
data$party_id[ees_party_id==1440952] <- 2511 # LT LLRA
data$party_id[ees_party_id==1440524] <- 2507 # LT LVZS


# Luxembourg (1442220 is missing)
data$party_id[ees_party_id==1442520] <- 3801 # LU CSV
data$party_id[ees_party_id==1442320] <- 3804 # LU LSAP
data$party_id[ees_party_id==1442420] <- 3803 # LU DP
data$party_id[ees_party_id==1442113] <- 3802 # LU Greng
data$party_id[ees_party_id==1442222] <- 3806 # LU DL
data$party_id[ees_party_id==1442951] <- 3805 # LU ADR


# Latvia (1428620 1428422 1428424 are missing)
data$party_id[ees_party_id==1428610] <- 2412 # LV V
data$party_id[ees_party_id==1428317] <- 2410 # LV SDPS
data$party_id[ees_party_id==1428723] <- 2406 # LV NA
data$party_id[ees_party_id==1428110] <- 2405 # LV ZZS
data$party_id[ees_party_id==1428901] <- 2402 # LV LKS 


# Malta (1470100 is missing)
data$party_id[ees_party_id==1470300] <- 3701 # MT PL
data$party_id[ees_party_id==1470500] <- 3702 # MT PN


# Netherlands (1528528 - please check. EES codes as coalition of 2 parties)
data$party_id[ees_party_id==1528420] <- 1003 # NL VVD
data$party_id[ees_party_id==1528320] <- 1002 # NL PvdA
data$party_id[ees_party_id==1528600] <- 1017 # NL PVV
data$party_id[ees_party_id==1528220] <- 1014 # NL SP
data$party_id[ees_party_id==1528521] <- 1001 # NL CDA
data$party_id[ees_party_id==1528330] <- 1004 # NL D66
data$party_id[ees_party_id==1528526] <- 1016 # NL CU
data$party_id[ees_party_id==1528110] <- 1005 # NL GL
data$party_id[ees_party_id==1528951] <- 1018 # NL PvdD


# Poland
data$party_id[ees_party_id==1616435] <- 2603 # PL PO
data$party_id[ees_party_id==1616811] <- 2606 # PL PSL
data$party_id[ees_party_id==1616210] <- 2601 # PL SLD
data$party_id[ees_party_id==1616436] <- 2605 # PL PiS
data$party_id[ees_party_id==1616310] <- 2613 # PL RP
data$party_id[ees_party_id==1616001] <- 2614 # PL KNP
data$party_id[ees_party_id==1616002] <- 2616 # PL SP


# Portugal (1620314 - please check. EES codes as coalition of 2 parties)
data$party_id[ees_party_id==1620313] <- 1206 # PT PSD
data$party_id[ees_party_id==1620520] <- 1202 # PT PP
data$party_id[ees_party_id==1620311] <- 1205 # PT PS
data$party_id[ees_party_id==1620229] <- 1201 # PT CDU
data$party_id[ees_party_id==1620211] <- 1208 # PT BE
data$party_id[ees_party_id==1620110] <- 1209 # PT MPT


# Romania (1642700, 1642800 are missing. 1642502 is a coalition)
data$party_id[ees_party_id==1642300] <- 2701 # RO PSD
data$party_id[ees_party_id==1642401] <- 2705 # RO PNL
data$party_id[ees_party_id==1642400] <- 2704 # RO PDL
data$party_id[ees_party_id==1642981] <- 2710 # RO PP-DD
data$party_id[ees_party_id==1642900] <- 2706 # RO UDMR
data$party_id[ees_party_id==1642503] <- 2711 # RO PMP
data$party_id[ees_party_id==1642600] <- 2702 # RO PC


# Sweden
data$party_id[ees_party_id==1752320] <- 1602 # SE SAP
data$party_id[ees_party_id==1752620] <- 1605 # SE M
data$party_id[ees_party_id==1752110] <- 1607 # SE MP
data$party_id[ees_party_id==1752420] <- 1604 # SE FP
data$party_id[ees_party_id==1752810] <- 1603 # SE C
data$party_id[ees_party_id==1752700] <- 1610 # SE SD
data$party_id[ees_party_id==1752520] <- 1606 # SE KD
data$party_id[ees_party_id==1752220] <- 1601 # SE V
data$party_id[ees_party_id==1752953] <- 1612 # SE FI
data$party_id[ees_party_id==1752000] <- 1611 # SE PP


# Slovenia (1705450, 1705421, 1705324, 1705710, 1705952 are missing)
data$party_id[ees_party_id==1705340] <- 2914 # SI PS
data$party_id[ees_party_id==1705320] <- 2902 # SI SDS
data$party_id[ees_party_id==1705323] <- 2903 # SI SD
data$party_id[ees_party_id==1705951] <- 2906 # SI DeSUS
data$party_id[ees_party_id==1705522] <- 2905 # SI NSI
data$party_id[ees_party_id==1705521] <- 2904 # SI SLS


# Slovakia (1703222 is missing)
data$party_id[ees_party_id==1703521] <- 2805 # SK KDH
data$party_id[ees_party_id==1703523] <- 2802 # SK SDKU-DS
data$party_id[ees_party_id==1703954] <- 2804 # SK SMK-MKP
data$party_id[ees_party_id==1703423] <- 2803 # SK Smer-SD
data$party_id[ees_party_id==1703610] <- 2815 # SK NOVA
data$party_id[ees_party_id==1703440] <- 2812 # SK SaS
data$party_id[ees_party_id==1703620] <- 2814 # SK OLaNO
data$party_id[ees_party_id==1703955] <- 2813 # SK MH
data$party_id[ees_party_id==1703710] <- 2809 # SK SNS


# UK (1826210, 1826903, 1826724, 1826720 are missing)
data$party_id[ees_party_id==1826620] <- 1101 # UK Cons
data$party_id[ees_party_id==1826320] <- 1102 # UK Lab
data$party_id[ees_party_id==1826421] <- 1104 # UK LibDems
data$party_id[ees_party_id==1826110] <- 1107 # UK Green
data$party_id[ees_party_id==1826951] <- 1108 # UK UKIP
data$party_id[ees_party_id==1826902] <- 1105 # UK SNP
data$party_id[ees_party_id==1826901] <- 1106 # UK Plaid


# Croatia
data$party_id[ees_party_id==1191320] <- 3102 # HR SDP
data$party_id[ees_party_id==1191412] <- 3105 # HR HNS
data$party_id[ees_party_id==1191511] <- 3101 # HR HDZ
data$party_id[ees_party_id==1191613] <- 3109 # HR HSP
data$party_id[ees_party_id==1191410] <- 3104 # HR HSLS
data$party_id[ees_party_id==1191952] <- 3107 # HR HDSSB
data$party_id[ees_party_id==1191330] <- 3112 # HR HL-SR
data$party_id[ees_party_id==1191110] <- 3114 # HR ORaH
