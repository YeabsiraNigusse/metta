

(: leapYear (-> Number Bool))

(= (leapYear $num) (
   ( if (not (== (% $num 4) 0) ) False (if (== (% $num 400) 0) True (if (== (% $num 100) 0) False True)))
))


! (leapYear 80)