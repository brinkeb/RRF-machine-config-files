M915 X S2 F0 H400 R0                               ; Set X axis Sensitivity
M915 Y S2 F0 H400 R0                               ; Set y axis Sensitivity
M913 X45 Y45 Z100                                  ; set X Y Z motors to 50% of their normal current

G91                                                ; relative positioning

G1 Z3 F800 H2                                      ; lift Z relative to current position


; HOME X
G1 H0 X5 F1000                                     ; move slowly away 
G1 H1 X-255 F3000                                  ; move quickly to X endstop 

G1 H0 X5 F1000                                     ; move slowly away 
G1 H1 X-255 F3000                                  ; move quickly to X endstop, second check 


; HOME Y
G1 H0 Y5 F1000                                     ; move slowly away 
G1 H1 Y-215 F3000                                  ; move quickly to Y endstop 

G1 H0 Y5 F1000                                     ; move slowly away 
G1 H1 Y-215 F3000                                  ; move quickly to Y endstops, second check


; HOME Z
G1 H2 Z2 F2600                                     ; raise head 2mm to ensure it is above the Z probe trigger height
G90                                                ; back to absolute mode
G1 X15 Y15 F6000                                   ; go to first probe point
G30                                                ; home Z by probing the bed


M913 X100 Y100 Z100                                ; set X Y Z motors to 100% of their normal current
M915 X S3 F0 H200 R0                               ; Set X axis Sensitivity
M915 Y S3 F0 H200 R0                               ; Set y axis Sensitivity