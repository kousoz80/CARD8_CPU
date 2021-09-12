// "card8vm_sym.c" CARD8 CPU用仮想マシンのエミュレータのC言語による実装 ver 1.0

#include <stdio.h>
#define MEM_SIZE 65536

// 仮想マシンのレジスタセット
int pc;	// PC: プログラムカウンタ
int x;	// X: インデックスレジスタX
int y;	// Y: インデックスレジスタY
int a;	// A: アキュムレータ
int cf;	// CF: キャリーフラグ
int zf;	// ZF: ゼロフラグ

// メモリ
int mem[MEM_SIZE];

// 仮想マシンの命令セット
enum card8vm_ins {
 HLT,	// hlt;			停止する
 LXI,	// lxi xxxx;	Xレジスタにxxxxの値をセットする
 LDX,	// ldx xxxx;	Xレジスタにxxxx番地の内容を転送する
 ADX,	// adx xxxx;	Xレジスタにxxxx番地の内容を加算する
 SBX,	// sbx xxxx;	Xレジスタからxxxx番地の内容を減算する
 STX,	// stx xxxx;	Xレジスタの内容をxxxx番地に転送する
 LAI,	// lai xx;		Aレジスタにxxの値をセットする
 LD,	// ld;			AレジスタにXレジスタが示す番地の内容を転送する
 ST,	// st;			Xレジスタが示す番地にAレジスタの内容を転送する
 ADC,	// adc;			AレジスタにXレジスタが示す番地の内容をキャリー付き加算する
 SBC,	// sbc;			AレジスタからXレジスタが示す番地の内容をキャリー付き減算する
 AND,	// and;			AレジスタにXレジスタが示す番地の内容をAND演算する(CFは0にする)
 OR,	// or;			AレジスタにXレジスタが示す番地の内容をOR演算する(CFは1にする)
 ROR,	// ror;			AレジスタのビットをCFを含めて右回転させる
 ROL,	// rol;			AレジスタのビットをCFを含めて左回転させる
 JMP,	// jmp xxxx;	xxxx番地にジャンプする
 JZ,	// jz xxxx;		ZFが１のときxxxx番地にジャンプする
 JNZ,	// jnz xxxx;	ZFが0のときxxxx番地にジャンプする
 JC,	// jc xxxx;		CFが１のときxxxx番地にジャンプする
 JNC,	// jnc xxxx;	CFが0のときxxxx番地にジャンプする
 JMPX,	// jmpx;		Xレジスタが示す番地にジャンプする

// ここから拡張命令(可能ならば実装する)
 JMPY,	// jmpy;		Yレジスタが示す番地にジャンプする
 LYI,	// lyi xxxx;	Yレジスタにxxxxの値をセットする
 LDY,	// ldy xxxx;	Yレジスタにxxxx番地の内容を転送する
 ADY,	// ady xxxx;	Yレジスタにxxxx番地の内容を加算する
 SBY,	// sby xxxx;	Yレジスタからxxxx番地の内容を減算する
 STY,	// sty xxxx;	Yレジスタの内容をxxxx番地に転送する
 LD_Y,	// ld_y;		AレジスタにYレジスタが示す番地の内容を転送する
 ST_Y,	// st_y;		Yレジスタが示す番地にAレジスタの内容を転送する
 ADC_Y,	// adc_y;		AレジスタにYレジスタが示す番地の内容をキャリー付き加算する
 SBC_Y,	// sbc_y;		AレジスタからYレジスタが示す番地の内容をキャリー付き減算する
 AND_Y,	// and_y;		AレジスタにYレジスタが示す番地の内容をAND演算する(CFは0にする)
 OR_Y,	// or_y;		AレジスタにYレジスタが示す番地の内容をOR演算する(CFは1にする)

};


// プログラムをロード
int load_prog( char* fname ){
  FILE* fp;
  int adrs, data;

  // ファイルがない場合はエラー
if( ( fp = fopen( fname, "r" ) ) == NULL ){
    printf("file not found.\n");
    return -1;
  }

  while(1){
    if( fscanf( fp, "%d\n",  &adrs ) < 1 ) break;
    if( fscanf( fp, "%d\n",  &data ) < 1 ) break;
    mem[ adrs ] = data;
  }
  fclose( fp );
  return 0;
}


// レジスタ表示
void print_regs(){
  printf( "pc=0x%06x, x=0x%06x, y=0x%06x, a=0x%02x, cf=%d, zf=%d\n", pc, x, y, a, cf, zf ); 
}


