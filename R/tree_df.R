#' Determine which tips are on the tree, and get their genera.
#'
#' @param tree Starting tree; object of type phylo
#' @return tree_df Dataframe objects expressing the tips, and their genera
#'

make_treedf <- function(tree){
  if (!inherits(tree, "phylo")){
    stop("tree must be of class 'phylo'")
  }
  tree_df <- data.frame(matrix(ncol = 2, nrow = length(tree$tip.label)))
  x <- c("genera", "fullnames")
  colnames(tree_df) <- x
  for (tip in tree$tip.label) {
    if (grepl("_", tip) == TRUE) {
    }
   else {
    stop("Tree tips must be formmatted in genus_species format. If this is a
            higher order taxon with no species name, please format as taxon_sp")
    stop
   }
  }
  tree_df$genera <- lapply(strsplit(tree$tip.label, "_"), `[`, 1)
  tree_df$fullnames <- tree$tip.label
  return(tree_df)
}
