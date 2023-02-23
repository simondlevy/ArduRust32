ifeq ($(shell uname),Darwin)
	    EXT := dylib
	else
	    EXT := so
	endif

TARGET = target/debug/libmath.$(EXT)
	 
$(TARGET): src/lib.rs Cargo.toml
	cargo build

test: $(TARGET)
	g++ src/main.cpp -L ./target/debug/ -lmath -o run
	LD_LIBRARY_PATH=./target/debug/ ./run
		 
clean:
	rm -rf target
	rm -rf run
