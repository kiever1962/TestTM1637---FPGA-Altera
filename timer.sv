function automatic integer convert(input integer src);
  begin
 
  convert = 'b11111111;
  
  if (src == 8'h0) convert = 'b00111111;
  if (src == 8'h1) convert = 'b00000110;
  if (src == 8'h2) convert = 'b01011011;  
  if (src == 8'h3) convert = 'b01001111;
  if (src == 8'h4) convert = 'b01100110;
  if (src == 8'h5) convert = 'b01101101;
  if (src == 8'h6) convert = 'b01111101;
  if (src == 8'h7) convert = 'b00000111;
  if (src == 8'h8) convert = 'b01111111;
  if (src == 8'h9) convert = 'b01101111;
  if (src == 8'hA) convert = 'b01110111;
  if (src == 8'hB) convert = 'b01111100;
  if (src == 8'hC) convert = 'b00111001;
  if (src == 8'hD) convert = 'b01011110;
  if (src == 8'hE) convert = 'b01111001;
  if (src == 8'hF) convert = 'b01110001;

  return(convert);  
  end
  endfunction	


module timer (
       input         clock,
       output bit [7:0]  data_one,
		 output bit [7:0]  data_two,
		 output bit [7:0]  data_three,
		 output bit [7:0]  data_four);
		 
		 integer	  cnt_divider  = 0;
		 integer   sec_e        = 0;
		 bit       flag_se      = 0;
		 integer   sec_d        = 0;
		 bit       flag_sd      = 0;
		 integer   min_e        = 0;
		 bit       flag_me      = 0;
		 integer   min_d        = 0;
		 bit       flag_md      = 0;
		 bit       flag_blink   = 0;
		 
		 
		 always @(posedge clock)
         begin: block// named block
			
			if(cnt_divider < 25000000)  
				cnt_divider = cnt_divider + 1;
			else
		      begin
	         cnt_divider = 0;
				if(flag_blink == 0)
				  begin  
				  flag_blink = 1;
              end
				else
		        begin
				  flag_blink = 0;
				  end  
          	end	
				
				if((flag_blink == 1) && (cnt_divider == 0))
				  begin
				  sec_e = sec_e + 1;
				    if(sec_e > 9) 
					   begin
						sec_e = 0;
						sec_d = sec_d + 1;
						  if(sec_d > 5)
						    begin
							 sec_d = 0;
							 min_e = min_e + 1;
							 if(min_e > 9)
							   begin
								min_e = 0;
								min_d = min_d + 1;
								if(min_d > 5)
								  begin
								  min_d = 0;
								  end
								end
							 end
						end
				  end
			   data_one <= convert(sec_e);
            data_two <= convert(sec_d);
            data_three <= convert(min_e);
			   data_four <= convert(min_d);
				if(flag_blink == 1) data_three[7] <= 1;
				else data_three[7] <= 0; 
		   end
endmodule 

