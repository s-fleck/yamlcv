#' Render a yaml cv to pdf
#'
#' @param x `character` scalar. Path to a cv `.yaml` file
#' @param output `character` scalar. name of the output `.pdf` file
#' @param overwrite `logical` scalar. overwrite `output` if it exists?
#' @param template `character` scalar. Path to the template `.tex` file
#' @param photo `character` scalar. Path to a photo
#' @param photo_opts `character` vector. Options for placing the photo. Valid
#'   values are `circle|rectangle,edge/noedge,left/right`
#' @param copy_tex Copy the `.tex` file to the same output directory as
#'   `output`
#' @param awesomecolor color the first three letters of each section
#'
#' @return `output`
#' @section Side effects:
#'   Creates the pdf file `output`
#' @export
render_cv <- function(
  x,
  output,
  overwrite = TRUE,
  template = system.file("templates", "awesomecv.Rnw", package = "yamlcv"),
  photo = NULL,
  photo_opts = c("rectangle", "edge", "right"),
  awesomecolor = FALSE,
  copy_tex = FALSE
){
  cv <- read_cv(x)

  if (file.exists(output) && !overwrite){
    stop("file exists")
  }

  if (!is.null(photo)){
    photo <- normalizePath(path.expand(photo))
    assert(file.exists(photo))
  }

  td <- tempfile()
  tex_file <- file.path(td, "cv.tex")
  pdf_file <- file.path(td, "cv.pdf")

  dir.create(td)
  on.exit(unlink(td, recursive = TRUE))
  unlink(tex_file)
  env <- environment()
  force(env)
  knitr::knit(template, output = tex_file, envir = env)

  to_copy <- list.files(system.file("lib", package = "yamlcv"), full.names = TRUE)
  names(to_copy) <- list.files(system.file("lib", package = "yamlcv"))
  file.copy(to_copy, td, recursive = TRUE)

  withr::with_dir(
    td,
    tinytex::xelatex(tex_file, pdf_file = pdf_file)
  )

  if (file.exists(output)){
    if (overwrite){
      unlink(output)
    } else {
      stop("file exists")
    }
  }
  file.copy(pdf_file, output)
  if (copy_tex)
    file.copy(tex_file, file.path(dirname(output), paste(basename(output), ".tex")))

  output
}
