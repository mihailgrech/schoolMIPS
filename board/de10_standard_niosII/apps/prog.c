#define switches (volatile char *) 0x0002010
#define leds (char *) 0x0002000
#define s7gment (char *) 0x0002028

void counter() {
 	int a = 0;
    
	while (1) {
        *s7gment = a;
		*leds = a++;
        for (int delay = 0; delay <= 1000000; delay++);
	}
}

void fib() {
	unsigned fib[] = {0, 1, 0};
    
	while (1) {
        *s7gment = fib[2];
		*leds = fib[2];

		fib[2] = fib[1] + fib[0];
		fib[0] = fib[1];
		fib[1] = fib[2];
        
        for (unsigned delay = 0; delay <= 1000000; delay++);
	}
}

void Sqrt() {
    while (1) {
        unsigned x = *switches; // number to sqrt from switches
        unsigned m = 0x40000000;
        unsigned y = 0, b;
        
        while (m != 0) { // Do 16 times
            b = y | m;
            y >>= 1;
            if (x >= b) {
                x -= b;
                y |= m;
            }
            
            m >>= 2;
        }
        
        *s7gment = y;
        *leds = y;
    }
}

// bit numbers 76543210 becomes 67452301
void rearrangeBitPairs() {
    while (1) {
        unsigned n = *switches;
        unsigned result = 0;

        unsigned c = 0;        
        while (n != 0) {
            unsigned secondBit = n & 1;
            unsigned firstBit;
            if (n & 2) {
                firstBit = 1;
            } else {
                firstBit = 0;
            }
                    
            n >>= 2;

            secondBit <<= c+1;
            firstBit <<= c;
            c += 2;

            result |= secondBit;
            result |= firstBit;
        }
        
        *s7gment = result;
        *leds = result;
    }
}

int main() {
    //ledsExample();
    counter();
    //fib();
    //Sqrt();
    //rearrangeBitPairs();
    return 0;
}