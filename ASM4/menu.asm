.model tiny 
org 100h 

     

.data 
    x    db  0 
    y    db  0 
    stage db 2 
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
    song dw  2152, 2152, 2415, 2415, 2711, 0, 1, 2415, 2152, 0, 3224, 0, 1, 3619, 3619, 3619, 0, 2152, 0, 2152, 2415, 0, 2711, 0, 1, 1
         dw  2152, 2152, 2415, 2415, 2711, 0, 1, 2415, 2152, 0, 2031, 0, 1, 3619, 3619, 3619, 0, 2152, 0, 2152, 2415, 0, 2711, 0, 1, 1
         dw  2152, 2152, 2415, 2415, 2711, 0, 1, 2415, 2152, 0, 3244, 0, 1, 3619, 3619, 3619, 3619, 0, 2152, 0, 2152, 2415, 0, 2152, 0, 1, 1
         dw  2152, 2152, 2415, 2415, 2711, 0, 1, 2711, 2415, 2152, 0, 2031, 0, 1, 3619, 3619, 3619, 3619, 0, 2152, 0, 2152, 2415, 0, 2711, 0, 1, 1
         dw  2711, 2415, 2152, 2031, 2152, 2031, 2152, 2031, 2152, 2031, 2152, 2031, 2152, 2031, 2152, 2031, 2031, 0, 2031, 0, 2152, 0, 1, 1, 2031, 0, 2031, 0, 2152, 0, 1, 1 
         dw  2711, 2415, 2152, 2031, 2152, 2031, 2152, 2031, 2152, 2031, 2152, 2031, 2152, 2031, 2152, 2031, 1917, 0, 1809, 0, 1, 1, 1, 1, 1, 555

.code 
; #### MENU SECTION ####
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
        
        jmp sound
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
        
        call     chooseStage
        
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
        je      clearScreen
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
; #### END MENU SECTION ####


; #### Utils ####
clearScreen:
    mov di ,0
    mov ax ,0b800h
    mov es ,ax
    cld
    mov ah ,0h
    mov al ,' '
    mov cx ,80 * 25
    rep stosw
    jmp done
    ret




; #### GAME SECTION ####


        

done: 
end main