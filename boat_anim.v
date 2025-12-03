`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2025 03:43:34 AM
// Design Name: 
// Module Name: boat_anim
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
/////////////////////////////////////////////////////////////////////////////////////


`timescale 1ns / 1ps

module boat_anim(
    input        clk,
    input        slow_anim_tick,      // drive with slow_tick for now
    input [9:0]  car_x,               // center of the boat in X
    input [9:0]  hCount,              // current VGA pixel X
    input [9:0]  vCount,              // current VGA pixel Y

    output [11:0] boat_pixel,         // pixel color from current frame
    output        in_boat_area        // 1 if this pixel is part of the boat
);
    // ---------------- Sprite geometry ----------------
    localparam BOAT_W      = 10'd40;
    localparam BOAT_H      = 10'd40;
    localparam BOAT_HALF_W = 10'd20;

    // vertical position of boat on screen (adjust if you want higher/lower)
    localparam BOAT_Y_START = 10'd400;

    // Top-left and bottom-right of sprite on screen
    wire [9:0] boat_x_start = car_x - BOAT_HALF_W;
    wire [9:0] boat_y_start = BOAT_Y_START;
    wire [9:0] boat_x_end   = boat_x_start + BOAT_W;
    wire [9:0] boat_y_end   = boat_y_start + BOAT_H;

    assign in_boat_area =
        (hCount >= boat_x_start && hCount < boat_x_end) &&
        (vCount >= boat_y_start && vCount < boat_y_end);

    // Local sprite coordinates (0..39); only meaningful if in_boat_area = 1
    wire [5:0] sx = hCount - boat_x_start;  // column index
    wire [5:0] sy = vCount - boat_y_start;  // row index

    // ---------------- Animation frame counter ----------------
    // 8 frames: 0..7
    reg [2:0] frame = 3'd0;

    always @(posedge clk) begin
        if (slow_anim_tick) begin
            frame <= frame + 3'd1;   // wraps automatically 7 -> 0
        end
    end

    // ---------------- Instantiate sprite ROMs ----------------
    // Each ROM module came from ee354_optimized_sprite_script:
    // module boat0_rom(input clk, input [ROW_W-1:0] row,
    //                  input [COL_W-1:0] col, output reg [11:0] color_data);

    wire [11:0] pix0, pix1, pix2, pix3, pix4, pix5, pix6, pix7;

    boat0_rom rom0 (.clk(clk), .row(sy), .col(sx), .color_data(pix0));
    boat1_rom rom1 (.clk(clk), .row(sy), .col(sx), .color_data(pix1));
    boat2_rom rom2 (.clk(clk), .row(sy), .col(sx), .color_data(pix2));
    boat3_rom rom3 (.clk(clk), .row(sy), .col(sx), .color_data(pix3));
    boat4_rom rom4 (.clk(clk), .row(sy), .col(sx), .color_data(pix4));
    boat5_rom rom5 (.clk(clk), .row(sy), .col(sx), .color_data(pix5));
    boat6_rom rom6 (.clk(clk), .row(sy), .col(sx), .color_data(pix6));
    boat7_rom rom7 (.clk(clk), .row(sy), .col(sx), .color_data(pix7));

    // ---------------- Select pixel from current frame ----------------
    reg [11:0] curr_pixel;

    always @(*) begin
        case (frame)
            3'd0: curr_pixel = pix0;
            3'd1: curr_pixel = pix1;
            3'd2: curr_pixel = pix2;
            3'd3: curr_pixel = pix3;
            3'd4: curr_pixel = pix4;
            3'd5: curr_pixel = pix5;
            3'd6: curr_pixel = pix6;
            3'd7: curr_pixel = pix7;
            default: curr_pixel = pix0;
        endcase
    end

    assign boat_pixel = curr_pixel;

endmodule
