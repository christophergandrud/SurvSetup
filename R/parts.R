#' Find unique spell IDs
#'
#' @param x a time ordered vector with values identifying a spell. It is
#' assumed that when a value in this vector changes that the spell has ended.
#'
#' @return a vector of spell IDs for each observation in \code{x}.
#'
#' @examples
#' x <- c(rep('a', 4), rep('b', 3), 'c', rep('a', 2), 'c')
#' spell_id(x)
#'
#' @export

spell_id <- function(x) {
    x <- as.character(x)
    temp <- data.frame(x = x, x1 = c(NA, x[-length(x)]),
                       stringsAsFactors = FALSE)

    if (any(is.na(temp$x))) stop('Missing values are not permitted.',
                                 call. = FALSE)

    # Find spell ID
    temp$spell_id[is.na(temp$x1)] <- 1

    for (i in 2:nrow(temp)) {
        if (temp[i, 1] == temp[i, 2]) temp[i, 3] <- temp[(i - 1), 3]
        else temp[i, 3] <- temp[(i - 1), 3] + 1
    }
    out <- temp[, 3]
    return(out)
}


#' Find spell durations (assuming observations have equal time spacing)
#'
#' @param x a time ordered vector with values identifying a spell. It is
#' assumed that when a value in this vector changes that the spell has ended.
#'
#' @return a vector of spell durations for each observation in \code{x}.
#'
#' @details Note that the function assumes that supplied observations are time
#' ordered and equally spaced in time.
#'
#' @examples
#' x <- c(rep('a', 4), rep('b', 3), 'c', rep('a', 2), 'c')
#' spell_duration(x)
#'
#' @importFrom dplyr %>% group_by mutate
#'
#' @export

spell_duration <- function(x) {
    fake <- NULL
    ids <- spell_id(x)
    temp <- data.frame(spell_id = ids, fake = 1)

    temp <- temp %>% group_by(spell_id) %>% mutate(duration = cumsum(fake))

    temp <- as.data.frame(temp)
    out <- temp[, 'duration']
    return(out)
}

#' Mark changes in spells as events
#'
#' @param x a time ordered vector with values identifying a spell. It is
#' assumed that when a value in this vector changes that the spell has ended.
#' @param right_censored logical. If \code{TRUE} the final observation is treated
#' as right-censored, i.e. coded as \code{0}. If \code{FALSE} the the final
#' observation is treated as an event.
#'
#' @return a vector of event codes for each observation in \code{x}.
#' \code{0} indicates that there was no spell change. \code{1} indicates a
#' spell change.
#'
#'
#' @examples
#' x <- c(rep('a', 4), rep('b', 3), 'c', rep('a', 2), 'c')
#' spell_event(x)
#' spell_event(x, right_censored = FALSE)
#'
#' @export

spell_event <- function(x, right_censored = TRUE) {
    ids <- spell_id(x)
    temp <- data.frame(spell = ids, spell1 = c(NA, ids[-length(ids)]),
                       event_post = 0)
    temp$event_post[temp[, 1] != temp[, 2]] <- 1

    if (isTRUE(right_censored)) {
        out <- c(temp$event_post[-1], 0)
    }
    else if (!isTRUE(right_censored)) {
        out <- c(temp$event_post[-1], 1)
    }

    return(out)
}