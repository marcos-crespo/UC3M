
libname ROutput 'F:\USEC\USEC3\A_MICRODATOS_Carmen\0_EES_2018_cuatrienal\2Proceso\22 SAS';
options fmtsearch = (ROutput ROutput.cat1);

* 2) DEFINICI�N DE FORMATOS;
PROC FORMAT LIBRARY=ROutput.cat1;
value $TNUTS

"1"="NOROESTE"
"2"="NORESTE"
"3"="COMUNIDAD DE MADRID"
"4"="CENTRO"
"5"="ESTE"
"6"="SUR"
"7"="CANARIAS"
;
value $TTrabaj

"0"="INCLUYE TODOS LOS ESTRATOS"
"1"="DE 1 A 49 TRABAJADORES"
"2"="DE 50 A 199 TRABAJADORES"
"3"="200 Y M�S TRABAJADORES"
"4"="INCLUYE ESTRATO 2 Y 3"
;
value $TContro

"1"="PUBLICO"
"2"="PRIVADO"
;
value $TMercad

"1"="LOCAL O REGIONAL"
"2"="NACIONAL"
"3"="UNI�N EUROPEA"
"4"="MUNDIAL"
;
value $TRegula

"1"="ESTATAL SECTORIAL"
"2"="SECTORIAL DE AMBITO INFERIOR (AUTON�MICO, PROVINCIAL, COMARCAL...)"
"3"="DE EMPRESA O GRUPO DE EMPRESAS"
"4"="DE CENTRO DE TRABAJO"
"5"="OTRA FORMA DE REGULACI�N"
;
value $TSexo

"1"="HOMBRE"
"6"="MUJER"
;
value $TPais

"1"="ESPA�A"
"2"="RESTO MUNDO"
;
value $TJornad

"1"="TIEMPO COMPLETO"
"2"="TIEMPO PARCIAL"
;
value $TContra

"1"="DURACION INDEFINIDA"
"2"="DURACION DETERMINADA"
;
value $TSino

"1"="S�"
"6"="No"
;
value $TEdad

"01"="MENOS 19 A�OS"
"02"="DE 20 A 29"
"03"="DE 30 A 39"
"04"="DE 40 A 49"
"05"="DE 50 A 59"
"06"="M�S DE 59"
;
value $T1Sino

"1"="S�"
"0"="No"
;
value $TCNAE

"B0"="Industrias extractivas: extracci�n de antracita, hulla y lignito, extracci�n de crudo de petr�leo y gas natural, extracci�n de minerales met�licos, otras industrias extractivas, actividades de apoyo a las industrias extractivas"
"C1"="Industria manufacturera: industria de la alimentaci�n, fabricaci�n de bebidas, industria del tabaco, industria textil, confecci�n de prendas de vestir, industria del cuero y del calzado"
"C2"="Industria manufacturera: industria de la madera y del corcho, excepto muebles; cester�a y esparter�a, industria del papel"
"C3"="Industria manufacturera: artes gr�ficas y reproducci�n de soportes grabados"
"C4"="Industria manufacturera: coquer�as y refino de petr�leo, industria qu�mica, fabricaci�n de productos farmac�uticos, fabricaci�n de productos de caucho y pl�sticos"
"C5"="Industria manufacturera: fabricaci�n de otros productos minerales no met�licos"
"C6"="Industria manufacturera: metalurgia; fabricaci�n de productos de hierro, acero y ferroaleaciones, fabricaci�n de productos met�licos, excepto maquinaria y equipo"
"C7"="Industria manufacturera: fabricaci�n de productos inform�ticos, electr�nicos y �pticos, fabricaci�n de material y equipo el�ctrico, fabricaci�n de maquinaria y equipo no contemplado en otras partes"
"C8"="Industria manufacturera: fabricaci�n de veh�culos de motor, remolques y semirremolques, fabricaci�n de otro material de transporte, fabricaci�n de muebles, otras industrias manufactureras, reparaci�n e instalaci�n de maquinaria y equipo"
"D0"="Suministro de energ�a el�ctrica, gas, vapor y aire acondicionado"
"E0"="Suministro de agua, actividades de saneamiento, gesti�n de residuos y descontaminaci�n: captaci�n, depuraci�n y distribuci�n de agua, recogida y tratamiento de aguas residuales, recogida, tratamiento y eliminaci�n de residuos; valorizaci�n, actividades de descontaminaci�n y otros servicios de gesti�n de residuos"
"F0"="Construcci�n: construcci�n de edificios, ingenier�a civil, actividades de construcci�n especializada"
"G1"="Comercio al por mayor y al por menor; reparaci�n de veh�culos de motor y motocicletas: venta y reparaci�n de veh�culos de motor y motocicletas, comercio al por mayor e intermediarios del comercio, excepto de veh�culos de motor y motocicletas"
"G2"="Comercio al por mayor y al por menor; reparaci�n de veh�culos de motor y motocicletas: comercio al por menor, excepto de veh�culos de motor y motocicletas"
"H1"="Transporte y almacenamiento: transporte terrestre y por tuber�a, transporte mar�timo y por v�as navegables interiores, transporte a�reo"
"H2"="Transporte y almacenamiento: almacenamiento y actividades anexas al transporte, actividades postales y de correos"
"I0"="Hosteler�a: servicios de alojamiento, servicios de comidas y bebidas"
"J0"="Informaci�n y comunicaciones: edici�n, actividades cinematogr�ficas, de v�deo y de programas de televisi�n, grabaci�n de sonido y edici�n musical, actividades de programaci�n y emisi�n de radio y televisi�n, telecomunicaciones, programaci�n, consultor�a y otras actividades relacionadas con la inform�tica, servicios de informaci�n"
"K0"="Actividades financieras y de seguros: servicios financieros, excepto seguros y fondos de pensiones, seguros, reaseguros y fondos de pensiones, excepto seguridad social obligatoria, actividades auxiliares a los servicios financieros y a los seguros"
"L0"="Actividades inmobiliarias"
"M0"="Actividades profesionales, cient�ficas y t�cnicas: actividades jur�dicas y de contabilidad, actividades de las sedes centrales; actividades de consultor�a de gesti�n empresarial, servicios t�cnicos de arquitectura e ingenier�a; ensayos y an�lisis t�cnicos, investigaci�n y desarrollo, publicidad y estudios de mercado, otras actividades profesionales, cient�ficas y t�cnicas, actividades veterinarias"
"N0"="Actividades administrativas y servicios auxliares: actividades de alquiler, actividades relacionadas con el empleo, actividades de agencias de viajes, operadores tur�sticos, servicios de reservas y actividades relacionadas con los mismos, actividades de seguridad e investigaci�n, servicios a edificios y actividades de jardiner�a, actividades administrativas de oficina y otras actividades auxiliares a las empresas"
"O0"="Administraci�n P�blica y defensa; Seguridad Social obligatoria"
"P0"="Educaci�n"
"Q0"="Actividades sanitarias y de servicios sociales: actividades sanitarias, asistencia en establecimientos residenciales, actividades de servicios sociales sin alojamiento"
"R0"="Actividades art�sticas, recreativas y de entrenimiento: actividades de creaci�n, art�sticas y espect�culos, actividades de bibliotecas, archivos, museos y otras actividades culturales, actividades de juegos de azar y apuestas, actividades deportivas, recreativas y de entretenimiento"
"S0"="Otros servicios: actividades asociativas, reparaci�n de ordenadores, efectos personales y art�culos de uso dom�stico, otros servicios personales"
;
value $TTitula

