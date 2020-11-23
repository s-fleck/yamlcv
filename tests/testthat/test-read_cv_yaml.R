test_that("render_cv_entry() works", {
  f <- system.file("examples", "example-cv.yaml", package = "yamlcv", mustWork = TRUE)
  x <- yaml::read_yaml(f)
  expect_true(nchar(render_cv_entry(x$experience[[1]])) > 20)
})



test_that("rendering cv sections works", {
  f <- system.file("examples", "example-cv.yaml", package = "yamlcv", mustWork = TRUE)
  x <- read_cv(f)

  expect_true(nchar(render_experience(x$experience)) > 20)
  render_education(nchar(render_experience(x$education)) > 20)
  render_education(nchar(render_experience(x$skills)) > 20)
  render_skills(x$education)
})

