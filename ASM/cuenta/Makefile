# Dependencies
# SDCC Small Device C Compiler
# pk2cmd for pickit pic programmers

# C compiler variables
SRC=*.c
CC=sdcc
FAMILY=pic16
PROC=18f4550

# ASM and program variables
PPROC=PIC18F4550
ASMPROC=18F4550

all: $(SRC:.c=.hex)

comp: $(SRC)
	$(CC) --use-non-free -m$(FAMILY) -p$(PROC) $^

clean:
	rm -f $(SRC:.c=.asm) $(SRC:.c=.cod) $(SRC:.c=.hex) $(SRC:.c=.lst) $(SRC:.c=.o)

program:
	pk2cmd -M -P${PPROC} -X -Fmain.hex

asm: *.asm
	gpasm -p ${ASMPROC} -o main.hex $^

asmp: asm program

.PHONY: all clean
