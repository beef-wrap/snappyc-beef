mkdir libs
mkdir libs\debug
mkdir libs\release

gcc -c -O0 -g -gcodeview -o snappy.lib -Wall snappy-c\snappy.c
move snappy.lib libs\debug

gcc -c -O3 -o snappy.lib -Wall -Dsnappy-c_IMPL snappy-c\snappy.c
move snappy.lib libs\release