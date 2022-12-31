`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/10/2022 01:08:43 AM
// Design Name: 
// Module Name: TEST_MAIN
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module TEST_MAIN(
    input CLK,
    input [15:0] SW,
    output [1:0] LED,
    output JA1, JA2, JA3, JA4
    );
    
    PWM_M 
    (
    .CLK(CLK),
    .position(SW[15:0]),
    .LED(LED[1:0]),
    .JA1(JA1),
    .JA2(JA2),
    .JA3(JA3),
    .JA4(JA4)
    );
    
always @ (posedge CLK) begin

end
endmodule
