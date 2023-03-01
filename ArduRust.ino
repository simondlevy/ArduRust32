extern "C"{
    int add(int first, int second);
}

void setup(void)
{
    Serial.begin(115200);
}

void loop(void)
{
    auto n = add(3, 4);

    Serial.println(n);

    delay(500);
}
