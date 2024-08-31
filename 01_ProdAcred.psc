
// FUNCIONES Y SUBPROCESOS DEFINIDOS MANUALMENTE

Funcion valorVerificado <- IngresarEnteroValido(limInf,limSup)
	// FUNCION PARA LEER ENTEROS QUE NECESARIAMENTE DEBEN ESTAR EN UN INTERVALO
	Definir valorIngresado Como Entero
	Leer valorIngresado
	Mientras (valorIngresado<limInf o valorIngresado>limSup) Hacer
		Escribir "Ingrese un valor entero válido, del ",limInf," al ",limSup,":"
		Leer valorIngresado
	FinMientras
	valorVerificado <- valorIngresado
FinFuncion

SubProceso TeclaContinuar
	// PIDE PRESIONAR UNA TECLA ANTES DE CONTINUAR
	// PARA PODER LEER LA INFORMACIÓN EN PANTALLA
	Escribir "Presione cualquier tecla para para continuar."
	Esperar Tecla
FinSubProceso

SubProceso ImprimirDiasSemana
	// IMPRIME DÍAS DE SEMANA CON CLASES
	Escribir "1. Lunes        4. Jueves"
	Escribir "2. Martes       5. Viernes"
	Escribir "3. Miércoles    6. Sábado"
FinSubProceso

SubProceso ImprimirBloquesHorarios
	// IMPRIME BLOQUES HORARIOS PARA CLASES PREDEFINIDOS
	Escribir "1. 07:30-09:10    5. 14:10-15:50"
	Escribir "2. 09:10-10:50    6. 15:50-17:30"
	Escribir "3. 10:50-12:30    7. 17:30-19:10"
	Escribir "4. 12:30-14:10    8. 19:10-20:50"
FinSubProceso



