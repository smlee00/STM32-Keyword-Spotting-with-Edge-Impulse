# STM32-Keyword-Spotting-with-Edge-Impulse #
# Overview #

This repository records the steps of attempt in making a keyword spotting project using machine learning. In this project, the machine learning model is trained using the Edge Implulse platfrom. STM32Cube is used to compile the code and build the porject into a STM32 board. 

![overview](https://github.com/smlee00/STM32-Keyword-Spotting-with-Edge-Impulse/blob/main/Images/3.png)

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

## Setting up Edge Impulse ##

  In this porject, [Edge Impulse](https://studio.edgeimpulse.com/login "Edge Impulse") is used to train our desired model to be integrated into our STM32 project. It is a great platform that allows user to train machine learning model for embedded systems. An account was signed up and a project is created. 
  
![ei_project](https://github.com/smlee00/STM32-Keyword-Spotting-with-Edge-Impulse/blob/main/Images/2.png)
 
  In the *Keys* tab in the dashboard, the API key of our project can be obtained. This API is used for uploading of the training data to Edge Impulse.

![API key](https://github.com/smlee00/STM32-Keyword-Spotting-with-Edge-Impulse/blob/main/Images/1.png)

## Data prepareation & Data Curation ##
Data that were used to train the Word Classifying Model were obtained form Google Speech Commands datasheet. This can save a lot of time since a large number of samples are needed if we wanted to train our own keyword. The dataset can be downloaded form [here](http://download.tensorflow.org/data/speech_commands_v0.02.tar.gz).

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

## Feature Extraction & Model Training ##

## Integrating into STM project ##

## Mic Configuration ##

## Demo ##

### Running the code with STM32CubeIDE ###
1. Download the repository and unzip it. 
2. Select **File > Import..** .
3. Select **Exixting Project into Workspace** and click **Next**. 
4. Select the unzipped folder.
5. Enable **Copy projects to Workspace**.
6. Click **Finish**.
