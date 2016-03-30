unit Obj.VCL.IButton;

interface

uses
    Obj.SSI.GenericIntf, Controls, VCL.StdCtrls;

type
    TNotifyReference = Reference to procedure (Sender: TObject);
    
    I<T> = Interface (Obj.SSI.GenericIntf.I<T>) ['{6B665225-2600-4611-A4C5-41B95FE6AA39}']
      function Click(ButtonClick: TNotifyReference): I<TButton>;
    End;
    
    TIButton = Class(TButton, I<TButton>)
    private
      FClick: TNotifyReference;
      procedure ButtonClick(Sender: TObject);
    public
      constructor Create; Overload;
      class function New(Parent: TWinControl; Caption: TCaption; Left, Top: Integer): I<TButton>;
      function Obj: TButton;
      function Click(ButtonClick: TNotifyReference): I<TButton>;
    End;

implementation

{ TLabel }

procedure TIButton.ButtonClick(Sender: TObject);
begin
     FClick(Sender);
end;

function TIButton.Click(ButtonClick: TNotifyReference): I<TButton>;
begin
     FClick := ButtonClick;
     Result := Self;
end;

constructor TIButton.Create;
begin
     inherited Create(nil);
     Self.OnClick := ButtonClick;
end;

class function TIButton.New(Parent: TWinControl; Caption: TCaption; Left, Top: Integer): I<TButton>;
begin
     Result             := Create;
     Result.Obj.Parent  := Parent;
     Result.Obj.Caption := Caption;
     Result.Obj.Left    := Left;
     Result.Obj.Top     := Top;
end;

function TIButton.Obj: TButton;
begin
     Result := Self;
end;

end.