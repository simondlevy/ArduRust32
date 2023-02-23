TARGET = ./target/thumbv7em-none-eabihf/debug/libmath.a

all: $(TARGET)

$(TARGET): src/lib.rs
	cargo build
	mv $(TARGET) sketch

clean:
	cargo clean
