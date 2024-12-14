JMPOK: lda 0x1c // load data 1
sta
sta
skz
hlt
lda 0x1d // load data 2
sta
sta
skz
jmp SKZ OK
sta
hlt
SKZ OK: lda 0x1c
sta
sta
skz // tai vi tri 0E cua thay
hlt
xor 0x1d
sta
sta
skz
jmp XOR OK
hlt
XOR OK: xor 0x1d
sta
sta
skz
hlt
hlt
DATA 1 = 00
DATA 2 = FF
TEMP   = AA

/******************************************************************************
 * Test program
 * 
 * Kết quả cần có: Chương trình sau kết thúc (halt) ở lệnh địa chỉ 17(hex)
 *****************************************************************************/

//opcode_operand  // addr                   assembly code
//--------------  // ----  -----------------------------------------------
@00 111_11110     //  00   BEGIN:   JMP TST_JMP
    000_00000     //  01            HLT        
    000_00000     //  02            HLT       
    101_11010     //  03   JMP_OK:  LDA DATA_1
    001_00000     //  04            SKZ
    000_00000     //  05            HLT        
    101_11011     //  06            LDA DATA_2
    001_00000     //  07            SKZ
    111_01010     //  08            JMP SKZ_OK
    000_00000     //  09            HLT        
    110_11100     //  0A   SKZ_OK:  STO TEMP   
    101_11010     //  0B            LDA DATA_1
    110_11100     //  0C            STO TEMP   
    101_11100     //  0D            LDA TEMP
    001_00000     //  0E            SKZ        
    000_00000     //  0F            HLT        
    100_11011     //  10            XOR DATA_2
    001_00000     //  11            SKZ        
    111_10100     //  12            JMP XOR_OK
    000_00000     //  13            HLT        
    100_11011     //  14   XOR_OK:  XOR DATA_2
    001_00000     //  15            SKZ
    000_00000     //  16            HLT        
    000_00000     //  17   END:     HLT        
    111_00000     //  18            JMP BEGIN  

@1A 00000000      //  1A   DATA_1:             (giá trị hằng 0x00)
    11111111      //  1B   DATA_2:             (giá trị hằng 0xFF)
    10101010      //  1C   TEMP:               (biến khởi tạo với giá trị 0xAA)

@1E 111_00011     //  1E   TST_JMP: JMP JMP_OK
    000_00000     //  1F            HLT