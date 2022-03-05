//
//	This file contains the padding module of the SHA-3 implementation
//

module padding (
	input logic [31:0] in_data,
	input logic [4:0] op_address,
	input logic clk,
	input logic rst,
	output logic [31:0] out_data
};

endmodule
