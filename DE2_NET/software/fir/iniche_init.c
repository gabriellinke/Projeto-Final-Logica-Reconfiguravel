/******************************************************************************
* Copyright (c) 2006 Altera Corporation, San Jose, California, USA.           *
* All rights reserved. All use of this software and documentation is          *
* subject to the License Agreement located at the end of this file below.     *
*******************************************************************************                                                                             *
* Date - October 24, 2006                                                     *
* Module - iniche_init.c                                                      *
*                                                                             *                                                                             *
******************************************************************************/

/******************************************************************************
 * NicheStack TCP/IP stack initialization and Operating System Start in main()
 * for Simple Socket Server (SSS) example. 
 * 
 * This example demonstrates the use of MicroC/OS-II running on NIOS II.       
 * In addition it is to serve as a good starting point for designs using       
 * MicroC/OS-II and Altera NicheStack TCP/IP Stack - NIOS II Edition.                                                                                           
 *      
 * Please refer to the Altera NicheStack Tutorial documentation for details on 
 * this software example, as well as details on how to configure the NicheStack
 * TCP/IP networking stack and MicroC/OS-II Real-Time Operating System.  
 */
  
#include <stdio.h>
#include <conio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>
#include <io.h>
#include <fcntl.h>
/* MicroC/OS-II definitions */
#include "../fir_bsp/HAL/inc/includes.h"

#include "../fir_bsp/system.h"

#include "dm9000a.h"

/* Simple Socket Server definitions */
#include "simple_socket_server.h"
#include "alt_error_handler.h"

/* Nichestack definitions */
#include "../fir_bsp/iniche/src/h/nios2/ipport.h"
#include "../fir_bsp/iniche/src/h/tcpport.h"
#include "../fir_bsp/iniche/src/h/libport.h"
#include "../fir_bsp/iniche/src/nios2/osport.h"
#include "basic_io.h"
#include "LCD.h"
#include "altera_avalon_pio_regs.h"
/* Definition of task stack for the initial task which will initialize the NicheStack
 * TCP/IP Stack and then initialize the rest of the Simple Socket Server example tasks. 
 */
OS_STK    SSSInitialTaskStk[TASK_STACKSIZE];

/* Declarations for creating a task with TK_NEWTASK.  
 * All tasks which use NicheStack (those that use sockets) must be created this way.
 * TK_OBJECT macro creates the static task object used by NicheStack during operation.
 * TK_ENTRY macro corresponds to the entry point, or defined function name, of the task.
 * inet_taskinfo is the structure used by TK_NEWTASK to create the task.
 */
TK_OBJECT(to_ssstask);
TK_ENTRY(SSSSimpleSocketServerTask);
void disp_7seg(int _duty_cycle, int _prescaler, int _timer, int _enable);
int binaryTodecimal (char num[]);
char *decimal_to_binary(int n);
int str_length( char str[]);

struct inet_taskinfo ssstask = {
      &to_ssstask,
      "simple socket server",
      SSSSimpleSocketServerTask,
      4,
      APP_STACK_SIZE,
};

/* SSSInitialTask will initialize the NicheStack
 * TCP/IP Stack and then initialize the rest of the Simple Socket Server example 
 * RTOS structures and tasks. 
 */
