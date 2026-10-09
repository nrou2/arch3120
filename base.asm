
INCLUDE Irvine32.inc
.data
loss BYTE "You Lose",0
vic BYTE "You Win",0
phealth BYTE 100
dhealth BYTE 250
strength BYTE 25
input BYTE 1
mp BYTE 100 
prompt1 BYTE "enter 1 - attack 2 - raise attack (costs 10) 3 - heal 50 (costs 25) 4 - weaken enemy (costs 10) 5 - use full heal (free, one time only)",0
prompt2 BYTE "Your current health: "
prompt3 BYTE "Your current mana: "
prompt4 BYTE "Enemy current health: "
.code
main PROC


jmp turn


turn:
mov edx,OFFSET prompt1
call WriteString
mov edx,OFFSET prompt2
call WriteString
mov edx,OFFSET phealth
call WriteString
mov edx,OFFSET prompt3
call WriteString
mov edx,OFFSET mp
call WriteString
mov edx,OFFSET prompt4
call WriteString
mov edx,OFFSET dhealth
call WriteString

call ReadInt
;I don't remember if we went over ReadInt specifically in class, but I assumed if ReadString works in one of our labs, there'd probably be a ReadInt, and that worked.
mov input, eax



attack:

buff:

heal:

debuff:

item:


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
