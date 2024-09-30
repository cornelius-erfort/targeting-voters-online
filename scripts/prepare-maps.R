
nuts0 <- readOGR(dsn = "data/datasets/maps/ref-nuts-2016-03m.shp/NUTS_RG_03M_2016_4326_LEVL_0.shp", stringsAsFactors = F)
nuts0 <- spTransform(nuts0, CRS("+proj=merc +a=6378137 +b=6378137 +lat_ts=0.0 +lon_0=0.0 +x_0=0.0 +y_0=0 +k=1.0 +units=m +nadgrids=@null +no_defs"))
nuts0$id <- rownames(nuts0@data)

nuts1 <- readOGR(dsn = "data/datasets/maps/ref-nuts-2016-03m.shp/NUTS_RG_03M_2016_4326_LEVL_1.shp", stringsAsFactors = F)
nuts1 <- spTransform(nuts1, CRS("+proj=merc +a=6378137 +b=6378137 +lat_ts=0.0 +lon_0=0.0 +x_0=0.0 +y_0=0 +k=1.0 +units=m +nadgrids=@null +no_defs"))

## Correct English regions
england_nuts <- c("UKC", "UKD", "UKE", "UKF", "UKG", "UKH", "UKI", "UKJ", "UKK")
england <- nuts1[nuts1$CNTR_CODE == "UK", ]

england_CtoI <- gUnion(england[england$FID == england_nuts[1], ], england[england$FID == england_nuts[2], ])
england_CtoI <- gUnion(england_CtoI, england[england$FID == england_nuts[3], ])
england_CtoI <- gUnion(england_CtoI, england[england$FID == england_nuts[4], ])
england_CtoI <- gUnion(england_CtoI, england[england$FID == england_nuts[5], ])
england_CtoI <- gUnion(england_CtoI, england[england$FID == england_nuts[6], ])
england_CtoI <- gUnion(england_CtoI, england[england$FID == england_nuts[7], ])
england_CtoI <- gUnion(england_CtoI, england[england$FID == england_nuts[8], ])
england_CtoI <- gUnion(england_CtoI, england[england$FID == england_nuts[9], ])

england_CtoI$CNTR_CODE <- "UK"
england_CtoI$FID <- "UKX"
england_CtoI$NUTS_ID <- "UKX"
england_CtoI$LEVL_CODE <- 1
england_CtoI$NUTS_NAME <- "FACEBOOK REGION: ENGLAND"

england <- rbind.SpatialPolygonsDataFrame(england[!(england$FID %in% england_nuts), ], england_CtoI)

nuts1 <- rbind.SpatialPolygonsDataFrame(nuts1[nuts1$CNTR_CODE != "UK", ], england)

# regions$NUTS1[regions$region == "England"] <- "UKX"
nuts1$id <- rownames(nuts1@data)

nuts2 <- readOGR(dsn = "data/datasets/maps/ref-nuts-2016-03m.shp/NUTS_RG_03M_2016_4326_LEVL_2.shp", stringsAsFactors = F)
nuts2 <- spTransform(nuts2, CRS("+proj=merc +a=6378137 +b=6378137 +lat_ts=0.0 +lon_0=0.0 +x_0=0.0 +y_0=0 +k=1.0 +units=m +nadgrids=@null +no_defs"))
nuts2$id <- rownames(nuts2@data)

nuts3 <- readOGR(dsn = "data/datasets/maps/ref-nuts-2016-03m.shp/NUTS_RG_03M_2016_4326_LEVL_3.shp", stringsAsFactors = F)
nuts3 <- spTransform(nuts3, CRS("+proj=merc +a=6378137 +b=6378137 +lat_ts=0.0 +lon_0=0.0 +x_0=0.0 +y_0=0 +k=1.0 +units=m +nadgrids=@null +no_defs"))


## Correct Latvian regions
latvia_nuts <- c("LV006", "LV007")	
latvia <- nuts3[nuts3$CNTR_CODE == "LV", ]

latvia_riga <- gUnion(latvia[latvia$FID == latvia_nuts[1], ], latvia[latvia$FID == latvia_nuts[2], ])

latvia_riga$CNTR_CODE <- "LV"
latvia_riga$FID <- "LV00X"
latvia_riga$NUTS_ID <- "LV00X"
latvia_riga$LEVL_CODE <- 3
latvia_riga$NUTS_NAME <- "FACEBOOK REGION: RIGA"

latvia <- rbind.SpatialPolygonsDataFrame(latvia[!(latvia$FID %in% latvia_nuts), ], latvia_riga)

nuts3 <- rbind.SpatialPolygonsDataFrame(nuts3[nuts3$CNTR_CODE != "LV", ], latvia)

# regions$NUTS3[regions$region == "Riga Planning Region	"] <- "LV00X"
nuts3$id <- rownames(nuts3@data)

nuts_country <- aggregate(regions[, c("NUTS1", "NUTS2", "NUTS3")], by = list(country = regions$country), FUN = function (x) (is.na(x) %>% sum) == 0)
nuts_country$country[nuts_country$country == "GB"] <- "UK"
nuts_country$country[nuts_country$country == "GR"] <- "EL"

# nuts_country <- nuts_country[!(nuts_country$country %in% c("FR")), ]

nuts_data <- merge(nuts_country, nuts0@data[, c("id", "CNTR_CODE")], by.x = "country", by.y = "CNTR_CODE")
nuts0_df <- tidy(nuts0)
nuts0_df <- left_join(nuts0_df,
                      nuts_data,
                      by = "id")
nuts0_df <- nuts0_df[is.na(nuts0_df$NUTS1), ]


nuts_data <- merge(nuts_country, nuts1@data[, c("id", "CNTR_CODE", "NUTS_ID")], by.x = "country", by.y = "CNTR_CODE")
nuts1_df <- tidy(nuts1)
nuts1_df <- left_join(nuts1_df,
                      nuts_data,
                      by = "id")
nuts1_df <- nuts1_df[nuts1_df$NUTS1, ]


nuts_data <- merge(nuts_country, nuts2@data[, c("id", "CNTR_CODE", "NUTS_ID")], by.x = "country", by.y = "CNTR_CODE")
nuts2_df <- tidy(nuts2)
nuts2_df <- left_join(nuts2_df,
                      nuts_data,
                      by = "id")
nuts2_df <- nuts2_df[nuts2_df$NUTS2, ]

nuts_data <- merge(nuts_country, nuts3@data[, c("id", "CNTR_CODE", "NUTS_ID")], by.x = "country", by.y = "CNTR_CODE")
nuts3_df <- tidy(nuts3)
nuts3_df <- left_join(nuts3_df,
                      nuts_data,
                      by = "id")
nuts3_df <- nuts3_df[nuts3_df$NUTS3, ]

nuts_data <- merge(nuts_country, nuts0@data[, c("id", "CNTR_CODE")], by.x = "country", by.y = "CNTR_CODE")
nuts_france_df <- tidy(nuts0)
nuts_france_df <- left_join(nuts_france_df,
                      nuts_data,
                      by = "id") 

nuts_france_df <- nuts_france_df[nuts_france_df$country == "FR" & !is.na(nuts_france_df$long), ]

ggplot(nuts_france_df) + geom_polygon(aes(x = long, y = lat, group = group), color = "white")


ggplot(nuts_france_df) + geom_polygon_pattern(aes(x = long, y = lat, group = group), color = "black", pattern = "stripe", pattern_spacing = .01, fill = "white")
