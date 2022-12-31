`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/10/2022 10:25:26 AM
// Design Name: 
// Module Name: SPECTRE_MK0
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


module SPECTRE_MK0(
    input CLK,
    input [15:0] SW,
    input BTNL,
    input BTNC,
    output [15:0] LED,
    input ACL_MISO,
    output ACL_SCLK,ACL_MOSI,ACL_CSN,
    output JA1, JA2, JA3, JA4,
    output LED16_B, LED17_R, LED16_G, LED17_G
    );
    
wire [2:0] state;
wire [12:0] scaled_x, scaled_y;

    /* Accelerometer module */
    accel
    (
    .CLK(CLK),
    .RESET_EN(SW[13]),
    .LED(LED[9:0]),
    .ACL_MISO(ACL_MISO),
    .ACL_SCLK(ACL_SCLK),
    .ACL_MOSI(ACL_MOSI),
    .ACL_CSN(ACL_CSN),
    .scaled_x(scaled_x),
    .scaled_y(scaled_y),
    .LED16_B(LED16_B),
    .LED17_R(LED17_R),
    .LED16_G(LED16_G),
    .LED17_G(LED17_G)
    );
    
    /* Servo controller module */
    PWM_M SPECTRE_SERVO 
    (
    .CLK(CLK),
    .angle(scaled_y),
    .TOGGLE_CONFIG_BTN(BTNC),
    //.calibration_value(SW[15:0]),
    .ARMED_FLAG(state),
    .LED(LED[11]),
    .SERVO_1_PIN(JA1),
    .SERVO_2_PIN(JA2),
    .SERVO_3_PIN(JA3),
    .SERVO_4_PIN(JA4)
    );
    
    /* Finite State Machine Module */
    FSM
    (
    .CLK(CLK),
    .ARM_SWITCH(SW[15]),
    .CALIBRATION_SW(SW[14]),
    .state(state),
    .LED(LED[15:13])
    );
    
endmodule
