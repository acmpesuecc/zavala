//
// This file contains the permutation module of the SHA-3 implementation
//

//
// This file contains the permutation module of the SHA-3 implementation
//

module permutation (
	input logic [1599:0] in,
	input logic [6:0] round_const,
	output logic [1599:0] out
);

    `define low_bit(x,y)  `high_bit(x,y) - 63
    `define high_bit(x,y) 1599 - 64*(5*y+x)

    `define add_1(x)      (x == 4 ? 0 : x + 1)
    `define add_2(x)      (x == 3 ? 0 : x == 4 ? 1 : x + 2)
    `define sub_1(x)      (x == 0 ? 4 : x - 1)

    `define rot_left(x, n) {x[63-n:0], x[63:63-n+1]}
    
    genvar x, y;
    
    logic [63:0] a[4:0][4:0];
    
    generate
        for(y = 0; y < 5; y = y + 1) begin : L0
           for(x = 0; x < 5; x = x + 1) begin : L1
          assign a[x][y] = in[`high_bit(x, y) : `low_bit(x, y)];
            end
        end
    endgenerate
    
    logic [63:0] b[4:0];
    
    generate    
        for(x = 0; x < 5; x = x + 1) begin : L2
           assign b[x] = a[x][0] ^ a[x][1] ^ a[x][2] ^ a[x][3] ^ a[x][4];
        end
    endgenerate
    
    logic [63:0] c[4:0][4:0];
    
    // theta function
    generate    
        for(y = 0; y < 5; y = y + 1) begin : L3
           for(x = 0; x < 5; x = x + 1) begin : L4
              assign c[x][y] = a[x][y] ^ b[`sub_1(x)] ^ `rot_left(b[`add_1(x)], 1);
           end
        end
    endgenerate
    
    logic [63:0] d[4:0][4:0];
	
   // rho function
   assign d[0][0] = c[0][0];
   assign d[1][0] = `rot_left(c[1][0],  1);
   assign d[2][0] = `rot_left(c[2][0], 62);
   assign d[3][0] = `rot_left(c[3][0], 28);
   assign d[4][0] = `rot_left(c[4][0], 27);
   assign d[0][1] = `rot_left(c[0][1], 36);
   assign d[1][1] = `rot_left(c[1][1], 44);
   assign d[2][1] = `rot_left(c[2][1], 6);
   assign d[3][1] = `rot_left(c[3][1], 55);
   assign d[4][1] = `rot_left(c[4][1], 20);
   assign d[0][2] = `rot_left(c[0][2], 3);
   assign d[1][2] = `rot_left(c[1][2], 10);
   assign d[2][2] = `rot_left(c[2][2], 43);
   assign d[3][2] = `rot_left(c[3][2], 25);
   assign d[4][2] = `rot_left(c[4][2], 39);
   assign d[0][3] = `rot_left(c[0][3], 41);
   assign d[1][3] = `rot_left(c[1][3], 45);
   assign d[2][3] = `rot_left(c[2][3], 15);
   assign d[3][3] = `rot_left(c[3][3], 21);
   assign d[4][3] = `rot_left(c[4][3], 8);
   assign d[0][4] = `rot_left(c[0][4], 18);
   assign d[1][4] = `rot_left(c[1][4], 2);
   assign d[2][4] = `rot_left(c[2][4], 61);
   assign d[3][4] = `rot_left(c[3][4], 56);
   assign d[4][4] = `rot_left(c[4][4], 14);
    
   logic [63:0] e[4:0][4:0];
	
   // pi function
   assign e[0][0] = d[0][0];
   assign e[0][2] = d[1][0];
   assign e[0][4] = d[2][0];
   assign e[0][1] = d[3][0];
   assign e[0][3] = d[4][0];
   assign e[1][3] = d[0][1];
   assign e[1][0] = d[1][1];
   assign e[1][2] = d[2][1];
   assign e[1][4] = d[3][1];
   assign e[1][1] = d[4][1];
   assign e[2][1] = d[0][2];
   assign e[2][3] = d[1][2];
   assign e[2][0] = d[2][2];
   assign e[2][2] = d[3][2];
   assign e[2][4] = d[4][2];
   assign e[3][4] = d[0][3];
   assign e[3][1] = d[1][3];
   assign e[3][3] = d[2][3];
   assign e[3][0] = d[3][3];
   assign e[3][2] = d[4][3];
   assign e[4][2] = d[0][4];
   assign e[4][4] = d[1][4];
   assign e[4][1] = d[2][4];
   assign e[4][3] = d[3][4];
   assign e[4][0] = d[4][4];
    
   logic [63:0] f[4:0][4:0];
	
   // chi function
   generate    
       for(y = 0; y < 5; y = y + 1) begin : L5
          for(x = 0; x < 5; x = x + 1) begin : L6
             assign f[x][y] = e[x][y] ^ ((~ e[`add_1(x)][y]) & e[`add_2(x)][y]);
          end
       end
   endgenerate 
    
   logic [63:0] g[4:0][4:0];	
    
   // iota function
   assign g[0][0][0]     = f[0][0][0] ^ round_const[0];
   assign g[0][0][1]     = f[0][0][1] ^ round_const[1];
   assign g[0][0][2]     = f[0][0][2];
   assign g[0][0][3]     = f[0][0][3] ^ round_const[2];
   assign g[0][0][6:4]   = f[0][0][6:4];
   assign g[0][0][7]     = f[0][0][7] ^ round_const[3];
   assign g[0][0][14:8]  = f[0][0][14:8];
   assign g[0][0][15]    = f[0][0][15] ^ round_const[4];
   assign g[0][0][30:16] = f[0][0][30:16];
   assign g[0][0][31]    = f[0][0][31] ^ round_const[5];
   assign g[0][0][62:32] = f[0][0][62:32];
   assign g[0][0][63]    = f[0][0][63] ^ round_const[6];
    
   generate    
       for(y = 0; y < 5; y = y + 1) begin : L7
          for(x = 0; x < 5; x = x + 1) begin : L8
             if(x != 0 || y != 0)
                assign g[x][y] = f[x][y];
          end
       end
   endgenerate 
	
   generate
        for(y = 0; y < 5; y = y + 1) begin : L99
           for(x = 0; x < 5; x = x + 1) begin : L100
              assign out[`high_bit(x, y) : `low_bit(x, y)] = g[x][y];
           end
        end
   endgenerate
    
   `undef low_bit
   `undef high_bit
   `undef add_1
   `undef add_2
   `undef sub_1
   `undef rot_left
    
endmodule
