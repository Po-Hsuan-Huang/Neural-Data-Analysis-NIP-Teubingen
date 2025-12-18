 # Neural-Data-Analysis-NIP-Teubingen
 
 This repository contains course material (PDFs) and MATLAB implementations for the *Neural Data Analysis* course (NIP, Tübingen). Each homework folder typically includes:
 
 - **Lecture / task PDFs** (`Lecture*.pdf`, `task*.pdf`)
 - **MATLAB code** (mostly `*.m`)
 - **Reports / figures** (`*.pdf`, `*.fig`, `*.tif`, `*.jpg`, `*.mat`)
 
 ## Requirements
 
 - **MATLAB** (scripts were written for MATLAB; exact version not pinned)
 - **Toolboxes (likely required depending on HW)**
   - Signal Processing Toolbox (e.g., `butter`, `filtfilt`, `gausswin`)
   - Statistics and Machine Learning Toolbox (common for mixture models / fitting)
 
 ## Quick start (MATLAB)
 
 1. Open MATLAB.
 2. Set the current folder to the repository root.
 3. Add subfolders to your path:
 
 ```matlab
 addpath(genpath(pwd));
 ```
 
 4. Run a homework “driver” script (examples below).
 
 ## Repository structure (high level)
 
 - **HW1 Introduction, Spike detection, Feature extraction/**
   - `Task1 Po-Hsuan, Mythreya/` (filtering, spike detection, waveform + feature extraction)
 - **HW2 Spike sorting with Mixture of Gaussians/**
   - `Task2_pohsuan/` (EM for MoG spike sorting, BIC model selection)
 - **HW3 Identifying single neurons (Cross-correlograms, LDA)/**
   - `mythreya Task3/` (waveform plots, cross-correlograms, cluster separation)
 - **HW4 Spike inference from calcium data (Deconvolution)/**
   - `Po-Hsaun Week4/` (simple peak finding + deconvolution prototypes)
 - **HW5 Visualizing and analyzing spike trains 1 (Raster plot, PSTH, Latency)/**
   - `task5/` (rasters, PSTHs, optimal bin width via cost function, linearity index)
 - **HW6 Visualizing and analyzing spike trains 2 (Tuning curves, Correlations)/**
   - `task6/` (tuning significance tests, cosine + von Mises fits)
 - **HW7 Single cell receptive field estimation (STA, STC, LNP-model)/**
   - `task7/` (LNP simulation, RF fitting, space-time separation)
 - **HW8 Analyzing neural populations 1 (Generalized linear models, Ising models)/**
   - `task8/` (GPFA on toy + dataset; includes `gpfa-master/` dependency)
 - **HW9 Analyzing neural populations 2 (Population dynamics, GPFA)/**
   - (lecture PDF only)
 - **WH10 Analyzing neural populations 3 (Decoding)/**
   - `task9-2/` (entropy estimation and estimator comparison)
 
 ## Homework entry points (recommended)
 
 Below are the most “top-level” scripts to run per homework. Many scripts assume data `.mat` files are present in the same folder.
 
 ### HW1: Spike detection / feature extraction
 - **Entry script**: `HW1 Introduction, Spike detection, Feature extraction/Task1 Po-Hsuan, Mythreya/task1.m`
 - **Notes**:
   - Expects a data file `NDA_rawdata.mat` (loaded via `load NDA_rawdata`). This file is **not present** in the repository snapshot.
 
 ### HW2: Spike sorting with Mixture of Gaussians
 - **Entry script**: `HW2 Spike sorting with Mixture of Gaussians/Task2_pohsuan/task2.m`
 - **Notes**:
   - Uses `generate_toy.m` for synthetic data.
   - Later sections call `load('task2_Raw.mat')` which is **not present** in the repository snapshot.
 
 ### HW3: Identifying single neurons (CCGs, clustering diagnostics)
 - **Entry script**: `HW3 Identifying single neurons (Cross-correlograms, LDA)/mythreya Task3/task3.m`
 - **Inputs (present)**:
   - `NDA_task1_results.mat`
   - `NDA_task2_results.mat`
 
 ### HW4: Spike inference from calcium (deconvolution)
 - **Entry script**: `HW4 Spike inference from calcium data (Deconvolution)/Po-Hsaun Week4/task4.m`
 - **Notes**:
   - Expects `TrainingData.mat` (opened via `open('TrainingData.mat')`) which is **not present** in the repository snapshot.
   - Calls `estimateRateFromCa(...)` (make sure this function is on your MATLAB path).
 
 ### HW5: Spike train visualization I (rasters / PSTH / latency)
 - **Entry script**: `HW5 Visualizing and analyzing spike trains 1 (Raster plot, PSTH, Latency)/task5/task4.m`
 - **Inputs (present)**:
   - `NDA_task3_results.mat`
   - `NDA_stimulus.mat`
 
 ### HW6: Spike train visualization II (tuning curves)
 - **Entry script**: `HW6 Visualizing and analyzing spike trains 2 (Tuning curves, Correlations)/task6/task5_new.m`
 - **Inputs (present)**:
   - `NDA_task6_data.mat`
   - `NDA_stimulus.mat`
 
 ### HW7: Single-cell receptive field estimation (LNP)
 - **Entry script**: `HW7 Single cell receptive field estimation (STA, STC, LNP-model)/task7/task7.m`
 - **Inputs (present)**:
   - `rf_data.mat`
 
 ### HW8: Population analysis (GPFA)
 - **Entry script**: `HW8 Analyzing neural populations 1 (Generalized linear models, Ising models)/task8/task8.m`
 - **Dependency**:
   - GPFA implementation is vendored in `HW8 .../task8/gpfa-master/`.
   - If needed, run `HW8 .../task8/gpfa-master/startup.m` or ensure `gpfa-master/` is on the MATLAB path.
 - **Inputs (present)**:
   - `task8_data.mat`
 
 ### WH10: Decoding (entropy estimators)
 - **Entry script**: `WH10 Analyzing neural populations 3 (Decoding)/task9-2/task9.m`
 - **Important note**:
   - `task9-2/startup.m` currently contains an **absolute, machine-specific path**.
   - Recommended workaround: ignore that startup and instead add this repository to your path from MATLAB:
 
 ```matlab
 addpath(genpath(pwd));
 ```
 
 ## Outputs
 
 Most scripts produce figures (`figure(...)`) and some save intermediate results to `*.mat`. Reports are included as PDFs in the corresponding homework folders.
