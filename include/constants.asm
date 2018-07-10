; TI-8x constants
.macro define_mask(name, bitN)
    .equ BIT_name bitN \
    .equ name 1 << bitN
.endmacro

.equ MONO_LCD_WIDTH   96
.equ MONO_LCD_HEIGHT  64
.equ MONO_BUF_SIZE    0x300
.equ COLOR_LCD_WIDTH  320
.equ COLOR_LCD_HEIGHT 240

; Port numbers and outputs
.equ PORT_LINKPORT 0
define_mask(LINKPORT_TIP, 0)
define_mask(LINKPORT_RING, 1)
define_mask(LINKPORT_CACHEDTIP, 4)
define_mask(LINKPORT_CACHEDRING, 5)
; 73/83+ BE only
define_mask(LINKPORT_ASSIST_ACTIVE, 2)
define_mask(LINKPORT_ASSIST_COMPLETE, 3)
define_mask(LINKPORT_ASSIST_BUSY, 6)
    
.equ PORT_KEYPAD 1

.equ PORT_CALC_STATUS 2
.equ PORT_INT_ACK     2
    define_mask(CALC_STATUS_BATTERY, 0)
    ; 83+ SE/84+ only
    define_mask(CALC_STATUS_LCDBUSY, 1)
    ; 73/83+ BE only
    define_mask(CALC_STATUS_ISTI73, 1)
    define_mask(CALC_STATUS_FLASHUNLOCKED, 2)
    define_mask(CALC_STATUS_HASUSB, 5)
    define_mask(CALC_STATUS_LINKASSIST_AVAILABLE, 6)
    define_mask(CALC_STATUS_IS83PBE, 7)

.equ PORT_INT_MASK 3
    define_mask(INT_ON, 0)
    define_mask(INT_TIMER1, 1)
    define_mask(INT_TIMER2, 2)
    define_mask(INT_LINK, 3)

; read
.equ PORT_INT_TRIG 4
    define_mask(INT_TRIG_ON, 0)
    define_mask(INT_TRIG_TIMER1, 1)
    define_mask(INT_TRIG_TIMER2, 2)
    define_mask(INT_TRIG_ON_HELD, 3)
    define_mask(INT_TRIG_LINK, 4)
    ; 83+ SE/84+ only
    define_mask(INT_TRIG_CRYS1, 5)
    define_mask(INT_TRIG_CRYS2, 6)
    define_mask(INT_TRIG_CRYS3, 7)
; write
.equ PORT_MEM_TIMER 4
    define_mask(MEM_TIMER_MODE1, 0)
    define_mask(MEM_TIMER_SPEED, 1)
    ; 83+ SE/84+ only
    define_mask(MEM_TIMER_BATTERY, 6)
    
.equ PORT_RAM_PAGING 5

.equ PORT_BANKA 6
    ; 73/83+ BE only
    define_mask(BANKA_ISRAM_CPU6, 6)
    ; 83+ SE/84+ only
    define_mask(BANKA_ISRAM_CPU15, 7)

.equ PORT_BANKB 7
    ; 73/83+ BE only
    define_mask(BANKB_ISRAM_CPU6, 6)
    ; 83+ SE/84+ only
    define_mask(BANKB_ISRAM_CPU15, 7)

.equ PORT_LINK_ASSIST_ENABLE 8
    define_mask(LA_ENABLE_INT_RX, 0)
    define_mask(LA_ENABLE_INT_TX, 1)
    define_mask(LA_ENABLE_INT_ERROR, 2)
    define_mask(LA_DISABLE, 7)

.equ PORT_LINK_ASSIST_STATUS 9
    define_mask(LA_INT_RX_DONE, 0)
    define_mask(LA_INT_TX_DONE, 1)
    define_mask(LA_INT_ERROR, 2)
    define_mask(LA_RX_ACTIVE, 3)
    define_mask(LA_RX_READY, 4)
    define_mask(LA_TX_READY, 5)
    define_mask(LA_RX_ERROR, 6)
    define_mask(LA_TX_ACTIVE, 7)

.equ PORT_LINK_ASSIST_RX_BUFFER 0x0A
.equ PORT_LINK_ASSIST_TX_BUFFER 0x0D

.equ PORT_MEMA_HIGH 0x0E
.equ PORT_MEMB_HIGH 0x0F

