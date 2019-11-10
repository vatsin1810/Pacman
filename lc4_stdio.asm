;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;  Assembly file to serve as bridge ;;;;;;;;;;;;
;;;;;  between subroutines and TRAPs	;;;;;;;;;;;;
;;;;;  for programs we will write in C  ;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;; WRAPPER SUBROUTINES FOLLOW ;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
.DATA
.ADDR x2000
STACK_SAVER .FILL 0x0000
.FILL 0x0000

.CODE
.ADDR x0010    ;; wrapper code will load after address x10, to preserve USER_START


;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; TRAP_PUTC Wrapper ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.FALIGN
lc4_putc

	;; prologue
	STR R7, R6, #-2	; save caller’s return address
	STR R5, R6, #-3	; save caller’s frame pointer
	ADD R6, R6, #-3 ; update stack pointer
	ADD R5, R6, #0	; update frame pointer
	LEA R7, STACK_SAVER ; Fill R7 for purpose of storing frame and stack pointer
	STR R5, R7, #0 ; Save frame pointer
	STR R6, R7, #1 ; Save stack pointer
	; no local variables, so no need to allocate for them

	;; function body 

	; setup arguments for TRAP_PUTC:
	LDR R0, R5, #3	; copy param (c) from stack, into register R0
	TRAP x01        ; R0 has been set, so we can call TRAP_PUTC
	
	; TRAP_PUTC has no return value, so nothing to copy back to stack

	;; epilogue
	LEA R7, STACK_SAVER ; Fill R7 for purpose of restoring frame and stack pointer
	LDR R5, R7, #0 ; Restore frame pointer
	LDR R6, R7, #1 ; Restore stack pointer
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
RET



;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; TRAP_PUTS Wrapper ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.FALIGN
lc4_puts
	

	;; prologue
	STR R7, R6, #-2	; save caller’s return address
	STR R5, R6, #-3	; save caller’s frame pointer
	ADD R6, R6, #-3 ; update stack pointer
	ADD R5, R6, #0	; update frame pointer
	LEA R7, STACK_SAVER
	STR R5, R7, #0
	STR R6, R7, #1

	;; function body 
	LDR R0, R5, #3	; copy param (array) from stack, into register R0
	TRAP x02        ; R0 has been set, so we can call TRAP_PUTC

	;; epilogue
	LEA R7, STACK_SAVER
	LDR R5, R7, #0
	LDR R6, R7, #1
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address

RET


;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; TRAP_GETC Wrapper ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.FALIGN
lc4_getc
	

	;; prologue
	STR R7, R6, #-2	; save caller’s return address
	STR R5, R6, #-3	; save caller’s frame pointer
	ADD R6, R6, #-3 ; update stack pointer
	ADD R5, R6, #0	; update frame pointer
	LEA R7, STACK_SAVER
	STR R5, R7, #0
	STR R6, R7, #1

	;; function body 
	TRAP x00        ; R0 has been set, so we can call TRAP_PUTC

	;; epilogue
	LEA R7, STACK_SAVER
	LDR R5, R7, #0
	LDR R6, R7, #1
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R0, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address



RET


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; TRAP_GETC_TIMER Wrapper ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.FALIGN
lc4_getc_timer
	

	;; prologue
	STR R7, R6, #-2	; save caller’s return address
	STR R5, R6, #-3	; save caller’s frame pointer
	ADD R6, R6, #-3 ; update stack pointer
	ADD R5, R6, #0	; update frame pointer
	LEA R7, STACK_SAVER
	STR R5, R7, #0
	STR R6, R7, #1

	;; function body 
	LDR R0, R5, #3	; copy param (time) from stack, into register R0
	TRAP x04        ; R0 has been set, so we can call TRAP_PUTC

	;; epilogue
	LEA R7, STACK_SAVER
	LDR R5, R7, #0
	LDR R6, R7, #1
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R0, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address


RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; TRAP_DRAW_Pixel Wrapper ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.FALIGN
lc4_draw_pixel
	
	;; prologue
	STR R7, R6, #-2	; save caller’s return address
	STR R5, R6, #-3	; save caller’s frame pointer
	ADD R6, R6, #-3 ; update stack pointer
	ADD R5, R6, #0	; update frame pointer
	LEA R7, STACK_SAVER
	STR R5, R7, #0
	STR R6, R7, #1

	;; function body 
	LDR R0, R5, #3	; copy param (row) from stack, into register R0
	LDR R1, R5, #4  ; copy param (col) from stack, into register R1
	LDR R2, R5, #5  ; copy param (color) from stack, into register R2
	TRAP x05        ; R0 has been set, so we can call TRAP_PUTC

	;; epilogue
	LEA R7, STACK_SAVER
	LDR R5, R7, #0
	LDR R6, R7, #1
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address

RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; TRAP_DRAW_HLINE Wrapper ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.FALIGN
lc4_draw_hline
	
	;; prologue
	STR R7, R6, #-2	; save caller’s return address
	STR R5, R6, #-3	; save caller’s frame pointer
	ADD R6, R6, #-3 ; update stack pointer
	ADD R5, R6, #0	; update frame pointer
	LEA R7, STACK_SAVER
	STR R5, R7, #0
	STR R6, R7, #1

	;; function body 
	LDR R0, R5, #3	; copy param (row) from stack, into register R0
	LDR R1, R5, #4  ; copy param (col) from stack, into register R1
	LDR R2, R5, #5  ; copy param (color) from stack, into register R2
	LDR R3, R5, #6
	TRAP x06        ; R0 has been set, so we can call TRAP_PUTC

	;; epilogue
	LEA R7, STACK_SAVER
	LDR R5, R7, #0
	LDR R6, R7, #1
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address

RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; TRAP_DRAW_VLINE Wrapper ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.FALIGN
lc4_draw_vline
	
	;; prologue
	STR R7, R6, #-2	; save caller’s return address
	STR R5, R6, #-3	; save caller’s frame pointer
	ADD R6, R6, #-3 ; update stack pointer
	ADD R5, R6, #0	; update frame pointer
	LEA R7, STACK_SAVER
	STR R5, R7, #0
	STR R6, R7, #1

	;; function body 
	LDR R0, R5, #3	; copy param (row) from stack, into register R0
	LDR R1, R5, #4  ; copy param (col) from stack, into register R1
	LDR R2, R5, #5  ; copy param (color) from stack, into register R2
	LDR R3, R5, #6
	TRAP x07        ; R0 has been set, so we can call TRAP_PUTC

	;; epilogue
	LEA R7, STACK_SAVER
	LDR R5, R7, #0
	LDR R6, R7, #1
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address

RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; TRAP_DRAW_RECT Wrapper ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


.FALIGN
lc4_draw_rect
	

	;; prologue
	STR R7, R6, #-2	; save caller’s return address
	STR R5, R6, #-3	; save caller’s frame pointer
	ADD R6, R6, #-3 ; update stack pointer
	ADD R5, R6, #0	; update frame pointer
	LEA R7, STACK_SAVER
	STR R5, R7, #0
	STR R6, R7, #1

	;; function body 
	LDR R0, R5, #3	; copy param (x) from stack, into register R0
	LDR R1, R5, #4  ; copy param (y) from stack, into register R1
	LDR R2, R5, #5  ; copy param (width) from stack, into register R2
	LDR R3, R5, #6  ; copy param (height) from stack, into register R2
	LDR R4, R5, #7  ; copy param (color) from stack, into register R2
	TRAP x08        ; R0 has been set, so we can call TRAP_PUTC

	;; epilogue
	LEA R7, STACK_SAVER
	LDR R5, R7, #0
	LDR R6, R7, #1
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address


RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; TRAP_DRAW_SPRITE Wrapper ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.FALIGN
lc4_draw_sprite
	

	;; prologue
	STR R7, R6, #-2	; save caller’s return address
	STR R5, R6, #-3	; save caller’s frame pointer
	ADD R6, R6, #-3 ; update stack pointer
	ADD R5, R6, #0	; update frame pointer
	LEA R7, STACK_SAVER
	STR R5, R7, #0
	STR R6, R7, #1

	;; function body 
	LDR R0, R5, #3	; copy param (x) from stack, into register R0
	LDR R1, R5, #4  ; copy param (y) from stack, into register R1
	LDR R2, R5, #5  ; copy param (color) from stack, into register R2
	LDR R3, R5, #6  ; copy param (starting address) from stack, into register R2
	TRAP x09       ; R0 has been set, so we can call TRAP_PUTC

	;; epilogue
	LEA R7, STACK_SAVER
	LDR R5, R7, #0
	LDR R6, R7, #1
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address


RET


;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; TRAP_LFSR Wrapper ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.FALIGN
lc4_random
	

	;; prologue
	STR R7, R6, #-2	; save caller’s return address
	STR R5, R6, #-3	; save caller’s frame pointer
	ADD R6, R6, #-3 ; update stack pointer
	ADD R5, R6, #0	; update frame pointer
	LEA R7, STACK_SAVER
	STR R5, R7, #0
	STR R6, R7, #1

	;; function body 
	TRAP x0D        ; R0 has been set, so we can call TRAP_PUTC

	;; epilogue
	LEA R7, STACK_SAVER
	LDR R5, R7, #0
	LDR R6, R7, #1
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R0, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address

RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; TRAP_RESET_VMEM Wrapper ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.FALIGN
lc4_reset_vmem
	;; CIS 240 - YOU MAY NEED TO MODIFY THIS IF TRAP x09 USES R5 or R6
	;; prologue
	STR R7, R6, #-2	; save caller’s return address
	STR R5, R6, #-3	; save caller’s frame pointer
	ADD R6, R6, #-3 ; update stack pointer
	ADD R5, R6, #0	; update frame pointer
	LEA R7, STACK_SAVER
	STR R5, R7, #0
	STR R6, R7, #1
	; no local variables, so no need to allocate for them

	;; function body 
	TRAP x0A

	; TRAP_RESET_VMEM has no return value, so nothing to copy back to stack

	;; epilogue
	LEA R7, STACK_SAVER
	LDR R5, R7, #0
	LDR R6, R7, #1
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; TRAP_BLT_VMEM Wrapper ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.FALIGN
lc4_blt_vmem
	;;  - YOU MAY NEED TO MODIFY THIS IF TRAP x09 USES R5 or R6
	;; prologue
	STR R7, R6, #-2	; save caller’s return address
	STR R5, R6, #-3	; save caller’s frame pointer
	ADD R6, R6, #-3 ; update stack pointer
	ADD R5, R6, #0	; update frame pointer
	LEA R7, STACK_SAVER
	STR R5, R7, #0
	STR R6, R7, #1
	; no local variables, so no need to allocate for them

	TRAP x0B
	; TRAP_BLT_VMEM has no return value, so nothing to copy back to stack

	;; epilogue
	LEA R7, STACK_SAVER
	LDR R5, R7, #0
	LDR R6, R7, #1
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address

RET
