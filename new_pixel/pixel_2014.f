	

!       ****************************************************** 
!            LAPLACE SOLVER FOR FINITE DEPTH 
!            STRUCTURE OF 9 SQUARE JUNCTIONS
!	     INCLUDING THE CONTRIBUTION OF AIR.
!            INPUT IS ON THE FILE inlapl1 AND
!            OUTPUT IS FILE lap.9pix.air.out OUT
!                   JANUARY 1993.
!       ******************************************************

!       ******************************************************
!                 DEFINITIONS OF VARIABLES
!       ******************************************************

       	INTEGER DIM
	PARAMETER(DIM=1024)
	REAL DATA(2*DIM*DIM),P(DIM,DIM,2),W(DIM)
	REAL P1(DIM,DIM,2),PS(DIM,DIM,2)
	REAL R,PI,C00,C01,C02,EAIR,ESI,C1D
	REAL LM,D,CB,C1,C2,C3,C4,C5,C6,C7,C8,C0
	INTEGER NN(2),RUNS,Z,LJ
	INTEGER RES,A1,A2,A3,A4,A5,A6,PITCH,L,CYCLE
	COMMON DATA,P,P1
	RES=DIM
	ESI=11.9
	EAIR=1.
	OPEN(UNIT=10,FILE='inlapl1')
	OPEN (UNIT=11,File='output')
	OPEN (UNIT=12,File='output2')
	OPEN (UNIT=15,File='PS')
	OPEN (UNIT=17,File='PS xwris four')
	OPEN (UNIT=16,File='P1')
	OPEN(UNIT=22,FILE='P1 teliko')
	OPEN(UNIT=22,FILE='lap.9pix.air.out')
	READ(10,*)RUNS
	DO 1968,Z=1,RUNS

!       *****************************************************
!               INPUT FROM FILE INLAPL1
!       ***************************************************** 

	   READ(10,*)RES,LJ,PITCH,D

