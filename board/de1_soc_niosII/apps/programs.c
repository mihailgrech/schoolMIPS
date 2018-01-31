#define switches (volatile char *) 0x0002010
#define leds (char *) 0x0002000

void ledsExample() {
    while (1) {
        *leds = *switches;
    }
}

void counter() {
 	int a = *switches;
    
	while (1) {
		*leds = a++;
        for (int delay = 0; delay <= 1000000; delay++);
	}
}

void fib() {
	unsigned fib[] = {0, 1, 0};
	while (1) {
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
        
        *leds = y;
    }
}

// rearrange all pairs of bits in the input in the reverse order
// e.g. bit numbers 76543210 becomes 10325476
//                       6543210          1032546
void rearrangeBitPairs() {
    while (1) {
        unsigned n = *switches;
        int result = 0;

        while (n != 0) {
            int last2bits = n & 3;
            n >>= 2;
       
        result <<= 2;
        result |= last2bits;
        }
        
        *leds = result;
    }
}

int main() {
    //ledsExample();
    //counter();
    //fib();
    //Sqrt();
    rearrangeBitPairs();
    return 0;
}