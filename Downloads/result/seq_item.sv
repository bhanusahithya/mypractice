class alu_seq_item extends uvm_sequence_item;
  // data and control fields
  rand bit [7:0] A,B;
  rand bit [3:0] ALU_sel;
  bit [ 7:0] ALU_Out;
  bit CarryOut;
  
 //object and members utils 
  `uvm_object_utils_begin(alu_seq_item)
  `uvm_field_int(A,UVM_ALL_ON)
  `uvm_field_int(B,UVM_ALL_ON)
  `uvm_field_int(ALU_sel,UVM_ALL_ON)
  `uvm_object_utils_end
  
  //constructor
  
  function new(string name="alu_seq_item");
    super.new(name);
  endfunction
  
  //constraint 
  constraint agrtb { (ALU_sel==4'b0001)-> A>B;};
endclass