.model  tiny   
    org     0100h      
         
.data
    randCh    db  0         ; for store random char
    colPos    db  80 dup(0) ; array for store head position
    seed      db  ?         ; seed variable
          
.code
main:
    ; Get system time
    mov   ah, 0h
    int   1ah

    ; Seed generator (Random from Stackoverflow :3)
    mov   ax, dx      ; copy Low-order part of clock count to ax as dividend (TouTang)
    xor   dx, dx      ; Ar-rai-mai-roo
    mov   cx, 80      ; 79-0+1 (Random ma jaa)
    div   cx          ; divide with 80 in cx
    mov   seed, dl    ; copy remander(sed) to dl
    mov   si, 79      ; set last array position

; Gen head pos
initHead:                          
    mov   dl, seed          
    mov   colPos[si], dl          
    ; Random using Linear Congruence Generator (LCG) method
    ; seed = (7 * seed + 11) % 45
    ; don't use 25. it's not pretty!
    mov   dl, 7   
    mov   al, seed
    mul   dl          
    add   ax, 11
    mov   dl, 45       
    div   dl           
    mov   seed, ah ;use remainder ad seed
          
    ; if (headArr not full) do set seed again
    dec   si
    cmp   si, 0
    jge   initHead

initDisplay:
    mov     ah, 00h         ; set video mode
    mov     al, 03h         ; set to 80x25
    int     10h

    mov   bh, 0h
    mov   dh, 0h  ; set row to 0
    mov   dl, 0h  ; set col to 0
    int   10h

setPos: 
    ; move cursor
    mov   ah, 2h
    int   10h

    push  dx  
    mov   dh, 0
    mov   si, dx
    pop   dx

    mov   bl, colPos[si]  ;copy head to bl
    sub   bl, dh      ; Get delta from cursor to head

; Select color by position
selectColor:          
    ; White - far from head 1 char
    cmp   bl, 1       
    jc    setWhite
    jz    setWhite
    ; Light Green - far from head 4 char
    cmp   bl, 4
    jz    setLightGreen
    jc    setLightGreen
    ; Green - far from head 8 char
    cmp   bl, 8
    jc    setGreen
    jz    setGreen
    ; Light Green - far from head 12 char
    cmp   bl, 12 
    jc    setGray
    jz    setGray
    ; Black is not jet black, use for else
    jmp   setBlack

; Set color with select color then print!
setBlack:
    mov   bl, 00h
    jmp   printChar

setWhite:
    mov   bl, 0fh
    jmp   printChar

setGray:
    mov   bl, 08h
    jmp   printChar

setGreen:
    mov   bl, 02h 
    jmp   printChar
          
setLightGreen:
    mov   bl, 0ah 
    jmp   printChar

printChar:
    ; print random character
    mov   ah, 09h 
    mov   cx, 1
    mov   al, randCh
    int   10h
    call  randNewChar ; Random yaaaaaa~~~~~
    inc    dl           ; increse col
    cmp    dl, 80      
    jg    nextLine     ; if over line, go to next line
    jmp    setPos    ; if not, jump to set pos & print again!

nextLine:
    mov   dl, 0     ; Start col at 0
    cmp   dh, 24    
    jg   reset      ; if row is 25, reset it! (Over screen)
    inc   dh        ; if not, increse row
    jmp   setPos    ; Jump to set pos & print again!

reset:
    push  dx ; To prevent duplicate dx register value
    delay:
        mov   ah, 86h
        mov   cx, 0000h ;start
        mov   dx, 3A98h ;stop
        int   15h      
    pop   dx      ;  pop position back
    mov   dh, 0h  ; set row to row index 0
    ; int   10h
    ; reset index value
    mov   si, 0 

inRandRange:
    inc   colPos[si]      ; increase Pos
    cmp   colPos[si], 45   ; to prevent out of random range (cause screen like old TV with no signal)
    jl    isInScreen      ; if less, check is in screen
    mov   colPos[si], 0   ; else reset it to 0

isInScreen:
    inc   si            ; inc index
    cmp  si, 80        
    je   printChar      ; if index === 80, Screen is full, Restart
    jne  inRandRange  ; else inc pos and check range        

randNewChar:  
    ; push some register to stack to prevent boom!
    push  ax
    push  dx
    mov   dl, 32
    mov   al, randCh    ;Use prev char as seed
    mul   dl            
    add   ax, 4
    mov   dl, 93        ; divider by 93 (126-33)
    div   dl            
    mov   randCh, ah    ; set reminder as char
    add   randCh, 33    ; Start at 33 (random start from 0)
    pop   dx
    pop   ax
    ret

endNaJa:
    ;  clear screen
    mov   ah, 6h
    mov   al, 0h       ; clear whole screen
    mov   bh, 7h
    mov   cx, 0h
    mov   dx, 184fh
    int   10h
    ret
    end     main