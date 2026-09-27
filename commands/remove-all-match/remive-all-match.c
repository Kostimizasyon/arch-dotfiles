#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char lower(char a) {
    return (a >= 'A' && a <= 'Z') ? a + 32 : a;
}

int main(int argc, char** argv) {

	if (argc != 2) {
		printf("Please give a single input for a matching package");
		return 0;
	}
	// need to prevent overflow
	char cmd[256] = "";

	strcat(cmd, "pacman -Qq | grep ");
	strcat(cmd, argv[1]);

	FILE* stream = popen(cmd, "r");

	// reading file content
	char buff[512];

	int count = 0;

	while(fgets(buff, sizeof(buff), stream) != NULL) {
		buff[strcspn(buff, "\n")] = '\0';   // removes trailing \n
		count++;
	}

	if (count < 1) {
		puts("No related package found");
		return 0;
	}

	pclose(stream);

	printf("%d matching packages found, delete all? Y/n \n", count);
	char input;
	scanf("%c", &input);

	if (lower(input) == 'y') {
		char cmd[512 + sizeof("sudo pacman -R --noconfirm ")] = "sudo pacman -R --noconfirm ";
		strcat(cmd, buff);

		system(cmd);

		printf("Sucesfully deleted %d files", count);
	}
	else if (lower(input) == 'n') {
		puts("Terminating process");
	}
	else {
		puts("Unrecognized input, terminated process");
	}


}

