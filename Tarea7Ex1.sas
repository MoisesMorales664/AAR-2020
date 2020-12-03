/* Optimista1	 */
proc iml;
	Escenario={Optimista1, Optimista2, Optimista3, Base, Pesimista1, Pesimista2, Pesimista3};
	Correlacion={-0.05, 0.05, 0.15, 0.25, 0.35, 0.45, 0.55};
	print Escenario Correlacion;
	* Fixing the seed of random numbers for replicability;
	call randseed(2020);
	* Number of simulations;
	N = 100000;
	muA = 0;
	muP = 0;
	* Vector of standard deviations for assets and liabilities, respectively;
	sigma = {500 500};
	* Independent normal standard numbers for Assets (A);
	ZA = j(N,1);
	call randgen(ZA,"Normal",0,1);
	* Independent normal standard numbers for liabilities (P);
	ZP = j(N,1);
	call randgen(ZP,"Normal",0,1);
	* Mixing the two previous vectors in a matrix;
	Z = ZA||ZP;
	
/* 	Matrices de correlaciones */
	O1={1 -0.05 , -0.05 1};
	
	* Choleski decomposition;
	LO1 = t(root(O1));
	
	* Correlating the independent normal standard numbers;	
	LZO1 = LO1*Z`;
	
	* Calculating the asset loss;
	LAO1 = sigma[1] * LZO1[1, ]; 
	
	* Calculating the liability loss;
	LPO1 = sigma[2] * LZO1[2, ]; 
	
	LO1 = LAO1` + LPO1`;
	
	LAPO1 = LAO1`||LPO1`||LO1;
	
	create work.totalLossO1 from LAPO1;
	append from LAPO1;
	close work.totalLossO1;
run;

proc datasets lib=work nolist nodetails;
	modify totalLossO1;
	rename col1=LAO1 col2=LPO1 col3=totalLossO1;
	format LAO1 LPO1 totalLossO1 comma10.2;
	label LAO1="Asset loss (LAO1)" LPO1="Liability loss (LPO1)" totalLossO1 = "Total loss (LA + LP)";
quit;

ods graphics / reset imagemap noborder;

title "Distribución conjunta de las pérdidas y ganancias de los activos y pasivos";
title2 "Gráfico de dispersión";
/*
proc sgplot data=work.totalLossO1;
 	scatter x = LAO1 y = LPO1;
 	xaxis grid;
	yaxis grid;
run;
*/


title "Distribución conjunta de las pérdidas y ganancias de los activos y pasivos";
title2 "Mapa de calor";
proc sgplot data=work.totalLossO1;
 	heatmap x = LAO1 y = LPO1;
 	xaxis grid;
	yaxis grid;
run;

/* ### */
proc univariate data=work.totalLossO1 pctldef=1;
	var totalLossO1;
	output out=work.varO1 PCTLPRE=p pctlpts=0.005;
run;

title "Requerimiento de Capital por Riesgos Técnicos y Financieros de Seguros";
proc sql;
	select * into: varO1
 	from work.varO1
 	;
quit;

title "Expected Shortfall";
proc sql;
	select mean(totalLossO1) into: es
 	from work.totalLossO1
 	where totalLossO1 < &varO1.
 	;
run;

title 'Pérdida total';
title2 "Histograma";
proc sgplot data=work.totalLossO1;
 	histogram totalLossO1 / fillattrs=(color=green transparency=0.97);
 	density totalLossO1 / lineattrs=(color=red);
  	refline &varO1. / axis=x lineattrs=(color=red pattern=15) label = ("RCTyFS = &var.");
  	refline &es. / axis=x lineattrs=(color=blue pattern=15) label = ("Expected Shortfall = &es.");
 	xaxis grid;
	yaxis grid;
run;


/* Optimista2 */
proc iml;
	Escenario={Optimista1, Optimista2, Optimista3, Base, Pesimista1, Pesimista2, Pesimista3};
	Correlacion={-0.05, 0.05, 0.15, 0.25, 0.35, 0.45, 0.55};
	print Escenario Correlacion;
	* Fixing the seed of random numbers for replicability;
	call randseed(2020);
	* Number of simulations;
	N = 100000;
	muA = 0;
	muP = 0;
	* Vector of standard deviations for assets and liabilities, respectively;
	sigma = {500 500};
	* Independent normal standard numbers for Assets (A);
	ZA = j(N,1);
	call randgen(ZA,"Normal",0,1);
	* Independent normal standard numbers for liabilities (P);
	ZP = j(N,1);
	call randgen(ZP,"Normal",0,1);
	* Mixing the two previous vectors in a matrix;
	Z = ZA||ZP;
	
/* 	Matrices de correlaciones */
	O2={1 0.05 , 0.05 1};
	
	* Choleski decomposition;
	LO2 = t(root(O2));
	
	* Correlating the independent normal standard numbers;	
	LZO2 = LO2*Z`;
	
	* Calculating the asset loss;
	LAO2 = sigma[1] * LZO2[1, ]; 
	
	* Calculating the liability loss;
	LPO2 = sigma[2] * LZO2[2, ]; 
	
	LO2 = LAO2` + LPO2`;
	
	LAPO2 = LAO2`||LPO2`||LO2;
	
	create work.totalLossO2 from LAPO2;
	append from LAPO2;
	close work.totalLossO2;
