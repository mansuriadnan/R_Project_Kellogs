library(shiny)
library(glue)

# Source the file containing the common_index_value_box function
source("render_mtd_ytd_indices.R")

# Define the server function
comm_single_view_server <- function(input, output, session) {
  # Function to render Net Sales Value
  render_net_sales_value <- function(.category) {
    value_label <- if (.category == "mtd") "MTD" else "YTD"

    value_iop <- ifelse(.category == "mtd", 6, 4)

    iop_growth_value <- ifelse(.category == "mtd", 4.5, 6.5)

    mtd_ytd_value <- ifelse(.category == "mtd", 8.2, 10.2) 
    growth <- ifelse(.category == "mtd", 50 , 80) 
    delta_glyph <- ifelse(growth > 50, "up", "down")

    renderText({
      glue('<div class="index-vs-ya">
               <div class="index-value">
                 <h2>{mtd_ytd_value}%</h2>
                 <span><img src="images/arrow-{delta_glyph}.png"></span>
               </div>
               <p>{value_label} Index vs YA</p>
             </div>
             {common_index_value_box("IOP", glue(" +${value_iop}M"), glue(" +{iop_growth_value}%"))}
             {common_index_value_box("IOP", glue(" +${value_iop}M"), glue(" +{iop_growth_value}%"))}
             ')
    })
  }
  # Output for MTD sales
  output$composite_mtd_sales <- render_net_sales_value("mtd")

  # Output for YTD sales
  output$composite_ytd_sales <- render_net_sales_value("ytd")
}
