.model tiny 
black equ 0h
grey equ 88h
nopTime equ 2000

; Nop time constant
diffEZ equ 3000
diffMid equ 2000
diffHard equ 1000

org 100h      

.data 
    x    db  0 
    y    db  0 
    stage db 1
    ; Init with easy time
    diffTime dw diffEZ
    life db 9

    xArr db 13 dup(?)   ;hold x for each char
    yArr db 13 dup(?)   ;hold y for each char
    charArr db 13 dup(?)   ;hold ascii for each char    
    
    minr db 0           ;Max random
    maxr db 77          ;Min random
    seed dw ?           ;Seed for random    
    
    inBuffer db ?     ;hold char that user pressed
    

    
    
    nopMain dw nopTime          ;Counter for main logic
    
    

    lastCharPos db 12
    
    
   

    home db  "ggyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyygg$" 
         db  "yyyyggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggyyyy$" 
         db  "yyggggggggggggggggggggggggggggggggggggggggggggwwwwgwwwwgwwwwwwwwwgggggggggggggyy$" 
         db  "yyggggggggggybbgggggybbbbggggggggggggggggggggww11www11www111w1w1wgggggggggggggyy$" 
         db  "yyggggggggggybnbggggybnnnbgggggggggggggggggggw1ww1wwww1w1wwww1w1wgggggggggggggyy$" 
         db  "yyggggggggggybnnbbgybbbnnnbggggggggggggggggggw111www111ww11ww1w1wgggggggggggggyy$" 
         db  "yygggggggggggybnnnbbnnnnbnbggggggggggggggggggw1wwww1ww1wwww1w1w1wgggggggggggggyy$" 
         db  "yygggggggggggybnnnnnnwwnnngggggggggggggggggggww11www111w111www1wwgggggggggggggyy$" 
         db  "yyggggggggggggybbnnnnbwnwwggggggggggggggggggggwwwwgwwww2w2wwww1wggggggggggggggyy$" 
         db  "yygggggggggggggybnnnnnnnbwybbbggggggggwwwwwwwwgwwwwgwww2wwwww1wwwwwwwwwgggggggyy$" 
         db  "yyggggggggggggybnnnnbnnnbbnbbbbbggggggw222222www22www222w2w2ww2w222222wwggggggyy$" 
         db  "yyggggggggggggybnnnbnnnnnnnbbbbbbgggggw2ww2ww2w2ww2w2ww2w2w2ww2w2ww2ww2wggggggyy$" 
         db  "yyggggggggggggybnnnbbbbnnnnbbbbbbgggggw2ww2ww2w222ww2ww2w2w2ww2w2ww2ww2wggggggyy$" 
         db  "yyggggggggybbbybnnbbbbbnnnnnbbbbbgggggw2ww2ww2w2wwww2ww2w2w2ww2w2ww2ww2wggggggyy$" 
         db  "yygggggggybrrrbbbbbrbbnnnnnnnbbbbgggggw2ww2ww2ww22www222w2ww222w2ww2ww2wggggggyy$" 
         db  "yygggggggybrrrrrrrrrbbnnnnnnbnnnbgggggwwwwwwww3wwwwgwwwwwwwwww3wwwwwwwwwggggggyy$" 
         db  "yygggggggybrrrrrrrrrbbbnnnnbnnnnbggggggggggggw3wwwgwwwwwwwwwww3wggggggggggggggyy$" 
         db  "yyggggggggybrrrrrrrrbbbbbbbnnnnbgggggggggggggw3w3www33ww33ww333wggggggggggggggyy$" 
         db  "yygggggggggybbrrrrrbbbbggybbbbbggggggggggggggw33w3wwww3w3ww3ww3wggggggggggggggyy$" 
         db  "yygggggggggggybbbbbnnbbbgggggggggggggggggggggw3ww3ww333w3ww3ww3wggggggggggggggyy$" 
         db  "yyggggggggggggggybnnnnnbgggggggggggggggggggggw3ww3w3ww3w3ww3ww3wggggggggggggggyy$" 
         db  "yygggggggggggggggybnnnbggggggggggggggggggggggw3ww3ww333w3www333wggggggggggggggyy$" 
         db  "yyggggggggggggggggybbbgggggggggggggggggggggggwwwwwwwwwwwwwgwwwwwggggggggggggggyy$" 
         db  "yyyyggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggyyyy$" 
         db  "ggyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyygg$", 0 
         
   gover db  "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb$" 
         db  "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb$" 
         db  "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb$" 
         db  "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb$" 
         db  "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb$" 
         db  "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb$" 
         db  "bbbbbbbbbbbbnnnnnnnnnnbbbbbbbbbbbbbwwwwwwlbbbwwwwlbbbwwwwwwwwwwwwlbbbbbwwwwlbbbb$" 
         db  "bbbbbbbbnnnnyyyyyyyyyynnnnbbbbbbbwwlbbbwwlbbbbbbbwwlbwwlbbbwwlbbbwwlbwwlbbbwwlbb$" 
         db  "bbbbbbnnyyyyyyyyyyyyyyyyyynnbbbbbwwlbbbwwlbbbwwwwwwlbwwlbbbwwlbbbwwlbwwwwwwlbbbb$" 
         db  "bbbbbbnnyynnyyyyyyyyyynnyynnbbbbbwwlbbbwwlbwwlbbbwwlbwwlbbbwwlbbbwwlbwwlbbbbbbbb$" 
         db  "bbbbnnyynnyyyyyyyyyyyyyynnyynnbbbbbwwwwwwlbbbwwwwwwlbwwlbbbwwlbbbwwlbbbwwwwlbbbb$" 
         db  "bbbbnnyyyynnnnnnyynnnnnnyyyynnbbbbbbbbbwwlbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb$" 
         db  "bbbbnnyyyyllyyyyyyyyyyllyyyynnbbbbbwwwwlbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb$" 
         db  "bbbbnnyyllllyyyyyyyyyyllllyynnbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb$" 
         db  "bbbbnnllllyywwwwwwwwwwyyllllnnbbbbbbbbbbbwwwwwwlbbbwwlbwwlbbbwwwwlbbbwwwwlbbbbbb$" 
         db  "bbbbbbllllyyrrrrrrrrrryyllllbbbbbbbbbbbwwlbbbbbwwlbwwlbwwlbwwlbbbwwlbwwlbbbbbbbb$" 
         db  "bbbbbbnnyyyyyyrrrrrryyyyyynnbbbbbbbbbbbwwlbbbbbwwlbwwlbwwlbwwwwwwlbbbwwlbbbbbbbb$" 
         db  "bbbbbbbbnnnnyyyyyyyyyynnnnbbbbbbbbbbbbbwwlbbbbbwwlbwwlbwwlbwwlbbbbbbbwwlbbbbbbbb$" 
         db  "bbbbbbbbbbbbnnnnnnnnnnbbbbbbbbbbbbbbbbbbbwwwwwwlbbbbbwwlbbbbbwwwwlbbbwwlbbbbbbbb$" 
         db  "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb$" 
         db  "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb$" 
         db  "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb$" 
         db  "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb$" 
         db  "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb$" 
         db  "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb$", 0 
         
    song dw  2152, 2152, 2415, 2415, 2711, 0, 1, 2415, 2152, 0, 3224, 0, 1, 3619, 3619, 3619, 0, 2152, 0, 2152, 2415, 0, 2711, 0, 1, 1
         dw  2152, 2152, 2415, 2415, 2711, 0, 1, 2415, 2152, 0, 2031, 0, 1, 3619, 3619, 3619, 0, 2152, 0, 2152, 2415, 0, 2711, 0, 1, 1
         dw  2152, 2152, 2415, 2415, 2711, 0, 1, 2415, 2152, 0, 3244, 0, 1, 3619, 3619, 3619, 3619, 0, 2152, 0, 2152, 2415, 0, 2152, 0, 1, 1
         dw  2152, 2152, 2415, 2415, 2711, 0, 1, 2711, 2415, 2152, 0, 2031, 0, 1, 3619, 3619, 3619, 3619, 0, 2152, 0, 2152, 2415, 0, 2711, 0, 1, 1
         dw  2711, 2415, 2152, 2031, 2152, 2031, 2152, 2031, 2152, 2031, 2152, 2031, 2152, 2031, 2152, 2031, 2031, 0, 2031, 0, 2152, 0, 1, 1, 2031, 0, 2031, 0, 2152, 0, 1, 1 
         dw  2711, 2415, 2152, 2031, 2152, 2031, 2152, 2031, 2152, 2031, 2152, 2031, 2152, 2031, 2152, 2031, 1917, 0, 1809, 0, 1, 1, 1, 1, 1, 555

    songOver dw 1, 1612, 0, 1, 3043, 2152, 2031, 1809, 1612, 0, 1, 2031, 1612, 0, 1, 2031, 1612, 0, 1, 2415, 2031, 2415, 3043, 2031, 2415, 0, 1, 1, 555

