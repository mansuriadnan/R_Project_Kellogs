library(glue)
common_index_value_box <- function(.value, .ref, .label) {
  
  # Calculate the difference ratio between value and reference
  .delta <- .value / .ref - 1
  
  # Determine the sign of deviation and color based on the delta value
  .sign_dev <- ifelse(.delta > 0, '+', '-')
  .color <- ifelse(.delta > 0, 'green', 'orange')
  
  # Convert value to million and calculate delta percentage
  value_million <- .value / 1e6
  delta_percent <- abs(round(.delta * 100, 1))
  
  glue('
    <div class="cmn-inner-value-box">
      <div class="value-vs">
        <h5>{.label}</h5><span>vs</span>
      </div>
      <div class="value-vs-result">
        <h4 class="{.color}-color-text">+${value_million}M</h4>
        <span class="{.color}-box">{.sign_dev}{delta_percent}%</span>
      </div>
    </div>
  ')
  
 
}
