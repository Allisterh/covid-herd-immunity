## Original from John Cook (https://www.johndcook.com/blog/2021/02/19/herd-immunity-countdown/?utm_source=feedburner&utm_medium=email&utm_campaign=Feed%3A+TheEndeavour+%28The+Endeavour%29)

# US_population         = 330_000_000
# num_vaccinated        =  40_000_000
# num_infected          =  50_000_000
# vaccine_efficacy      = 0.9
# herd_immunity_portion = 0.70
# 
# # Some portion of the population had immunity to SARS-COV-2
# # before the pandemic. I've seen estimates from 10% up to 60%.
# portion_pre_immune = 0.40
# num_pre_immune = portion_pre_immune*US_population
# 
# # Adjust for vaccines given to people who are already immune.
# portion_at_risk = 1.0 - (num_pre_immune + num_infected)/US_population
# 
# num_new_vaccine_immune = num_vaccinated*vaccine_efficacy*portion_at_risk
# 
# # Number immune at present
# num_immune = num_pre_immune + num_infected + num_new_vaccine_immune
# herd_immunity_target = herd_immunity_portion*US_population
# 
# num_needed = herd_immunity_target - num_immune
# 
# num_vaccines_per_day = 1_800_000
# num_new_immune_per_day = num_vaccines_per_day*portion_at_risk*vaccine_efficacy
# 
# days_to_herd_immunity = num_needed / num_new_immune_per_day
# 
# print(days_to_herd_immunity)

# R version: 

US_population         = 330000000
num_vaccinated        =  40000000
num_infected          =  50000000
vaccine_efficacy      = 0.9
herd_immunity_portion = 0.70

# Some portion of the population had immunity to SARS-COV-2
# before the pandemic. I've seen estimates from 10% up to 60%.
portion_pre_immune = 0.40
num_pre_immune = portion_pre_immune*US_population

# Adjust for vaccines given to people who are already immune.
portion_at_risk = 1.0 - (num_pre_immune + num_infected)/US_population

num_new_vaccine_immune = num_vaccinated*vaccine_efficacy*portion_at_risk

# Number immune at present
num_immune = num_pre_immune + num_infected + num_new_vaccine_immune
herd_immunity_target = herd_immunity_portion*US_population

num_needed = herd_immunity_target - num_immune

num_vaccines_per_day = 1800000
num_new_immune_per_day = num_vaccines_per_day*portion_at_risk*vaccine_efficacy

days_to_herd_immunity = num_needed / num_new_immune_per_day

print(days_to_herd_immunity)