!       ****************************************************
!               HYPOTHETICAL SOLUTION ON SURFACE
!       ****************************************************
	   print *, 'Resolution = ', RES
	   print *, 'Pixel Length = ', LJ
	   print *, 'Pitch = ', PITCH
	   M=1
	   PI=3.14159
	   CYCLE=0
	   A3=(RES-LJ)/2
	   A4=(RES+LJ)/2+1
	   A2=A3-PITCH+1
	   A5=A4+PITCH-1
	   A1=A2-LJ-1
	   A6=A5+LJ+1
	   print *, 'placement of pixels on the grid'
	   print *, 'A1=', A1
	   print *, 'A2=', A2
	   print *, 'A3=', A3
	   print *, 'A4=', A4
	   print *, 'A5=', A5
	   print *, 'A6=', A6
	   DO 1,K=1,RES
	      DO 2,L=1,RES
		 P(K,L,2)=0.0
		 IF((K.GT.A3).AND.(K.LT.A4).AND.(L.GT.A3).AND.(L.LT.A4))THEN
		    P(K,L,1)=1.0
		    print *, 'P(K,L,1)=',K,L, P(K,L,1)
		 END IF
 2	      CONTINUE
 1	   CONTINUE
	   DO 3,K=1,A3
	      DO 4,L=1,A3
		 LM=SQRT((REAL(K)-REAL(A3))**2+(REAL(L)-REAL(A3))**2)
		 P(K,L,1)=1./(LM+1.)
 4	      CONTINUE
 3	   CONTINUE
	   DO 5,K=1,A3
	      DO 6,L=A3+1,A4
		 LM=REAL(A3)-REAL(K)
		 P(K,L,1)=1./(LM+1.)
 6	      CONTINUE
 5	   CONTINUE
	   DO 7,K=1,A3
	      DO 8,L=A4+1,RES
		 LM=SQRT((REAL(K)-REAL(A3))**2+(REAL(L)-REAL(A4))**2)
		 P(K,L,1)=1./(LM+1.)
 8	      CONTINUE
 7	   CONTINUE
	   DO 9,K=A3+1,A4
	      DO 10,L=1,A3
		 LM=REAL(A3)-REAL(L)
		 P(K,L,1)=1./(LM+1.)
 10	      CONTINUE
 9	   CONTINUE
	   DO 11,K=A3+1,A4
	      DO 12,L=A4+1,RES
		 LM=REAL(L)-REAL(A4)
		 P(K,L,1)=1./(LM+1.)
 12	      CONTINUE
 11	   CONTINUE
	   DO 13,K=A4+1,RES
	      DO 14,L=1,A3
		 LM=SQRT((REAL(K)-REAL(A4))**2+(REAL(L)-REAL(A3))**2)
		 P(K,L,1)=1./(LM+1.)
 14	      CONTINUE
 13	   CONTINUE
	   DO 15,K=A4+1,RES
	      DO 16,L=A3+1,A4 
		 LM=REAL(K)-REAL(A4)
		 P(K,L,1)=1./(LM+1.)
 16	      CONTINUE
 15	   CONTINUE
	   DO 17,K=A4+1,RES
	      DO 18,L=A4+1,RES
		 LM=SQRT((REAL(K)-REAL(A4))**2+(REAL(L)-REAL(A4))**2)
		 P(K,L,1)=1./(LM+1.)
 18	      CONTINUE
 17	   CONTINUE
	   DO 19,K=A1+1,A2-1
	      DO 19,L=A1+1,A2-1
		 P(K,L,1)=0.
 19	      CONTINUE
	      DO 206,K=A3+1,A4-1
		 DO 206,L=A1+1,A2-1
		    P(K,L,1)=0.
 206		 CONTINUE
		 DO 216,K=A5+1,A6-1
		    DO 216,L=A1+1,A2-1
		       P(K,L,1)=0.
 216		    CONTINUE
		    DO 226,K=A1+1,A2-1
		       DO 226,L=A3+1,A4-1
			  P(K,L,1)=0.
 226		       CONTINUE
		       DO 236,K=A5+1,A6-1
			  DO 236,L=A3+1,A4-1
			     P(K,L,1)=0.
 236			  CONTINUE
			  DO 246,K=A1+1,A2-1
			     DO 246,L=A5+1,A6-1
				P(K,L,1)=0.
 246			     CONTINUE
			     DO 256,K=A3+1,A4-1
				DO 256,L=A5+1,A6-1
				   P(K,L,1)=0.
 256				CONTINUE
				DO 266,K=A5+1,A6-1
				   DO 266,L=A5+1,A6-1
				      P(K,L,1)=0.
 266				   CONTINUE
				   NN(1)=RES
				   NN(2)=RES
				   DO 4000,L=1,200
				      DO 4010,K=1,200
					 
					 Write (11,*) 'P(K,L,1)=',K,L, P(K,L,1)
	4				      010    CONTINUE
	4				      000    CONTINUE
					 

!       ****************************************************       
!          HYPOTHETICAL SOLUTION ON SURFACE NOW IS SET
!       ****************************************************
					 
 222					 CONTINUE        
					 CYCLE=CYCLE+1
					 
!       ***************************************************
!           FOURIER TRANSFORM OF SURFACE POTENTIAL 
!       ***************************************************

					 J=1
					 DO 100,L=1,RES
					    DO 101,K=1,RES
					       DATA(J)=P(K,L,1)
					       DATA(J+1)=P(K,L,2)
					       J=J+2
	1					    01     CONTINUE
	1					    00     CONTINUE
					       CALL FOURN(DATA,NN,2,1)
					       DO 24,M=1,2*RES*RES,2
						  L=M/(2*RES)+1
						  J=M-(L-1)*(2*RES)
						  K=(J-1)/2+1
						  P1(K,L,1)=DATA(M)
						  P1(K,L,2)=DATA(M+1)
 24					       CONTINUE
					       DO 3000,L=1,200
						  DO 3010,K=1,200
						     
						     Write (12,*) 'P1(K,L,1)=',K,L, P1(K,L,1)
	3						  010    CONTINUE
	3						  000    CONTINUE
						     
						     
