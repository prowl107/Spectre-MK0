# Spectre MK0

## Overview
 Spectre MK0 is an attempt to recreate the basic features of the Spectre Module flight computer used for the actual flight vehicle(s). Due to time constraints, this project is not designed to be a 1-to-1 recreation. The objective is to experiment with servo/canard actuation with the Nexys FPGA platform. 

## What is Spectre:
Spectre is an experimental high-powered rocket being used to develop an active-stabilization system for future ERPL rockets by using small forward control surfaces called canards to adjust its orientation. The end goal is to achieve a vertical, roll-less flight in any reasonable launch environment.

## Project Goal:
Simply to actuate the canards based on the orientation of the Nexys A7. At the time of writing, there are no plans to use this on a flight vehicle. Data acquisition, arming, and hardware-in-the-loop (HITL) testing are not required for this project.

## Test Environment:
In order to test that the project meets expectations, the current hardware for the Spectre flight vehicle will be reused. This includes the canards, servo motors, and portions of the assembly for the AV bay. 

### Hardware Specifications
- Platform: [Nexys A7-100T](https://digilent.com/shop/nexys-a7-fpga-trainer-board-recommended-for-ece-curriculum/) 
    - FPGA: Artix-7 XC7A100T
- Sensors:
    - [ADXL362 3-axis acceleromter](https://www.analog.com/en/products/adxl362.html#product-overview)
- Servos: [LD-20MG](https://hiwonder.hk/products/hiwonder-ld-20mg-full-metal-gear-digital-servo-with-20kg-high-torque-aluminium-case-for-robot-rc-car)

### Development Environment
- [Vivado Design Suite (2018.3)](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/vivado-design-tools/archive.html)

## Demo

*Coming soon*

## Difficulties
- Servo calibration
- Properly scaling of raw accelerometer output
- Generating PWM output on GPIO pins