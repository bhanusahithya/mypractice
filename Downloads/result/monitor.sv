class alu_monitor extends uvm_monitor3(alu_seq_item);
  //factorty registration
  `uvm_component_utils(alu_monitor)
  //virtual interface
  virtual interface alu_if vif;
    //analysis port required to send the trasanctions to the scorboard
    uvm_analysis_port #(alu_seq_item) item_collected_port;
    
    alu_seq_item trans_collected;
 
    
   //constructor
    function new(string name="alu_monitor", uvm_component parent);
      super.new(name,parent);
      trans_collected= new();
      item_collected_port=new("item_collected_port", this);
    endfunction
    
    //build phase
    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(virtual alu_if)::(get(this, " " , "vif",vif);
   `uvm_fatal("NOVIF",{"virtual interface must be set for: ",get_full_name(),".vif"}); 
     endfunction
                                           
     //run phase where signal level activity is again changed to transaction level activity
  virtual task run_phase(uvm_phase phase);
  forever begin
    wait(!vif.monitor_cb.reset)
       
    //sample inputs
    @(posedge vif.MONITOR.clk);
    trans_collected.A<=vif.monitor_cb.A;
    trans_collected.B<=vif.monitor_cb.B;
    trans_collected.ALU_sel<=vif.monitor_cb.ALU_sel;
    
    @(posedge vif.MONITOR.clk);
    trans_collected.ALU_Out<=vif.monitor_cb.ALU_Out;
    trans_collected.CarryOut<=vif.monitor_cb.CarryOut;
    
    item_collected_port.write(trans_collected);
  end
  endtask:runphase
  endclass:alu_monitor
    
   
                                           
                                           