#' Title
#'
#' @param x
#' @param output
#' @param template
#' @param photo
#' @param photo_opts `circle|rectangle,edge/noedge,left/right`
#'
#' @return
#' @export
#'
#' @examples
render_cv <- function(
  x,
  output,
  overwrite = TRUE,
  template = system.file("templates", "awesomecv.Rnw", package = "arcv"),
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
  knitr::knit(template, output = tex_file)

  to_copy <- list.files(system.file("lib", package = "arcv"), full.names = TRUE)
  names(to_copy) <- list.files(system.file("lib", package = "arcv"))
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
