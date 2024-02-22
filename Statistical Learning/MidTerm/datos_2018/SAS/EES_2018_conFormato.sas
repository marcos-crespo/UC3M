
libname ROutput 'F:\USEC\USEC3\A_MICRODATOS_Carmen\0_EES_2018_cuatrienal\2Proceso\22 SAS';
options fmtsearch = (ROutput ROutput.cat1);

* 2) DEFINICIÓN DE FORMATOS;
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
"3"="200 Y MÁS TRABAJADORES"
"4"="INCLUYE ESTRATO 2 Y 3"
;
value $TContro

"1"="PUBLICO"
"2"="PRIVADO"
;
value $TMercad

"1"="LOCAL O REGIONAL"
"2"="NACIONAL"
"3"="UNIÓN EUROPEA"
"4"="MUNDIAL"
;
value $TRegula

"1"="ESTATAL SECTORIAL"
"2"="SECTORIAL DE AMBITO INFERIOR (AUTONÓMICO, PROVINCIAL, COMARCAL...)"
"3"="DE EMPRESA O GRUPO DE EMPRESAS"
"4"="DE CENTRO DE TRABAJO"
"5"="OTRA FORMA DE REGULACIÓN"
;
value $TSexo

"1"="HOMBRE"
"6"="MUJER"
;
value $TPais

"1"="ESPAÑA"
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

"1"="Sí"
"6"="No"
;
value $TEdad

"01"="MENOS 19 AÑOS"
"02"="DE 20 A 29"
"03"="DE 30 A 39"
"04"="DE 40 A 49"
"05"="DE 50 A 59"
"06"="MÁS DE 59"
;
value $T1Sino

"1"="Sí"
"0"="No"
;
value $TCNAE

"B0"="Industrias extractivas: extracción de antracita, hulla y lignito, extracción de crudo de petróleo y gas natural, extracción de minerales metálicos, otras industrias extractivas, actividades de apoyo a las industrias extractivas"
"C1"="Industria manufacturera: industria de la alimentación, fabricación de bebidas, industria del tabaco, industria textil, confección de prendas de vestir, industria del cuero y del calzado"
"C2"="Industria manufacturera: industria de la madera y del corcho, excepto muebles; cestería y espartería, industria del papel"
"C3"="Industria manufacturera: artes gráficas y reproducción de soportes grabados"
"C4"="Industria manufacturera: coquerías y refino de petróleo, industria química, fabricación de productos farmacéuticos, fabricación de productos de caucho y plásticos"
"C5"="Industria manufacturera: fabricación de otros productos minerales no metálicos"
"C6"="Industria manufacturera: metalurgia; fabricación de productos de hierro, acero y ferroaleaciones, fabricación de productos metálicos, excepto maquinaria y equipo"
"C7"="Industria manufacturera: fabricación de productos informáticos, electrónicos y ópticos, fabricación de material y equipo eléctrico, fabricación de maquinaria y equipo no contemplado en otras partes"
"C8"="Industria manufacturera: fabricación de vehículos de motor, remolques y semirremolques, fabricación de otro material de transporte, fabricación de muebles, otras industrias manufactureras, reparación e instalación de maquinaria y equipo"
"D0"="Suministro de energía eléctrica, gas, vapor y aire acondicionado"
"E0"="Suministro de agua, actividades de saneamiento, gestión de residuos y descontaminación: captación, depuración y distribución de agua, recogida y tratamiento de aguas residuales, recogida, tratamiento y eliminación de residuos; valorización, actividades de descontaminación y otros servicios de gestión de residuos"
"F0"="Construcción: construcción de edificios, ingeniería civil, actividades de construcción especializada"
"G1"="Comercio al por mayor y al por menor; reparación de vehículos de motor y motocicletas: venta y reparación de vehículos de motor y motocicletas, comercio al por mayor e intermediarios del comercio, excepto de vehículos de motor y motocicletas"
"G2"="Comercio al por mayor y al por menor; reparación de vehículos de motor y motocicletas: comercio al por menor, excepto de vehículos de motor y motocicletas"
"H1"="Transporte y almacenamiento: transporte terrestre y por tubería, transporte marítimo y por vías navegables interiores, transporte aéreo"
"H2"="Transporte y almacenamiento: almacenamiento y actividades anexas al transporte, actividades postales y de correos"
"I0"="Hostelería: servicios de alojamiento, servicios de comidas y bebidas"
"J0"="Información y comunicaciones: edición, actividades cinematográficas, de vídeo y de programas de televisión, grabación de sonido y edición musical, actividades de programación y emisión de radio y televisión, telecomunicaciones, programación, consultoría y otras actividades relacionadas con la informática, servicios de información"
"K0"="Actividades financieras y de seguros: servicios financieros, excepto seguros y fondos de pensiones, seguros, reaseguros y fondos de pensiones, excepto seguridad social obligatoria, actividades auxiliares a los servicios financieros y a los seguros"
"L0"="Actividades inmobiliarias"
"M0"="Actividades profesionales, científicas y técnicas: actividades jurídicas y de contabilidad, actividades de las sedes centrales; actividades de consultoría de gestión empresarial, servicios técnicos de arquitectura e ingeniería; ensayos y análisis técnicos, investigación y desarrollo, publicidad y estudios de mercado, otras actividades profesionales, científicas y técnicas, actividades veterinarias"
"N0"="Actividades administrativas y servicios auxliares: actividades de alquiler, actividades relacionadas con el empleo, actividades de agencias de viajes, operadores turísticos, servicios de reservas y actividades relacionadas con los mismos, actividades de seguridad e investigación, servicios a edificios y actividades de jardinería, actividades administrativas de oficina y otras actividades auxiliares a las empresas"
"O0"="Administración Pública y defensa; Seguridad Social obligatoria"
"P0"="Educación"
"Q0"="Actividades sanitarias y de servicios sociales: actividades sanitarias, asistencia en establecimientos residenciales, actividades de servicios sociales sin alojamiento"
"R0"="Actividades artísticas, recreativas y de entrenimiento: actividades de creación, artísticas y espectáculos, actividades de bibliotecas, archivos, museos y otras actividades culturales, actividades de juegos de azar y apuestas, actividades deportivas, recreativas y de entretenimiento"
"S0"="Otros servicios: actividades asociativas, reparación de ordenadores, efectos personales y artículos de uso doméstico, otros servicios personales"
;
value $TTitula