run;

proc datasets lib=work nolist nodetails;
	modify totalLossO2;
	rename col1=LAO2 col2=LPO2 col3=totalLossO2;
	format LAO2 LPO2 totalLossO2 comma10.2;
	label LAO2="Asset loss (LAO2)" LPO2="Liability loss (LPO2)" totalLossO2 = "Total loss (LA + LP)";
quit;

ods graphics / reset imagemap noborder;

title "Distribución conjunta de las pérdidas y ganancias de los activos y pasivos";
title2 "Gráfico de dispersión";
/*
proc sgplot data=work.totalLossO2;
 	scatter x = LAO2 y = LPO2;
 	xaxis grid;
	yaxis grid;
run;
*/


title "Distribución conjunta de las pérdidas y ganancias de los activos y pasivos";
title2 "Mapa de calor";
proc sgplot data=work.totalLossO2;
 	heatmap x = LAO2 y = LPO2;
 	xaxis grid;
	yaxis grid;
run;

/* ### */
proc univariate data=work.totalLossO3 pctldef=1;
	var totalLossO3;
	output out=work.varO3 PCTLPRE=p pctlpts=0.005;
run;

title "Requerimiento de Capital por Riesgos Técnicos y Financieros de Seguros";
proc sql;
	select * into: varO3
 	from work.varO3
 	;
quit;

title "Expected Shortfall";
proc sql;
	select mean(totalLossO3) into: es
 	from work.totalLossO3
 	where totalLossO3 < &varO3.
 	;
run;

title 'Pérdida total';
title2 "Histograma";
proc sgplot data=work.totalLossO3;
 	histogram totalLossO3 / fillattrs=(color=green transparency=0.97);
 	density totalLossO3 / lineattrs=(color=red);
  	refline &varO3. / axis=x lineattrs=(color=red pattern=15) label = ("RCTyFS = &var.");
  	refline &es. / axis=x lineattrs=(color=blue pattern=15) label = ("Expected Shortfall = &es.");
 	xaxis grid;
	yaxis grid;
run;



/* Optimista3 */
proc iml; 
	Escenario={Optimista1, Optimista2, Optimista3, Base, Pesimista1, Pesimista2, Pesimista3};
	Correlacion={-0.05, 0.05, 0.15, 0.25, 0.35, 0.45, 0.55};
	print Escenario Correlacion;
	* Fixing the seed of random numbers for replicability;
	call randseed(2020);
	* Number of simulations;
	N = 100000;
	muA = 0;
	muP = 0;
	* Vector of standard deviations for assets and liabilities, respectively;
	sigma = {500 500};
	* Independent normal standard numbers for Assets (A);
	ZA = j(N,1);
	call randgen(ZA,"Normal",0,1);
	* Independent normal standard numbers for liabilities (P);
	ZP = j(N,1);
	call randgen(ZP,"Normal",0,1);
	* Mixing the two previous vectors in a matrix;
	Z = ZA||ZP;
	
