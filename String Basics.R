#Em r podemos definir string com " ou '
#Não importa qual delas vc usa, o output do R será o mesmo
# mas existem algumas condições onde fica melhor usar " ou ' para definir uma string
# exemplos abaixo

# Usamos " só para definir a string
line1 <- "The table was a large one, but the three were all crowded together at one corner of it:"

# usamos ' pq no meio da string temos q usar ", o contrário tbm funciona 
line2 <- '"No room! No room!" they cried out when they saw Alice coming.'

# Usamos " pq usamos dentro da string ' e "
line3 <- "\"There's plenty of room!\" said Alice indignantly, and she sat down in a large arm-chair at one end of the table."

# Putting lines in a vector
lines <- c(line1, line2, line3)

# Print lines
lines

# Use writeLines() on lines
writeLines(lines)

# Write lines with a space separator
writeLines(lines, sep = " ")

# Use writeLines() on the string "hello\n\U1F30D"
writeLines("hello\n\U1F30D")


# Should display: To have a \ you need \\
writeLines("To have a \\ you need \\\\")

# Should display: 
# This is a really 
# really really 
# long string
writeLines("This is a really really really long string", sep="\n")

# Use writeLines() with 
# "\u0928\u092e\u0938\u094d\u0924\u0947 \u0926\u0941\u0928\u093f\u092f\u093e"
writeLines("\u0928\u092e\u0938\u094d\u0924\u0947 \u0926\u0941\u0928\u093f\u092f\u093e")

#para mais informações
?Quotes

#Formatando números 
# Some vectors of numbers
percent_change  <- c(4, -1.91, 3.00, -5.002)
income <-  c(72.19, 1030.18, 10291.93, 1189192.18)
p_values <- c(0.12, 0.98, 0.0000191, 0.00000000002)

# Format c(0.0011, 0.011, 1) with digits = 1
format(c(0.0011, 0.011, 1), digits=1)

# Format c(1.0011, 2.011, 1) with digits = 1
format(c(1.0011, 2.011, 1), digits = 1)

# Format percent_change to one place after the decimal point
format(percent_change, digits=2)

# Format income to whole numbers
format(income, digits=2)


format(p_values)
# Format p_values in fixed format
format(p_values, scientific=FALSE)


formatted_income <- format(income, digits = 2)

# Print formatted_income
formatted_income

# Call writeLines() on the formatted income
writeLines(formatted_income)

# Define trimmed_income
trimmed_income <- format(income, digits = 2, trim = TRUE)

# Call writeLines() on the trimmed_income
writeLines(trimmed_income)

# Define pretty_income
pretty_income <- format(income, digits = 2, big.mark = ",")

# Call writeLines() on the pretty_income
writeLines(pretty_income)


# From the format() exercise
x <- c(0.0011, 0.011, 1)
y <- c(1.0011, 2.011, 1)

# formatC() on x with format = "f", digits = 1
formatC(x, format="f", digits = 1)

# formatC() on y with format = "f", digits = 1
formatC(y, format = "f", digits = 1)

# Format percent_change to one place after the decimal point
formatC(percent_change, format = "f", digits = 1)

# percent_change with flag = "+"
pretty_percent <- formatC(percent_change, format = "f", digits = 1, flag = "+")
pretty_percent

# Format p_values using format = "g" and digits = 2
formatC(p_values, format = "g", digits=2)

years <- 2010:2013



# Add $ to pretty_income
paste("$", pretty_income, sep="")

# Add % to pretty_percent
paste(pretty_percent,"%", sep="")

# Create vector with elements like 2010: +4.0%`
year_percent <- paste(years, paste(pretty_percent, "%", sep = ""), sep=": ")

# Collapse all years into single string
paste(year_percent, collapse=", ")

# Define the names vector
income_names <- c("Year 0", "Year 1", "Year 2", "Project Lifetime")

# Create pretty_income
pretty_income <- format(income, digits = 2, big.mark = ",")

# Create dollar_income
dollar_income <- paste("$", pretty_income, sep="")

# Create formatted_names
formatted_names <- format(income_names, justify="right")

# Create rows
rows <- paste(formatted_names, dollar_income, sep="   ")

# Write rows
writeLines(rows)

toppings <- c("anchovies", "artichoke", "bacon"    , "breakfast bacon", "Canadian bacon"  , "cheese"   , "chicken"  , "chili peppers"   
      , "feta"     , "garlic"   , "green peppers"   , "grilled onions"  
      , "ground beef",      "ham"      , "hot sauce", "meatballs"       
      , "mushrooms", "olives"   , "onions"   , "pepperoni"       
      , "pineapple", "sausage"  , "spinach"  , "sun-dried tomato"
      , "tomatoes")

# Randomly sample 3 toppings
my_toppings <- sample(toppings, size = 3)

# Print my_toppings
my_toppings

# Paste "and " to last element: my_toppings_and
my_toppings_and <- paste(c("","","and "), my_toppings, sep="")

# Collapse with comma space: these_toppings
these_toppings <- paste(my_toppings_and, collapse=", ")

# Add rest of sentence: my_order
my_order <- paste("I want to order a pizza with ", these_toppings, ".", sep="")

# Order pizza with writeLines()
writeLines(my_order)

