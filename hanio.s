	AREA mycode, CODE
	THUMB
	EXPORT __main
		
	;#r0 as steps
	;r1-r6 as disks 
	;r7 holds steps needed for loop to end
	;r8-r10 as pegs
	;This code shifts bits around to move disks 
	;The answer for 3 disks is in r10 at the end = 321 in r0 = 7 steps
	;The answer for 6 disks is in r9 at the end = 654321 in r0 = 63 steps


;This code is for 3 disks ---- odd disks
;__main  PROC
;    MOV R0, #0
;    MOV R1, #1
;   MOV R2, #2
;    MOV R3, #3
;    MOV R4, #0
;    LSLS R7, R1, #3
;    ADD R7, #-1
;    MOV R0, #0
;    LSLS R8, R3, #8
;    LSLS R9, R2, #4
;   ORRS R8, R8, R9
;    ORRS R8, R8, R1
;    MOV R9, #0
;    MOV R10, #0
;   b check

;This code is for 6 disks ---- even disks
__main	PROC
		MOV R0, #0
		MOV R1, #1
		MOV R2, #2
		MOV R3, #3
		MOV R4, #4
		MOV R5, #5
		MOV R6, #6
		;LSLS R7, R1, #6
		;ADD R7, #-1
		MOV R0, #0
		LSLS R8, R6, #20
		LSLS R9, R5, #16
		ORRS R8, R8, R9
		LSLS R9, R4, #12
		ORRS R8, R8, R9
		LSLS R9, R3, #8
		ORRS R8, R8, R9
		LSLS R9, R2, #4
		ORRS R8, R8, R9
		ORRS R8, R8, R1
		mov r7, r8  ;------- change 
		MOV R9, #0
		MOV R10, #0
		b check

check	AND R5, R6, R1
		CMP R1, R5
		BEQ odd
		B even 
		
odd		MOV R3, #1
		b step1
	
step1	ADD R0, #1
		AND R1, R8, #15
		AND R2, R10, #15
		CMP R10, #0
		BEQ atoc
		CMP R2, R1
		BLT ctoa 
		CMP R8, #0
		BEQ ctoa
		CMP R1, R2
		BLT atoc
	
atoc
		LSLS R10, R10, #4
		ORRS R10, R1, R10
		LSRS R8, R8, #4
		CMP R3, #0
		BEQ checkEven1
		b checkODD1
		
checkODD1
		CMP R10, R7
		BGE endcall
		b step2
		
checkEven1
		CMP R9, R7
		BGE endcall
		b step2
		
ctoa
		LSLS R8, R8, #4
		ORRS R8, R2, R8
		LSRS R10, R10, #4
		CMP R3, #0
		BEQ checkEven1
		b checkODD1
		
	
step2	ADD R0, #1
		AND R1, R8, #15
		AND R2, R9, #15
		CMP R9, #0
		BEQ atob
		CMP R2, R1
		BLT btoa
		CMP R8, #0
		BEQ btoa
		CMP R1, R2
		BLT atob
			
atob		
		LSLS R9, R9, #4
		ORRS R9, R1, R9
		LSRS R8, R8, #4
		CMP R3, #0
		BEQ checkEven2
		B checkODD2

btoa
		LSLS R8, R8, #4
		ORRS R8, R2, R8
		LSRS R9, R9, #4
		CMP R3, #0
		BEQ checkEven2
		B checkODD2

checkODD2
		CMP R10, R7
		BGE endcall
		b step3
		

checkEven2
		CMP R9, R7
		BGE endcall
		b step3

step3	CMP R10, R7
		BGE endcall
		ADD R0, #1
		AND R1, R9, #15
		AND R2, R10, #15
		CMP R10, #0
		BEQ btoc
		CMP R2, R1
		BLT ctob
		CMP R9, #0
		BEQ ctob
		CMP R1, R2
		BLT btoc


btoc
		LSLS R10, R10, #4
		ORRS R10, R1, R10
		LSRS R9, R9, #4
		CMP R3, #1
		BEQ checkODD3
		CMP R3, #0
		BEQ checkEven3
		
ctob
		LSLS R9, R9, #4
		ORRS R9, R2, R9
		LSRS R10, R10, #4
		CMP R3, #1
		BEQ checkODD3
		CMP R3, #0
		BEQ checkEven3

checkODD3
		CMP R10, R7
		BGE endcall
		b odd
		

checkEven3
		CMP R9, R7
		BGE endcall
		b even
		
even	MOV R3, #0
		B step1
		
endcall	b endcall	
		ENDP
		END
		
		
		



		
		
		
		