/* 	Matrices de correlaciones */
	O3={1 0.15 , 0.15 1};
	
	* Choleski decomposition;
	LO3 = t(root(O3));
	
	* Correlating the independent normal standard numbers;	
	LZO3 = LO3*Z`;
	
	* Calculating the asset loss;
	LAO3 = sigma[1] * LZO3[1, ]; 
	
	* Calculating the liability loss;
	LPO3 = sigma[2] * LZO3[2, ]; 
	
	LO3 = LAO3` + LPO3`;
	
	LAPO3 = LAO3`||LPO3`||LO3;
	
	create work.totalLossO3 from LAPO3;
	append from LAPO3;
	close work.totalLossO3;
run;

proc datasets lib=work nolist nodetails;
	modify totalLossO3;
	rename col1=LAO3 col2=LPO3 col3=totalLossO3;
	format LAO3 LPO3 totalLossO3 comma10.2;
	label LAO3="Asset loss (LAO3)" LPO3="Liability loss (LPO3)" totalLossO3 = "Total loss (LA + LP)";
quit;

ods graphics / reset imagemap noborder;

title "Distribución conjunta de las pérdidas y ganancias de los activos y pasivos";
title2 "Gráfico de dispersión";
/*
proc sgplot data=work.totalLossO3;
 	scatter x = LAO3 y = LPO3;
 	xaxis grid;
	yaxis grid;
run;
*/


title "Distribución conjunta de las pérdidas y ganancias de los activos y pasivos";
title2 "Mapa de calor";
proc sgplot data=work.totalLossO3;
 	heatmap x = LAO3 y = LPO3;
 	xaxis grid;
	yaxis grid;
run;
/* ### */
proc univariate data=work.totalLossO3 pctldef=1;
	var totalLossO3;
	output out=work.varO3 PCTLPRE=p pctlpts=0.005;
run;

title "Requerimiento de Capital por Riesgos Técnicos y Financieros de Seguros";
proc sql;
	select * into: varO3
 	from work.varO3
 	;
quit;

title "Expected Shortfall";
proc sql;
	select mean(totalLossO3) into: es
 	from work.totalLossO3
 	where totalLossO3 < &varO3.
 	;
run;

title 'Pérdida total';
title2 "Histograma";
proc sgplot data=work.totalLossO3;
 	histogram totalLossO3 / fillattrs=(color=green transparency=0.97);
 	density totalLossO3 / lineattrs=(color=red);
  	refline &varO3. / axis=x lineattrs=(color=red pattern=15) label = ("RCTyFS = &var.");
  	refline &es. / axis=x lineattrs=(color=blue pattern=15) label = ("Expected Shortfall = &es.");
 	xaxis grid;
	yaxis grid;
run;


/* Base */
proc iml; 
	Escenario={Optimista1, Optimista2, Optimista3, Base, Pesimista1, Pesimista2, Pesimista3};
	Correlacion={-0.05, 0.05, 0.15, 0.25, 0.35, 0.45, 0.55};
	print Escenario Correlacion;
	* Fixing the seed of random numbers for replicability;
	call randseed(2020);
	* Number of simulations;
	N = 100000;
	muA = 0;
	muP = 0;
	* Vector of standard deviations for assets and liabilities, respectively;
	sigma = {500 500};
	* Independent normal standard numbers for Assets (A);
	ZA = j(N,1);
	call randgen(ZA,"Normal",0,1);
	* Independent normal standard numbers for liabilities (P);
	ZP = j(N,1);
	call randgen(ZP,"Normal",0,1);
	* Mixing the two previous vectors in a matrix;
	Z = ZA||ZP;
	
/* 	Matrices de correlaciones */
	B={1 0.25 , 0.25 1};
	
	* Choleski decomposition;
	LB = t(root(B));
	
	* Correlating the independent normal standard numbers;	
	LZB = LB*Z`;
	
	* Calculating the asset loss;
	LAB = sigma[1] * LZB[1, ]; 
	
	* Calculating the liability loss;
	LPB = sigma[2] * LZB[2, ]; 
	
	LB = LAB` + LPB`;
	
	LAPB = LAB`||LPB`||LB;
	
	create work.totalLossB from LAPB;
	append from LAPB;
	close work.totalLossB;