!       **************************************************
!                P1 IS THE FT OF POTENTIAL. 
!                CALCULATION OF K VECTORS.
!       *************************************************

						     DO 25,K=1,RES/2+1 
							W(K)=2.0*PI*REAL(K-1)/REAL(RES)
 25						     CONTINUE
						     J=1
						     DO 26,K=RES/2+2,RES
							W(K)=W(RES/2+1-J)
							J=J+1
 26						     CONTINUE

!       ***************************************************
!         FT OF P1 WILL BE CONVERTED IN FT OF ELECTRIC
!         FIELD BY MULTIPLICATION  WITH X (SEE NOTES).
!               PS IS THE FIELD IN THE AIR.
!       ***************************************************

						     DO 2751,K=1,RES
							DO 2751,L=1,RES
							   R=SQRT(W(K)**2+W(L)**2)
							   PS(K,L,1)=P1(K,L,1)*R
							   PS(K,L,2)=P1(K,L,2)*R
 2751							CONTINUE
							DO 9000,L=1,200
							   DO 9010,K=1,200
							      
							      Write (17,*) 'PS(K,L,1)=',K,L, Ps(K,L,1)
	9							   010    CONTINUE
	9							   000    CONTINUE
							      
!       DO 275,K=1,RES
!       DO 275,L=1,RES
!       R=SQRT(W(K)**2+W(L)**2)
!       IF(R.EQ.0.0)THEN
!       EZ(K,L,1)=P1(K,L,1)*(1./D)
!       EZ(K,L,2)=P1(K,L,2)*(1./D)
!       ELSE
!       EZ(K,L,1)=P1(K,L,1)*(2.*R*EXP(-R*D)) 
!    1  /(1.-EXP(-2.*R*D))
!       EZ(K,L,2)=P1(K,L,2)*(2.*R*EXP(-R*D))
!    1  /(1.-EXP(-2.*R*D))
!       END IF
!275    CONTINUE
							      DO 27,K=1,RES
								 DO 27,L=1,RES
								    R=SQRT(W(K)**2+W(L)**2)
								    IF(R.EQ.0.0)THEN
								       P1(K,L,1)=P1(K,L,1)*(1./D)
								       P1(K,L,2)=P1(K,L,2)*(1./D)
								    ELSE
								       P1(K,L,1)=P1(K,L,1)*R*(1.+EXP(-2.*R*D))/  &
								       &  (1.-EXP(-2.*R*D))
								       P1(K,L,2)=P1(K,L,2)*R*(1.+EXP(-2.*R*D))/  &
								       &  (1.-EXP(-2.*R*D)) 
								    END IF
 27								 CONTINUE

