# About

```
//================================================================================================//
//------------------------------------------------------------------------------------------------//
//    MPH-I : Moving Particle Hydrodynamics for Incompressible Flows (implicit calculation)       //
//------------------------------------------------------------------------------------------------//
//    Developed by    : Masahiro Kondo                                                            //
//    Distributed in  : 2022                                                                      //
//    Lisence         : GPLv3                                                                     //
//    For instruction : see README                                                                //
//    For theory      : see the following references                                              //
//     [1] CPM 8 (2021) 69-86,       https://doi.org/10.1007/s40571-020-00313-w                   //
//     [2] JSCES Paper No.20210006,  https://doi.org/10.11421/jsces.2021.20210006                 //
//     [3] CPM 9 (2022) 265-276,     https://doi.org/10.1007/s40571-021-00408-y                   //
//     [4] CMAME 385 (2021) 114072,  https://doi.org/10.1016/j.cma.2021.114072                    //
//     [5] JSCES Paper No.20210016,  https://doi.org/10.11421/jsces.2021.20210016                 //
//     [6] CPM (2023),               https://doi.org/10.1007/s40571-023-00636-4                   //
//    (Please cite the references above when you make a publication using this program)           //
//    Copyright (c) 2022                                                                          //
//    Masahiro Kondo & National Institute of Advanced Industrial Science and Technology (AIST)    //
//================================================================================================//
```

This repository contains programs for conducting particle based fluid simulation
using MPH-I (Moving Particle Hydrodynamics for Incompressible) method. 


# Directories
The directories in the repository is as follows:  

```
MphImplicit ---- generator
            |--- results
            |--- results3d
            |--- source

```        

# How to execute samples

1."generator" is for pre-process. To compile it, run
```
> make 
```
in generator directory. (g++ is to be installed)

2."results" contains sample cases for the calculation. 
In a case directory, execute

```
> ./generate.sh
```

The generator will be launched and particles will be generated
reading cubolid file (*.boid).

3."source" contains the main solver for MPH-I calculations. 
To complie it , run

```
> make 
```
in the source directory. Then, an executable "MphImplicit", 
which is for 2D single thread calculation, is created with g++. 

4.Then, back to the case directory, and launch

```
> ./execute.sh
```
Make sure that the execute.sh points the correct executable. 

The solver starts with reading parameter file (*.data) 
and particle file (*.grid). 
The series of calculation results (*.vtk) are output,  
and they can be visualized with a viewer like ParaView. 
(https://www.paraview.org/)


# Using openMP, openACC and CUDA
You may switch the compilation by the targets of "make".
For 3D single thread calculation with g+;
```
> make MphImplicit_3d
``` 
For 2D OpenMP calculation with g++;
```
> make Mph_gcc
``` 
For 3D OpenMP calculation with g++; 
```
> make Mph_gcc3d
``` 
For 2D OpenACC calculation with NVIDIA HPC-SDK;
```
> make Mph_acc
``` 
For 3D OpenACC calculation with NVIDIA HPC-SDK;
```
> make Mph_acc3d
``` 
See "makefile" in detail. 

Instead of switching the target executable as above, 
You may switch the compiler and its options directly. 

For using openMP apply
```
 CC = g++
 CFLAGS  = -O3 -fopenmp 
```
For using openACC apply
```
 CC = pgc++
 CFLAGS  =  -O3 -acc -Minfo=accel  
```

```
 
The solver program has only been tested with 
   g++ 7.5.0.   and   NVIDIA HPC-SDK 21.5 with CUDA version 11.3.
So, they are recomended though compatible versions may work. 


# Generating particles 
Initial particle disturiburion in combination of cuboids 
can be generated by editting the cuboid file (*.boid) and using the generator. 
For distribution including shape other than cuboid, particles 
are to be generated in other way such as making a new program for it.   
  
In the main solver, the particle types are defined as
- 0: fluid 
- 1: fluid
- 2: wall
- 3: wall
Therefore, 2 fluid types and 2 wall types can be used in the solver. 
To change tne number of types, the main solver is to be modified. 

# Changing physical properties 
The physical properties and calculation conditions are given in 
the parameter file (*.data). By editting the file, the physical 
properties can be changed. 


# For 3D calculation 
Particle distribution in 3D can be generated only by editing the 
cuboid file (*.boid) No modification in the generator program is needed. 
In compiling the main solver, 3D executable is generated 
when the macro TWO_DIMENSIONAL is NOT defined, 
which can be controled by the compile option.   
  

# For Truning off Multigrid solver
When you do not want to apply the multigrid preconditioner, 
just comment out the macro MULTIGRID_SOLVER in the main solver. 
Then, the simple CR solver is applied in the calculation.  


