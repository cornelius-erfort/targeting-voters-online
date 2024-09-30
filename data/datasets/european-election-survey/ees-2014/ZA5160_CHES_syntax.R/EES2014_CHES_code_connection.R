# Connection of EES and CHES party codes

##note that  'party_ees' is the ees party code in variable qpp14_ 
## it takes on values 1 to 8 and needs to be connected with the correct country ('countrycode')

## note that party_id is the CHES party code 
## it takes on values  102 to 4006, it does not need to be connected with country


###REMARKS ###

#1) Coalition for Bulgaria (EES code - qpp14_2) is a coalition of the Bulgarian Socialist Party and other minor parties,
#   thus it will be idetified as the Bulgarian Socialist Party, CHES code 2003.
#2) Reformist Bloc (EES code - qpp14_5) is a coalition of the Democrats for a Strong Bulgaria  and other minor parties,
#   thus it will be idetified as the Democrats for a Strong Bulgaria, CHES code 2008.
#3) In spain PAIN: Coalicion por Europa (EES code - qpp14_5), is a coalition of the follwing CHES parties: 
#  Convergence and Union(505), Basque Nationalist Party(506), Canarian Coalition(517) and other small parties 

# Austria
data$party_id[party_ees==1 & countrycode == 1040] <- 1302 # Austria. OVP
data$party_id[party_ees==2 & countrycode == 1040] <- 1301 # Austria. SPO 
data$party_id[party_ees==3 & countrycode == 1040] <- 1309 # Austria. NEOS 
data$party_id[party_ees==4 & countrycode == 1040] <- 1304 # Austria. Grune 
data$party_id[party_ees==5 & countrycode == 1040] <- 1303 # Austria. FPO 
data$party_id[party_ees==6 & countrycode == 1040] <- 1307 # Austria. BZO

# Belgium (Flanders)
data$party_id[party_ees==1 & countrycode == 1056] <- 119 ## Belgium (Flanders). PVDA
data$party_id[party_ees==2 & countrycode == 1056] <- 109 ## Belgium (Flanders). CD&V
data$party_id[party_ees==3 & countrycode == 1056] <- 103 ## Belgium (Flanders). SPA
data$party_id[party_ees==4 & countrycode == 1056] <- 107 ## Belgium (Flanders). VLD
data$party_id[party_ees==5 & countrycode == 1056] <- 110 ## Belgium (Flanders). NVA
data$party_id[party_ees==6 & countrycode == 1056] <- 105 ## Belgium (Flanders). Groen
data$party_id[party_ees==7 & countrycode == 1056] <- 112 ## Belgium (Flanders). VB

# Belgium (French) 
data$party_id[party_ees==1 & countrycode==1056 & p13_intlang==8] <- 108 # Belgium (French). cdH
data$party_id[party_ees==2 & countrycode==1056 & p13_intlang==8] <- 102 # Belgium (French). PS
data$party_id[party_ees==3 & countrycode==1056 & p13_intlang==8] <- 106 # Belgium (French). MR
data$party_id[party_ees==4 & countrycode==1056 & p13_intlang==8] <- 104 # Belgium (French). ECOLO
data$party_id[party_ees==5 & countrycode==1056 & p13_intlang==8] <- 120 # Belgium (French). PP
data$party_id[party_ees==6 & countrycode==1056 & p13_intlang==8] <- 119 # Belgium (French). PTB-go! SP edit

# Bulgaria
data$party_id[party_ees==1 & countrycode==1100] <- 2010 # Bulgaria. GERB
data$party_id[party_ees==2 & countrycode==1100] <- 2003 # Bulgaria. BSP / KzB
data$party_id[party_ees==3 & countrycode==1100] <- 2004 # Bulgaria. DPS
data$party_id[party_ees==4 & countrycode==1100] <- 2007 # Bulgaria. Ataka
data$party_id[party_ees==5 & countrycode==1100] <- 2008 # Bulgaria. DSB, 
data$party_id[party_ees==6 & countrycode==1100] <- 2015 # Bulgaria. BBT
data$party_id[party_ees==7 & countrycode==1100] <- 2016 # Bulgaria. ABV

