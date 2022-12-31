`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2022 01:40:11 PM
// Design Name: 
// Module Name: PWM_M
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


module PWM_M #( parameter CTR_LEN = 21)
  (
  input CLK,
  input [15:0] angle,
  input TOGGLE_CONFIG_BTN,
  input [10:0] calibration_value,
  input [2:0] ARMED_FLAG,
  output reg SERVO_1_PIN,SERVO_2_PIN,SERVO_3_PIN,SERVO_4_PIN,
  output reg LED
  );

reg [CTR_LEN:0] counter = 0;
reg [15:0] position = 0;
//reg [15:0] default_pos = (10'b1100001111) / 2;
//reg [15:0] default_pos = 0;
reg [15:0] default_pos = (10'b1100001111);
reg [(CTR_LEN - 1):0] pulse_period = (2000000-1) * 2;

always @ (posedge CLK) begin

/*************************************************************************
* System States:
* 0 - SYSTEM_INIT
* 1 - NOT_ARMED
* 2 - ARMED_OPERATION
*************************************************************************/
case (ARMED_FLAG)
    
    /* SYSTEM_INIT -- Calibrate default position */
    0: begin 
        if(TOGGLE_CONFIG_BTN != 0) begin
            //default_pos <= calibration_value;
        end
    end
    
    /* SYSTEM WAITING FOR ARM -- set servo to default position */
    1: begin
        position <= default_pos;
    end
    
    /* ARMED_OPERATION -- Start Demo */
    2: begin 
        if (angle[11:9] > 0) begin
            position <=  default_pos - (1024-angle[9:0]); /* Reverse direction if orientation angle is negative */
        end else begin
            position <= default_pos + angle;
        end
    end
    
    /* If invalid state, set to default position */
    default: begin 
        position <= default_pos;
    end
endcase

/**************************************************************************
* Servo Control & PWM output
*
* Desired frequency = 50Hz
* Pulse periodd = 20ms
* CLK Frequency = 100MHz
* Counter bits = 21 - Derived from F = Fclk/(2^n) where n is # of 
*    counter bits
*
* Output to pins JA1 (SERVO_0), JA2 (SERVO_1), JA3 (SERVO_2), JA4 (SERVO_4)
**************************************************************************/
  counter <= counter + 1;

/**************************************************************************
* Set output to HIGH (1) if counter is less than compare target,
* otherwise, output on all pins should be 0. 
**************************************************************************/
if (ARMED_FLAG == 2) begin
   if (counter < (((position + 15'd165 )<<8))) begin
    SERVO_1_PIN <= 1;
    SERVO_2_PIN <= 1;
    SERVO_3_PIN <= 1;
    SERVO_4_PIN <= 1;
    LED <= 1;
    end else begin
    SERVO_1_PIN <= 0;
    SERVO_2_PIN <= 0;
    SERVO_3_PIN <= 0;
    SERVO_4_PIN <= 0;
    LED <= 0;
    end
 end

    if (counter == pulse_period) /* Reset counter if pulse period is reached */
    begin
        counter <= 0;
    end
end
endmodule
