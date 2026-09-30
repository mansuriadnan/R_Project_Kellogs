library(tidyverse)

dummy_op_profibility_data1 <- tibble(
  ref = c("ya", "iop", "le", "ya", "iop", "le"),
  ref_value = c(33, 37, 40, 100, 110, 120) * 1e4,
  value = c(45, 45, 45, 130, 130, 130) * 1e4,
  category = c("mtd", "mtd", "mtd", "ytd", "ytd", "ytd"),
  period = as_date("2024-04-01")
)

# Extract the starting date
start_date <- dummy_op_profibility_data1$period[1]

# Create a tibble with a sequence of dates covering 12 months
dates <- tibble(period = seq(start_date, by = "1 month", length.out = 12))

# Replicate the sample data for each month
monthly_data <- map_dfr(dates$period, ~ mutate(dummy_op_profibility_data1, period = .x))
# View the resulting data
print(monthly_data)

# Plotting the area chart using ggplot2
ggplot(monthly_data, aes(x = period, y = value, fill = ref)) +
  geom_area() +
  labs(x = "Period", y = "Value", fill = "Reference") +
  scale_x_date(date_labels = "%b %Y", date_breaks = "1 month") +
  theme_minimal()
