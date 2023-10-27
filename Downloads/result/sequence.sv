class alu_sequence extends uvm_sequence#(alu_seq_item);
 //factory utilisation
  `uvm_object_utils(alu_sequuence)
  
  //constructor
  function new(string name="alu_sequence");
    super.new(name);
  endfunction
  
  //declaring the sequencer
  //done to setup sequence in sequence library not to register it
  `uvm_declare_p_sequencer(alu_sequencer)
  //create, randomize and send the item to driver
  
  virtual task body();
    repeat(2) begin
      req= alu_seq_item::type_id::create("req");
      wait_for_grant();// wait for the grant by the driver
      req.randomize();// we randomize the sequences
      send_request(req);// we send the request
      wait_for_item_done();// we waitfor the sequence to be completed for sending the next sequence
    end
  endtask
endclass
//add sequence
class add_sequence extends uvm_sequence#(alu_seq_item);
  
  `uvm_object_utils(add_sequence)
   

  //Constructor
 
  function new(string name = "add_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    `uvm_do_with(req,{req.ALU_sel==4'b0000;})
  endtask
endclass

class mul_sequence extends uvm_sequence#(alu_seq_item);
  
  `uvm_object_utils(mul_sequence)
   //constructor

  function new(string name = "mul_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    `uvm_do_with(req,{req.ALU_sel==4'b0010;})
  endtask
endclass

//sequence after a sequence
class mul_add_sequence extends uvm_sequence#(alu_seq_item);
  
  `uvm_object_utils(mul_add_sequence)
   //constructor

  function new(string name = "mul_add_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    `uvm_do_with(req,{req.ALU_sel==4'b0010;})
    `uvm_do_with(req,{req.ALU_sel==4'b0000;})
  endtask
endclass
      