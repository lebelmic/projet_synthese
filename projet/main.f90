! A fortran95 program for G95
! By WQY
program main
use mpi
integer :: ierr, num_procs, rank, tag, dest, i
!integer :: status(MPI_STATUS_SIZE)
integer :: value(100)
integer :: data (100)


!value(:) = 1

!call MPI_INIT(ierr)

!call MPI_COMM_RANK(MPI_COMM_WORLD, rank, ierr)
!call MPI_COMM_SIZE(MPI_COMM_WORLD, num_procs, ierr)

!write ( *, '(a,i1,a)' ) 'P:', rank, ' About to communicate'

!call flush()

!if ( rank == 0 ) then
!
!    write ( *, '(a,i1,a)' ) 'P:', rank, ' About to receive'
!
!    tag = 55
!    call MPI_Recv ( value, 100, MPI_INT, MPI_ANY_SOURCE, tag, &
!      MPI_COMM_WORLD, status, ierr )
!
!    write ( *, '(a,i1,a,i1)' ) 'P:', rank, ' Got data from processor ', &
!      status(MPI_SOURCE)
!
!    !call MPI_Get_count ( status, MPI_REAL, count, ierr )
!
!    !write ( *, '(a,i1,a,i3,a)' ) 'P:', rank, ' Got ', count, ' elements.'
!
!    write ( *, '(a,i1,a,g14.6)' ) 'P:', rank, ' value(5) = ', value(5)
!
!    !call MPI_Get_count ( status, MPI_REAL, count, ierr )
!
!    !write ( *, '(a,i1,a,i3,a)' ) 'P:', rank, ' Got ', count, ' elements.'
!
!    write ( *, '(a,i1,a,g14.6)' ) 'P:', rank, ' value(5) = ', value(5)
!
! else
! 
!    write ( *, '(a)' ) ' '
!    write ( *, '(a,i1,a)' ) 'P:', rank, &
!      ' - setting up data to send to process 0.'
!
!    do i = 1, 100
!      data(i) = i
!    end do
!
!    dest = 0
!    tag = 55
!    call MPI_Send ( data, 100, MPI_INT, dest, tag, MPI_COMM_WORLD, ierr )
!  
!  !else
!
!  !  write ( *, '(a)' ) ' '
!  !  write ( *, '(a,i1,a)' ) 'P:', rank, ' - MPI has no work for me!'
!
!end if

!call MPI_FINALIZE(ierr)

end program main
