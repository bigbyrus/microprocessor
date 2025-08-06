#include <stdint.h>
#include <stdio.h>

int printBinary16(uint16_t num){
    for(int i = 15; i >= 0; i--){
        printf("%c", (num & (1 << i)) ? '1' : '0');
    }
    printf("\n");
    return 0;
}

int printBinary8(uint8_t num){
    for(int i = 7; i >= 0; i--){
        printf("%c", (num & (1 << i)) ? '1' : '0');
    }
    printf("\n");
    return 0;
}

/* ONLY 8-BIT DATA VALUES */
uint16_t fix2float(uint16_t raw){
    uint8_t index;
    int8_t int_part = (int8_t)(raw >> 8);
    uint8_t frac_part = raw & 0x00FF;
    int8_t mask = (int_part >> 7);
    int8_t abs_val = (int_part^mask) - mask;
    printf("abs_val: ");
    printBinary8(abs_val);

    for(int i=7; i>=0; i--){
        if((abs_val >> i) & 0x0001 == 0x0001){
            index = i;
            break;
        }
    }
    printf("index: ");
    printBinary8(index);
    uint8_t new;
    uint8_t fill;
    uint8_t temp;
    uint8_t exp;
    /* if index is >= to 3: shift decimal bits right by 'temp' */
    /* then fill in the top decimal bits with the bottom 'temp' bits of the int part */
    /* NEW holds updated frac_part                             */
    /* ABS_VAL holds updated abs_val part */
    if(index>=3){
        temp = index-2;
        frac_part = frac_part>>temp;
        uint8_t temp2mask = (2<<temp)-1;
        fill = abs_val&temp2mask;
        fill = fill<<(8-temp);
        frac_part = frac_part|fill;
        abs_val = abs_val>>temp;
    }
    /* else fill the bottom 'temp' bits of int part with */
    /* the top 'temp' bits of the frac_part              */
    /* abs_val holds updated INT_PART */
    /* frac_part holds updated frac_part */
    else{
        temp = 2-index;
        if(temp == 2){
            temp = 0xC0;
            fill = frac_part&temp;
            fill = fill>>6;
            abs_val = abs_val<<2;
            abs_val = abs_val|fill;
            frac_part = frac_part<<2;
            printf("abs_val: ");
            printBinary8(abs_val);
            printf("frac_part: ");
            printBinary8(frac_part);
        }
        else if(temp == 1){
            temp = 0x80;
            fill = frac_part&temp;
            fill = fill>>7;
            abs_val = abs_val<<1;
            abs_val = abs_val|fill;
            frac_part = frac_part<<1;
            printf("abs_val: ");
            printBinary8(abs_val);
            printf("frac_part: ");
            printBinary8(frac_part);
        }
    }
    /* AT THIS POINT, mantissa bits are set. */
    /* Set the TOP 6 BITS of abs_val to zero */
    /* Then set exponent and sign bit, exponent = index+15 */
    uint8_t mask2 = 0x03;
    abs_val = mask2&abs_val;
    exp = index+15;
    exp = exp<<2;
    abs_val = exp|abs_val;
    if(mask&0x01 == 0x00){
        printf("RESULT\n");
        printBinary8(abs_val);
        printBinary8(frac_part);
        return 0;
    }
    else{
        abs_val = abs_val|0x80;
        printf("RESULT\n");
        printBinary8(abs_val);
        printBinary8(frac_part);
    }
    return 0;
}

int main(){
    uint16_t raw = 0x0020;
    
    printf("Raw: ");
    printBinary16(raw);
    fix2float(raw);

    
    return 0;
}
