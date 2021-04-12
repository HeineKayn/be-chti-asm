	PRESERVE8
	THUMB   
		
	EXPORT SortieSon
	EXPORT timer_callback
	EXPORT Compteur
	IMPORT Son
	IMPORT LongueurSon
		
	include Driver/DriverJeuLaser.inc

; ====================== zone de réservation de données,  ======================================
;Section RAM (read only) :
	area    mesdata,data,readonly


;Section RAM (read write):
	area    maram,data,readwrite
		

SortieSon DCW 0
Compteur DCD 0
; ===============================================================================================
		
;Section ROM code (read only) :		
	area    moncode,code,readonly
; écrire le code ici		

timer_callback proc
	push {r4-r11,lr}
	
	; Chargement des variables globales
	ldr r1, =Son 		
	ldr r3, =Compteur
	ldr r2, [r3]
	ldr r7, =LongueurSon
	ldr r7, [r7]
	
	; Si dépassement du tableau, on skip le code
	cmp r2, r7
	beq setzero
	
	; La valeur était négative -> On la repasse en positive
	ldrsh r0, [r1,r2, LSL#1]
	add r0, #32768
	; On la recentre sur [0;720]
	mov r6, #91
	sdiv r0, r0, r6
	
	; Actualisation des variables
	ldr r5, =SortieSon
	strh r0, [r5]
	add r2, #1  ;Compteur + 1
	str r2, [r3] ;Compteur++ 
	b fin
setzero
	ldr r0,=0
	
fin
	bl PWM_Set_Value_TIM3_Ch3   ; en r0 se trouve le nombre de période avant le retour a 0	
	pop {r4-r11,lr}
	bx lr
	endp	
		
	END	