% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/lingpg.R
\name{lingpg}
\alias{lingpg}
\title{Linearization of the gender pay (wage) gap.}
\usage{
lingpg(
  Y,
  gender = NULL,
  id = NULL,
  weight = NULL,
  sort = NULL,
  Dom = NULL,
  period = NULL,
  dataset = NULL,
  var_name = "lin_gpg",
  checking = TRUE
)
}
\arguments{
\item{Y}{Study variable (for example the gross hourly earning). One dimensional object convertible to one-column \code{data.table} or variable name as character, column number.}

\item{gender}{Numerical variable for gender, where 1 is for males, but 2 is for females. One dimensional object convertible to one-column \code{data.table} or variable name as character, column number.}

\item{id}{Optional variable for unit ID codes. One dimensional object convertible to one-column \code{data.table} or variable name as character, column number.}

\item{weight}{Optional weight variable. One dimensional object convertible to one-column \code{data.table} or variable name as character, column number.}

\item{sort}{Optional variable to be used as tie-breaker for sorting. One dimensional object convertible to one-column \code{data.table} or variable name as character, column number.}

\item{Dom}{Optional variables used to define population domains. If supplied, estimation and linearization of gender pay (wage) gap is done for each domain. An object convertible to \code{data.table} or variable names as character vector, column numbers.}

\item{period}{Optional variable for survey period. If supplied, estimation and linearization of gender pay (wage) gap is done for each time period. Object convertible to \code{data.table} or variable names as character, column numbers.}

\item{dataset}{Optional survey data object convertible to \code{data.table}.}

\item{var_name}{A character specifying the name of the linearized variable.}

\item{checking}{Optional variable if this variable is TRUE, then function checks data preparation errors, otherwise not checked. This variable by default is TRUE.}
}
\value{
A list with two objects are returned:
\itemize{
 \item \code{value} - a \code{data.table} containing the estimated gender pay (wage) gap (in percentage).
 \item \code{lin} - a \code{data.table} containing the linearized variables of the gender pay (wage) gap (in percentage) for variance estimation.
 }
}
\description{
Estimation of gender pay (wage) gap and computation of linearized variables for variance estimation.
}
\examples{
library("data.table")
library("laeken")
data("ses")
dataset1 <- data.table(ID = paste0("V", 1 : nrow(ses)), ses)

dataset1[, IDnum := .I]

setnames(dataset1, "sex", "sexf")
dataset1[sexf == "male", sex:= 1]
dataset1[sexf == "female", sex:= 2]
  
# Full population
gpgs1 <- lingpg(Y = "earningsHour", gender = "sex",
                id = "IDnum", weight = "weights",
                dataset = dataset1)
gpgs1$value
  
\dontrun{
# Domains by education
gpgs2 <- lingpg(Y = "earningsHour", gender = "sex",
                id = "IDnum", weight = "weights",
                Dom = "education", dataset = dataset1)
gpgs2$value
    
# Sort variable
gpgs3 <- lingpg(Y = "earningsHour", gender = "sex",
                id = "IDnum", weight = "weights",
                sort = "IDnum", Dom = "education",
                dataset = dataset1)
gpgs3$value
    
# Two survey periods
dataset1[, year := 2010]
dataset2 <- copy(dataset1)
dataset2[, year := 2011]
dataset1 <- rbind(dataset1, dataset2)

gpgs4 <- lingpg(Y = "earningsHour", gender = "sex",
                id = "IDnum", weight = "weights", 
                sort = "IDnum", Dom = "education",
                period = "year", dataset = dataset1)
gpgs4$value
names(gpgs4$lin)}
  
}
\references{
Working group on Statistics on Income and Living Conditions (2004) Common cross-sectional EU indicators based on EU-SILC; the gender pay gap. \emph{EU-SILC 131-rev/04}, Eurostat.  \cr
Guillaume Osier (2009). Variance estimation for complex indicators of poverty and inequality. \emph{Journal of the European Survey Research Association}, Vol.3, No.3, pp. 167-195, ISSN 1864-3361, URL \url{https://ojs.ub.uni-konstanz.de/srm/article/view/369}.  \cr
Jean-Claude Deville (1999). Variance estimation for complex statistics and estimators: linearization and residual techniques. Survey Methodology, 25, 193-203, URL \url{https://www150.statcan.gc.ca/n1/pub/12-001-x/1999002/article/4882-eng.pdf}.  \cr
}
\seealso{
\code{\link{linqsr}}, \code{\link{lingini}},
         \code{\link{varpoord}} , \code{\link{vardcrospoor}},
          \code{\link{vardchangespoor}}
}
\keyword{Linearization}
