`timescale 1ns / 1ps

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

    // Screen & object sizes
    localparam SCREEN_BOTTOM_Y   = 10'd479;

    localparam PLAYER_Y_START    = 10'd400;
    localparam PLAYER_HEIGHT     = 10'd40;
    localparam PLAYER_Y_END      = PLAYER_Y_START + PLAYER_HEIGHT;
    localparam PLAYER_HALF_WIDTH = 10'd20;   // total width = 40

    localparam OBSTACLE_HEIGHT   = 10'd40;
    localparam OBSTACLE_HALF_W   = 10'd20;   // total width = 40

    // Lane centers in X (tweak as needed)
    localparam LANE0_X_CENTER    = 10'd220;
    localparam LANE1_X_CENTER    = 10'd360;
    localparam LANE2_X_CENTER    = 10'd500;

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

    // Single obstacle
    reg [1:0] obstacle_lane;     // lane of obstacle
    reg [9:0] obstacle_y;        // top of obstacle

    // Game state
    reg [1:0] game_state = ST_START;
    wire is_start    = (game_state == ST_START);
    wire is_play     = (game_state == ST_PLAY);
    wire is_gameover = (game_state == ST_GAMEOVER);

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

    // --------------- INITIAL STATE ----------------------
    initial begin
        lane          = 2'd1;                // start in middle lane
        car_x         = LANE1_X_CENTER;
        car_target_x  = LANE1_X_CENTER;
        car_state     = CAR_READY;

        obstacle_lane = 2'd1;
        obstacle_y    = 10'd0;

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

    wire [9:0] obstacle_x_center =
        (obstacle_lane == 2'd0) ? LANE0_X_CENTER :
        (obstacle_lane == 2'd1) ? LANE1_X_CENTER :
                                  LANE2_X_CENTER;

    // --------------- COLLISION DETECTION ---------------------- 

    wire [9:0] player_x_start = car_x - PLAYER_HALF_WIDTH;
    wire [9:0] player_x_end   = car_x + PLAYER_HALF_WIDTH;

    wire [9:0] obstacle_y_end = obstacle_y + OBSTACLE_HEIGHT;

    wire y_overlap =
        (obstacle_y_end >= PLAYER_Y_START) &&
        (obstacle_y     <= PLAYER_Y_END);

    wire lane_match  = (lane == obstacle_lane);
    wire collision   = lane_match && y_overlap;

    // --------------- MAIN GAME FSM + CAR FSM + OBSTACLE MOTION ----------------
    always @(posedge clk) begin
        case (game_state)

            // ----------------- START STATE ------------------------
            ST_START: begin
                // Reset positions
                lane      <= 2'd1;
                car_x     <= LANE1_X_CENTER;
                car_state <= CAR_READY;

                obstacle_lane <= 2'd0;
                obstacle_y    <= 10'd0;

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
                    if (obstacle_y < SCREEN_BOTTOM_Y + OBSTACLE_HEIGHT) begin
                        obstacle_y <= obstacle_y + OBSTACLE_STEP;
                    end
                    else begin
                        obstacle_y    <= 10'd0;
                        obstacle_lane <= lfsr[1:0] % 3; // random lane 0..2
                        score         <= score + 16'd1;
                    end
                end

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

    // obstacle rectangle
    wire [9:0] obs_x_start = obstacle_x_center - OBSTACLE_HALF_W;
    wire [9:0] obs_x_end   = obstacle_x_center + OBSTACLE_HALF_W;

    wire in_obstacle_rect =
        (hCount >= obs_x_start && hCount < obs_x_end) &&
        (vCount >= obstacle_y  && vCount < obstacle_y_end);

    // lane divider lines (vertical)
    wire in_lane_lines =
        ((hCount == LANE0_X_CENTER) ||
         (hCount == LANE1_X_CENTER) ||
         (hCount == LANE2_X_CENTER)) &&
        (vCount < SCREEN_BOTTOM_Y);

    always @(*) begin
        if (!bright) begin
            rgb = BLACK;          // outside visible area
        end
        else if (is_gameover && collision) begin
            // show collision in red
            if (in_player_rect || in_obstacle_rect)
                rgb = RED;
            else
                rgb = BLACK;
        end
        else begin
            // normal drawing
            rgb = BLACK;          // background

            if (in_lane_lines)
                rgb = GRAY;       // lane dividers

            if (in_obstacle_rect)
                rgb = GREEN;      // obstacle

            if (in_player_rect)
                rgb = WHITE;      // player
        end
    end

endmodule
