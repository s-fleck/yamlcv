test_that("multiplication works", {
  f <- system.file("examples", "experience.yaml", package = "arcv", mustWork = TRUE)
  render_cv(f, output = "~/scv.pdf")
})
