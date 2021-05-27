#include "DriverJeuLaser.h"
#include <stdio.h>

int DFT_ModuleAuCarre( short int * Signal64ech, char k);

int Transformee[64];
extern short int LeSignal[64];
short int dma_buf[64];
	
void timer_callback(void){
	Start_DMA1(64);
	Wait_On_End_Of_DMA1();
	Stop_DMA1;
	for (int i=0; i<64; i++){
		Transformee[i] = DFT_ModuleAuCarre(dma_buf, i);
	}
}

int main(void)
{

// ===========================================================================
// ============= INIT PERIPH (faites qu'une seule fois)  =====================
// ===========================================================================

Systick_Period_ff(5*72000);
Systick_Prio_IT(10, timer_callback );
SysTick_On;
SysTick_Enable_IT;	
	
Init_TimingADC_ActiveADC_ff( ADC1, 72 );
Single_Channel_ADC( ADC1, 2 );
Init_Conversion_On_Trig_Timer_ff( ADC1, TIM2_CC2, 225 );
Init_ADC1_DMA1(0, dma_buf );
	
// Après exécution : le coeur CPU est clocké à 72MHz ainsi que tous les timers
CLOCK_Configure();


//============================================================================	
	
	
while	(1)
	{
	}
}