.code 

;### Init , Menu, GameOver and everything ###
main: 
        mov     ax ,@data 
        mov     ds ,ax 
     
        mov     ah, 00h         ; Set to 80x25 
        mov     al, 03h 
        int     10h 
        mov     ax,1003h        ; text not blinking
        int     10h 
        
        mov     al, 182         ; Prepare the speaker for the
        out     43h, al         ;  note.
        
        menu:
        mov     bx, 0
        jmp     sound
        ret 
        
draw: 
        call    move 
        mov     al, [home + bx] 
        cmp     al ,0 
        jne     skipExit 
        ret

        skipExit: 
        cmp     al, '$' 
        je      newLine 

        back: 
        call    color 
         
        inc     x 
        inc     bx 
        jmp     draw 

move: 
        xor     ax, ax 
        mov     al, y           ;set ax to y 
        mov     dx, 80          ;set dx = 80 for multiplie source 
        mul     dx              ;multiplied result at dx ax 
        xor     dx, dx 
        mov     dl, x 
        add     ax, dx           ;add column by x 

        shl     ax, 1 

        mov     dx, ax          ;set dx as offset 
        ret

newLine: 
        inc     bx 
        mov     al, [home + bx] 
        inc     y 
        mov     x, 0 
        jmp     back 

color: 
        cmp     al, 'y' 
        je      yellow 

        cmp     al, 'w' 
        je      white 

        cmp     al, 'n' 
        je      brown 

        cmp     al, 'b' 
        je      black 

        cmp     al, 'r' 
        je      red 

        cmp     al, 'g' 
        je      green   
        
        cmp     al, 'l'
        je      blue

        cmp     al, '1' 
        je      choose1 

        cmp     al, '2' 
        je      choose2 

        cmp     al, '3' 
        je      choose3 

        yellow: 
        mov     ah, 0EEh 
        jmp     print 

        white: 
        mov     ah, 0FFh 
        jmp     print 

        black: 
        mov     ah, 00h 
        jmp     print 

        red: 
        mov     ah, 44h 
        jmp     print 

        brown: 
        mov     ah, 66h 
        jmp     print 

        green: 
        mov     ah, 33h 
        jmp     print 
                  
        blue:
        mov     ah, 99h
        jmp     print
        
        print: 
                push    ax 
                mov     di ,dx 
                mov     ax ,0b800h      ;moving in video ram address 
                mov     es ,ax          ;set address destination 
                pop     ax 
                cld 
                mov     cx ,1           ;print one char 
                rep     stosw           ;store value of ax to destination 
        ret 

