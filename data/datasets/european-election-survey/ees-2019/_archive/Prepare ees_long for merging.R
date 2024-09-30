## Prepare ees_long and target_groups_total for merging

#      EES      ->    FB
#  AT (1040) - 2      ->      2
ees_long$region_NUTS[ees_long$countrycode_ees == 1040] <- ees_long$region_NUTS2_ees[ees_long$countrycode_ees == 1040]

unique(ees_long$region_NUTS) %>% str_subset("AT") %>% substr(3, 4) %>% sort
unique(target_groups_total$tg_NUTS) %>% str_subset("AT") %>% substr(3, 4) %>% sort

#  BE (1056) - 2      ->      1
ees_long$region_NUTS[ees_long$countrycode_ees == 1056] <- ees_long$region_NUTS1_ees[ees_long$countrycode_ees == 1056]

#  BG (1110) - 2      ->      3
ees_long$region_NUTS[ees_long$countrycode_ees == 1110] <- ees_long$region_NUTS2_ees[ees_long$countrycode_ees == 1110]
target_groups_total$tg_NUTS[target_groups_total$tg_country == "BG"] <- target_groups_total$tg_NUTS3[target_groups_total$tg_country == "BG"] %>% substr(1, 4)
## Aggregate later all countries together

#  CY (1196) - 3 (make NUTS3 CY000)      ->      3
ees_long$region_NUTS[ees_long$countrycode_ees == 1196] <- "CY000"

#  CZ (1203) - 2      ->      3
ees_long$region_NUTS[ees_long$countrycode_ees == 1203] <- ees_long$region_NUTS2_ees[ees_long$countrycode_ees == 1203]
target_groups_total$tg_NUTS[target_groups_total$tg_country == "CZ"] <- target_groups_total$tg_NUTS3[target_groups_total$tg_country == "CZ"] %>% substr(1, 4)

#  DE (1276) - 1      ->      1
ees_long$region_NUTS[ees_long$countrycode_ees == 1276] <- ees_long$region_NUTS1_ees[ees_long$countrycode_ees == 1276]

#  DK (1208) - 2      ->      2
ees_long$region_NUTS[ees_long$countrycode_ees == 1208] <- ees_long$region_NUTS2_ees[ees_long$countrycode_ees == 1208]

#  EE (1233) - 3      ->      3
ees_long$region_NUTS[ees_long$countrycode_ees == 1233] <- ees_long$region_NUTS3_ees[ees_long$countrycode_ees == 1233]

#  ES (1724) - 2      ->      2
ees_long$region_NUTS[ees_long$countrycode_ees == 1724] <- ees_long$region_NUTS2_ees[ees_long$countrycode_ees == 1724]

#  FI (1246) - 2      ->      3
ees_long$region_NUTS[ees_long$countrycode_ees == 1246] <- ees_long$region_NUTS2_ees[ees_long$countrycode_ees == 1246]
target_groups_total$tg_NUTS[target_groups_total$tg_country == "FI"] <- target_groups_total$tg_NUTS3[target_groups_total$tg_country == "FI"] %>% substr(1, 4)
target_groups_total$tg_NUTS[target_groups_total$tg_NUTS == "DI1D6"] <- "FI1D6"

#  FR (1250) - 0      ->      2
ees_long$region_NUTS[ees_long$countrycode_ees == 1250] <- "FR"
target_groups_total$tg_NUTS[target_groups_total$tg_country == "FR"] <- "FR"

#  GB (1826) - 1 (make combined regions)      ->     UK (combined regions - UKX) - 1
ees_long$region_NUTS[ees_long$countrycode_ees == 1826] <- ees_long$region_NUTS1_ees[ees_long$countrycode_ees == 1826]
ees_long$region_NUTS[ees_long$region_NUTS%in% c("UKC", "UKD", "UKE", "UKF", "UKG", "UKH", "UKI", "UKJ", "UKK")	] <- "UKX"
target_groups_total$tg_NUTS[target_groups_total$tg_region == "England"] <- "UKX"