// ALGORITMO PRINCIPAL
Algoritmo ProdAcred
	
	//     DEFINICIONES BASE
	Definir cantAlum, cantCursosReg, cantCursosPorCiclo, maxBloqHorarCurso, maxCursosPorAlum, cantCiclos, cantCarreras Como Entero
	cantAlum <- 9  // Cantidad inicial de alumnos
	cantCursosReg <- 24  // Cantidad inicial de cursos en total
	cantCursosPorCiclo <- 10  // Cada ciclo tiene espacios hasta 10 cursos
	maxBloqHorarCurso <- 4  // Cada curso tiene hasta 4 bloques de 2h c/u
	maxCursosPorAlum <- 8  // Cada alumno puede matricularse en hasta 8 cursps
	cantCiclos <- 10
	cantCarreras <- 3
	
	
	//     "BASES DE DATOS" DE Alumnos
	// El ID interno de cada alumno será su posición en la 1ra dimensión 
	// del arreglo, asignado de acuerdo al orden en que es agregado.
	// El ID interno será usado para las operaciones del programa.
	Definir datAlumCar Como Caracter // Datos de Alumnos (caracter)
	Definir datAlumEnt Como Entero   // Datos de Alumnos (entero)
	Definir datAlumHor Como Logico   // Datos de horario de Alumnos
	Dimension datAlumCar[cantAlum,2]
	// Los 2 espacios corresponden a CODIGO, NOMBRE
	Dimension datAlumEnt[cantAlum,5]
	// Los 5 espacios corresponden a CARRERA (ID interno), CICLO, ESTADO DE BECA, ESTADO DE PAGO, ESTADO DE MATRÍCULA
	// ESTADO DE BECA:
	//    0: Sin beca
	//    1: Media beca
	//    2: Beca completa
	// ESTADO DE PAGO:
	//    0: No pagó
	//    1: Ya pagó (y puede matricularse)
	// ESTADO DE MATRÍCULA
	//    0: No matriculado
	//    1: Ya matriculado
	Dimension datAlumHor[cantAlum,6,8]
	// Arreglo de booleanos lógicos (0 o 1) donde:
	// 0 = Espacio vacío sin clases
	// 1 = Espacio lleno con clases
	// La 2da dimensión es el Día de la semana (1-6)
	// La 3ra dimensión es el Bloque horario (1-8)
	//   °ID interno    Lun  Mar  Mie  Jue  Vie  Sab
	//  07:30 - 09:10    1    2    3    4    5    6
	//  09:10 - 10:50    2
	//  10:50 - 12:30    3
	//  12:30 - 14:10    4
	//  14:10 - 15:50    5
	//  15:50 - 17:30    6
	//  17:30 - 19:10    7
	//  19:10 - 20:50    8
	Definir nombreDiaSem, nombreBloqHorar Como Caracter
	Dimension nombreDiaSem[6]
	Dimension nombreBloqHorar[8]
	
	
	//     "BASE DE DATOS" DE CARRERA
	// El ID interno de cada carrera será su posición en la 1ra dimensión
	Definir nombreCarrera Como Caracter
	Definir cantAlumCarrera Como Entero
	Dimension nombreCarrera[cantCarreras]
	Dimension cantAlumCarrera[cantCarreras]

	
	
	//     "BASE DE DATOS" DE CURSOS
	// Los cursos se dividen por carrera, ciclo, y lugar dentro de cada ciclo.
	Definir datCursCar Como Caracter
	Definir datCursEnt, datCursHor Como Entero
	Dimension datCursCar[cantCarreras,cantCiclos,cantCursosPorCiclo,3]
	// 4ta dimensión: CODIGO (ABCD-1001), NOMBRE, CÓDIGO PREREQUISITO (ABCD-1001)
	Dimension datCursEnt[cantCarreras,cantCiclos,cantCursosPorCiclo,3]
	// 4ta dimensión: CRÉDITOS, CUPOS ACTUALES, CUPOS MÁXIMOS
	Dimension datCursHor[cantCarreras,cantCiclos,cantCursosPorCiclo,maxBloqHorarCurso,2]
	// 4ta dimension: cada una de los 4 bloques horarios máximo de cada curso (maxBloqHorarCurso=4).
	// 5ta dimension: DÍA, BLOQUE HORARIO.
	
	
	//     REGISTRO DE CURSOS POR alumno	
	Definir datAlumCurs Como Entero
	Dimension datAlumCurs[cantAlum,maxCursosPorAlum,2]
	// Arreglo de IDs de los cursos registrados para cada alumno
	// 2da dimensión: Cada uno de los 8 (maxCursosPorAlum) cursos como máximo matriculables
	// 3ra dimensión: CICLO DEL CURSO, LUGAR EN EL CICLO DEL CURSO
	
	
	//     INICIALIZACIÓN DE INFORMACIÓN PREDEFINIDA
	nombreCarrera[1] <- "Ingeniería Civil"       // ID interno: 1
	nombreCarrera[2] <- "Ingeniería de Sistemas" // ID interno: 2
	nombreCarrera[3] <- "Arquitectura"           // ID interno: 3
	cantAlumCarrera[1] <- 3
	cantAlumCarrera[2] <- 3
	cantAlumCarrera[3] <- 3
	nombreDiaSem[1] <- "Lunes"
	nombreDiaSem[2] <- "Martes"
	nombreDiaSem[3] <- "Miércoles"
	nombreDiaSem[4] <- "Jueves"
	nombreDiaSem[5] <- "Viernes"
	nombreDiaSem[6] <- "Sábado"
	nombreBloqHorar[1] <- "07:30-09:10"
	nombreBloqHorar[2] <- "09:10-10:50"
	nombreBloqHorar[3] <- "10:50-12:30"
	nombreBloqHorar[4] <- "12:30-14:10"
	nombreBloqHorar[5] <- "14:10-15:50"
	nombreBloqHorar[6] <- "15:50-17:30"
	nombreBloqHorar[7] <- "17:30-19:10"
	nombreBloqHorar[8] <- "19:10-20:50"
	// Alumnos (ID 1 a 9)
		datAlumCar[1,1] <- "231639H"  // Codigo
		datAlumCar[1,2] <- "PISCOYA ENCAJIMA JOSE ALONSO"
		datAlumEnt[1,1] <- 2  // Sistemas
		datAlumEnt[1,2] <- 4  // Ciclo
		datAlumEnt[1,3] <- 2  // Beca completa
		datAlumCar[2,1] <- "231645H"  // Codigo
		datAlumCar[2,2] <- "VILLEGAS CUENCA JOSE MANUEL"
		datAlumEnt[2,1] <- 2  // Sistemas
		datAlumEnt[2,2] <- 4  // Ciclo
		datAlumEnt[2,3] <- 1  // Media beca
		datAlumCar[3,1] <- "231625G"  // Codigo
		datAlumCar[3,2] <- "CAUCHOS LABAN NELSON ANIBAL"
		datAlumEnt[3,1] <- 2  // Sistemas
		datAlumEnt[3,2] <- 4  // Ciclo
		datAlumEnt[3,3] <- 1  // Media beca
		datAlumCar[4,1] <- "231624K"  // Codigo
		datAlumCar[4,2] <- "CASTRO MENDOZA JHORDY FABRICIO"
		datAlumEnt[4,1] <- 1  // Civil
		datAlumEnt[4,2] <- 3  // Ciclo
		datAlumEnt[4,3] <- 2  // Beca completa
		datAlumCar[5,1] <- "231620E"  // Codigo
		datAlumCar[5,2] <- "BARRERA ALVARADO HENRY CRISTIAN"
		datAlumEnt[5,1] <- 1  // Civil
		datAlumEnt[5,2] <- 3  // Ciclo
		datAlumEnt[5,3] <- 1  // Media beca
		datAlumCar[6,1] <- "231640F"  // Codigo
		datAlumCar[6,2] <- "QUISPE CABEZAS JUAN DE DIOS"
		datAlumEnt[6,1] <- 1  // Civil
		datAlumEnt[6,2] <- 2  // Ciclo
		datAlumEnt[6,3] <- 0  // Sin beca
		datAlumCar[7,1] <- "231638A"  // Codigo
		datAlumCar[7,2] <- "PAREDES AGUINAGA JOSUE SAMUEL"
		datAlumEnt[7,1] <- 3  // Arquitectura
		datAlumEnt[7,2] <- 2  // Ciclo
		datAlumEnt[7,3] <- 2  // Beca completa
		datAlumCar[8,1] <- "231631G"  // Codigo
		datAlumCar[8,2] <- "LOZANO PAZ ABIMA GALILEY"
		datAlumEnt[8,1] <- 3  // Arquitectura
		datAlumEnt[8,2] <- 1  // Ciclo
		datAlumEnt[8,3] <- 0  // Sin becas
		datAlumCar[9,1] <- "231636I"  // Codigo
		datAlumCar[9,2] <- "NUÑEZ RUBIO MAICOL JHORDY"
		datAlumEnt[9,1] <- 3  // Arquitectura
		datAlumEnt[9,2] <- 1  // Ciclo
		datAlumEnt[9,3] <- 0  // Sin becas
	// CARRERAS ING. CIVIL (ID 1)
		// Ciclo 1
			datCursCar[1,1,1,1] <- "MATC1001" // Código de curso 1
			datCursCar[1,1,1,2] <- "Fundamentos matemáticos"
			datCursCar[1,1,1,3] <- "0"    // Sin prerrequisito
			datCursEnt[1,1,1,1] <- 4    // Créditos
			datCursEnt[1,1,1,2] <- 0    // Cupos actuales
			datCursEnt[1,1,1,3] <- 35    // Cupos máximos
			datCursHor[1,1,1,1,1] <- 1 // Hora 1 Lunes
			datCursHor[1,1,1,1,2] <- 1 // Hora 1 07:30-09:10
			datCursHor[1,1,1,2,1] <- 2 // Hora 2 Martes
			datCursHor[1,1,1,2,2] <- 1 // Hora 2 07:30-09:10
			datCursCar[1,1,2,1] <- "MATC1002" // Código de curso 2
			datCursCar[1,1,2,2] <- "Geometría descriptiva"
			datCursCar[1,1,2,3] <- "0"    // Sin prerrequisito
			datCursEnt[1,1,2,1] <- 3    // Créditos
			datCursEnt[1,1,2,2] <- 0    // Cupos actuales
			datCursEnt[1,1,2,3] <- 40    // Cupos máximos
			datCursHor[1,1,2,1,1] <- 1 // Hora 1 Lunes
			datCursHor[1,1,2,1,2] <- 2 // Hora 1 09:10-10:50
			datCursHor[1,1,2,2,1] <- 2 // Hora 2 Martes
			datCursHor[1,1,2,2,2] <- 2 // Hora 2 09:10-10:50
		// Ciclo 2
			datCursCar[1,2,1,1] <- "CALC1011" // Código de curso 1
			datCursCar[1,2,1,2] <- "Cálculo Diferencial"
			datCursCar[1,2,1,3] <- "MATC1001" // Prerrequisito
			datCursEnt[1,2,1,1] <- 5    // Créditos
			datCursEnt[1,2,1,2] <- 0    // Cupos actuales
			datCursEnt[1,2,1,3] <- 30    // Cupos máximos
			datCursHor[1,2,1,1,1] <- 1 // Hora 1 Lunes
			datCursHor[1,2,1,1,2] <- 1 // Hora 1 07:30-09:10
			datCursHor[1,2,1,2,1] <- 2 // Hora 2 Martes
			datCursHor[1,2,1,2,2] <- 1 // Hora 2 07:30-09:10
			datCursCar[1,2,2,1] <- "ALIN1101" // Código de curso 2
			datCursCar[1,2,2,2] <- "Álgebra Lineal 1"
			datCursCar[1,2,2,3] <- "MATC1002" // Prerrequisito
			datCursEnt[1,2,2,1] <- 4    // Créditos
			datCursEnt[1,2,2,2] <- 0    // Cupos actuales
			datCursEnt[1,2,2,3] <- 30    // Cupos máximos
			datCursHor[1,2,2,1,1] <- 1 // Hora 1 Lunes
			datCursHor[1,2,2,1,2] <- 2 // Hora 1 09:10-10:50
			datCursHor[1,2,2,2,1] <- 2 // Hora 2 Martes
			datCursHor[1,2,2,2,2] <- 2 // Hora 2 09:10-10:50
		// Ciclo 3
			datCursCar[1,3,1,1] <- "CALC1012" // Código de curso 1
			datCursCar[1,3,1,2] <- "Cálculo Integral"
			datCursCar[1,3,1,3] <- "CALC1011"    // Prerrequisito
			datCursEnt[1,3,1,1] <- 4    // Créditos
			datCursEnt[1,3,1,2] <- 0    // Cupos actuales
			datCursEnt[1,3,1,3] <- 30    // Cupos máximos
			datCursHor[1,3,1,1,1] <- 1 // Hora 1 Lunes
			datCursHor[1,3,1,1,2] <- 1 // Hora 1 07:30-09:10
			datCursHor[1,3,1,2,1] <- 2 // Hora 2 Martes
			datCursHor[1,3,1,2,2] <- 1 // Hora 2 07:30-09:10
			datCursCar[1,3,2,1] <- "ALIN1102" // Código de curso 2
			datCursCar[1,3,2,2] <- "Álgebra Lineal 2"
			datCursCar[1,3,2,3] <- "ALIN1101"    // Prerrequisito
			datCursEnt[1,3,2,1] <- 3    // Créditos
			datCursEnt[1,3,2,2] <- 0    // Cupos actuales
			datCursEnt[1,3,2,3] <- 25    // Cupos máximos
			datCursHor[1,3,2,1,1] <- 1 // Hora 1 Lunes
			datCursHor[1,3,2,1,2] <- 2 // Hora 1 09:10-10:50
			datCursHor[1,3,2,2,1] <- 2 // Hora 2 Martes
			datCursHor[1,3,2,2,2] <- 2 // Hora 2 09:10-10:50
		// Ciclo 4
			datCursCar[1,4,1,1] <- "MATE4011" // Código de curso 1
			datCursCar[1,4,1,2] <- "Análisis Real Avanzado"
			datCursCar[1,4,1,3] <- "CALC1012" // Prerrequisito
			datCursEnt[1,4,1,1] <- 5    // Créditos
			datCursEnt[1,4,1,2] <- 0    // Cupos actuales
			datCursEnt[1,4,1,3] <- 28    // Cupos máximos
			datCursHor[1,4,1,1,1] <- 1 // Hora 1 Lunes
			datCursHor[1,4,1,1,2] <- 1 // Hora 1 07:30-09:10
			datCursHor[1,4,1,2,1] <- 2 // Hora 2 Martes
			datCursHor[1,4,1,2,2] <- 1 // Hora 2 07:30-09:10
			datCursCar[1,4,2,1] <- "CIVI4001" // Código de curso 2
			datCursCar[1,4,2,2] <- "Introducción a la planificación de construcciones"
			datCursCar[1,4,2,3] <- "ALIN1102" // Prerrequisito
			datCursEnt[1,4,2,1] <- 4    // Créditos
			datCursEnt[1,4,2,2] <- 0    // Cupos actuales
			datCursEnt[1,4,2,3] <- 20    // Cupos máximos
			datCursHor[1,4,2,1,1] <- 1 // Hora 1 Lunes
			datCursHor[1,4,2,1,2] <- 2 // Hora 1 09:10-10:50
			datCursHor[1,4,2,2,1] <- 2 // Hora 2 Martes
			datCursHor[1,4,2,2,2] <- 2 // Hora 2 09:10-10:50
	// CARRERAS ING. SISTEMAS (ID 2)
		// Ciclo 1
			datCursCar[2,1,1,1] <- "MATS1001" // Código de curso 1
			datCursCar[2,1,1,2] <- "Fundamentos matemáticos"
			datCursCar[2,1,1,3] <- "0"    // Sin prerrequisito
			datCursEnt[2,1,1,1] <- 4    // Créditos
			datCursEnt[2,1,1,2] <- 0    // Cupos actuales
			datCursEnt[2,1,1,3] <- 35    // Cupos máximos
			datCursHor[2,1,1,1,1] <- 3 // Hora 1 Miércoles
			datCursHor[2,1,1,1,2] <- 3 // Hora 1 10:50-12:30
			datCursHor[2,1,1,2,1] <- 4 // Hora 2 Jueves
			datCursHor[2,1,1,2,2] <- 3 // Hora 2 10:50-12:30
			datCursCar[2,1,2,1] <- "COMG1001" // Código de curso 2
			datCursCar[2,1,2,2] <- "Introducción a la Computación"
			datCursCar[2,1,2,3] <- "0"    // Sin prerrequisito
			datCursEnt[2,1,2,1] <- 3    // Créditos
			datCursEnt[2,1,2,2] <- 0    // Cupos actuales
			datCursEnt[2,1,2,3] <- 40    // Cupos máximos
			datCursHor[2,1,2,1,1] <- 3 // Hora 1 Miércoles
			datCursHor[2,1,2,1,2] <- 5 // Hora 1 14:10-15:50
			datCursHor[2,1,2,2,1] <- 4 // Hora 2 Jueves
			datCursHor[2,1,2,2,2] <- 5 // Hora 2 14:10-15:50
		// Ciclo 2
			datCursCar[2,2,1,1] <- "CALS1011" // Código de curso 1
			datCursCar[2,2,1,2] <- "Cálculo Diferencial"
			datCursCar[2,2,1,3] <- "MATS1001" // Prerrequisito
			datCursEnt[2,2,1,1] <- 5    // Créditos
			datCursEnt[2,2,1,2] <- 0    // Cupos actuales
			datCursEnt[2,2,1,3] <- 30    // Cupos máximos
			datCursHor[2,2,1,1,1] <- 3 // Hora 1 Miércoles
			datCursHor[2,2,1,1,2] <- 3 // Hora 1 10:50-12:30
			datCursHor[2,2,1,2,1] <- 4 // Hora 2 Jueves
			datCursHor[2,2,1,2,2] <- 3 // Hora 2 10:50-12:30
			datCursCar[2,2,2,1] <- "PROG2101" // Código de curso 2
			datCursCar[2,2,2,2] <- "Fundamentos de Programación"
			datCursCar[2,2,2,3] <- "COMG1001" // Prerrequisito
			datCursEnt[2,2,2,1] <- 4    // Créditos
			datCursEnt[2,2,2,2] <- 0    // Cupos actuales
			datCursEnt[2,2,2,3] <- 30    // Cupos máximos
			datCursHor[2,2,2,1,1] <- 3 // Hora 1 Miércoles
			datCursHor[2,2,2,1,2] <- 5 // Hora 1 14:10-15:50
			datCursHor[2,2,2,2,1] <- 4 // Hora 2 Jueves
			datCursHor[2,2,2,2,2] <- 5 // Hora 2 14:10-15:50
		// Ciclo 3
			datCursCar[2,3,1,1] <- "CALS1012" // Código de curso 1
			datCursCar[2,3,1,2] <- "Cálculo Integral"
			datCursCar[2,3,1,3] <- "CALS1011"    // Prerrequisito
			datCursEnt[2,3,1,1] <- 4    // Créditos
			datCursEnt[2,3,1,2] <- 0    // Cupos actuales
			datCursEnt[2,3,1,3] <- 30    // Cupos máximos
			datCursHor[2,3,1,1,1] <- 3 // Hora 1 Miércoles
			datCursHor[2,3,1,1,2] <- 3 // Hora 1 10:50-12:30
			datCursHor[2,3,1,2,1] <- 4 // Hora 2 Jueves
			datCursHor[2,3,1,2,2] <- 3 // Hora 2 10:50-12:30
			datCursCar[2,3,2,1] <- "PROG2102" // Código de curso 2
			datCursCar[2,3,2,2] <- "Programación Orientada a Objetos"
			datCursCar[2,3,2,3] <- "PROG2101"    // Prerrequisito
			datCursEnt[2,3,2,1] <- 3    // Créditos
			datCursEnt[2,3,2,2] <- 0    // Cupos actuales
			datCursEnt[2,3,2,3] <- 25    // Cupos máximos
			datCursHor[2,3,2,1,1] <- 3 // Hora 1 Miércoles
			datCursHor[2,3,2,1,2] <- 5 // Hora 1 14:10-15:50
			datCursHor[2,3,2,2,1] <- 4 // Hora 2 Jueves
			datCursHor[2,3,2,2,2] <- 5 // Hora 2 14:10-15:50
		// Ciclo 4
			datCursCar[2,4,1,1] <- "ESTC4101" // Código de curso 1
			datCursCar[2,4,1,2] <- "Estadística"
			datCursCar[2,4,1,3] <- "CALS1012" // Prerrequisito
			datCursEnt[2,4,1,1] <- 5    // Créditos
			datCursEnt[2,4,1,2] <- 0    // Cupos actuales
			datCursEnt[2,4,1,3] <- 28    // Cupos máximos
			datCursHor[2,4,1,1,1] <- 3 // Hora 1 Miércoles
			datCursHor[2,4,1,1,2] <- 3 // Hora 1 10:50-12:30
			datCursHor[2,4,1,2,1] <- 4 // Hora 2 Jueves
			datCursHor[2,4,1,2,2] <- 3 // Hora 2 10:50-12:30
			datCursCar[2,4,2,1] <- "ISIC4101" // Código de curso 2
			datCursCar[2,4,2,2] <- "Introducción a la Teoría de Sistemas"
			datCursCar[2,4,2,3] <- "PROG2102" // Prerrequisito
			datCursEnt[2,4,2,1] <- 4    // Créditos
			datCursEnt[2,4,2,2] <- 0    // Cupos actuales
			datCursEnt[2,4,2,3] <- 20    // Cupos máximos
			datCursHor[2,4,2,1,1] <- 3 // Hora 1 Miércoles
			datCursHor[2,4,2,1,2] <- 5 // Hora 1 14:10-15:50
			datCursHor[2,4,2,2,1] <- 4 // Hora 2 Jueves
			datCursHor[2,4,2,2,2] <- 5 // Hora 2 14:10-15:50
	// CARRERAS ARQUITECTURA (ID 3)
		// Ciclo 1
			datCursCar[3,1,1,1] <- "MATA1001" // Código de curso 1
			datCursCar[3,1,1,2] <- "Fundamentos matemáticos"
			datCursCar[3,1,1,3] <- "0"    // Sin prerrequisito
			datCursEnt[3,1,1,1] <- 4    // Créditos
			datCursEnt[3,1,1,2] <- 0    // Cupos actuales
			datCursEnt[3,1,1,3] <- 35    // Cupos máximos
			datCursHor[3,1,1,1,1] <- 5 // Hora 1 Viernes
			datCursHor[3,1,1,1,2] <- 6 // Hora 1 15:50-17:30
			datCursHor[3,1,1,2,1] <- 6 // Hora 2 Sábado
			datCursHor[3,1,1,2,2] <- 6 // Hora 2 15:50-17:30
			datCursCar[3,1,2,1] <- "MATA1002" // Código de curso 2
			datCursCar[3,1,2,2] <- "Geometría descriptiva"
			datCursCar[3,1,2,3] <- "0"    // Sin prerrequisito
			datCursEnt[3,1,2,1] <- 3    // Créditos
			datCursEnt[3,1,2,2] <- 0    // Cupos actuales
			datCursEnt[3,1,2,3] <- 40    // Cupos máximos
			datCursHor[3,1,2,1,1] <- 5 // Hora 1 Viernes
			datCursHor[3,1,2,1,2] <- 7 // Hora 1 17:30-19:10
			datCursHor[3,1,2,2,1] <- 6 // Hora 2 Sábado
			datCursHor[3,1,2,2,2] <- 7 // Hora 2 17:30-19:10
		// Ciclo 2
			datCursCar[3,2,1,1] <- "CALA1011" // Código de curso 1
			datCursCar[3,2,1,2] <- "Cálculo Diferencial"
			datCursCar[3,2,1,3] <- "MATA1001" // Prerrequisito
			datCursEnt[3,2,1,1] <- 5    // Créditos
			datCursEnt[3,2,1,2] <- 0    // Cupos actuales
			datCursEnt[3,2,1,3] <- 30    // Cupos máximos
			datCursHor[3,2,1,1,1] <- 5 // Hora 1 Viernes
			datCursHor[3,2,1,1,2] <- 6 // Hora 1 15:50-17:30
			datCursHor[3,2,1,2,1] <- 6 // Hora 2 Sábado
			datCursHor[3,2,1,2,2] <- 6 // Hora 2 15:50-17:30
			datCursCar[3,2,2,1] <- "DTEN1101" // Código de curso 2
			datCursCar[3,2,2,2] <- "Dibujo Técnico 1"
			datCursCar[3,2,2,3] <- "MATA1002" // Prerrequisito
			datCursEnt[3,2,2,1] <- 4    // Créditos
			datCursEnt[3,2,2,2] <- 0    // Cupos actuales
			datCursEnt[3,2,2,3] <- 30    // Cupos máximos
			datCursHor[3,2,2,1,1] <- 5 // Hora 1 Viernes
			datCursHor[3,2,2,1,2] <- 7 // Hora 1 17:30-19:10
			datCursHor[3,2,2,2,1] <- 6 // Hora 2 Sábado
			datCursHor[3,2,2,2,2] <- 7 // Hora 2 17:30-19:10
		// Ciclo 3
			datCursCar[3,3,1,1] <- "CALA1012" // Código de curso 1
			datCursCar[3,3,1,2] <- "Cálculo Integral"
			datCursCar[3,3,1,3] <- "CALA1011"    // Prerrequisito
			datCursEnt[3,3,1,1] <- 4    // Créditos
			datCursEnt[3,3,1,2] <- 0    // Cupos actuales
			datCursEnt[3,3,1,3] <- 30    // Cupos máximos
			datCursHor[3,3,1,1,1] <- 5 // Hora 1 Viernes
			datCursHor[3,3,1,1,2] <- 6 // Hora 1 15:50-17:30
			datCursHor[3,3,1,2,1] <- 6 // Hora 2 Sábado
			datCursHor[3,3,1,2,2] <- 6 // Hora 2 15:50-17:30
			datCursCar[3,3,2,1] <- "DTEN1102" // Código de curso 2
			datCursCar[3,3,2,2] <- "Dibujo Técnico 2"
			datCursCar[3,3,2,3] <- "DTEN1101"    // Prerrequisito
			datCursEnt[3,3,2,1] <- 3    // Créditos
			datCursEnt[3,3,2,2] <- 0    // Cupos actuales
			datCursEnt[3,3,2,3] <- 25    // Cupos máximos
			datCursHor[3,3,2,1,1] <- 5 // Hora 1 Viernes
			datCursHor[3,3,2,1,2] <- 7 // Hora 1 17:30-19:10
			datCursHor[3,3,2,2,1] <- 6 // Hora 2 Sábado
			datCursHor[3,3,2,2,2] <- 7 // Hora 2 17:30-19:10
		// Ciclo 4
			datCursCar[3,4,1,1] <- "MATE4011" // Código de curso 1
			datCursCar[3,4,1,2] <- "Análisis Real Avanzado"
			datCursCar[3,4,1,3] <- "CALA1012" // Prerrequisito
			datCursEnt[3,4,1,1] <- 5    // Créditos
			datCursEnt[3,4,1,2] <- 0    // Cupos actuales
			datCursEnt[3,4,1,3] <- 28    // Cupos máximos
			datCursHor[3,4,1,1,1] <- 5 // Hora 1 Viernes
			datCursHor[3,4,1,1,2] <- 6 // Hora 1 15:50-17:30
			datCursHor[3,4,1,2,1] <- 6 // Hora 2 Sábado
			datCursHor[3,4,1,2,2] <- 6 // Hora 2 15:50-17:30
			datCursCar[3,4,2,1] <- "ARQC4001" // Código de curso 2
			datCursCar[3,4,2,2] <- "Diseño de interiores"
			datCursCar[3,4,2,3] <- "DTEN1102" // Prerrequisito
			datCursEnt[3,4,2,1] <- 4    // Créditos
			datCursEnt[3,4,2,2] <- 0    // Cupos actuales
			datCursEnt[3,4,2,3] <- 20    // Cupos máximos
			datCursHor[3,4,2,1,1] <- 5 // Hora 1 Viernes
			datCursHor[3,4,2,1,2] <- 7 // Hora 1 17:30-19:10
			datCursHor[3,4,2,2,1] <- 6 // Hora 2 Sábado
			datCursHor[3,4,2,2,2] <- 7 // Hora 2 17:30-19:10
	
	
	//  VARIABLES AUXILIARES
		// GESTION ALUMNOS, PAGOS y MATRÍCULA
			Definir codigoAlumBusq Como Caracter  // Código del alumno buscado
			Definir idAlumBusq Como Entero  // ID interno del alumno buscado
		// GESTION CURSOS
			Definir cursoCodigoBuscar Como Caracter  // Código del curso buscado
			Definir cursoCarreraSelecc, cursoCicloSelecc Como Entero // Carrera y ciclo del curso buscado o seleccionado
			Definir idCursoNuevo Como Entero // Lugar dentro del ciclo del nuevo curso a registrarse
			Definir cursoCantidadBusq  Como Entero // Contador de cursos buscados, para mostrar mensaje si no se encontró ninguno
			Definir cursoBloqHorar Como Entero // Número de bloques horarios del nuevo curso a registrarse
		// GESTION PAGOS
			Definir montoMatricBase, nroCursosDesaprob, costoCursoDesaprob, montoPagar Como Real
			montoMatricBase <- 20
			costoCursoDesaprob <- 20
		// MATRICULA
			Definir contMatricBloqHor Como Entero  // Mantiene cuenta del nro de bloques horarios en que se matriculó el alumno
			Definir verifMatricHor Como Entero  // Cambia de valor si se detecta un cruce de horario, anulando la matrícula
		// REPORTES
			Definir contMatricCursos Como Entero // Cuenta el número de cursos en que se registró el alumno
		// SALIR DEL PROGRAMA
			Definir verifSalirPrograma Como Real
			verifSalirPrograma <- 1
	
	
	
	// MENU PRINCIPAL, recursivo hasta que verifSalirPrograma lo detenga
	Definir accionMenu Como Real
	Repetir
		Borrar Pantalla
		Escribir "================================================"
		Escribir " BIENVENIDO AL SISTEMA DE GESTIÓN DE MATRÍCULA. "
		Escribir "================================================"
		Escribir "1. Gestión de Alumnos."
		Escribir "2. Gestión de Cursos."
		Escribir "3. Gestión de Pagos."
		Escribir "4. Proceso de Matrícula."
		Escribir "5. Reportes Académicos."
		Escribir "6. Salir del programa."
		Leer accionMenu
		Segun accionMenu Hacer
			1:
				// GESTION DE ALUMNOS
				Escribir "=== GESTIÓN DE ALUMNOS ==="
				Escribir "1. Mostrar lista de alumnos."
				Escribir "2. Registrar un nuevo alumno."
				Escribir "3. Buscar alumno y/o actualizar información."
				Escribir "(otro número). Regresar al menú principal."
				Leer accionMenu
				Segun accionMenu Hacer
					1:
						// MOSTRAR LISTA DE ALUMNOS
						Escribir "== LISTA DE ALUMNOS =="
						Para i<-1 Hasta cantAlum Hacer
							Escribir i,". ", datAlumCar[i,2]
							Escribir "    Código ",datAlumCar[i,1],", " Sin Saltar
							Escribir nombreCarrera[datAlumEnt[i,1]],", ciclo ",datAlumEnt[i,2]
							Segun datAlumEnt[i,3] Hacer
								0:
									Escribir "    Sin beca."
								1:
									Escribir "    Media beca."
								2:
									Escribir "    Beca completa."
							FinSegun
							Escribir ""
						FinPara
						TeclaContinuar
						
						
					2:
						// REGISTRAR NUEVO ALUMNO
						cantAlum <- cantAlum +1
						// Redimensionar todos los arreglos que dependan de la cantidad de alumnos
						Redimension datAlumCar[cantAlum,2]
						Redimension datAlumEnt[cantAlum,5]
						Redimension datAlumHor[cantAlum,6,18]
						Redimension datAlumCurs[cantAlum,cantCiclos,cantCursosPorCiclo]
						// Leer información del nuevo alumno
						Escribir "Ingrese el código del alumno nuevo:"
						Leer datAlumCar[cantAlum,1]
						Escribir "Ingrese los apellidos y nombres (en ese orden, en mayúsculas) del alumno nuevo:"
						Leer datAlumCar[cantAlum,2]
						Escribir "Elija la carrera del alumno nuevo:"
						Para i<-1 Hasta cantCarreras Hacer
							Escribir i,". ",nombreCarrera[i]
						FinPara
						datAlumEnt[cantAlum,1] <- IngresarEnteroValido(1,cantCarreras)
						Escribir "Ingrese el ciclo en que se encuentra, del 1 al ",cantCiclos,"."
						datAlumEnt[cantAlum,2] <- IngresarEnteroValido(1,cantCiclos)
						Escribir "Elija una opción respecto a la condición del alumno:"
						Escribir "0. No becado."
						Escribir "1. Con media beca."
						Escribir "2. Con beca completa."
						datAlumEnt[cantAlum,3] <- IngresarEnteroValido(0,2)
						
						// Confirmar registro de alumno
						Escribir "Alumno registrado correctamente."
						TeclaContinuar
						
						
					3:
						// BUSCAR Y/O ACTUALIZAR INFORMACIÓN DE ALUMNO
						Escribir "Ingrese el código exacto (de la forma 256789A) del alumno a buscar:"
						idAlumBusq <- 0
						Leer codigoAlumBusq
						Para i<-1 Hasta cantAlum Hacer
							Si datAlumCar[i,1] = codigoAlumBusq Entonces
								idAlumBusq <- i
							FinSi
						FinPara
						Si idAlumBusq = 0 Entonces
							Escribir "No se encontró un alumno con ese código exacto."
						SiNo
							Escribir "Se encontró al alumno:"
							Escribir "  ",datAlumCar[idAlumBusq,2]
							Escribir "    Código ",datAlumCar[idAlumBusq,1],", " Sin Saltar
							Escribir nombreCarrera[datAlumEnt[idAlumBusq,1]],", ciclo ",datAlumEnt[idAlumBusq,2]
							Segun datAlumEnt[idAlumBusq,3] Hacer
								0:
									Escribir "    Sin beca."
								1:
									Escribir "    Media beca."
								2:
									Escribir "    Beca completa."
							FinSegun
							// Proceder a la actualización de un valor
							Escribir "¿Desea actualizar la información de este alumno?"
							Escribir "1. Código"
							Escribir "2. Apellidos y nombres"
							Escribir "3. Carrera"
							Escribir "4. Ciclo"
							Escribir "5. Condición de beca"
							Escribir "(otro número). No actualizar nada."
							Leer accionMenu
							Segun accionMenu Hacer
								1:
									// Actualizar código
									Escribir "Ingrese el código actualizado del alumno:"
									Leer datAlumCar[idAlumBusq,1]
								2:
									// Actualizar nombre
									Escribir "Ingrese los apellidos y nombres (en ese orden, en mayúsculas) actualizados del alumno:"
									Leer datAlumCar[idAlumBusq,2]
								3:
									// Actualizar carrera
									Escribir "Elija la carrera actualizada del alumno:"
									Para j<-1 Hasta cantCarreras Hacer
										Escribir j,". ",nombreCarrera[j]
									FinPara
									datAlumEnt[idAlumBusq,1] <- IngresarEnteroValido(1,cantCarreras)
								4:
									// Actualizar ciclo
									Escribir "Ingrese el ciclo actualizado, del 1 al ",cantCiclos,"."
									datAlumEnt[idAlumBusq,2] <- IngresarEnteroValido(1,cantCiclos)
								5:
									// Modificar condición de becado
									Escribir "Elija una opción respecto a la condición del alumno:"
									Escribir "0. No becado."
									Escribir "1. Con media beca."
									Escribir "2. Con beca completa."
									datAlumEnt[idAlumBusq,3] <- IngresarEnteroValido(0,2)
								De Otro Modo:
									// Volver al menú principal
							FinSegun
						FinSi
						TeclaContinuar
						
						
					De Otro Modo:
						// Volver al menú principal
				FinSegun
				
				
				
				
			2:
				// GESTIÓN DE CURSOS
				Escribir "=== GESTIÓN DE CURSOS ==="
				Escribir "1. Mostrar lista de cursos por carrera o ciclo."
				Escribir "2. Registrar un nuevo curso."
				Escribir "3. Buscar curso y/o actualizar información."
				Escribir "(otro número). Regresar al menú principal."
				Leer accionMenu
				Segun accionMenu Hacer
					1:
						// LISTA DE CURSOS POR CARRERA Y CICLO
						Escribir "Elija la carrera de los cursos a mostrar:"
						Para i<-1 Hasta cantCarreras Hacer
							Escribir i,". ",nombreCarrera[i]
						FinPara
						cursoCarreraSelecc <- IngresarEnteroValido(1,cantCarreras)
						Escribir "Ingrese el ciclo, del 1 al ",cantCiclos," de los cursos a mostrar, o ingrese ",cantCiclos +1, " para mostrar cursos de todos los ciclos:" 
						cursoCicloSelecc <- IngresarEnteroValido(1,cantCiclos+1)
						Si cursoCicloSelecc = cantCiclos +1 Entonces
							// Mostrar cursos de TODOS los ciclos
							Para i<-1 Hasta cantCiclos Hacer
								Escribir "CICLO ",i,":"
								Para j<-1 Hasta cantCursosPorCiclo Hacer
									Si datCursCar[cursoCarreraSelecc,i,j,1] <> "" Entonces
										// Imprimir curso
										Escribir "  Curso ",j,": ",datCursCar[cursoCarreraSelecc,i,j,2]
										Escribir "    Código ",datCursCar[cursoCarreraSelecc,i,j,1]
										Si datCursCar[cursoCarreraSelecc,i,j,3] = "0" Entonces
											Escribir "    No tiene prerequisitos."
										SiNo
											Escribir "    Prerequisito: ", datCursCar[cursoCarreraSelecc,i,j,3] 
										FinSi
										Escribir "    Créditos: ",datCursEnt[cursoCarreraSelecc,i,j,1]
										Escribir "    Cupos: ",datCursEnt[cursoCarreraSelecc,i,j,2]," de ",datCursEnt[cursoCarreraSelecc,i,j,3]
										// Mostrar horarios del curso
										Escribir "    Horarios:"
										Para k<-1 Hasta 4 Hacer
											Si datCursHor[cursoCarreraSelecc,i,j,k,1] <> 0 Entonces
												Escribir "      ",nombreDiaSem[datCursHor[cursoCarreraSelecc,i,j,k,1]] Sin Saltar
												Escribir " " Sin Saltar
												Escribir nombreBloqHorar[datCursHor[cursoCarreraSelecc,i,j,k,2]]
											FinSi
										FinPara
									FinSi
								FinPara
							FinPara
						SiNo
							// Mostrar solo cursos del ciclo seleccionado
							Escribir "CICLO ",cursoCicloSelecc,":"
							Para j<-1 Hasta cantCursosPorCiclo Hacer
								Si datCursCar[cursoCarreraSelecc,cursoCicloSelecc,j,1] <> "" Entonces
									// Imprimir curso
									Escribir "  Curso ",j,": ",datCursCar[cursoCarreraSelecc,cursoCicloSelecc,j,2]
									Escribir "    Código ",datCursCar[cursoCarreraSelecc,cursoCicloSelecc,j,1]
									Si datCursCar[cursoCarreraSelecc,cursoCicloSelecc,j,3] = "0" Entonces
										Escribir "    No tiene prerequisitos."
									SiNo
										Escribir "    Prerequisito: ", datCursCar[cursoCarreraSelecc,cursoCicloSelecc,j,3] 
									FinSi
									Escribir "    Créditos: ",datCursEnt[cursoCarreraSelecc,cursoCicloSelecc,j,1]
									Escribir "    Cupos: ",datCursEnt[cursoCarreraSelecc,cursoCicloSelecc,j,2]," de ",datCursEnt[cursoCarreraSelecc,cursoCicloSelecc,j,3]
									// Mostrar horarios del curso
									Escribir "    Horarios:"
									Para k<-1 Hasta 4 Hacer
										Si datCursHor[cursoCarreraSelecc,i,j,k,1] <> 0 Entonces
											Escribir "      ",nombreDiaSem[datCursHor[cursoCarreraSelecc,i,j,k,1]] Sin Saltar
											Escribir " " Sin Saltar
											Escribir nombreBloqHorar[datCursHor[cursoCarreraSelecc,i,j,k,2]]
										FinSi
									FinPara
								FinSi
							FinPara
						FinSi
						TeclaContinuar
						
						
					2:
						// REGISTRAR UN NUEVO CURSO
						Escribir "Elija la carrera a la que se va a agregar el curso:"
						Para i<-1 Hasta cantCarreras Hacer
							Escribir i,". ",nombreCarrera[i]
						FinPara
						cursoCarreraSelecc <- IngresarEnteroValido(1,cantCarreras)
						Escribir "Ingrese el ciclo, del 1 al ",cantCiclos," al que se va a agregar el curso:"
						cursoCicloSelecc <- IngresarEnteroValido(1,cantCiclos)
						// Asignar ID interno del nuevo curso
						idNuevoCurso <- 0
						Repetir
							idNuevoCurso <- idNuevoCurso +1
						Hasta Que (datCursCar[cursoCarreraSelecc,cursoCicloSelecc,idNuevoCurso,1] = "" o idNuevoCurso > cantCursosPorCiclo-1)
						Si (idNuevoCurso = cantCursosPorCiclo y datCursCar[cursoCarreraSelecc,cursoCicloSelecc,idNuevoCurso,1] <> "") Entonces
							Escribir "Ya se alcanzó el máximo de ",cantCursosPorCiclo," cursos en este ciclo."
						SiNo
							// Registrar información del nuevo curso:
							Escribir "Ingrese el código exacto del nuevo curso (de la forma ABCD1001):"
							Leer datCursCar[cursoCarreraSelecc,cursoCicloSelecc,idNuevoCurso,1]
							Escribir "Ingrese el nombre del nuevo curso:"
							Leer datCursCar[cursoCarreraSelecc,cursoCicloSelecc,idNuevoCurso,2]
							Escribir "Ingrese el código del curso prerequisito, o 0 si no tiene ninguno:"
							Leer datCursCar[cursoCarreraSelecc,cursoCicloSelecc,idNuevoCurso,3]
							Escribir "Ingrese el número de créditos, de 1 a 9:"
							datCursEnt[cursoCarreraSelecc,cursoCicloSelecc,idNuevoCurso,1] <- IngresarEnteroValido(1,9)
							// Asignar cupos actuales a 0
							datCursEnt[cursoCarreraSelecc,cursoCicloSelecc,idNuevoCurso,2] <- 0
							Escribir "Ingrese el número de cupos máximos, de 10 a 60:"
							datCursEnt[cursoCarreraSelecc,cursoCicloSelecc,idNuevoCurso,3] <- IngresarEnteroValido(10,60)
							// Elegir horario del curso
							Escribir "Ingrese el número de bloques horarios (2h c/u) del curso, de 1 a 4:"
							cursoBloqHorar <- IngresarEnteroValido(1,4)
							Para i <- 1 Hasta cursoBloqHorar Hacer
								Escribir "Ingrese el día de la semana del bloque horario ",i,":"
								ImprimirDiasSemana
								datCursHor[cursoCarreraSelecc,cursoCicloSelecc,idNuevoCurso,i,1] <- IngresarEnteroValido(1,6)
								Escribir "Ingrese el bloque horario ",i,":"
								ImprimirBloquesHorarios
								datCursHor[cursoCarreraSelecc,cursoCicloSelecc,idNuevoCurso,i,2] <- IngresarEnteroValido(1,8)
							FinPara
							cantCursosReg <- cantCursosReg +1
							Escribir "Curso registrado correctamente."
						FinSi
						TeclaContinuar
						
						
					3:
						// BUSCAR CURSO Y/O ACTUALIZAR INFORMACIÓN
						Escribir "Ingrese el código exacto del curso a buscar (de la forma ABCD1001):"
						Leer cursoCodigoBuscar
						// Restablecer contador de búsqueda
						cursoCantidadBusq <- 0
						Escribir "Resultados de búsqueda:"
						Para i<-1 Hasta cantCarreras Hacer // Busca cada carrera
							Para j<-1 Hasta cantCiclos Hacer // Busca cada ciclo
								Para k<-1 Hasta cantCursosPorCiclo Hacer // Busca cada espacio de los ciclos.
									Si datCursCar[i,j,k,1] = cursoCodigoBuscar Entonces
										// Imprimir curso
										Escribir datCursCar[i,j,k,1],": ",datCursCar[i,j,k,2]
										Escribir "    ",nombreCarrera[i],", ciclo ",j,"."
										Si datCursCar[i,j,k,3] = "0" Entonces
											Escribir "    No tiene prerequisitos."
										SiNo
											Escribir "    Prerequisito: ", datCursCar[i,j,k,3] 
										FinSi
										Escribir "    Créditos: ",datCursEnt[i,j,k,1]
										Escribir "    Cupos: ",datCursEnt[i,j,k,2]," de ",datCursEnt[i,j,k,3]
										cursoCantidadBusq <- cursoCantidadBusq+1
										// Proceder a la actualización del curso
										Escribir "¿Desea actualizar algún dato de este curso?"
										Escribir "1. Código"
										Escribir "2. Nombre"
										Escribir "3. Código del prerrequisito"
										Escribir "4. Créditos"
										Escribir "5. Cupos máximos"
										Escribir "(otro número). No actualizar nada"
										Leer accionMenu
										Segun accionMenu Hacer
											1:
												// Actualizar código
												Escribir "Ingrese el código exacto actualizado del curso (de la forma ABCD1001):"
												Leer datCursCar[i,j,k,1]
											2:
												// Actualizar nombre
												Escribir "Ingrese el nombre actualizado del curso:"
												Leer datCursCar[i,j,k,2]
											3:
												// Actualizar código prerrequisito
												Escribir "Ingrese el código del curso prerequisito, o 0 si no tiene ninguno:"
												Leer datCursCar[i,j,k,3]
											4:
												// Actualizar créditos
												Escribir "Ingrese el número de créditos, de 1 a 9:"
												datCursEnt[i,j,k,1] <- IngresarEnteroValido(1,9)
											5:
												// Actualizar cupos máximos
												Escribir "Ingrese el número de cupos máximos, de 10 a 60:"
												datCursEnt[i,j,k,3] <- IngresarEnteroValido(10,60)
											De Otro Modo:
												// Continuar búsqueda o volver al menú principal.
										FinSegun
									FinSi
								FinPara
							FinPara
						FinPara
						Si cursoCantidadBusq <- 0 Entonces
							Escribir "No se encontró ningún curso con el código proporcionado"
						FinSi
						TeclaContinuar
						
						
					De Otro Modo:
						// Volver al menú principal
				FinSegun
				
				
				
				
			3:
				// GESTIÓN DE PAGOS
				Escribir "=== GESTION DE PAGOS ==="
				Escribir "1. Registrar pago para matrícula de un alumno."
				Escribir "2. Mostrar lista de Alumnos con pagos completados."
				Escribir "3. Mostrar lista de Alumnos con pagos pendientes."
				Escribir "(otro número). Volver al menú principal."
				Leer accionMenu
				Segun accionMenu Hacer
					1:
						// BUSCAR Y/O ACTUALIZAR INFORMACIÓN DE alumno
						Escribir "Ingrese el código exacto (de la forma 256789A) del alumno a registrar:"
						Leer codigoAlumBusq
						idAlumBusq <- 0
						Para i<-1 Hasta cantAlum Hacer
							Si datAlumCar[i,1] = codigoAlumBusq Entonces
								idAlumBusq <- i
							FinSi
						FinPara
						Si idAlumBusq = 0 Entonces
							Escribir "No se encontró un alumno con ese código exacto."
						SiNo
							Escribir "Se encontró al alumno:"
							Escribir "  ",datAlumCar[idAlumBusq,2]
							Escribir "    Código ",datAlumCar[idAlumBusq,1],", " Sin Saltar
							Escribir nombreCarrera[datAlumEnt[idAlumBusq,1]],", ciclo ",datAlumEnt[idAlumBusq,2]
							Segun datAlumEnt[idAlumBusq,3] Hacer
								0:
									Escribir "    Sin beca."
								1:
									Escribir "    Media beca."
								2:
									Escribir "    Beca completa."
							FinSegun
							// Verificar si ya pagó
							Si datAlumEnt[idAlumBusq,4] <> 0 Entonces
								Escribir "Este alumno ya pagó su derecho de matrícula."
							SiNo
								// Verificar si tiene beca completa
								Si datAlumEnt[idAlumBusq,3] = 2 Entonces
									Escribir "El alumno tiene beca completa."
									Escribir "Monto a pagar: S/. 0.00"
									// Cambiar estado de pago
									datAlumEnt[idAlumBusq,4] <- 1
									Escribir "Pago registrado correctamente. El alumno ya puede matricularse."
								SiNo
									// Proceder al cálculo del monto total a pagar.
									montoPagar <- 0
									Escribir "Ingrese el número de cursos desaprobados (de 0 a 10) del alumno:"
									nroCursosDesaprob <- IngresarEnteroValido(0,10)
									montoPagar <- montoMatricBase + nroCursosDesaprob*costoCursoDesaprob 
									Escribir "S/. 20  Monto base"
									Escribir "S/. ",nroCursosDesaprob*costoCursoDesaprob,"  Cursos desaprobados (S/.20 c/u)"
									Si datAlumEnt[idAlumBusq,3] = 1 Entonces
										Escribir "La media beca aplica un 50% de descuento."
										montoPagar <- montoPagar/2
									FinSi
									Escribir "S/. ",montoPagar,"  TOTAL A PAGAR"
									Escribir "¿El alumno pagó el monto requerido?"
									Escribir "1. Sí."
									Escribir "(otro número). No."
									Leer accionMenu
									Si accionMenu = 1 Entonces
										datAlumEnt[idAlumBusq,4] <- 1
										Escribir "Pago registrado correctamente. El alumno ya puede matricularse."
									SiNo
										Escribir "No se registró ningún pago."
									FinSi
									
								FinSi
							FinSi
						FinSi
						TeclaContinuar
						
						
					2:
						Escribir "== Alumnos CON PAGOS COMPLETADOS =="
						Para i <- 1 Hasta cantAlum Hacer
							Si datAlumEnt[i,4] = 1 Entonces
								Escribir "  ",datAlumCar[i,2]
								Escribir "    Código ",datAlumCar[i,1],", " Sin Saltar
								Escribir nombreCarrera[datAlumEnt[i,1]],", ciclo ",datAlumEnt[i,2]
								Escribir ""
							FinSi
						FinPara
						TeclaContinuar
						
						
					3:
						Escribir "== Alumnos CON PAGOS PENDIENTES =="
						Para i <- 1 Hasta cantAlum Hacer
							Si datAlumEnt[i,4] = 0 Entonces
								Escribir "  ",datAlumCar[i,2]
								Escribir "    Código ",datAlumCar[i,1],", " Sin Saltar
								Escribir nombreCarrera[datAlumEnt[i,1]],", ciclo ",datAlumEnt[i,2]
								Escribir ""
							FinSi
						FinPara
						TeclaContinuar
						
						
					De Otro Modo:
						//Volver al menú principal
				FinSegun
				
				
				
				
			4:
				// Procesos de matrícula
				// Contiene las funciones:
				// 		MatricularalumnoEnCurso() : Agregar alumno a ciertos cursos acorde a su ciclo y carrera
				// 		VerificarMatricula() : Verificar prerequisitos y conflictos horarios 
				// 		GenerarBoletaMatricula() : con costo total
				Escribir "=== MATRÍCULA ==="
				Escribir "1. Registrar matrícula de un alumno."
				Escribir "2. Mostrar lista de alumnos matriculados."
				Escribir "3. Mostrar lista de alumnos sin matricular."
				Escribir "(otro número). Volver al menú principal."
				Leer accionMenu
				Segun accionMenu Hacer
					1:
						Escribir "Ingrese el código exacto (de la forma 256789A) del alumno a matricular:"
						idAlumBusq <- 0
						Leer codigoAlumBusq
						Para i<-1 Hasta cantAlum Hacer
							Si datAlumCar[i,1] = codigoAlumBusq Entonces
								idAlumBusq <- i
							FinSi
						FinPara
						Si idAlumBusq = 0 Entonces
							Escribir "No se encontró un alumno con ese código exacto."
						SiNo
							Escribir "== MATRÍCULA DE ALUMNO =="
							Escribir "  ",datAlumCar[idAlumBusq,2]
							Escribir "    Código ",datAlumCar[idAlumBusq,1],", " Sin Saltar
							Escribir nombreCarrera[datAlumEnt[idAlumBusq,1]],", ciclo ",datAlumEnt[idAlumBusq,2]
							Segun datAlumEnt[idAlumBusq,3] Hacer
								0:
									Escribir "    Sin beca."
								1:
									Escribir "    Media beca."
								2:
									Escribir "    Beca completa."
							FinSegun
							// Verificar si ya está matriculado
							Si datAlumEnt[idAlumBusq,5] = 1 Entonces
								Escribir "El alumno ya está matriculado."
							SiNo
								// Verificar si ya pagó 
								Si datAlumEnt[idAlumBusq,5] = 1 Entonces
									Escribir "El alumno no tiene su pago completo procesado aún."
								SiNo
									
									
									// PROCEDER A LA MATRÍCULA
									Escribir "El alumno puede matricularse en los siguientes cursos:"
									// Mostrar lista de cursos según ciclo del alumno.
									Para i<- datAlumEnt[idAlumBusq,2]-1 Hasta datAlumEnt[idAlumBusq,2]+1 Hacer
										// Mostrar solo cursos del ciclo seleccionado
										Escribir "CICLO ",i,":"
										Para j<-1 Hasta cantCursosPorCiclo Hacer
											// Recordar que datAlumEnt[idAlumBusq,1] es la carrera del alumno
											Si (datCursCar[datAlumEnt[idAlumBusq,1],i,j,1] <> "" y datCursEnt[datAlumEnt[idAlumBusq,1],i,j,2]<datCursEnt[datAlumEnt[idAlumBusq,1],i,j,3]) Entonces
												// Si el nombre no está vacío, y los cupos actuales son menores que los máximos, entonces 
												// Imprimir curso
												Escribir "  Curso ",j,": ",datCursCar[datAlumEnt[idAlumBusq,1],i,j,2]
												Escribir "    Código ",datCursCar[datAlumEnt[idAlumBusq,1],i,j,1]
												Si datCursCar[datAlumEnt[idAlumBusq,1],i,j,3] = "0" Entonces
													Escribir "    No tiene prerequisitos."
												SiNo
													Escribir "    Prerequisito: ", datCursCar[datAlumEnt[idAlumBusq,1],i,j,3] 
												FinSi
												Escribir "    Créditos: ",datCursEnt[datAlumEnt[idAlumBusq,1],i,j,1]
												Escribir "    Cupos: ",datCursEnt[datAlumEnt[idAlumBusq,1],i,j,2]," de ",datCursEnt[datAlumEnt[idAlumBusq,1],i,j,3]
												// Mostrar horarios del curso
												Escribir "    Horarios:"
												Para k<-1 Hasta 4 Hacer
													Si datCursHor[datAlumEnt[idAlumBusq,1],i,j,k,1] <> 0 Entonces
														Escribir "      ",nombreDiaSem[datCursHor[datAlumEnt[idAlumBusq,1],i,j,k,1]] Sin Saltar
														Escribir " " Sin Saltar
														Escribir nombreBloqHorar[datCursHor[datAlumEnt[idAlumBusq,1],i,j,k,2]]
													FinSi
												FinPara
											FinSi
										FinPara
									FinPara
									Escribir "Recuerde que solo puede matricularse en un máximo de ",maxCursosPorAlum," cursos a la vez."
									TeclaContinuar
									// Elegir en cuáles se puede matricular
									contMatricBloqHor <- 0
									verifMatricHor <- 0
									// Para cada i = ciclo actual, el anterior y el siguiente. (solo se permite matricula hasta cursos de 3 ciclos consecutivos)
									Para i<- datAlumEnt[idAlumBusq,2]-1 Hasta datAlumEnt[idAlumBusq,2]+1 Hacer
										// Para cada espacio dentro del ciclo
										Para j<-1 Hasta cantCursosPorCiclo Hacer
											// Recordar que datAlumEnt[idAlumBusq,1] es la carrera del alumno
											Si (datCursCar[datAlumEnt[idAlumBusq,1],i,j,1] <> "" y datCursEnt[datAlumEnt[idAlumBusq,1],i,j,2]<datCursEnt[datAlumEnt[idAlumBusq,1],i,j,3] y verifMatricHor = 0) Entonces
												// Si el nombre no está vacío, los cupos actuales son menores que los máximos, y no hay cruces, entonces 
												// Imprimir curso
												Escribir datCursCar[datAlumEnt[idAlumBusq,1],i,j,1],": ",datCursCar[datAlumEnt[idAlumBusq,1],i,j,2]
												// Preguntar matrícula
												Escribir "  ¿Matricularse en este curso?"
												Escribir "  1. Sí"
												Escribir "  (otro número). No"
												Leer accionMenu
												Segun accionMenu Hacer
													1:
														// Verificar si no hay cruce para cada uno de sus bloques horarios
														Para k <- 1 Hasta 4 Hacer
															// No trabajar con espacios vacíos
															Si datCursHor[datAlumEnt[idAlumBusq,1],i,j,k,1] <> 0 Entonces
																// Verificar si el espacio del horario del alumno está vacío
																// Recordar que datAlumHor[id del estudiante, ciclo del curso, lugar en el ciclo del curso]
																Si datAlumHor[idAlumBusq,datCursHor[datAlumEnt[idAlumBusq,1],i,j,k,1],datCursHor[datAlumEnt[idAlumBusq,1],i,j,k,2]] = FALSO Entonces
																	// Espacio disponible, registrar curso en matrícula
																	datAlumHor[idAlumBusq,datCursHor[datAlumEnt[idAlumBusq,1],i,j,k,1],datCursHor[datAlumEnt[idAlumBusq,1],i,j,k,2]] <- VERDADERO
																	contMatricBloqHor <- contMatricBloqHor +1
																	// Agregar solo si es diferente al anterior
																	Si (contMatricBloqHor > 1 y (i <> datAlumCurs[idAlumBusq,contMatricBloqHor-1,1] o j <> datAlumCurs[idAlumBusq,contMatricBloqHor-1,2])) Entonces
																		datAlumCurs[idAlumBusq,contMatricBloqHor,1] <- i // Guardar ciclo
																		datAlumCurs[idAlumBusq,contMatricBloqHor,2] <- j // Guardar lugar dentro del ciclo
																		// Aumentar número de cupos del curso en 1
																		datCursEnt[datAlumEnt[idAlumBusq,1],i,j,2] <- datCursEnt[datAlumEnt[idAlumBusq,1],i,j,2] +1
																	FinSi
																SiNo
																	// Espacio ocupado, detectar cruce para detener el bucle
																	verifMatricHor <- 1
																FinSi
															FinSi
														FinPara
														
													De Otro Modo:
														// No hace nada
												FinSegun
											FinSi
										FinPara
									FinPara
									
									
									
									// CONFIRMAR O ANULAR MATRÍCULA
									Si verifMatricHor = 1 Entonces
										Escribir "Se ha detectado un cruce de horarios. Matrícula cancelada."
										// Reiniciar matriz de horarios del estudiante
										Para i <- 1 Hasta 6 Hacer
											Para j <- 1 Hasta 8 Hacer
												datAlumHor[idAlumBusq,i,j] <- FALSO
											FinPara
										FinPara
										// Reiniciar matriz de cursos registrados
										Para i <- 1 Hasta maxCursosPorAlum Hacer
											Para j <- 1 Hasta 2 Hacer
												datAlumCurs[idAlumBusq,i,j] <- 0
											FinPara
										FinPara
									SiNo
										Escribir "Matrícula registrada correctamente. Los cursos matriculados son:"
										Para i <- 1 Hasta maxCursosPorAlum Hacer
											// No trabajar con espacios vacíos
											Si datAlumCurs[idAlumBusq,i,1] <> 0 Entonces
												// Imprimir el código y nombre del curso
												Escribir datCursCar[datAlumEnt[idAlumBusq,1],datAlumCurs[idAlumBusq,i,1],datAlumCurs[idAlumBusq,i,2],1],": ",datCursCar[datAlumEnt[idAlumBusq,1],datAlumCurs[idAlumBusq,i,1],datAlumCurs[idAlumBusq,i,2],2]
											FinSi
										FinPara
										// Cambiar estado de matrícula
										datAlumEnt[idAlumBusq,5] <- 1
									FinSi
									
								FinSi
							FinSi
						FinSi
						TeclaContinuar
						
						
					2:
						Escribir "== ALUMNOS MATRICULADOS =="
						Para i <- 1 Hasta cantAlum Hacer
							Si datAlumEnt[i,5] = 1 Entonces
								Escribir "  ",datAlumCar[i,2]
								Escribir "    Código ",datAlumCar[i,1],", " Sin Saltar
								Escribir nombreCarrera[datAlumEnt[i,1]],", ciclo ",datAlumEnt[i,2]
								Escribir ""
							FinSi
						FinPara
						TeclaContinuar
						
						
					3:
						Escribir "== ALUMNOS SIN MATRICULAR =="
						Para i <- 1 Hasta cantAlum Hacer
							Si datAlumEnt[i,5] = 0 Entonces
								Escribir "  ",datAlumCar[i,2]
								Escribir "    Código ",datAlumCar[i,1],", " Sin Saltar
								Escribir nombreCarrera[datAlumEnt[i,1]],", ciclo ",datAlumEnt[i,2]
								Escribir ""
							FinSi
						FinPara
						TeclaContinuar
						
						
					De Otro Modo:
						//Volver al menú principal
				FinSegun
				
				
				
				
			5:
				// Reportes Académicos
				// Contiene las funciones:
				//		GenerarReportealumno() : por alumno, ingresando código.
				//		EstadísticasMatrícula(): por curso o por carrera
				Escribir "=== REPORTES ACADÉMICOS ==="
				Escribir "1. Reporte de alumno."
				Escribir "2. Estadísticas de curso"
				Escribir "3. Estadísticas de carrera"
				Escribir "(otro número). Volver al menú principal."
				Leer accionMenu
				Segun accionMenu Hacer
					1:
						// BUSCAR ALUMNO Y DEVOLVER INFO
						Escribir "Ingrese el código exacto (de la forma 256789A) del alumno a generar reporte:"
						idAlumBusq <- 0
						Leer codigoAlumBusq
						Para i<-1 Hasta cantAlum Hacer
							Si datAlumCar[i,1] = codigoAlumBusq Entonces
								idAlumBusq <- i
							FinSi
						FinPara
						Si idAlumBusq = 0 Entonces
							Escribir "No se encontró un alumno con ese código exacto."
						SiNo
							Escribir "== REPORTE DE ALUMNO =="
							Escribir "  ",datAlumCar[idAlumBusq,2]
							Escribir "    Código ",datAlumCar[idAlumBusq,1],", " Sin Saltar
							Escribir nombreCarrera[datAlumEnt[idAlumBusq,1]],", ciclo ",datAlumEnt[idAlumBusq,2]
							Segun datAlumEnt[idAlumBusq,3] Hacer
								0:
									Escribir "    Sin beca."
								1:
									Escribir "    Media beca."
								2:
									Escribir "    Beca completa."
							FinSegun
						FinSi
						Escribir "El alumno está matriculado en los siguientes cursos:"
						contMatricBloqHor <- 0
						Para i <- 1 Hasta maxCursosPorAlum Hacer
							// No trabajar con espacios vacíos
							Si datAlumCurs[idAlumBusq,i,1] <> 0 Entonces
								// Imprimir el código y nombre del curso
								contMatricBloqHor <- contMatricBloqHor +1
								Escribir "  ",datCursCar[datAlumEnt[idAlumBusq,1],datAlumCurs[idAlumBusq,i,1],datAlumCurs[idAlumBusq,i,2],1],": ",datCursCar[datAlumEnt[idAlumBusq,1],datAlumCurs[idAlumBusq,i,1],datAlumCurs[idAlumBusq,i,2],2]
							FinSi
						FinPara
						Si contMatricBloqHor = 0 Entonces
							Escribir "  (Ninguno)"
						FinSi
						TeclaContinuar
						
						
					2:
						// BUSCAR CURSO Y DEVOLVER INFO
						Escribir "Ingrese el código exacto del curso a reportar (de la forma ABCD1001):"
						Leer cursoCodigoBuscar
						// Restablecer contador de búsqueda
						cursoCantidadBusq <- 0
						Escribir "Resultados de búsqueda:"
						Para i<-1 Hasta cantCarreras Hacer // Busca cada carrera
							Para j<-1 Hasta cantCiclos Hacer // Busca cada ciclo
								Para k<-1 Hasta cantCursosPorCiclo Hacer // Busca cada espacio de los ciclos.
									Si datCursCar[i,j,k,1] = cursoCodigoBuscar Entonces
										// Imprimir curso
										Escribir datCursCar[i,j,k,1],": ",datCursCar[i,j,k,2]
										Escribir "    ",nombreCarrera[i],", ciclo ",j,"."
										Escribir "    ",datCursEnt[i,j,k,2]," alumnos matriculados, ",datCursEnt[i,j,k,3]-datCursEnt[i,j,k,2]," cupos libres."
										cursoCantidadBusq <- cursoCantidadBusq+1
									FinSi
								FinPara
							FinPara
						FinPara
						Si cursoCantidadBusq <- 0 Entonces
							Escribir "No se encontró ningún curso con el código proporcionado"
						FinSi
						TeclaContinuar
						
						
					3:
						// DEVOLVER INFORMACION POR CARRERA
						Escribir "== ESTADÍSTICAS POR CARRERA =="
						Para i<-1 Hasta cantCarreras Hacer
							Escribir nombreCarrera[i] ,": ",cantAlumCarrera[i]," alumnos."
						FinPara
						TeclaContinuar
						
						
					De Otro Modo:
						//Volver al menú principal
				FinSegun
				
				
				
				
			6:
				// Diálogo para salir del programa
				Escribir "=== SALIR DEL PROGRAMA ==="
				Escribir "Desea salir del programa?"
				Escribir "0. Sí"
				Escribir "(otro número). No"
				Leer verifSalirPrograma
				
			De Otro Modo:
				Escribir "No se ingresó una opción correcta."
		Fin Segun
	Hasta Que verifSalirPrograma=0
	
	// Mensaje de despedida al salir
	Escribir "======================"
	Escribir "Que tenga un buen día."
FinAlgoritmo
