#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>

#define MAX_LINES 100
#define MAX_LINE_LEN 100

/* Convert machine code to int */
uint8_t hexCharToValue(char c) {
    if ('0' <= c && c <= '9') return c - '0';
    else if ('a' <= c && c <= 'f') return 10 + (c - 'a');
    else if ('A' <= c && c <= 'F') return 10 + (c - 'A');
    else return 0;
}

/* Converts comp2s[] into uint16_t */
uint16_t hextoUint16(const char comp2s[3]) {
    uint8_t high = hexCharToValue(comp2s[0]);
    uint8_t low  = hexCharToValue(comp2s[1]);
    uint16_t result = ((high << 4) | low);
    result = result&(0x003F);
    return result;
}


/* Update the machine code to reflect */
/* the register used for Operand 1    */
uint16_t arithmetic_reg1(const char *op1, uint16_t base){
    if(strncmp(op1, "r1", 2) == 0){
        return base = base|0x0004;
    }
    else if(strncmp(op1, "r2", 2) == 0){
        return base = base|0x0008;
    }
    else if(strncmp(op1, "r3", 2) == 0){
        return base = base|0x000C;
    }
    else return base;
}

/* Update the machine code to reflect */
/* the register used for Operand 2    */
uint16_t arithmetic_reg2(const char *op2, uint16_t base){
    if(strncmp(op2, "r1", 2) == 0){
        return base = base|0x0001;
    }
    else if(strncmp(op2, "r2", 2) == 0){
        return base = base|0x0002;
    }
    else if(strncmp(op2, "r3", 2) == 0){
        return base = base|0x0003;
    }
    else return base;
}

/* Update the machine code to reflect */
/* the immediate use for Operand 2    */
uint16_t arithmetic_imm2(const char *op2, uint16_t base){
    if(strncmp(op2, "#1", 2) == 0){
        return base = base|0x0001;
    }
    else if(strncmp(op2, "#2", 2) == 0){
        return base = base|0x0002;
    }
    else if(strncmp(op2, "#3", 2) == 0){
        return base = base|0x0003;
    }
    else return base;
}

/* read through assembly code line by line and assemble */
int main() {
    FILE *file;
    char lines[MAX_LINES][MAX_LINE_LEN];
    int lineCount = 0;
    char opcode[4];
    char comp2s[3];
    char op1[3];
    char op2[3];


    /* open file as "file" object */
    file = fopen("program.txt", "r");
    if (file == NULL) {
        perror("Error opening file for reading");
        return 1;
    }


    /* store lines in "lines" array one by one        */
    /* replace new line character with null character */
    while (fgets(lines[lineCount], MAX_LINE_LEN, file) != NULL) {
        lines[lineCount][strcspn(lines[lineCount], "\n")] = '\0';
        lineCount++;
    }
    fclose(file);


    /* open the same file in write mode, will clear all data */
    file = fopen("program.txt", "w");
    if (file == NULL) {
        perror("Error opening file for writing");
        return 1;
    }


    /* process each line */
    for (int i = 0; i < lineCount; i++) {
        /* instruction points to array of characters */
        char *instruction = lines[i];

        /* operands points to characters after the Opcode */
        /* (excluding the leading white space)            */
        char *operands = instruction + 4;

        /* store the 2's comp number as a char array for processing */
        char *comp2 = instruction + 6;
        strncpy(comp2s, comp2, 2);
        comp2s[2] = '\0';


        /* op1 holds the first two characters after Opcode */
        /* (excluding white space)                         */
        strncpy(op1, operands, 2);
        op1[2] = '\0';

        /* op2 holds the Operand 2 for Arithmetic instructions ONLY */
        char *operand2 = operands + 4;
        strncpy(op2, operand2, 2);
        op2[2] = '\0';

        uint16_t res;

        /* isolate Opcodes for handling */
        strncpy(opcode, instruction, 3);
        opcode[3] = '\0';
        

        /* handle opcodes, update machine code */
        if(strcmp(opcode, "add") == 0){
            res = 0x0100;
            res = arithmetic_reg1(op1, res);
            res = arithmetic_reg2(op2, res);
        }
        else if(strcmp(opcode, "sub") == 0){
            res = 0x0110;
            res = arithmetic_reg1(op1, res);
            res = arithmetic_reg2(op2, res);
        } 
        else if(strcmp(opcode, "and") == 0){
            res = 0x0120;
            res = arithmetic_reg1(op1, res);
            res = arithmetic_reg2(op2, res);
        }
        else if(strcmp(opcode, "orr") == 0){
            res = 0x0130;
            res = arithmetic_reg1(op1, res);
            res = arithmetic_reg2(op2, res);
        }
        else if(strcmp(opcode, "lsl") == 0){
            res = 0x0140;
            res = arithmetic_reg1(op1, res);
            res = arithmetic_reg2(op2, res);
        }
        else if(strcmp(opcode, "asr") == 0){
            res = 0x0150;
            res = arithmetic_reg1(op1, res);
            res = arithmetic_reg2(op2, res);
        }
        else if(strcmp(opcode, "cmp") == 0){
            res = 0x0160;
            res = arithmetic_reg1(op1, res);
            res = arithmetic_reg2(op2, res);
        }
        else if(strcmp(opcode, "cmi") == 0){
            res = 0x0170;
            res = arithmetic_reg1(op1, res);
            res = arithmetic_imm2(op2, res);
        }
        else if(strcmp(opcode, "mov") == 0){
            res = 0x0180;
            res = arithmetic_reg1(op1, res);
            res = arithmetic_reg2(op2, res);
        }
        else if(strcmp(opcode, "mvi") == 0){
            res = 0x0190;
            res = arithmetic_reg1(op1, res);
            res = arithmetic_imm2(op2, res);
        }
        else if(strcmp(opcode, "ldr") == 0){
            res = 0x01A0;
            res = arithmetic_reg1(op1, res);
            res = arithmetic_reg2(op2, res);
        }
        else if(strcmp(opcode, "str") == 0){
            res = 0x01B0;
            res = arithmetic_reg1(op1, res);
            res = arithmetic_reg2(op2, res);
        }
        else if(strcmp(opcode, "lsi") == 0){
            res = 0x01C0;
            res = arithmetic_reg1(op1, res);
            res = arithmetic_imm2(op2, res);
        }
        else if(strcmp(opcode, "ori") == 0){
            res = 0x01D0;
            res = arithmetic_reg1(op1, res);
            res = arithmetic_imm2(op2, res);
        }
        else if(strcmp(opcode, "xor") == 0){
            res = 0x01E0;
            res = arithmetic_reg1(op1, res);
            res = arithmetic_reg2(op2, res);
        }
        else if(strcmp(opcode, "lsr") == 0){
            res = 0x01F0;
            res = arithmetic_reg1(op1, res);
            res = arithmetic_reg2(op2, res);
        }
        else if(strcmp(opcode, "bbb") == 0){
            res = 0x0000;
            res = hextoUint16(comp2s);
        }
        else if(strcmp(opcode, "bll") == 0){
            res = 0x0040;
            res = res | hextoUint16(comp2s);
        }
        else if(strcmp(opcode, "beq") == 0){
            res = 0x0080;
            res = res | hextoUint16(comp2s);
        }
        else if(strcmp(opcode, "blt") == 0){
            res = 0x00C0;
            res = res | hextoUint16(comp2s);
        }
        
        printf("res (hex): 0x%04X\n", res);
        for (int i = 8; i >= 0; i--) {
            fputc(((res & (1 << i)) ? '1' : '0'), file);
        }
        fputc('\n', file);
    }
    fclose(file);
    return 0;
}