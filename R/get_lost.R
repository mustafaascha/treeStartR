#' Determine if a tip is present on a tree
#' @description  Determine which tips that are not on the tree, puts them in a dataframe if they
#' do not have congeners on the tree
#' @param absent_list Vector of taxa in the total dataset that are not on the tree
#' @param tree Starting tree; object of type phylo
#' @return not_found_df Dataframe objects expressing the tips that are not
#'         on the tree, and don"t have congeners
#' @examples
#' no_congeners <- treestartr:::get_lost(absent_list, tree)

get_lost <- function(absent_list, tree){
  absent_df <- make_absentdf(absent_list)
  tree_df <- make_treedf(tree)

  tree_gen <- data.frame(matrix(ncol = 2, nrow = length(absent_list)))
  not_gen <- data.frame(matrix(ncol = 2, nrow = length(absent_list)))
  x <- c("genera", "fullnames")
  colnames(tree_gen) <- x
  colnames(not_gen) <- x

  not_found_gen <- list()
  not_found_full <- list()

    for (row in seq_len(nrow(absent_df))) {
    gen <- absent_df[row, "genera"]
    full <- absent_df[row, "fullnames"]
    not_found_gen[[row]] <- gen[which(!gen %in% tree_df$genera)]
    not_found_full[[row]] <- full[which(!gen %in% tree_df$genera)]
  }
  not_found_gen <- not_found_gen[lapply(not_found_gen, length) > 0]
  not_found_full <- not_found_full[lapply(not_found_full, length) > 0]
  not_found_df <- do.call(rbind.data.frame, Map('c', not_found_full,
                                                not_found_gen))
  names(not_found_df ) <- c("full_name", "genera")
  return(not_found_df)
}
