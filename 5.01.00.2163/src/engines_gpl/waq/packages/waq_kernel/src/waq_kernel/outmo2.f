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

      SUBROUTINE OUTMO2 ( IOUT   , ARRA   , VNAME  , DNAME  , NODUMP ,
     +                    ID     , NEND   , NOTOT  )
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
C     PARAMETERS          : 8
C
C     NAME    KIND     LENGTH     FUNCT.  DESCRIPTION
C     ----    -----    ------     ------- -----------
C     IOUT    INTEGER   1         INPUT   unit number output file
C     ARRA    REAL      *         INPUT   values to be printed
C     VNAME   CHAR*40   1         INPUT   name of printed value
C     DNAME   CHAR*20   NODUMP    INPUT   names of monitoring stations
C     NODUMP  INTEGER   1         INPUT   amount of dump segments
C     ID      INTEGER   1         INPUT   index first system in this block
C     NEND    INTEGER   1         INPUT   index last system in this block
C     NOTOT   INTEGER   1         INPUT   total number of systems
C
C     Declaration of arguments
C
      use timers

      INTEGER      IOUT  , NODUMP, ID    , NEND  , NOTOT
      REAL         ARRA(NOTOT,*)
      CHARACTER*20 DNAME(*)
      CHARACTER*40 VNAME
      integer(4) ithandl /0/
      if ( timon ) call timstrt ( "outmo2", ithandl )
C
      WRITE (IOUT,2060) VNAME
C
      DO 40 IDMP=1,NODUMP
         WRITE (IOUT,2090) DNAME(IDMP),(ARRA(K,IDMP),K=ID,NEND)
   40 CONTINUE
C
      if ( timon ) call timstop ( ithandl )
      RETURN
 2060 FORMAT (  ' ', A40 )
 2090 FORMAT (  ' ',      A20          ,10(1P,E11.4))
      END