#  EL (1300) - 2      ->      GR - 2
ees_long$region_NUTS[ees_long$countrycode_ees == 1300] <- ees_long$region_NUTS2_ees[ees_long$countrycode_ees == 1300]
ees_long$region_NUTS[ees_long$region_NUTS == "EL11"] <- "EL51"
ees_long$region_NUTS[ees_long$region_NUTS == "EL12"] <- "EL52"
ees_long$region_NUTS[ees_long$region_NUTS == "EL13"] <- "EL53"
ees_long$region_NUTS[ees_long$region_NUTS == "EL21"] <- "EL54"
ees_long$region_NUTS[ees_long$region_NUTS == "EL14"] <- "EL61"
ees_long$region_NUTS[ees_long$region_NUTS == "EL22"] <- "EL62"
ees_long$region_NUTS[ees_long$region_NUTS == "EL23"] <- "EL63"
ees_long$region_NUTS[ees_long$region_NUTS == "EL24"] <- "EL64"
ees_long$region_NUTS[ees_long$region_NUTS == "EL25"] <- "EL65"
target_groups_total$tg_NUTS[target_groups_total$tg_region == "Western Greece"] <- "EL63"

#  HR (1191) - 2      ->      3
ees_long$region_NUTS[ees_long$countrycode_ees == 1191] <- ees_long$region_NUTS2_ees[ees_long$countrycode_ees == 1191]
target_groups_total$tg_NUTS[target_groups_total$tg_country == "HR"] <- target_groups_total$tg_NUTS3[target_groups_total$tg_country == "HR"] %>% substr(1, 4)

#  HU (1348) - 2      ->      3
ees_long$region_NUTS[ees_long$countrycode_ees == 1348] <- ees_long$region_NUTS2_ees[ees_long$countrycode_ees == 1348]
target_groups_total$tg_NUTS[target_groups_total$tg_country == "HU"] <- target_groups_total$tg_NUTS3[target_groups_total$tg_country == "HU"] %>% substr(1, 4)
target_groups_total$tg_NUTS[target_groups_total$tg_NUTS %in% c("HU11", "HU12")] <- "HU10"

#  IE (1372) - 3      ->      3
ees_long$region_NUTS[ees_long$countrycode_ees == 1372] <- ees_long$region_NUTS3_ees[ees_long$countrycode_ees == 1372]
ees_long$region_NUTS[ees_long$region_NUTS == "IE011"] <- "IE041"
ees_long$region_NUTS[ees_long$region_NUTS == "IE012"] <- "IE063"
ees_long$region_NUTS[ees_long$region_NUTS == "IE013"] <- "IE042"
ees_long$region_NUTS[ees_long$region_NUTS == "IE021"] <- "IE061"
ees_long$region_NUTS[ees_long$region_NUTS == "IE022"] <- "IE062"
ees_long$region_NUTS[ees_long$region_NUTS == "IE023"] <- "IE051"
ees_long$region_NUTS[ees_long$region_NUTS == "IE024"] <- "IE052"
ees_long$region_NUTS[ees_long$region_NUTS == "IE025"] <- "IE053"

#  IT (1380) - 2      ->      2
ees_long$region_NUTS[ees_long$countrycode_ees == 1380] <- ees_long$region_NUTS2_ees[ees_long$countrycode_ees == 1380]

#  LT (1440) - 3      ->      3
ees_long$region_NUTS[ees_long$countrycode_ees == 1440] <- ees_long$region_NUTS3_ees[ees_long$countrycode_ees == 1440]

# New NUTS
ees_long$region_NUTS[ees_long$region_NUTS == "LT001"] <- "LT021"
ees_long$region_NUTS[ees_long$region_NUTS == "LT002"] <- "LT022"
ees_long$region_NUTS[ees_long$region_NUTS == "LT003"] <- "LT023"
ees_long$region_NUTS[ees_long$region_NUTS == "LT004"] <- "LT024"
ees_long$region_NUTS[ees_long$region_NUTS == "LT005"] <- "LT025"
ees_long$region_NUTS[ees_long$region_NUTS == "LT006"] <- "LT026"
ees_long$region_NUTS[ees_long$region_NUTS == "LT007"] <- "LT027"
ees_long$region_NUTS[ees_long$region_NUTS == "LT008"] <- "LT028"
ees_long$region_NUTS[ees_long$region_NUTS == "LT009"] <- "LT029"
ees_long$region_NUTS[ees_long$region_NUTS == "LT00A"] <- "LT011"

