

#' Save and load Python objects with pickle
#'
#' @param object Object to save
#' @param filename File name
#' @param pickle The implementation of pickle to use (defaults to "pickle" but
#'   could e.g. also be "cPickle")
#' 
#' @export
py_save_object <- function(object, filename, pickle = "pickle") {
  builtins <- import_builtins()
  pickle <- import(pickle)
  handle <- builtins$open(filename, "wb")
  on.exit(handle$close(), add = TRUE)
  pickle$dump(object, handle, protocol = pickle$HIGHEST_PROTOCOL)
}

#' @rdname py_save_object
#' @export
py_load_object <- function(filename, pickle = "pickle") {
  builtins <- import_builtins()
  pickle <- import(pickle)
  handle <- builtins$open(filename, "rb") 
  on.exit(handle$close(), add = TRUE)
  pickle$load(handle)
}
