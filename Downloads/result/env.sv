`include "agent.sv"
`include "scoreboard.sv"

class alu_env extends uvm_env;
  
  //factory registration
  `uvm_component_utils(alu_env)
  //member declaration
  alu_agent agent;
  alu_scoreboard scoreboard;
  //constructor
  function new(string name="uvm_env", uvm_phase phase);
    super.new(name,phase);
  endfunction
  
 //build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agent=alu_agent::type_id::create("agent",this);
    scoreboard=alu_scoreboard::type_id::create("scoreboard",this);
  endfunction:build_phase
  
  //connect phase -need to connect monitor and scoreboard
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    alu_agent.monitor.item_collected_port.connect(alu_scoreboard.item_collected_export);
  endfunction:connect_phase
endclass