`include "seq_item.sv"
`include "sequence.sv"
`include "sequencer.sv"
`include "driver.sv"
`include "monitor.sv"

class alu_agent extends uvm_agent;
  //member instantiations
  alu_sequencer sequencer;
  alu_driver driver;
  alu_monitor monitor;
  
//facotry registration
  `uvm_component_utils(alu_agent)
  
  //constructor
  
  function new(string name="alu_agent", uvm_component parent);
    super.new(name,parent);
  endfunction
  
  //build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    monitor= alu_monitor::type_id::create("monitor",this);
    
    if(get_is_active()==UVM_ACTIVE)begin
      sequencer= alu_sequencer::type_id::create("sequencer", this);
      driver= alu_driver::type_id::create("driver", this);
    end
  endfunction:build_phase
  
  //connectphase
  //connecting the sequencer to the driver
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    if(get_is_active()==UVM_ACTIVE)
      begin
      driver.seq_item_port.connect(sequencer.seq_item_export);
      end
  endfunction:connect_phase

endclass:alu_agent
    
      
  
  