.equ PORT_LCD_CMD 0x10
    ; non-color calcs only
    ; read
    define_mask(LCD_CMD_AUTOINC, 0)
    define_mask(LCD_CMD_AUTOINC_AFFECTSCOL, 1)
    define_mask(LCD_CMD_RESETSTATE, 4)
    define_mask(LCD_CMD_DISPLAYING, 5)
    define_mask(LCD_CMD_8BITS, 6)
    define_mask(LCD_CMD_BUSY, 7)
    ; write
    .equ LCD_CMD_SETOUTPUTMODE              0
    .equ LCD_CMD_SETDISPLAY                 2
    .equ LCD_CMD_AUTOINCDEC_SETX            4
    .equ LCD_CMD_AUTOINCDEC_SETY            6
    .equ LCD_CMD_POWERSUPPLY_SETENHANCEMENT 8
    .equ LCD_CMD_MIRRORSCREEN               0x0C
    .equ LCD_CMD_POWERSUPPLY_SETLEVEL       0x10
    .equ LCD_CMD_CANCELTESTMODE             0x18
    .equ LCD_CMD_ENTERTESTMODE              0x1C
    .equ LCD_CMD_SETCOLUMN                  0x20
    .equ LCD_CMD_SETZSHIFT                  0x40
    .equ LCD_CMD_SETROW                     0x80
    .equ LCD_CMD_SETCONTRAST                0xC0

.equ PORT_LCD_DATA 0x11

.equ PORT_FLASHRWCONTROL 0x14
    define_mask(FLASHRWCONTROL_ENABLEWRITE, 0)

; 73/83+ BE only
.equ PORT_FLASHEXCLUSION 0x16

; 83+ SE/84+ only
.equ PORT_CPUSPEED 0x20
    define_mask(CPUSPEED_6MHZ, 0)
    define_mask(CPUSPEED_15MHZ, 1)
    ; there are also 2 and 3, but they should not be used

; 83+ SE/84+ only
.equ PORT_FLASHRAMSIZE 0x21
    define_mask(FLASHRAMSIZE_FLASHCHIP, 0)
    define_mask(FLASHRAMSIZE_RAMCHIP, 4)

; 83+ SE/84+ only
.equ PORT_FLASHEXEC_LOWLIMIT 0x22

; 83+ SE/84+ only
.equ PORT_FLASHEXEC_UPLIMIT 0x23

; 83+ SE/84+ only
.equ PORT_RAMEXEC_LOWLIMIT 0x25
    
; 83+ SE/84+ only
.equ PORT_RAMEXEC_UPLIMIT 0x26

; 83+ SE/84+ only
.equ PORT_LCD_DELAY 0x2A
    define_mask(LCD_DELAY_FLASH, 0)
    define_mask(LCD_DELAY_RAM, 1)
    define_mask(LCD_DELAY_AMOUNT, 2)

; 83+ SE/84+ only
.equ PORT_CRYS1_FREQ    0x30
.equ PORT_CRYS1_LOOP    0x31
.equ PORT_CRYS1_COUNTER 0x32
.equ PORT_CRYS2_FREQ    0x33
.equ PORT_CRYS2_LOOP    0x34
.equ PORT_CRYS2_COUNTER 0x35
.equ PORT_CRYS3_FREQ    0x36
.equ PORT_CRYS3_LOOP    0x37
.equ PORT_CRYS3_COUNTER 0x38

    define_mask(CRYS_LOOP_ENABLED, 0)
    define_mask(CRYS_LOOP_INT, 1)
    .equ CRYS_FREQ_0   0x00
    .equ CRYS_FREQ_8HZ 0x47

; 84+ only
.equ PORT_GPIO_CONFIG 0x39

; 84+ only
.equ PORT_GPIO_RW 0x3A
    ; color only
    define_mask(GPIO_RW_BACKLIGHT, 5)

; Clocks are 84+ only
.equ PORT_CLOCKCONTROL 0x40
    define_mask(CLOCKCONTROL_ENABLE, 0)
    define_mask(CLOCKCONTROL_COMMAND, 1)

.equ PORT_CLOCKREG1_IN  0x41
.equ PORT_CLOCKREG2_IN  0x42
.equ PORT_CLOCKREG3_IN  0x43
.equ PORT_CLOCKREG4_IN  0x44
.equ PORT_CLOCKREG1_OUT 0x45
.equ PORT_CLOCKREG2_OUT 0x46
.equ PORT_CLOCKREG3_OUT 0x47
.equ PORT_CLOCKREG4_OUT 0x48

