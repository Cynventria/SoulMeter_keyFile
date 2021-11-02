#include <stdio.h> 
#include <string.h>

#define KEY_FILE_NAME "SWPkey.bin"


int main(){
	short magic = 3;
	char _keyTable[64] = { 0x14, 0xb2, 0x99, 0x12, 0xcc, 0x23, 0xb9, 0x90, 0xf3, 0x08, 0x3d, 0xae, 0xe0, 0xac, 0x51 };
	int _keyLen = 15;
	char info[64] = "TestKEY_1102";

	
	
	
	//WRITE FILE
	FILE *keyFile = fopen(KEY_FILE_NAME, "wb");
	fwrite(&magic, sizeof(short), 1, keyFile );
	fwrite(&_keyLen, sizeof(int), 1, keyFile );
	fwrite(_keyTable, sizeof(char), _keyLen, keyFile );
	fwrite(info, sizeof(char), strlen(info), keyFile );
	printf("%d", strlen(info));
	

	fclose(keyFile);
	
	//READ & CHECK FILE
	keyFile = fopen(KEY_FILE_NAME, "r");
	char buffer[64];
	char _RkeyTable[64];
	
	//check fle length
	fseek(keyFile, 0, SEEK_END);
	int fileSize = ftell(keyFile);
	rewind(keyFile);
	

	short tmpMAGIC = 0;
	fread(&tmpMAGIC, sizeof(short), 1, keyFile);
	int tmpKeyLen = 0;
	fread(&tmpKeyLen, sizeof(int), 1, keyFile);

	if (tmpKeyLen > 0 && tmpKeyLen < 64) {

		if (fileSize - sizeof(int) -sizeof(short) - tmpKeyLen < 0) {
			puts("Invalid_KeySize");
			return 0;
		}
		fread(&buffer, sizeof(char), tmpKeyLen, keyFile);//read key
		//decrypt if needed
		memcpy(_RkeyTable, buffer, tmpKeyLen);
		memset(buffer, 0, sizeof(buffer));
		
		fread(&buffer, sizeof(char), fileSize - sizeof(int) - sizeof(short) - tmpKeyLen, keyFile);
		
		puts("generated SWPkey.bin file:\n");
		printf("SWMAGIC:\t%d\n", tmpMAGIC);
		
		printf("key length:\t%d\n", tmpKeyLen);
		printf("_keyTable:\t");
		for(int i = 0; i < tmpKeyLen; i++){
			printf("0x%02x, ", _RkeyTable[i] & 0xff);
		}
		puts("");

		printf("info:\t\t%s",buffer );

		//read description
		//sprintf(_keyInfo, "%s", buffer);

	}
	else {
		//sprintf(_keyInfo, "Invalid_KeySize");
		return 0;
	}
	fclose(keyFile);


}