!	*************************************************
!       P1 IS THE FT OF ELECTRIC FIELD.PS IS THE FT OF
!	       THE ELECTRIC FIELD IN THE AIR.
!         FT WILL TRANSFORM P1,PS IN ELECTRIC FIELD.
!          EZ IS THE FT OF ELECTRIC FIELD IN THE 
!                    LOWER SURFACE
!       **************************************************

								 J=1
								 DO 293,L=1,RES
								    DO 303,K=1,RES
								       DATA(J)=PS(K,L,1)
								       DATA(J+1)=PS(K,L,2)
								       J=J+2
	3								    03     CONTINUE
	2								    93     CONTINUE
								       CALL FOURN(DATA,NN,2,-1)
								       DO 343,M=1,2*RES*RES,2
									  L=M/(2*RES)+1
									  J=M-(L-1)*(2*RES)
									  K=(J-1)/2+1
									  PS(K,L,1)=(1./(RES*RES))*DATA(M)
									  PS(K,L,2)=(1./(RES*RES))*DATA(M+1)
 343								       CONTINUE
								       J=1
								       DO 29,L=1,RES
									  DO 30,K=1,RES
									     DATA(J)=P1(K,L,1)
									     DATA(J+1)=P1(K,L,2)
									     J=J+2
	3									  0      CONTINUE
	2									  9      CONTINUE
									     CALL FOURN(DATA,NN,2,-1)
									     DO 34,M=1,2*RES*RES,2
										L=M/(2*RES)+1
										J=M-(L-1)*(2*RES)
										K=(J-1)/2+1
										P1(K,L,1)=(1./(RES*RES))*DATA(M)
										P1(K,L,2)=(1./(RES*RES))*DATA(M+1)
 34									     CONTINUE
									     
									     DO 8000,L=1,200
										DO 8010,K=1,200
										   
										   Write (15,*) 'PS(K,L,1)=',K,L, PS(K,L,1)
										   Write (16,*) 'P1(K,L,1)=',K,L, P1(K,L,1)
										   
	8										010    CONTINUE
	8										000    CONTINUE
										   
										   
										   
!       J=1
!       DO 291,L=1,RES
!       DO 301,K=1,RES
!       DATA(J)=EZ(K,L,1)
!       DATA(J+1)=EZ(K,L,2)
!       J=J+2
! 301     CONTINUE
!  291     CONTINUE
!       CALL FOURN(DATA,NN,2,-1)
!       DO 341,M=1,2*RES*RES,2
!       L=M/(2*RES)+1
!       J=M-(L-1)*(2*RES)
!       K=(J-1)/2+1
!       EZ(K,L,1)=(1./(RES*RES))*DATA(M)
!       EZ(K,L,2)=(1./(RES*RES))*DATA(M+1)
!341    CONTINUE

!       **************************************************
!        CALCULATION OF SUMs(FIELD*SURF.),WHICH IS DESIGNATED
!          BY Cn AND IS THE TOTAL CHARGE ON THE APPROPRIATE 
!        SURFACE DIVIDED BY THE DIELECTRIC CONSTANT OF SILICON.
!          WE HAVE SUMMATION ONLY ON SQUARES  BECAUSE
!              OUTSIDE OF THE SQUARES CHARGE IS ZERO.
!       ***************************************************

!       CB=0.
!       DO 79,K=1,RES
!       DO 79,L=1,RES
!       CB=CB+EZ(K,L,1)
!79     CONTINUE



										   C0=0.
										   DO 80,K=A3+1,A4-1
										      DO 80,L=A3+1,A4-1
											 
											 C0=C0+ESI*P1(K,L,1)+EAIR*PS(K,L,1)
 80										      CONTINUE
										      print *, C0
										      C1=0.
										      DO 81,K=A1+1,A2-1
											 DO 81,L=A1+1,A2-1
											    C1=C1+ESI*P1(K,L,1)+EAIR*PS(K,L,1)
 81											 CONTINUE
											 print *, C1
											 C2=0.
											 DO 82,K=A3+1,A4-1
											    DO 82,L=A1+1,A2-1
											       
											       C2=C2+ESI*P1(K,L,1)+EAIR*PS(K,L,1)
											       
 82											    CONTINUE
											    print *, C2
											    C3=0.    
											    DO 83,K=A5+1,A6-1
											       DO 83,L=A1+1,A2-1
												  C3=C3+ESI*P1(K,L,1)+EAIR*PS(K,L,1)
 83											       CONTINUE
											       print *, C3
											       C4=0.
											       DO 84,K=A1+1,A2-1
												  DO 84,L=A3+1,A4-1
												     C4=C4+ESI*P1(K,L,1)+EAIR*PS(K,L,1)
 84												  CONTINUE
												  print *, C4
												  C5=0.
												  DO 85,K=A5+1,A6-1
												     DO 85,L=A3+1,A4-1
													C5=C5+ESI*P1(K,L,1)+EAIR*PS(K,L,1)
 85												     CONTINUE
												     print *, C5
												     C6=0.
												     DO 86,K=A1+1,A2-1
													DO 86,L=A5+1,A6-1
													   C6=C6+ESI*P1(K,L,1)+EAIR*PS(K,L,1)
 86													CONTINUE
													print *, C6
													C7=0.
													DO 87,K=A3+1,A4-1
													   DO 87,L=A5+1,A6-1
													      C7=C7+ESI*P1(K,L,1)+EAIR*PS(K,L,1)
 87													   CONTINUE
													   print *, C7
													   C8=0.
													   DO 88,K=A5+1,A6-1
													      DO 88,L=A5+1,A6-1
														 C8=C8+ESI*P1(K,L,1)+EAIR*PS(K,L,1)
 88													      CONTINUE
													      print *, C8
													      print *, '---------------------------------------------------------------------------'
													      
