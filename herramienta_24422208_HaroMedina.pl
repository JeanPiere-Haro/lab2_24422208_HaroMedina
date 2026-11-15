:- module(herramienta_24422208_HaroMedina, [
    herramienta/5, herramientaNombre/2, herramientaRol/2,
    herramientaCosto/2, herramientaPredicado/2
    ]).


%TDA Herramienta
% Descripción: 
% Dom: Nombre(string) X Rol(átomo de roles) X Costo(int mayor que 0) X Predicado(átomo,nombre de un predicado de aridad 2)
% Rec: Herramienta (herramienta)
% Estrategia: No aplica
herramienta(Nombre,Rol,Costo,Predicado,[Nombre,Rol,Costo,Predicado]).

% SELECTORES

% Descripción:
% Dom: Herramienta(herramienta)
% Rec: Nombre(string)
% Estrategia: No aplica
herramientaNombre([Nombre, _, _, _], Nombre).


% Descripción:
% Dom: Herramienta(herramienta)
% Rec: Rol(átomo de roles)
% Estrategia: No aplica
herramientaRol([_, Rol, _, _],Rol).

% Descripción:
% Dom: Herramienta(herramienta)
% Rec: Costo(int mayor que 0)
% Estrategia: No aplica
herramientaCosto([_, _, Costo, _], Costo).

% Descripción:
% Dom: Herramienta(herramienta)
% Rec: Predicado(átomo,nombre de un predicado de aridad 2)
% Estrategia: No aplica
herramientaPredicado([_, _, _, Predicado], Predicado).