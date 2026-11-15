:- module(agente_24422208_HaroMedina, [
    agente/7, agenteId/2,agenteNombre/2,agenteRol/2,agenteHerramientas/2,agenteTokensIniciales/2,
    agenteTokensActuales/2,agenteVentana/2,agenteEstado/2,agenteSupervisor/2,agenteSubordinados/2,
    agenteMemoria/2
    ]).




%TDA Agente
% Descripción: Enlista los datos de un agente en una lista.
% Dom: Id(int mayor que 0) X Nombre(string) X Rol(átomo de roles) X Herramientas(lista de herramientas) X Tokens(int mayor o igual que 0) X Ventana(int mayor que 0)
% Rec: Agente(agente)
% Estrategia: No aplica

%Caso estado agotado
agente(Id,Nombre,Rol,Herramientas,0,Ventana,[Id,Nombre,Rol,Herramientas,0,0,Ventana,agotado,[],[],[]]).

%Caso estado disponible
agente(Id,Nombre,Rol,Herramientas,Tokens,Ventana,[Id,Nombre,Rol,Herramientas,Tokens,Tokens,Ventana,disponible,[],[],[]]):-
    Tokens > 0.

%SELECTORES

% Descripción:
% Dom: Agente(agente)
% Rec: Id(int)
% Estrategia: No aplica
agenteId([Id | _ ],Id).


% Descripción:
% Dom: Agente(agente)
% Rec: Nombre(string)
% Estrategia: No aplica
agenteNombre([_,Nombre | _ ],Nombre).


% Descripción:
% Dom: Agente(agente)
% Rec: Rol(átomo de roles)
% Estrategia: No aplica
agenteRol([_,_,Rol | _ ],Rol).

% Descripción:
% Dom: Agente(agente)
% Rec: Herramientas(lista de herramientas)
% Estrategia: No aplica
agenteHerramientas([_,_,_,Herramientas | _],Herramientas).


% Descripción:
% Dom: Agente(agente)
% Rec: TokensIniciales(int)
% Estrategia: No aplica
agenteTokensIniciales([_,_,_,_,TokensIniciales | _ ],TokensIniciales).

% Descripción:
% Dom: Agente(agente)
% Rec: TokensActuales(int)
% Estrategia: No aplica
agenteTokensActuales([_,_,_,_,_,TokensActuales | _ ],TokensActuales).

% Descripción:
% Dom: Agente(agente)
% Rec: Ventana(int)
% Estrategia: No aplica
agenteVentana([_,_,_,_,_,_,Ventana | _ ],Ventana).

% Descripción:
% Dom: Agente(agente)
% Rec: Estado(átomo)
% Estrategia: No aplica
agenteEstado([_,_,_,_,_,_,_,Estado | _ ],Estado).

% Descripción:
% Dom: Agente(agente)
% Rec: Supervisor(int)
% Estrategia: No aplica
agenteSupervisor([_,_,_,_,_,_,_,_,Supervisor | _ ],Supervisor).

% Descripción:
% Dom: Agente(agente)
% Rec: Subordinados(lista)
% Estrategia: No aplica
agenteSubordinados([_,_,_,_,_,_,_,_,_,Subordinados | _],Subordinados).

% Descripción:
% Dom: Agente(agente)
% Rec: Memoria(lista)
% Estrategia: No aplica
agenteMemoria([_,_,_,_,_,_,_,_,_,_,Memoria],Memoria).