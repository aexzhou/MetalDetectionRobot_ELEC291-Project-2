# Metal Detecting Robot

**ELEC 291 202, Jesus Calvino-Fraga**  

**Group B5**

## Member List
Brandon Cheong, Joe Graham, Baneesh Khosa, Alexanna Lavoie, Hrudai Rajesh, Alex Zhou

---

## Table of Contents
- [Metal Detecting Robot](#metal-detecting-robot)
  - [Member List](#member-list)
  - [Table of Contents](#table-of-contents)
  - [Introduction](#introduction)
    - [Controller](#controller)
    - [Robot](#robot)
  - [Investigation](#investigation)
    - [Idea Generation](#idea-generation)
    - [Investigation Design](#investigation-design)
    - [Data Collection](#data-collection)
    - [Data Synthesis](#data-synthesis)
    - [Analysis of Results](#analysis-of-results)
  - [Design](#design)
    - [Use of Process](#use-of-process)
    - [Need and Constraint Identification](#need-and-constraint-identification)
    - [Problem Specification](#problem-specification)
    - [Solution Generation](#solution-generation)
    - [Solution Evaluation](#solution-evaluation)
    - [Detailed Design](#detailed-design)
    - [Solution Assessment](#solution-assessment)
  - [Life-Long Learning](#life-long-learning)
  - [Conclusion](#conclusion)
  - [References](#references)
  - [Bibliography](#bibliography)

---

## Introduction

The primary objective of this project is to develop a remote controller and a remote-controlled metal detecting robot. Key specifications include:

- Use two separate microprocessor architectures for the controller and robot  
- Have both the controller and robot operate completely on battery power  
- Wirelessly communicate between the controller and robot using a JDY-40 chip (or otherwise)  
- Capability to detect coins as small as a dime, with a buzzer running on the controller when metal is detected by the robot  
- Incorporation of calibration on the remote interface as well as the robot interface  
- Robot must be able to be precisely driven in patterns such as a square or figure-eight  
- User interface and display using an LCD and joystick

The design approach was divided into two main components: the **controller team** and the **robot team**, each with its own system block diagram to illustrate the system’s architecture.

### Controller

Central to the controller was the microprocessor unit **EFM8LB1** [2]. The hardware of the controller interfaces with:

- **Communication**: JDY-40 transmits and receives data via UART to the robot  
- **LCD Display**: Displays key metrics such as frequency readings and controller status  
- **Alarm**: Buzzer module beeps with an interval increasing with proximity to metal  
- **Power Supply**: Ensures stable power to the system through a 9V battery

The software end of the controller incorporates:

- Encoding/decoding messaging to the robot through the JDY-40  
- A protocol to increase buzzer frequency with a change of inductance on the robot end  
- Two joysticks for coarse and fine controls of the robot, using the JDY-40 to transmit signals

![][image1] 

*Figure 1: Controller Block Diagram*  

### Robot

The robot was built using the **STM32** microprocessor [1]. The hardware of the robot interfaces with the following:

- **JDY-40** wireless communication chip  
- **Optocoupler** for motor control and voltage isolation  
- **Colpitts oscillator** to produce an oscillating circuit with the inductor

![][image2] 

*Figure 2: Robot Block Diagram*  

On the software end, the robot incorporated the following:

- Error detection and rejection for wireless communication  
- Message encoding and decoding for input/output signals from the JDY-40  
- Pulse-Width Modulation (PWM) control to modulate the speed of each motor through the optocoupler  
- Frequency change detection of the Colpitts oscillator to indicate the detection of metal  

---

## Investigation 

### Idea Generation

We started our project by first ensuring that all members of our group had an appropriate understanding of the project requirements and goals. After this, we subdivided into two groups, one for the controller and one for the robot. The first task was to construct our robot and controller. The robot was straightforward since instructions were provided, and the controller only required us to learn how to use the joystick. From previous labs, we had gained familiarity with most of the required components. To ensure effective cooperation, we formulated a data format for UART communication between the two devices before integrating the remaining hardware.

### Investigation Design 

In the initial phase of our project, we conducted an exhaustive review of the documentation to align our team's understanding with the defined specifications. Our strategic roadmap emerged from this foundation.

Our initial and primary focus was the **optimization of wireless communication**. We knew from third-year students and TAs that interference and errors were common. We developed an encoding/decoding algorithm with error detection to combat noise. After several attempts, we settled on sending integers padded with spaces at the beginning—ensuring that noise, which mostly occurred at the start of the signal, would interfere with “useless” padding bits rather than critical data.

Beyond wireless communication, our hardware efforts were extensive. On the robot side, we focused on developing the optocoupler circuit for motor control. Concurrently, we evaluated potential enhancements to enrich the user experience, leading to various additional functionalities. This analytical approach allowed us to meticulously refine our system while expanding our knowledge in electronic circuit design and optimization.

### Data Collection

To enhance metal detection, we ran tests to determine the ideal capacitance and inductance for an effective frequency reading. Various capacitor combinations and inductor coil turns were explored, and the final frequency readings were integrated into the software so that the controller’s buzzer would emit increasingly higher frequencies upon detecting more metal. Below is an illustrative circuit used in this process:

![][image3]  

*Figure 3: Frequency Circuit*

We also collected data to **calibrate the joysticks** on the controller side. Each joystick’s x and y voltages map to the robot's movement. We conducted various trials to determine calibration methods and to ensure signal integrity. Key steps included setting a unique device ID, baud rate, and other parameters for robust data transmission.

### Data Synthesis

Next, we synthesized these data to refine system performance and ensure smooth integration between controller and robot. By analyzing joystick voltage readings, we optimized controller responsiveness, ensuring that user inputs translated accurately into intended robot movements.

Simultaneously, we correlated metal detection frequency changes with the buzzer frequency on the controller. This refined the metal detection mechanism, ensuring sensitivity and accuracy—even for minimal metal proximity. We also honed our wireless communication by analyzing transmission error rates, encoding schemes, and space-padding for error rejection.

Ultimately, this synthesis confirmed the effectiveness of individual components and provided insights into subsystem interdependencies, enabling informed design adjustments to enhance overall performance.

### Analysis of Results

To assess the validity of our results, we identified potential sources of systematic and random error. Systematic errors often arose from software bugs, calculation mistakes, or methodological flaws. Random errors largely originated from component tolerances. For instance, at one point, inaccurate readings persisted despite multiple recalibrations. After testing different gains, we discovered a resistor had a value far from its labeled resistance, leading to consistent offset. This unexpectedly validated our precision—even if our values were occasionally skewed.

---

## Design 

### Use of Process 

Our design process was systematic. We began with collaborative brainstorming, then divided tasks among team members to ensure efficiency. Each member researched and designed a project component. Afterwards, we integrated individual modules into the final design. Multiple iterative refinements allowed cohesive integration of components.

### Need and Constraint Identification 

We brainstormed what constitutes a poor user experience, then compared our resources against an ideal controller design, avoiding clutter, bloat, convoluted inputs, and inconsistency. On the robot end, various components (optocoupler, H-bridge, frequency circuit, microcontroller interface) had to fit on a single breadboard.

To maintain a tidy layout and simplify debugging, we optimized and color-coded wiring, routing it away from 9V and 6V power supplies to prevent interference. For fast wireless communication, we decided on a **single-integer encoding** strategy, transmitting compact data for each motor.

### Problem Specification 

Our primary focus was creating a user-friendly interface and easy interaction. On the controller end, we used an LCD display and two joysticks (coarse and fine movement). Pressing the joysticks down for 3 seconds triggers calibration. On the robot end, frequent re-calibration ensures accurate metal detection; without it, the buzzer might trigger randomly.

### Solution Generation 

We explored multiple UI concepts. A single joystick was insufficient for full directional control, prompting us to consider both coarse and fine adjustments for complex patterns like squares and figure-eights. This required a robust wireless encoding scheme. Eventually, we chose a **streamlined single-integer encoding** system for simplicity and speed. Hardware-wise, we identified the optimal capacitor values and coil windings for the LC oscillator.

### Solution Evaluation 

Incorporating fine and coarse controls simplified tasks like drawing a straight line and a figure-eight. Two joysticks also improved overall user comfort. Our single-integer encoding outperformed other schemes in speed and reliability for data transmission. We represented metal detection strength on the LCD (levels 0–4) and incremented by 1 for every 200 increments in frequency. This was sensitive enough to detect small objects (e.g., dimes) yet stable enough to filter noise.

### Detailed Design 

We split into two main groups: **controller** and **robot**, each subdivided further. Controller sub-teams handled hardware and wireless communication, then LCD and buzzer functionality. Robot sub-teams tackled physical construction, circuitry and breadboarding, followed by wireless communication and metal detection.

1. **Controller Hardware and User Input**  
    ![][image4] 

   - *Figure 4: Controller with dual-joystick setup* 
  
    ![][image5] 

   - *Figure 5: Controller system block diagram*  

   Our controller’s layout draws inspiration from common gaming controllers (e.g., PlayStation DualShock) to maximize ergonomics. The left joystick provides coarse control (0–80%), and the right joystick provides fine control (0–20%). Both joysticks read x-y voltages, mapped to cartesian coordinates, and send binary motor commands to the robot via JDY-40. The LCD and buzzer display and audibly indicate metal-detection strength (1–4). A second EFM8 controller supports music playback via an external memory interface.

2. **Robot Hardware**  

    ![][image8] 

   - *Figure 8: Robot Breadboard on the Robot*  

   The robot features:
   - **STM32** chip  
   - **JDY-40** transceiver  
   - **Optocoupler** circuit and **H-bridge** for motor control  
   - **Colpitts oscillator** circuit for metal detection  

   We carefully arranged these on a single breadboard, using large jumper wires for key connections (PWM, JDY-40 I/O, power). The motors needed lubrication to avoid high current draw. We ensured independent grounds and correctly routed power for the 3.3V logic (STM32, JDY-40) and 5V for the oscillator.

3. **Transmitter Software (Controller)**  
    ![][image6] 

   - *Figure 6: Block diagram for Controller*  

    ![][image7]

   - *Figure 7: Controller functionality*  

   The main software program initializes:
   - **UART** communication  
   - **ADC** for joystick inputs  
   - **LCD** in 4-bit mode  

   Joystick voltages are polled continuously, scaled for coarse/fine controls, and summed. Data transmission occurs via buffers and functions like `sendstr1` and `getstr`. Frequency data returned from the robot is displayed on the LCD and tied to the buzzer frequency. A timeout mechanism handles communication responsiveness.

4. **Robot Software**  
   The STM32 receiver code uses a 20-element buffer array to store incoming PWM data. Timer 2 and ISRs manage interrupt-driven decoding. A `char2int` function parses single-digit integers for each motor (0–9). Values 0–4 indicate backward movement, 5–9 forward, and 5 alone indicates no movement. The **Colpitts oscillator** frequency is measured via `GetPeriod`, then transmitted back to the controller. The robot uses four PWM outputs (two per motor) for full directional control.

### Solution Assessment 

We stress-tested wireless communication in high-interference areas (e.g., the lab) to confirm resilience. Next, we tested metal detection sensitivity (down to a dime). We then tested both features simultaneously to ensure interrupts and timers didn’t compromise communication. Reducing transmitted data to two single-digit integers mitigated interrupt-induced data loss. Finally, we transitioned from USB to battery power and verified key voltage nodes with a multimeter, confirming consistent performance.

---

## Life-Long Learning 

Other courses such as **ELEC 201**, **ELEC 211**, and **ELEC 221** provided valuable background throughout the project. For instance:
- **ELEC 201** insights on capacitors explained unexpected motor movement due to capacitor discharge.  
- **ELEC 221** underpinned our understanding of signals and wireless communication.  
- **ELEC 211** covered electromagnetics, crucial for optimizing the metal detector’s oscillator circuit.  

We also filled knowledge gaps on H-bridges, enabling forward and reverse motor control, and gained experience with serial communication via JDY-40. By adding a speaker to the controller, we explored memory storage and access with the **25Q32** [4].

---

## Conclusion 

Over 100 hours went into designing this metal-detecting robot, complete with robust features. Our primary challenge was unreliable multi-digit data transmission, resolved by single-digit encoding. We also struggled initially with insufficient frequency change to detect small coins, which we overcame by using smaller capacitors in the Colpitts oscillator.

Our final design:
- **Precisely detects** metal ranging from a small dime to a stack of coins.  
- Uses **wireless communication** to relay oscillator frequency to the controller, driving the **buzzer** and **LCD**.  
- Features **ergonomic joysticks** for coarse and fine robot control via two servo motors, synchronized with PWM signals.  
- Supports **customization**, including a speaker capable of playing songs stored in external memory.

We believe this design demonstrates intricate features and an innovative approach, leading to high user satisfaction.

---

## References 

[1] STMicroelectronics, “STM32L051x6 STM32L051x8 Access line ultra-low-power 32-bit MCU Arm®-based Cortex®-M0+, up to 64 KB Flash, 8 KB SRAM, 2 KB EEPROM, ADC”, STM32L051x6 STM32L051x8 datasheet, Oct. 2019.

[2] Silicon Laboratories, “EFM8 Laser Bee Family EFM8LB1 Data Sheet,” EFM8LB1 datasheet, Jan. 2012.

[3] Texas Instruments, “LM386 Low Voltage Audio Power Amplifier,” LM386 datasheet, May 2004 [Revised Aug. 2023].

[4] Winbond, “8M-BIT, 16M-BIT AND 32M-BIT SERIAL FLASH MEMORY WITH DUAL AND QUAD SPI,” 25Q32 datasheet.  

[5] Winbond, “LM386 Low Voltage Audio Power Amplifier,” LM386 datasheet, Sept. 2007.

---

## Bibliography

J. Calvino-Fraga. *ELEC 291: Class Lecture, Topic: “Project 2: Metal Detecting Robot”*, Electrical and Computer Engineering, University of British Columbia, Vancouver, BC, March 15, 2024.

---

<!-- Image references (placeholders). Add actual image URLs or relative paths in your repository. -->
[image1]: Figures/image1.png
[image2]: Figures/image2.png
[image3]: Figures/image3.png
[image4]: Figures/image4.jpg
[image5]: Figures/image5.png
[image6]: Figures/image6.png
[image7]: Figures/image7.png
[image8]: Figures/image8.jpg

