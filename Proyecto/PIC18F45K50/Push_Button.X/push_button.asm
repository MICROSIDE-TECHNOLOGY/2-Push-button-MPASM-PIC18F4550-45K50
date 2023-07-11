;====================================================================

	LIST P=18F45K50 
	#include "P18f45K50.INC" ;ENCABEZADO

;====================================================================
; Bits de configuracion
;--------------------------------------------------------------------
  CONFIG  PLLSEL = PLL3X        ; PLL Selection (3x clock multiplier)
  CONFIG  CFGPLLEN = ON         ; PLL Enable Configuration bit (PLL Enabled)
  CONFIG  LS48MHZ = SYS48X8     ; Low Speed USB mode with 48 MHz system clock (System clock at 48 MHz, USB clock divider is set to 8)
  CONFIG  FOSC = INTOSCIO       ; Oscillator Selection (Internal oscillator)
  CONFIG  nPWRTEN = ON          ; Power-up Timer Enable (Power up timer enabled)
  CONFIG  BORV = 250            ; Brown-out Reset Voltage (BOR set to 2.5V nominal)
  CONFIG  nLPBOR = ON           ; Low-Power Brown-out Reset (Low-Power Brown-out Reset enabled)
  CONFIG  WDTEN = OFF           ; Watchdog Timer Enable bits (WDT disabled in hardware (SWDTEN ignored))
  CONFIG  PBADEN = OFF          ; PORTB A/D Enable bit (PORTB<5:0> pins are configured as digital I/O on Reset)
  CONFIG  LVP = OFF             ; Single-Supply ICSP Enable bit (Single-Supply ICSP disabled)

;====================================================================
; Macros
;--------------------------------------------------------------------

	#DEFINE	LED		 LATA,4  ;LED PIN A4
	#DEFINE BUTTON		 PORTA,2  ;BOTON PIN A2

;====================================================================
; VECTOR DE INICIO
;--------------------------------------------------------------------

	ORG		0x2000
	GOTO		START
	
	ORG		0x2008
	RETFIE
	
	ORG		0x2018
	RETFIE

;====================================================================
; PROGRAMA PRINCIPAL
;--------------------------------------------------------------------
     
START
    MOVLW   0x70
    MOVWF   OSCCON  ;CONFIGURA OSCILADOR
    BANKSEL(ANSELA) ;SE SELECCIONA EL BANCO SFR
    CLRF    ANSELA  ;PUERTO A SE CONFIGURA COMO DIGITAL
    SETF    TRISA   ;PUERTO A SE CONFIGURA COMO ENTRADAS
    BCF	    TRISA,4 ;PIN RA4 SE CONFIGURA COMO SALIDA
    BCF	    LED	    ;SE LIMPIA EL PIN RA4
LOOP
    BTFSS   BUTTON  ;OMITE SIGUIENTE INSTRUCCION SI RA2 ES 1
    GOTO    LED_ON
    BCF	    LED	    ;LIMPIA PIN RA4
    GOTO    LOOP
LED_ON
    BSF	    LED	    ;SE COLOCA PIN RA4
    GOTO LOOP
END