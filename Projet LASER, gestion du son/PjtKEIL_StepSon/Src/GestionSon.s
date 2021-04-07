	PRESERVE8
	THUMB   
		
	EXPORT SortieSon
	EXPORT timer_callback
	EXPORT Compteur
	IMPORT Son
	IMPORT LongueurSon

; ====================== zone de r�servation de donn�es,  ======================================
;Section RAM (read only) :
	area    mesdata,data,readonly


;Section RAM (read write):
	area    maram,data,readwrite
		

SortieSon DCW 0
Compteur DCD 0
; ===============================================================================================
		
;Section ROM code (read only) :		
	area    moncode,code,readonly
; �crire le code ici		

timer_callback proc
	push {r4-r11,lr}
	
	ldr r1, =Son
	ldr r3, =Compteur
	ldr r2, [r3]
	
	ldr r7, =LongueurSon
	ldr r7, [r7]
	
	cmp r2, r7
	beq fin
	
	ldrsh r0, [r1,r2, LSL#1]
	add r0, #32768
	mov r6, #91
	sdiv r0, r0, r6
	
	ldr r5, =SortieSon
	strh r0, [r5]
	
	add r2, #1  ;*Compteur + 1
	str r2, [r3] ;Compteur++ 
	
fin
	
	pop {r4-r11,lr}
	bx lr
	endp	
		
	END	