class alu_scoreboard extends uvm_scoreboard;
  //factory registration
  `uvm_utils_component(alu_scoreboard)
  //local memory to store the transactions to compare the values
  alu_seq_item alu_pkts[$];
  //analysis port
  uvm_analysis_port #(alu_seq_item, alu_scoreboard) item_collected_export;
  //constructor
  function new(string name="alu_scoreboard", uvm_phase phase);
    super.new(name,phase);
  endfunction
  
  //buildphase-initalizing the local memory
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    item_collected_port= new(item_collected_port,this);
  endfunction:build_phase
    
    //write phase- writing the transactions from monitor to the scoreboard
  virtual function void write( alu_seq_item pkt);
    alu_pkts.push_back(pkt);
  endfunction
  //runphase
	task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("scb: runphase","run_phase",UVM_HIGH)
    alu_seq_item curr_trans;
    forever begin
      wait((alu_pkts.size()>0);
           curr_trans=alu_pkts.pop_front();// dequeue
           compare(curr_trans);
           end
    endtask:run_phase
           
    task compare(alu_seq_item curr_trans);
      logic [7:0] expected;
      logic [7:0] actual;
      
      case(curr_trans.ALU_Sel)
        0: expected= curr_trans.A +curr_trans.B;
        1: expected= curr_trans.A -curr_trans.B;
        2: expected= curr_trans.A *curr_trans.B;
        3: expected= curr_trans.A /curr_trans.B;
      endcase
      
        actual=curr_trans.result;
      if(actual!=expected)
        begin
        `uvm_error("COMPARE", $sformatf("Transaction failed! ACT=%d, EXP=%d", actual, expected))
        end
      else
        begin
        `uvm_info("COMPARE", $sformatf("Transaction passed!Actual=%d, Expected=%d",actual, expected)
        end
    endtask:compare
endclass:alu_scoreboard
                  