# Cyrpus
data$party_id[party_ees==1 & countrycode==1196] <- 4001 # Cyprus. DISY
data$party_id[party_ees==2 & countrycode==1196] <- 4004 # Cyprus. DIKO
data$party_id[party_ees==3 & countrycode==1196] <- 4005 # Cyprus. EDEK
data$party_id[party_ees==4 & countrycode==1196] <- 4003 # Cyprus. AKEL
data$party_id[party_ees==5 & countrycode==1196] <- 4006 # Cyprus. KOP


# Czech Republic
data$party_id[party_ees==1 & countrycode==1203] <- 2104 # Czech Republic. KDU-CSL
data$party_id[party_ees==2 & countrycode==1203] <- 2109 # Czech Republic. TOP09
data$party_id[party_ees==3 & countrycode==1203] <- 2101 # Czech Republic. CSSD
data$party_id[party_ees==4 & countrycode==1203] <- 2102 # Czech Republic. ODS
data$party_id[party_ees==5 & countrycode==1203] <- 2103 # Czech Republic. KSCM
data$party_id[party_ees==7 & countrycode==1203] <- 2111 # Czech Republic. ANO2011
data$party_id[party_ees==8 & countrycode==1203] <- 2113 # Czech Republic. SVOBODNI

# Germany
data$party_id[party_ees==1 & countrycode==1276] <- 301 # Germany. CDU
data$party_id[party_ees==2 & countrycode==1276] <- 302 # Germany. SPD
data$party_id[party_ees==3 & countrycode==1276] <- 303 # Germany. FDP
data$party_id[party_ees==4 & countrycode==1276] <- 304 # Germany. Grunen
data$party_id[party_ees==5 & countrycode==1276] <- 306 # Germany. Linke
data$party_id[party_ees==6 & countrycode==1276] <- 310 # Germany. AfD
data$party_id[party_ees==7 & countrycode==1276] <- 311 # Germany. Piraten

# Denmark
data$party_id[party_ees==1 & countrycode==1208] <- 201 # Denmark. SD
data$party_id[party_ees==2 & countrycode==1208] <- 211 # Denmark. V
data$party_id[party_ees==3 & countrycode==1208] <- 206 # Denmark. SF
data$party_id[party_ees==4 & countrycode==1208] <- 215 # Denmark. DF
data$party_id[party_ees==5 & countrycode==1208] <- 202 # Denmark. RV
data$party_id[party_ees==6 & countrycode==1208] <- 218 # Denmark. LA
data$party_id[party_ees==7 & countrycode==1208] <- 203 # Denmark. KF
data$party_id[party_ees==8 & countrycode==1208] <- 217 # Denmark. FolkB

# Estonia
data$party_id[party_ees==1 & countrycode==1233] <- 2201 # Estonia. IRL
data$party_id[party_ees==2 & countrycode==1233] <- 2204 # Estonia. SDE
data$party_id[party_ees==3 & countrycode==1233] <- 2203 # Estonia. ER
data$party_id[party_ees==4 & countrycode==1233] <- 2202 # Estonia. EK
data$party_id[party_ees==5 & countrycode==1233] <- 2207 # Estonia. EER

# Spain 
data$party_id[party_ees==1 & countrycode==1724] <- 502 # Spain. PP
data$party_id[party_ees==2 & countrycode==1724] <- 501 # Spain. PSOE
data$party_id[party_ees==3 & countrycode==1724] <- 504 # Spain. IU
data$party_id[party_ees==4 & countrycode==1724] <- 523 # Spain. UPyd
data$party_id[party_ees==6 & countrycode==1724] <- 511 # Spain. ERC
data$party_id[party_ees==7 & countrycode==1724] <- 526 # Spain. Cs
data$party_id[party_ees==8 & countrycode==1724] <- 525 # Spain. Podemos

