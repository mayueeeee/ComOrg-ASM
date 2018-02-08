.model  tiny

.data
    row     DB     -1        ; row count (Horizontal)
    col     DB     79        ; column count (Vertical)
    dir     DB     1        ; direction (-1=reverse 1=forward)


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
    ; Delay for 10000 microseconds
    delay:
        mov   ah, 86h
        mov   cx, 0000h ;start
        mov   dx, 4E20h ;stop
        int   15h  
    
    checkPos:
        ;Inc/Dec column with direction
        mov al,dir
        mov bl,row
        add al,bl
        mov row,al
        ; Check line is blank. If blank,increse column
        cmp row, -2 
        je incRow
        ; Check line is full. If full,decrese column back
        cmp row ,26 
        jl print ;Print until line full
        je decRow

changeDirection:
    incRow:
        dec col 
        cmp col ,-1
        je endNaJa
        mov dir,1
        jmp drawLine

    decRow:
        dec col
        cmp col ,-1
        je endNaJa
        mov dir,-1
        jmp drawLine

print:
    printChar:
        mov     ah, 09h         ; write character at cursor position.
        mov     al, 'O'         ; O Char
        mov     bl, 09h         ; set color to light blue
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