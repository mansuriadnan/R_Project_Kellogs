
library(ggplot2)
library(ggtext)


composite_offtake_iris <- function(.data) {
  plot_offtake_iris(.data)
}

plot_offtake_iris <- function(.data) {
  print(.data)
  # Process the dataset
  rolled_iris <- .data %>%
    mutate_at(vars(matches("Length")), ~./10) %>%  # Scaling the Length columns
    select(Sepal.Length, Petal.Length, Species) %>%
    filter(Species == "setosa") %>%
    mutate(Sepal.Length = Sepal.Length * 100)  # Just for demonstration, scaling Sepal.Length
  
  # Calculate some variables
  max_length <- max(rolled_iris$Sepal.Length)
  min_length <- min(rolled_iris$Sepal.Length)
  
  # Set colors
  left_species_color <- '#FD9331'
  right_species_color <- '#7091F5'
  
  # Prepare data for plotting
  rolled_iris %>%
    ggplot(aes(x = Species, y = Sepal.Length)) +
    geom_line(size = 1, color = left_species_color) +  # Plot Sepal.Length line
    geom_line(aes(y = Petal.Length), size = 1, color = right_species_color) +  # Plot Petal.Length line
    scale_y_continuous(
      sec.axis = sec_axis(trans = ~./100, name = "Petal.Length"),  # Secondary axis for Petal.Length
      labels = scales::dollar_format()
    ) +
    labs(
      x = NULL,
      title = "Sepal Length vs Petal Length",
      subtitle = "Comparison between Sepal Length and Petal Length for setosa species"
    ) +
    theme(
      axis.title = element_blank(),
      axis.text.x = element_text(size = 12, color = "#909090"),
      plot.title = element_text(color = 'dimgray'),
      plot.subtitle = element_text(color = 'dimgray')
    )
}
