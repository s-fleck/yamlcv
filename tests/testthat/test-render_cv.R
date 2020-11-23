test_that("rendering pdf cvs from yaml works", {
  f <- system.file("examples", "example-cv.yaml", package = "yamlcv", mustWork = TRUE)
  tf <- render_cv(f, output = tempfile(fileext = ".pdf"))
  on.exit(unlink(tf))
  expect_true(file.size(tf) > 10)
})
