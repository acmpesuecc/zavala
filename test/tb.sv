module test_t();
  reg a;
  reg b;
  reg c;
  reg d;
  reg e;
  reg f;
  
  wire y;
  
  test dut (a,b,c,d,e,f,y);
  
  initial begin
    a=0, b=1;
    $disp("Testbench")
  end
endmodule
