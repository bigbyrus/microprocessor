/*----------------------------------------------------------*/
/*																				*/
/* Module: Instruction Memory 										*/
/* Input: Program Counter     										*/
/* Output: 9-bit Machine Code 										*/
/* 																			*/
/* The purpose of this module is to retrieve machine code	*/
/* to be decoded. All instructions are hard coded based on  */
/* results given by assembler											*/
/*																				*/
/*----------------------------------------------------------*/

module InstROM19(
  input       [ 7:0] prog_ctr,
  output logic[ 8:0] mach_code);
	 
  always_comb 
	case (prog_ctr)
		0 : mach_code = 'b110011100;
		1 : mach_code = 'b110100011;
		2 : mach_code = 'b110011101;
		3 : mach_code = 'b110100111;
		4 : mach_code = 'b110001101;
		5 : mach_code = 'b110011011;
		6 : mach_code = 'b111001001;
		7 : mach_code = 'b111011001;
		8 : mach_code = 'b101011110;
		9 : mach_code = 'b110011011;
		10 : mach_code = 'b111001010;
		11 : mach_code = 'b111011010;
		12 : mach_code = 'b110111110;
		13 : mach_code = 'b111100111;
		14 : mach_code = 'b101111100;
		15 : mach_code = 'b010000011;
		16 : mach_code = 'b110011001;
		17 : mach_code = 'b100000110;
		18 : mach_code = 'b110011011;
		19 : mach_code = 'b111001001;
		20 : mach_code = 'b111011001;
		21 : mach_code = 'b110011111;
		22 : mach_code = 'b111001110;
		23 : mach_code = 'b111011111;
		24 : mach_code = 'b110110011;
		25 : mach_code = 'b110000001;
		26 : mach_code = 'b110011110;
		27 : mach_code = 'b111001111;
		28 : mach_code = 'b110110111;
		29 : mach_code = 'b110011101;
		30 : mach_code = 'b101111000; // cmi r2, #0
		31 : mach_code = 'b010001000; 
		32 : mach_code = 'b111110110;
		33 : mach_code = 'b100100111;
		34 : mach_code = 'b101100111;
		35 : mach_code = 'b010000100;
		36 : mach_code = 'b100011011;
		37 : mach_code = 'b110000100;
		38 : mach_code = 'b000111000;
		39 : mach_code = 'b110010110;
		40 : mach_code = 'b111000111;
		41 : mach_code = 'b111010101;
		42 : mach_code = 'b110111001;
		43 : mach_code = 'b101111011;
		44 : mach_code = 'b011011110;
		45 : mach_code = 'b110010010;
		46 : mach_code = 'b100011000;
		47 : mach_code = 'b110010111;
		48 : mach_code = 'b111000110;
		49 : mach_code = 'b111010111;
		50 : mach_code = 'b110100001;
		51 : mach_code = 'b111110010;
		52 : mach_code = 'b110010101; //mvi r1, #1
		53 : mach_code = 'b101000110;
		54 : mach_code = 'b100010111;
		55 : mach_code = 'b111001111;
		56 : mach_code = 'b110111011;
		57 : mach_code = 'b110011110;
		58 : mach_code = 'b111001111;
		59 : mach_code = 'b110101011;
		60 : mach_code = 'b100100110;
		61 : mach_code = 'b110011110;
		62 : mach_code = 'b111001110;
		63 : mach_code = 'b110101011;
		64 : mach_code = 'b100011110;
		65 : mach_code = 'b101000111;
		66 : mach_code = 'b100110001;
		67 : mach_code = 'b110011110;
		68 : mach_code = 'b111001111;
		69 : mach_code = 'b110100111;
		70 : mach_code = 'b111110110; //lsr r1, r2
		71 : mach_code = 'b110001000;
		72 : mach_code = 'b110000001;
		73 : mach_code = 'b000010100;
		74 : mach_code = 'b110010110;
		75 : mach_code = 'b100010110;
		76 : mach_code = 'b101110110;
		77 : mach_code = 'b010000010;
		78 : mach_code = 'b000010000;
		79 : mach_code = 'b110010111;
		80 : mach_code = 'b111000111;
		81 : mach_code = 'b111000111;
		82 : mach_code = 'b110011111;
		83 : mach_code = 'b111001110;
		84 : mach_code = 'b111011111;
		85 : mach_code = 'b110101011;
		86 : mach_code = 'b100100110;
		87 : mach_code = 'b110011111;
		88 : mach_code = 'b111001101;
		89 : mach_code = 'b111110111;
		90 : mach_code = 'b111000010;
		91 : mach_code = 'b100110011;
		92 : mach_code = 'b111001010;
		93 : mach_code = 'b000010011;
		94 : mach_code = 'b101110101;
		95 : mach_code = 'b010000010;
		96 : mach_code = 'b000010000;
		97 : mach_code = 'b110010110;
		98 : mach_code = 'b111000111;
		99 : mach_code = 'b111000111;
		100 : mach_code = 'b110011111;
		101 : mach_code = 'b111001110;
		102 : mach_code = 'b111011111;
		103 : mach_code = 'b110101011;
		104 : mach_code = 'b100100110;
		105 : mach_code = 'b110011111;
		106 : mach_code = 'b111001101;
		107 : mach_code = 'b111011101;
		108 : mach_code = 'b111110111;
		109 : mach_code = 'b111000001;
		110 : mach_code = 'b100110001;
		111 : mach_code = 'b111001001;
		112 : mach_code = 'b110011111;
		113 : mach_code = 'b100100011;
		114 : mach_code = 'b110011110;
		115 : mach_code = 'b111001111;
		116 : mach_code = 'b111011101;
		117 : mach_code = 'b110100111;
		118 : mach_code = 'b110011111;
		119 : mach_code = 'b111001110;
		120 : mach_code = 'b111011111;
		121 : mach_code = 'b100000111;
		122 : mach_code = 'b111000110;
		123 : mach_code = 'b100110001;
		124 : mach_code = 'b110011111;
		125 : mach_code = 'b111001110;
		126 : mach_code = 'b111011110;
		127 : mach_code = 'b110100111;
		128 : mach_code = 'b110011101;
		129 : mach_code = 'b100100111;
		130 : mach_code = 'b101110100;
		131 : mach_code = 'b010000101;
		132 : mach_code = 'b111001111;
		133 : mach_code = 'b111001111;
		134 : mach_code = 'b111001101;
		135 : mach_code = 'b100110011;
		136 : mach_code = 'b110011111;
		137 : mach_code = 'b110110011;
		138 : mach_code = 'b110011110;
		139 : mach_code = 'b110111011;
		140 : mach_code = 'b110111011;
		default : mach_code = 'b000000000;
    endcase

endmodule
