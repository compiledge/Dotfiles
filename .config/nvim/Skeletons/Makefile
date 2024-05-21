CC = gcc
CDEBUG = -g
CFLAGS = $(CDEBUG) -Wall -Werror
LDFLAGS = -lm
OBJECTS = [objetcs]
TARGET = [bin]

# Linker
$(TARGET) : $(OBJECTS)
	$(CC) -o $(TARGET) $(OBJECTS) $(LDFLAGS)

# Object traduction
[objetcs]

# Debugging
.PHONY : debug
debug : CFLAGS = $(CDEBUG) -Wall -Werror
debug : $(TARGET)

.PHONY : clean
clean:
	rm -f $(TARGET) $(OBJECTS)
