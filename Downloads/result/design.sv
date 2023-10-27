// Code your design here
module ALU_DUT(input clk, 
               input reset, 
               input [7:0] A,B,
               input[3:0] ALU_sel,
               output logic [ 7:0] ALU_Out,
               output logic CarryOut);
  logic[7:0] ALU_result;
  wire [8:0] tmp;
  assign tmp={1'b0,A} +{1'b0,B};
  always@(posedge clk or posedge reset)
    begin
      if(reset)begin
        
        ALU_Out<=8'd0;
      	CarryOut<=1'd0;
    end
      else
       ALU_Out<=ALU_result;
      Carryout<=tmp[8];
    end
  always@(*)
    begin
    case(ALU_sel)
      4'b0000: ALU_result<= A+B;
      4'b0001: ALU_result<=A-B;
      4'b0010: ALU_result<= A*B;
      4'b0011: ALU_result<= A/B;
      default: ALU_result<= 8'hAC;
    endcase
    end
endmodule
      