

H5_INC=-I/usr/lib64/gfortran/modules
H5_LIB=
#H5_INC=-I/usr/local/Cellar/hdf5/1.10.1/include/
#H5_LIB=-L/usr/local/Cellar/hdf5/1.10.1/lib/ -lhdf5 -lhdf5_fortran  -lhdf5_hl

include conf.mk

all: exemple-1.x  exemple-2.x exemple-3.x

%.x: %.f90
	mpif90 $^ -o $@ $(H5_INC) $(H5_LIB)

clean:
	rm *.x

