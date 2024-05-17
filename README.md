# Menger-Sponge-Fractal
These scripts are designed for creating and managing a Menger Sponge fractal in Roblox Studio.
## Created by AmSpotNot_1221

## Menger Sponge Server Script

This script contains functions for generating a Menger Sponge fractal on the server side. It utilizes the Box Module Script to create and manipulate individual blocks of the sponge.

### Functions
- `sponge(size,iter,position,color)`: A function to create the Menger Sponge fractal with specified parameters.
- `GenerateFractal` remote event: Listens for client requests to generate the fractal with custom color and iteration settings.

## Box Module Script

This script provides functionality for creating and manipulating individual boxes, which are used to construct the Menger Sponge fractal.

### Functions
- `box.New(size,pos)`: Creates a new box object with specified size and position.
- `box:Subdivide(iter,max)`: Subdivides the box into smaller boxes recursively until the specified iteration limit is reached.
- `box:GetCurrentMesh()`: Retrieves the current mesh of boxes.

## Usage
1. Place the Menger Sponge Server Script and Box Module Script in ServerScriptService.
2. Ensure you have a model named "BoxMesh" in ServerStorage, which will be used to represent individual blocks of the Menger Sponge.
3. Call the `GenerateFractal` remote event in ReplicatedStorage from the client side, passing the desired color and number of iterations as arguments.
