<img src="logo.png" width=500>

## Motivation

I love writing [Arduino code for STM32
microcontrollers](https://github.com/stm32duino) but wanted to expand my skill
set to the awesome Rust programming language.  Having looked into [Embedded
Rust](https://docs.rust-embedded.org/book/), I concluded that the  level of
Rust knowledge required was beyond my current ability to understand and modify.
To keep the best of both worlds &ndash; the simplicity of the Arduino approach
and the safety of Rust &ndash; I came up with this minimal example of how you
can call Rust code from an Arduino sketch on an STM32 microcontroller.  

## Example 

The very simple example I am using is adapted from Amir Shrestha's
[blog post](https://amirkoblog.wordpress.com/2018/07/05/calling-rust-code-from-c-c/).
In this example, your Arduino (C++) code calls a Rust function to add two integers
together, and then reports the resulting sum in a loop.

## Requirements

* An STM32Fxx microcontroller

* Linux OS

* [Arduino\_Core\_STM32](https://github.com/stm32duino/Arduino_Core_STM32)

* [Arduino CLI](https://arduino.github.io/arduino-cli/0.31/installation/)





