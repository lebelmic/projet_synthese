# Please copy this file into conf.mk

#H5_INC=-I/usr/lib64/gfortran/modules
#H5_LIB=

H5_INC=-I/usr/local/Cellar/hdf5/1.10.1/include/
H5_LIB=-L/usr/local/Cellar/hdf5/1.10.1/lib/ -lhdf5 -lhdf5_fortran  -lhdf5_hl

