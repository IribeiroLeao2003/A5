/*
* C to assembler menu hook
*
*/
#include <stdio.h>
#include <stdint.h>
#include <ctype.h>
#include "common.h" 
#include "stm32f3xx_hal.h"
#include "stm32f3_discovery.h"
#include "stm32f3_discovery_accelerometer.h"
#include "stm32f3_discovery_gyroscope.h"   
#include "watchdog.h"
 


int add_test(int x, int y, int delay); 
int il_led_demo_a2(int count, int delay);    
int ilGame(int delay, char *pattern, int target); 
int ticks_test(int time);  
void _il_lab_tick(void);   
int ilTilt(int choice);  
int _il_watchdog_start(int delay); 


/*
* Function Name: _il_A2 
* Paremeters: Action  
* Description: Collects user input and sends to assembly code to verify and do loop 
*/
void _il_A2(int action)
{  
//variables  created
    uint32_t count;
    int fetch_status; 
    uint32_t delay;
    
    //fecthes user input for count 
    fetch_status = fetch_uint32_arg(&count);

    if(fetch_status) {
    // Use a default value
    count = 1;
    } 

    //fetches a user input for delay 
    fetch_status = fetch_uint32_arg(&delay);

    if(fetch_status) {
    // Use a default value
    delay = 0xFFFFFF;
    }
    if(action==CMD_SHORT_HELP) return;
    if(action==CMD_LONG_HELP) {
    printf("Addition Test\n\n"
    "This command tests new addition function\n"
    );
    return;
    }
        printf("add_test returned: %d\n", il_led_demo_a2(count, delay) );
    }
ADD_CMD("add2", _il_A2,"Test the new add2 function");

  







 void gameOn(int action)
{   

//variables  created 
uint32_t target;
int fetch_status; 
uint32_t delay; 
char *pattern; 



//fecthes user input for delay 
fetch_status = fetch_uint32_arg(&delay);

if(fetch_status) {
// Use a default value
delay = 0xFFFFFF;
} 

//fetches a user input for pattern 
fetch_status = fetch_string_arg(&pattern);

if(fetch_status) {
// Use a default value 
pattern = "012345678";
} 

//fecthes user input for target 
fetch_status = fetch_uint32_arg(&target);

if(fetch_status) {
// Use a default value
target = 1; 
} 

if(action==CMD_SHORT_HELP) return;
if(action==CMD_LONG_HELP) {
printf("Game \n\n"
"This command starts a game of blinking lights \n"
);
return;
}    



if(ilGame(delay, pattern, target) == 1){ 
    printf("ilGame returned: You Won"); 
    } else { 
    printf("ilGame returned: You Lost"); 
    } 

}
ADD_CMD("ilGame", gameOn,"Test the new Game function") 
 




void AddTest(int action)
{ 
uint32_t delay;
int fetch_status; 

fetch_status = fetch_uint32_arg(&delay); 

if(fetch_status) {
// Use a default delay value
delay = 0xFFFFFF;
}
// When we call our function, pass the delay value.
// printf(“<<< here is where we call add_test – can you add a third parameter? >>>”); 

if(action==CMD_SHORT_HELP) return;
if(action==CMD_LONG_HELP) {
printf("Addition Test\n\n"
"This command tests new addition function\n"
);
return;
}
printf("add_test returned: %d\n", add_test(99, 87, delay) );
}
ADD_CMD("add", AddTest,"Test the new add function")  



void TicksTest(int action)
{  
if(action==CMD_SHORT_HELP) return;
if(action==CMD_LONG_HELP) {
printf("Tick Test\n\n"
"This command tests new tick test \n"
);
return;
} 


uint32_t user_input; 
int fetch_status; 

fetch_status = fetch_uint32_arg(&user_input); 

if(fetch_status) {

    user_input = 5000;
}


printf("ticks_test returned: %d\n", ticks_test(user_input) );  



}
ADD_CMD("ticktest",TicksTest,"Test the new TicksTest function")  
 





void ilTiltGame(int action)
{  
if(action==CMD_SHORT_HELP) return;
if(action==CMD_LONG_HELP) {
printf("ilTilt\n\n"
"This command tests new tilt game \n"
);
return;
} 


uint32_t user_input; 
int fetch_status; 

fetch_status = fetch_uint32_arg(&user_input); 

if(fetch_status) {

    user_input = 0xFFFFF;
}


for (int i = 0; i < 100; i++){ 
    printf("ilTilt returned: %d\n", ilTilt(user_input) );  
}




}
ADD_CMD("ilTilt",ilTiltGame,"Test the new TicksTest function")    


void testWatchdog(int action)
{  
    mes_InitIWDG(2);   
    mes_IWDGStart(); 
    mes_IWDGRefresh(); 

}
ADD_CMD("watchDogs",testWatchdog,"loool")   
 

/*
* Function Name: _ilWatch 
* Paremeters: Action  
* Description: Collects user input and starts watchdog 
*/
 void _ilWatch(int action)
{  
if(action==CMD_SHORT_HELP) return;
if(action==CMD_LONG_HELP) {
printf("ilWatch\n\n"
"The command tests the new watchdog game \n"
);
return;
} 


uint32_t timeout;  
uint32_t delay;   

int fetch_status; 

fetch_status = fetch_uint32_arg(&delay); 

if(fetch_status) {

    delay = 0xFFFFF;
} 

fetch_status = fetch_uint32_arg(&timeout); 

if(fetch_status) {

    timeout = 500;
}


// calculates reload time 
uint32_t reload = timeout * 32000 / (4 * 36 * 1000) - 1; 
 

 // initializes and starts watchdog 
 mes_InitIWDG(reload); 
 mes_IWDGStart();   
 // infinite loop while calling LED assembly function and refreshing it 
 while(1){ 
    
   _il_watchdog_start(delay);   
    mes_IWDGRefresh(); 
 }   


    
    





}
ADD_CMD("ilWatch",_ilWatch,"Test the new _ilWatch function")  





