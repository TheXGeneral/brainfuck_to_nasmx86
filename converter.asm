bits 32
global start
extern exit,fopen,fread,fprintf,fclose
import exit msvcrt.dll 
import fopen msvcrt.dll 
import fread msvcrt.dll 
import fprintf msvcrt.dll 
import fclose msvcrt.dll
segment data use32 class=data
    file_name db "input.txt", 0
    access_mode db "r", 0
    input_file_descriptor dd -1
    output_file_name db "converted_code.txt",0
    output_access_mode db 'w+',0
    output_file_descriptor dd -1
    sign db 0
    start_code db "bits 32",10,"global start",10,"extern exit,printf,scanf",10,"import exit msvcrt.dll",10,"import printf msvcrt.dll",10,"import scanf msvcrt.dll",10,"segment data use32 class=data",10,"   data_segment times 30000 db 0",10,"   format db ",34 ,"%%","c" ,34,",0",10,"segment code use32 class=code",10,"start:",10,"   mov ESI,data_segment",10,0
    end_code db "   push dword 0",10,"   call [exit]",0
    instruction_1 db "inc ESI",10,0
    instruction_2 db "dec ESI",10,0
    instruction_3 db "inc byte [ESI]",10,0
    instruction_4 db "dec byte [ESI]",10,0
    
    instruction_5_1 db "pushad",10,0
    instruction_5_2 db "mov EAX,0",10,0
    instruction_5_3 db "mov AL,[ESI]",10,0
    instruction_5_4 db "push dword EAX",10,0
    instruction_5_5 db "push dword format",10,0
    instruction_5_6 db "call [printf]",10,0
    instruction_5_7 db "add esp,4*2",10,0
    instruction_5_8 db "popad",10,0
    
    instruction_6_1 db "pushad",10,0
    instruction_6_2 db "push dword ESI",10,0
    instruction_6_3 db "push dword format",10,0
    instruction_6_4 db "call [scanf]",10,0
    instruction_6_5 db "add esp,4*2",10,0
    instruction_6_6 db "popad",10,0
    
    instruction_7_1 db "loop_",0
    instruction_7_2 db ":",10,0
    
    instruction_8_1 db "cmp byte [ESI],0",10,0
    instruction_8_2 db "jg loop_",0
    
    number_print_format db "%d",0
    endl_print_format db 10,0
    number_of_loops dw 0
    active_loops times 1000 dw 0
    indentation db "   ",0
segment code use32 class=code
indent:
    mov EAX,EDI
    sub EAX,active_loops
    mov DX,0
    mov BX,2
    div BX
    inc AX
    cmp AX,0
    je to_return
    do_indent:
        pushad 
        push indentation
        push dword [output_file_descriptor]
        call [fprintf]
        add esp, 4*2
        popad
        dec AX
        cmp AX,0
        jne do_indent
    to_return:
    ret
