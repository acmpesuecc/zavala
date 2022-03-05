// 
//	This file contains the main sv code for the zavala miner
//
//	Licensed under the MIT license which states as follows
//
//	MIT License
//
//	Copyright (c) 2022 ACM Student Chapter, PESU ECC
//
//	Permission is hereby granted, free of charge, to any person obtaining a copy
//	of this software and associated documentation files (the "Software"), to deal
//	in the Software without restriction, including without limitation the rights
//	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//	copies of the Software, and to permit persons to whom the Software is
//	furnished to do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in all
//	copies or substantial portions of the Software.
//

`timescale 1 ns / 1 ps

module zavala (
	input logic	clk,
	input logic rst,
	input logic read,
	input logic write,
	input logic [4:0] op_address,
	output logic [31:0] readdata
);

	parameter miner_freq = 10000000; //frequency in hertz

endmodule
