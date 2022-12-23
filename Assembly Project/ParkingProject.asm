org 100h
   .data
StartMessage db "Enter The Amount Of Paid Money or Enter '0' if you want to leave: $" 

wrongInput db "Wrong Value $"

Expirymessage db "Your Period Has Expired.... $ "   


.code

mov ax,@data
mov ds, ax ;load @data in data segement
                          

Userinput:


;Displaying Start Message            
lea dx,StartMessage
mov ah,09h
int 21h

mov dl,10 
mov bl,0 

scanNum:

      mov ah, 01h
      int 21h

      cmp al, 13   ; Terminates Loop if "ENTER KEY"
      je  Return 

      mov ah, 0  
      sub al, 48   ; ASCII

      mov cl, al
      mov al, bl   

      mul dl       

      add al, cl   
      mov bl, al

      jmp scanNum

Return:

mov ax,0
out 199,ax

cmp bl, 1                    
jne if5pounds                
mov     cx, 4ch   ; 5 sec
mov     dx, 4b40h
jmp endif

if5pounds: 
cmp bl, 5
jne if10pounds
mov     cx, 1c9h   ; 30 sec
mov     dx, 0c380h
jmp endif

if10pounds:
cmp bl, 0Ah
jne wrongentry
mov     cx, 393h   ; 60 sec
mov     dx, 8700h
jmp endif


endif:

;Newline                     
mov dx,13
mov ah,2
int 21h  
mov dx,10
mov ah,2
int 21h

;wait function
mov ah,86h
int 15h

;types Expired When Time is Finished
lea dx,Expirymessage
mov ah,09h
int 21h
mov ax,1
out 199,ax

jmp Final

wrongentry:
cmp bl,0h
je END

;Newline                     
mov dx,13
mov ah,2
int 21h  
mov dx,10
mov ah,2
int 21h

lea dx,wrongInput
mov ah,09h
int 21h


Final:

;Newline                     
mov dx,13
mov ah,2
int 21h  
mov dx,10
mov ah,2
int 21h
call Userinput 

END:
hlt