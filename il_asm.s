

.code 16                    @ This directive selects the instruction set being generated.
                            @ The value 16 selects Thumb, with the value 32 selecting ARM.
.text                       @ Tell the assembler that the upcoming section is to be considered
                            @ assembly language instructions - Code section (text -> ROM) 

@@ Function Header Block 

.align 2                    @ Code alignment - 2^n alignment (n=2)
                            @ This causes the assembler to use 4 byte alignment
.syntax unified             @ Sets the instruction set to the new unified ARM + THUMB
                            @ instructions. The default is divided (separate instruction sets)
.global add_test            @ Make the symbol name for the function visible to the linker
.code 16                    @ 16bit THUMB code (BOTH .code and .thumb_func are required)
.thumb_func                 @ Specifies that the following symbol is the name of a THUMB 

.type add_test, %function   @ Declares that the symbol is a function (not strictly required)  





.global ilGame              @ Make the symbol name for the function visible to the linker
.code 16                    @ 16bit THUMB code (BOTH .code and .thumb_func are required)
.thumb_func  
                            @ encoded function. Necessary for interlinking between ARM and THUMB code.

.type ilGame, %function     @ Declares that the symbol is a function (not strictly required) 
 

.align 2                    @ Code alignment - 2^n alignment (n=2)
                            @ This causes the assembler to use 4 byte alignment
.syntax unified             @ Sets the instruction set to the new unified ARM + THUMB
.global ilTilt              @ Make the symbol name for the function visible to the linker
.code 16                    @ 16bit THUMB code (BOTH .code and .thumb_func are required)
.thumb_func  
                            @ encoded function. Necessary for interlinking between ARM and THUMB code.

.type ilTilt, %function     @ Declares that the symbol is a function (not strictly required) 



.global il_led_demo_a2      @ Make the symbol name for the function visible to the linker
.code 16                    @ 16bit THUMB code (BOTH .code and .thumb_func are required)
.thumb_func  
                            @ encoded function. Necessary for interlinking between ARM and THUMB code.

.type il_led_demo_a2, %function @ Declares that the symbol is a function (not strictly required) 
 




.align 2                    @ Code alignment - 2^n alignment (n=2)
                            @ This causes the assembler to use 4 byte alignment
.syntax unified             @ Sets the instruction set to the new unified ARM + THUMB
                            @ instructions. The default is divided (separate instruction sets)
.global _il_lab_tick      @ Make the symbol name for the function visible to the linker
.code 16                    @ 16bit THUMB code (BOTH .code and .thumb_func are required)
.thumb_func  
                            @ encoded function. Necessary for interlinking between ARM and THUMB code.

.type _il_lab_tick, %function @ Declares that the symbol is a function (not strictly required)  



.align 2                    @ Code alignment - 2^n alignment (n=2)
                            @ This causes the assembler to use 4 byte alignment
.syntax unified             @ Sets the instruction set to the new unified ARM + THUMB
                            @ instructions. The default is divided (separate instruction sets)
.global _il_watchdog_start      @ Make the symbol name for the function visible to the linker
.code 16                    @ 16bit THUMB code (BOTH .code and .thumb_func are required)
.thumb_func  
                            @ encoded function. Necessary for interlinking between ARM and THUMB code.

.type _il_watchdog_start, %function @ Declares that the symbol is a function (not strictly required) 







    .code 16                    @ 16bit THUMB code (BOTH .code and .thumb_func are required)
    .text 
                            @ encoded function. Necessary for interlinking between ARM and THUMB code.
.global ticks_test      @ Make the symbol name for the function visible to the linker
.type ticks_test, %function @ Declares that the symbol is a function (not strictly required)


 



LEDaddress: .word 0x48001014


_il_watchdog_start:  
    push {r4-r7, lr} 
    @ mov   r4, r0    @ timeout 
    @ mov   r5, r1    @ delay 
    @ mov   r7, #0    @ LED start 
    @ mov   r6, #8    @ LED finish 
    

    myloop: 
    mov r0, r7 
    bl   BSP_LED_Toggle  

    mov  r0, r5
    bl   busy_delay

    mov r0, r7 
    bl   BSP_LED_Toggle  

    mov  r0, r5
    bl   busy_delay
    
    add r7, r7, #1 
    sub r6, r6, #1
                    
    cmp r6, #0 
    bgt loop  
    

    

    pop  {r4-r7, lr}    

    bx lr   




@ Function Declaration : int il_led_demo_a2(int count, int delay)
@
@ Input: r0, r1 (i.e. r0 holds count, r1 holds delay)
@
il_led_demo_a2:   
    push {r4-r7, lr} 
    mov r4, r0      @ count 
    mov r5, r1      @ delay 
    mov r6, #8      @ full loop 
    mov r7, #0      @ led 

@ Function Declaration : loop 
@
@ Description: Works as loop and fixes delay 
@
loop:  
    mov r0, r7 
    bl   BSP_LED_Toggle  

    mov  r0, r5
    bl   busy_delay 

    mov r0, r7 
    bl   BSP_LED_Toggle  

    mov  r0, r5
    bl   busy_delay
    
    add r7, r7, #1 
    sub r6, r6, #1
                    
    cmp r6, #0 
    bgt loop  
 
    sub r4, r4, #1 
    mov r7, #0 
    mov r6, #0 


    cmp r4, r0  
    bgt loop 

    pop  {r4-r7, lr}    

    bx lr 
  
    
    

@ Function Declaration : ilGame 
@
@ Parameters: count, delay and pattern 
@
 


 ilGame: 
    push {r4-r10, lr}   @ Saving register values for delay, pattern, target.
    mov r4, r0          @ Move our delay value to r4 
    mov r5, r1          @ Move our pattern value to r5 
    mov r6, r2          @ Move our target value to r6   
    mov r7, #0x30



