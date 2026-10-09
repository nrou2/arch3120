
INCLUDE Irvine32.inc
.data
loss BYTE "You Lose",0
vic BYTE "You Win",0
phealth DWORD 100
dhealth DWORD 335
strength DWORD 25
dstrength DWORD 15
input DWORD 1
mp DWORD 100 
fullheal DWORD 1
prompt1 BYTE "enter 1 - Basic Attack 2 - Strengthen Self (costs 10, strength+10) 3 - Heal Self (costs 25, heal up to 50) 4 - Weaken Enemy (costs 15, reduce strength) 5 - Full Heal Item (free, only one) 6 - Icicle Spell (Costs 25)",0
prompt2 BYTE "Your current health: ",0
prompt3 BYTE "Your current mana: ",0
prompt4 BYTE "Enemy current health: ",0
prompt5 BYTE "Move failed, you can't afford it!",0
prompt6 BYTE "Enemy strength can't go any lower than 5!",0
prompt7 BYTE "Enemy current strength: ",0
prompt8 BYTE "You already used that!",0
prompt9 BYTE "Enemy attacked for ",0
prompt10 BYTE "You used a basic attack dealing ",0
prompt11 BYTE "You used a spell dealing ",0
prompt12 BYTE "You healed 50 damage.",0
prompt13 BYTE "You used your full heal up.",0
prompt14 BYTE "You reduced the enemy strength.",0
prompt15 BYTE "You raised your own strength!",0
prompt16 BYTE "Your current strength: ", 0
.code
main PROC


mov eax, white + (black * 16)
call SetTextColor

jmp turn


turn:
mov edx,OFFSET prompt1
call WriteString
call Crlf
call Crlf
mov edx,OFFSET prompt2
call WriteString
call Crlf
mov eax, green + (black * 16)
call SetTextColor
mov eax, phealth
call WriteInt
call Crlf
mov eax, white + (black * 16)
call SetTextColor
mov edx,OFFSET prompt3
call WriteString
call Crlf
mov eax, blue + (black * 16)
call SetTextColor
mov eax, mp
call WriteInt
call Crlf
mov eax, white + (black * 16)
call SetTextColor
mov edx,OFFSET prompt4
call WriteString
call Crlf
mov eax, green + (black * 16)
call SetTextColor
mov eax, dhealth
call WriteInt
call Crlf
mov eax, white + (black * 16)
call SetTextColor
mov edx,OFFSET prompt16
call WriteString
call Crlf
mov eax, strength
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
cmp input, 7
jz attack
;Force default attack if the input is over 6

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

dec input
jz ice



attack:
mov eax, green + (black * 16)
call SetTextColor
call Randomize
call Crlf
mov edx,OFFSET prompt10
call WriteString

mov eax, 7
call RandomRange
sub eax, 3
;Random variation of +- 3 in player basic attack, consistency can be gained through using spell attack instead

mov ebx, dhealth
sub ebx, strength
sub ebx, eax
mov dhealth, ebx



add eax, strength
call WriteInt
call Crlf

mov eax, white + (black * 16)
call SetTextColor

cmp dhealth, 0
jle win
jmp enemy

buff:

mov eax, mp
sub eax, 10
cmp eax,0
call Crlf
JGE buffsuccess
mov eax, red + (black * 16)
call SetTextColor
mov edx,OFFSET prompt5

call Crlf
call WriteString
call Crlf

mov eax, white + (black * 16)
call SetTextColor
jmp enemy

buffsuccess:
mov eax, mp
sub eax, 10
mov mp, eax
mov eax, green + (black * 16)
call SetTextColor
add strength,10
mov edx,OFFSET prompt15
call WriteString
call CRLF
mov eax, white + (black * 16)
call SetTextColor
jmp enemy

heal:
mov eax, mp
sub eax, 50
cmp eax,0

JGE healsuccess
call crlf
mov eax, red + (black * 16)
call SetTextColor
mov edx,OFFSET prompt5
call WriteString
call Crlf
mov eax, white + (black * 16)
call SetTextColor
jmp enemy


healsuccess:
mov eax, mp
sub eax, 50
mov mp, eax

add phealth, 50
cmp phealth, 100
mov eax, green + (black * 16)
call SetTextColor
mov edx,OFFSET prompt12
call CRLF
call WriteString
call CRLF
mov eax, white + (black * 16)
call SetTextColor

JGE healcap
jmp enemy

healcap:
mov phealth,100
jmp enemy


debuff:

mov eax, mp
sub eax, 15
cmp eax,0

JGE debuffsuccess
mov eax, red + (black * 16)
call SetTextColor
mov edx,OFFSET prompt5

call Crlf
call WriteString

call Crlf
mov eax, white + (black * 16)
call SetTextColor
jmp enemy


debuffsuccess:
call CRLF
mov eax, green + (black * 16)
call SetTextColor
mov eax, mp
sub eax, 15
mov mp, eax
sub dstrength, 3
mov edx,OFFSET prompt14
call WriteString
call CRLF

mov eax, white + (black * 16)
call SetTextColor
mov eax, dstrength
cmp eax, 5
jl debuffcap
jmp enemy

debuffcap:
mov dstrength, 5
mov eax, yellow + (black * 16)
call SetTextColor
mov edx,OFFSET prompt6
call WriteString
call Crlf
mov eax, white + (black * 16)
call SetTextColor
jmp enemy

item:
cmp fullheal, 0
JNZ itemsuccess
mov eax, red + (black * 16)
call SetTextColor


call Crlf
mov edx,OFFSET prompt8
call WriteString

call Crlf
mov eax, white + (black * 16)
call SetTextColor

jmp enemy


itemsuccess:
call CRLF
mov eax, green + (black * 16)
call SetTextColor
mov fullheal,0
mov phealth, 100
mov edx,OFFSET prompt13
call WriteString
call CRLF
mov eax, white + (black * 16)
call SetTextColor
jmp enemy

ice:
mov eax, mp
sub eax, 25
cmp eax,0

JGE icesuccess

mov eax, red + (black * 16)
call SetTextColor
mov edx,OFFSET prompt5
call Crlf
call WriteString
call Crlf
mov eax, white + (black * 16)
call SetTextColor

jmp enemy


icesuccess:
call CRLF
mov eax, green + (black * 16)
call SetTextColor
sub mp, 25

mov eax, strength
mov ebx, 2
mul ebx
add eax, 3

mov ebx, dhealth
sub ebx, eax
mov dhealth, ebx

mov edx,OFFSET prompt11
call WriteString

call WriteInt
mov eax, white + (black * 16)
call SetTextColor
call CRLF


cmp ebx, 0
jle win
jmp enemy


enemy:
mov eax, red + (black * 16)
call SetTextColor
call Randomize
call Crlf
call Crlf
mov edx,OFFSET prompt9
call WriteString

mov eax, 10
call RandomRange
mov ebx, phealth
sub ebx, dstrength
sub ebx, eax
mov phealth, ebx



add eax, dstrength
call WriteInt
call Crlf
call CRLF

mov eax, white + (black * 16)
call SetTextColor

cmp phealth,0
jle lose
jmp turn


win:
mov eax, green + (black * 16)
call SetTextColor
mov edx,OFFSET vic
call WriteString
jmp done

lose:
mov eax, red + (black * 16)
call SetTextColor
mov edx,OFFSET loss
call WriteString
jmp done

done:
INVOKE ExitProcess,0
main ENDP
END main
