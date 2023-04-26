module TEST();

reg clk,rst,Coin_01Rs,Coin_02Rs,Coin_05Rs,Coin_10Rs;
wire [3:0] Change;
wire Choco;

V_M_C Block1 (clk,rst,Coin_01Rs,Coin_02Rs,Coin_05Rs,Coin_10Rs,Change,Choco);


always #100 clk = ~clk;

initial begin
clk = 0;
rst = 0;
#500 Coin_10Rs = 1;
#200 Coin_10Rs = 0;
#2400 Coin_02Rs = 1;
#200 Coin_02Rs = 0;
#2400 Coin_02Rs = 1;
#200 Coin_02Rs = 0;
#2400 Coin_01Rs = 1;
#200 Coin_01Rs = 0;
#2400 Coin_01Rs = 1;
#200 Coin_01Rs = 0;
end
endmodule
