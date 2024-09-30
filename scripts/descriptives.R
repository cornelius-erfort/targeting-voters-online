
# Load packages and functions

source("scripts/packages.R")
source("scripts/functions.R")


# Load data

load("data/mydata/analyze_data.RData")
# analyze_data <- filter(analyze_data, country != "UK")

load("data/mydata/ads_total.RData")


# Create vector of national party IDs
ees_party_list <- read_excel("data/datasets/european-election-survey/ees-2014/ZA5160_cp-hand-coding-import.xlsx") 
page_id_national <- (pivot_longer(ees_party_list[, str_subset(names(ees_party_list), "page_id_national")], cols = starts_with("page_id_national"), values_to = "page_id_national") %>% filter(!is.na(page_id_national)) %>% select(page_id_national))$page_id_national



# Summary statistics

# Number of ads downloaded
ads_total %>% nrow %>% comma

# Number of party pages
ads_total$page_id %>% unique %>% length %>% comma

# Countries in sample
analyze_data$country %>% unique %>% length

# Parties in sample
analyze_data$parlgov_id %>% unique %>% length

# Number of target groups
analyze_data %>% select(c(age, gender, fb)) %>% unique %>% nrow %>% comma

# Number of regions
analyze_data %>% select(c(fb)) %>% unique %>% nrow %>% comma

# Party type
analyze_data$party_type[!duplicated(analyze_data$parlgov_id)] %>% table

# Italy average turnout
sum(analyze_data$turnout[analyze_data$parlgov_id == 382]*analyze_data$obs_targets[analyze_data$parlgov_id == 382]) / sum(analyze_data$obs_targets[analyze_data$parlgov_id == 382])

# obs_targets
analyze_data$obs_targets %>% summary

# Select vars for summary table
analyze_data %>% names %>% sort 

present_data <- analyze_data %>%
  select(c(
    "country",
    "parlgov_party_name_short",
    "party_type",
    "parlgov_id",
    "fb",
    "gender",
    "age",
    
    "amount_spent_est_EUR",
    "amount_spent_est_EUR_party",
    
    "amount_spent_est_EUR_nat",
    "amount_spent_est_EUR_party_nat",
    
    "target_spend",
    "target_spend_nat",
    
    "vote_diff",
    "vote_party",
    "prop_diff",
    "vote_prop_party",
    
    "obs_targets",
    
    "pop_count"
  ))

# Format vars for presentation
present_data[, names(present_data) %>% str_subset("EUR")] <- apply(present_data[, names(present_data) %>% str_subset("EUR")], MARGIN = 2, function (x) round(x, 0))

present_data <- present_data[!is.na(present_data$age), ]
present_data$male <- 0
present_data$male[present_data$gender == "male"] <- 1

for (group in unique(present_data$age %>% sort)) {
  present_data[, paste0("age_", group)] <- 0
  present_data[present_data$age == group, paste0("age_", group)] <- 1
}

present_data$niche <- 0
present_data$niche[present_data$party_type == "niche"] <- 1

# Write latex table
present_data %>% select(c(amount_spent_est_EUR, amount_spent_est_EUR_nat, amount_spent_est_EUR_party, amount_spent_est_EUR_party_nat, target_spend, target_spend_nat, vote_diff, vote_party, prop_diff, vote_prop_party, obs_targets, pop_count, male, starts_with("age_"), niche)) %>%  
  stargazer(
    covariate.labels	= c("Target group spending (EUR)",
                         " - Only nat. party pages",
                         
                         "Mean spending of party (EUR)",
                         " - Only nat. party pages",
                         
                         "Target group spending (rel. to mean and pop. size)",
                         " - Only nat. party pages",
                         
                         "Difference in vote share (Target group –  Party mean)",
                         "Mean vote share of party",
                         
                         "Difference in vote propensity (Target group –  Party mean)",
                         "Mean vote propensity for party",
                         
                         "Number of respondents for target group",
                         "Target group size (absolute)",
                         
                         "Gender: male",
                         
                         "Age: 18-24",
                         "Age: 25-34",
                         "Age: 35-44",
                         "Age: 45-54",
                         "Age: 55-64",
                         "Age: 65+",
                         
                         "Niche party"),
    type = "latex", digits = 2, out = "tables/summary_statistics_all.tex", omit.summary.stat = c("p25", "p75"))

