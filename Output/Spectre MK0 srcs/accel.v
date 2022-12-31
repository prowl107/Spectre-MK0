`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/02/2016 10:23:51 PM
// Design Name: 
// Module Name: accel
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


module accel(
    input CLK,
    input RESET_EN,
    input ACL_MISO,
    output reg [11:0]LED=0,
    output ACL_SCLK,ACL_MOSI,ACL_CSN,
    output reg LED16_B,
    output reg LED17_R,
    output reg LED16_G,
    output reg LED17_G,
    output reg [12:0] scaled_x, scaled_y
    );

wire [11:0] ACCEL_X,ACCEL_Y,ACCEL_Z,ACCEL_TMP;
wire Data_Ready;
reg [7:0] count;
reg SCLK;
ADXL362Ctrl accel (.SYSCLK(CLK), .RESET(RESET_EN), .ACCEL_X(ACCEL_X), .ACCEL_Y(ACCEL_Y), .ACCEL_Z(ACCEL_Z), .ACCEL_TMP(ACCEL_TMP), .SCLK(ACL_SCLK), .MOSI(ACL_MOSI), .MISO(ACL_MISO), .SS(ACL_CSN));

always @(posedge CLK)
   begin
    if (count>100)
        begin
            count<=0;
            SCLK<=!SCLK;     
        end
    else
        begin
            count<=count+1;
        end
   end
   
always @(posedge CLK)
    begin
    /**************************************************************************
    * Scaled values are right shifted by 2 to account for sensitivity 
    * listed in ADXL362 datasheet
    *
    * NOTE: Due to time constratins, accel in x axis is not considered
    **************************************************************************/
         scaled_x <= ACCEL_X>>2; 
         scaled_y <= ACCEL_Y>>2;
         LED[11:0] = ACCEL_Y>>2;
         
    /**************************************************************************
    * Update LEDs to indicate orientation
    * 
    * LED16_B = OFF | -1g in Y axis
    * LED17_R = ON  | +1g in Y axis 
    * 
    * LED17_G = ON, LED16_G = OFF | -1g in X axis
    * LED16_G = OFF, LED17_G = ON | +1g in X axis 
    **************************************************************************/
        if (scaled_y[11:9] > 0) begin
            LED16_B <= 1;
            LED17_R <= 0;
        end else begin
            LED16_B <= 0;
            LED17_R <= 1;
        end
        
//        if (scaled_x[11:9] > 0) begin
//            LED17_G <= 1;
//            LED16_G <= 0;
//        end else begin
//            LED17_G <= 0;
//            LED16_G <= 1;
//        end
   end
                    
endmodule
