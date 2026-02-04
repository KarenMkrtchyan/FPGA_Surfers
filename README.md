# FPGA Surfers

<video controls autoplay loop muted playsinline width="640">
  <source src="./demo.mp4" type="video/mp4">
  Demo video not supported by your browser.
</video>

Alternate demo link:  
https://youtube.com/shorts/oKfRI5LEl64?feature=share

---

**FPGA Surfers** is an endless three-lane dodging game implemented entirely in **Verilog** and deployed on a **Nexys A7 FPGA**. The design generates a real-time **640×480 VGA** output and handles input, animation, collision detection, and scoring fully in hardware.

---

## Functionality

- Three-lane player movement with smooth lane-to-lane sliding  
- Falling obstacle generation with guaranteed open lane  
- Immediate collision detection and game-over state  
- Score increments based on survival time

---

## Architecture

- **VGA controller**
  - 25 MHz pixel clock
  - 640×480 @ 60 Hz timing
- **Clocking**
  - Slow clock enable (~0.16 s) for game logic
  - VGA rendering runs continuously at full frame rate
- **State Machines**
  - Main game FSM: `START → PLAY → GAMEOVER`
  - Movement FSM: `READY → MOVING`
- **Graphics**
  - Sprite-based rendering using BRAM
  - Multi-frame boat animation with transparency
- **Collision Detection**
  - Bounding-box overlap checks in X and Y
- **Scoring**
  - Displayed on Nexys A7 seven-segment display

---

## Controls

- **BtnL / BtnR**: Move player left or right (debounced)  
- **BtnC**: Restart game

---

## Tools & Platform

- Verilog HDL  
- Nexys A7 FPGA  
- VGA output  
- BRAM-based sprite ROMs