# Data sample

present_sample <- select(present_data, c(country, parlgov_party_name_short, parlgov_id, fb, gender, age, amount_spent_est_EUR, amount_spent_est_EUR_party, vote_diff, vote_party, prop_diff, vote_prop_party, obs_targets, pop_count))
present_sample <- present_sample[sample(1:length(present_data[, 1]), 35), ]


present_sample[order(present_sample$country, present_sample$parlgov_party_name_short), ] %>% 
  stargazer(
    summary = F, rownames = F, 
    covariate.labels = c("Country", "Party", "Niche", "ParlGov ID", "NUTS", "Gender", "Age", "Spend", "(mean)", "\\$\\Delta\\$ Vote", "(mean)", "\\$\\Delta\\$ Prop.", "(mean)", "Survey n", "Size"),
    type = "latex", out = "tables/target_group_sample35.tex", digits = 2)




# List of parties

present_data <- select(ads_total, c(country, parlgov_id, spend.upper_bound.x, spend.lower_bound.x, currency)) # , spend.lower_bound_EUR, spend.upper_bound_EUR))

exchange <- read.xlsx("data/datasets/exchange-rates/exchange-rates_2019-05-26_xe.com.xlsx") %>% dplyr::rename(exchange = rate)
present_data <- merge(present_data, exchange, by = "currency", all.x = T)

present_data$estimate_EUR <- (present_data$spend.upper_bound.x + present_data$spend.lower_bound.x) /2 * present_data$exchange

# Add party names
parties <- read_csv("data/datasets/parlgov/view_party.csv") %>% select(c("party_id", "party_name_short")) %>%
  dplyr::rename(parlgov_id = party_id, party_name = party_name_short)

present_data <- merge(present_data, parties, by = "parlgov_id")

present_data$number_ads <- 1

present_data <- aggregate(cbind(estimate_EUR, number_ads) ~ country + party_name + parlgov_id, data = present_data, FUN = function (x) sum(x, na.rm = T)) # spend.lower_bound_EUR, spend.upper_bound_EUR

present_data <- present_data[order(present_data$country, present_data$party_name), ]

present_data$party_name <- present_data$party_name %>% str_replace_all("&", "\\\\")
present_data$average_ad_spend <- round(present_data$estimate_EUR / present_data$number_ads, 0)
present_data$estimate_EUR <- round(present_data$estimate_EUR, 0)


# TABLE
stargazer(present_data %>% dplyr::mutate(parlgov_id = as.character(parlgov_id)),
          order = c(1, 2, 3, 4, 5),
          covariate.labels	= c("Country",
                               "Party name",
                               "ParlGov ID",
                               "Estimated spending (EUR)",
                               # "Spending, lower bound",
                               # "Spending, upper bound",
                               "Number of ads",
                               "Avg. ad spending (EUR)"),
          summary = F,
          rownames = F,
          label = "tab:party-list",
          title = "List of parties with spending and number of ads",
          type = "latex", digits = 2, out = "tables/party-list.tex")


# Spending over time

# Estimated total daily spending in all Eurozone countries
ads_total %>% filter(currency == "EUR") %>% 
  
  
  aggregate(ads_total[!is.na(ads_total$spend.lower_bound.x), names(ads_total) %in% c("spend.lower_bound.x", "spend.upper_bound.x")], by = list(date = ads_total$date2[!is.na(ads_total$spend.lower_bound.x)]), FUN = function(x) sum(unlist(x), na.rm = T)) %>% mutate(estimate = (spend.lower_bound.x+spend.upper_bound.x)/2) %>% 
  filter(!is.na(spend.lower_bound.x) & !is.na(spend.upper_bound.x) & !is.na(estimate)) %>% 
  ggplot(aes(x = date)) + 
  geom_step(aes(y = estimate, color = "estimate", lty = "estimate")) +
  geom_step(aes(y = spend.lower_bound.x, color = "lower bound", lty = "lower bound")) +
  geom_step(aes(y = spend.upper_bound.x, color = "upper bound", lty = "upper bound")) +
  scale_x_date(date_breaks = "1 month", date_labels = "%d-%m-%Y", 
               limits = as.Date(c(NA,'2019-06-01'))) +
  scale_y_continuous(labels = scales::comma) +
  theme_grey() +
  theme(axis.title = element_text(size = 10),
        plot.title = element_text(hjust = 0.5),
        axis.text.x = element_text(angle = 45, hjust = 1, size = 13),
        text = element_text(family = "Latin Modern Roman")
  ) +
  scale_linetype_manual(name = "",
                        values = c(1, 2, 2),
                        labels = c("estimate", "lower bound", "upper bound")) +
  scale_color_discrete(name = "",
                       #values = c("black", "blue", "red"),
                       labels = c("estimate", "lower bound", "upper bound")) + 
  labs(y = "Daily spending in Euro", x = "") 