choose1: 
        cmp     stage, 2
        jb      red
        je      black
        ja      black
        
choose2: 
        cmp     stage, 2
        jb      black
        je      red
        ja      black
        
choose3: 
        cmp     stage, 2
        jb      black
        je      black
        ja      red
    
sound:
        push    ax
        push    bx
        push    cx
        
        call    chooseStage
        
        pop     ax
        pop     bx
        pop     cx
        
        mov     ax , [song + bx]        ; Frequency number (in decimal).

        cmp     ax, 1                   ; check for mute
        je      isOne
        
        call    soundon                 ; play sound
        here:
        call    delayOn                
        
        mov     cx, [song + bx]         
        mov     ax, cx
        
        isSame:                         ; long note
        cmp     [song + bx + 2], 0
        je      sameNote
 
        call    soundoff                ; duration between note
        call    delayOff
        add     bx, 2
        cmp     [song + bx], 555   ; song end
        jne     sound  
        mov     bx, 0
        jmp     sound 
        
soundon:
        out     42h, al         ; Output low byte.
        mov     al, ah          ; Output high byte.
        out     42h, al 
        
        in      al, 61h         ; Turn on note (get value from port 61h).
        or      al, 00000011b   ; Set bits 1 and 0.
        out     61h, al         ; Send new value.
        ret
        
