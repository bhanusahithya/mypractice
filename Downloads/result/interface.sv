interface alu_if(input clk,reset);
  
  //declaring the signals
  logic [7:0] A,B;
  logic [3:0] ALU_sel;
  logic [7:0] ALU_Out;
  logic CarryOut;
  
  //driver clocking block
  clocking driver_cb @(posedge clk);
    default input #1 output #1;
    output A,B;
    output ALU_sel;
    input ALU_Out;
    input CarryOut;
  endclocking
  
 //monitor clocking block
  clocking monitor_cb@(posedge clk);
    default input #1 output #1;
    input A,B;
    input ALU_sel;
    output ALU_Out;
    output CarryOut;
  endclocking
  
  //modport declaration for driver
  modport DRIVER(clocking driver_cb,input clk,reset);
  //modport declaration for monitor
  modport MONITOR(clocking monitor_cb, input clk,reset);//check the monitor code for the error
endinterface
    
      
      