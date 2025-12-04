`timescale 1ns / 1ps
 // 2 obstacles
module vga_bitchange(
    input  clk,
    input  bright,
    input  button_L,
    input  button_R,
    input  button_C,
    input  [9:0] hCount, 
    input  [9:0] vCount,
    output reg [11:0] rgb,
    output reg [15:0] score
);

    // -------------- PARAMETERS & CONSTANTS ----------------------
    // Colors
    localparam BLACK  = 12'b0000_0000_0000;
    localparam WHITE  = 12'b1111_1111_1111;
    localparam RED    = 12'b1111_0000_0000;
    localparam GREEN  = 12'b0000_1111_0000;
    localparam GRAY   = 12'b1000_1000_1000;
    localparam BLUE   = 12'h468;
    localparam SAND   = 12'b1110_1100_1010;  // sand color (12-bit RGB: E C A) - light beige

    // Screen & object sizes
    localparam SCREEN_WIDTH      = 10'd640;
    localparam SCREEN_BOTTOM_Y   = 10'd479;

    localparam PLAYER_Y_START    = 10'd400;
    localparam PLAYER_HEIGHT     = 10'd80;
    localparam PLAYER_Y_END      = PLAYER_Y_START + PLAYER_HEIGHT;
    localparam PLAYER_HALF_WIDTH = 10'd40;   // total width = 80

    localparam OBSTACLE_HEIGHT   = 10'd80;
    localparam OBSTACLE_HALF_W   = 10'd40;   // total width = 80
    
    // Rock sprite dimensions (should match obstacle size)
    localparam ROCK_WIDTH   = 10'd80;
    localparam ROCK_HEIGHT  = 10'd80;
    localparam ROCK_HALF_W  = 10'd40;

    // VGA visible area offset (from display_controller: hCount 144-783 is visible)
    localparam H_VISIBLE_START   = 10'd144;  // hCount where visible area starts
    localparam V_VISIBLE_START   = 10'd35;   // vCount where visible area starts
    
    // Lane spacing and playable area (centered on 640px screen)
    // Screen positions: 0-639, but hCount values: 144-783
    localparam LANE_SPACING      = 10'd140;  // spacing between lane centers
    localparam PLAYABLE_WIDTH    = 10'd360;  // total width of 3 lanes area
    localparam PLAYABLE_LEFT     = 10'd140;  // left edge of playable area (screen pos)
    localparam PLAYABLE_RIGHT    = 10'd500;  // right edge of playable area (screen pos)
    
    // hCount values for sand borders (accounting for visible area offset)
    localparam SAND_LEFT_HCOUNT   = H_VISIBLE_START + PLAYABLE_LEFT;   // 144 + 140 = 284
    localparam SAND_RIGHT_HCOUNT  = H_VISIBLE_START + PLAYABLE_RIGHT;  // 144 + 500 = 644

    // Lane centers in X (in hCount coordinates: screen_pos + H_VISIBLE_START)
    // Screen positions: 180, 320, 460 -> hCount: 324, 464, 604
    localparam LANE0_X_CENTER    = H_VISIBLE_START + 10'd180;  // left lane (hCount = 324)
    localparam LANE1_X_CENTER    = H_VISIBLE_START + 10'd320;  // center lane (hCount = 464)
    localparam LANE2_X_CENTER    = H_VISIBLE_START + 10'd460;  // right lane (hCount = 604)

    // movement speeds (pixels per slow_tick)
    localparam OBSTACLE_STEP = 10'd4;  // obstacle speed
    localparam CAR_STEP      = 10'd5;  // car slide speed

    // Car movement FSM states
    localparam CAR_READY   = 1'b0;
    localparam CAR_MOVING  = 1'b1;

    // Game states
    localparam ST_START    = 2'd0;
    localparam ST_PLAY     = 2'd1;
    localparam ST_GAMEOVER = 2'd2;

    // -------------- STATE & GAME SIGNALS ----------------------

    // Car / player
    reg        car_state;        // CAR_READY / CAR_MOVING
    reg [1:0]  lane;             // 0,1,2 (left, middle, right)
    reg [9:0]  car_x;            // current center X
    reg [9:0]  car_target_x;     // target lane center X
    wire [11:0] boat_pixel;
    wire        in_boat_area;

    // Double obstacle
    reg [1:0] obstacle_lane0, obstacle_lane1;
    reg [9:0] obstacle_y0,    obstacle_y1;

    // Game state
    reg [1:0] game_state = ST_START;
    wire is_start    = (game_state == ST_START);
    wire is_play     = (game_state == ST_PLAY);
    wire is_gameover = (game_state == ST_GAMEOVER);

     // Obstacle centers in X (per lane)
    wire [9:0] obs0_x_center =
        (obstacle_lane0 == 2'd0) ? LANE0_X_CENTER :
        (obstacle_lane0 == 2'd1) ? LANE1_X_CENTER :
                                LANE2_X_CENTER;

    wire [9:0] obs1_x_center =
        (obstacle_lane1 == 2'd0) ? LANE0_X_CENTER :
        (obstacle_lane1 == 2'd1) ? LANE1_X_CENTER :
                                LANE2_X_CENTER;
    
    // Rock sprite areas and pixels (defined after obstacle centers)
    wire [9:0] rock0_x_start = obs0_x_center - ROCK_HALF_W;
    wire [9:0] rock0_x_end   = obs0_x_center + ROCK_HALF_W;
    wire [9:0] rock0_y_start = obstacle_y0;
    wire [9:0] rock0_y_end   = obstacle_y0 + ROCK_HEIGHT;
    
    wire [9:0] rock1_x_start = obs1_x_center - ROCK_HALF_W;
    wire [9:0] rock1_x_end   = obs1_x_center + ROCK_HALF_W;
    wire [9:0] rock1_y_start = obstacle_y1;
    wire [9:0] rock1_y_end   = obstacle_y1 + ROCK_HEIGHT;
    
    wire in_rock0_area = (hCount >= rock0_x_start && hCount < rock0_x_end) &&
                         (vCount >= rock0_y_start && vCount < rock0_y_end);
    wire in_rock1_area = (hCount >= rock1_x_start && hCount < rock1_x_end) &&
                         (vCount >= rock1_y_start && vCount < rock1_y_end);
    
    // Local sprite coordinates for rock ROMs (row, col addresses)
    // Rock ROM uses [8:0] addresses (9 bits = up to 512 pixels)
    // Calculate sprite-local coordinates when in rock area
    wire [8:0] rock0_sx = (hCount - rock0_x_start);  // column index (0-79 for 80px width)
    wire [8:0] rock0_sy = (vCount - rock0_y_start);  // row index (0-79 for 80px height)
    wire [8:0] rock1_sx = (hCount - rock1_x_start);
    wire [8:0] rock1_sy = (vCount - rock1_y_start);
    
    // Rock ROM pixel outputs (12-bit RGB color data)
    wire [11:0] rock0_pixel, rock1_pixel;

    // Player X-interval
    wire [9:0] player_x_start = car_x - PLAYER_HALF_WIDTH;
    wire [9:0] player_x_end   = car_x + PLAYER_HALF_WIDTH;

    // Obstacle 0
    wire [9:0] obs0_x_start = obs0_x_center - OBSTACLE_HALF_W;
    wire [9:0] obs0_x_end   = obs0_x_center + OBSTACLE_HALF_W;
    wire [9:0] obs0_y_start = obstacle_y0;
    wire [9:0] obs0_y_end   = obstacle_y0 + OBSTACLE_HEIGHT;

    // Obstacle 1
    wire [9:0] obs1_x_start = obs1_x_center - OBSTACLE_HALF_W;
    wire [9:0] obs1_x_end   = obs1_x_center + OBSTACLE_HALF_W;
    wire [9:0] obs1_y_start = obstacle_y1;
    wire [9:0] obs1_y_end   = obstacle_y1 + OBSTACLE_HEIGHT;


    // --------------- SLOW TICK GENERATOR ----------------------

    reg [21:0] tick_counter = 22'd0;
    wire       slow_tick;

    assign slow_tick = (tick_counter == 22'd0);

    always @(posedge clk) begin
        tick_counter <= tick_counter + 1'b1;
    end

    // --------------- SIMPLE LFSR FOR RANDOM LANE SELECTION ----------------------

    reg [7:0] lfsr = 8'hAC;

    always @(posedge clk) begin
        // Feedback taps: x^8 + x^6 + 1
        lfsr <= {lfsr[6:0], lfsr[7] ^ lfsr[5]};
    end

    // --------------- BOAT VISUALS -----------------------

    boat_anim boat_animation (
        .clk(clk),
        .slow_anim_tick(slow_tick),  // reuse your existing slow_tick for now
        .car_x(car_x),
        .hCount(hCount),
        .vCount(vCount),
        .boat_pixel(boat_pixel),
        .in_boat_area(in_boat_area)
    );

    // --------------- ROCK SPRITES -----------------------
    // Simple ROM sprite lookup (following Xilinx BRAM ROM pattern from article)
    // Single static sprite - no animation, just direct pixel lookup
    // Module: rock_rom (defined in rock_12_bit_rom.v)
    // Inputs: clk, row[8:0], col[8:0]
    // Output: color_data[11:0] - 12-bit RGB (r3r2r1r0 g3g2g1g0 b3b2b1b0)
    
    rock_rom rock0_rom (
        .clk(clk),
        .row(rock0_sy),      // sprite row coordinate (0-79)
        .col(rock0_sx),      // sprite column coordinate (0-79)
        .color_data(rock0_pixel)
    );
    
    rock_rom rock1_rom (
        .clk(clk),
        .row(rock1_sy),
        .col(rock1_sx),
        .color_data(rock1_pixel)
    );


    // --------------- INITIAL STATE ----------------------
    initial begin
        lane          = 2'd1;                // start in middle lane
        car_x         = LANE1_X_CENTER;
        car_target_x  = LANE1_X_CENTER;
        car_state     = CAR_READY;

    //    obstacle_lane = 2'd1;
    //    obstacle_y    = 10'd0;

        score         = 16'd0;
    end

    // --------------- LANE: TARGET & OBSTACLE X CENTER ----------------------
    always @(*) begin
        case (lane)
            2'd0: car_target_x = LANE0_X_CENTER;
            2'd1: car_target_x = LANE1_X_CENTER;
            2'd2: car_target_x = LANE2_X_CENTER;
            default: car_target_x = LANE1_X_CENTER;
        endcase
    end

    // --------------- COLLISION DETECTION ---------------------- 
    // Use rock sprite areas for collision detection (more accurate than rectangles)

    // Collision with rock 0 or rock 1
    wire collision0 = in_rock0_area && in_boat_area;
    wire collision1 = in_rock1_area && in_boat_area;

    // Final collision flag
    wire collision = collision0 || collision1;


    // --------------- MAIN GAME FSM + CAR FSM + OBSTACLE MOTION ----------------
    always @(posedge clk) begin
        case (game_state)

            // ----------------- START STATE ------------------------
            ST_START: begin
                // Reset positions
                lane      <= 2'd1;
                car_x     <= LANE1_X_CENTER;
                car_state <= CAR_READY;

            //    obstacle_lane <= 2'd0;
            //    obstacle_y    <= 10'd0;
           
                // Independent obstacles at different Y positions
                obstacle_lane0 <= 2'd0;     // left lane
                obstacle_y0    <= 10'd0;

                obstacle_lane1 <= 2'd2;     // right lane
                obstacle_y1    <= 10'd80;  // mid-screen offset


                score <= 16'd0;

                // start when center button is pressed
                if (button_C)
                    game_state <= ST_PLAY;
            end

            // ---------------- PLAY STATE --------------------
            ST_PLAY: begin
                // ---- CAR MOVEMENT FSM ----
                case (car_state)
                    CAR_READY: begin
                        // car locked to lane center, accept inputs
                        car_x <= car_target_x;

                        if (button_L && lane > 0) begin
                            lane      <= lane - 1;
                            car_state <= CAR_MOVING;
                        end
                        else if (button_R && lane < 2) begin
                            lane      <= lane + 1;
                            car_state <= CAR_MOVING;
                        end
                    end

                    CAR_MOVING: begin
                        // slide smoothly toward target
                        if (slow_tick) begin
                            if (car_x < car_target_x)
                                car_x <= car_x + CAR_STEP;
                            else if (car_x > car_target_x)
                                car_x <= car_x - CAR_STEP;
                        end

                        // when aligned, return to READY
                        if (car_x == car_target_x)
                            car_state <= CAR_READY;
                    end
                endcase

                // ---- OBSTACLE MOTION + SCORING ----
                if (slow_tick) begin
                //    if (obstacle_y < SCREEN_BOTTOM_Y + OBSTACLE_HEIGHT) begin
                //        obstacle_y <= obstacle_y + OBSTACLE_STEP;
                //    end
                    if (obstacle_y0 < SCREEN_BOTTOM_Y + OBSTACLE_HEIGHT) begin
                        obstacle_y0 <= obstacle_y0 + OBSTACLE_STEP;
                    end else begin
                        obstacle_y0    <= 10'd0;
                        obstacle_lane0 <= lfsr[1:0] % 3;   // random lane 0..2
                        score          <= score + 16'd1;
                    end

                    // obstacle 1
                    if (obstacle_y1 < SCREEN_BOTTOM_Y + OBSTACLE_HEIGHT) begin
                        obstacle_y1 <= obstacle_y1 + OBSTACLE_STEP;
                    end else begin
                        obstacle_y1    <= 10'd0;
                        obstacle_lane1 <= lfsr[3:2] % 3;   // independent random lane 0..2
                        score          <= score + 16'd1;
                    end
                end

                //    else begin
                //        obstacle_y    <= 10'd0;
                //        obstacle_lane <= lfsr[1:0] % 3; // random lane 0..2
                //        score         <= score + 16'd1;
                //    end
                //end

                // ---- COLLISION CHECK ----
                if (collision) begin
                    game_state <= ST_GAMEOVER;
                end

                // optional: allow center button to bail back to START
                if (button_C) begin
                    game_state <= ST_START;
                end
            end

            // ---------------- GAMEOVER STATE ----------------
            ST_GAMEOVER: begin
                // freeze car & obstacle (no movement here)
                // restart with center button
                if (button_C)
                    game_state <= ST_START;
            end

            default: game_state <= ST_START;
        endcase
    end

    // --------------- DRAWING LOGIC ---------------------- 

    // player rectangle
    wire in_player_rect =
        (hCount >= player_x_start && hCount < player_x_end) &&
        (vCount >= PLAYER_Y_START && vCount < PLAYER_Y_END);

    wire in_obstacle0 =
        (hCount >= obs0_x_start && hCount < obs0_x_end) &&
        (vCount >= obstacle_y0  && vCount < obs0_y_end);

    wire in_obstacle1 =
        (hCount >= obs1_x_start && hCount < obs1_x_end) &&
        (vCount >= obstacle_y1  && vCount < obs1_y_end);

    wire in_obstacle_rect = in_obstacle0 || in_obstacle1;


    // lane divider lines (vertical)
    wire in_lane_lines =
        ((hCount == LANE0_X_CENTER) ||
         (hCount == LANE1_X_CENTER) ||
         (hCount == LANE2_X_CENTER)) &&
        (vCount < SCREEN_BOTTOM_Y);

    // Sand border areas (outside the 3 lanes)
    // hCount values: visible area is 144-783, so sand is before 284 and after 644
    wire in_sand_area = (hCount < SAND_LEFT_HCOUNT) || (hCount >= SAND_RIGHT_HCOUNT);

    always @(*) begin
        if (!bright) begin
            rgb = BLACK;          // outside visible area
        end
        else if (is_gameover && collision) begin
            // show collision in red
            if (in_boat_area || in_rock0_area || in_rock1_area)
                rgb = RED;
            else if (in_sand_area)
                rgb = SAND;       // sand border even in gameover
            else
                rgb = BLUE;
        end
        else begin
            // normal drawing
            // Draw sand border first (outside playable area)
            if (in_sand_area) begin
                rgb = SAND;       // sand-colored edge
            end
            else begin
                // Inside playable area - draw game elements
                rgb = BLUE;       // background (water)

                if (in_lane_lines)
                    rgb = BLUE;   // lane dividers

                // Draw rock sprites instead of green rectangles
                if (in_rock0_area)
                    rgb = rock0_pixel;
                else if (in_rock1_area)
                    rgb = rock1_pixel;

              //  if (in_player_rect)
                //    rgb = WHITE;      // player

               // BOAT SPRITE: draw over everything else
                if (in_boat_area)
                    rgb = boat_pixel;
            end
        end
    end

endmodule


// change the red
// add obstacles