module V_M_C(
                input clk,rst,
                input Coin_01Rs,
                input Coin_02Rs,
                input Coin_05Rs,
                input Coin_10Rs,        
                output reg [3:0] Change,
                output reg Choco
                );
                
parameter STATE00=0,
          STATE01=1,
          STATE02=2,
          STATE03=3,
          STATE04=4,
          STATE05=5,
          STATE06=6,
          STATE06_SS=6,
          STATE10=7,
          STATE10_SS=8;
reg [3:0] Present_State,Next_State;
reg [1:0] Choco_Counter =0;
reg Coin_01Rs_pulse,Coin_02Rs_pulse,Coin_05Rs_pulse,Coin_10Rs_pulse;
reg Coin_01Rs_hold,Coin_02Rs_hold,Coin_05Rs_hold,Coin_10Rs_hold;
reg [3:0] Coin_01Rs_Counts,Coin_02Rs_Counts,Coin_05Rs_Counts,Coin_10Rs_Counts;
//-------------------------------------------------------------------//
//-------------------------------------------------------------------//
initial begin
Coin_01Rs_pulse = 0;
Coin_02Rs_pulse = 0;
Coin_05Rs_pulse = 0;
Coin_10Rs_pulse = 0;
Coin_01Rs_Counts = 0;
Coin_02Rs_Counts = 0;
Coin_05Rs_Counts = 0;
Coin_10Rs_Counts = 0;
Coin_01Rs_hold = 0;
Coin_02Rs_hold = 0;
Coin_05Rs_hold = 0;
Coin_10Rs_hold = 0;
Present_State = STATE00;
Next_State = STATE00;
end
//-------------------------------------------------------------------//
//-------------------------------------------------------------------//
 always@(posedge clk) begin
 if (rst) begin
        Present_State = STATE00;
        Change = 0;
        Choco = 0;
        end
 else if (Coin_01Rs_pulse ==1 && Coin_01Rs_Counts == 10)
        Present_State = Next_State;
 else if (Coin_02Rs_pulse ==1 && Coin_02Rs_Counts == 10)
        Present_State = Next_State;   
 else if (Coin_05Rs_pulse ==1 && Coin_05Rs_Counts == 5)
        Present_State = Next_State;
 else if (Coin_10Rs_pulse ==1 && Coin_10Rs_Counts == 4)
        Present_State = Next_State;                  
 end
///////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////
always@(posedge clk)
begin
    if (Choco == 1 && Choco_Counter < 2) begin
        Choco = 1;
        Choco_Counter = Choco_Counter +1;
        end
    else if (Choco == 1 && Choco_Counter == 2) begin
        Choco = 0;
        Choco_Counter = 0;
        end
end
///////////////////////////////////////////////////////////////////////
always@(posedge clk)
begin
    if (Coin_01Rs) 
    begin
        Coin_01Rs_pulse = 1;
        Coin_01Rs_hold = 1;
    end
    else
    begin
        Coin_01Rs_pulse = 0;
    end
    if (Coin_01Rs_hold == 1 && Coin_01Rs_Counts < 10)
    begin
        Coin_01Rs_pulse = 1;
        Coin_01Rs_Counts = Coin_01Rs_Counts + 1;
    end
    else if (Coin_01Rs_hold == 1 && Coin_01Rs_Counts == 10)
    begin
        Coin_01Rs_pulse = 0;
        Coin_01Rs_Counts = 0;
        Coin_01Rs_hold = 0;
    end
end
///////////////////////////////////////////////////////////////////////
always@(posedge clk)
begin
    if (Coin_02Rs) 
    begin
        Coin_02Rs_pulse = 1;
        Coin_02Rs_hold = 1;
    end
    if (Coin_02Rs_hold == 1 && Coin_02Rs_Counts < 10)
    begin
        Coin_02Rs_pulse = 1;
        Coin_02Rs_Counts = Coin_02Rs_Counts + 1;
    end
    else if (Coin_02Rs_hold == 1 && Coin_02Rs_Counts == 10)
    begin
        Coin_02Rs_pulse = 0;
        Coin_02Rs_Counts = 0;
        Coin_02Rs_hold = 0;
    end