!       *****************************************************
!        SETTING ELECTRIC DISPALCEMENT CONTINIOUS IN THE
!        FRONT SURFACE OUTSIDE OF THE JUNCTIONS.
!       *****************************************************

													      DO 36,K=1,RES
														 DO 36,L=1,RES
														    IF(((K.LE.A1).OR.((K.GE.A2).AND.(K.LE.A3))&
														    &.OR.((K.GE.A4).AND.(K.LE.A5)).OR. &
														    &(K.GE.A6)).OR.((L.LE.A1).OR.((L.GE.A2) &
														    &.AND.(L.LE.A3)).OR.((L.GE.A4).AND. &
														    &(L.LE.A5)).OR.(L.GE.A6))) THEN
														    P1(K,L,1)=EAIR*PS(K,L,1)/ESI
														    P1(K,L,2)=EAIR*PS(K,L,2)/ESI
														 ELSE
														 END IF
 36													      CONTINUE
													      
!       ***************************************************
!           P1 WILL CONVERTED IN FT OF VOLTAGE
!       ***************************************************

													      J=1
													      DO 37,L=1,RES
														 DO 38,K=1,RES
														    DATA(J)=P1(K,L,1)
														    DATA(J+1)=P1(K,L,2)
														    J=J+2
	3														 8      CONTINUE
	3														 7      CONTINUE
														    CALL FOURN(DATA,NN,2,1)
														    DO 42,M=1,2*RES*RES,2
														       L=M/(2*RES)+1
														       J=M-(L-1)*(2*RES)
														       K=(J-1)/2+1
														       P1(K,L,1)=DATA(M)
														       P1(K,L,2)=DATA(M+1)
 42														    CONTINUE
														    DO 43,K=1,RES
														       DO 44,L=1,RES
															  R=SQRT(W(K)**2+W(L)**2)
															  IF(R.EQ.0.)THEN
															     P1(K,L,1)=P1(K,L,1)*D
															     P1(K,L,2)=P1(K,L,2)*D
															  ELSE
															     P1(K,L,1)=P1(K,L,1)/ &
															     &  (R*(1.+EXP(-2.*R*D))/(1.-EXP(-2.*R*D)))
															     P1(K,L,2)=P1(K,L,2)/ &
															     &  (R*(1.+EXP(-2.*R*D))/(1.-EXP(-2.*R*D)))
															  END IF
 44														       CONTINUE
 43														    CONTINUE

!       ****************************************************
!         P1 IS THE FT OF VOLTAGE.
!        IT WILL BE CONVERTED TO VOLTAGE
!       ****************************************************

														    J=1
														    DO 45,L=1,RES
														       DO 46,K=1,RES
															  DATA(J)=P1(K,L,1)
															  DATA(J+1)=P1(K,L,2)
															  J=J+2
	4														       6      CONTINUE
	4														       5      CONTINUE
															  CALL FOURN(DATA,NN,2,-1)
															  DO 234,M=1,2*RES*RES,2
															     L=M/(2*RES)+1
															     J=M-(L-1)*(2*RES)
															     K=(J-1)/2+1
															     P1(K,L,1)=(1./(RES*RES))*DATA(M)
															     P1(K,L,2)=(1./(RES*RES))*DATA(M+1)
 234															  CONTINUE
															  