void SSSInitialTask(void *task_data)
{
  INT8U error_code;

  /*
   * Initialize Altera NicheStack TCP/IP Stack - Nios II Edition specific code.
   * NicheStack is initialized from a task, so that RTOS will have started, and
   * I/O drivers are available.  Two tasks are created:
   *    "Inet main"  task with priority 2
   *    "clock tick" task with priority 3
   */
  LCD_Line1();
  LCD_Show_Text("Adquirindo IP");
  LCD_Line2();
  LCD_Show_Text("via DHCP -- PWM");

  alt_iniche_init();
  netmain();

  /* Wait for the network stack to be ready before proceeding.
   * iniche_net_ready indicates that TCP/IP stack is ready, and IP address is obtained.
   */
  while (!iniche_net_ready)
    TK_SLEEP(1);

  /* Now that the stack is running, perform the application initialization steps */

  /* Application Specific Task Launching Code Block Begin */

  printf("\nSimple Socket Server starting up\n");

  /* Create the main simple socket server task. */
  //TK_NEWTASK(&ssstask);

  /*create os data structures */
  //SSSCreateOSDataStructs();

  /* create the other tasks */
  //SSSCreateTasks();

  /* Application Specific Task Launching Code Block End */

  /*This task is deleted because there is no need for it to run again */
  //error_code = OSTaskDel(OS_PRIO_SELF);
  //alt_uCOSIIErrorHandler(error_code, 0);
  LCD_Init();
  int sw, but;
  char ArqI[32] = "ARQ INVALIDO !!!ARQ INVALIDO !!!";
  char p1[16];
  char flag = 0; //0-> escolhendo, 1->scroll
  char lastbut = 0x0F;
  unsigned int linha1=0;
  unsigned int linha2=16;
  char choice = 0;
  struct sockaddr_in sa;
  int res;
  int SocketFD;
  char str_valor_lido[100],lcd_print1[15],lcd_print2[15];
  char buf[2000];
  char *readIO;
  int initial_value, read_IO;
  int duty_cycle, prescaler, timer, enable;
  printf("Inicializacao\n");

  SocketFD = socket(PF_INET, SOCK_STREAM, IPPROTO_TCP);
  printf("Socket criado\n");

  memset(&sa, 0, sizeof sa);
  sa.sin_family = AF_INET;
  sa.sin_port = htons(5000); // ALTERAR PORTA
  res = inet_pton(AF_INET, "192.168.0.210", &sa.sin_addr); //ALTERAR O IP

  if (connect(SocketFD, (struct sockaddr *)&sa, sizeof sa) == -1) {
	perror("connect failed");
	close(SocketFD);
	exit(EXIT_FAILURE);
  }

  duty_cycle = 0;
  prescaler = 0;
  timer = 0;
  enable = 0;

  while (1){

	  if (recv(SocketFD, buf, sizeof(buf), 0) < 0) //recebimento
	  	{
	  		perror("Error - Recv()");
	  		exit(EXIT_FAILURE);
	  	}else{
	  		printf("Msg recebida: %s\n", buf);
	  		memcpy(p1, buf, 16 * sizeof(char));

	  		//enable = ((buf[0] - '0')*10 + (buf[1] - '0'));
	  		//prescaler = ((buf[3] - '0')*10 + (buf[4] - '0'));
	  		//timer = ((buf[6] - '0')*10 + (buf[7] - '0'));
	  		//duty_cycle = ((buf[9] - '0')*10 + (buf[10] - '0'));
	  		//printf("ENABLE DEC: %d\n", enable);
	  		//printf("PRESCALER DEC: %d\n", prescaler);
	  		//printf("TIMER DEC: %d\n", timer);
	  		//printf("DUTY DEC: %d\n", duty_cycle);

	  		printf("MSG BIN: %s\n", buf);
	  		printf("MSG DEC: %d\n", binaryTodecimal(buf));


	  		initial_value = binaryTodecimal(buf);
	  		IOWR(0, 0, initial_value);
	  }

	  	sw = IORD_ALTERA_AVALON_PIO_DATA(SWITCH_PIO_BASE) & 0x03;
		but = IORD_ALTERA_AVALON_PIO_DATA(BUTTON_PIO_BASE) & 0x0F;

		read_IO = IORD(0,0);

		printf("read_IO dec: %d\n", read_IO);

		readIO = decimal_to_binary(read_IO);

		printf("readIO bin: %s\n", readIO);

		char _duty[9], _timer[9], _pres[3], _enable;
//    PADR�O DE MSG ->     0000000000000|1 |00|00011001|00000000|
		_enable = readIO[13];
		strncpy(_pres, &readIO[14], 2);
		strncpy(_timer, &readIO[16], 8);
		strncpy(_duty, &readIO[24], 8);

		_pres[2] = '\0';
		_timer[8] = '\0';
		_duty[8] = '\0';

		//printf("enable bin: %c\n", _enable);
		//printf("pres bin: %s\n", _pres);
		//printf("timer bin: %s\n", _timer);
		//printf("duty bin: %s\n", _duty);

		duty_cycle = binaryTodecimal(_duty);
		prescaler = binaryTodecimal(_pres);
		timer = binaryTodecimal(_timer);

		if(_enable = '1')
			enable = 1;
		else
			enable = 0;

		disp_7seg(duty_cycle, prescaler, timer, enable);

		sprintf(str_valor_lido, "DutyCycle: %02d | Prescaler: %02d | Timer: %02d | Enable: %02d", duty_cycle, prescaler, timer, enable);

		 if (send(SocketFD, str_valor_lido, sizeof(str_valor_lido), 0) < 0) //exemplo de envio
			{
			    perror("Erro de comunicacao - Send()");
			    exit(EXIT_FAILURE);
			}

		  LCD_Line1();
		  LCD_Show_Text("PWM");

		  sprintf(lcd_print1, "DutyCycle: %02d ", duty_cycle);
		  sprintf(lcd_print2, "Prescaler: %02d", prescaler);

		  LCD_Line1();
		  LCD_Show_Text(lcd_print1);

		  LCD_Line2();
		  LCD_Show_Text(lcd_print2);

		  msleep(1000);
  }
}