ggsave("figures/spending-campaign-cycle-full.pdf", device = cairo_pdf, width = 6.75, height = 4.5)



aggregate(ads_total[!is.na(ads_total$spend.lower_bound.x), names(ads_total) %in% c("spend.lower_bound.x", "spend.upper_bound.x")], by = list(date = ads_total$date2[!is.na(ads_total$spend.lower_bound.x)]), FUN = function(x) sum(unlist(x), na.rm = T)) %>% mutate(estimate = (spend.lower_bound.x+spend.upper_bound.x)/2) %>% 
  filter(!is.na(spend.lower_bound.x) & !is.na(spend.upper_bound.x) & !is.na(estimate)) %>% 
  ggplot(aes(x = date)) + 
  geom_step(aes(y = estimate, color = "estimate", lty = "estimate")) +
  geom_step(aes(y = spend.lower_bound.x, color = "lower bound", lty = "lower bound")) +
  geom_step(aes(y = spend.upper_bound.x, color = "upper bound", lty = "upper bound")) +
  scale_x_date(date_breaks = "1 week", date_labels = "%d-%m-%Y", 
               limits = as.Date(c('2019-05-01','2019-06-01'))) +
  scale_y_continuous(labels = scales::comma) +
  theme_grey() +
  theme(axis.title = element_text(size = 10),
        plot.title = element_text(hjust = 0.5),
        axis.text.x = element_text(angle = 45, hjust = 1, size = 13),
        text = element_text(family = "Latin Modern Roman")
  ) +
  scale_linetype_manual(name = "",
                        values = c(1, 2, 2),
                        labels = c("estimate", "lower bound", "upper bound")) +
  scale_color_discrete(name = "",
                       #values = c("black", "blue", "red"),
                       labels = c("estimate", "lower bound", "upper bound")) + 
  labs(y = "Daily spending in Euro", x = "") 
ggsave("figures/spending-campaign-cycle.pdf", device = cairo_pdf, width = 6.75, height = 4.5)



# Map of spending by region
load("data/mydata/target_groups_total.RData")
load("data/datasets/regions/regions.RData")
source("scripts/prepare-maps.R")

par(family = "LM Roman 10")
theme_update(text = element_text(family = "LM Roman 10"))

nuts0_df$group <- str_c(nuts0_df$group, "_0")
nuts1_df$group <- str_c(nuts1_df$group, "_1")
nuts2_df$group <- str_c(nuts2_df$group, "_2")
nuts3_df$group <- str_c(nuts3_df$group, "_3")

nuts_all_df <- rbind.fill(nuts0_df, nuts1_df, nuts2_df, nuts3_df)

NUTS_groups <- aggregate(cbind(estimate_EUR_adj, tg_pop_count) ~ tg_NUTS, target_groups_total, sum)

NUTS_groups$percapita <- round(NUTS_groups$estimate_EUR_adj / NUTS_groups$tg_pop_count * 100, 2)

NUTS_groups$tg_NUTS[NUTS_groups$tg_NUTS == "UKX"] <- "UKX"
NUTS_groups$tg_NUTS[NUTS_groups$tg_NUTS == 'c("LV006", "LV007")	'] <- "LV00X"

nuts_all_df <- merge(nuts_all_df, NUTS_groups, by.x = "NUTS_ID", by.y = "tg_NUTS")
nuts_all_df <- nuts_all_df[order(nuts_all_df$NUTS_ID, nuts_all_df$order), ]
myPalette <- colorRampPalette(c("white", "black"))

summary(nuts_all_df$percapita)

