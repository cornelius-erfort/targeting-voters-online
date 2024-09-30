source("scripts/packages.R")
source("scripts/functions.R")


# Party-level analysis
load("data/mydata/analyze_data_ees19.RData")

party_analysis <- analyze_data 
analyze_data$vote_diff %>% summary
party_analysis$population <- party_analysis$pop_count/party_analysis$pop_count_mean * 100

# Add a weighted vote diff variable
party_analysis <- party_analysis %>% group_by(parlgov_id) %>% mutate(w_vote_diff=vote_diff*rel_targeting_nat*population*amount_spent_est_EUR_nat)

# Summarize
party_analysis <- party_analysis %>% dplyr::group_by(country, parlgov_party_name_short, parlgov_id) %>%
  dplyr::summarise(sum_vote_diff = sum(w_vote_diff, na.rm = T), 
                   vote_party = mean(vote_party, na.rm = T),
                   sum_population = sum(population, na.rm = T),
                   sum_targeting = sum(rel_targeting_nat, na.rm = T),
                   sum_spending = sum(amount_spent_est_EUR_nat, na.rm = T)
  ) %>%  mutate(mean_vote_diff = sum_vote_diff/(sum_spending*sum_population))



# ggplot(party_analysis) +
#   geom_text(aes(x = mean_vote_diff, y = vote_party, label = parlgov_party_name_short)) +
#   xlim(-.1,.1)

mymod <- lm(mean_vote_diff ~ vote_party, party_analysis)
summary(mymod)
cplot(mymod, xlab = "Total vote share", ylab = "Average target group support", family = "LM Roman 10")



# Table
stargazer(mymod,
          # covariate.labels = c("Vote support"),
          dep.var.labels.include = T,
          # dep.var.labels = "Relative target group spending",
          df = F,
          table.placement = "!ht",
          label = "tab:reg-simple" ,
          # notes.append = T,
          # notes.label = "\\floatfoot{The unit of analysis is a target group defined by party, gender, age, and region. Robust standard errors clustered by country are in parentheses. Weighted by number of observations for each target group.}",
          type = "latex", # "text",
          # font.size = "small",
          star.cutoffs = c(0.1, 0.05, 0.01))   %>% 
  starnote(save_loc = "tables/reg-new-party.tex", colnumber = 5,
           caption = "Results of OLS-regression") %>% suppressWarnings()

cairo_pdf("figures/cplot_vote_diff.pdf", width = 4*2^.5, height = 4)
cplot(mymod, xlab = "Total vote share", ylab = "Average target group support", family = "LM Roman 10")
dev.off()






# Country-level analysis
load("data/mydata/analyze_data_ees19.RData")



country_analysis <- analyze_data %>% select(c(country, parlgov_id, vote_party, vote_diff, targeting_nat, rel_targeting_nat, pop_count, pop_count_mean, amount_spent_est_EUR_nat))
country_analysis$population <- country_analysis$pop_count/country_analysis$pop_count_mean * 100

country_analysis %>% filter(parlgov_id == 1284) %>% View


analyze_data$rel_targeting_nat %>% summary
analyze_data$vote_diff %>% summary

# Add a weighted vote diff variable
country_analysis <- country_analysis %>% group_by(parlgov_id) %>% mutate(w_vote_diff=vote_diff*amount_spent_est_EUR_nat)

# Summarize
country_analysis <- country_analysis %>% filter(!is.na(w_vote_diff)) %>% dplyr::group_by(country, parlgov_id)  %>%
  dplyr::summarise(sum_vote_diff = sum(w_vote_diff, na.rm = T),
                   sum_population = sum(population, na.rm = T),
                   sum_spending = sum(amount_spent_est_EUR_nat, na.rm = T),
                   vote_party = mean(vote_party, na.rm = T),
  ) %>%  mutate(mean_vote_diff = sum_vote_diff/(sum_spending))


country_analysis <- country_analysis %>% dplyr::group_by(country) %>%
  dplyr::summarise(mean_vote_diff = sum(mean_vote_diff*sum_spending, na.rm = T)/sum(sum_spending, na.rm = T))


# Map
country_analysis$country[country_analysis$country == "EL"] <- "GR"
country_analysis$country[country_analysis$country == "UK"] <- "GB"

world <- ne_countries(scale = "medium", returnclass = "sf") # %>% filter(iso_a2_eh %in% c(country_analysis$country, "GB"," PT", "HR", "FR"))

country_analysis$mean_vote_diff[country_analysis$mean_vote_diff %>% is.nan] <- NA

world <- left_join(world, country_analysis, by = c("iso_a2_eh" = "country"), keep = T)

ggplot(data = world, aes(fill = mean_vote_diff), fill = NA) +
  geom_sf() + xlim(c(-10,30)) + ylim(c(35,70)) + 
  geom_sf_label(aes(label = round(mean_vote_diff, 3)), color = "white") + xlab("") + ylab("") + 
  labs(fill="Average vote share\ndifference in targeted \ngroups [%]")

ggsave("figures/map_vote_diff.pdf", width = 9*2^.5, height = 9, device = cairo_pdf)

