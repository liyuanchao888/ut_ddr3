
`ifndef GUARD_SVT_AXI_PORT_MONITOR_CALLBACK_SV
`define GUARD_SVT_AXI_PORT_MONITOR_CALLBACK_SV

/**
  * Port monitor callback class contains the callback methods called by the port
  * monitor component. The coverage callback classes are extended from port
  * monitor callback class.
  */

`ifdef SVT_UVM_TECHNOLOGY
class svt_axi_port_monitor_callback extends svt_uvm_callback;
`elsif SVT_OVM_TECHNOLOGY
class svt_axi_port_monitor_callback extends svt_ovm_callback;
`else
class svt_axi_port_monitor_callback extends svt_xactor_callbacks;
`endif

  //----------------------------------------------------------------------------
  /** CONSTUCTOR: Create a new callback instance */
`ifndef SVT_VMM_TECHNOLOGY
  extern function new(string name = "svt_axi_port_monitor_callback");
`else
  extern function new();
`endif

  //----------------------------------------------------------------------------
  /** Returns this class name as a string. */
  virtual function string `SVT_DATA_GET_OBJECT_TYPENAME();
    return "svt_axi_port_monitor_callback";
  endfunction  

  /** 
    * Called before putting a transaction to the analysis port. Extension 
    * of this method in the default coverage callback class is used for triggering
    * transaction coverage.
    */
  virtual function void pre_output_port_put(svt_axi_port_monitor axi_monitor, svt_axi_transaction item);
  endfunction

  /** 
    * Called for toggle signals before putting a transaction to the analysis port. Extension 
    * of this method in the default coverage callback class is used for triggering
    * transaction coverage.
    */
  virtual function void toggle_output_port_put(svt_axi_port_monitor axi_monitor, svt_axi_transaction item);
  endfunction

  /** Called when a new transaction is observed on the port */
  virtual function void new_transaction_started(svt_axi_port_monitor axi_monitor, svt_axi_transaction item);
  endfunction
  
  /** Called when a transaction ends */
  virtual function void transaction_ended(svt_axi_port_monitor axi_monitor, svt_axi_transaction item);
  endfunction

  /** Called when ARVALID or AWVALID is asserted */
  virtual function void change_dynamic_port_cfg(svt_axi_port_monitor axi_monitor,svt_axi_port_configuration cfg);
  endfunction

  /** Called when AWVALID is asserted */
  virtual function void write_address_phase_started(svt_axi_port_monitor axi_monitor, svt_axi_transaction item);
  endfunction

  /** 
    * Called when write address handshake is complete, that is, when AWVALID 
    * and AWREADY are asserted. Extension of this method in the default coverage 
    * callback class is used for signal coverage of write address channel signals.
    */
  virtual function void write_address_phase_ended(svt_axi_port_monitor axi_monitor, svt_axi_transaction item);
  endfunction

  /** Called when ARVALID is asserted */
  virtual function void read_address_phase_started(svt_axi_port_monitor axi_monitor, svt_axi_transaction item);
  endfunction

  /** Called when dvm sync snoop addr handshake is done on the snoop address channel and master is preparing to send corresponding 
    * DVMCOMPLETE Coherent transaction.
    * This callback is used by the user to change the properties of auto generated dvm_complete transaction.User can modify the 
    * svt_axi_transaction::dvm_complete_delay , svt_axi_transaction::addr_valid_delay , svt_axi_transaction::addr_ready_delay
    * properties of the dvm_complete_xact using this callback.
    * By modifying the above properties below different scenarios can be achieved.
    * Generate ARVALID (DVM Complete) atleast 1 cycle (configurable delay) before CRVALID response 
    * Generate CRVALID , ARVALID at the same time. 
    * Generate ARVALID after CRVALID. 
    * Please see that CRVALID here corresponds to the corresponding DVM SNOOP SYNC and ARVALID corresponds to autogenerated 
    * DVMCOMPLETE.
    */
  virtual function void auto_generated_dvm_complete_xact_started(svt_axi_port_monitor axi_monitor,svt_axi_transaction item);
  endfunction
 
  /** 
    * Called when read address handshake is complete, that is, when ARVALID 
    * and ARREADY are asserted. Extension of this method in the default coverage 
    * callback class is used for signal coverage of read address channel signals.
    */
  virtual function void read_address_phase_ended(svt_axi_port_monitor axi_monitor, svt_axi_transaction item);
  endfunction

  /** Called when WVALID is asserted */
  virtual function void write_data_phase_started(svt_axi_port_monitor axi_monitor, svt_axi_transaction item);
  endfunction

  /** 
    * Called when write data handshake is complete, that is, when WVALID 
    * and WREADY are asserted. Extension of this method in the default coverage 
    * callback class is used for signal coverage of write data channel signals.
    */ 
  virtual function void write_data_phase_ended(svt_axi_port_monitor axi_monitor, svt_axi_transaction item);
  endfunction

  /** Called when RVALID is asserted */
  virtual function void read_data_phase_started(svt_axi_port_monitor axi_monitor, svt_axi_transaction item);
  endfunction

  /** 
    * Called when read data handshake is complete, that is, when RVALID 
    * and RREADY are asserted. Extension of this method in the default coverage 
    * callback class is used for signal coverage of read data channel signals.
    */ 
  virtual function void read_data_phase_ended(svt_axi_port_monitor axi_monitor, svt_axi_transaction item);
  endfunction

  /** Called when BVALID is asserted */
  virtual function void write_resp_phase_started(svt_axi_port_monitor axi_monitor, svt_axi_transaction item);
  endfunction

  /** 
    * Called when write response handshake is complete, that is, when BVALID 
    * and BREADY are asserted. Extension of this method in the default coverage 
    * callback class is used for signal coverage of write response channel signals.
    */
  virtual function void write_resp_phase_ended(svt_axi_port_monitor axi_monitor, svt_axi_transaction item);
  endfunction

  /** 
    * Called just before the response request transaction is provided by slave 
    * port monitor to slave response generator
    */
  virtual function void pre_response_request_port_put(svt_axi_port_monitor axi_monitor, svt_axi_transaction item);
  endfunction


  // ACE callbacks

  /** Called before putting a snoop transaction to the analysis port */
  virtual function void pre_snoop_output_port_put(svt_axi_port_monitor axi_monitor, svt_axi_snoop_transaction item);
  endfunction

  /** Called when a new snoop transaction is observed on the port */
  virtual function void new_snoop_transaction_started(svt_axi_port_monitor axi_monitor, svt_axi_snoop_transaction item);
  endfunction

  /** Called when a idle period of snoop channel toggles acwakeup signal assertion observed on the port */
  virtual function void new_snoop_channel_acwakeup_toggle_started(svt_axi_port_monitor axi_monitor, int assert_delay);
  endfunction

  /** Called when a idle period of snoop channel toggles acwakeup signal deassertion observed on the port */
  virtual function void new_snoop_channel_acwakeup_toggle_ended(svt_axi_port_monitor axi_monitor, int deassert_delay);
  endfunction

  /** Called when a idle period of snoop channel toggles awakeup signal assertion observed on the port */
  virtual function void new_snoop_channel_awakeup_toggle_started(svt_axi_port_monitor axi_monitor, int assert_delay);
  endfunction

  /** Called when a idle period of snoop channel toggles awakeup signal deassertion observed on the port */
  virtual function void new_snoop_channel_awakeup_toggle_ended(svt_axi_port_monitor axi_monitor, int deassert_delay);
  endfunction

  /** Called when ACVALID is asserted */
  virtual function void snoop_address_phase_started(svt_axi_port_monitor axi_monitor, svt_axi_snoop_transaction item);
  endfunction

  /** Called when snoop address handshake is complete, that is, when ACVALID 
    * and ACREADY are asserted */
  virtual function void snoop_address_phase_ended(svt_axi_port_monitor axi_monitor, svt_axi_snoop_transaction item);
  endfunction

  /** Called when CDVALID is asserted */
  virtual function void snoop_data_phase_started(svt_axi_port_monitor axi_monitor, svt_axi_snoop_transaction item);
  endfunction

  /** Called when snoop data handshake is complete, that is, when CDVALID 
    * and CDREADY are asserted */
  virtual function void snoop_data_phase_ended(svt_axi_port_monitor axi_monitor, svt_axi_snoop_transaction item);
  endfunction

  /** Called when CRVALID is asserted */
  virtual function void snoop_resp_phase_started(svt_axi_port_monitor axi_monitor, svt_axi_snoop_transaction item);
  endfunction

  /** Called when snoop response handshake is complete, that is, when CRVALID 
    * and CRREADY are asserted */
  virtual function void snoop_resp_phase_ended(svt_axi_port_monitor axi_monitor, svt_axi_snoop_transaction item);
  endfunction

   /** Called when TVALID is asserted */
  virtual function void stream_transfer_started(svt_axi_port_monitor axi_monitor,svt_axi_transaction item);
  endfunction

  /** Called when stream handshake is complete, that is, when TVALID and TREADY are asserted */
  virtual function void stream_transfer_ended(svt_axi_port_monitor axi_monitor, svt_axi_transaction item);
  endfunction