start:
    push dword access_mode
    push dword file_name
    call [fopen]
    add esp, 4*2       
    cmp eax, 0                  
    je final
    mov [input_file_descriptor], eax
    
    push dword output_access_mode
    push dword output_file_name
    call [fopen]
    add esp, 4*2       
    cmp eax, 0                  
    je final
    mov [output_file_descriptor], eax
    pushad
        push dword start_code
        push dword [output_file_descriptor]
        call [fprintf]
        add esp, 4*2
        popad 
    mov EDI,active_loops
        bucla:
            pushad
                ;this will read a single char
                push dword [input_file_descriptor]
                push dword 1
                push dword 1
                push dword sign
                call [fread]
                add esp, 4*4
                cmp eax, 0 
                je cleanup
            popad
            case_1:
                cmp byte [sign],'>'
                jne case_2
                pushad
                call indent
                push dword instruction_1
                push dword [output_file_descriptor]
                call [fprintf]
                add esp, 4*2
                popad 
                jmp next_letter
            case_2:
                cmp byte [sign],'<'
                jne case_3
                pushad
                call indent
                push dword instruction_2
                push dword [output_file_descriptor]
                call [fprintf]
                add esp, 4*2
                popad
                jmp next_letter
            case_3:
                cmp byte [sign],'+'
                jne case_4
                pushad
                call indent
                push dword instruction_3
                push dword [output_file_descriptor]
                call [fprintf]
                add esp, 4*2
                popad
                jmp next_letter
            case_4:
                cmp byte [sign],'-'
                jne case_5
                pushad
                call indent
                push dword instruction_4
                push dword [output_file_descriptor]
                call [fprintf]
                add esp, 4*2
                popad
                jmp next_letter
            case_5:
                cmp byte [sign],'.'
                jne case_6
                pushad
                call indent
                push dword instruction_5_1
                push dword [output_file_descriptor]
                call [fprintf]
                add esp, 4*2
                call indent
                push dword instruction_5_2
                push dword [output_file_descriptor]
                call [fprintf]
                add esp, 4*2
                call indent
                push dword instruction_5_3
                push dword [output_file_descriptor]
                call [fprintf]
                add esp, 4*2
                call indent
                push dword instruction_5_4
                push dword [output_file_descriptor]
                call [fprintf]
                add esp, 4*2
                call indent
                push dword instruction_5_5
                push dword [output_file_descriptor]
                call [fprintf]
                add esp, 4*2
                call indent
                push dword instruction_5_6
                push dword [output_file_descriptor]
                call [fprintf]
                add esp, 4*2
                call indent
                push dword instruction_5_7
                push dword [output_file_descriptor]
                call [fprintf]
                add esp, 4*2
                call indent
                push dword instruction_5_8
                push dword [output_file_descriptor]
                call [fprintf]
                add esp, 4*2
                popad
                jmp next_letter
            case_6:
                cmp byte [sign], ','
                jne case_7
                pushad
                call indent
                push dword instruction_6_1
                push dword [output_file_descriptor]
                call [fprintf]
                add esp, 4*2
                call indent
                push dword instruction_6_2
                push dword [output_file_descriptor]
                call [fprintf]
                add esp, 4*2
                call indent
                push dword instruction_6_3
                push dword [output_file_descriptor]
                call [fprintf]
                add esp, 4*2
                call indent
                push dword instruction_6_4
                push dword [output_file_descriptor]
                call [fprintf]
                add esp, 4*2
                call indent
                push dword instruction_6_5
                push dword [output_file_descriptor]
                call [fprintf]
                add esp, 4*2
                call indent
                push dword instruction_6_6
                push dword [output_file_descriptor]
                call [fprintf]
                add esp, 4*2
                popad
                jmp next_letter
            case_7:
                cmp byte [sign],'['
                jne case_8
                ;Print loop_<nr_of_loops>:
                pushad
                
                call indent
                push dword instruction_7_1
                push dword [output_file_descriptor]
                call [fprintf]
                add esp, 4*2
                
                mov EAX,0
                mov AX,[number_of_loops]
                push EAX
                push number_print_format
                push dword [output_file_descriptor]
                call [fprintf]
                add ESP,4*3
                push dword instruction_7_2
                push dword [output_file_descriptor]
                call [fprintf]
                add esp, 4*2
                popad
                mov EAX,0
                mov AX,[number_of_loops]
                cld
                stosw
                inc word [number_of_loops]
                jmp next_letter
            case_8:
                cmp byte [sign],']'
                jne next_letter
                mov EAX,0
                mov AX,[EDI-2]
                pushad
                call indent
                push dword instruction_8_1
                push dword [output_file_descriptor]
                call [fprintf]
                add esp, 4*2
                call indent
                push dword instruction_8_2
                push dword [output_file_descriptor]
                call [fprintf]
                add esp, 4*2
                popad
                pushad
                push EAX
                push number_print_format
                push dword [output_file_descriptor]
                call [fprintf]
                add ESP,4*3
                
                push dword endl_print_format
                push dword [output_file_descriptor]
                call [fprintf]
                add esp, 4*2
                popad
                sub EDI,2
            next_letter:
            jmp bucla
      cleanup:
        pushad
        push dword end_code
        push dword [output_file_descriptor]
        call [fprintf]
        add esp, 4*2
        popad
        
        push dword [input_file_descriptor]
        call [fclose]
        add esp, 4
         push dword [output_file_descriptor]
        call [fclose]
        add esp, 4
    final:
    push dword 0
    call [exit]


    