!       *******************************************************   
!        NOW P1 IS THE NEW VALUE FOR VOLTAGE.WE SUPPOSE
!        THAT THE SOLUTION IS A SUPERPOSITION OF THE SUPPOSED
!        VALUE ON THE SURFACE AND P1.WE APPLY THE FORMULA:
!            VOLTAGE = ( 1 - f ) P + f P1
!        WHERE f IS A COEFFICIENT BETWEEN 0 AND 1.
!        WE SELECT A VALUE OF f FOR CONVERGENCE OF
!        THE ALGORITHM.
!        NEXT WE CHECK THE DIFFERENCE VOLTAGE(NEW)-VOLTAGE 
!        ALSO WE TAKE CARE OF VOLTAGE TO BE 1 IN THE SQUARE.
!        *******************************************************
															  DO 5000,L=1,200
															     DO 5010,K=1,200
																
																
																Write (16,*) 'P1(K,L,1)=',K,L, P1(K,L,1)
																
	5															     010    CONTINUE
	5															     000    CONTINUE 



																DO 52,K=1,RES
																   DO 52,L=1,RES
																      P(K,L,1)=0.8*P(K,L,1)+0.2*P1(K,L,1)
																      P(K,L,2)=0.8*P(K,L,2)+0.2*P1(K,L,2)
 52																   CONTINUE
																   DO 193,K=A1+1,A2-1
																      DO 193,L=A1+1,A2-1
																	 P(K,L,1)=0.
																	 P(K,L,2)=0.
 193																      CONTINUE
																      DO 203,K=A3+1,A4-1
																	 DO 203,L=A1+1,A2-1
																	    P(K,L,1)=0.
																	    P(K,L,2)=0.
 203																	 CONTINUE
																	 DO 213,K=A5+1,A6-1
																	    DO 213,L=A1+1,A2-1
																	       P(K,L,1)=0.
																	       P(K,L,2)=0.
 213																	    CONTINUE
																	    DO 223,K=A1+1,A2-1
																	       DO 223,L=A3+1,A4-1
																		  P(K,L,1)=0.
																		  P(K,L,2)=0.
 223																	       CONTINUE
																	       DO 233,K=A5+1,A6-1
																		  DO 233,L=A3+1,A4-1
																		     P(K,L,1)=0.
																		     P(K,L,2)=0. 
 233																		  CONTINUE
																		  DO 243,K=A1+1,A2-1
																		     DO 243,L=A5+1,A6-1
																			P(K,L,1)=0.
																			P(K,L,2)=0.
 243																		     CONTINUE
																		     DO 253,K=A3+1,A4-1
																			DO 253,L=A5+1,A6-1
																			   P(K,L,1)=0.
																			   P(K,L,2)=0.
 253																			CONTINUE
																			DO 263,K=A5+1,A6-1
																			   DO 263,L=A5+1,A6-1
																			      P(K,L,1)=0.
																			      P(K,L,2)=0.
 263																			   CONTINUE
																			   DO 823,K=A3+1,A4-1
																			      DO 823,L=A3+1,A4-1
																				 P(K,L,1)=1.0
																				 P(K,L,2)=0.0
 823																			      CONTINUE
																			      ICHK=1
																			      DO 553,K=1,RES
																				 DO 553,L=1,RES
																				    IF (ABS(P(K,L,1)-P1(K,L,1)) .GT. 1.E-3) ICHK=0
 553																				 CONTINUE 
																				 WRITE(22,*)'CYCLE NUMBER ',CYCLE
																				 WRITE(22,*)'   C00/C1d       C01/C1d         C02/C1d'
																				 C1D=ESI*LJ*LJ/D
																				 C01=(C2+C4+C7+C5)/4.*(-1.)
																				 C02=(C1+C3+C6+C8)/4.*(-1.)
																				 C00=C0-4.*C01-4.*C02
																				 C00=C00/C1D
																				 C01=C01/C1D
																				 C02=C02/C1D
																				 WRITE(22,*)C00,C01,C02
