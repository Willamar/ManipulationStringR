#install.packages("rebus")
library(rebus)
#install.packages("jsonlite")
library(jsonlite)
library(stringr)
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

library(babynames)
babynames_2014 <- filter(babynames, year == 2014)
boy_names <- filter(babynames_2014, sex == "M")$name
girl_names <- filter(babynames_2014, sex == "F")$name

pattern <- "q" %R% ANY_CHAR

# Find names that have the pattern
names_with_q <- str_subset(boy_names, pattern)

# How many names were there?
length(names_with_q)

# Find part of name that matches pattern
part_with_q <- str_extract(boy_names, pattern)

# Get a table of counts
table(part_with_q)

# Did any names have the pattern more than once?
count_of_q <- str_count(boy_names, pattern)

# Get a table of counts
table(count_of_q)

# Which babies got these names?
with_q <- str_detect(boy_names, pattern)

# What fraction of babies got these names?
mean(with_q)

# Match Jeffrey or Geoffrey
whole_names <- or("Jeffrey", "Geoffrey")
str_view(boy_names, pattern = whole_names, match = TRUE)


# Match Jeffrey or Geoffrey, another way
common_ending <- or("Je", "Geo") %R% "ffrey"
str_view(boy_names, pattern = common_ending, match = TRUE)


# Match with alternate endings
by_parts <- or("Je", "Geo") %R% "ff" %R% or("ry", "ery", "rey", "erey")
str_view(boy_names, pattern = by_parts, match = TRUE)

# Match names that start with Cath or Kath
ckath <- START %R% or("C", "K") %R% "ath"
str_view(girl_names, pattern = ckath, match = TRUE)

x <- c("grey sky", "gray elephant")

# Create character class containing vowels
vowels <- char_class("aeiouAEIOU")

# Print vowels
vowels

# See vowels in x with str_view()
str_view(x, pattern = vowels)

# See vowels in x with str_view_all()
str_view_all(x, vowels)


# Number of vowels in boy_names
num_vowels <- str_count(boy_names, vowels)

# Proportion of vowels in boy_names
name_length <- str_length(boy_names)

# Calc mean number of vowels
mean(num_vowels)

# Calc mean fraction of vowels per name
mean(num_vowels / name_length)

# Vowels from last exercise
vowels <- char_class("aeiouAEIOU")

# See names with only vowels
str_view(boy_names, 
         pattern = exactly(one_or_more(vowels)), 
         match = TRUE)

# Use `negated_char_class()` for everything but vowels
not_vowels <- negated_char_class("aeiouAEIOU")

# See names with no vowels
str_view(boy_names, 
         pattern = exactly(one_or_more(not_vowels)), 
         match = TRUE)

contact <- c( "Call me at 555-555-0191",                 
            "123 Main St",                             
            "(555) 555 0191",                          
            "Phone: 555.555.0191 Mobile: 555.555.0192")

# Create a three digit pattern
three_digits <- DGT %R% DGT %R% DGT

# Test it
str_view_all(contact, pattern = three_digits)

three_digits


# Create a separator pattern
separator <- char_class("-.() ")

# Test it
str_view_all(contact, pattern = separator)

# Use these components
three_digits <- DGT %R% DGT %R% DGT
four_digits <- three_digits %R% DGT
separator <- char_class("-.() ")

# Create phone pattern
phone_pattern <- zero_or_more(OPEN_PAREN) %R%
  three_digits %R%
  zero_or_more(separator) %R%
  three_digits %R% 
  zero_or_more(separator) %R%
  four_digits

# Test it           
str_view_all(contact, pattern = phone_pattern)

# Use this pattern
three_digits <- DGT %R% DGT %R% DGT
four_digits <- three_digits %R% DGT
separator <- char_class("-.() ")
phone_pattern <- optional(OPEN_PAREN) %R% 
  three_digits %R% 
  zero_or_more(separator) %R% 
  three_digits %R% 
  zero_or_more(separator) %R%
  four_digits

# Extract phone numbers 
str_extract(contact, phone_pattern)

# Extract ALL phone numbers
str_extract_all(contact, phone_pattern)
narratives <- c( "19YOM-SHOULDER STRAIN-WAS TACKLED WHILE PLAYING FOOTBALL W/ FRIENDS ",               
                 "31 YOF FELL FROM TOILET HITITNG HEAD SUSTAINING A CHI ",                     
                 "ANKLE STR. 82 YOM STRAINED ANKLE GETTING OUT OF BED ",                    
                 "TRIPPED OVER CAT AND LANDED ON HARDWOOD FLOOR. LACERATION ELBOW, LEFT. 33 YOF*",           
                 "10YOM CUT THUMB ON METAL TRASH CAN DX AVULSION OF SKIN OF THUMB ",          
                 "53 YO F TRIPPED ON CARPET AT HOME. DX HIP CONTUSION ",         
                 "13 MOF TRYING TO STAND UP HOLDING ONTO BED FELL AND HIT FOREHEAD ON RADIATOR DX LACERATION",
                 "14YR M PLAYING FOOTBALL; DX KNEE SPRAIN ",
                 "55YOM RIDER OF A BICYCLE AND FELL OFF SUSTAINED A CONTUSION TO KNEE ",
                  "5 YOM ROLLING ON FLOOR DOING A SOMERSAULT AND SUSTAINED A CERVICAL STRA IN")