/* Main creates a single task, SSSInitialTask, and starts task scheduler.
 */

int main (int argc, char* argv[], char* envp[])
{
  
  INT8U error_code;

  DM9000A_INSTANCE( DM9000A_0, dm9000a_0 );
  DM9000A_INIT( DM9000A_0, dm9000a_0 );

  /* Clear the RTOS timer */
  OSTimeSet(0);

  /* SSSInitialTask will initialize the NicheStack
   * TCP/IP Stack and then initialize the rest of the Simple Socket Server example
   * RTOS structures and tasks.
   */
  error_code = OSTaskCreateExt(SSSInitialTask,
                             NULL,
                             (void *)&SSSInitialTaskStk[TASK_STACKSIZE],
                             SSS_INITIAL_TASK_PRIORITY,
                             SSS_INITIAL_TASK_PRIORITY,
                             SSSInitialTaskStk,
                             TASK_STACKSIZE,
                             NULL,
                             0);
  alt_uCOSIIErrorHandler(error_code, 0);

  /*
   * As with all MicroC/OS-II designs, once the initial thread(s) and
   * associated RTOS resources are declared, we start the RTOS. That's it!
   */
  OSStart();
  
  while(1); /* Correct Program Flow never gets here. */

  return -1;
}

int str_length( char str[])
{
   int i = 0;
   while (str[i] != '\0')
       i++;
   return i;
}

int binaryTodecimal (char num[])
{
    int i, deci_num, mul = 0;
    for ( deci_num = 0, i = str_length(num) - 1; i >= 0; --i, ++mul)
    {
            deci_num = deci_num + (num[i] - 48) * (1 << mul);
    }

    return deci_num;
 }

char *decimal_to_binary(int n)
{
  int c, d, t;
  char *p;

  t = 0;
  p = (char*)malloc(32+1);

  if (p == NULL)
    exit(EXIT_FAILURE);

  for (c = 31 ; c >= 0 ; c--)
  {
    d = n >> c;

    if (d & 1)
      *(p+t) = 1 + '0';
    else
      *(p+t) = 0 + '0';

    t++;
  }
  *(p+t) = '\0';

  return  p;
}


void disp_7seg(int _duty_cycle, int _prescaler, int _timer, int _enable){

	int disp1, disp2, disp3, disp4, disp5, disp6, disp7, disp8;

    disp1 = 0;
    disp2 = _duty_cycle;

    disp3 = 0;
    disp4 = _prescaler;

    disp5 = 0;
    disp6 = _timer;

    disp7 = 0;
    disp8 = _enable;

	IOWR_ALTERA_AVALON_PIO_DATA(SEG7_DISPLAY_BASE, ((disp1 << 28) + (disp2 << 24) + (disp3 << 20) + (disp4 << 16) + (disp5 << 12) + (disp6 << 8) + (disp7 << 4) + (disp8 << 0)));

}

/******************************************************************************
*                                                                             *
* License Agreement                                                           *
*                                                                             *
* Copyright (c) 2006 Altera Corporation, San Jose, California, USA.           *
* All rights reserved.                                                        *
*                                                                             *
* Permission is hereby granted, free of charge, to any person obtaining a     *
* copy of this software and associated documentation files (the "Software"),  *
* to deal in the Software without restriction, including without limitation   *
* the rights to use, copy, modify, merge, publish, distribute, sublicense,    *
* and/or sell copies of the Software, and to permit persons to whom the       *
* Software is furnished to do so, subject to the following conditions:        *
*                                                                             *
* The above copyright notice and this permission notice shall be included in  *
* all copies or substantial portions of the Software.                         *
*                                                                             *
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR  *
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,    *
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE *
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER      *
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING     *
* FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER         *
* DEALINGS IN THE SOFTWARE.                                                   *
*                                                                             *
* This agreement shall be governed in all respects by the laws of the State   *
* of California and by the laws of the United States of America.              *
* Altera does not recommend, suggest or require that this reference design    *
* file be used in conjunction or combination with any other product.          *
******************************************************************************/