# nuts_all_df$percapita[nuts_all_df$percapita > 100] <- 100

# Percapita spending by regions
ggplot(data = nuts_all_df, aes(x = long, y = lat, group = group)) +
  geom_polygon(aes(fill = percapita), color = "black", size = .1) +
  theme_light() + 
  theme(legend.key.size = unit(1, 'cm'),
        legend.position = c(.2, .8),
        legend.title = element_blank(),
        axis.text = element_blank(),         
        axis.title = element_blank(), 
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        plot.title = element_blank(),
        text = element_text(family = "LM Roman 10", size = 20)) +
  lims(x=c(-1200000,4000000), y=c(3900000,12000000)) +  
  scale_fill_gradientn(colours = myPalette(100), limits=c(0, 2)) +
  geom_polygon(data=nuts0, color="black", size=.1, fill = NA, lty = 2)
ggsave("figures/regions-spending.pdf", device = cairo_pdf, width = 8, height = 8*2^.5)




# Demographic targeting by parties
load("data/mydata/target_groups_total.RData")

target_groups_total$spending_per10000 <- target_groups_total$amount_spent_est_natparty / target_groups_total$tg_pop_count * 10000

# spending <- target_groups_total %>% select(parlgov_id, amount_spent_est_natparty)

age <- aggregate(amount_spent_est ~ age + parlgov_id, target_groups_total, sum)

age$age <- str_replace_all(age$age, c("18-24" = "21", "25-34" = "29.5", "35-44" = "39.5", "45-54" = "49.5", "55-64" = "59.5", "65\\+" = "75")) %>% as.numeric()
summary(age$age)

age <- pivot_wider(age, id_cols = "parlgov_id", names_from = "age", values_from = "amount_spent_est")

age$total <- apply(age[, -1], MARGIN = 1, FUN = function (x) sum(x, na.rm = T))

# Exclude parties with low total
summary(age$total)

# age <- filter(age, total > quantile(total, .5))

age <- filter(age, total != 0)


age[, c("21", "29.5", "39.5", "49.5", "59.5", "75")] <- age[, c("21", "29.5", "39.5", "49.5", "59.5", "75")] / age$total

age <- dplyr::mutate(age, `21` = 21 *`21`,
                     `29.5` = 29.5 *`29.5`,
                     `39.5` = 39.5 *`39.5`,
                     `49.5` = 49.5 *`49.5`,
                     `59.5` = 59.5 *`59.5`,
                     `75` = 75 *`75`)

age$mean_age <- rowSums(age[, c("21", "29.5", "39.5", "49.5", "59.5", "75")], na.rm = T)

summary(age$mean_age)

gender <- aggregate(amount_spent_est ~ gender + parlgov_id + country, target_groups_total, sum) %>% 
  pivot_wider(id_cols = c("country", "parlgov_id"), names_from = "gender", values_from = "amount_spent_est")

gender$female_percent <- gender$female / (gender$male + gender$female)
summary(gender$female_percent)

target_groups <- merge(age %>% select(c(parlgov_id, mean_age, total)), gender %>% select(c(parlgov_id, female_percent, country)), by = "parlgov_id")

# Load party details (parlgov)
parties <- read_csv("data/datasets/parlgov/view_party.csv") %>% select(c("party_id", "family_name_short", "party_name_short")) %>%
  dplyr::rename(id = party_id)
names(parties) <- names(parties) %>% str_c("parlgov_", .)

# Merge dataframes
target_groups <- merge(target_groups, parties, by.x = "parlgov_id", by.y = "parlgov_id", all.x = T)

target_groups$`Party Family` <- target_groups$parlgov_family_name_short

target_groups <- target_groups %>% filter(`Party Family` != "none")

