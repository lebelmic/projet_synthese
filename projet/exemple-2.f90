! A fortran95 program for G95
! By WQY
program main
use mpi
integer :: ierr, num_procs, rank, tag, dest, i
integer :: status(MPI_STATUS_SIZE)
integer :: buf(100)
integer :: all_data(100)
integer, allocatable :: array(:,:)
integer, allocatable :: big_array(:,:)
integer :: n, m


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

do i=1,m

  if (i /= rank) cycle

  array(:,i) = rank

end do

! Communicate
call MPI_reduce(array, big_array, n*m, MPI_INT, MPI_SUM, 0, MPI_COMM_WORLD, ierr)

! Print out result
if ( rank == 0 ) then

  do i=1,m
    write(*,*) big_array(:,i)
  end do

end if

! Free memory
deallocate(big_array)
deallocate(array)

call MPI_FINALIZE(ierr)

end program main
