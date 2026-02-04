module boat4_rom
	(
		input wire clk,
		input wire [5:0] row,
		input wire [5:0] col,
		output reg [11:0] color_data
	);

	(* rom_style = "block" *)

	//signal declaration
	reg [5:0] row_reg;
	reg [5:0] col_reg;

	always @(posedge clk)
		begin
		row_reg <= row;
		col_reg <= col;
		end

	always @(*) begin
		if(({row_reg, col_reg}>=12'b000000000000) && ({row_reg, col_reg}<12'b000000010011)) color_data = 12'b010001101000;
		if(({row_reg, col_reg}>=12'b000000010011) && ({row_reg, col_reg}<12'b000000010101)) color_data = 12'b010001000100;

		if(({row_reg, col_reg}>=12'b000000010101) && ({row_reg, col_reg}<12'b000001010001)) color_data = 12'b010001101000;
		if(({row_reg, col_reg}==12'b000001010001)) color_data = 12'b010101101000;
		if(({row_reg, col_reg}==12'b000001010010)) color_data = 12'b001101000110;
		if(({row_reg, col_reg}>=12'b000001010011) && ({row_reg, col_reg}<12'b000001010101)) color_data = 12'b010100110001;
		if(({row_reg, col_reg}==12'b000001010101)) color_data = 12'b001101000110;
		if(({row_reg, col_reg}==12'b000001010110)) color_data = 12'b010101101000;

		if(({row_reg, col_reg}>=12'b000001010111) && ({row_reg, col_reg}<12'b000010010001)) color_data = 12'b010001101000;
		if(({row_reg, col_reg}==12'b000010010001)) color_data = 12'b010001010111;
		if(({row_reg, col_reg}==12'b000010010010)) color_data = 12'b010000100001;
		if(({row_reg, col_reg}==12'b000010010011)) color_data = 12'b010000010001;
		if(({row_reg, col_reg}==12'b000010010100)) color_data = 12'b001100010001;
		if(({row_reg, col_reg}==12'b000010010101)) color_data = 12'b001000010001;
		if(({row_reg, col_reg}==12'b000010010110)) color_data = 12'b010001010111;

		if(({row_reg, col_reg}>=12'b000010010111) && ({row_reg, col_reg}<12'b000011010001)) color_data = 12'b010001101000;
		if(({row_reg, col_reg}==12'b000011010001)) color_data = 12'b001100110100;
		if(({row_reg, col_reg}==12'b000011010010)) color_data = 12'b010000100000;
		if(({row_reg, col_reg}==12'b000011010011)) color_data = 12'b011100110010;
		if(({row_reg, col_reg}==12'b000011010100)) color_data = 12'b011000110010;
		if(({row_reg, col_reg}==12'b000011010101)) color_data = 12'b001000000000;
		if(({row_reg, col_reg}==12'b000011010110)) color_data = 12'b001100110100;
		if(({row_reg, col_reg}==12'b000011010111)) color_data = 12'b010101111000;

		if(({row_reg, col_reg}>=12'b000011011000) && ({row_reg, col_reg}<12'b000100010000)) color_data = 12'b010001101000;
		if(({row_reg, col_reg}==12'b000100010000)) color_data = 12'b010101101000;
		if(({row_reg, col_reg}==12'b000100010001)) color_data = 12'b001000110100;
		if(({row_reg, col_reg}==12'b000100010010)) color_data = 12'b011000100000;
		if(({row_reg, col_reg}==12'b000100010011)) color_data = 12'b011100110001;
		if(({row_reg, col_reg}==12'b000100010100)) color_data = 12'b011000110001;
		if(({row_reg, col_reg}==12'b000100010101)) color_data = 12'b010000010001;
		if(({row_reg, col_reg}==12'b000100010110)) color_data = 12'b001000110100;
		if(({row_reg, col_reg}==12'b000100010111)) color_data = 12'b010101101000;

		if(({row_reg, col_reg}>=12'b000100011000) && ({row_reg, col_reg}<12'b000101010000)) color_data = 12'b010001101000;
		if(({row_reg, col_reg}==12'b000101010000)) color_data = 12'b010101111001;
		if(({row_reg, col_reg}==12'b000101010001)) color_data = 12'b001101000101;
		if(({row_reg, col_reg}==12'b000101010010)) color_data = 12'b010100110010;
		if(({row_reg, col_reg}==12'b000101010011)) color_data = 12'b011100110010;
		if(({row_reg, col_reg}==12'b000101010100)) color_data = 12'b010100100010;
		if(({row_reg, col_reg}==12'b000101010101)) color_data = 12'b010000100010;
		if(({row_reg, col_reg}==12'b000101010110)) color_data = 12'b001101000101;
		if(({row_reg, col_reg}==12'b000101010111)) color_data = 12'b010101111001;

		if(({row_reg, col_reg}>=12'b000101011000) && ({row_reg, col_reg}<12'b000110001111)) color_data = 12'b010001101000;
		if(({row_reg, col_reg}>=12'b000110001111) && ({row_reg, col_reg}<12'b000110010010)) color_data = 12'b001101010110;
		if(({row_reg, col_reg}==12'b000110010010)) color_data = 12'b000100110100;
		if(({row_reg, col_reg}==12'b000110010011)) color_data = 12'b010000010001;
		if(({row_reg, col_reg}==12'b000110010100)) color_data = 12'b001100010001;
		if(({row_reg, col_reg}==12'b000110010101)) color_data = 12'b001000110100;
		if(({row_reg, col_reg}==12'b000110010110)) color_data = 12'b001101010110;
		if(({row_reg, col_reg}>=12'b000110010111) && ({row_reg, col_reg}<12'b000110011001)) color_data = 12'b001101000110;
		if(({row_reg, col_reg}==12'b000110011001)) color_data = 12'b010001010111;

		if(({row_reg, col_reg}>=12'b000110011010) && ({row_reg, col_reg}<12'b000111001110)) color_data = 12'b010001101000;
		if(({row_reg, col_reg}==12'b000111001110)) color_data = 12'b001000110100;
		if(({row_reg, col_reg}>=12'b000111001111) && ({row_reg, col_reg}<12'b000111010001)) color_data = 12'b011001010100;
		if(({row_reg, col_reg}==12'b000111010001)) color_data = 12'b000100100010;
		if(({row_reg, col_reg}==12'b000111010010)) color_data = 12'b000000010001;
		if(({row_reg, col_reg}==12'b000111010011)) color_data = 12'b011000100001;
		if(({row_reg, col_reg}==12'b000111010100)) color_data = 12'b010100100010;
		if(({row_reg, col_reg}==12'b000111010101)) color_data = 12'b010000100010;
		if(({row_reg, col_reg}==12'b000111010110)) color_data = 12'b001100100010;
		if(({row_reg, col_reg}==12'b000111010111)) color_data = 12'b000000100010;
		if(({row_reg, col_reg}>=12'b000111011000) && ({row_reg, col_reg}<12'b000111011010)) color_data = 12'b000100100010;
		if(({row_reg, col_reg}==12'b000111011010)) color_data = 12'b010001010111;

		if(({row_reg, col_reg}>=12'b000111011011) && ({row_reg, col_reg}<12'b001000001101)) color_data = 12'b010001101000;
		if(({row_reg, col_reg}==12'b001000001101)) color_data = 12'b001101000101;
		if(({row_reg, col_reg}==12'b001000001110)) color_data = 12'b010000100000;
		if(({row_reg, col_reg}==12'b001000001111)) color_data = 12'b100101010010;
		if(({row_reg, col_reg}>=12'b001000010000) && ({row_reg, col_reg}<12'b001000010010)) color_data = 12'b100001000010;
		if(({row_reg, col_reg}==12'b001000010010)) color_data = 12'b100001000001;
		if(({row_reg, col_reg}==12'b001000010011)) color_data = 12'b100101000010;
		if(({row_reg, col_reg}==12'b001000010100)) color_data = 12'b011000110010;
		if(({row_reg, col_reg}>=12'b001000010101) && ({row_reg, col_reg}<12'b001000011001)) color_data = 12'b010000100010;
		if(({row_reg, col_reg}==12'b001000011001)) color_data = 12'b010000010010;
		if(({row_reg, col_reg}==12'b001000011010)) color_data = 12'b000100010001;
		if(({row_reg, col_reg}==12'b001000011011)) color_data = 12'b010001010111;

		if(({row_reg, col_reg}>=12'b001000011100) && ({row_reg, col_reg}<12'b001001001011)) color_data = 12'b010001101000;
		if(({row_reg, col_reg}==12'b001001001011)) color_data = 12'b010101101000;
		if(({row_reg, col_reg}==12'b001001001100)) color_data = 12'b001101010111;
		if(({row_reg, col_reg}==12'b001001001101)) color_data = 12'b100001100101;
		if(({row_reg, col_reg}==12'b001001001110)) color_data = 12'b101001110101;
		if(({row_reg, col_reg}==12'b001001001111)) color_data = 12'b010100100010;
		if(({row_reg, col_reg}==12'b001001010000)) color_data = 12'b011000110010;
		if(({row_reg, col_reg}==12'b001001010001)) color_data = 12'b010000110010;
		if(({row_reg, col_reg}==12'b001001010010)) color_data = 12'b001100100010;
		if(({row_reg, col_reg}==12'b001001010011)) color_data = 12'b011100110010;
		if(({row_reg, col_reg}==12'b001001010100)) color_data = 12'b010100100010;
		if(({row_reg, col_reg}==12'b001001010101)) color_data = 12'b010000100010;
		if(({row_reg, col_reg}==12'b001001010110)) color_data = 12'b010100100010;
		if(({row_reg, col_reg}>=12'b001001010111) && ({row_reg, col_reg}<12'b001001011010)) color_data = 12'b001100100010;
		if(({row_reg, col_reg}==12'b001001011010)) color_data = 12'b000100100010;
		if(({row_reg, col_reg}==12'b001001011011)) color_data = 12'b001000110100;
		if(({row_reg, col_reg}==12'b001001011100)) color_data = 12'b010101111000;

		if(({row_reg, col_reg}>=12'b001001011101) && ({row_reg, col_reg}<12'b001010001011)) color_data = 12'b010001101000;
		if(({row_reg, col_reg}==12'b001010001011)) color_data = 12'b010101101000;
		if(({row_reg, col_reg}==12'b001010001100)) color_data = 12'b001101010111;
		if(({row_reg, col_reg}==12'b001010001101)) color_data = 12'b100001100101;
		if(({row_reg, col_reg}==12'b001010001110)) color_data = 12'b111110101000;
		if(({row_reg, col_reg}==12'b001010001111)) color_data = 12'b101001010101;
		if(({row_reg, col_reg}==12'b001010010000)) color_data = 12'b101101100110;
		if(({row_reg, col_reg}==12'b001010010001)) color_data = 12'b001101010101;
		if(({row_reg, col_reg}==12'b001010010010)) color_data = 12'b000101000100;
		if(({row_reg, col_reg}==12'b001010010011)) color_data = 12'b010100100001;
		if(({row_reg, col_reg}==12'b001010010100)) color_data = 12'b010000100010;
		if(({row_reg, col_reg}==12'b001010010101)) color_data = 12'b101001010101;
		if(({row_reg, col_reg}==12'b001010010110)) color_data = 12'b101101100110;
		if(({row_reg, col_reg}>=12'b001010010111) && ({row_reg, col_reg}<12'b001010011001)) color_data = 12'b001001010101;
		if(({row_reg, col_reg}==12'b001010011001)) color_data = 12'b001001000100;
		if(({row_reg, col_reg}==12'b001010011010)) color_data = 12'b001000100011;
		if(({row_reg, col_reg}==12'b001010011011)) color_data = 12'b001000110100;
		if(({row_reg, col_reg}==12'b001010011100)) color_data = 12'b010101111000;

		if(({row_reg, col_reg}>=12'b001010011101) && ({row_reg, col_reg}<12'b001011001011)) color_data = 12'b010001101000;
		if(({row_reg, col_reg}==12'b001011001011)) color_data = 12'b010101101000;
		if(({row_reg, col_reg}==12'b001011001100)) color_data = 12'b001101010111;
		if(({row_reg, col_reg}==12'b001011001101)) color_data = 12'b100001100101;
		if(({row_reg, col_reg}==12'b001011001110)) color_data = 12'b111110101001;
		if(({row_reg, col_reg}==12'b001011001111)) color_data = 12'b101101100101;
		if(({row_reg, col_reg}==12'b001011010000)) color_data = 12'b101101100110;
		if(({row_reg, col_reg}==12'b001011010001)) color_data = 12'b001101010101;
		if(({row_reg, col_reg}==12'b001011010010)) color_data = 12'b001001000100;
		if(({row_reg, col_reg}==12'b001011010011)) color_data = 12'b010100100010;
		if(({row_reg, col_reg}==12'b001011010100)) color_data = 12'b010000100010;
		if(({row_reg, col_reg}==12'b001011010101)) color_data = 12'b101001100101;
		if(({row_reg, col_reg}==12'b001011010110)) color_data = 12'b101101100110;
		if(({row_reg, col_reg}==12'b001011010111)) color_data = 12'b001101010101;
		if(({row_reg, col_reg}==12'b001011011000)) color_data = 12'b001001010101;
		if(({row_reg, col_reg}==12'b001011011001)) color_data = 12'b001000110100;
		if(({row_reg, col_reg}==12'b001011011010)) color_data = 12'b000100100011;
		if(({row_reg, col_reg}==12'b001011011011)) color_data = 12'b001000110100;
		if(({row_reg, col_reg}==12'b001011011100)) color_data = 12'b010101111000;

		if(({row_reg, col_reg}>=12'b001011011101) && ({row_reg, col_reg}<12'b001100001011)) color_data = 12'b010001101000;
		if(({row_reg, col_reg}==12'b001100001011)) color_data = 12'b010101101000;
		if(({row_reg, col_reg}==12'b001100001100)) color_data = 12'b001101010111;
		if(({row_reg, col_reg}==12'b001100001101)) color_data = 12'b100001100101;
		if(({row_reg, col_reg}==12'b001100001110)) color_data = 12'b111111011010;
		if(({row_reg, col_reg}==12'b001100001111)) color_data = 12'b101101110110;
		if(({row_reg, col_reg}==12'b001100010000)) color_data = 12'b101001100101;
		if(({row_reg, col_reg}==12'b001100010001)) color_data = 12'b001101010101;
		if(({row_reg, col_reg}==12'b001100010010)) color_data = 12'b000101000100;
		if(({row_reg, col_reg}==12'b001100010011)) color_data = 12'b010100100001;
		if(({row_reg, col_reg}==12'b001100010100)) color_data = 12'b001100100010;
		if(({row_reg, col_reg}==12'b001100010101)) color_data = 12'b101001010101;
		if(({row_reg, col_reg}==12'b001100010110)) color_data = 12'b101101100110;
		if(({row_reg, col_reg}==12'b001100010111)) color_data = 12'b001001010101;
		if(({row_reg, col_reg}==12'b001100011000)) color_data = 12'b001001000100;
		if(({row_reg, col_reg}==12'b001100011001)) color_data = 12'b001000110100;
		if(({row_reg, col_reg}==12'b001100011010)) color_data = 12'b001000100011;
		if(({row_reg, col_reg}==12'b001100011011)) color_data = 12'b001000110100;
		if(({row_reg, col_reg}==12'b001100011100)) color_data = 12'b010101111001;

		if(({row_reg, col_reg}>=12'b001100011101) && ({row_reg, col_reg}<12'b001101001011)) color_data = 12'b010001101000;
		if(({row_reg, col_reg}==12'b001101001011)) color_data = 12'b010101101000;
		if(({row_reg, col_reg}==12'b001101001100)) color_data = 12'b001101010111;
		if(({row_reg, col_reg}==12'b001101001101)) color_data = 12'b011101100101;
		if(({row_reg, col_reg}==12'b001101001110)) color_data = 12'b110010000111;
		if(({row_reg, col_reg}>=12'b001101001111) && ({row_reg, col_reg}<12'b001101010001)) color_data = 12'b011000110010;
		if(({row_reg, col_reg}==12'b001101010001)) color_data = 12'b010000110010;
		if(({row_reg, col_reg}==12'b001101010010)) color_data = 12'b001100100010;
		if(({row_reg, col_reg}==12'b001101010011)) color_data = 12'b011100110010;
		if(({row_reg, col_reg}>=12'b001101010100) && ({row_reg, col_reg}<12'b001101010110)) color_data = 12'b010100100010;
		if(({row_reg, col_reg}==12'b001101010110)) color_data = 12'b010100110010;
		if(({row_reg, col_reg}>=12'b001101010111) && ({row_reg, col_reg}<12'b001101011010)) color_data = 12'b001100100010;
		if(({row_reg, col_reg}==12'b001101011010)) color_data = 12'b000100100010;
		if(({row_reg, col_reg}==12'b001101011011)) color_data = 12'b001001000101;
		if(({row_reg, col_reg}==12'b001101011100)) color_data = 12'b010101101000;

		if(({row_reg, col_reg}>=12'b001101011101) && ({row_reg, col_reg}<12'b001110001101)) color_data = 12'b010001101000;
		if(({row_reg, col_reg}==12'b001110001101)) color_data = 12'b010001010111;
		if(({row_reg, col_reg}==12'b001110001110)) color_data = 12'b011001000011;
		if(({row_reg, col_reg}>=12'b001110001111) && ({row_reg, col_reg}<12'b001110010011)) color_data = 12'b100001000001;
		if(({row_reg, col_reg}==12'b001110010011)) color_data = 12'b101001010010;
		if(({row_reg, col_reg}==12'b001110010100)) color_data = 12'b100000110010;
		if(({row_reg, col_reg}>=12'b001110010101) && ({row_reg, col_reg}<12'b001110011000)) color_data = 12'b011000100001;
		if(({row_reg, col_reg}==12'b001110011000)) color_data = 12'b011100110010;
		if(({row_reg, col_reg}==12'b001110011001)) color_data = 12'b011000100001;
		if(({row_reg, col_reg}==12'b001110011010)) color_data = 12'b001000110100;

		if(({row_reg, col_reg}>=12'b001110011011) && ({row_reg, col_reg}<12'b001111001101)) color_data = 12'b010001101000;
		if(({row_reg, col_reg}==12'b001111001101)) color_data = 12'b010010011010;
		if(({row_reg, col_reg}==12'b001111001110)) color_data = 12'b001101100110;
		if(({row_reg, col_reg}==12'b001111001111)) color_data = 12'b011001010010;
		if(({row_reg, col_reg}==12'b001111010000)) color_data = 12'b001000010010;
		if(({row_reg, col_reg}==12'b001111010001)) color_data = 12'b011000110010;
		if(({row_reg, col_reg}==12'b001111010010)) color_data = 12'b011000110001;
		if(({row_reg, col_reg}==12'b001111010011)) color_data = 12'b010100100001;
		if(({row_reg, col_reg}==12'b001111010100)) color_data = 12'b010000100010;
		if(({row_reg, col_reg}==12'b001111010101)) color_data = 12'b011000110001;
		if(({row_reg, col_reg}==12'b001111010110)) color_data = 12'b100001000010;
		if(({row_reg, col_reg}==12'b001111010111)) color_data = 12'b011000110010;
		if(({row_reg, col_reg}==12'b001111011000)) color_data = 12'b001100100001;
		if(({row_reg, col_reg}==12'b001111011001)) color_data = 12'b001001100111;
		if(({row_reg, col_reg}==12'b001111011010)) color_data = 12'b010101111001;

		if(({row_reg, col_reg}>=12'b001111011011) && ({row_reg, col_reg}<12'b010000001100)) color_data = 12'b010001101000;
		if(({row_reg, col_reg}==12'b010000001100)) color_data = 12'b001101000101;
		if(({row_reg, col_reg}==12'b010000001101)) color_data = 12'b010001000100;
		if(({row_reg, col_reg}==12'b010000001110)) color_data = 12'b010000110010;
		if(({row_reg, col_reg}==12'b010000001111)) color_data = 12'b100110000101;
		if(({row_reg, col_reg}==12'b010000010000)) color_data = 12'b001100100011;
		if(({row_reg, col_reg}==12'b010000010001)) color_data = 12'b011101000011;
		if(({row_reg, col_reg}==12'b010000010010)) color_data = 12'b100101000010;
		if(({row_reg, col_reg}==12'b010000010011)) color_data = 12'b010100100010;
		if(({row_reg, col_reg}==12'b010000010100)) color_data = 12'b010000100010;
		if(({row_reg, col_reg}==12'b010000010101)) color_data = 12'b100001000010;
		if(({row_reg, col_reg}==12'b010000010110)) color_data = 12'b101001000011;
		if(({row_reg, col_reg}==12'b010000010111)) color_data = 12'b100001000011;
		if(({row_reg, col_reg}==12'b010000011000)) color_data = 12'b010000100001;
		if(({row_reg, col_reg}==12'b010000011001)) color_data = 12'b000100110011;
		if(({row_reg, col_reg}==12'b010000011010)) color_data = 12'b001101000100;
		if(({row_reg, col_reg}==12'b010000011011)) color_data = 12'b010001010111;

		if(({row_reg, col_reg}>=12'b010000011100) && ({row_reg, col_reg}<12'b010001001011)) color_data = 12'b010001101000;
		if(({row_reg, col_reg}==12'b010001001011)) color_data = 12'b010001010110;
		if(({row_reg, col_reg}==12'b010001001100)) color_data = 12'b010001000100;
		if(({row_reg, col_reg}==12'b010001001101)) color_data = 12'b100100110001;
		if(({row_reg, col_reg}==12'b010001001110)) color_data = 12'b011101000010;
		if(({row_reg, col_reg}==12'b010001001111)) color_data = 12'b100001110101;
		if(({row_reg, col_reg}==12'b010001010000)) color_data = 12'b001100100011;
		if(({row_reg, col_reg}==12'b010001010001)) color_data = 12'b011100110011;
		if(({row_reg, col_reg}==12'b010001010010)) color_data = 12'b011100110010;
		if(({row_reg, col_reg}==12'b010001010011)) color_data = 12'b010100100010;
		if(({row_reg, col_reg}==12'b010001010100)) color_data = 12'b001100100010;
		if(({row_reg, col_reg}==12'b010001010101)) color_data = 12'b010100110010;
		if(({row_reg, col_reg}==12'b010001010110)) color_data = 12'b011100110011;
		if(({row_reg, col_reg}==12'b010001010111)) color_data = 12'b010100110011;
		if(({row_reg, col_reg}==12'b010001011000)) color_data = 12'b010000100001;
		if(({row_reg, col_reg}==12'b010001011001)) color_data = 12'b001000000001;
		if(({row_reg, col_reg}==12'b010001011010)) color_data = 12'b001000010001;
		if(({row_reg, col_reg}==12'b010001011011)) color_data = 12'b001101000100;
		if(({row_reg, col_reg}==12'b010001011100)) color_data = 12'b010101101000;

		if(({row_reg, col_reg}>=12'b010001011101) && ({row_reg, col_reg}<12'b010010001011)) color_data = 12'b010001101000;
		if(({row_reg, col_reg}==12'b010010001011)) color_data = 12'b001101000101;
		if(({row_reg, col_reg}==12'b010010001100)) color_data = 12'b011001010101;
		if(({row_reg, col_reg}==12'b010010001101)) color_data = 12'b101001000010;
		if(({row_reg, col_reg}==12'b010010001110)) color_data = 12'b011101000010;
		if(({row_reg, col_reg}==12'b010010001111)) color_data = 12'b100001100011;
		if(({row_reg, col_reg}==12'b010010010000)) color_data = 12'b010000100100;
		if(({row_reg, col_reg}==12'b010010010001)) color_data = 12'b100001000011;
		if(({row_reg, col_reg}==12'b010010010010)) color_data = 12'b100101000011;
		if(({row_reg, col_reg}>=12'b010010010011) && ({row_reg, col_reg}<12'b010010010110)) color_data = 12'b011000110011;
		if(({row_reg, col_reg}>=12'b010010010110) && ({row_reg, col_reg}<12'b010010011000)) color_data = 12'b010100110011;
		if(({row_reg, col_reg}==12'b010010011000)) color_data = 12'b010100100001;
		if(({row_reg, col_reg}==12'b010010011001)) color_data = 12'b001100010010;
		if(({row_reg, col_reg}==12'b010010011010)) color_data = 12'b001100100010;
		if(({row_reg, col_reg}==12'b010010011011)) color_data = 12'b001101000100;
		if(({row_reg, col_reg}==12'b010010011100)) color_data = 12'b010101101000;

		if(({row_reg, col_reg}>=12'b010010011101) && ({row_reg, col_reg}<12'b010011001011)) color_data = 12'b010001101000;
		if(({row_reg, col_reg}==12'b010011001011)) color_data = 12'b001101010110;
		if(({row_reg, col_reg}==12'b010011001100)) color_data = 12'b001100110011;
		if(({row_reg, col_reg}==12'b010011001101)) color_data = 12'b010100100001;
		if(({row_reg, col_reg}==12'b010011001110)) color_data = 12'b010000100001;
		if(({row_reg, col_reg}==12'b010011001111)) color_data = 12'b100001100011;
		if(({row_reg, col_reg}==12'b010011010000)) color_data = 12'b001100100011;
		if(({row_reg, col_reg}==12'b010011010001)) color_data = 12'b010100110011;
		if(({row_reg, col_reg}==12'b010011010010)) color_data = 12'b011101000011;
		if(({row_reg, col_reg}>=12'b010011010011) && ({row_reg, col_reg}<12'b010011010101)) color_data = 12'b100101000011;
		if(({row_reg, col_reg}==12'b010011010101)) color_data = 12'b101001000011;
		if(({row_reg, col_reg}==12'b010011010110)) color_data = 12'b011000110011;
		if(({row_reg, col_reg}==12'b010011010111)) color_data = 12'b010100110011;
		if(({row_reg, col_reg}==12'b010011011000)) color_data = 12'b010100100001;
		if(({row_reg, col_reg}==12'b010011011001)) color_data = 12'b001100010001;
		if(({row_reg, col_reg}==12'b010011011010)) color_data = 12'b001000010001;
		if(({row_reg, col_reg}==12'b010011011011)) color_data = 12'b001000100011;
		if(({row_reg, col_reg}==12'b010011011100)) color_data = 12'b010001100111;

		if(({row_reg, col_reg}>=12'b010011011101) && ({row_reg, col_reg}<12'b010100001100)) color_data = 12'b010001101000;
		if(({row_reg, col_reg}==12'b010100001100)) color_data = 12'b001101000110;
		if(({row_reg, col_reg}==12'b010100001101)) color_data = 12'b001001101000;
		if(({row_reg, col_reg}==12'b010100001110)) color_data = 12'b010001000011;
		if(({row_reg, col_reg}==12'b010100001111)) color_data = 12'b011101000010;
		if(({row_reg, col_reg}==12'b010100010000)) color_data = 12'b001100100011;
		if(({row_reg, col_reg}==12'b010100010001)) color_data = 12'b011000110011;
		if(({row_reg, col_reg}==12'b010100010010)) color_data = 12'b011101000011;
		if(({row_reg, col_reg}==12'b010100010011)) color_data = 12'b011000110011;
		if(({row_reg, col_reg}==12'b010100010100)) color_data = 12'b010100100011;
		if(({row_reg, col_reg}>=12'b010100010101) && ({row_reg, col_reg}<12'b010100010111)) color_data = 12'b100101000010;
		if(({row_reg, col_reg}==12'b010100010111)) color_data = 12'b010000100011;
		if(({row_reg, col_reg}==12'b010100011000)) color_data = 12'b010100100001;
		if(({row_reg, col_reg}==12'b010100011001)) color_data = 12'b001001010110;
		if(({row_reg, col_reg}==12'b010100011010)) color_data = 12'b001101100111;
		if(({row_reg, col_reg}==12'b010100011011)) color_data = 12'b010001010110;

		if(({row_reg, col_reg}>=12'b010100011100) && ({row_reg, col_reg}<12'b010101001100)) color_data = 12'b010001101000;
		if(({row_reg, col_reg}==12'b010101001100)) color_data = 12'b010101111001;
		if(({row_reg, col_reg}==12'b010101001101)) color_data = 12'b001110011010;
		if(({row_reg, col_reg}==12'b010101001110)) color_data = 12'b011101110100;
		if(({row_reg, col_reg}==12'b010101001111)) color_data = 12'b010000110010;
		if(({row_reg, col_reg}==12'b010101010000)) color_data = 12'b001100100011;
		if(({row_reg, col_reg}>=12'b010101010001) && ({row_reg, col_reg}<12'b010101010011)) color_data = 12'b011000110011;
		if(({row_reg, col_reg}==12'b010101010011)) color_data = 12'b010000110011;
		if(({row_reg, col_reg}==12'b010101010100)) color_data = 12'b011001010011;
		if(({row_reg, col_reg}==12'b010101010101)) color_data = 12'b010101000011;
		if(({row_reg, col_reg}==12'b010101010110)) color_data = 12'b011101010011;
		if(({row_reg, col_reg}==12'b010101010111)) color_data = 12'b011001010011;
		if(({row_reg, col_reg}==12'b010101011000)) color_data = 12'b011101000010;
		if(({row_reg, col_reg}==12'b010101011001)) color_data = 12'b001101010110;
		if(({row_reg, col_reg}==12'b010101011010)) color_data = 12'b010110101100;

		if(({row_reg, col_reg}>=12'b010101011011) && ({row_reg, col_reg}<12'b010110001100)) color_data = 12'b010001101000;
		if(({row_reg, col_reg}==12'b010110001100)) color_data = 12'b010110001010;
		if(({row_reg, col_reg}==12'b010110001101)) color_data = 12'b001110001010;
		if(({row_reg, col_reg}==12'b010110001110)) color_data = 12'b011101110100;
		if(({row_reg, col_reg}==12'b010110001111)) color_data = 12'b010100110011;
		if(({row_reg, col_reg}==12'b010110010000)) color_data = 12'b001100100011;
		if(({row_reg, col_reg}==12'b010110010001)) color_data = 12'b011100110011;
		if(({row_reg, col_reg}==12'b010110010010)) color_data = 12'b011000110011;
		if(({row_reg, col_reg}==12'b010110010011)) color_data = 12'b011001010010;
		if(({row_reg, col_reg}==12'b010110010100)) color_data = 12'b110010100100;
		if(({row_reg, col_reg}==12'b010110010101)) color_data = 12'b100001110011;
		if(({row_reg, col_reg}==12'b010110010110)) color_data = 12'b100110000011;
		if(({row_reg, col_reg}==12'b010110010111)) color_data = 12'b101110100100;
		if(({row_reg, col_reg}==12'b010110011000)) color_data = 12'b101101110010;
		if(({row_reg, col_reg}==12'b010110011001)) color_data = 12'b001101010101;
		if(({row_reg, col_reg}==12'b010110011010)) color_data = 12'b010110101100;

		if(({row_reg, col_reg}>=12'b010110011011) && ({row_reg, col_reg}<12'b010111001100)) color_data = 12'b010001101000;
		if(({row_reg, col_reg}==12'b010111001100)) color_data = 12'b010110001010;
		if(({row_reg, col_reg}==12'b010111001101)) color_data = 12'b001110011010;
		if(({row_reg, col_reg}==12'b010111001110)) color_data = 12'b011101110100;
		if(({row_reg, col_reg}==12'b010111001111)) color_data = 12'b010000110011;
		if(({row_reg, col_reg}==12'b010111010000)) color_data = 12'b010000100011;
		if(({row_reg, col_reg}==12'b010111010001)) color_data = 12'b010100110011;
		if(({row_reg, col_reg}==12'b010111010010)) color_data = 12'b100101000011;
		if(({row_reg, col_reg}==12'b010111010011)) color_data = 12'b011100110010;
		if(({row_reg, col_reg}==12'b010111010100)) color_data = 12'b001100110010;
		if(({row_reg, col_reg}==12'b010111010101)) color_data = 12'b011101100100;
		if(({row_reg, col_reg}==12'b010111010110)) color_data = 12'b011000110010;
		if(({row_reg, col_reg}==12'b010111010111)) color_data = 12'b000000000001;
		if(({row_reg, col_reg}==12'b010111011000)) color_data = 12'b011100110010;
		if(({row_reg, col_reg}==12'b010111011001)) color_data = 12'b001101010101;
		if(({row_reg, col_reg}==12'b010111011010)) color_data = 12'b010110101100;

		if(({row_reg, col_reg}>=12'b010111011011) && ({row_reg, col_reg}<12'b011000001100)) color_data = 12'b010001101000;
		if(({row_reg, col_reg}==12'b011000001100)) color_data = 12'b010101111001;
		if(({row_reg, col_reg}==12'b011000001101)) color_data = 12'b001110001010;
		if(({row_reg, col_reg}==12'b011000001110)) color_data = 12'b011101110100;
		if(({row_reg, col_reg}==12'b011000001111)) color_data = 12'b011001000100;
		if(({row_reg, col_reg}==12'b011000010000)) color_data = 12'b010000100011;
		if(({row_reg, col_reg}==12'b011000010001)) color_data = 12'b011100110011;
		if(({row_reg, col_reg}>=12'b011000010010) && ({row_reg, col_reg}<12'b011000010100)) color_data = 12'b100101000011;
		if(({row_reg, col_reg}==12'b011000010100)) color_data = 12'b010100100010;
		if(({row_reg, col_reg}==12'b011000010101)) color_data = 12'b010000010001;
		if(({row_reg, col_reg}==12'b011000010110)) color_data = 12'b010000100001;
		if(({row_reg, col_reg}==12'b011000010111)) color_data = 12'b010100110011;
		if(({row_reg, col_reg}==12'b011000011000)) color_data = 12'b011100110010;
		if(({row_reg, col_reg}==12'b011000011001)) color_data = 12'b001101100110;
		if(({row_reg, col_reg}==12'b011000011010)) color_data = 12'b010010011011;
		if(({row_reg, col_reg}==12'b011000011011)) color_data = 12'b010001100111;

		if(({row_reg, col_reg}>=12'b011000011100) && ({row_reg, col_reg}<12'b011001001010)) color_data = 12'b010001101000;
		if(({row_reg, col_reg}==12'b011001001010)) color_data = 12'b010010011010;
		if(({row_reg, col_reg}==12'b011001001011)) color_data = 12'b010001101000;
		if(({row_reg, col_reg}==12'b011001001100)) color_data = 12'b010101101000;
		if(({row_reg, col_reg}==12'b011001001101)) color_data = 12'b001110001010;
		if(({row_reg, col_reg}==12'b011001001110)) color_data = 12'b011101110100;
		if(({row_reg, col_reg}==12'b011001001111)) color_data = 12'b010101000100;
		if(({row_reg, col_reg}==12'b011001010000)) color_data = 12'b010000100011;
		if(({row_reg, col_reg}>=12'b011001010001) && ({row_reg, col_reg}<12'b011001010100)) color_data = 12'b100101000011;
		if(({row_reg, col_reg}==12'b011001010100)) color_data = 12'b101001000011;
		if(({row_reg, col_reg}==12'b011001010101)) color_data = 12'b100101000010;
		if(({row_reg, col_reg}==12'b011001010110)) color_data = 12'b101001000010;
		if(({row_reg, col_reg}==12'b011001010111)) color_data = 12'b100001000011;
		if(({row_reg, col_reg}==12'b011001011000)) color_data = 12'b011100110001;
		if(({row_reg, col_reg}==12'b011001011001)) color_data = 12'b001101100110;
		if(({row_reg, col_reg}==12'b011001011010)) color_data = 12'b010010001010;
		if(({row_reg, col_reg}==12'b011001011011)) color_data = 12'b010001100111;

		if(({row_reg, col_reg}>=12'b011001011100) && ({row_reg, col_reg}<12'b011010001010)) color_data = 12'b010001101000;
		if(({row_reg, col_reg}==12'b011010001010)) color_data = 12'b010010001001;
		if(({row_reg, col_reg}==12'b011010001011)) color_data = 12'b010001101000;
		if(({row_reg, col_reg}==12'b011010001100)) color_data = 12'b010101111001;
		if(({row_reg, col_reg}==12'b011010001101)) color_data = 12'b001110001010;
		if(({row_reg, col_reg}==12'b011010001110)) color_data = 12'b011101010011;
		if(({row_reg, col_reg}==12'b011010001111)) color_data = 12'b101010010101;
		if(({row_reg, col_reg}==12'b011010010000)) color_data = 12'b001100100011;
		if(({row_reg, col_reg}==12'b011010010001)) color_data = 12'b011000110011;
		if(({row_reg, col_reg}>=12'b011010010010) && ({row_reg, col_reg}<12'b011010010110)) color_data = 12'b100101000011;
		if(({row_reg, col_reg}==12'b011010010110)) color_data = 12'b100001000011;
		if(({row_reg, col_reg}==12'b011010010111)) color_data = 12'b011001000011;
		if(({row_reg, col_reg}==12'b011010011000)) color_data = 12'b100001000001;
		if(({row_reg, col_reg}==12'b011010011001)) color_data = 12'b001001010110;
		if(({row_reg, col_reg}==12'b011010011010)) color_data = 12'b010110011010;
		if(({row_reg, col_reg}==12'b011010011011)) color_data = 12'b010001100111;

		if(({row_reg, col_reg}>=12'b011010011100) && ({row_reg, col_reg}<12'b011011001100)) color_data = 12'b010001101000;
		if(({row_reg, col_reg}==12'b011011001100)) color_data = 12'b010110001010;
		if(({row_reg, col_reg}==12'b011011001101)) color_data = 12'b001110011011;
		if(({row_reg, col_reg}==12'b011011001110)) color_data = 12'b010100110001;
		if(({row_reg, col_reg}==12'b011011001111)) color_data = 12'b110110000100;
		if(({row_reg, col_reg}==12'b011011010000)) color_data = 12'b110010100101;
		if(({row_reg, col_reg}==12'b011011010001)) color_data = 12'b100001100101;
		if(({row_reg, col_reg}==12'b011011010010)) color_data = 12'b100101100011;
		if(({row_reg, col_reg}==12'b011011010011)) color_data = 12'b110001110011;
		if(({row_reg, col_reg}>=12'b011011010100) && ({row_reg, col_reg}<12'b011011010110)) color_data = 12'b100101100011;
		if(({row_reg, col_reg}==12'b011011010110)) color_data = 12'b100101010011;
		if(({row_reg, col_reg}==12'b011011010111)) color_data = 12'b101001010011;
		if(({row_reg, col_reg}==12'b011011011000)) color_data = 12'b010000100010;
		if(({row_reg, col_reg}==12'b011011011001)) color_data = 12'b001001010110;
		if(({row_reg, col_reg}==12'b011011011010)) color_data = 12'b010110011010;
		if(({row_reg, col_reg}==12'b011011011011)) color_data = 12'b010001010111;
		if(({row_reg, col_reg}==12'b011011011100)) color_data = 12'b010001101000;
		if(({row_reg, col_reg}==12'b011011011101)) color_data = 12'b010010001001;

		if(({row_reg, col_reg}>=12'b011011011110) && ({row_reg, col_reg}<12'b011100001100)) color_data = 12'b010001101000;
		if(({row_reg, col_reg}==12'b011100001100)) color_data = 12'b010101111001;
		if(({row_reg, col_reg}==12'b011100001101)) color_data = 12'b001110011010;
		if(({row_reg, col_reg}==12'b011100001110)) color_data = 12'b010100110001;
		if(({row_reg, col_reg}==12'b011100001111)) color_data = 12'b101101010010;
		if(({row_reg, col_reg}==12'b011100010000)) color_data = 12'b101101100011;
		if(({row_reg, col_reg}==12'b011100010001)) color_data = 12'b110110100100;
		if(({row_reg, col_reg}==12'b011100010010)) color_data = 12'b110001110011;
		if(({row_reg, col_reg}>=12'b011100010011) && ({row_reg, col_reg}<12'b011100010110)) color_data = 12'b101101110011;
		if(({row_reg, col_reg}==12'b011100010110)) color_data = 12'b100101010011;
		if(({row_reg, col_reg}==12'b011100010111)) color_data = 12'b010100110011;
		if(({row_reg, col_reg}==12'b011100011000)) color_data = 12'b001100010010;
		if(({row_reg, col_reg}==12'b011100011001)) color_data = 12'b001001010101;
		if(({row_reg, col_reg}==12'b011100011010)) color_data = 12'b010110011010;
		if(({row_reg, col_reg}==12'b011100011011)) color_data = 12'b010001100111;
		if(({row_reg, col_reg}==12'b011100011100)) color_data = 12'b010001101000;
		if(({row_reg, col_reg}==12'b011100011101)) color_data = 12'b010001111001;

		if(({row_reg, col_reg}>=12'b011100011110) && ({row_reg, col_reg}<12'b011101001101)) color_data = 12'b010001101000;
		if(({row_reg, col_reg}==12'b011101001101)) color_data = 12'b010010011011;
		if(({row_reg, col_reg}==12'b011101001110)) color_data = 12'b010101000010;
		if(({row_reg, col_reg}==12'b011101001111)) color_data = 12'b110001100010;
		if(({row_reg, col_reg}==12'b011101010000)) color_data = 12'b100101000011;
		if(({row_reg, col_reg}>=12'b011101010001) && ({row_reg, col_reg}<12'b011101010011)) color_data = 12'b100101000010;
		if(({row_reg, col_reg}==12'b011101010011)) color_data = 12'b100001000011;
		if(({row_reg, col_reg}>=12'b011101010100) && ({row_reg, col_reg}<12'b011101010110)) color_data = 12'b011000110011;
		if(({row_reg, col_reg}==12'b011101010110)) color_data = 12'b010100100011;
		if(({row_reg, col_reg}==12'b011101010111)) color_data = 12'b010000110100;
		if(({row_reg, col_reg}==12'b011101011000)) color_data = 12'b001100010010;
		if(({row_reg, col_reg}==12'b011101011001)) color_data = 12'b001101100111;
		if(({row_reg, col_reg}==12'b011101011010)) color_data = 12'b010110011011;

		if(({row_reg, col_reg}>=12'b011101011011) && ({row_reg, col_reg}<12'b011110001100)) color_data = 12'b010001101000;
		if(({row_reg, col_reg}==12'b011110001100)) color_data = 12'b010001100111;
		if(({row_reg, col_reg}==12'b011110001101)) color_data = 12'b010110011011;
		if(({row_reg, col_reg}==12'b011110001110)) color_data = 12'b001101100111;
		if(({row_reg, col_reg}==12'b011110001111)) color_data = 12'b101001010001;
		if(({row_reg, col_reg}==12'b011110010000)) color_data = 12'b101101010011;
		if(({row_reg, col_reg}>=12'b011110010001) && ({row_reg, col_reg}<12'b011110010011)) color_data = 12'b100001000011;
		if(({row_reg, col_reg}==12'b011110010011)) color_data = 12'b100101000011;
		if(({row_reg, col_reg}==12'b011110010100)) color_data = 12'b011100110011;
		if(({row_reg, col_reg}==12'b011110010101)) color_data = 12'b011000110011;
		if(({row_reg, col_reg}==12'b011110010110)) color_data = 12'b010000110011;
		if(({row_reg, col_reg}==12'b011110010111)) color_data = 12'b010100100011;
		if(({row_reg, col_reg}==12'b011110011000)) color_data = 12'b001000100010;
		if(({row_reg, col_reg}==12'b011110011001)) color_data = 12'b010010011011;
		if(({row_reg, col_reg}==12'b011110011010)) color_data = 12'b010110101011;

		if(({row_reg, col_reg}>=12'b011110011011) && ({row_reg, col_reg}<12'b011111001100)) color_data = 12'b010001101000;
		if(({row_reg, col_reg}==12'b011111001100)) color_data = 12'b010001111000;
		if(({row_reg, col_reg}==12'b011111001101)) color_data = 12'b010010101011;
		if(({row_reg, col_reg}==12'b011111001110)) color_data = 12'b010010001010;
		if(({row_reg, col_reg}==12'b011111001111)) color_data = 12'b010000110100;
		if(({row_reg, col_reg}==12'b011111010000)) color_data = 12'b100000110001;
		if(({row_reg, col_reg}==12'b011111010001)) color_data = 12'b101001000010;
		if(({row_reg, col_reg}==12'b011111010010)) color_data = 12'b101001000011;
		if(({row_reg, col_reg}==12'b011111010011)) color_data = 12'b100101000011;
		if(({row_reg, col_reg}==12'b011111010100)) color_data = 12'b011100110011;
		if(({row_reg, col_reg}==12'b011111010101)) color_data = 12'b011100110010;
		if(({row_reg, col_reg}==12'b011111010110)) color_data = 12'b010100100010;
		if(({row_reg, col_reg}==12'b011111010111)) color_data = 12'b001000100010;
		if(({row_reg, col_reg}==12'b011111011000)) color_data = 12'b010001010111;
		if(({row_reg, col_reg}==12'b011111011001)) color_data = 12'b010110101011;
		if(({row_reg, col_reg}==12'b011111011010)) color_data = 12'b010010101011;

		if(({row_reg, col_reg}>=12'b011111011011) && ({row_reg, col_reg}<12'b100000001100)) color_data = 12'b010001101000;
		if(({row_reg, col_reg}==12'b100000001100)) color_data = 12'b010001111001;
		if(({row_reg, col_reg}==12'b100000001101)) color_data = 12'b010010101100;
		if(({row_reg, col_reg}==12'b100000001110)) color_data = 12'b010010001001;
		if(({row_reg, col_reg}==12'b100000001111)) color_data = 12'b010001101000;
		if(({row_reg, col_reg}==12'b100000010000)) color_data = 12'b001101000110;
		if(({row_reg, col_reg}==12'b100000010001)) color_data = 12'b001100110011;
		if(({row_reg, col_reg}==12'b100000010010)) color_data = 12'b011000110010;
		if(({row_reg, col_reg}==12'b100000010011)) color_data = 12'b011100110001;
		if(({row_reg, col_reg}==12'b100000010100)) color_data = 12'b010100100010;
		if(({row_reg, col_reg}==12'b100000010101)) color_data = 12'b001100100010;
		if(({row_reg, col_reg}==12'b100000010110)) color_data = 12'b001100110100;
		if(({row_reg, col_reg}==12'b100000010111)) color_data = 12'b010001010111;
		if(({row_reg, col_reg}==12'b100000011000)) color_data = 12'b010001111001;
		if(({row_reg, col_reg}==12'b100000011001)) color_data = 12'b010010101011;
		if(({row_reg, col_reg}==12'b100000011010)) color_data = 12'b010010001010;

		if(({row_reg, col_reg}>=12'b100000011011) && ({row_reg, col_reg}<12'b100001001101)) color_data = 12'b010001101000;
		if(({row_reg, col_reg}==12'b100001001101)) color_data = 12'b010010101011;
		if(({row_reg, col_reg}==12'b100001001110)) color_data = 12'b010010001001;
		if(({row_reg, col_reg}>=12'b100001001111) && ({row_reg, col_reg}<12'b100001010010)) color_data = 12'b010001101000;
		if(({row_reg, col_reg}==12'b100001010010)) color_data = 12'b001101010111;
		if(({row_reg, col_reg}==12'b100001010011)) color_data = 12'b001101000101;
		if(({row_reg, col_reg}==12'b100001010100)) color_data = 12'b001101000110;
		if(({row_reg, col_reg}>=12'b100001010101) && ({row_reg, col_reg}<12'b100001011000)) color_data = 12'b010001101000;
		if(({row_reg, col_reg}==12'b100001011000)) color_data = 12'b010010001001;
		if(({row_reg, col_reg}==12'b100001011001)) color_data = 12'b010010101100;
		if(({row_reg, col_reg}==12'b100001011010)) color_data = 12'b010010001001;

		if(({row_reg, col_reg}>=12'b100001011011) && ({row_reg, col_reg}<12'b100010001101)) color_data = 12'b010001101000;
		if(({row_reg, col_reg}==12'b100010001101)) color_data = 12'b010010001010;
		if(({row_reg, col_reg}==12'b100010001110)) color_data = 12'b010010011011;
		if(({row_reg, col_reg}>=12'b100010001111) && ({row_reg, col_reg}<12'b100010010011)) color_data = 12'b010001101000;
		if(({row_reg, col_reg}>=12'b100010010011) && ({row_reg, col_reg}<12'b100010010101)) color_data = 12'b010101101000;
		if(({row_reg, col_reg}>=12'b100010010101) && ({row_reg, col_reg}<12'b100010011000)) color_data = 12'b010001101000;
		if(({row_reg, col_reg}==12'b100010011000)) color_data = 12'b010001111000;
		if(({row_reg, col_reg}==12'b100010011001)) color_data = 12'b010010101011;
		if(({row_reg, col_reg}==12'b100010011010)) color_data = 12'b010001111000;

		if(({row_reg, col_reg}>=12'b100010011011) && ({row_reg, col_reg}<12'b100011001101)) color_data = 12'b010001101000;
		if(({row_reg, col_reg}>=12'b100011001101) && ({row_reg, col_reg}<12'b100011001111)) color_data = 12'b010010011011;
		if(({row_reg, col_reg}>=12'b100011001111) && ({row_reg, col_reg}<12'b100011011001)) color_data = 12'b010001101000;
		if(({row_reg, col_reg}==12'b100011011001)) color_data = 12'b010010011011;
		if(({row_reg, col_reg}==12'b100011011010)) color_data = 12'b010001111001;

		if(({row_reg, col_reg}>=12'b100011011011) && ({row_reg, col_reg}<12'b100100001101)) color_data = 12'b010001101000;
		if(({row_reg, col_reg}==12'b100100001101)) color_data = 12'b010010101011;
		if(({row_reg, col_reg}==12'b100100001110)) color_data = 12'b010001111000;
		if(({row_reg, col_reg}>=12'b100100001111) && ({row_reg, col_reg}<12'b100100011001)) color_data = 12'b010001101000;
		if(({row_reg, col_reg}>=12'b100100011001) && ({row_reg, col_reg}<12'b100100011011)) color_data = 12'b010010001010;
		if(({row_reg, col_reg}==12'b100100011011)) color_data = 12'b010001100111;

		if(({row_reg, col_reg}>=12'b100100011100) && ({row_reg, col_reg}<12'b100101001101)) color_data = 12'b010001101000;
		if(({row_reg, col_reg}==12'b100101001101)) color_data = 12'b010010011011;
		if(({row_reg, col_reg}>=12'b100101001110) && ({row_reg, col_reg}<12'b100101011001)) color_data = 12'b010001101000;
		if(({row_reg, col_reg}==12'b100101011001)) color_data = 12'b010010001001;
		if(({row_reg, col_reg}==12'b100101011010)) color_data = 12'b010010011010;

		if(({row_reg, col_reg}>=12'b100101011011) && ({row_reg, col_reg}<12'b100110001101)) color_data = 12'b010001101000;
		if(({row_reg, col_reg}==12'b100110001101)) color_data = 12'b010010011010;
		if(({row_reg, col_reg}>=12'b100110001110) && ({row_reg, col_reg}<12'b100110011010)) color_data = 12'b010001101000;
		if(({row_reg, col_reg}==12'b100110011010)) color_data = 12'b010010011011;

		if(({row_reg, col_reg}>=12'b100110011011) && ({row_reg, col_reg}<12'b100111001101)) color_data = 12'b010001101000;
		if(({row_reg, col_reg}==12'b100111001101)) color_data = 12'b010001111001;
		if(({row_reg, col_reg}>=12'b100111001110) && ({row_reg, col_reg}<12'b100111011010)) color_data = 12'b010001101000;
		if(({row_reg, col_reg}==12'b100111011010)) color_data = 12'b010010001010;

		if(({row_reg, col_reg}>=12'b100111011011) && ({row_reg, col_reg}<=12'b100111100111)) color_data = 12'b010001101000;
	end
endmodule