`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: rock_anim
// Description: Renders rock sprite from ROM
/////////////////////////////////////////////////////////////////////////////////////

module rock_anim(
    input        clk,
    input [9:0]  rock_x_center,     // center of the rock in X (hCount coordinates)
    input [9:0]  rock_y_top,        // top Y position of rock (vCount coordinates)
    input [9:0]  hCount,            // current VGA pixel X
    input [9:0]  vCount,            // current VGA pixel Y

    output [11:0] rock_pixel,       // pixel color from sprite
    output        in_rock_area      // 1 if this pixel is part of the rock
);
    // ---------------- Sprite geometry ----------------
    // Rock sprite dimensions (adjust based on actual sprite size)
    // Using 9-bit addresses suggests sprite could be up to 512x512
    // Assuming rock is similar to obstacle size, but will work with ROM's actual size
    localparam ROCK_W      = 10'd80;   // width of rock sprite
    localparam ROCK_H      = 10'd80;   // height of rock sprite
    localparam ROCK_HALF_W = 10'd40;   // half width

    // Top-left and bottom-right of sprite on screen
    wire [9:0] rock_x_start = rock_x_center - ROCK_HALF_W;
    wire [9:0] rock_y_start = rock_y_top;
    wire [9:0] rock_x_end   = rock_x_start + ROCK_W;
    wire [9:0] rock_y_end   = rock_y_start + ROCK_H;

    assign in_rock_area =
        (hCount >= rock_x_start && hCount < rock_x_end) &&
        (vCount >= rock_y_start && vCount < rock_y_end);

    // Local sprite coordinates (0..79); only meaningful if in_rock_area = 1
    // Rock ROM uses [8:0] for row and col, so we need 9-bit addresses
    wire [8:0] sx = (hCount - rock_x_start);  // column index (9 bits)
    wire [8:0] sy = (vCount - rock_y_start);  // row index (9 bits)

    // ---------------- Instantiate rock ROM ----------------
    wire [11:0] rock_pix;

    rock_rom rock_rom_inst (
        .clk(clk),
        .row(sy),
        .col(sx),
        .color_data(rock_pix)
    );

    // Output pixel (use 0 for transparent/background if needed)
    // For now, output the pixel directly
    assign rock_pixel = rock_pix;
    // Note: If the rock has a transparent background color, you might want to
    // mask it here similar to how boat_anim might handle it

endmodule

