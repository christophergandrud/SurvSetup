#' Find features of a spell that are useful for estimating survival models
#' with interval censored observations
#'
#' @param df data frame with the spell variable
#' @param var character string specifying the variable in \code{df} with
#' information specifying the spell.
#' @param group character string specifying a group variable (if any) to find
#' spell features within groups.
#' @param right_censored logical. If \code{TRUE} the final observation is treated
#' as right-censored, i.e. coded as \code{0}. If \code{FALSE} the the final
#' observation is treated as an event.
#'
#' @details Note: assumes that \code{var} is in time order and that observations
#' are equally spaced in time.
#'
#' @return Four columns in addition to the original data frame of the
#' \code{spell_id}, a binary \code{spell_event} variable, as well as
#' \code{spell_time1} and \code{spell_time2} with the interval start and
#' end times within each spell.
#'
#' @examples
#' # Create fake data
#' group_id <- c(rep('aa', 7), rep('bb', 4))
#' x <- c(rep('a', 4), rep('b', 3), 'c', rep('a', 2), 'c')
#' fake_data <- data.frame(group_id = group_id, spell = x)
#'
#' # Find spell features
#' spell_features(fake_data, var = 'spell')
#' spell_features(fake_data, var = 'spell', group = 'group_id')
#' spell_features(fake_data, var = 'spell', group = 'group_id',
#'                right_censored = FALSE)
#'
#' @importFrom dplyr %>% group_by mutate
#'
#' @export

spell_features <- function(df, var, group, right_censored = TRUE) {
    if (!(var %in% names(df))) stop(
        sprintf('%s not found.', var), call. = FALSE
    )
    if (missing(group)) {
        feat <- data.frame(
            spell_id = spell_id(df[, var]),
            spell_event = spell_event(df[, var],
                                    right_censored = right_censored),
            spell_time1 = spell_duration(df[, var])
        )
    }
    if (!missing(group)) {
        if (!(group %in% names(df))) stop(
            sprintf('%s not found.', group), call. = FALSE
        )
        temp <- df[, c(group, var)]
        names(temp) <- c('group', 'var')
        temp <- temp %>% group_by(group) %>%
                    mutate(
                        spell_id = spell_id(var),
                        spell_event = spell_event(var,
                                            right_censored = right_censored),
                        spell_time1 = spell_duration(var)
                    )
        feat <- temp[, 3:5]
    }
    # Create inveral end time (assuming equal interval spacing)
    feat$spell_time2 <- feat$spell_time1 + 1
    out <- cbind(df, feat)

    return(out)
}