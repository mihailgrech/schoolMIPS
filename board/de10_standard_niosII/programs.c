#define switches (volatile char *) 0x0002010
#define leds (char *) 0x0002000

int main() {
    while (1) {
        unsigned n = *SWITCHES_ADDR_BASE;
        unsigned result = 0, c = 0;
        
        while (n != 0) {
            unsigned secondBit = n & 1;
            unsigned firstBit = (n & 2) ? 1 : 0;
            n >>= 2;
        
            secondBit <<= c+1;
            firstBit <<= c;
            c += 2;
        
            result |= secondBit;
            result |= firstBit;
        }

    *LEDS_ADDR_BASE = result;
    return 0;
    }
}