soundoff:
        in      al, 61h         ; Turn off note (get value from port 61h).
        and     al, 11111100b   ; Reset bits 1 and 0.
        out     61h, al         ; Send new value.
        ret
        
delayOn:                        ; delay when sound on
        push    bx
        mov     bx, 4           ; Pause for duration of note.
        pause1:
                mov     cx, 65535       ;16 bits
        pause2:
                dec     cx
                jne     pause2
                dec     bx
                jne     pause1
        pop     bx
        ret
        
delayOff:                       ;delay when sound off
        push    bx
        mov     bx, 1           ; Pause for duration of note.
        pause3:
                mov     cx, 65535       ;16 bits
        pause4:
                dec     cx
                jne     pause4
                dec     bx
                jne     pause3
        pop bx
        ret

sameNote:                       ;long note
        call    soundon
        call    delayOn
        add     bx, 2
        jmp     issame
        
isOne:                          ; mute
        call    soundoff
        call    delayOff
        jmp     here
        
chooseStage:
        mov     ah, 01h         ;don't press any keys
        int     16h
        jz      okok
        
        mov     ah, 00h
        int     16h
        cmp     al, 73h         ; key s
        je      isDown
        cmp     al, 77h         ; key w
        je      isUp
        cmp     al, 1Bh         ; key esc
        je      done
        cmp     al, 0Dh         ; key enter
        je      startGame
        jmp     okok            
        
        isDown:                 ; press down key
        inc     stage
        cmp     stage, 3
        ja      overStage
        jmp     okok
        
        isUp:                   ; press up key
        dec     stage
        cmp     stage, 1
        jb      underStage
  
        okok:
        mov     bx, 0
        mov     x, 0
        mov     y, 0
        call    draw
        ret
        
        overStage:
        mov     stage,3
        jmp     okok
        
        underStage:
        mov     stage, 1
        jmp     okok    
        
endGame:
        mov     bx, 0
        jmp     soundOver

drawEnd: 
        call    move 
        mov     al, [gover + bx] 
        cmp     al, 0 
        jne     skipExit2 
        ret

        skipExit2: 
        cmp     al, '$' 
        je      newLine2 

        back2: 
        call    color 
         
        inc     x 
        inc     bx 
        jmp     drawEnd 
        
newLine2: 
        inc     bx 
        mov     al, [gover + bx] 
        inc     y 
        mov     x, 0 

        jmp     back2 
        
sameNote2:                       ;long note
        call    soundon
        call    delayOn
        add     bx, 2
        jmp     issame2
isOne2:                          ; mute
        call    soundoff
        call    delayOff
        jmp     here2
        
soundOver:
        push    ax
        push    bx
        push    cx
        
        call    chooseEnd
        
        pop     ax
        pop     bx
        pop     cx
        
        mov     ax , [songOver + bx]        ; Frequency number (in decimal).

        cmp     ax, 1                   ; check for mute
        je      isOne2
        
        call    soundon                 ; play sound
        here2:
        call    delayOn                
        
        mov     cx, [songOver + bx]         
        mov     ax, cx
        
        isSame2:                         ; long note
        cmp     [songOver + bx + 2], 0
        je      sameNote2
 
        call    soundoff                ; duration between note
        call    delayOff
        add     bx, 2
        cmp     [songOver + bx], 555   ; song end
        jne     soundOver  
        mov     bx, 0
        jmp     soundOver 
        