`ifdef SVT_UVM_TECHNOLOGY

  /** Called when a transaction completes and when use_tlm_gp_sequencer is set
    * in the port configuration. The completed AXI transaction is converted to
    * a PV-annotated TLM GP and is made available through this callback
    */
  virtual function void pre_tlm_generic_payload_port_put(svt_axi_port_monitor    axi_monitor,
                                                         uvm_tlm_generic_payload xact);
  endfunction

  /** Called when a snoop transaction completes and when use_tlm_gp_sequencer is set
    * in the port configuration. The completed AXI snoop response is converted to
    * a PV-annotated TLM GP and is made available through this callback
    */
  virtual function void pre_tlm_generic_payload_snoop_port_put(svt_axi_port_monitor    axi_monitor,
                                                               uvm_tlm_generic_payload xact);
  endfunction
`endif

endclass

`protected
,_@2&MGF[f6_,AB@O1</WU(>/g+[f(LI_<[H>WB[O683.[I)c>\&.)gfbV09I]]9
7?4<e:CCECQ,(TbDDMKc2a+U.N^NRGJbf#6<(I4L_EGW+-UEE?3C-Nc1H_\AN93X
#GeIfGDPLG/?A-/TXg@_&]T9fa,>RQD2(I@ESf3#,[+Ga#;?^L&L7[MXd25NJFO]
f;0:f]\P-?#I:MY.W@<[A&-NM<>9@Df9eAg:)S\J97ZNKIC)P:6]YFI:C=[64&bE
(S(3aEJD^ed]8:g_;a(gZ[RbObZB<3?)+=PM^-^?9C3agcM[L8X0]&=5RaM#;T)>
V9L:Bf<);;gUJVA-1.2B[T6d;AO@,JXJgL6BULCb6<-7^,N/DL9_9#[8BYd_UfLS
QR,4NS:6U_S;L[D96@W1H2gM6^@gJGQ-ISU\<&#SCRO:Y<N)Oaf7R)G89bVWJ\Z6
fJ9GD4S^2ZK#gX>ZJK>4.Q6)SG?PR<A</F;_#3V/#Ja&UA@YTEIS[ef:Rd5[ZX<.
?[R;QfD2(CC.d,0\+TD,N@MRAW]_[N]g-T=1AEKJOJSO;4f2Hde3;Pf:K$
`endprotected


`endif // GUARD_SVT_AXI_PORT_MONITOR_CALLBACK_SV