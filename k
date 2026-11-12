
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* minWindow(char* s, char* t) {
    int sLen = strlen(s);
    int tLen = strlen(t);

    if (tLen > sLen)
        return "";

    int freq[256] = {0};

    for (int i = 0; i < tLen; i++) {
        freq[(unsigned char)t[i]]++;
    }

    int left = 0;
    int required = tLen;
    int minLen = sLen + 1;
    int start = 0;

    for (int right = 0; right < sLen; right++) {

        unsigned char ch = (unsigned char)s[right];

        if (freq[ch] > 0) {
            required--;
        }

        freq[ch]--;

        while (required == 0) {

            int windowLen = right - left + 1;

            if (windowLen < minLen) {
                minLen = windowLen;
                start = left;
            }

            unsigned char leftChar =
                (unsigned char)s[left];

            freq[leftChar]++;

            if (freq[leftChar] > 0) {
                required++;
            }

            left++;
        }
    }

    if (minLen == sLen + 1)
        return "";

    char* result = malloc(minLen + 1);

    if (result == NULL)
        return "";

    strncpy(result, s + start, minLen);
    result[minLen] = '\0';

    return result;
}

int main() {
    char s[] = "ADOBECODEBANC";
    char t[] = "ABC";

    char* result = minWindow(s, t);

    printf("Minimum Window: %s\n", result);

    if (result[0] != '\0')
        free(result);

    return 0;
}
