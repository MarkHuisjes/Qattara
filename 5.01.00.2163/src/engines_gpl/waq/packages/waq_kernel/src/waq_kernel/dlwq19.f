!!  Copyright(C) Stichting Deltares, 2012.
!!
!!  This program is free software: you can redistribute it and/or modify
!!  it under the terms of the GNU General Public License version 3,
!!  as published by the Free Software Foundation.
!!
!!  This program is distributed in the hope that it will be useful,
!!  but WITHOUT ANY WARRANTY; without even the implied warranty of
!!  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
!!  GNU General Public License for more details.
!!
!!  You should have received a copy of the GNU General Public License
!!  along with this program. If not, see <http://www.gnu.org/licenses/>.
!!
!!  contact: delft3d.support@deltares.nl
!!  Stichting Deltares
!!  P.O. Box 177
!!  2600 MH Delft, The Netherlands
!!
!!  All indications and logos of, and references to registered trademarks
!!  of Stichting Deltares remain the property of Stichting Deltares. All
!!  rights reserved.

      SUBROUTINE DLWQ19 ( IOUT   , IDUMP  , ARRA   , VNAME  , DNAME  ,
     *                    NODUMP , ID     , NEND   , NOTOT  )
C
C     Deltares     SECTOR WATERRESOURCES AND ENVIRONMENT
C
C     CREATED: april 4, 1991 by J. van Beek
C
C     FUNCTION            : Writes monitoring results to IOUT in
C                                          blocks of 10 systems.
C
C     LOGICAL UNITNUMBERS : IOUT = number of monitoring output file
C
C     SUBROUTINES CALLED  : none
C
C     PARAMETERS          :
C
C     NAME    KIND     LENGTH     FUNCT.  DESCRIPTION
C     ----    -----    ------     ------- -----------
C     IOUT    INTEGER   1         INPUT   unit number output file
C     IDUMP   INTEGER   NODUMP    INPUT   segment numbers for dump
C     ARRA    REAL      *         INPUT   values to be printed
C     VNAME   CHAR*40   1         INPUT   name of printed value
C     DNAME   CHAR*20   NODUMP    INPUT   names of monitoring stations
C     NODUMP  INTEGER   1         INPUT   amount of dump segments
C     ID      INTEGER   1         INPUT   index first system in this block
C     NEND    INTEGER   1         INPUT   index last system in this block
C     NOTOT   INTEGER   1         INPUT   total number of systems
C
      use timers
      DIMENSION    IDUMP(*) , ARRA(NOTOT,*)
      CHARACTER*20 DNAME(*)
      CHARACTER*40 VNAME
      CHARACTER*1  SPACE
      DATA         SPACE / ' ' /
      integer(4) ithandl /0/
      if ( timon ) call timstrt ( "dlwq19", ithandl )

      WRITE (IOUT,2060) VNAME

      DO 40 I=1,NODUMP
      ISEG = IDUMP(I)
      IF ( DNAME(I) .EQ. SPACE ) THEN
           WRITE (IOUT,2080) ISEG    ,(ARRA(K,ISEG),K=ID,NEND)
      ELSE
           WRITE (IOUT,2090) DNAME(I),(ARRA(K,ISEG),K=ID,NEND)
      ENDIF
   40 CONTINUE
      if ( timon ) call timstop ( ithandl )
      RETURN
 2060 FORMAT (  ' ', A40 )
 2080 FORMAT (  ' SEGMENT NR:',I6,'   ',10(1P,E11.4))
 2090 FORMAT (  ' ',      A20          ,10(1P,E11.4))
      END