chooseEnd:
        mov     ah, 01h         ;don't press any keys
        int     16h
        jz      okok2
        mov     stage,1
        mov     ah, 00h
        int     16h
        cmp     al, 1Bh         ; press esc
        je      done
        jmp     menu            ; press any keys to back to menu
        
        okok2:
        mov     bx, 0
        mov     x, 0
        mov     y, 0
        call    drawEnd
        ret   
; #### END MENU SECTION ####


; #### GAME SECTION ####
startGame:
   mov life,9
   ; Set speed by diff
   setDiffTime:        
        cmp stage,1
        je setEZ
        cmp stage,2
        je setMid
        cmp stage,3
        je setHard    
   setEZ:
        push bx
        mov bx , diffEZ
        mov diffTime,bx
        pop bx
        jmp prepare
   setMid:
        push bx
        mov bx , diffMid
        mov diffTime,bx
        pop bx
        jmp prepare
   setHard:
        push bx
        mov bx , diffHard
        mov diffTime,bx
        pop bx
        jmp prepare
   prepare:
        ; Clear all screen at start
        call clearScreen    
        ; Clear bx
        xor bx ,bx

    initValue:
        mov al ,bl
        mov dl ,5
        mul dl
        neg al
        mov [yArr + bx] ,al
        ; random in this range to prevent collision between matrix and life
        mov minr ,0
        mov maxr ,77        
        call random
        mov [xArr + bx] ,dl
        
        mov minr ,'0'
        mov maxr ,'z' + 1
        call random
        mov [charArr + bx] ,dl
        
        inc bx
        cmp bx ,13
        jl initValue
    
    call printLife
        
    MainLoop:
        dec nopMain        
        mov ah ,0Bh
        int 21h
        
        cmp al ,00h
        jne charAvailable
        
        cmp nopMain ,0
        jle moveMatrix
                        
        jmp MainLoop


charAvailable:
    mov ah ,07h
    int 21h             ;al hold char in buffer
    
    cmp al ,27          ;check esc
    jne  recieveKey
    jmp endGame

    recieveKey:
        mov inBuffer,al    
        jmp checkInArr

checkInArr:
    ; Clear garbageeeeeeeeeee
    xor bx ,bx    
    checkLoop:
        mov cl ,[charArr + bx]
        cmp cl ,inBuffer
        jne ifNotFound
        jmp ifFound

    ifNotFound:
        ; Increase index
        inc bx
        cmp bx ,13
        je MainLoop
        jmp checkLoop
        
moveMatrix:
    ; Prevent garbage value
    xor bx ,bx    
    loopMatrix:
        push bx
        xor cx ,cx
        mov cl ,[xArr + bx]
        mov x ,cl
        mov cl ,[yArr + bx]
        mov y ,cl
        dec y
        call setCursor
        mov al ,[charArr + bx]
        mov ah ,2h
        call printChar
        pop bx
        push bx
        dec y
        call setCursor
        mov al ,[charArr + bx]
        mov ah ,7h
        call printChar
        pop bx
        push bx
        dec y
        call setCursor
        mov al ,[charArr + bx]
        mov ah ,0Fh
        call printChar
        pop bx
        push bx
        dec y
        call setCursor
        mov al ,' '
        mov ah ,0h
        call printChar       
        pop bx

        push bx        
        xor cx ,cx
        mov cl ,[yArr + bx]
        inc cl
        mov [yArr + bx] ,cl
        cmp cl ,25
        jl setY
        mov y ,cl
        mov cl ,[xArr + bx]
        mov x ,cl
        mov cx ,5
        delTail:
            push cx
            call setCursor
            mov ah ,0h
            mov al ,' '
            call printChar
            dec y
            pop cx
        loop delTail
        
        jmp decLife
        exceedScreen:
        
        call shiftArr
        call randomNewChar
        jmp isComplete
        
        
        
        mov al ,[charArr + bx]
        mov ah ,0Ah
        call printChar  ;print char to new position
        pop bx
        isComplete:
        inc bx
        cmp bx ,13
        jge  skipLoopMatrix
        jmp loopMatrix

    setY:
        mov y ,cl
        call setCursor
    skipLoopMatrix:
        mov ax ,diffTime  
        mov nopMain ,ax
        jmp MainLoop
            
    
