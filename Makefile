# Compiler flags
CXX      ?= g++
CXXFLAGS ?= -std=c++20 -Wall -O3
CPPFLAGS ?= -I eigen -I include -I include/core  -I include/methods -I $(shell dpkg -L libmuparserx-dev | grep -oP '.*include/muparserx' | sort -u) 

# Linker flags
LDFLAGS ?= 
LDLIBS  ?= -lmuparserx -ltbb

# Variables
EXEC    = main
SRC_DIR = src
SRCS 	= $(shell find $(SRC_DIR) -name '*.cpp')
OBJS    = $(SRCS:.cpp=.o)
HEADERS = $(shell find include -maxdepth 1) $(shell find include/methods -maxdepth 1 -name '*.hpp')

# Default target
all: $(EXEC)

# Link object files to create executable
$(EXEC): $(OBJS)
	$(CXX) $(CXXFLAGS) $(LDFLAGS) $(OBJS) $(LDLIBS) -o $@

# Compile source files
%.o: %.cpp ../include/core/%.hpp $(HEADERS)
	$(CXX) -c $(CPPFLAGS) $(CXXFLAGS) $< -o $@

# Remove all object files
clean:
	$(RM) $(OBJS)

# Remove all generated files
distclean: clean
	$(RM) $(EXEC)
	$(RM) $(SRC_DIR)/*~

