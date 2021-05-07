module reset (
       input        clock,
		 output logic reset = 1);
		 
		 bit       flag_fin     = 0;
       integer	  cnt_divider  = 0;
		 
		 always @(posedge clock)
         begin: main_reset// named block
			
			if((cnt_divider < 25000000) && (flag_fin == 0)) 
			   begin
				cnt_divider = cnt_divider + 1;
			   reset <= 1;
				end	
			else	
			   begin
				reset <= 0;
				flag_fin = 1;
				end
       end
endmodule // top