#Yan Wang
#08/15/2020
#Daily Exercise 08: Lags & Rolling Means

library(tidyverse)

url = 'https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv'

covid = read_csv(url)

head(covid)

state.of.interest = "California"

covid %>%

  filter(state == state.of.interest) %>%

  group_by(date) %>%

  summarise(cases = sum(cases)) %>%

  mutate(newCases = cases - lag(cases),
         roll7 = rollmean(newCases, 7, fill = NA, align="right")) %>%

  ggplot(aes(x = date)) +

  geom_col(aes(y = newCases), col = NA, fill = "#F5B8B5") +

  geom_line(aes(y = roll7), col = "darkred", size = 1) +

  ggthemes::theme_wsj() +

  labs(title = paste("New Reported cases by day in", state.of.interest)) +

  theme(plot.background = element_rect(fill = "white"),
        panel.background = element_rect(fill = "white"),
        plot.title = element_text(size = 10, face = 'bold')) +

  theme(aspect.ratio = .5)

ggsave(path = "img", filename = "D8_Question_1.jpg")