# Finland
data$party_id[party_ees==1 & countrycode==1246] <- 1402 # Finland. KOK
data$party_id[party_ees==2 & countrycode==1246] <- 1409 # Finland. KD
data$party_id[party_ees==3 & countrycode==1246] <- 1401 # Finland. SDP
data$party_id[party_ees==4 & countrycode==1246] <- 1403 # Finland. KESK
data$party_id[party_ees==5 & countrycode==1246] <- 1406 # Finland. RKP/SFP
data$party_id[party_ees==6 & countrycode==1246] <- 1408 # Finland. VIHR
data$party_id[party_ees==7 & countrycode==1246] <- 1404 # Finland. VAS
data$party_id[party_ees==8 & countrycode==1246] <- 1405 # Finland. PS

# France
data$party_id[party_ees==1 & countrycode==1250] <- 609 # France. UMP
data$party_id[party_ees==2 & countrycode==1250] <- 602 # France. PS
data$party_id[party_ees==3 & countrycode==1250] <- 610 # France. FN
data$party_id[party_ees==4 & countrycode==1250] <- 605 # France. EELV
data$party_id[party_ees==5 & countrycode==1250] <- 601 # France. PCF
data$party_id[party_ees==6 & countrycode==1250] <- 613 # France. MODEM


# Hungary
data$party_id[party_ees==1 & countrycode==1348] <- 2308 # Hungary. JOBBIK
data$party_id[party_ees==2 & countrycode==1348] <- 2309 # Hungary. LMP
data$party_id[party_ees==3 & countrycode==1348] <- 2302 # Hungary. Fidesz
data$party_id[party_ees==4 & countrycode==1348] <- 2301 # Hungary. MSzP
data$party_id[party_ees==5 & countrycode==1348] <- 2310 # Hungary. E14
data$party_id[party_ees==6 & countrycode==1348] <- 2311 # Hungary. DK

# Ireland
data$party_id[party_ees==1 & countrycode==1372] <- 702 # Ireland. FG
data$party_id[party_ees==2 & countrycode==1372] <- 703 # Ireland. Lab
data$party_id[party_ees==3 & countrycode==1372] <- 701 # Ireland. FF
data$party_id[party_ees==4 & countrycode==1372] <- 705 # Ireland. GP
data$party_id[party_ees==5 & countrycode==1372] <- 707 # Ireland. SF
data$party_id[party_ees==6 & countrycode==1372] <- 708 # Ireland. SP

# Italy
data$party_id[party_ees==1 & countrycode==1380] <- 837 # Italy. PD
data$party_id[party_ees==2 & countrycode==1380] <- 815 # Italy. FI
data$party_id[party_ees==3 & countrycode==1380] <- 811 # Italy. LN
data$party_id[party_ees==4 & countrycode==1380] <- 845 # Italy. M5S
data$party_id[party_ees==5 & countrycode==1380] <- 814 # Italy. UDC
data$party_id[party_ees==6 & countrycode==1380] <- 838 # Italy. SEl
data$party_id[party_ees==7 & countrycode==1380] <- 848 # Italy. NCD
data$party_id[party_ees==8 & countrycode==1380] <- 844 # Italy. FDL

# Lithuania
data$party_id[party_ees==1 & countrycode==1440] <- 2506 # Lithuania. TS-LKD
data$party_id[party_ees==2 & countrycode==1440] <- 2501 # Lithuania. LSDP
data$party_id[party_ees==3 & countrycode==1440] <- 2518 # Lithuania. LRLS
data$party_id[party_ees==4 & countrycode==1440] <- 2516 # Lithuania. DP
data$party_id[party_ees==5 & countrycode==1440] <- 2515 # Lithuania. TT
data$party_id[party_ees==6 & countrycode==1440] <- 2511 # Lithuania. LLRA
data$party_id[party_ees==7 & countrycode==1440] <- 2507 # Lithuania. LVZS

