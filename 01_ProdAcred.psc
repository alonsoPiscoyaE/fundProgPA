
Funcion MenuPrincipal
	Escribir "Bienvenido a blablabla."
	Escribir "1. Gesti�n de Estudiantes."
	Escribir "2. Gesti�n de Cursos."
	Escribir "3. Proceso de matr�cula."
	Escribir "4. Gesti�n de Pagos."
	Escribir "5. Reportes Acad�micos."
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
			Escribir "No se ingres� una opci�n correcta."
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
	Escribir "1 = S�"
	Escribir "0 = No"
	Leer retornoSalirPrograma
FinFuncion



Algoritmo ProdAcred
	Definir verifSalirPrograma Como Entero
	verifSalirPrograma = 0
	// Sistema de gesti�n de matr�culas universitarias
	// Se deben usar las funciones:
	// 
	// Funcion MenuPrincipal(): ejecutada al iniciar el programa y al terminar una funci�n de nivel 1 (FN1),
	//			Puede indicar en ejecutar una funci�n de siguiente nivel, o salir del programa.
	//
	// 		GestionEstudiantes() : contiene las funciones:
	// 			RegistrarEstudiantes() : agregar informacion de alumnos (dni, nombre, carrera, ciclo)
	//			ActualizarEstudiantes() : editar informacion ya registrada
	// 			BuscarEstudiantes() : por ID o nombre, para mostrar informaci�n relevante
	//
	// 		GestionCursos() : contiene las funciones:
	// 			RegistrarCursos() : agregar cursos (c�digo, nombre, cr�ditos, cupos m�ximos)
	// 			ActualizarCursos() : editar informaci�n ya registrada
	// 			MostrarCursos() : mostrar lista de cursos disponibles por carrera o por ciclo
	//
	// 		ProcesoMatricula() : contiene las funciones:
	// 			MatricularEstudianteEnCurso() : Agregar estudiante a ciertos cursos acorde a su ciclo y carrera
	// 			VerificarMatricula() : Verificar prerequisitos y conflictos horarios 
	// 			GenerarBoletaMatricula() : con costo total
	//
	//		Gesti�nPagos() : contiene las funciones:
	// 			RegistrarPagos() : de matr�cula
	// 			CalcularDscto() : por pronto pago o becas.
	//
	// 		ReportesAcademicos() : contiene las funciones:
	//			GenerarReporteEstudiante() : por estudiante, ingresando dni.
	//			Estad�sticasMatr�cula(): por curso o por carrera
	//
	// 		SalirPrograma()
	
	MenuPrincipal
FinAlgoritmo
