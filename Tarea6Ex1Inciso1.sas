ods pdf file="/home/u49913583/sasuser.v94/AAR/Inciso1.pdf";
Title "Ejercicio 1 Inciso 1";
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
	
	vO1 = cdf('NORMAL',LZO1);
	vO2 = cdf('NORMAL',LZO2);
	vB  = cdf('NORMAL',LZB );
	vP1 = cdf('NORMAL',LZP1);
	vP2 = cdf('NORMAL',LZP2);
	
	print "2) Calculate the simulated total loss due to Equity and Credit risk factors using the correlated uniform values. Show your work.";
	
	L_equityO1 = quantile('NORMAL',vO1[1],0,500);
	L_creditO1 = quantile('NORMAL',vO1[2],0,1000);
	
	L_equityO2 = quantile('NORMAL',vO2[1],0,500);
	L_creditO2 = quantile('NORMAL',vO2[2],0,1000);
	
	L_equityB = quantile('NORMAL',vB[1],0,500);
	L_creditB = quantile('NORMAL',vB[2],0,1000);
	
	L_equityP1 = quantile('NORMAL',vP1[1],0,500);
	L_creditP1 = quantile('NORMAL',vP1[2],0,1000);
	
	L_equityP2 = quantile('NORMAL',vP2[1],0,500);
	L_creditP2 = quantile('NORMAL',vP2[2],0,1000);
	
	
	TotalLoss_O1 = L_equityO1 + L_creditO1;
	TotalLoss_O2 = L_equityO2 + L_creditO2;
	TotalLoss_B  = L_equityB  + L_creditB ;
	TotalLoss_P1 = L_equityP1 + L_creditP1;
	TotalLoss_P2 = L_equityP2 + L_creditP2;
	
	print TotalLoss_O1  TotalLoss_O2 TotalLoss_B TotalLoss_P1 TotalLoss_P2 ;
	
run;

ods pdf close;