ledlight_loop:  

    ldrb r8, [r5]            @ load the pattern on r8
    sub  r9, r8, r7          @ converting the number from ASCII to decimal   

    
    mov  r0, r9              @ Moving r9 back to r0 for pattern   
    bl   BSP_LED_Toggle   

    mov  r0, r4              @ Moving delay back to r0 
    bl   busy_delay  


    
    mov  r0, r9              @ Moving r9 back to r0 for pattern
    bl   BSP_LED_Toggle  

    mov  r0, r4              @ Moving delay back to r0 
    bl   busy_delay  


    mov  r0, r9              @ Moving r9 back to r0 for pattern
    bl   BSP_LED_Toggle  

    mov  r0, r4              @ Moving delay back to r0 
    bl   busy_delay  
    

    mov  r0, r9              @ Moving r9 back to r0 for pattern
    bl   BSP_LED_Toggle  

    mov  r0, r4              @ Moving delay back to r0 
    bl   busy_delay   

    
    
    
        

    cmp r8, #0               @ Compare to see if string is empty  
    add r5, r5, #1           @ increase pattern by 1 to move to the next light   
    bgt ledlight_loop        @ If no then continue  

    cmp r10, #5              @ reset the values for infiniue
    mov r9, r5 
    mov r8, #0
    bne ledlight_loop

    

    pop  {r4-r10, lr}     
    bx lr  
    

a4_ticks: .word 0 
a4_ticks_to_blink: .word 0 

ticks_test: 

    ldr r1, =a4_ticks 
    str r0, [r1]  
    bx lr 
_il_lab_tick: 
    push {lr} 

    
    ldr r1, =a4_ticks 
    ldr r0, [r1] 
    subs r0, r0, #1 

    ble do_nothing 

    str r0, [r1]

    ldr r1, =a4_ticks_to_blink
    ldr r0, [r1] 
    subs r0,r0, #1  

    str r0, [r1] 

    bgt do_nothing   

    mov r0, #0 
    bl BSP_LED_Toggle 

    ldr r1, =a4_ticks_to_blink 
    mov r0, #500 
    str r0,[r1]

     
    do_nothing:  

    pop {lr} 
    bx lr  

    .size _il_lab_tick, .-_il_lab_tick 





.equ Y_HI, 0x2B 
.equ X_HI, 0x29  
.equ X_LO, 0x28 
.equ I2C_Address, 0x32 

ilTilt: 
    push {lr}  
 
    mov r4, r0  

    mov r0, r4
    bl busy_delay 
    

    mov r0, #I2C_Address 
    mov r1, #X_HI
    bl COMPASSACCELERO_IO_Read
     
    sxtb r0, r0  
    mov r5, r0 @X


    mov r0, #I2C_Address  
    mov r1, #Y_HI 
    bl COMPASSACCELERO_IO_Read

    sxtb r0, r0  
    mov r6, r0  @Y

    

    pop {lr}
    bx lr   

    .size ilTilt, .-ilTilt  
 



 x_y_toled:  
    push {lr}
    mov r4, r0  @ X
    mov r5, r1  @ Y  
 
    
    cmp r5, #-64  
    bgt led_7  
    cmp r4, #0
    beq led_7


    cmp r4, #32
    bgt led_6 
    cmp r5, #-32  
    bgt led_6  
    pop {lr} 
    bx lr       



    cmp r4, #-32
    bgt led_5 
    cmp r5, #-32  
    bgt led_5 
    pop {lr} 
    bx lr 

    cmp r5, #0  
    beq led_4  
    cmp r4, #64 
    bgt led_4 

    cmp r5, #0  
    beq led_3  
    cmp r4, #-64
    bgt led_3 


    cmp r4, #32
    bgt led_2 
    cmp r5, #32  
    bgt led_2   

    cmp r4, #-32
    blt led_1
    cmp r5, #32  
    bgt led_1  

    
    cmp r5, #64  
    bgt led_0  
    cmp r4, #0
    beq led_0 



    

    


led_7: 
    mov r0, #7 
    bx lr 

led_6: 
    mov r0, #6 
    bx lr 

led_5:
    mov r0, #5 
    bx lr 

led_4: 
    mov r0, #4 
    bx lr 

led_3: 
    mov r0, #3 
    bx lr  

led_2: 
    mov r0, #2  
    bx lr 

led_1: 
    mov r0, #1 
    bx lr 

led_0: 
    mov r0, #0
    bx lr




@ Function Declaration : int add_test(int x, int y)
@
@ Input: r0, r1 (i.e. r0 holds x, r1 holds y)
@ Returns: r0
@
@ Here is the actual add_test function 
add_test: 
    push {lr}                @ Put aside registers we want to restore later

    mov  r0, #1              @ r0 holds our argument for the LED toggle function
                             @ So pass it a value

    bl   BSP_LED_Toggle      @ call BSP C function using Branch with Link (bl) 
    ldr  r1, =myTickCount
    ldr  r0, [r1]
    
    pop  {lr}                @ Bring all the register values back

    bx lr    

    add r0, r0, r1
    bx lr 
    .size add_test, .-add_test  

busy_delay:
    push {r5}
    mov r5, r0 

delay_1oop:
    subs r5, r5, #1
    bge delay_1oop
    mov r0, #0                @ Return zero (success)
    pop {r5}
    bx lr                     @ Return (Branch eXchange) to the address in the link register (lr) 

.size  il_led_demo_a2, .-il_led_demo_a2 
.end