run;
proc datasets lib=work nolist nodetails;
	modify totalLossB;
	rename col1=LAB col2=LPB col3=totalLossB;
	format LAB LPB totalLossB comma10.2;
	label LAB="Asset loss (LAB)" LPB="Liability loss (LPB)" totalLossB = "Total loss (LA + LP)";
quit;

ods graphics / reset imagemap noborder;

title "Distribución conjunta de las pérdidas y ganancias de los activos y pasivos";
title2 "Gráfico de dispersión";
/*
proc sgplot data=work.totalLossB;
 	scatter x = LAB y = LPB;
 	xaxis grid;
	yaxis grid;
run;
*/


title "Distribución conjunta de las pérdidas y ganancias de los activos y pasivos";
title2 "Mapa de calor";
proc sgplot data=work.totalLossB;
 	heatmap x = LAB y = LPB;
 	xaxis grid;
	yaxis grid;
run;
/* ### */
proc univariate data=work.totalLossB pctldef=1;
	var totalLossB;
	output out=work.varB PCTLPRE=p pctlpts=0.005;
run;

title "Requerimiento de Capital por Riesgos Técnicos y Financieros de Seguros";
proc sql;
	select * into: varB
 	from work.varB
 	;
quit;

title "Expected Shortfall";
proc sql;
	select mean(totalLossB) into: es
 	from work.totalLossB
 	where totalLossB < &varB.
 	;
run;

title 'Pérdida total';
title2 "Histograma";
proc sgplot data=work.totalLossB;
 	histogram totalLossB / fillattrs=(color=green transparency=0.97);
 	density totalLossB / lineattrs=(color=red);
  	refline &varB. / axis=x lineattrs=(color=red pattern=15) label = ("RCTyFS = &var.");
  	refline &es. / axis=x lineattrs=(color=blue pattern=15) label = ("Expected Shortfall = &es.");
 	xaxis grid;
	yaxis grid;
run;


/* Pesimista 1 */
proc iml; 
	Escenario={Optimista1, Optimista2, Optimista3, Base, Pesimista1, Pesimista2, Pesimista3};
	Correlacion={-0.05, 0.05, 0.15, 0.25, 0.35, 0.45, 0.55};
	print Escenario Correlacion;
	* Fixing the seed of random numbers for replicability;
	call randseed(2020);
	* Number of simulations;
	N = 100000;
	muA = 0;
	muP = 0;
	* Vector of standard deviations for assets and liabilities, respectively;
	sigma = {500 500};
	* Independent normal standard numbers for Assets (A);
	ZA = j(N,1);
	call randgen(ZA,"Normal",0,1);
	* Independent normal standard numbers for liabilities (P);
	ZP = j(N,1);
	call randgen(ZP,"Normal",0,1);
	* Mixing the two previous vectors in a matrix;
	Z = ZA||ZP;
	
