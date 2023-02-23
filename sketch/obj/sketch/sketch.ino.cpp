#include <Arduino.h>
#line 1 "/mnt/c/Users/levys/Desktop/ardurust/sketch/sketch.ino"
extern "C"{
    int add(int first, int second);
}

#line 5 "/mnt/c/Users/levys/Desktop/ardurust/sketch/sketch.ino"
void setup(void);
#line 10 "/mnt/c/Users/levys/Desktop/ardurust/sketch/sketch.ino"
void loop(void);
#line 5 "/mnt/c/Users/levys/Desktop/ardurust/sketch/sketch.ino"
void setup(void)
{
    auto n = add(3, 4);
}

void loop(void)
{
}

