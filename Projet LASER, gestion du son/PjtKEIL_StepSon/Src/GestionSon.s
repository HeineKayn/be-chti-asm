	PRESERVE8
	THUMB   
		
	EXPORT FlagCligno
	EXPORT timer_callback

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
	
	ldr r1, =Son
	ldr r2, =Compteur
	ldrh r0, [r1,r2, LSL#1]
	add r0,#32768
	bl GPIOB_Set
	b fin
	
diffzero
	mov r2, #0
	mov r0,#1
	bl GPIOB_Clear
	
fin
	str r2, [r1]
	pop {r4-r11,lr}
	bx lr
	endp	
		
		
	END	