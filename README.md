# DC Motor Reduced Order Model

[![Open in MATLAB Online](https://www.mathworks.com/images/responsive/global/open-in-matlab-online.svg)](https://matlab.mathworks.com/open/github/v1?repo=simorxb/DC-Motor-Reduced-Order&file=Analysis.m)

## Summary
This repository contains a step-by-step guide and implementation for obtaining a reduced-order model of a DC motor using MATLAB. The reduction is achieved through balanced truncation, allowing for a simplified model with reduced computational complexity while maintaining essential system dynamics.

## Project Overview
The project demonstrates how to reduce the order of a system model using a five-step process. This approach is particularly beneficial for control systems where model simplification can lead to more efficient and robust controller designs.

### Steps to Obtain a Reduced Order Model

1. **Define the System**  
   Begin by modeling a DC motor using the state space representation, which is crucial for setting up the foundation of model reduction.

2. **State Space Model**  
   The DC motor is represented in the state space form with the following equations:
x' = Ax + Bu
y = Cx + Du

**State Variables and Matrices:**
- `x = [θ, ω, i]`
- `u = V` (input voltage)
- `y = θ = [1, 0, 0] x`

**Matrices:**
A = [ 0, 1, 0;
0, -b/J, kt/J;
0, -ke/L, -R/L ]

B = [ 0;
0;
1/L ]

C = [1, 0, 0]

D = 0

3. **Model Order Reduction Specification (`reducespec`)**  
Create a model order reduction specification using balanced truncation with the command:

red = reducespec(sys, 'balanced');

This technique evaluates the states' contributions to the input/output transfer function and discards states with minimal impact.

4. **State Contribution Visualization (view)**
Use Hankel singular values to view and analyze the state contributions with:

view(red);

5. **Obtain Reduced Order Model (getrom)**

Choose the desired order for the reduced model and extract it using:

reducedOrder = 2;
rsys2 = getrom(red, 'Order', reducedOrder);

## Why Model Reduction?

- Simplification: Reduces complexity in systems with high order, making the model easier to handle and interpret.
- Control Design: Simplified models lead to simpler state feedback and observer designs, often with better robustness and noise rejection due to fewer fast states.