!       C0=C0-CB+C1+C2+C3+C4+C5+C6+C7+C8
!       WRITE(22,*)'TOTAL CHARGE :',C0
																				 WRITE(22,*)' '
																				 IF (ICHK .EQ. 0) GO TO 222
																				 WRITE(22,*)'THE RESOLUTION WAS=',RES,'L=',LJ
																				 WRITE(22,*)'DEPTH W=',D,'SEPERATION',PITCH
																				 WRITE(22,*)'RUN No ',Z
																				 WRITE(22,*)'**********************************************'
 1968																			      CONTINUE        
																			      END


	SUBROUTINE FOURN(DATA,NN,NDIM,ISIGN)
	REAL*8 WR,WI,WPR,WPI,WTEMP,THETA
	DIMENSION NN(NDIM),DATA(*)
	NTOT=1
	DO 11 IDIM=1,NDIM
	   NTOT=NTOT*NN(IDIM)
 11	CONTINUE
	NPREV=1
	DO 18 IDIM=1,NDIM
	   N=NN(IDIM)
	   NREM=NTOT/(N*NPREV)
	   IP1=2*NPREV
	   IP2=IP1*N
	   IP3=IP2*NREM
	   I2REV=1
	   DO 14 I2=1,IP2,IP1
	      IF(I2.LT.I2REV)THEN
		 DO 13 I1=I2,I2+IP1-2,2
		    DO 12 I3=I1,IP3,IP2
		       I3REV=I2REV+I3-I2
		       TEMPR=DATA(I3)
		       TEMPI=DATA(I3+1)
		       DATA(I3)=DATA(I3REV)
		       DATA(I3+1)=DATA(I3REV+1)
		       DATA(I3REV)=TEMPR
		       DATA(I3REV+1)=TEMPI
 12		    CONTINUE        
 13		 CONTINUE
	      ENDIF
	      IBIT=IP2/2
 1	      IF((IBIT.GE.IP1).AND.(I2REV.GT.IBIT)) THEN
		 I2REV=I2REV-IBIT
		 IBIT=IBIT/2
		 GO TO 1
	      ENDIF
	      I2REV=I2REV+IBIT
 14	   CONTINUE
	   IFP1=IP1 
 2	   IF(IFP1.LT.IP2)THEN
	      IFP2=2*IFP1
	      THETA=ISIGN*6.28318530717959D0/(IFP2/IP1)
	      WPR=-2.D0*DSIN(0.5D0*THETA)**2
	      WPI=DSIN(THETA)
	      WR=1.D0
	      WI=0.D0
	      DO 17 I3=1,IFP1,IP1
		 DO 16 I1=I3,I3+IP1-2,2
		    DO 15 I2=I1,IP3,IFP2
		       K1=I2
		       K2=K1+IFP1
		       TEMPR=SNGL(WR)*DATA(K2)-SNGL(WI)*DATA(K2+1)
		       TEMPI=SNGL(WR)*DATA(K2+1)+SNGL(WI)*DATA(K2)
		       DATA(K2)=DATA(K1)-TEMPR
		       DATA(K2+1)=DATA(K1+1)-TEMPI
		       DATA(K1)=DATA(K1)+TEMPR
		       DATA(K1+1)=DATA(K1+1)+TEMPI
 15		    CONTINUE
 16		 CONTINUE
		 WTEMP=WR
		 WR=WR*WPR-WI*WPI+WR
		 WI=WI*WPR+WTEMP*WPI+WI
 17	      CONTINUE
	      IFP1=IFP2
	      GO TO 2
	   ENDIF
	   NPREV=N*NPREV
 18	CONTINUE
	RETURN
	END
