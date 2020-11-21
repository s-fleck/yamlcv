test_that("multiplication works", {
  f <- system.file("examples", "experience.yaml", package = "arcv", mustWork = TRUE)
  x <- yaml::read_yaml(f)
  render_cv_entry(x$job[[1]])
})



test_that("multiplication works", {
  f <- system.file("examples", "experience.yaml", package = "arcv", mustWork = TRUE)
  x <- read_cv(f)

  render_experience(x$experience)
  render_education(x$education)
  cat(render_skills(x$skills))
})

