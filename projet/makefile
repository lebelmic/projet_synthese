
all: exemple-1.x  exemple-2.x

%.x: %.f90
	mpif90 $^ -o $@ -I /usr/lib64/gfortran/modules

clean:
	rm *.x

