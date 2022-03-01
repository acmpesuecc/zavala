module test(
  input logic [31:0] a,
  input logic [31:0] b,
  input logic [31:0] c,
  input logic [31:0] d,
  input logic [31:0] e,
  input logic [31:0] f,
  
  output logic [31:0] y
);
  
  logic adr_valid_bit = 0;
  logic test_flag = 0;
  logic err_flag = 0;
  
  always_comb begin
    if(a!=b) begin
      adr_valid_bit <= 1;
    else
      if(test_flag == 0) begin
        $disp("Test mode not active");
      else
        $disp("Test mode active");
      end
    end
  end
endmodule
        
