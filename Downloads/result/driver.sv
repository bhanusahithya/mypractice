`define DRIV_IF vif.DRIVER.driver_cb
class alu_driver extends uvm_driver#(alu_seq_item);
  //factory registration of component
  
  
 //we need a virtual interface
  virtual alu_if vif;
  `uvm_component_utils(alu_driver)
  //constructor
  
  function new(string name="alu_driver", uvm_component parent);
    super.new(name,parent);
  endfunction
  
  //build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);// constructor
    if(!uvm_config_db#(virtual alu_if)::get(this, " ", "vif", vif))
      `uvm_fata("NO VIF",{"Virtual interface must be set for :",get_full_name(),".vif"});
  endfunction:build_phase
  
  //run phase(pretty common)
  
  virtual task run_phase(uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(req);
      drive();
      seq_item_port.item_done();
    end
  endtask : run_phase
  
  //driver phase (connects the transaction level signals to the DUT signals)
   virtual task drive();
     `DRIV_IF.reset<=0;
     `DRIV_IF.ALU_sel<=0;
     @(posedge vif.DRIVER.clk)
   
     'DRIV_IF.reset<=req.reset;
     'DRIV_IF.A<=req.A;
     'DRIV_IF.B<=req.B;
     'DRIV_IF.ALU_sel<=req.ALU_sel;
   endtask:drive
endclass:alu_driver
       
     
     
  