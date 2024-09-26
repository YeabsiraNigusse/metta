


(: Planet Type)
(: Mercury Planet)
(: Venus Planet)
(: Earth Planet)
(: Mars Planet)
(: Jupiter Planet)
(: Saturn Planet)
(: Uranus Planet)
(: Neptune Planet)

(: ageOn (-> Planet Number Number))
(= (ageOn $Planet $second) 
    (case $Planet
        (
            (Mercury (/ $second (* 86400 (* 365.25 0.2408467))))
            (Venus (/ $second (* 86400 (* 365.25 0.61519726))))
            (Earth (/ $second (* 86400 365.25)))
            (Mars (/ $second (* 86400 (* 365.25 1.8808158))))
            (Jupiter (/ $second (* 86400 (* 365.25 11.862615))))
            (Satern (/ $second (* 86400 (* 365.25 29.447498))))
            (Uranus (/ $second (* 86400 (* 365.25 84.016846))))
            (Neptune (/ $second (* 86400 (* 365.25 164.79132))))
        )
    )

)

! (ageOn Mercury 2134835688)
! (ageOn Mars 2129871239)
! (ageOn Neptune 1821023456)