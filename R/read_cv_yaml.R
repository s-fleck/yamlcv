#' Read a yaml cv
#'
#' @inheritParams yaml::read_yaml
#'
#' @export
read_cv <- function(file, fileEncoding = "UTF-8", text, error.label, ...){
  x <- yaml::read_yaml(file)
  cv(x)
}



cv <- function(x){
  class(x) <- union("cv", class(x))
  x
}




#' Render cv sections
#'
#' @param x a list with the appropriate elements (see `example-cv`)
#' @export
render_skills <- function(x){
  dd <- vapply(names(x), function(.) paste0("   \\cvskill{", ., "}{", paste( x[[.]], collapse = ", "), "}"), character(1), USE.NAMES = FALSE)
  paste0(
    "\\begin{cvskills}\n",
    paste(dd, collapse = "\n"),
    "\n\\end{cvskills}"
  )
}



#' @rdname render_skills
#' @export
render_person <- function(x){
  dd <- vapply(names(x), function(.) paste0("\\", ., paste0("{", x[[.]], "}", collapse = "")), character(1))
  paste(dd, collapse = "\n")
}



#' @rdname render_skills
#' @export
render_experience <- function(x){
  render_cventries(x, fields = c("title", "organization", "location", "date", "description"))
}


#' @rdname render_skills
#' @export
render_education <- function(x){
  render_cventries(x, fields = c("degree", "institution", "location", "date", "description"))
}



render_cventries <- function(x, fields = NULL){
  dd <- lapply(x, render_cv_entry, fields = fields)
  paste0(
    "\\begin{cventries}\n\n",
    paste(unlist(dd), collapse = "\n\n"),
    "\n\n\\end{cventries}"
  )
}




render_cv_entry <- function(
  x,
  fields = NULL
){
  if (!is.null(fields))
    x <- x[fields]

  dd <- lapply(x, commonmark::markdown_latex, smart = TRUE)
  dd <- lapply(dd, function(.) if (is.null(.)) "" else .)
  dd <- as.character(dd)
  dd <- gsub("\n$*", "", dd )
  dd <- vapply(dd, itemize_to_cvitems, character(1))
  paste("\\cventry",  paste("{", dd, "}", collapse = "", sep = ""), sep = "")
}




itemize_to_cvitems <- function(x){
  dd <- gsub("\\itemize", "\\cvitems", x)
  dd <- strsplit(dd, "\n")[[1]]
  dd <- vapply(dd, function(.) {
    if (grepl("s*\\item\\s+", .)){
      gsub("s*\\\\s*item\\s+", "  \\\\item {", paste0(., "}"))
    } else {
      .
    }
  }, character(1), USE.NAMES = FALSE)

  dd <- dd[!is_blank(dd)]
  paste(dd, collapse = "\n")
}
