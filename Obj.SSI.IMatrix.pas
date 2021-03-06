(******************************************************************************)
(** Suite         : Reusable Objects                                         **)
(** Object        : IMatrix                                                  **)
(** Framework     :                                                          **)
(** Developed by  : Nuno Picado                                              **)
(******************************************************************************)
(** Interfaces    : IMatrix                                                  **)
(** Classes       : TMatrix, implements IMatrix                              **)
(******************************************************************************)
(** Dependencies  : RTL                                                      **)
(******************************************************************************)
(** Description   : Generic Bidimensional List of items                      **)
(******************************************************************************)
(** Licence       : GNU LGPLv3 (http://www.gnu.org/licenses/lgpl-3.0.html)   **)
(** Contributions : You can create pull request for all your desired         **)
(**                 contributions as long as they comply with the guidelines **)
(**                 you can find in the readme.md file in the main directory **)
(**                 of the Reusable Objects repository                       **)
(** Disclaimer    : The licence agreement applies to the code in this unit   **)
(**                 and not to any of its dependencies, which have their own **)
(**                 licence agreement and to which you must comply in their  **)
(**                 terms                                                    **)
(******************************************************************************)

unit Obj.SSI.IMatrix;

interface

type
    IMatrix<T> = Interface
    ['{3769B3FE-376D-4430-9652-48E6BF85A9CA}']
      function Cell(Col, Row: LongInt): T;
      function Edit(Col, Row: LongInt; Value: T): IMatrix<T>;
      function ColCount: Integer;
      function RowCount: Integer;
      function Resize(ColCount, RowCount: LongInt): IMatrix<T>;
    End;

    TMatrix<T> = Class(TInterfacedObject, IMatrix<T>)
    private
      FMatrix: Array of Array of T;
      constructor Create(ColCount, RowCount: Word);
    public
      class function New: IMatrix<T>; Overload;
      class function New(ColCount, RowCount: Word): IMatrix<T>; Overload;
      function Cell(Col, Row: LongInt): T;
      function Edit(Col, Row: LongInt; Value: T): IMatrix<T>;
      function ColCount: Integer;
      function RowCount: Integer;
      function Resize(ColCount, RowCount: LongInt): IMatrix<T>;
    End;

implementation

uses
    SysUtils
  ;

{ TStringMatrix }

function TMatrix<T>.Cell(Col, Row: Integer): T;
begin
     Result := FMatrix[Col][Row];
end;

function TMatrix<T>.ColCount: Integer;
begin
     Result := Length(FMatrix);
end;

constructor TMatrix<T>.Create(ColCount, RowCount: Word);
var
   i: LongInt;
begin
     SetLength(FMatrix, ColCount);
     for i := Low(FMatrix) to High(FMatrix) do
         SetLength(FMatrix[i], RowCount);
end;

function TMatrix<T>.Edit(Col, Row: Integer; Value: T): IMatrix<T>;
begin
     Result            := Self;
     FMatrix[Col][Row] := Value;
end;

class function TMatrix<T>.New: IMatrix<T>;
begin
     Result := Create(1, 1);
end;

class function TMatrix<T>.New(ColCount, RowCount: Word): IMatrix<T>;
begin
     if (ColCount<1) or (RowCount<1)
        then raise Exception.Create('Cannot have a matrix with no cells.');
     Result := Create(ColCount, RowCount);
end;

function TMatrix<T>.Resize(ColCount, RowCount: LongInt): IMatrix<T>;
begin
     Result := New(ColCount, RowCount);
end;

function TMatrix<T>.RowCount: Integer;
begin
     Result := Length(FMatrix[0]);
end;

end.