# Luxembourg
data$party_id[party_ees==1 & countrycode==1442] <- 3801 # Luxembourg. CSC
data$party_id[party_ees==2 & countrycode==1442] <- 3804 # Luxembourg. LSAP
data$party_id[party_ees==3 & countrycode==1442] <- 3803 # Luxembourg. DP
data$party_id[party_ees==4 & countrycode==1442] <- 3802 # Luxembourg. Greng
data$party_id[party_ees==5 & countrycode==1442] <- 3806 # Luxembourg. DL
data$party_id[party_ees==6 & countrycode==1442] <- 3805 # Luxembourg. ADR

# Latvia
data$party_id[party_ees==1 & countrycode==1428] <- 2412 # Latvia. V
data$party_id[party_ees==2 & countrycode==1428] <- 2410 # Latvia. SDPS
data$party_id[party_ees==3 & countrycode==1428] <- 2406 # Latvia. NA
data$party_id[party_ees==4 & countrycode==1428] <- 2405 # Latvia. ZZS
data$party_id[party_ees==7 & countrycode==1428] <- 2402 # Latvia. LKS 
# Note: 6 is missed in the .do file

# Malta
data$party_id[party_ees==1 & countrycode==1470] <- 3701 # Malta. PL
data$party_id[party_ees==2 & countrycode==1470] <- 3702 # Malta. PN

# Netherlands
data$party_id[party_ees==1 & countrycode==1528] <- 1003 # Netherlands. VVD
data$party_id[party_ees==2 & countrycode==1528] <- 1002 # Netherlands. PvdA
data$party_id[party_ees==3 & countrycode==1528] <- 1017 # Netherlands. PVV
data$party_id[party_ees==4 & countrycode==1528] <- 1014 # Netherlands. SP
data$party_id[party_ees==5 & countrycode==1528] <- 1001 # Netherlands. CDA
data$party_id[party_ees==6 & countrycode==1528] <- 1004 # Netherlands. D66
data$party_id[party_ees==7 & countrycode==1528] <- 1016 # Netherlands. CU
data$party_id[party_ees==8 & countrycode==1528] <- 1005 # Netherlands. GL

# Poland
data$party_id[party_ees==1 & countrycode==1616] <- 2603 # Poland. PO
data$party_id[party_ees==2 & countrycode==1616] <- 2606 # Poland. PSL
data$party_id[party_ees==3 & countrycode==1616] <- 2601 # Poland. SLD
data$party_id[party_ees==4 & countrycode==1616] <- 2605 # Poland. PiS
data$party_id[party_ees==5 & countrycode==1616] <- 2613 # Poland. RP
data$party_id[party_ees==6 & countrycode==1616] <- 2614 # Poland. KNP
data$party_id[party_ees==7 & countrycode==1616] <- 2616 # Poland. SP

# Portugal
data$party_id[party_ees==1 & countrycode==1620] <- 1206 # Portugal. PSD
data$party_id[party_ees==2 & countrycode==1620] <- 1202 # Portugal. PP
data$party_id[party_ees==3 & countrycode==1620] <- 1205 # Portugal. PS
data$party_id[party_ees==4 & countrycode==1620] <- 1201 # Portugal. CDU
data$party_id[party_ees==5 & countrycode==1620] <- 1208 # Portugal. BE
data$party_id[party_ees==6 & countrycode==1620] <- 1209 # Portugal. MPT


# Romania
data$party_id[party_ees==1 & countrycode==1642] <- 2701 # Romania. PSD
data$party_id[party_ees==2 & countrycode==1642] <- 2705 # Romania. PNL
data$party_id[party_ees==3 & countrycode==1642] <- 2704 # Romania. PDL
data$party_id[party_ees==4 & countrycode==1642] <- 2710 # Romania. PP-DD
data$party_id[party_ees==5 & countrycode==1642] <- 2706 # Romania. UDMR
data$party_id[party_ees==7 & countrycode==1642] <- 2711 # Romania. PMP