"1"="Menos que primaria"
"2"="Educación primaria"
"3"="Primera etapa de educación secundaria"
"4"="Segunda etapa de eduación secundaria"
"5"="Enseñanzas de formación profesional de grado superior y similares"
"6"="Diplomados universitarios y similares"
"7"="Licenciados y similares, y doctores universitarios"
;
value $TCNO

"A0"="DIRECTORES Y GERENTES"
"B0"="TÉCNICOS Y PROFESIONALES CIENTÍFICOS E INTELECTUALES DE LA SALUD Y LA ENSEÑANZA"
"C0"="OTROS TÉCNICOS Y PROFESIONALES CIENTÍFICOS E INTELECTUALES"
"D0"="TÉCNICOS; PROFESIONALES DE APOYO"
"E0"="EMPLEADOS DE OFICINA QUE NO ATIENDEN AL PÚBLICO"
"F0"="EMPLEADOS DE OFICINA QUE ATIENDEN AL PÚBLICO"
"G0"="TRABAJADORES DE LOS SERVICIOS DE RESTAURACION Y COMERCIO"
"H0"="TRABAJADORES DE LOS SERVICIOS DE SALUD Y EL CUIDADO DE PERSONAS"
"I0"="TRABAJADORES DE LOS SERVICOS DE PROTECCION Y SEGURIDAD"
"J0"="TRABAJADORES CUALIFICADOS EN EL SECTOR AGRÍCOLA, GANADERO, FORESTAL Y PESQUERO"
"K0"="TRABAJADORES CUALIFICADOS DE LA CONSTRUCCION, EXCEPTO LOS OPERADORES DE MÁQUINAS"
"L0"="TRABAJADORES CUALIFICADOS DE LAS INDUSTRIAS MANUFACTURERAS, EXCEPTO OPERADORES DE INSTALACIONES Y MÁQUINAS"
"M0"="OPERADORES DE INSTALACIONES Y MAQUINARIA FIJAS, Y MONTADORES"
"N0"="CONDUCTORES Y OPERADORES DE MAQUINARIA MOVIL"
"O0"="TRABAJADORES NO CUALIFICADOS EN SERVICIOS"
"P0"="PEONES DE LA AGRICULTURA, PESCA, CONSTRUCCIÓN, INDUSTRIAS MANUFACTURERAS Y TRANSPORTES"
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
