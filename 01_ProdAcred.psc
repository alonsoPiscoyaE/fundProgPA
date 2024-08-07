
Funcion MenuPrincipal
	Escribir "Bienvenido a blablabla."
	Escribir "1. Gestión de Estudiantes."
	Escribir "2. Gestión de Cursos."
	Escribir "3. Proceso de matrícula."
	Escribir "4. Gestión de Pagos."
	Escribir "5. Reportes Académicos."
	Escribir "6. Salir del programa."
	Leer accionMenuPrincipal
	Segun accionMenuPrincipal Hacer
		1:
			GestionEstudiantes
		2:
			GestionCursos
		3:
			ProcesoMatricula
		4:
			GestionPagos
		5:
			ReportesAcademicos
		6:
			verifSalirPrograma = SalirPrograma
		De Otro Modo:
			Escribir "No se ingresó una opción correcta."
	Fin Segun
	Si verifSalirPrograma = 0 Entonces
		MenuPrincipal
	FinSi
Fin Funcion



Funcion GestionEstudiantes
	//
FinFuncion



Funcion GestionCursos
	//
FinFuncion



Funcion ProcesoMatricula
	//
FinFuncion



Funcion GestionPagos
	//
FinFuncion



Funcion ReportesAcademicos
	//
FinFuncion



Funcion retornoSalirPrograma <- SalirPrograma
	Escribir "Desea salir del programa?"
	Escribir "1 = Sí"
	Escribir "0 = No"
	Leer retornoSalirPrograma
FinFuncion



Algoritmo ProdAcred
	Definir verifSalirPrograma Como Entero
	verifSalirPrograma = 0
	// Sistema de gestión de matrículas universitarias
	// Se deben usar las funciones:
	// 
	// Funcion MenuPrincipal(): ejecutada al iniciar el programa y al terminar una función de nivel 1 (FN1),
	//			Puede indicar en ejecutar una función de siguiente nivel, o salir del programa.
	//
	// 		GestionEstudiantes() : contiene las funciones:
	// 			RegistrarEstudiantes() : agregar informacion de alumnos (dni, nombre, carrera, ciclo)
	//			ActualizarEstudiantes() : editar informacion ya registrada
	// 			BuscarEstudiantes() : por ID o nombre, para mostrar información relevante
	//
	// 		GestionCursos() : contiene las funciones:
	// 			RegistrarCursos() : agregar cursos (código, nombre, créditos, cupos máximos)
	// 			ActualizarCursos() : editar información ya registrada
	// 			MostrarCursos() : mostrar lista de cursos disponibles por carrera o por ciclo
	//
	// 		ProcesoMatricula() : contiene las funciones:
	// 			MatricularEstudianteEnCurso() : Agregar estudiante a ciertos cursos acorde a su ciclo y carrera
	// 			VerificarMatricula() : Verificar prerequisitos y conflictos horarios 
	// 			GenerarBoletaMatricula() : con costo total
	//
	//		GestiónPagos() : contiene las funciones:
	// 			RegistrarPagos() : de matrícula
	// 			CalcularDscto() : por pronto pago o becas.
	//
	// 		ReportesAcademicos() : contiene las funciones:
	//			GenerarReporteEstudiante() : por estudiante, ingresando dni.
	//			EstadísticasMatrícula(): por curso o por carrera
	//
	// 		SalirPrograma()
	
	MenuPrincipal
FinAlgoritmo
