H_ext = 6.1;
W_ext = 17.0;
L_ext = 30.25;

H_int = 4.1;
W_int = 15;
L_int = 29.25;

Holes_spacing = 2.54;
Hole_from_border_L = 3.54 - 0.33;
Hole_from_ext_border_W = 6.5 - 0.33;
Hole_dia = 1.6;
actual_dia = Hole_dia * 1.2;
Hole_dia_pinhead = 1.8;
actual_dia_pinhead = Hole_dia_pinhead * 1.2;

side_to_notch = 4.0; //distance along the width of the PCB between its border and the start of the breakable tab notch.
back_to_notch = 10.0; //distance along the length of the PCB between its border and the start of the breakable tab notch.
notch = 8.0; //width along the length of the PCB between of the breakable tab notch.


// This side will receive the U2F board to be programmed.
difference()
{
    // Basic outline
    cube( [W_ext, L_ext, H_ext] );
    
    // Removing a pcb sized chunk from the top
    translate( [(W_ext - W_int) / 2.0, L_ext - L_int, H_int] )
        cube( [W_int, L_ext, H_int] );

    // Holes for the pogo pins. Their head will go there, make the hole larger so they doesn't get stuck after being pressed.
    translate( [W_ext / 2.0, L_ext - Hole_from_border_L, -1] )
        cylinder( d=actual_dia_pinhead, $fn=5, h= H_ext + 2 );
    
    translate( [W_ext / 2.0 - Holes_spacing, L_ext - Hole_from_border_L, -1] )
        rotate( [0, 0, 180] )
            cylinder( d=actual_dia_pinhead, $fn=5, h=H_ext + 2 );
    
    translate( [W_ext / 2.0 - Holes_spacing, L_ext - Hole_from_border_L - Holes_spacing, -1] )
        rotate( [0, 0, 180] )
            cylinder( d=actual_dia_pinhead, $fn=5, h=H_ext + 2 );
    
    // 2 holes to ease assembly of the 2 parts using a bit of 3mm filament
    translate( [W_ext / 3.0, L_ext / 3.0, -0.1] )
        cylinder( r=1.7, $fn=6, h=H_int + 0.2 );
        
    translate( [W_ext / 3.0 * 2, L_ext / 3.0 * 2, -0.1] )
        cylinder( r=1.7, $fn=6, h=H_int + 0.2 );
    
    // On this side, removing notches so the remnant of the breakable tabs doesn't forbid us to slip the PCB in place.
    translate( [side_to_notch + (W_ext - W_int) / 2.0, -0.1, H_int] )
        cube( [W_int - 2 * side_to_notch, L_ext - L_int + 0.2, H_ext - H_int + 0.1] );
        
    translate( [-0.1, back_to_notch, H_int] )
        cube( [(W_ext - W_int) / 2.0 + 0.2, notch, H_ext - H_int + 0.1] );
        
    translate( [W_ext - 0.1 - (W_ext - W_int) / 2.0, back_to_notch, H_int] )
        cube( [(W_ext - W_int) / 2.0 + 0.2, notch, H_ext - H_int + 0.1] );
}


// A mirrored version of the previous, without notches and with smaller pogo pins holes.
// This side is where you should connect you pogo pins to whatever you use for programming - IE perfboard.
translate( [-2, 0, 0] ) mirror() difference()
{
    // Basic outline
    cube( [W_ext, L_ext, H_ext] );
    
    // Removing a pcb sized chunk from the top
    translate( [(W_ext - W_int) / 2.0, L_ext - L_int, H_int] )
        cube( [W_int, L_ext, H_int] );
    
    // Holes for the pogo pins. Smaller here as we need them to be a tight fit around the pins tail..
    translate( [W_ext / 2.0, L_ext - Hole_from_border_L, -1] )
        cylinder( d=actual_dia, $fn=5, h= H_ext + 2 );
    
    translate( [W_ext / 2.0 - Holes_spacing, L_ext - Hole_from_border_L, -1] )
        rotate( [0, 0, 180] )
            cylinder( d=actual_dia, $fn=5, h=H_ext + 2 );
    
    translate( [W_ext / 2.0 - Holes_spacing, L_ext - Hole_from_border_L - Holes_spacing, -1] )
        rotate( [0, 0, 180] )
            cylinder( d=actual_dia, $fn=5, h=H_ext + 2 );
    
    // 2 holes to ease assembly of the 2 parts using a bit of 3mm filament
    translate( [W_ext / 3.0, L_ext / 3.0, -0.1] )
        cylinder( r=1.7, $fn=6, h=H_int + 0.2 );
    
    translate( [W_ext / 3.0 * 2, L_ext / 3.0 * 2, -0.1] )
        cylinder( r=1.7, $fn=6, h=H_int + 0.2 );
}