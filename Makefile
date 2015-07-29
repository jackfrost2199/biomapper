# Compiler
CC = g++

# Compiler flags
CFLAGS = -std=c++11

# the build target executable
TARGET = biomapper

all: compile

# Set up release mode
# call by 'make release' or just by 'make'
release: CFLAGS += -O3
release: CXXFLAGS = -DRELEASE
release: compile

# Debug mode
# 'make debug'
debug: CFLAGS += -g -Wall
debug: CXXFLAGS = -DDEBUG
debug: compile

# Raspberry pi
# 'make raspberry'
raspberry: CC = g++-4.9
raspberry: CFLAGS += -g -Wall -gdwarf-3
raspberry: CXXFLAGS = -DDEBUG
raspberry: compile

# OSX
# 'make osx'
osx: CFLAGS += -g -Wall -gdwarf-3
osx: CXXFLAGS = -DDEBUG
osx: compile

# Support functions
compile: main.o biomapper.o
	$(CC) $(CFLAGS) -o bin/$(TARGET) src/main.o src/biomapper.o $(CXXFLAGS)

main.o: src/main.cpp 
	$(CC) $(CFLAGS) -c src/main.cpp -o src/main.o $(CXXFLAGS)

biomapper.o: src/biomapper.cpp src/biomapper.hpp
	$(CC) $(CFLAGS) -c src/biomapper.cpp -o src/biomapper.o	$(CXXFLAGS)


# clean up the built files
clean: 
	$(RM) bin/$(TARGET) src/*.o src/*~
