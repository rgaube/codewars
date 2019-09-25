#######################################
# [8kyu] Convert string to camel case #
#######################################
# https://www.codewars.com/kata/517abf86da9663f1d2000003

# ------- Instructions ----------------
# Complete the method/function so that it converts dash/underscore delimited words into 
# camel casing. The first word within the output should be capitalized only if the original 
# word was capitalized (known as Upper Camel Case, also often referred to as Pascal case).

# ------- Examples --------------------

# toCamelCase("the-stealth-warrior") // returns "theStealthWarrior"
# toCamelCase("The_Stealth_Warrior") // returns "TheStealthWarrior"

# ------- Solution --------------------

to_camel_case <- function(text){
  # Test that input is not empty string and contains dashes and/or underscores
  if ((text != "") && grep("-|_", text)) {
    # Helper function: removes dashes and underscores and capitalizes the subsequent letter 
    camelcasing(text)
  } else {text}
}

# Helper function
camelcasing <- function(text){
  # split string into single character vector
  chars <- unlist(strsplit(text,""))
  # retrieve positions of dashes and underscores in string vector 
  pos <- which(chars == "_" | chars == "-")
  # capitalize small letters after dashes or underscores
  chars[pos+1] <- toupper(chars[pos+1])
  # remove dashes and underscores
  paste0(chars[-pos], sep="", collapse = "")
}
