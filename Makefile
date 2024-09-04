OS := $(shell uname -s)

CXX := g++
CXXFLAGS := -std=c++17 -pthread -O -Wno-comment -I./src/OpenCL/include
SRCS := src/*.cpp
OUT := bin/OpenCL-Benchmark


ifeq ($(OS), Darwin)	# macOS
    LDFLAGS := -framework OpenCL
endif

ifeq ($(findstring Android, $(OS)), Android)	# Android
    LDFLAGS := -L/system/vendor/lib64 -lOpenCL
endif

ifeq ($(OS), Linux)		# Linux
    LDFLAGS := -L./src/OpenCL/lib -lOpenCL
endif


all: path
	$(CXX) $(SRCS) -o $(OUT) $(CXXFLAGS) $(LDFLAGS)

path:
	-mkdir -p bin

clean:
	rm -f $(OUT)

clean-all:
	rm -rf bin
