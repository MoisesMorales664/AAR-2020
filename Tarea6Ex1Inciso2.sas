
ods pdf file="/home/u49913583/sasuser.v94/AAR/Inciso2.pdf";
title "Ejercicio 1 Inciso 2";
proc iml;
	Correlacion={0.15, 0.20, 0.25, 0.30, 0.35};
	Escenario={'Optimista 1', 'Optimista 2', 'Base', 'Pesimista 1', 'Pesimista 2'};

	print  Escenario Correlacion;
	
	O1={1 0.15, 0.15 1};
	O2={1 0.20, 0.20 1};
	B ={1 0.25, 0.25 1};
	P1={1 0.30, 0.30 1};
	P2={1 0.35, 0.35 1};
		
	LO1=t(root(O1));
	LO2=t(root(O2));
	LB=t(root(B));
	LP1=t(root(P1));
	LP2=t(root(P2));
		
	u = {0.95 0.08};
	
	z = quantile('NORMAL',u);
	
	LZO1 = LO1*Z`;
	LZO2 = LO2*Z`;
	LZB  = LB*Z`;
	LZP1 = LP1*Z`;
	LZP2 = LP2*Z`;

	tO1=LZO1*(1/(0.325/2))**0.5;
	tO2=LZO2*(1/(0.325/2))**0.5;
	tB=LZB*(1/(0.325/2))**0.5;
	tP1=LZP1*(1/(0.325/2))**0.5;
	tP2=LZP2*(1/(0.325/2))**0.5;
		
	vtO1=cdf('TO1',tO1,2);
	vtO2=cdf('TO2',tO2,2);
	vtB=cdf('TB',tB,2);
	vtP1=cdf('TP1',tP1,2);
	vtP2=cdf('TP2',tP2,2);
	
	print "2) Calculate the simulated total loss due to Equity and Credit risk factors using the correlated uniform values. Show your work.";

	lt_equityO1 = quantile('NORMAL',vtO1[1],0,500);
	lt_creditO1 = quantile('NORMAL',vtO1[2],0,1000);
	
	lt_equityO2 = quantile('NORMAL',vtO2[1],0,500);
	lt_creditO2 = quantile('NORMAL',vtO2[2],0,1000);
	
	lt_equityB = quantile('NORMAL',vtB[1],0,500);
	lt_creditB = quantile('NORMAL',vtB[2],0,1000);
	
	lt_equityP1 = quantile('NORMAL',vtP1[1],0,500);
	lt_creditP1 = quantile('NORMAL',vtP1[2],0,1000);
	
	lt_equityP2 = quantile('NORMAL',vtP2[1],0,500);
	lt_creditP2 = quantile('NORMAL',vtP2[2],0,1000);
	
	
	TotalLoss_O1 = Lt_equityO1 + lt_creditO1;
	TotalLoss_O2 = LT_equityO2 + LT_creditO2;
	TotalLoss_B  = LT_equityB  + LT_creditB ;
	TotalLoss_P1 = LT_equityP1 + LT_creditP1;
	TotalLoss_P2 = LT_equityP2 + LT_creditP2;
	
	print TotalLoss_O1  TotalLoss_O2 TotalLoss_B TotalLoss_P1 TotalLoss_P2 ;
	

run;
ods pdf close;