ggplot(target_groups) + 
  geom_vline(xintercept = .5, color = "dark grey") +
  geom_point(aes(x = female_percent, y = mean_age, color = `Party Family`, shape = `Party Family`)) +
  ylim(c(27.5, 50)) + xlim(c(.25, .75)) +
  theme(legend.position = "bottom") +
  scale_shape_manual(breaks = c("agr", "com", "eco", "right", "spec", "chr", "con", "lib", "soc"), values = c(1:9), labels = c("Agrarian", "Communist/Socialist", "Green/Ecologist", "Right-wing", "Special issue", "Christian democracy", "Conservative", "Liberal", "Social democracy"), guide = guide_legend(nrow = 3)) + 
  scale_color_manual(breaks = c("agr", "com", "eco", "right", "spec", "chr", "con", "lib", "soc"), values = c("dark grey", "purple", "green", "blue", "dark grey", "black", "black", "orange", "red"), labels = c("Agrarian", "Communist/Socialist", "Green/Ecologist", "Right-wing", "Special issue", "Christian democracy", "Conservative", "Liberal", "Social democracy"), guide = guide_legend(nrow = 3)) +
  xlab("Share of ads targeted at women") + 
  ylab("Mean age of targeted groups (weighted)") +
  new_scale_color() +
  scale_color_manual(breaks = c("agr", "com", "eco", "right", "spec", "chr", "con", "lib", "soc"), values = c("dark grey", "purple", "green", "blue", "dark grey", "black", "black", "orange", "red"), guide=FALSE) +
  geom_text_repel(aes(x = female_percent, y = mean_age, label = parlgov_party_name_short, color = `Party Family`), family = "LM Roman 10", max.overlaps = 20, size = 2.5, force_pull = 10, force = 0.5, box.padding = .2, label.padding = .1, label.size = .15, label.r = .075, alpha = .9)

ggsave("figures/parties-demo.pdf", device = cairo_pdf, width = 4*2^.5, height = 4)



ggplot(target_groups) + 
  geom_vline(xintercept = .5, color = "dark grey") +
  geom_point(aes(x = female_percent, y = mean_age, color = `Party Family`, shape = `Party Family`)) +
  ylim(c(27.5, 50)) + xlim(c(.25, .75)) +
  theme(legend.position = "bottom") +
  scale_shape_manual(breaks = c("agr", "com", "eco", "right", "spec", "chr", "con", "lib", "soc"), values = c(1:9), labels = c("Agrarian", "Communist/Socialist", "Green/Ecologist", "Right-wing", "Special issue", "Christian democracy", "Conservative", "Liberal", "Social democracy"), guide = guide_legend(nrow = 3)) + 
  scale_color_manual(breaks = c("agr", "com", "eco", "right", "spec", "chr", "con", "lib", "soc"), values = c("dark grey", "purple", "green", "blue", "dark grey", "black", "black", "orange", "red"), labels = c("Agrarian", "Communist/Socialist", "Green/Ecologist", "Right-wing", "Special issue", "Christian democracy", "Conservative", "Liberal", "Social democracy"), guide = guide_legend(nrow = 3)) +
  xlab("Share of ads targeted at women") + 
  ylab("Mean age of targeted groups (weighted)") +
  new_scale_color() +
  scale_color_manual(breaks = c("agr", "com", "eco", "right", "spec", "chr", "con", "lib", "soc"), values = c("dark grey", "purple", "green", "blue", "dark grey", "black", "black", "orange", "red"), guide=FALSE) 

ggsave("figures/parties-demo-nolabels.pdf", device = cairo_pdf, width = 4*2^.5, height = 4)



mean(target_groups$mean_age)

