ifeq ($(shell uname),Darwin)
	    EXT := dylib
	else
	    EXT := so
	endif

TARGET = target/debug/libmath.$(EXT)
	 
all: $(TARGET)
	g++ src/main.cpp -L ./target/debug/ -lmath -o run
	LD_LIBRARY_PATH=./target/debug/ ./run
			 
$(TARGET): src/lib.rs Cargo.toml
	cargo build
		 
clean:
	rm -rf target
	rm -rf run
