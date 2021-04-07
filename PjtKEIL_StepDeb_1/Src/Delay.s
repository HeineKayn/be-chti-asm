	PRESERVE8
	THUMB   


	EXPORT VarTime ; on l'exporte pour pouvoir la lire avec le watch


; ====================== zone de r�servation de donn�es,  ======================================
;Section RAM (read only) :
	area    mesdata,data,readonly


;Section RAM (read write):
	area    maram,data,readwrite
	
; Vartime est un emplacement m�moire dans lequel on met du vide	
VarTime	dcd 0

	
; ===============================================================================================
	
;constantes (�quivalent du #define en C)
TimeValue	equ 900000


	EXPORT Delay_100ms ; la fonction Delay_100ms est rendue publique donc utilisable par d'autres modules.

		
;Section ROM code (read only) :		
	area    moncode,code,readonly
		


; REMARQUE IMPORTANTE 
; Cette mani�re de cr�er une temporisation n'est clairement pas la bonne mani�re de proc�der :
; - elle est peu pr�cise
; - la fonction prend tout le temps CPU pour... ne rien faire...
;
; Pour autant, la fonction montre :
; - les boucles en ASM
; - l'acc�s �cr/lec de variable en RAM
; - le m�canisme d'appel / retour sous programme
;
; et donc poss�de un int�r�t pour d�buter en ASM pur

Delay_100ms proc
	
	    ldr r0,=VarTime  	; r0 = &VarTime	  
						  
		ldr r1,=TimeValue	; r1 = TimeValue
		str r1,[r0]			; *r0 ( *(&VarTime)) = TimeValue

BoucleTempo					; label sur lequel on peut jump
		ldr r1,[r0]    		; r1 = VarTime
						
		subs r1,#1			; subs =! sub -> si arrive � 0 on active un flag
		str  r1,[r0]		; *r0 ( *(&VarTime)) = TimeValue
		bne	 BoucleTempo	; on re jump sur le label boucle tant que flag pas actif
			
		bx lr				; nous fait jump � l'adresse suivante de l� o�
							; la fonction avait �t� appel�e (return)
		endp
		
		
	END	