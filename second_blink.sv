module second_blink(
       input        clock,
		 output logic second_blink = 1);
		 
		 bit       bit_divider   = 0;
       integer	  cnt_divider   = 0;
		 
		 always @(posedge clock)
         begin: divider_frq                  // named block
		//-------section of divide clk	
			 if(cnt_divider < 25000000) 
				cnt_divider = cnt_divider + 1;
          else
			   begin
            cnt_divider = 0;
		//--------Section of inversion of bit		
   	      if(bit_divider == 1)
				  begin
   	        bit_divider = 0;
			     second_blink <= 0;
				  end
		      else
				  begin
		        bit_divider = 1;
			     second_blink <= 1;
		        end;				
			   end;	  
         end
endmodule // top