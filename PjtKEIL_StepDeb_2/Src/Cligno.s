	PRESERVE8
	THUMB   
		
	include Driver/DriverJeuLaser.inc
		
	EXPORT FlagCligno
	EXPORT timer_callback

; ====================== zone de réservation de données,  ======================================
;Section RAM (read only) :
	area    mesdata,data,readonly


;Section RAM (read write):
	area    maram,data,readwrite
		
FlagCligno dcd 0
; ===============================================================================================
	
;Section ROM code (read only) :		
	area    moncode,code,readonly
		
timer_callback proc
	push {r4-r11,lr}
	
	ldr r1, =FlagCligno
	ldr r0, [r1]
	cmp r0, #0
	bne diffzero
	; égale à 0
	mov r2, #1
	mov r0,#1
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