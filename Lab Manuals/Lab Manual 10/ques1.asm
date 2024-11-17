[org 0x0100]

jmp start

; Messages to prompt user input
prompt_name:        db 'Enter your name:$'
prompt_roll:        db 'Enter your roll number:$'
prompt_course:      db 'Enter your course name:$'
prompt_section:     db 'Enter your section:$'

; Buffers for storing user input
name_buffer:        db 80           ; Max length
                    db 0            ; Length byte
                    times 80 db 0   ; Actual buffer space for name
roll_buffer:        db 80           ; Max length
                    db 0            ; Length byte
                    times 80 db 0   ; Actual buffer space for roll number
course_buffer:      db 80           ; Max length
                    db 0            ; Length byte
                    times 80 db 0   ; Actual buffer space for course name
section_buffer:     db 80           ; Max length
                    db 0            ; Length byte
                    times 80 db 0   ; Actual buffer space for section

start:
    ; Get user's name
    mov dx, prompt_name
    mov ah, 9              ; DOS service 9 to display string
    int 0x21

    mov dx, name_buffer
    mov ah, 0x0A           ; DOS buffered input service
    int 0x21

    ; Append '$' at the end of input in name buffer
    mov bh, 0
    mov bl, [name_buffer+1]    ; Get the length of the name input
    mov byte [name_buffer+2+bx], '$'

    ; Get user's roll number
    mov dx, prompt_roll
    mov ah, 9
    int 0x21

    mov dx, roll_buffer
    mov ah, 0x0A
    int 0x21

    ; Append '$' at the end of input in roll buffer
    mov bh, 0
    mov bl, [roll_buffer+1]
    mov byte [roll_buffer+2+bx], '$'

    ; Get user's course name
    mov dx, prompt_course
    mov ah, 9
    int 0x21

    mov dx, course_buffer
    mov ah, 0x0A
    int 0x21

    ; Append '$' at the end of input in course buffer
    mov bh, 0
    mov bl, [course_buffer+1]
    mov byte [course_buffer+2+bx], '$'

    ; Get user's section
    mov dx, prompt_section
    mov ah, 9
    int 0x21

    mov dx, section_buffer
    mov ah, 0x0A
    int 0x21

    ; Append '$' at the end of input in section buffer
    mov bh, 0
    mov bl, [section_buffer+1]
    mov byte [section_buffer+2+bx], '$'

    ; Terminate program
    mov ax, 0x4c00
    int 0x21