# Pattern to match one or two digits
age <- DGT %R% optional(DGT)

# Test it
str_view(narratives, pattern = age)

# Use this pattern
age <- DGT %R% optional(DGT)

# Pattern to match units 
unit <- optional(" ") %R% char_class("YO", "YR", "MO")

# Test pattern with age then units
str_view(narratives, pattern = age %R% unit)

# Use these patterns
age <- DGT %R% optional(DGT)
unit <- optional(SPC) %R% or("YO", "YR", "MO")

# Pattern to match gender
gender <- optional(SPC) %R% or ("M", "F")

# Test pattern with age then units then gender
str_view(narratives, pattern = age %R% unit %R% gender)

# Use these patterns
age <- DGT %R% optional(DGT)
unit <- optional(SPC) %R% or("YO", "YR", "MO")
gender <- optional(SPC) %R% or("M", "F")

# Extract age, unit, gender
str_extract(narratives, age %R% unit %R% gender)
age_gender <- str_extract(narratives, age %R% unit %R% gender)

# Extract age and make numeric
as.numeric(str_extract(narratives, age))

# Replace age and units with ""
genders <- str_remove(age_gender, age %R% unit)

# Replace extra spaces
str_remove(genders, " ")

# Numeric ages, from previous step
ages_numeric <- as.numeric(str_extract(age_gender, age))

# Extract units 
time_units <- str_extract(age_gender, unit)

# Extract first word character
time_units_clean <- str_extract(time_units, WRD)

# Turn ages in months to years
ifelse(time_units_clean == "Y", ages_numeric, ages_numeric / 12)


hero_contacts <- c("(wolverine@xmen.com)", "wonderwoman@justiceleague.org", "thor@avengers.com")

# Capture parts between @ and . and after .
email <- capture(one_or_more(WRD)) %R% 
  "@" %R% capture(one_or_more(WRD)) %R% 
  DOT %R% capture(one_or_more(WRD))

# Check match hasn't changed
str_view(hero_contacts, email)

# Pattern from previous step
email <- capture(one_or_more(WRD)) %R% 
  "@" %R% capture(one_or_more(WRD)) %R% 
  DOT %R% capture(one_or_more(WRD))

# Pull out match and captures
email_parts <- str_match(hero_contacts, email)
email_parts

# Save host
host <- email_parts[,3]
host

# View text containing phone numbers
contact

# Add capture() to get digit parts
phone_pattern <- capture(three_digits) %R% zero_or_more(separator) %R% 
  capture(three_digits) %R% zero_or_more(separator) %R%
  capture(four_digits)

# Pull out the parts with str_match()
phone_numbers <- str_match(contact, phone_pattern)

# Put them back together
str_c(
  "(",
  phone_numbers[,2],
  ") ",
  phone_numbers[,3],
  "-",
  phone_numbers[,4])


# narratives has been pre-defined
narratives

# Add capture() to get age, unit and sex
pattern <- capture(optional(DGT) %R% DGT) %R%  
  optional(SPC) %R% capture(or("YO", "YR", "MO")) %R%
  optional(SPC) %R% capture(or("M", "F"))

# Pull out from narratives
str_match(narratives, pattern)

# Edit to capture just Y and M in units
pattern2 <- capture(optional(DGT) %R% DGT) %R%  
  optional(SPC) %R% capture(or("Y", "M")) %R% optional(or("O","R")) %R%
  optional(SPC) %R% capture(or("M", "F"))

# Check pattern
str_view(narratives, pattern2)

# Pull out pieces
str_match(narratives, pattern2)


# Names with three repeated letters
repeated_three_times <-capture(LOWER) %R% REF1 %R% REF1

# Test it
str_view(boy_names, pattern = repeated_three_times, match = TRUE)

# Names with a pair of repeated letters
pair_of_repeated <- capture(LOWER %R% LOWER) %R%  REF1

# Test it
str_view(boy_names, pattern = pair_of_repeated, match = TRUE)


# Names with a pair that reverses
pair_that_reverses <- capture(LOWER) %R% capture(LOWER) %R% REF2 %R% REF1

# Test it
str_view(boy_names, pattern = pair_that_reverses, match = TRUE)

# Four letter palindrome names
four_letter_palindrome <-  exactly(capture(LOWER) %R% capture(LOWER) %R% REF2 %R% REF1) 
# Test it
str_view(boy_names, pattern = four_letter_palindrome, match = TRUE)

# View text containing phone numbers
contact

# Replace digits with "X"
str_replace(contact, DGT, "X")

# Replace all digits with "X"
str_replace_all(contact, DGT, "X")

# Replace all digits with different symbol
str_replace_all(contact, DGT, c("X",".", "*", "_"))

# Build pattern to match words ending in "ING"
pattern <- one_or_more(WRD) %R% "ING"
str_view(narratives, pattern)

# Test replacement
str_replace(narratives, capture(pattern), 
            str_c("CARELESSLY", REF1, sep = " "))

# One adverb per narrative
adverbs_10 <- sample(adverbs, 10)

# Replace "***ing" with "adverb ***ly"
str_replace(narratives, 
            capture(pattern),
            str_c(adverbs_10, REF1, sep = " "))  
                
                