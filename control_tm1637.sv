module control_tm1637(
       input         clock,
		 input  logic  button,
		 input  logic  busy,
		 input  [31:0] data_in,
		 output [7:0]  data_out,

		 output logic  data_latch,
		 output logic  data_stop_bit,
		 output logic  led = 1);
		 		 
		 reg [3:0]     cur_state = S_IDLE;
		 integer       time_wait = 50000;
	 
    localparam [9:0] wait_time = 256; // at 12MHz that's about 47uS

    localparam [3:0]
        S_IDLE      = 4'h0,
        S_WAIT1     = 4'h1,
        S_WAIT2     = 4'h2,
        S_WAIT3     = 4'h3,
        S_WAIT4     = 4'h4,
        S_WAIT5     = 4'h5,
        S_WAIT6     = 4'h6,
        S_WAIT7     = 4'h7,
		  S_WAIT8     = 4'h8,
        S_WAIT9     = 4'h9, 		 
		  S_WAITA     = 4'hA,
		  S_WAITB     = 4'hB,
		  S_WAITC     = 4'hC,
		  S_WAITD     = 4'hD,
		  S_WAITE     = 4'hE,
		  S_WAITF     = 4'hF;
		 
		 
		 always @(posedge clock)
         begin: check_frq// named block	

			if (button == 0) begin
           // data init
		     data_latch    <= 0;
		     data_stop_bit <= 0;
			  cur_state      = S_IDLE;
			  led           <= 1;
			  end else begin

           case (cur_state)
                    S_IDLE: begin
                        // send first byte
								if(busy == 0) begin
								data_out      <= 8 'h40;
								data_stop_bit <= 1;
                        data_latch    <= 1;
								cur_state      = S_WAIT1;
								end
                    end	

                    S_WAIT1: begin
                        if(busy == 1)
								  begin
								  data_latch <= 0;
								  cur_state   = S_WAIT2;
								  end
                    end							  
						  
                    S_WAIT2: begin
						      //send second byte
                        if(busy== 0)
								  begin
								  data_out      <= 'hC0;
								  data_stop_bit <= 0;
								  data_latch    <= 1;
								  cur_state      = S_WAIT3;
								  end
                    end	

						  S_WAIT3: begin
                        if(busy == 1)
								  begin
								  data_latch <= 0;
								  cur_state   = S_WAIT4;
								  end
                    end		
						  
						  S_WAIT4: begin
						      //send third byte
                        if(busy == 0)
								  begin
								  data_out <= data_in[31:24];
								  data_stop_bit <= 0;
                          data_latch    <= 1;								  
								  cur_state     = S_WAIT5;
								  end
                    end	
						  
						  S_WAIT5: begin
                        if(busy == 1)
								  begin
								  data_latch <= 0;
								  cur_state   = S_WAIT6;
								  end
                    end	
						  
						  S_WAIT6: begin
						      //send third byte
                        if(busy == 0)
								  begin
								  data_out <= data_in[23:16]; //'h06;
								  data_stop_bit <= 0;
                          data_latch    <= 1;								  
								  cur_state     = S_WAIT7;
								  end
                    end							  
						  
						  S_WAIT7: begin
                        if(busy == 1)
								  begin
								  data_latch <= 0;
								  cur_state   = S_WAIT8;
								  end
                    end							  
						  
						  S_WAIT8: begin
						      //send third byte
                        if(busy == 0)
								  begin
								  data_out <= data_in[14:8]; //'h06;
								  data_stop_bit <= 0;
                          data_latch    <= 1;								  
								  cur_state     = S_WAIT9;
								  end
                    end							  
						  
						  S_WAIT9: begin
                        if(busy == 1)
								  begin
								  data_latch <= 0;
								  cur_state   = S_WAITA;
								  end
                    end							  
						  
						  S_WAITA: begin
						      //send third byte
                        if(busy == 0)
								  begin
								  data_out <= data_in[7:0];//'h06;
								  data_stop_bit <= 1;
                          data_latch    <= 1;								  
								  cur_state     = S_WAITB;
								  end
                    end							  
						  
						  S_WAITB: begin
                        if(busy == 1)
								  begin
								  data_latch <= 0;
								  cur_state   = S_WAITC;
								  end
                    end		
	
	

						  S_WAITC: begin
						      //send fourth byte
                        if(busy == 0)
								  begin
								  data_out      <= 'h8A;
								  data_stop_bit <= 1;
                          data_latch    <= 1;								  
								  cur_state     = S_WAITD;
								  end
                    end							  
						  
						  S_WAITD: begin
                        if(busy == 1)
								  begin
								  data_latch <= 0;
								  cur_state   = S_WAITE;
								  end
                    end		
		
						  S_WAITE: begin
						      //send fifth byte
                        if(busy == 0)
								  begin
                          if(time_wait > 0) time_wait = time_wait -1;
								  else
								    begin
									 time_wait = 50000;
								    cur_state <= S_IDLE;	 
									 end
								  end
                    end		

		              default: begin
                        cur_state <= S_IDLE;
                    end
                endcase

	        end
			
			
			end
endmodule 			