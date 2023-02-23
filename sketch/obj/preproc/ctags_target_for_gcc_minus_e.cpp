# 1 "/mnt/c/Users/levys/Desktop/ardurust/sketch/sketch.ino"
extern "C"{
    int add(int first, int second);
}

void setup(void)
{
    auto n = add(3, 4);
}

void loop(void)
{
}