ggplot(target_groups %>% mutate(`Party Family` = recode(`Party Family`,
                                                        "agr" = "Agrarian",
                                                        "com" = "Communist/Socialist",
                                                        "eco" = "Green/Ecologist",
                                                        "right" = "Right-wing",
                                                        "spec" = "Special issue",
                                                        "chr" = "Christian democracy",
                                                        "con" = "Conservative",
                                                        "lib" = "Liberal",
                                                        "soc" = "Social democracy",
))) + 
  geom_vline(xintercept = .5, color = "dark grey") +
  geom_hline(yintercept = mean(target_groups$mean_age), color = "dark grey") +
  geom_point(aes(x = female_percent, y = mean_age, color = `Party Family`)) +
  ylim(c(27.5, 50)) + xlim(c(.25, .75)) +
  theme(legend.position = "none") +
  # scale_shape_manual(breaks = c("Agrarian", "Communist/Socialist", "Green/Ecologist", "Right-wing", "Special issue", "Christian democracy", "Conservative", "Liberal", "Social democracy"), values = c(1:9), labels = c("Agrarian", "Communist/Socialist", "Green/Ecologist", "Right-wing", "Special issue", "Christian democracy", "Conservative", "Liberal", "Social democracy"), guide = guide_legend(nrow = 3)) + 
  
  scale_color_manual(breaks = c("Agrarian", "Communist/Socialist", "Green/Ecologist", "Right-wing", "Special issue", "Christian democracy", "Conservative", "Liberal", "Social democracy"), values = c("dark grey", "purple", "dark green", "blue", "dark grey", "black", "black", "orange", "red"), labels = c("Agrarian", "Communist/Socialist", "Green/Ecologist", "Right-wing", "Special issue", "Christian democracy", "Conservative", "Liberal", "Social democracy"), guide = guide_legend(nrow = 3)) +
  xlab("Share of ads targeted at women") + 
  ylab("Mean age of targeted groups (weighted)") +
  new_scale_color() +
  scale_color_manual(breaks = c("Agrarian", "Communist/Socialist", "Green/Ecologist", "Right-wing", "Special issue", "Christian democracy", "Conservative", "Liberal", "Social democracy"), values = c("dark grey", "purple", "dark green", "blue", "dark grey", "black", "black", "orange", "red"), guide=FALSE) +
  facet_wrap(~`Party Family`, nrow = 3)

ggsave("figures/parties-demo-facet.pdf", device = cairo_pdf, width = 4*2^.5, height = 6)




load("data/mydata/target_groups_total.RData")

target_groups_total$spending_per10000 <- target_groups_total$estimate_EUR_adj / target_groups_total$tg_pop_count * 10000

region <- aggregate(spending_per10000 ~ tg_region + tg_NUTS + parlgov_id, target_groups_total, sum)

region <- region %>%
  dplyr::group_by(tg_region) %>% 
  dplyr::mutate(rank = rank(-spending_per10000))

region <- filter(region, rank == 1)
region <- merge(region, parties, by.x = "parlgov_id", by.y = "parlgov_id", all.x = T)

region <- select(region, c(parlgov_party_name_short, tg_region, tg_NUTS))

centroids <- data.frame(NUTS_ID = c(nuts1$NUTS_ID, nuts2$NUTS_ID, nuts3$NUTS_ID), sp::getSpPPolygonsLabptSlots(rbind(nuts1, nuts2, nuts3)))
names(centroids) <- c("tg_NUTS", "long", "lat")

centroids <- merge(region, centroids, by = "tg_NUTS")

ggplot(data = nuts_all_df, aes(x = long, y = lat)) +
  geom_polygon(aes(fill = percapita, group = group), color = "black", size = .1) +
  theme_light() + 
  theme(legend.key.size = unit(1, 'cm'),
        legend.position = c(.2, .8),
        legend.title = element_blank(),
        axis.text = element_blank(),         
        axis.title = element_blank(), 
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        plot.title = element_blank(),
        text = element_text(family = "LM Roman 10", size = 20)) +
  lims(x=c(-1200000,4000000), y=c(3900000,12000000)) +
  geom_label_repel(data = centroids, aes(label = parlgov_party_name_short), family = "LM Roman 10", size = 3, max.overlaps = 40, force_pull = 30, force = 0.5, box.padding = .1, label.padding = .1, label.size = .15, label.r = .075) + 
  scale_fill_gradientn(colours = myPalette(100), limits=c(0, 2)) +
  geom_polygon(data = nuts0, aes(group = group), color="black", size=.1, fill = NA, lty = 2)

# ggsave("figures/regions-spending.pdf", device = cairo_pdf, width = 8, height = 8*2^.5)






# Compare EES with election results
# Load data
load("data/mydata/ees14.RData")
load("data/mydata/population.RData")

# Reformat EES
ees <- ees14 %>% select(c(parlgov_id_vote, respid, countrycode, age, gender, fb)) %>% filter(!is.na(parlgov_id_vote)) %>% unique 

# Add observation for each party in country
expand_ees <- ees %>% expand(age, gender, fb, nesting(countrycode, parlgov_id_vote))

ees <- merge(ees, expand_ees, by = c("countrycode", "age", "gender", "fb"), all = T) %>% 
  filter(!is.na(respid)) %>% 
  mutate(vote = as.numeric(parlgov_id_vote.x == parlgov_id_vote.y)) %>% 
  dplyr::rename(parlgov_id = parlgov_id_vote.y) %>% 
  select(-c(parlgov_id_vote.x)) 