/* 	Matrices de correlaciones */
	P1={1 0.35 , 0.35 1};
	
	* Choleski decomposition;
	LP1 = t(root(P1));
	
	* Correlating the independent normal standard numbers;	
	LZP1 = LP1*Z`;
	
	* Calculating the asset loss;
	LAP1 = sigma[1] * LZP1[1, ]; 
	
	* Calculating the liability loss;
	LPP1 = sigma[2] * LZP1[2, ]; 
	
	LP1 = LAP1` + LPP1`;
	
	LAPP1 = LAP1`||LPP1`||LP1;
	
	create work.totalLossP1 from LAPP1;
	append from LAPP1;
	close work.totalLossP1;
run;
proc datasets lib=work nolist nodetails;
	modify totalLossP1;
	rename col1=LAP1 col2=LPP1 col3=totalLossP1;
	format LAP1 LPP1 totalLossP1 comma10.2;
	label LAP1="Asset loss (LAP1)" LPP1="Liability loss (LPP1)" totalLossP1 = "Total loss (LA + LP)";
quit;

ods graphics / reset imagemap noborder;

title "Distribución conjunta de las pérdidas y ganancias de los activos y pasivos";
title2 "Gráfico de dispersión";
/*
proc sgplot data=work.totalLossP1;
 	scatter x = LAP1 y = LPP1;
 	xaxis grid;
	yaxis grid;
run;
*/


title "Distribución conjunta de las pérdidas y ganancias de los activos y pasivos";
title2 "Mapa de calor";
proc sgplot data=work.totalLossP1;
 	heatmap x = LAP1 y = LPP1;
 	xaxis grid;
	yaxis grid;
run;
/* ### */
proc univariate data=work.totalLossP1 pctldef=1;
	var totalLossP1;
	output out=work.varP1 PCTLPRE=p pctlpts=0.005;
run;

title "Requerimiento de Capital por Riesgos Técnicos y Financieros de Seguros";
proc sql;
	select * into: varP1
 	from work.varP1
 	;
quit;

title "Expected Shortfall";
proc sql;
	select mean(totalLossP1) into: es
 	from work.totalLossP1
 	where totalLossP1 < &varP1.
 	;
run;

title 'Pérdida total';
title2 "Histograma";
proc sgplot data=work.totalLossP1;
 	histogram totalLossP1 / fillattrs=(color=green transparency=0.97);
 	density totalLossP1 / lineattrs=(color=red);
  	refline &varP1. / axis=x lineattrs=(color=red pattern=15) label = ("RCTyFS = &var.");
  	refline &es. / axis=x lineattrs=(color=blue pattern=15) label = ("Expected Shortfall = &es.");
 	xaxis grid;
	yaxis grid;
run;


/* Pesimista 2 */
proc iml; 
	Escenario={Optimista1, Optimista2, Optimista3, Base, Pesimista1, Pesimista2, Pesimista3};
	Correlacion={-0.05, 0.05, 0.15, 0.25, 0.35, 0.45, 0.55};
	print Escenario Correlacion;
	* Fixing the seed of random numbers for replicability;
	call randseed(2020);
	* Number of simulations;
	N = 100000;
	muA = 0;
	muP = 0;
	* Vector of standard deviations for assets and liabilities, respectively;
	sigma = {500 500};
	* Independent normal standard numbers for Assets (A);
	ZA = j(N,1);
	call randgen(ZA,"Normal",0,1);
	* Independent normal standard numbers for liabilities (P);
	ZP = j(N,1);
	call randgen(ZP,"Normal",0,1);
	* Mixing the two previous vectors in a matrix;
	Z = ZA||ZP;
	
/* 	Matrices de correlaciones */
	P2={1 0.45 , 0.45 1};
	
	* Choleski decomposition;
	LP2 = t(root(P2));
	
	* Correlating the independent normal standard numbers;	
	LZP2 = LP2*Z`;
	
	* Calculating the asset loss;
	LAP2 = sigma[1] * LZP2[1, ]; 
	
	* Calculating the liability loss;
	LPP2 = sigma[2] * LZP2[2, ]; 
	
	LP2 = LAP2` + LPP2`;
	
	LAPP2 = LAP2`||LPP2`||LP2;
	
	create work.totalLossP2 from LAPP2;
	append from LAPP2;
	close work.totalLossP2;
run;
proc datasets lib=work nolist nodetails;
	modify totalLossP2;
	rename col1=LAP2 col2=LPP2 col3=totalLossP2;
	format LAP2 LPP2 totalLossP2 comma10.2;
	label LAP2="Asset loss (LAP2)" LPP2="Liability loss (LPP2)" totalLossP2 = "Total loss (LA + LP)";
quit;

ods graphics / reset imagemap noborder;

title "Distribución conjunta de las pérdidas y ganancias de los activos y pasivos";
title2 "Gráfico de dispersión";
/*
proc sgplot data=work.totalLossP2;
 	scatter x = LAP2 y = LPP2;
 	xaxis grid;
	yaxis grid;
run;
*/


title "Distribución conjunta de las pérdidas y ganancias de los activos y pasivos";
title2 "Mapa de calor";
proc sgplot data=work.totalLossP2;
 	heatmap x = LAP2 y = LPP2;
 	xaxis grid;
	yaxis grid;
run;
/* ### */
proc univariate data=work.totalLossP2 pctldef=1;
	var totalLossP2;
	output out=work.varP2 PCTLPRE=p pctlpts=0.005;
run;

title "Requerimiento de Capital por Riesgos Técnicos y Financieros de Seguros";
proc sql;
	select * into: varP2
 	from work.varP2
 	;
quit;

title "Expected Shortfall";
proc sql;
	select mean(totalLossP2) into: es
 	from work.totalLossP2
 	where totalLossP2 < &varP2.
 	;