ifFound:
    ; Remove and clear tail
    push bx
    xor cx ,cx
    mov cl ,[xArr + bx]
    mov x ,cl
    mov cl ,[yArr + bx]
    mov y ,cl    
    call clearTail
    call headShot
    pop bx
    ; Shift into blank
    call shiftArr
    call randomNewChar         
    
    jmp MainLoop 
            
shiftArr:               ;shift array after match char in array
    inc bx
    mov al ,[yArr + bx]
    mov cl ,[xArr + bx]
    mov dl ,[charArr + bx]
    mov [yArr + bx - 1] ,al
    mov [xArr + bx - 1] ,cl
    mov [charArr + bx -1] ,dl
    cmp bx ,12
    
    jne shiftArr
    ret                                             

randomNewChar:          ;random new char and position that match char user pressed   
    mov minr ,0
    mov maxr ,77
    call random
    
    mov [xArr + bx] ,dl
    
    push bx
    xor bx ,bx
    mov bl ,lastCharPos
    mov cl ,[yArr + bx]
    sub cl ,5
    pop bx
    mov lastCharPos ,bl
    mov [yArr + bx] ,cl
    
    mov minr ,'0'
    mov maxr ,'z' + 1
    call random
    mov [charArr + bx] ,dl
    ret
    
decLife:
    dec life
    call printLife
    call die
    cmp life ,0
    je endGame
    jmp exceedScreen

headShot:
    mov     ax , 1207        
    call    soundon  
    call    delayOn  
        
    mov     ax , 1355 
    call    soundon 
    call    delayOn    
    call    soundoff 
    ret

die:
        mov     ax , 8126        
        call    soundon  
        call    delayOn  
        
        mov     ax , 8609 
        call    soundon 
        call    delayOn   
        call    soundoff 
        ret 

getTime:
    mov ah ,2Ch
    int 21h
    ret            
    
setCursor:
    xor ax ,ax              
    mov al ,y           ;set ax to y
    mov dx ,80          ;set dx = 80 for multiplie source
    mul dx              ;multiplied result at dx ax
    xor dx ,dx
    mov dl ,x
    add ax ,dx           ;add column by x
    
    shl ax ,1
     
    mov dx ,ax          ;set dx as offset   
    ret
    
printChar:              ;need al as char ascii parameter
    push ax
    mov di ,dx
    mov ax ,0b800h      ;moving in video ram address
    mov es ,ax          ;set address destination
    pop ax
    cld
    mov cx ,1           ;print one char
    rep stosw           ;store value of ax to destination    
    ret

clearTail:
    call setCursor
    mov al ,' '
    mov ah ,0h
    call printChar

    dec y
    call setCursor
    mov al ,' '
    mov ah ,0h
    call printChar

    dec y
    call setCursor
    mov al ,' '
    mov ah ,0h
    call printChar

    dec y
    call setCursor
    mov al ,' '
    mov ah ,0h
    call printChar

    dec y
    call setCursor
    mov al ,' '
    mov ah ,0h
    call printChar
    ret

printLife:
    mov x ,78
    mov y ,1
    call setCursor
    mov al ,life
    add al ,'0'
    mov ah, 0ch ; set light red
    call printChar
    ret

    
random:
    mov ah ,2ch
    int 21h
    mov ax ,dx
    add ax ,seed
    
    xor cx ,cx  
    xor dx ,dx
    mov cl ,maxr
    sub cl ,minr
    
    div cx
    add seed ,dx
    
    add dl ,minr
        
    ret

clearScreen:
    mov di ,0
    mov ax ,0b800h
    mov es ,ax
    cld
    mov ah ,black
    mov al ,' '
    mov cx ,80 * 25
    rep stosw
    ret

done:     
    call clearScreen 
    end start      