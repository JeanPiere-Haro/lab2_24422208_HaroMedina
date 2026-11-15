:- module(plataforma_24422208_HaroMedina, [
    plataforma/5
    ]).

:- use_module(tarea_24422208_HaroMedina).
:- use_module(agente_24422208_HaroMedina).

% RF05 TDA Plataforma
% Descripción: Relaciona agentes,tareas,máximo de ciclos y semillas con la plataforma. Las tareas quedan en la cola, y la plataforma guarda el ciclo actual y el historial.
% Dom: Agentes(lista de agentes) X Tareas(lista de tareas) X MaxCiclos(int mayor que 0) X Seed(int mayor que 0) 
% Rec: Plataforma(plataforma)
% Estrategia: No aplica

plataforma(Agentes,Tareas,MaxCiclos,Seed,[Agentes,TareasOrdenadas,MaxCiclos,Seed,0,[]]):-
    paresPrioridad(Tareas,Pares),
    keysort(Pares,ParesOrdenados),
    extraerTareas(ParesOrdenados,TareasOrdenadas).


%SELECTORES

% Descripción: relaciona una plataforma con su lista de agentes.
% Dom: Plataforma(plataforma)
% Rec: Agentes(lista)
% Estrategia: No aplica
plataformaAgentes([Agentes | _],Agentes).


% Descripción: relaciona una plataforma con su cola de tareas.
% Dom: Plataforma(plataforma)
% Rec: Tareas(lista)
% Estrategia: No aplica
plataformaTareas([_, Tareas | _ ],Tareas).


% Descripción: relaciona una plataforma con su cantidad máxima de ciclos.
% Dom: Plataforma(plataforma)
% Rec: MaxCiclos(int)
% Estrategia: No aplica
plataformaMaxCiclos([_,_,MaxCiclos | _ ],MaxCiclos).

% Descripción: relaciona una plataforma con su seed.
% Dom: Plataforma(plataforma)
% Rec: Seed(int)
% Estrategia: No aplica
plataformaSeed([_,_,_,Seed | _ ],Seed).

% Descripción: relaciona una plataforma con su ciclo actual.
% Dom: Plataforma(plataforma)
% Rec: CicloActual(int)
% Estrategia: No aplica
plataformaCicloActual([_,_,_,_,CicloActual | _ ],CicloActual).

% Descripción: relaciona una plataforma con su historial.
% Dom: Plataforma(plataforma)
% Rec: Historial(lista de strings)
% Estrategia: No aplica
plataformaHistorial([_,_,_,_,_,Historial],Historial).






%Funciones auxiliares

% Descripción: Crea una lista de pares en formato tarea-prioridad
% Dom: Tareas(Lista)
% Rec: Pares(Lista)
% Estrategia: Recursión natural

%Caso base
paresPrioridad([],[]).

%Caso recursivo
paresPrioridad([Tarea | T], [P-Tarea | Resto]):-
    tareaPrioridad(Tarea,P),
    paresPrioridad(T,Resto).


% Descripción: Extrae una lista de tareas de una lista de pares de formato Prioridad-Tarea
% Dom: Pares(Lista)
% Rec: Tareas(Lista)
% Estrategia: Recursión natural

%Caso base
extraerTareas([],[]).

%Caso recursivo
extraerTareas([_-T | Resto], [T| Resto2 ]):-
    extraerTareas(Resto,Resto2).


% Descripción: Extrae una lista de tareas de una lista de pares de formato Prioridad-Tarea.
% Dom: Pares(Lista)
% Rec: Tareas(Lista)
% Estrategia: Recursión natural

buscarAgente(Id, [Agente | _],Agente):-
    agenteId(Agente,Id).

buscarAgente(Id, [_ | Resto],Agente):-
    buscarAgente(Id,Resto,Agente).


%Nota para informe: Se decidió crear la siguiente funcion auxiliar para agilizar el proceso de modificar un agente en especifico(RF06), y por si hiciese falta en otros requisitos mas adelante.

% Descripción: Reemplaza un elemento de una lista por un nuevo elemento
% Dom: Viejo(término) X Nuevo(término) X ListaVieja(lista)
% Rec: ListaNueva(lista)
% Estrategia: Recursión natural

% Caso Base
reemplazarElemento(Viejo,Nuevo,[Viejo | Resto],[Nuevo | Resto]) :- !.

% Caso recursivo
reemplazarElemento(Viejo,Nuevo,[Elemento | Resto],[Elemento | Resto2]):-
    reemplazarElemento(Viejo,Nuevo,Resto,Resto2).



% Requisitos Funcionales (RF06-RF17)

% RF06 Vinculación de agentes
% Descripción: Relaciona la plataforma con otra en que el agente IdSupervisor supervisa al agente IdSubordinado. El vinculo existe en PlataformaSalida y en las plataformas que se obtienen de ella.
% Dom: Plataforma(plataforma) X IdSupervisor(int) X IdSubordinado(int)
% Rec: PlataformaSalida(plataforma)
% Estrategia: Recursión natural
vincularAgentes(Plataforma,IdSupervisor,IdSubordinado,PlataformaSalida):-
    plataformaAgentes(Plataforma,Agentes),

    %Verificacion de condiciones
    buscarAgente(IdSupervisor,Agentes,Supervisor),
    buscarAgente(IdSubordinado,Agentes,Subordinado),

    agenteRol(Supervisor,RolSupervisor),
    RolSupervisor = orquestador,

    agenteRol(Subordinado,RolSubordinado),
    RolSubordinado \= orquestador,

    agenteSupervisor(Subordinado, SupervisorAsignado),
    SupervisorAsignado = [],

    %Modificacion de subordinado y supervisor
    Subordinado = [IdSub,NombreSub,RolSub,HerramientasSub,TokensInicialesSub,TokensActualesSub,VentanaSub,EstadoSub,[],SubordinadosSub,MemoriaSub],
    NuevoSubordinado = [IdSub,NombreSub,RolSub,HerramientasSub,TokensInicialesSub,TokensActualesSub,VentanaSub,EstadoSub,IdSupervisor,SubordinadosSub,MemoriaSub],

    Supervisor = [IdSup,NombreSup,RolSup,HerramientasSup,TokensInicialesSup,TokensActualesSup,VentanaSup,EstadoSup,SupervisorSup,SubordinadosSup,MemoriaSup],
    append(SubordinadosSup,[IdSubordinado],NuevoSubordinadosSup),
    NuevoSupervisor = [IdSup,NombreSup,RolSup,HerramientasSup,TokensInicialesSup,TokensActualesSup,VentanaSup,EstadoSup,SupervisorSup,NuevoSubordinadosSup,MemoriaSup],

    %Modificacion de lista de agentes
    reemplazarElemento(Subordinado,NuevoSubordinado,Agentes,AgentesNuevos),
    reemplazarElemento(Supervisor,NuevoSupervisor,AgentesNuevos,AgentesFinales),

    %Modificacion del historial
    plataformaCicloActual(Plataforma,CicloActual),
    format(string(EventoNuevo),"ciclo ~w: ~w supervisa a ~w",[CicloActual,NombreSup,NombreSub]),

    %ModificarPlataforma
    Plataforma = [_,TareasPlat,MaxCiclosPlat,SeedPlat,CicloActualPlat,HistorialPlat],
    append(HistorialPlat,[EventoNuevo],NuevoHistorialPlat),
    PlataformaSalida = [AgentesFinales,TareasPlat,MaxCiclosPlat,SeedPlat,CicloActualPlat,NuevoHistorialPlat].