#  LU (1442) - 3 (make NUTS3 LU000)      ->      3
ees_long$region_NUTS[ees_long$countrycode_ees == 1442] <- "LU000"

#  LV (1428) - 3 (make combined regions)      ->      (combined regions LV00X) - 3
ees_long$region_NUTS[ees_long$countrycode_ees == 1428] <- ees_long$region_NUTS3_ees[ees_long$countrycode_ees == 1428]
ees_long$region_NUTS[ees_long$region_NUTS%in% c("LV006", "LV007")	] <- "LV00X"
target_groups_total$tg_NUTS[target_groups_total$tg_region == "Riga Planning Region"] <- "LV00X"

#  MT (1470) - 3      ->      3
ees_long$region_NUTS[ees_long$countrycode_ees == 1470] <- ees_long$region_NUTS3_ees[ees_long$countrycode_ees == 1470]

#  NL (1528) - 2      ->      2
ees_long$region_NUTS[ees_long$countrycode_ees == 1528] <- ees_long$region_NUTS2_ees[ees_long$countrycode_ees == 1528]

#  PL (1616) - 2      ->      2
ees_long$region_NUTS[ees_long$countrycode_ees == 1616] <- ees_long$region_NUTS2_ees[ees_long$countrycode_ees == 1616]
ees_long$region_NUTS[ees_long$region_NUTS == "PL11"] <- "PL71"
ees_long$region_NUTS[ees_long$region_NUTS == "PL12"] <- "PL92"
ees_long$region_NUTS[ees_long$region_NUTS == "PL31"] <- "PL81"
ees_long$region_NUTS[ees_long$region_NUTS == "PL32"] <- "PL82"
ees_long$region_NUTS[ees_long$region_NUTS == "PL33"] <- "PL72"
ees_long$region_NUTS[ees_long$region_NUTS == "PL34"] <- "PL84"

#  PT (1620) - 2      ->      2
ees_long$region_NUTS[ees_long$countrycode_ees == 1620] <- ees_long$region_NUTS2_ees[ees_long$countrycode_ees == 1620]

#  RO (1642) - 2      ->      3
ees_long$region_NUTS[ees_long$countrycode_ees == 1642] <- ees_long$region_NUTS2_ees[ees_long$countrycode_ees == 1642]
target_groups_total$tg_NUTS[target_groups_total$tg_country == "RO"] <- target_groups_total$tg_NUTS3[target_groups_total$tg_country == "RO"] %>% substr(1, 4)

#  SE (1752) - 2      ->      3
ees_long$region_NUTS[ees_long$countrycode_ees == 1752] <- ees_long$region_NUTS2_ees[ees_long$countrycode_ees == 1752]
target_groups_total$tg_NUTS[target_groups_total$tg_country == "SE"] <- target_groups_total$tg_NUTS3[target_groups_total$tg_country == "SE"] %>% substr(1, 4)

#  SI (1705) - 3 (check, make SI011-SI024 -> SI031-SI044)      ->      3
ees_long$region_NUTS[ees_long$countrycode_ees == 1705] <- paste0("SI0", ees_long$region_NUTS3_ees[ees_long$countrycode_ees == 1705] %>% substr(4, 5) %>% parse_number() + 20)

#  SK (1703) - 2      ->      3
ees_long$region_NUTS[ees_long$countrycode_ees == 1703] <- ees_long$region_NUTS2_ees[ees_long$countrycode_ees == 1703]
target_groups_total$tg_NUTS[target_groups_total$tg_country == "SK"] <- target_groups_total$tg_NUTS3[target_groups_total$tg_country == "SK"] %>% substr(1, 4)