"1"="Menos que primaria"
"2"="Educaci�n primaria"
"3"="Primera etapa de educaci�n secundaria"
"4"="Segunda etapa de eduaci�n secundaria"
"5"="Ense�anzas de formaci�n profesional de grado superior y similares"
"6"="Diplomados universitarios y similares"
"7"="Licenciados y similares, y doctores universitarios"
;
value $TCNO

"A0"="DIRECTORES Y GERENTES"
"B0"="T�CNICOS Y PROFESIONALES CIENT�FICOS E INTELECTUALES DE LA SALUD Y LA ENSE�ANZA"
"C0"="OTROS T�CNICOS Y PROFESIONALES CIENT�FICOS E INTELECTUALES"
"D0"="T�CNICOS; PROFESIONALES DE APOYO"
"E0"="EMPLEADOS DE OFICINA QUE NO ATIENDEN AL P�BLICO"
"F0"="EMPLEADOS DE OFICINA QUE ATIENDEN AL P�BLICO"
"G0"="TRABAJADORES DE LOS SERVICIOS DE RESTAURACION Y COMERCIO"
"H0"="TRABAJADORES DE LOS SERVICIOS DE SALUD Y EL CUIDADO DE PERSONAS"
"I0"="TRABAJADORES DE LOS SERVICOS DE PROTECCION Y SEGURIDAD"
"J0"="TRABAJADORES CUALIFICADOS EN EL SECTOR AGR�COLA, GANADERO, FORESTAL Y PESQUERO"
"K0"="TRABAJADORES CUALIFICADOS DE LA CONSTRUCCION, EXCEPTO LOS OPERADORES DE M�QUINAS"
"L0"="TRABAJADORES CUALIFICADOS DE LAS INDUSTRIAS MANUFACTURERAS, EXCEPTO OPERADORES DE INSTALACIONES Y M�QUINAS"
"M0"="OPERADORES DE INSTALACIONES Y MAQUINARIA FIJAS, Y MONTADORES"
"N0"="CONDUCTORES Y OPERADORES DE MAQUINARIA MOVIL"
"O0"="TRABAJADORES NO CUALIFICADOS EN SERVICIOS"
"P0"="PEONES DE LA AGRICULTURA, PESCA, CONSTRUCCI�N, INDUSTRIAS MANUFACTURERAS Y TRANSPORTES"
"Q0"="OCUPACIONES MILITARES"
;


* 3) VINCULAR FORMATOS A LA BASE DE DATOS;
data ROutput.EES_2018_ConFormato;
	set ROutput.EES_2018;


FORMAT NUTS1 $TNUTS.;
FORMAT CNACE $TCNAE.;
FORMAT ESTRATO2 $TTrabaj.;
FORMAT CONTROL $TContro.;
FORMAT MERCADO $TMercad.;
FORMAT REGULACION $TRegula.;
FORMAT SEXO $TSexo.;
FORMAT TIPOPAIS $TPais.;
FORMAT CNO1 $TCNO.;
FORMAT RESPONSA $T1Sino.;
FORMAT ESTU $TTitula.;
FORMAT TIPOJOR $TJornad.;
FORMAT TIPOCON $TContra.;
FORMAT SIESPM1 $TSino.;
FORMAT SIESPM2 $TSino.;
FORMAT SIESPA1 $TSino.;
FORMAT SIESPA2 $TSino.;
FORMAT SIESPA3 $TSino.;
FORMAT SIESPA4 $TSino.;
FORMAT ANOS2 $TEdad.;



RUN;
/* FIN PROGRAMA: Microdatos en SAS: EES_2018.sas*/
