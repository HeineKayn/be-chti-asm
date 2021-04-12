

#include "DriverJeuLaser.h"
void timer_callback(void);


int main(void)
{

// ===========================================================================
// ============= INIT PERIPH (faites qu'une seule fois)  =====================
// ===========================================================================

// Après exécution : le coeur CPU est clocké à 72MHz ainsi que tous les timers
CLOCK_Configure();
Timer_1234_Init_ff(TIM4, 91*72);
	
// Configuration PWM 
GPIO_Configure(GPIOB, 0, OUTPUT, ALT_PPULL); // permet que ça soit la PWM qui gère le truc
PWM_Init_ff( TIM3, 3, 720);	 // init la pwm
	
// configuration du Timer 4 en débordement 100ms
Active_IT_Debordement_Timer(TIM4, 2, timer_callback);	
	
// configuration de PortB.1 (PB1) en sortie push-pull
// GPIO_Configure(GPIOB, 1, OUTPUT, OUTPUT_PPULL);	


//============================================================================	
	
	
while	(1)
	{
	}
}

