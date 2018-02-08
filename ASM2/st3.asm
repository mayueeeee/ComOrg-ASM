.model  tiny

.data
    row     DB     24        ; row count (Horizontal)
    col     DB     0        ; column count (Vertical)
    dir     DB     -1        ; direction (-1=reverse 1=forward)


.code
    org     0100h
main:    
    mov     ah, 00h         ; set video mode
    mov     al, 03h         ; set to 80x25
    int     10h

    mov     ah, 02h         ; Set cursor
    mov     bh, 00h
    mov     dh, 0           ; X position
    mov     dl, 0           ; Y position
    int     10h

jmp moveCursor
; Loop for create row
drawLine:
    ; Delay for 20000 microseconds
    delay:
        mov   ah, 86h
        mov   cx, 0000h ;start
        mov   dx, 4E20h ;stop
        int   15h  
    
    checkPos:
        ;Inc/Dec row with direction
        mov al,dir
        mov bl,row
        add al,bl
        mov row,al
        ; Check line is blank. If blank,row column
        cmp row, -1 
        je incRow
        ; Check line is full. If full,decrese row back
        cmp row ,26 
        jl print ;Print until line full
        je decRow

changeDirection:
    incRow:
        inc col ;Add col
        cmp col ,80
        je endNaJa
        mov dir,1
        jmp drawLine

    decRow:
        inc col ;Add col
        cmp col ,80
        je endNaJa
        mov dir,-1
        jmp drawLine

print:
    printChar:
        mov     ah, 09h         ; write character at cursor position.
        mov     al, 'O'         ; O Char
        mov     bl, 0ah         ; set color to light green
        mov     cx, 1h          ; write 1 character
        int     10h
    ; jmp changeDirection    
    moveCursor:
        mov ah, 02h
        mov dh, row
        mov dl, col
        mov ah, 2
        int 10h 
    hideCursor:
        mov     ch, 32
        mov     ah, 1
        int     10h
    jmp drawLine

endNaJa:
    ;  clear screen
    ; mov   ah, 6h
    ; mov   al, 0h       ; clear whole screen
    ; mov   bh, 7h
    ; mov   cx, 0h
    ; mov   dx, 184fh
    ; int   10h
    ret
    end     main