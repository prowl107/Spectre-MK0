`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/10/2022 12:30:16 PM
// Design Name: 
// Module Name: FSM
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


module FSM(
    input CLK,
    input ARM_SWITCH,
    input CALIBRATION_SW,
    output reg [2:0] LED, /* LED[15:13] */
    output reg [7:0] anode_val,
    output reg [7:0] cathode_val,
    output reg [2:0] state
    );

/*************************************************************************
* System States:
* 0 - SYSTEM_INIT & CALIBTRATION
* 1 - NOT_ARMED
* 2 - ARMED_OPERATION
*************************************************************************/
reg [2:0] state_counter = 0;
reg [2:0] STATE0 = 0;
reg [2:0] STATE1 = 1;
reg [2:0] STATE2 = 2;
reg [2:0] STATE3 = 3;
reg [2:0] STATE4 = 4;
reg [2:0] STATE5 = 5;

reg [3:0] counter = 0;

always @(posedge CLK)
    begin
        case(state)
       
        /*************************************************************************
        * 0 - SYSTEM_INIT & CALIBTRATION
        *
        * Transition from state 0 if BTNC is pressed
        *************************************************************************/
        STATE0: begin /* SYSTEM STARTUP & Calibration*/
            if(CALIBRATION_SW == 0) begin
                LED[2] <= 0;
                state <= STATE1;
            end
        end
        
        /*************************************************************************
        * 1 - SYSTEM HOLD FOR ARMING
        *
        * - Transition to state 0 if BTNC is pressed
        * - Transition to state 2 if ARM_SWITCH is activated
        *************************************************************************/
        STATE1: begin /* SYSTEM HOLD FOR ARMING */
            if(ARM_SWITCH != 0 && CALIBRATION_SW == 0) begin
                state <= STATE2; /* System is armed */
            end else begin
                state <= STATE1;
            end
        end
        
        /*************************************************************************
        * 2 - ARMED Operation
        *
        * - Transition to state 1 if ARM_SWITCH is disabled
        *************************************************************************/
        STATE2: begin
            if (ARM_SWITCH == 0) begin
                LED[2] <= 1;
                state <= STATE1;
            end
        end

        endcase
        
        /* NOTE: At any point, the system shall be able to be disarmed */
//        if (ARM_SWITCH != 1) begin
//            state <= STATE1;
//        end
        
        /**************************************************************************
        * Update LEDs to indicate state
        *
        * LED[15] is reserved for the arming switch
        * State will be indicated via LED[14:13]
        **************************************************************************/
        LED[1:0] <= state;
        
    end
endmodule

