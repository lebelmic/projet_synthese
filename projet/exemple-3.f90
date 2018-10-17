! A fortran90 program to experiment with MPI and HDF5
! Étienne Lebel-Michaud, Gabriel Antonius
program main

!Using both libraries
use mpi
use hdf5

IMPLICIT NONE

!Define file name and values for hdf5
character(LEN=8), PARAMETER :: filename = "filef.h5"
character(LEN=9), PARAMETER :: dsetname = "big_array"
integer(HID_T) :: file_id
integer(HID_T) :: dataset_id
integer(HID_T) :: dataspace_id
integer :: h_rank
integer(HSIZE_T) :: data_dims(2)
integer(HSIZE_T) :: max_dims(2)
real(8), allocatable :: dset_data(:,:)

!Define values for MPI
integer :: num_procs, rank, tag, dest
integer :: status(MPI_STATUS_SIZE)
integer :: buf(100)
integer :: all_data(100)
integer, allocatable :: array(:,:)
integer, allocatable :: big_array(:,:)
integer :: n, m

!General
integer :: i, j,  ierr


! Initialize MPI
call MPI_INIT(ierr)
call MPI_COMM_RANK(MPI_COMM_WORLD, rank, ierr)
call MPI_COMM_SIZE(MPI_COMM_WORLD, num_procs, ierr)


! Initialize array
n = 3
m = 6
data_dims = (/n,m/)
allocate(array(n,m))
allocate(big_array(n,m))
array = 0
big_array = 0

if (rank == 0) then

  !Initialize HDF5
  call h5open_f(ierr)

  !Create file
  call h5fcreate_f(filename, H5F_ACC_TRUNC_F, file_id, ierr)

  !Create dataspace
  h_rank = size(data_dims)
  call h5screate_simple_f(h_rank, data_dims, dataspace_id, ierr)

  !Create dataset with default properties
  call h5dcreate_f(file_id, dsetname, H5T_NATIVE_REAL, dataspace_id, dataset_id, ierr)

end if

!Each process creates his row
do i=1,m
  if (i /= rank) cycle
  array(:,i) = rank

  !do j=1,n
  !  array(j,i) = i+j
  !end do
end do


! Communicate it to the master
call MPI_reduce(array, big_array, n*m, MPI_INT, MPI_SUM, 0, MPI_COMM_WORLD, ierr)


! Print out result
if ( rank == 0 ) then

 do i=1,m
    write(*,*) big_array(:,i)
!     write(*,*) array(:,i) 
 end do

  !Write the dataset
  call h5dwrite_f(dataset_id, H5T_NATIVE_INTEGER, big_array, data_dims, ierr)
  
end if

if (rank == 0) then

  !Close the dataset
  call h5dclose_f(dataset_id, ierr)

  !Close the dataspace
  call h5sclose_f(dataspace_id, ierr)

  !Close file
  call h5fclose_f(file_id, ierr)

  !Close HDF5
  call h5close_f(ierr)
end if


! Free memory
deallocate(big_array)
deallocate(array)


!Finalize MPI
call MPI_FINALIZE(ierr)

end program main
