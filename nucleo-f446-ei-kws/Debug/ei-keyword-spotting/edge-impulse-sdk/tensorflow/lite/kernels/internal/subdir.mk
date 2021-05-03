################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (9-2020-q2-update)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CC_SRCS += \
../ei-keyword-spotting/edge-impulse-sdk/tensorflow/lite/kernels/internal/quantization_util.cc 

CC_DEPS += \
./ei-keyword-spotting/edge-impulse-sdk/tensorflow/lite/kernels/internal/quantization_util.d 

OBJS += \
./ei-keyword-spotting/edge-impulse-sdk/tensorflow/lite/kernels/internal/quantization_util.o 


# Each subdirectory must supply rules for building sources it contributes
ei-keyword-spotting/edge-impulse-sdk/tensorflow/lite/kernels/internal/quantization_util.o: ../ei-keyword-spotting/edge-impulse-sdk/tensorflow/lite/kernels/internal/quantization_util.cc ei-keyword-spotting/edge-impulse-sdk/tensorflow/lite/kernels/internal/subdir.mk
	arm-none-eabi-g++ "$<" -mcpu=cortex-m4 -std=gnu++14 -g3 -DDEBUG -DUSE_HAL_DRIVER -DSTM32F446xx -c -I../Core/Inc -I../Drivers/STM32F4xx_HAL_Driver/Inc -I../Drivers/STM32F4xx_HAL_Driver/Inc/Legacy -I../Drivers/CMSIS/Device/ST/STM32F4xx/Include -I../Drivers/CMSIS/Include -I"C:/Users/Shung Mun/Documents/STM_proj/nucleo-f446-ei-kws/ei-keyword-spotting" -I"C:/Users/Shung Mun/Documents/STM_proj/nucleo-f446-ei-kws/ei-keyword-spotting/edge-impulse-sdk/third_party/flatbuffers/include" -I"C:/Users/Shung Mun/Documents/STM_proj/nucleo-f446-ei-kws/ei-keyword-spotting/edge-impulse-sdk/third_party/gemmlowp" -I"C:/Users/Shung Mun/Documents/STM_proj/nucleo-f446-ei-kws/ei-keyword-spotting/edge-impulse-sdk" -I"C:/Users/Shung Mun/Documents/STM_proj/nucleo-f446-ei-kws/ei-keyword-spotting/edge-impulse-sdk/third_party/ruy" -I"C:/Users/Shung Mun/Documents/STM_proj/nucleo-f446-ei-kws/ei-keyword-spotting/edge-impulse-sdk/CMSIS/DSP/Include" -I"C:/Users/Shung Mun/Documents/STM_proj/nucleo-f446-ei-kws/ei-keyword-spotting/edge-impulse-sdk/CMSIS/DSP/PrivateInclude" -I"C:/Users/Shung Mun/Documents/STM_proj/nucleo-f446-ei-kws/ei-keyword-spotting/edge-impulse-sdk/classifier" -I"C:/Users/Shung Mun/Documents/STM_proj/nucleo-f446-ei-kws/ei-keyword-spotting/edge-impulse-sdk/CMSIS/NN/Include" -O0 -ffunction-sections -fdata-sections -fno-exceptions -fno-rtti -fno-use-cxa-atexit -Wall -fstack-usage -MMD -MP -MF"ei-keyword-spotting/edge-impulse-sdk/tensorflow/lite/kernels/internal/quantization_util.d" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"

