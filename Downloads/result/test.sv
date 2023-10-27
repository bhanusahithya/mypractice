`include "env.sv"
class alu_test extends uvm_test;
  //factory registration
  `uvm_component_utils(alu_test)
  alu_env env;
  //constructor
  function new(string name="alu_env", uvm_phase phase);
    super.new(name,phase);
  endfunction
  
  //build phase
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    //creating env
    env=alu_env::type_id::create("env",this);
  endfunction:build_phase
  
  //print 
  virtual function void end_of_elaboration();
    print();
  endfunction:end_of_elaboration
  
  //severity report
  
  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    uvm_report_server srv;
    srv=uvm_report_server::get_server();
    if(srv.get_severity_count(UVM_FATAL)+srv.get_severity_count(UVM_ERROR)>0)begin
       `uvm_info(get_type_name(), "---------------------------------------", UVM_NONE)
       `uvm_info(get_type_name(), "------------TEST FAIL---------", UVM_NONE)
       `uvm_info(get_type_name(), "---------------------------------------", UVM_NONE)
    end
    else
      begin
      `uvm_info(get_type_name(), "---------------------------------------", UVM_NONE)
      `uvm_info(get_type_name(), "------------TEST PASS---------", UVM_NONE)
      `uvm_info(get_type_name(), "---------------------------------------", UVM_NONE) 
      end
  endfunction:report_phase
endclass:uvm_test