# Sweden
data$party_id[party_ees==1 & countrycode==1752] <- 1602 # Sweden. SAP
data$party_id[party_ees==2 & countrycode==1752] <- 1605 # Sweden. M
data$party_id[party_ees==3 & countrycode==1752] <- 1607 # Sweden. MP
data$party_id[party_ees==4 & countrycode==1752] <- 1604 # Sweden. FP
data$party_id[party_ees==5 & countrycode==1752] <- 1603 # Sweden. C
data$party_id[party_ees==6 & countrycode==1752] <- 1610 # Sweden. SD
data$party_id[party_ees==7 & countrycode==1752] <- 1606 # Sweden. KD
data$party_id[party_ees==8 & countrycode==1752] <- 1601 # Sweden. V

# Slovenia
data$party_id[party_ees==1 & countrycode==1705] <- 2914 # Slovenia. PS
data$party_id[party_ees==2 & countrycode==1705] <- 2902 # Slovenia. SDS
data$party_id[party_ees==3 & countrycode==1705] <- 2903 # Slovenia. SD
data$party_id[party_ees==5 & countrycode==1705] <- 2906 # Slovenia. DeSUS
data$party_id[party_ees==6 & countrycode==1705] <- 2905 # Slovenia. NSI
data$party_id[party_ees==8 & countrycode==1705] <- 2904 # Slovenia. SLS

# Slovakia
data$party_id[party_ees==1 & countrycode==1703] <- 2805 # Slovakia. KDH
data$party_id[party_ees==2 & countrycode==1703] <- 2802 # Slovakia. SDKU-DS
data$party_id[party_ees==3 & countrycode==1703] <- 2804 # Slovakia. SMK-MKP
data$party_id[party_ees==4 & countrycode==1703] <- 2803 # Slovakia. Smer-SD
data$party_id[party_ees==5 & countrycode==1703] <- 2815 # Slovakia. NOVA
data$party_id[party_ees==6 & countrycode==1703] <- 2812 # Slovakia. SaS
data$party_id[party_ees==7 & countrycode==1703] <- 2814 # Slovakia. OLaNO
data$party_id[party_ees==8 & countrycode==1703] <- 2813 # Slovakia. MH

# UK
data$party_id[party_ees==1 & countrycode==1826] <- 1101 # UK. Cons
data$party_id[party_ees==2 & countrycode==1826] <- 1102 # UK. Lab
data$party_id[party_ees==3 & countrycode==1826] <- 1104 # UK. LibDems
data$party_id[party_ees==4 & countrycode==1826] <- 1107 # UK. Green
data$party_id[party_ees==5 & countrycode==1826] <- 1108 # UK. UKIP
data$party_id[party_ees==6 & countrycode==1826] <- 1105 # UK. SNP
data$party_id[party_ees==7 & countrycode==1826] <- 1106 # UK. Plaid

# Croatia
data$party_id[party_ees==1 & countrycode==1191] <- 3102 # Croatia. SDP
data$party_id[party_ees==2 & countrycode==1191] <- 3105 # Croatia. HNS
data$party_id[party_ees==3 & countrycode==1191] <- 3101 # Croatia. HDZ
data$party_id[party_ees==4 & countrycode==1191] <- 3113 # Croatia. HSP-AS
data$party_id[party_ees==5 & countrycode==1191] <- 3104 # Croatia. HSLS
data$party_id[party_ees==6 & countrycode==1191] <- 3107 # Croatia. HDSSB
data$party_id[party_ees==7 & countrycode==1191] <- 3112 # Croatia. HL-SR
data$party_id[party_ees==8 & countrycode==1191] <- 3114 # Croatia. ORaH
