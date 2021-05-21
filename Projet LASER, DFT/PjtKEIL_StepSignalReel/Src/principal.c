#include "DriverJeuLaser.h"
#include <stdio.h>

int DFT_ModuleAuCarre( short int * Signal64ech, char k);

float Transformee[64];
extern short int LeSignal[64];
	

int main(void)
{

// ===========================================================================
// ============= INIT PERIPH (faites qu'une seule fois)  =====================
// ===========================================================================

// Après exécution : le coeur CPU est clocké à 72MHz ainsi que tous les timers
CLOCK_Configure();
for (int i=0; i<64; i++){
	Transformee[i] = DFT_ModuleAuCarre(LeSignal, i);
	//printf("%d -> %f \n",i,Transformee[i]);
}


	
	

//============================================================================	
	
	
while	(1)
	{
	}
}

