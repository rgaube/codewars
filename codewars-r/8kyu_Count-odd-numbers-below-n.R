####################################
# [8kyu] Count odd numbers below n #
####################################
# https://www.codewars.com/kata/59342039eb450e39970000a6

# --- Instructions ----------------
# Given a number n, return the number of positive odd numbers below n, EASY!
# But expect large inputs! So take care of good performance.

# --- Examples --------------------
# oddCount(7) //=> 3, i.e [1, 3, 5]
# oddCount(15) //=> 7, i.e [1, 3, 5, 7, 9, 11, 13]

# --- Solution ---------------------
odd_count <- function(n) {

  floor(n/2)

  # Initial solution timing out
  # sum(1:n %% 2 != 0)-1
}
