install.packages("rebus")
library(rebus)
install.packages("jsonlite")
library(jsonlite)
# Some strings to practice with
x <- c("cat", "coat", "scotland", "tic toc")

# Print END
END

# Run me
str_view(x, pattern = START %R% "c")

str_view(x, pattern = START %R% "co")

# Match the strings that end with "at"
str_view(x, pattern = "at" %R% END)

# Match the string that is exactly "cat"
str_view(x, pattern = START %R% "cat" %R% END)


# Match two characters, where the second is a "t"
str_view(x, pattern = ANY_CHAR %R% "t")
# Match a "t" followed by any character
str_view(x, pattern = "t" %R% ANY_CHAR)

# Match two characters
str_view(x, pattern = ANY_CHAR %R% ANY_CHAR)

# Match a string with exactly three characters
str_view(x, pattern = START %R% ANY_CHAR %R% ANY_CHAR %R% ANY_CHAR %R% END)
