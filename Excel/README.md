# This is the Excel documentation for NNFSiX

## Goal
The main goal of the project is: To use Excel to recreate the NNFSiX project, without using macros.

## Requirements
- min. Version Excel 2019 (unconfirmed). I am running on Office 365.

## Guidelines
Since there is no clear syntax for Excel. I tried to make it as user-friendly and coherent as possible.

### First Column
The first column is always for the variables. Mostly these do not serve a direct purpose, except to define the data
beside it. However sometimes they are the keys to the objects i.e. sheets used. Thus, it is necessary to check that
the variable, and it's respective object/sheet name is the same.

### Objects

Apart from the Ranges, each new defined Object will be saved as a sheet. Sheets like layer and activation contain
predefined inputs and calculations. This allows for easier creation with copy pasting the sheets, subsequently 
creating new objects and allowing for input parameters to dynamically be passed.

#### Layers

**Inputs:**
1. layer_name: Text
2. n_input: Number
3. n_neurons: Number
4. inputs: Range

**Output:**
1. output: Range (referenced by layer_name!output#)

**To create a layer:**
1. Define layer_name in the column A
2. Define n_input in column B
3. Define n_neurons in column C
4. Reference your inputs as a range in column D
5. Copy any layerX sheet and rename it to your layer_name

**Example:**

    | A      |  B        |  C          |  D                |
    |--------|-----------|-------------|-------------------|
	|        |  n_input  |	n_neurons  |  inputs           |
	|--------|-----------|-------------|-------------------|
    | layer2 |  4.0	     |  5.0        |  =layer1!output#  |

#### Activation Functions

**Inputs:**
1. activation_name: Text
2. inputs: Range

**Output:**
1. output: Range (referenced by activation_name!output#)

**To create an activation function:**
1. Define activation_name in the column A
4. Reference your inputs as a range in column B
5. Copy any activationX sheet and rename it to your activation_name

**Example:**

    | A           |  B                |
    |-------------|-------------------|
	|             |  inputs           |
	|-------------|-------------------|
    | activation1 |  =layer1!output#  |
    

### Special Excel Stuff

Anything out of the ordinary in Excel will be listed below.

#### Ranges

Careful when using Range References. Should you encounter a #SPILL error, if possible add adjacent empty rows or
columns, as there might be a value blocking the output.

**Output:**
1. output: Range (referenced by cell_address#)

**Example:**

    ={1,2,3,2.5;2,5,-1,2;-1.5,2.7,3.3,-0.8}

## Missing Stuff
- Coloration of cells for readable input and output.