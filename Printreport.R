render_report = function(year) {
    rmarkdown::render(
        "APD_report.Rmd", params = list(
            year = year
        ),
        output_file = paste0("APD-", Sys.Date(), ".pdf")
    )
}

render_report(2020)