# Aggregate by target group
ees <- aggregate(vote ~ age + gender + fb + countrycode + parlgov_id, ees, mean)

# Add population data for target groups
ees <- merge(ees, population, by.x = c("fb", "age", "gender"), by.y = c("GEO", "age", "SEX"), all.x = T) %>% select(-c("GEO_LABEL"))

# Add population weights
ees <- ees %>% 
  dplyr::group_by(countrycode, parlgov_id) %>% 
  dplyr::mutate(pop_country = sum(tg_pop_count, na.rm = T)) %>% 
  mutate(pop_weight = tg_pop_count / pop_country,
         vote_w = vote * pop_weight *100) %>% 
  select(c(countrycode, parlgov_id, vote, tg_pop_count, pop_country, pop_weight, vote_w))


ees <- aggregate(vote_w ~ countrycode + parlgov_id, ees, sum)

# Add election results
elections <- read_csv("data/datasets/parlgov/view_election.csv") %>% filter(election_type == "ep" & str_detect(election_date, "2014")) %>% select(c(party_id, vote_share, party_name_short, country_name)) %>%
  dplyr::rename(id = party_id)
names(elections) <- names(elections) %>% str_c("parlgov_", .)

# Combine CDU+CSU
elections <- rbind.fill(elections, data.frame(parlgov_vote_share = elections$parlgov_vote_share[elections$parlgov_id == 808] + elections$parlgov_vote_share[elections$parlgov_id == 1180] , parlgov_id = 1727))

# Merge EES with election results
ees <- merge(ees, elections, by = "parlgov_id", all.x = T)

# Correlation
ees %>% select(c(vote_w, parlgov_vote_share)) %>% filter(!is.na(vote_w) & !is.na(parlgov_vote_share)) %>%  cor # 88.4\%

# Niche parties?

# Add party names
parties <- read_csv("data/datasets/parlgov/view_party.csv") %>%
  dplyr::rename(parlgov_id = party_id) %>% 
  mutate(niche = as.numeric(family_name_short %in% c("com", "eco", "right", "spec"))) %>% 
  select(c("parlgov_id", "niche"))

ees <- merge(ees, parties, by = "parlgov_id", all.x = T)

ees <- ees[order(ees$countrycode, -ees$vote_w), ]

# Create table
ees <- ees %>% select(c(parlgov_country_name, parlgov_id, parlgov_party_name_short, niche, vote_w, parlgov_vote_share)) %>% filter(!is.na(parlgov_vote_share)) %>% 
  mutate(vote_w = round(vote_w, 2),
         parlgov_vote_share = round(parlgov_vote_share, 2),
         difference = vote_w - parlgov_vote_share)


# Correlation
ees %>% select(c(vote_w, parlgov_vote_share)) %>% filter(!is.na(vote_w) & !is.na(parlgov_vote_share)) %>%  cor # 88.4\%

ees %>% filter(niche == 0) %>% 
  select(c(vote_w, parlgov_vote_share)) %>% filter(!is.na(vote_w) & !is.na(parlgov_vote_share))  %>%  cor # 87.1\%

ees %>% filter(niche == 1) %>% 
  select(c(vote_w, parlgov_vote_share)) %>% filter(!is.na(vote_w) & !is.na(parlgov_vote_share))  %>%  cor # 90.0\%

# ees$difference %>% summary

# filter(ees, niche == 0)$difference %>% summary

# filter(ees, niche == 1)$difference %>% summary


ees$parlgov_party_name_short <- ees$parlgov_party_name_short %>% str_replace_all("&", "\\&")

stargazer(ees %>% dplyr::mutate(parlgov_id = as.character(parlgov_id)),
          # order = c(1, 2, 3, 4, 5, 6, 7),
          covariate.labels	= c("Country", "ParlGov ID", "Party", "Niche", "EES vote share", "Election vote share", "$\\Delta$"),
          summary = F,
          rownames = F,
          label = "tab:ees-election",
          title = "List of parties with vote share in EES compared with election results",
          type = "latex", digits = 2, out = "tables/ees-vs-election.tex")