end
///////////////////////////////////////////////////////////////////////
always@(posedge clk)
begin
    if (Coin_05Rs) 
    begin
        Coin_05Rs_pulse = 1;
        Coin_05Rs_hold = 1;
    end
    if (Coin_05Rs_hold == 1 && Coin_05Rs_Counts < 10)
    begin
        Coin_05Rs_pulse = 1;
        Coin_05Rs_Counts = Coin_05Rs_Counts + 1;
    end
    else if (Coin_05Rs_hold == 1 && Coin_05Rs_Counts == 10)
    begin
        Coin_05Rs_pulse = 0;
        Coin_05Rs_Counts = 0;
        Coin_05Rs_hold = 1;
    end
end
///////////////////////////////////////////////////////////////////////
always@(posedge clk)
begin
    if (Coin_10Rs) 
    begin
        Coin_10Rs_pulse = 1;
        Coin_10Rs_hold = 1;
    end

    if (Coin_10Rs_hold == 1 && Coin_10Rs_Counts < 10)
    begin
        Coin_10Rs_pulse = 1;
        Coin_10Rs_Counts = Coin_10Rs_Counts + 1;
    end
    else if (Coin_10Rs_hold == 1 && Coin_10Rs_Counts == 10)
    begin
        Coin_10Rs_pulse = 0;
        Coin_10Rs_Counts = 0;
        Coin_10Rs_hold = 0;
    end
end
///////////////////////////////////////////////////////////////////////
always@(posedge clk)
begin
    case (Present_State)
          STATE00:
          begin
                if (Coin_01Rs_Counts==10)
                    Next_State = STATE01;
                else if (Coin_02Rs_Counts==10)
                    Next_State = STATE02;
                else if (Coin_05Rs_Counts==4)
                    Next_State = STATE05;    
                else if (Coin_10Rs_Counts==4)
                    Next_State = STATE10;
                else
                    Next_State = STATE00;    
          end
          
          STATE01:
          begin
                if (Coin_01Rs_Counts==10)
                    Next_State = STATE02;
                else if (Coin_02Rs_Counts==10)
                    Next_State = STATE03;
                else
                    Next_State = STATE01;
          end
          STATE02:
          begin
                if (Coin_01Rs_Counts==10)
                    Next_State = STATE03;
                else if (Coin_02Rs_Counts==10)
                    Next_State = STATE04;
                else
                    Next_State = STATE02;
          end
          STATE03:
          begin
                     if (Coin_01Rs_Counts==10)
                    Next_State = STATE04;
                else if (Coin_02Rs_Counts==10)
                    Next_State = STATE05;
                else
                    Next_State = STATE03;
          end
          STATE04:
          begin
                if (Coin_01Rs_Counts==10)
                    Next_State = STATE05;
                else if (Coin_02Rs_Counts==10)
                    Next_State = STATE06;
                else
                    Next_State = STATE04;
          end
          STATE05:
          begin
                if (Coin_01Rs_Counts==10)
                    Next_State = STATE01;
                else if (Coin_02Rs_Counts==10)
                    Next_State = STATE02;
                else if (Coin_05Rs_Counts==10)
                    Next_State = STATE05;    
                else if (Coin_10Rs_Counts==10)
                    Next_State = STATE10;
          end
          STATE06:
          begin 
                        if (Coin_01Rs_Counts==10)
                            Next_State = STATE01;
                        else if (Coin_02Rs_Counts==10)
                            Next_State = STATE02;
                        else if (Coin_05Rs_Counts==10)
                            Next_State = STATE05;    
                        else if (Coin_10Rs_Counts==10)
                            Next_State = STATE10;
                        else     
                        Next_State = STATE00;
          end
          STATE10:
          begin
                        if (Coin_01Rs_Counts==10)
                            Next_State = STATE01;
                        else if (Coin_02Rs_Counts==10)
                            Next_State = STATE02;
                        else if (Coin_05Rs_Counts==10)
                            Next_State = STATE05;    
                        else if (Coin_10Rs_Counts==10)
                            Next_State = STATE10;
                        else     
                            Next_State = STATE00;
          end
    endcase
end
///////////////////////////////////////////////////////////////////////////////
always@(*)
begin
    case (Present_State)
          STATE00:
          begin
                Change=0;
                Choco=0;      
          end
          STATE01:
          begin
                Change=0;
                Choco=0;
          end
          STATE02:
          begin
                Change=0;
                Choco=0;
          end
          STATE03:
          begin
                Change=0;
                Choco=0;
          end
          STATE04:
          begin
                Change=0;
                Choco=0;
          end
          STATE05:
          begin
                Change=0;
                Choco=1;
          end
          STATE06:
          begin
                Change=1;
                Choco=1;
          end
          STATE10:
          begin
                Change=5;
                Choco=1;
          end
    endcase
end
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
endmodule
