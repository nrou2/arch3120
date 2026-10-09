INCLUDE Irvine32.inc
.data
loss BYTE "You Lose",0
vic BYTE "You Win",0
.code
main PROC


jmp win



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
