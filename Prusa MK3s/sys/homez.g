G91              							; relative positioning
G1 H0 Z3 F6000  							; lift Z relative to current position
G90              							; absolute positioning

G1 X15 Y15 F6000 							; go to first probe point
G30              							; home Z by probing the bed

; Uncomment the following lines to lift Z after probing
;G91             							; relative positioning
;G1 H0 Z5 F100   							; lift Z relative to current position
;G90             							; absolute positioning