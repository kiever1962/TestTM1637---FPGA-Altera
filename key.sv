module key (
       input        clock,
		 input  logic button,
		 output logic button_on = 1);
		 
		 bit       flag_press   = 0;
       integer	  cnt_divider  = 0;
		 
		 always @(posedge clock)
         begin: check_button// named block
			
			 if((cnt_divider < 5000000) && (button == 0) && (flag_press == 0)) 
				cnt_divider = cnt_divider + 1;
			 
			 if(cnt_divider > 4999999) 
			   begin
				flag_press  = 1;
				button_on  <= 0;
				cnt_divider = 0;
				end;
 
			 if(button == 1) 
			   begin
				flag_press  = 0;
				button_on  <= 1;
				end
			 			
       end
endmodule // top