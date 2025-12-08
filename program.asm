
dump.so:	file format elf64-bpf

Disassembly of section .text:

0000000000000120 <entrypoint>:
      36:	18 00 00 00 00 00 00 00 00 00 00 00 03 00 00 00	r0 = 0x300000000 ll ; idk what that means
      38:	79 12 00 00 00 00 00 00	r2 = *(u64 *)(r1 + 0x0) ; read the first 8 bytes (len of accounts)
      39:	55 02 15 00 00 00 00 00	if r2 != 0x0 goto +0x15 <entrypoint+0xc8> ; assert the len of the accounts is 0 (no accounts required in this instruction) / otherwise, exit
      40:	79 12 08 00 00 00 00 00	r2 = *(u64 *)(r1 + 0x8) ; load the length of the instruction data in the second registry;
      41:	55 02 0e 00 10 00 00 00	if r2 != 0x10 goto +0xe <entrypoint+0xa0> ; the size of the data should be 16 bytes (i.e. that means two u64 numbers) / otherwise, not-haha
      42:	79 12 10 00 00 00 00 00	r2 = *(u64 *)(r1 + 0x10) ; load the first number into the r2 registry
      43:	18 03 00 00 00 00 00 00 00 00 00 00 00 ff ff ff	r3 = -0x10000000000 ll ; load this number into r3
      45:	5f 32 00 00 00 00 00 00	r2 &= r ; remove the last 40 bits of the number /using the number above/ (optimization ig?)
      46:	18 03 00 00 00 00 00 00 00 00 00 00 00 9b 6a d6	r3 = -0x2995650000000000 ll ; very specific number being loaded into r3 right here
      48:	af 32 00 00 00 00 00 00	r2 ^= r3 ; XOR the number in r2 and r3 and keep the result into r2
      49:	79 11 18 00 00 00 00 00	r1 = *(u64 *)(r1 + 0x18) ; read the second number from the r1 registry and keep it there (r1 becomes just the number)
      50:	4f 12 00 00 00 00 00 00	r2 |= r1 ; OR r2 and r1
      51:	55 02 04 00 00 00 00 00	if r2 != 0x0 goto +0x4 <entrypoint+0xa0> ; assert, after all this operations, that the value of r2 is zero / otherwise not haha
      52:	18 01 00 00 f0 01 00 00 00 00 00 00 00 00 00 00	r1 = 0x1f0 ll ; load the HAHA message probably
      54:	b7 02 00 00 11 00 00 00	r2 = 0x11
      55:	05 00 03 00 00 00 00 00	goto +0x3 <entrypoint+0xb8>
      56:	18 01 00 00 01 02 00 00 00 00 00 00 00 00 00 00	r1 = 0x201 ll ; load the not haha message ;(
      58:	b7 02 00 00 22 00 00 00	r2 = 0x22
      59:	85 10 00 00 ff ff ff ff	call -0x1 ; call the logging function?
      60:	b7 00 00 00 00 00 00 00	r0 = 0x0
      61:	95 00 00 00 00 00 00 00	exit