// メイン
void main( int argc, char** argv ){
  enum card8vm_ins ins;	// 命令コード
  int adr;					// アドレスレジスタ
  int tmp;					// 一時レジスタ
  int is_break; 			// 停止フラグ 

  // パラメータがあるときはプログラムファイル名とみなしてロードする
  if( argc > 1 ) load_prog( argv[1] );

  pc = 0;
  x = 0;
  y = 0;
  a = 0;
  cf = 0;
  zf = 0;
  mem[0] = (int)HLT;

  // メインループ
  is_break = 0;
  while( !is_break ){

    // 命令コードをフェッチ
    ins = (enum card8vm_ins)mem[ pc++ ];

    // 命令コードに応じた処理
    switch( ins ){

	// hlt;			停止する
    case HLT:
      is_break = 1;
      break;

    // lxi xxxx;	Xレジスタにxxxxの値をセットする
    case LXI:
      x = mem[ pc++ ] | (mem[ pc++ ] << 8) | (mem[ pc++ ] << 16);
      break;

    // ldx xxxx;	Xレジスタにxxxx番地の内容を転送する
    case LDX:
      adr = mem[ pc++ ] | (mem[ pc++ ] << 8) | (mem[ pc++ ] << 16);
      x = mem[ adr++ ] | (mem[ adr++ ] << 8) | (mem[ adr ] << 16);
      break;

    // adx xxxx;	Xレジスタにxxxx番地の内容を加算する
    case ADX:
      adr = mem[ pc++ ] | (mem[ pc++ ] << 8) | (mem[ pc++ ] << 16);
      tmp = mem[ adr++ ] | (mem[ adr++ ] << 8) | (mem[ adr ] << 16);
      x = x + tmp;
      zf = (x==0);
      cf = (x >= 0x1000000);
      x &= 0xffffff; 
      break;

    // sbx xxxx;	Xレジスタからxxxx番地の内容を減算する
    case SBX:
      adr = mem[ pc++] | (mem[ pc++ ] << 8) | (mem[pc++] << 16);
      tmp = mem[ adr++ ] | (mem[ adr++ ] << 8) | (mem[ adr ] << 16);
      x = x - tmp;
      zf = (x==0);
      cf = (x < 0);
      x &= 0xffffff; 
      break;

    // stx xxxx;	Xレジスタの内容をxxxx番地に転送する
    case  STX:
      adr = mem[ pc++] | (mem[ pc++ ] << 8) | (mem[pc++] << 16);
      mem[ adr++ ] = (x>>0)  & 0xff;
      mem[ adr++ ] = (x>>8)  & 0xff;
      mem[ adr ]   = (x>>16) & 0xff;
      break;

    // lai xx;		Aレジスタにxxの値をセットする
    case  LAI:
      a = mem[ pc++ ];
      break;

    // ld;			AレジスタにXレジスタが示す番地の内容を転送する
    case  LD:
      a = mem[ x ];
      break;

    // st;			Xレジスタが示す番地にAレジスタの内容を転送する
    case  ST:
      mem[ x ] = a;
      break;

    // adc;			AレジスタにXレジスタが示す番地の内容をキャリー付き加算する
    case  ADC:
      a = a + mem[ x ] + cf;
      cf = (a >= 0x100);
      a &= 0xff; 
      zf = (a==0);
      break;

    // sbc;			AレジスタからXレジスタが示す番地の内容をキャリー付き減算する
    case  SBC:
      a = a - mem[ x ] - cf;
      cf = (a < 0);
      a &= 0xff; 
      zf = (a==0);
      break;

    // and;			AレジスタにXレジスタが示す番地の内容をAND演算する(CFは0にする)
    case  AND:
      a = (a & mem[ x ]) & 0xff;
      zf = (a==0);
      cf = 0;
      break;

    // or;			AレジスタにXレジスタが示す番地の内容をOR演算する(CFは1にする)
    case  OR:
      a = (a | mem[ x ]) & 0xff;
      zf = (a==0);
      cf = 1;
      break;

    // ror;			AレジスタのビットをCFを含めて右回転させる
    case  ROR:
      tmp = a;
      a = a >> 1;
      if( cf == 1 ) a = a | 0x80; 
      a &= 0xff; 
      zf = (a==0);
      cf = (tmp & 0x01)? 1 : 0;
      break;

    // rol;			AレジスタのビットをCFを含めて左回転させる
    case  ROL:
      tmp = a;
      a = a << 1;
      if( cf == 1 ) a = a | 0x01; 
      a &= 0xff; 
      zf = (a==0);
      cf = (tmp & 0x80)? 1 : 0;
      break;

    // jmp xxxx;	xxxx番地にジャンプする
    case  JMP:
      tmp = mem[ pc++] | (mem[ pc++ ] << 8) | (mem[pc++] << 16);
      pc = tmp;
      break;

    // jz xxxx;		ZFが１のときxxxx番地にジャンプする
    case  JZ:
      tmp = mem[ pc++] | (mem[ pc++ ] << 8) | (mem[pc++] << 16);
      if( zf == 1 ) pc = tmp;
      break;

    // jnz xxxx;	ZFが0のときxxxx番地にジャンプする
    case  JNZ:
      tmp = mem[ pc++] | (mem[ pc++ ] << 8) | (mem[pc++] << 16);
      if( zf == 0 ) pc = tmp;
      break;

    // jc xxxx;		CFが１のときxxxx番地にジャンプする
    case  JC:
      tmp = mem[ pc++] | (mem[ pc++ ] << 8) | (mem[pc++] << 16);
      if( cf == 1 ) pc = tmp;
      break;

    // jnc xxxx;	CFが0のときxxxx番地にジャンプする
    case  JNC:
      tmp = mem[ pc++] | (mem[ pc++ ] << 8) | (mem[pc++] << 16);
      if( cf == 0 ) pc = tmp;
      break;

    // jmpx;		Xレジスタが示す番地にジャンプする
    case  JMPX:
      pc = x;
      break;

    // ここから拡張命令

    // jmpy;		Yレジスタが示す番地にジャンプする
    case  JMPY:
      pc = y;
      break;

    // lyi xxxx;	Yレジスタにxxxxの値をセットする
    case LYI:
      y = mem[ pc++ ] | (mem[ pc++ ] << 8) | (mem[ pc++ ] << 16);
      break;

    // ldy xxxx;	Yレジスタにxxxx番地の内容を転送する
    case LDY:
      adr = mem[ pc++ ] | (mem[ pc++ ] << 8) | (mem[ pc++ ] << 16);
      y = mem[ adr++ ] | (mem[ adr++ ] << 8) | (mem[ adr ] << 16);
      break;

    // ady xxxx;	Yレジスタにxxxx番地の内容を加算する
    case ADY:
      adr = mem[ pc++ ] | (mem[ pc++ ] << 8) | (mem[ pc++ ] << 16);
      tmp = mem[ adr++ ] | (mem[ adr++ ] << 8) | (mem[ adr ] << 16);
      y = y + tmp;
      zf = (y==0);
      cf = (y >= 0x1000000);
      y &= 0xffffff; 
      break;

    // sby xxxx;	Yレジスタからxxxx番地の内容を減算する
    case SBY:
      adr = mem[ pc++] | (mem[ pc++ ] << 8) | (mem[pc++] << 16);
      tmp = mem[ adr++ ] | (mem[ adr++ ] << 8) | (mem[ adr ] << 16);
      y = y - tmp;
      zf = (y==0);
      cf = (y < 0);
      y &= 0xffffff; 
      break;

    // sty xxxx;	Yレジスタの内容をxxxx番地に転送する
    case STY:
      adr = mem[ pc++] | (mem[ pc++ ] << 8) | (mem[pc++] << 16);
      mem[ adr++ ] = (y>>0)  & 0xff;
      mem[ adr++ ] = (y>>8)  & 0xff;
      mem[ adr ]   = (y>>16) & 0xff;
      break;

    // ld_y;		AレジスタにYレジスタが示す番地の内容を転送する
    case LD_Y:
      a = mem[ y ];
      break;

    // st_y;		Yレジスタが示す番地にAレジスタの内容を転送する
    case ST_Y:
      mem[ y ] = a;
      break;

    // adc_y;		AレジスタにYレジスタが示す番地の内容をキャリー付き加算する
    case ADC_Y:
      a = a + mem[ y ] + cf;
      cf = (a >= 0x100);
      a &= 0xff; 
      zf = (a==0);
      break;

    // sbc_y;		AレジスタからYレジスタが示す番地の内容をキャリー付き減算する
    case SBC_Y:
      a = a - mem[ y ] - cf;
      cf = (a < 0);
      a &= 0xff; 
      zf = (a==0);
      break;

    // and_y;		AレジスタにYレジスタが示す番地の内容をAND演算する(CFは0にする)
    case AND_Y:
      a = (a & mem[ y ]) & 0xff;
      zf = (a==0);
      cf = 0;
      break;

    // or_y;		AレジスタにYレジスタが示す番地の内容をOR演算する(CFは1にする)
    case OR_Y:
      a = (a | mem[ y ]) & 0xff;
      zf = (a==0);
      cf = 1;
      break;

    }
    print_regs();
  }
  printf("HALT.\n");
}
