all:
	g++ simulador_fonte/*.cpp -O3 -march=native `pkg-config --libs --cflags gtk+-2.0` -lcurses -pthread -Wall -lgthread-2.0 -o bin/icmc_sim 
	gcc montador_fonte/*.c -o bin/icmc_montador

clean:
	rm bin/icmc_sim 
	rm bin/icmc_montador	
