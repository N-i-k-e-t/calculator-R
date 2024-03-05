# ----- Project Settings -----
data_file <- "bank_statement.csv" # Update with your actual file name

# ----- Data Loading and Cleaning -----
transactions <- read.csv(data_file, header = TRUE)

transactions$Date <- as.Date(transactions$Date, format = "%m/%d/%Y")
transactions$Amount <- as.numeric(transactions$Amount)
transactions <- transactions %>%
    mutate(Description = tolower(Description))

library(tidyverse)
# ----- Category Mapping -----
category_map <- tribble(
    ~Description,      ~Category,
    "coffee",          "Dining",
    "supermarket",     "Groceries",
    "gym membership",  "Fitness",
    "amazon",          "Shopping",
    "netflix",         "Entertainment",
    "rent",            "Housing",
    # Add more as needed
)
transactions <- transactions %>%
    left_join(category_map, by = "Description")

# ----- Visualizations -----
# Spending over time (line graph)
ggplot(transactions, aes(x = Date, y = Amount)) +
    geom_line() +
    labs(x = "Date", y = "Spending", title = "Spending Trend")

# Monthly spending breakdown (bar chart)
ggplot(transactions, aes(x = month(Date), y = Amount, fill = Category)) +
    geom_col(position = "dodge") +
    labs(x = "Month", y = "Spending", title = "Monthly Spending by Category")

# ----- Insights -----
transactions %>%
    group_by(Category) %>%
    summarize(Total_Spent = sum(Amount)) %>%
    arrange(desc(Total_Spent))
