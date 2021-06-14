# STM32-Keyword-Spotting-with-Edge-Impulse #
# Overview #

This repository records the steps of attempt in making a keyword spotting project using machine learning. In this project, the machine learning model is trained using the Edge Implulse platfrom. STM32Cube is used to compile the code and build the porject into a STM32 board. 

## Materials ##
The hardware used in this project are as follow:
  - Nucleo F446RE Board
  - Breadboard
  - I2S microphone (INMP441/ Adafruit MAX9814)
  - I2S audio amplifier (MAX98357)
  - 1602 16x2 character LCD display
  - M-to-M wires
  - M-to-F wires
  - F-to-F wires 
  - LED 

## Setup Project ##
A new project is created in the STM32Cube IDE. At the setup page, **NUCLEO-F44GRE** is chosen in the board selector tab. The targeted language is **C++** as some library are not available in **C**. Let all peripherals to initialize in their default state. At the configuration pane, the **CRC** feature at the *Computing* tab is activated so that word classifying can be carried out.

![crc](https://github.com/smlee00/STM32-Keyword-Spotting-with-Edge-Impulse/blob/main/Images/13.png)

Next, the USART is configured with the parameters below to allows the communication with serial monitor such as PuTTy to monitor the output of the project.
![usart](https://github.com/smlee00/STM32-Keyword-Spotting-with-Edge-Impulse/blob/main/Images/17.png)

## Setting up Edge Impulse ##

  In this porject, [Edge Impulse](https://studio.edgeimpulse.com/login "Edge Impulse") is used to train our desired model to be integrated into our STM32 project. It is a great platform that allows user to train machine learning model for embedded systems. An account was signed up and a project is created. 
  
![ei_project](https://github.com/smlee00/STM32-Keyword-Spotting-with-Edge-Impulse/blob/main/Images/2.png)
 
  In the *Keys* tab in the dashboard, the API key of our project can be obtained. This API is used for uploading of the training data to Edge Impulse.

![API key](https://github.com/smlee00/STM32-Keyword-Spotting-with-Edge-Impulse/blob/main/Images/1.png)

## Data prepareation & Data Curation ##
Data that were used to train the Word Classifying Model were obtained form Google Speech Commands datasheet. This can save a lot of time since a large number of samples are needed if we wanted to train our own keyword. The dataset can be downloaded from [here](http://download.tensorflow.org/data/speech_commands_v0.02.tar.gz).

However, if you desire to create your own data samples, you can store your data following the directory structure below.

```
 |-custom_keywords
 |--keyword_1
 |-----000.wav
 |-----001.wav
 |----- ...
 |--keyword_2
 |-----000.wav
 |-----001.wav
 |----- ...
 |-- ...
```

After having the dataset, data curation is done to 
  1. mix the prepared samples with background noise 
  2. split the data samples into test set and train set
  3. upload into Edge Impulse project
This can be done by using this [Google Colab](https://colab.research.google.com/github/smlee00/STM32-Keyword-Spotting-with-Edge-Impulse/blob/main/ei_audio_dataset_curation.ipynb) file. 

There is another option to record your data directly in Edge Impulse with built in microphone, for more details [this](https://docs.arduino.cc/tutorials/nano-33-ble-sense/edge-impulse) can be your reference. 

In the colab file, the API key of project(mentioned above) is added so that the data can be populated into Edge Impulse.
![api_key](https://github.com/smlee00/STM32-Keyword-Spotting-with-Edge-Impulse/blob/main/Images/5.png)

Data can be viewed in Edge Impulse after uploading.
![data](https://github.com/smlee00/STM32-Keyword-Spotting-with-Edge-Impulse/blob/main/Images/7.png)

## Feature Extraction & Model Training ##

After uploading training data to Edge Impulse, the next step is to create impulse. The impulse determines how the model will be trained. For this project, **Audio (MFCC)** is added as the processing block and **Neural Network (Keras)** is added as the learning block. All settings are remained as default. 

![create_impulse](https://github.com/smlee00/STM32-Keyword-Spotting-with-Edge-Impulse/blob/main/Images/8.png)

Next, we proceed to the **MFCC** tab. At the *Generate Features*, the data uploaded is processed and features are generated in the form of MFCC (Mel Frequency Cepstral Coefficient). This features is fed to the neural network to train our model. After the processing job completed the features can be visualised in graphical form. 

![mfcc](https://github.com/smlee00/STM32-Keyword-Spotting-with-Edge-Impulse/blob/main/Images/9.png)

Next, the model is trained at the **NN Classifier** tab. In our project, the training setting is kept at default but the neural network architecture is adjusted as we are trying to detect 4 keywors. We used a 3 layer **1D convolutional** neural network with 16, 16 and 32 neurons for respective layer. A dropout of 0.25 is applied after each layer for better training efficiency. After the training process, a confusion matrix is obtained to show the performance of trained model.

![nn_architecture](https://github.com/smlee00/STM32-Keyword-Spotting-with-Edge-Impulse/blob/main/Images/10.png) 
![confusion_m](https://github.com/smlee00/STM32-Keyword-Spotting-with-Edge-Impulse/blob/main/Images/11.png)

To export the model, we go to the testing and deployment tab. As we are using STM32 Nucleo board, the **C++** library option are chosen. Edge Impulse will compile the C++ library based on TensorflowLite and our model.

![deplou](https://github.com/smlee00/STM32-Keyword-Spotting-with-Edge-Impulse/blob/main/Images/12.png)

## Integrating into STM project ##

### Adding Edge Impulse Library ###
After obtaining the compiled files from Edge Impulse, the next thing to do is include it inside our STM32 project. The downloaded file is unzipped, and the directory structure is shown as below:
```
|- <edge-impulse-project-name>
|--- edge-impulse-sdk 
|----- ...
|--- model-parameters
|----- dsp_blocks.h 
|----- model_metadata.h 
|--- tflite-model
|----- trained_model_compiled.cpp 
|----- trained_model_compiled.h 
```
The **edge-impulse-sdk** contains all libraries needed to run inference, **model-parameters** contains the dsp data and nueral network model while **tflite-model** contains the model in byte array and the supporting function needed. In the **edege-impulse-sdk**, the libaries compiled by Edge Impulse is to accomodate general boards. We would need to delete some files to make the library specific to our project. These files are:

- edge-impulse-sdk/utensor (uTensor is an alternative to TensorFlow Lite)
- edge-impulse-sdk/tensorflow/lite/micro/testing (the testing directory contains test code that should not be compiled)
- all *but* stm32-cubeai folder in edge-impulse-sdk/porting (keep the porting folder for STM32 microcontroller family)
- ei_run_classifier_c.cpp and ei_run_classifier_c.h in edge-impulse-sdk/classifier (will cause compilation error)

Next, go to *Project > Properties > C/C++ General > Paths and Symbols* and the paths to Edge Impulse library are added. After adding this, we are ready to integrate the word classifier in the main code. 
![path](https://github.com/smlee00/STM32-Keyword-Spotting-with-Edge-Impulse/blob/main/Images/14.png)

To run the classifier, we include the header file of the word classifier in the main.cpp. The header file can be found in the path *(edge-impulse-project-name)/edge-impulse-sdk/classifier/ei_run_classifier.h*. The main function that we used for do classification is *run_classifier_continuous*. In the main *while* loop, the function is called to run classification continuously.

![run](https://github.com/smlee00/STM32-Keyword-Spotting-with-Edge-Impulse/blob/main/Images/16.png)

### Mic Configuration ###




### Running the project with STM32CubeIDE ###
To run this project, follow the following steps:
1. Download the repository and unzip it. 
2. Select **File > Import..** .
3. Select **Exixting Project into Workspace** and click **Next**. 
4. Select the **nucleo-f446-ei-kws** folder.
5. Enable **Copy projects to Workspace**.
6. Click **Finish**.
You can replace the *ei-keyword-spotting* file with the Edge Impulse library of your own following the instructions [here](#Adding Edge Impulse Library)
section_title<a name="Adding Edge Impulse Library">
  
  Markup : [text goes here](#section_name)
          section_title<a name="section_name"></a>    