run;

title 'Pérdida total';
title2 "Histograma";
proc sgplot data=work.totalLossP2;
 	histogram totalLossP2 / fillattrs=(color=green transparency=0.97);
 	density totalLossP2 / lineattrs=(color=red);
  	refline &varP2. / axis=x lineattrs=(color=red pattern=15) label = ("RCTyFS = &var.");
  	refline &es. / axis=x lineattrs=(color=blue pattern=15) label = ("Expected Shortfall = &es.");
 	xaxis grid;
	yaxis grid;
run;


/* Pesimista 3 */
proc iml; 
	Escenario={Optimista1, Optimista2, Optimista3, Base, Pesimista1, Pesimista2, Pesimista3};
	Correlacion={-0.05, 0.05, 0.15, 0.25, 0.35, 0.45, 0.55};
	print Escenario Correlacion;
	* Fixing the seed of random numbers for replicability;
	call randseed(2020);
	* Number of simulations;
	N = 100000;
	muA = 0;
	muP = 0;
	* Vector of standard deviations for assets and liabilities, respectively;
	sigma = {500 500};
	* Independent normal standard numbers for Assets (A);
	ZA = j(N,1);
	call randgen(ZA,"Normal",0,1);
	* Independent normal standard numbers for liabilities (P);
	ZP = j(N,1);
	call randgen(ZP,"Normal",0,1);
	* Mixing the two previous vectors in a matrix;
	Z = ZA||ZP;
	
/* 	Matrices de correlaciones */
	P3={1 0.55 , 0.55 1};
	
	* Choleski decomposition;
	LP3 = t(root(P3));
	
	* Correlating the independent normal standard numbers;	
	LZP3 = LP3*Z`;
	
	* Calculating the asset loss;
	LAP3 = sigma[1] * LZP3[1, ]; 
	
	* Calculating the liability loss;
	LPP3 = sigma[2] * LZP3[2, ]; 
	
	LP3 = LAP3` + LPP3`;
	
	LAPP3 = LAP3`||LPP3`||LP3;
	
	create work.totalLossP3 from LAPP3;
	append from LAPP3;
	close work.totalLossP3;
run;

proc datasets lib=work nolist nodetails;
	modify totalLossP3;
	rename col1=LAP3 col2=LPP3 col3=totalLossP3;
	format LAP3 LPP3 totalLossP3 comma10.2;
	label LAP3="Asset loss (LAP3)" LPP3="Liability loss (LPP3)" totalLossP3 = "Total loss (LA + LP)";
quit;

ods graphics / reset imagemap noborder;

title "Distribución conjunta de las pérdidas y ganancias de los activos y pasivos";
title2 "Gráfico de dispersión";
/*
proc sgplot data=work.totalLossP3;
 	scatter x = LAP3 y = LPP3;
 	xaxis grid;
	yaxis grid;
run;
*/


title "Distribución conjunta de las pérdidas y ganancias de los activos y pasivos";
title2 "Mapa de calor";
proc sgplot data=work.totalLossP3;
 	heatmap x = LAP3 y = LPP3;
 	xaxis grid;
	yaxis grid;
run;
/* ### */
proc univariate data=work.totalLossP3 pctldef=1;
	var totalLossP3;
	output out=work.varP3 PCTLPRE=p pctlpts=0.005;
run;

title "Requerimiento de Capital por Riesgos Técnicos y Financieros de Seguros";
proc sql;
	select * into: varP3
 	from work.varP3
 	;
quit;

title "Expected Shortfall";
proc sql;
	select mean(totalLossP3) into: es
 	from work.totalLossP3
 	where totalLossP3 < &varP3.
 	;
run;

title 'Pérdida total';
title2 "Histograma";
proc sgplot data=work.totalLossP3;
 	histogram totalLossP3 / fillattrs=(color=green transparency=0.97);
 	density totalLossP3 / lineattrs=(color=red);
  	refline &varP3. / axis=x lineattrs=(color=red pattern=15) label = ("RCTyFS = &var.");
  	refline &es. / axis=x lineattrs=(color=blue pattern=15) label = ("Expected Shortfall = &es.");
 	xaxis grid;
	yaxis grid;
run;

