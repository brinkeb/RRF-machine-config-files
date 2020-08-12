; 0:/sys/start.g
; Executed before each print - BEFORE ANY SLICER CODE IS RAN
; Alternative Start.g - This loads the heightmap from the system's set filament
; type directory (0:/filaments/PETG/heightmap.csv), if the heightmap does not
; exist, create one, and then save in the filament's directory.
 
T0                                                         ; Ensure tool is selected
;M280 P0 S160                                              ; BLTouch, alarm release
;G4 P100                                                   ; BLTouch, delay for the release command
M572 D0 S0.0                                               ; clear pressure advance
M220 S100                                                  ; Set speed factor back to 100% in case it was changed
M221 S100                                                  ; Set extrusion factor back to 100% in case it was changed
M290 R0 S0                                                 ; Clear babystepping
M106 S0                                                    ; Turn part cooling blower off if it is on
M703                                                       ; Execute loaded filament's config.g
G28                                                        ; Home all

;G1 Z5 X100 Y100                                           ; [PINDA] Place nozzle center of bed, 5mm up

G1 Z160 F300                                               ; [BLTouch] Last chance to check nozzle cleanliness

M300 S4000 P100 G4 P200 M300 S4000 P100                    ; Give a double beep
M116                                                       ; wait for all temperatures
M300 S4000 P100                                            ; Give a single beep

; [BLTouch] Start countdown - use Z as indicator  
G91                                                        ; [BLTouch] Set to Relative Positioning
while iterations <=9                                       ; [BLTouch] Perform 10 passes
    G4 S12                                                 ; [BLTouch] Wait 12 seconds
    G1 Z-15 F300                                           ; [BLTouch] Move Z 15mm down
G90                                                        ; [BLTouch] Set to Absolute Positioning

;G4 S120                                                   ; [PINDA] wait additional 2 minutes for the bed to stabilize

G32                                                        ; Level bed
G29 S1 [P{"0:/filaments/" ^ move.extruders[0].filament ^ "/heightmap.csv"}] ; Load bed mesh for the system's set filament type
if result > 1                                              ; If file doesn't exist, perform mesh and save
   G29                                                     ; Perform mesh now
   G29 S3 [P{"0:/filaments/" ^ move.extruders[0].filament ^ "/heightmap.csv"}] ; Save heightmap.csv to filament type's directory
G90                                                        ; Absolute Positioning
M83                                                        ; Extruder relative mode
M98 P"0:/sys/current-sense-normal.g"                       ; Ensure that motor currents and sense are set for printing 
G1 X0 Y0 Z2                                                ; Final position before slicer's temp is reached and primeline is printed.
 
; The primeline macro is executed by the slicer gcode to enable direct printing
; of the primeline at the objects temp and to immediately print the object
; following primeline completion. 
 
; Slicer generated gcode takes it away from here
