library(glue)
common_index_value_box <- function(title, value, iop_growth_value) {
  glue(
    '<div class="cmn-inner-value-box">
       <div class="value-vs">         <h5>{title}</h5><span>vs</span>
       </div>       <div class="value-vs-result">         <h3>{value}</h3>
         <span>{iop_growth_value}</span>
       </div>
     </div>'
  )
}
