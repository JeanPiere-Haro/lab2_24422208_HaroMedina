:- module(tarea_24422208_HaroMedina, [
    tarea/8, tareaId/2, tareaDescripcion/2, tareaRol/2,
    tareaHerramienta/2, tareaDatos/2, tareaComplejidad/2,
    tareaPrioridad/2, tareaEstado/2, tareaAgente/2,tareaResultado/2
    ]).


%TDA Tarea
% Descripción:
% Dom: Id(int mayor que 0) X Descripcion(string) X Rol(átomo de roles) X Herramienta(string) X Datos(término) X Complejidad(int mayor que 0) X Prioridad(int entre 1 y 5)
% Rec: Tarea(tarea)
% Estrategia: No aplica
tarea(Id,Descripcion,Rol,Herramienta,Datos,Complejidad,Prioridad,[Id,Descripcion,Rol,Herramienta,Datos,Complejidad,Prioridad,pendiente, [], []]).


%SELECTORES

% Descripción:
% Dom: Tarea(tarea)
% Rec: Id(int mayor que 0)
% Estrategia: No aplica
tareaId([Id | _], Id).

% Descripción:
% Dom: Tarea(tarea)
% Rec: Descripcion(string)
% Estrategia: No aplica
tareaDescripcion([_ , Descripcion | _ ],Descripcion).


% Descripción:
% Dom: Tarea(tarea)
% Rec: Rol(átomo de roles)
% Estrategia: No aplica
tareaRol([_,_,Rol | _ ],Rol).


% Descripción:
% Dom: Tarea(tarea)
% Rec: Herramienta(string)
% Estrategia: No aplica
tareaHerramienta([_,_,_,Herramienta | _],Herramienta).

% Descripción:
% Dom: Tarea(tarea)
% Rec: Datos(término)
% Estrategia: No aplica
tareaDatos([_,_,_,_,Datos | _ ],Datos).

% Descripción:
% Dom: Tarea(tarea)
% Rec: Complejidad(int mayor que 0)
% Estrategia: No aplica
tareaComplejidad([_,_,_,_,_,Complejidad | _ ],Complejidad).

% Descripción:
% Dom: Tarea(tarea)
% Rec: Prioridad(int entre 1 y 5)
% Estrategia: No aplica
tareaPrioridad([_,_,_,_,_,_,Prioridad | _],Prioridad).

% Descripción:
% Dom: Tarea(tarea)
% Rec: Estado()
% Estrategia: No aplica
tareaEstado([_,_,_,_,_,_,_,Estado | _],Estado).

% Descripción:
% Dom: Tarea(tarea)
% Rec: Agente(int)
% Estrategia: No aplica
tareaAgente([_,_,_,_,_,_,_,_,Agente | _],Agente).

% Descripción:
% Dom: Tarea(tarea)
% Rec: Resultado(término)
% Estrategia: No aplica
tareaResultado([_,_,_,_,_,_,_,_,_,Resultado],Resultado).