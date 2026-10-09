
INCLUDE Irvine32.inc
.data
loss BYTE "You Lose",0
vic BYTE "You Win",0
phealth DWORD 100
dhealth DWORD 250
strength DWORD 25
dstrength DWORD 20
input DWORD 1
mp DWORD 100 
prompt1 BYTE "enter 1 - attack 2 - raise attack (costs 10) 3 - heal 50 (costs 25) 4 - weaken enemy (costs 10) 5 - use full heal (free, one time only)",0
prompt2 BYTE "Your current health: ",0
prompt3 BYTE "Your current mana: ",0
prompt4 BYTE "Enemy current health: ",0
prompt5 BYTE "Move failed, you can't afford it!",0
prompt6 BYTE "Enemy strength can't go any lower than 5!"
prompt7 BYTE "Enemy current strength: ",0
.code
main PROC


jmp turn


turn:
mov edx,OFFSET prompt1
call WriteString
call Crlf
mov edx,OFFSET prompt2
call WriteString
call Crlf
mov eax, phealth
call WriteInt
call Crlf
mov edx,OFFSET prompt3
call WriteString
call Crlf
mov eax, mp
call WriteInt
call Crlf
mov edx,OFFSET prompt4
call WriteString
call Crlf
mov eax, dhealth
call WriteInt
call Crlf
mov edx,OFFSET prompt7
call WriteString
call Crlf
mov eax, dstrength
call WriteInt
call Crlf

call ReadInt
;I don't remember if we went over ReadInt specifically in class, but I assumed if ReadString works in one of our labs, there'd probably be a ReadInt, and that worked. Same with Writeint.
mov input, eax
cmp input, 5
jz attack
;Force default attack if the input is over 5

dec input
jz attack

dec input
jz buff

dec input
jz heal

dec input
jz debuff

dec input
jz item



attack:
mov eax, dhealth
sub eax, strength
mov dhealth, eax

jz win
jnz enemy

buff:
add strength,10
jmp enemy

heal:
mov eax, mp
sub eax, 50
cmp eax,0

JGE healsuccess

mov edx,OFFSET prompt5
call WriteString
call Crlf
jmp enemy


healsuccess:
mov eax, mp
sub eax, 50
mov mp, eax

add phealth, 50
cmp phealth, 100
JGE healcap
jmp enemy

healcap:
mov phealth,100
jmp enemy


debuff:
sub dstrength, 3
mov eax, dstrength
cmp eax, 5
jl debuffcap
jmp enemy

debuffcap:
mov dstrength, 5
mov edx,OFFSET prompt6
call WriteString
call Crlf
jmp enemy

item:
mov phealth, 100
jmp enemy


enemy:
mov eax, phealth
sub eax, dstrength
mov phealth, eax

jz lose
jmp turn


win:
mov edx,OFFSET vic
call WriteString
jmp done

lose:
mov edx,OFFSET loss
call WriteString
jmp done

done:
INVOKE ExitProcess,0
main ENDP
END main
