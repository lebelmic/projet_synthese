! A fortran90 program to experiment with MPI and HDF5
! Étienne Lebel-Michaud, Gabriel Antonius
program main

!Using both libraries
use mpi
use hdf5

!Define file name and values for hdf5
character(LEN=8), PARAMETER :: filename = "filef.h5"
integer(HID_T) :: file_id

!Define values for MPI
integer :: num_procs, rank, tag, dest
integer :: status(MPI_STATUS_SIZE)
integer :: buf(100)
integer :: all_data(100)
integer, allocatable :: array(:,:)
integer, allocatable :: big_array(:,:)
integer :: n, m

!General
integer :: i, ierr


! Initialize MPI
call MPI_INIT(ierr)
call MPI_COMM_RANK(MPI_COMM_WORLD, rank, ierr)
call MPI_COMM_SIZE(MPI_COMM_WORLD, num_procs, ierr)


! Initialize array
n = 3
m = 6
allocate(array(n,m))
allocate(big_array(n,m))
array = 0
big_array = 0


!Create the file for hdf5
call h5open_f(ierr)
call h5fcreate_f(filename, H5F_ACC_TRUC_F, file_id, ierr)


!Each process creates his row
do i=1,m

  if (i /= rank) cycle

  array(:,i) = rank

end do


! Communicate it to the master
call MPI_reduce(array, big_array, n*m, MPI_INT, MPI_SUM, 0, MPI_COMM_WORLD, ierr)


! Print out result
if ( rank == 0 ) then

  do i=1,m
    write(*,*) big_array(:,i)
  end do

end if


!Close file
call h5fclose_f(file_id, ierr)
call h5close_f(ierr)


! Free memory
deallocate(big_array)
deallocate(array)


!Finalize MPI
call MPI_FINALIZE(ierr)

end program main
