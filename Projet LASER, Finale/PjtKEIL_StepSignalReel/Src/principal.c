#include "DriverJeuLaser.h"
#include <stdio.h>

int DFT_ModuleAuCarre( short int * Signal64ech, char k);

extern short int LeSignal[64];
short int dma_buf[64];

int fnormalise[6] = {17,18,19,20,23,24};
int score[6] = {0,0,0,0,0,0}; 
int cpt[6] = {0,0,0,0,0,0}; 
int k;
int seuil = 18;
	
void timer_callback(void){
	Start_DMA1(64);
	Wait_On_End_Of_DMA1();
	Stop_DMA1;
	
	// on mets des compteur parce que sinon 1 tir = 20 ms = 20 points
	for (int i=0; i<6; i++){
		k = fnormalise[i];
		if (DFT_ModuleAuCarre(dma_buf, k) > 0){
			cpt[i] += 1;
		}
		else{
			cpt[i] = 0;
		}
		
		if (cpt[i] > seuil){
			score[i] += 1;
			cpt[i] = 0;
		}
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