; USB is 84+ only
.equ PORT_USB_INT 0x55
    define_mask(USB_INT_BUS, 0)
    define_mask(USB_INT_UNKNOWN1, 1)
    define_mask(USB_INT_LINE, 2)
    define_mask(USB_INT_VIEWSCREEN_MISS, 3)
    define_mask(USB_INT_PROTOCOL, 4)
    define_mask(USB_INT_UNKNOWN5, 5)
    define_mask(USB_INT_UNKNOWN6, 6)
    define_mask(USB_INT_UNKNOWN7, 7)
    
.equ PORT_USB_LINE 0x56
    define_mask(USB_LINE_DPLOW, 0)
    define_mask(USB_LINE_DPHIGH, 1)
    define_mask(USB_LINE_DMLOW, 2)
    define_mask(USB_LINE_DMHIGH, 3)
    define_mask(USB_LINE_IDLOW, 4)
    define_mask(USB_LINE_IDHIGH, 5)
    ; note the order
    define_mask(USB_LINE_VBUSHIGH, 6)
    define_mask(USB_LINE_VBUSLOW, 7)
    
.equ PORT_USB_LINE_MASK 0x57
    define_mask(USB_LINE_MASK_DPLOW, 0)
    define_mask(USB_LINE_MASK_DPHIGH, 1)
    define_mask(USB_LINE_MASK_DMLOW, 2)
    define_mask(USB_LINE_MASK_DMHIGH, 3)
    define_mask(USB_LINE_MASK_IDLOW, 4)
    define_mask(USB_LINE_MASK_IDHIGH, 5)
    ; again, note the order
    define_mask(USB_LINE_MASK_VBUSHIGH, 6)
    define_mask(USB_LINE_MASK_VBUSLOW, 7)
    
.equ PORT_USB_WRPIPE1     0x82
.equ PORT_USB_WRPIPE2     0x83
.equ PORT_USB_RDPIPE1     0x84
.equ PORT_USB_RDPIPE2     0x85
.equ PORT_USB_MISC_EVENTS 0x86

; LCD registers
; TI-84+ CSE only
.equ LCDREG_DRIVER_OUTPUTCONTROL1    1
.equ LCDREG_LCDDRIVING_CONTROL       2
.equ LCDREG_ENTRYMODE                3
.equ LCDREG_UNKNOWN6                 6
.equ LCDREG_DISPCONTROL1             7
.equ LCDREG_DISPCONTROL2             8
.equ LCDREG_DISPCONTROL3             9
.equ LCDREG_DISPCONTROL4             0x0A
.equ LCDREG_RGBDISP_INTERFACECONTROL 0x0C
.equ LCDREG_FRAMEMAKER_POSITION      0x0D
.equ LCDREG_POWERCONTROL1            0x10
.equ LCDREG_POWERCONTROL2            0x11
.equ LCDREG_POWERCONTROL3            0x12
.equ LCDREG_POWERCONTROL4            0x13
.equ LCDREG_CURSOR_ROW               0x20
.equ LCDREG_CURSOR_COLUMN            0x21
.equ LCDREG_GRAM                     0x22
.equ LCDREG_POWERCONTROL7            0x29
.equ LCDREG_FRAMERATE                0x2B
.equ LCDREG_GAMMA1                   0x30
.equ LCDREG_GAMMA2                   0x31
.equ LCDREG_GAMMA3                   0x32
.equ LCDREG_GAMMA4                   0x35
.equ LCDREG_GAMMA5                   0x36
.equ LCDREG_GAMMA6                   0x37
.equ LCDREG_GAMMA7                   0x38
.equ LCDREG_GAMMA8                   0x39
.equ LCDREG_GAMMA9                   0x3C
.equ LCDREG_GAMMA10                  0x3D
.equ LCDREG_WINDOW_HORIZ_START       0x50
.equ LCDREG_WINDOW_HORIZ_END         0x51
.equ LCDREG_WINDOW_VERT_START        0x52
.equ LCDREG_WINDOW_VERT_END          0x53
.equ LCDREG_GATESCANCONTROL          0x60
.equ LCDREG_BASEIMAGEDISPLAYCONTROL  0x61
.equ LCDREG_VERTSCROLLCONTROL        0x6A
.equ LCDREG_PARTIALIMG1_DISPPOS      0x80
.equ LCDREG_PANELINTERFACECONTROL1   0x90
.equ LCDREG_PANELINTERFACECONTROL2   0x92
.equ LCDREG_PANELINTERFACECONTROL4   0x95
.equ LCDREG_PANELINTERFACECONTROL5   0x97
