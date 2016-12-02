unit TestObj.SSI.MBRef;
{

  Delphi DUnit Test Case
  ----------------------
  This unit contains a skeleton test case class generated by the Test Case Wizard.
  Modify the generated code to correctly setup and call the methods from the unit 
  being tested.

}

interface

uses
  TestFramework, Obj.SSI.MBRef, Obj.SSI.IString, Delphi.Mocks;

type
  // Test methods for class TMBRef

  TestTMBRef = class(TTestCase)
  strict private
    FMBRef: IMBReference;
    MockEntidade: TMock<IString>;
    MockSubEnt: TMock<IString>;
    MockID: TMock<IString>;
    MockValor: TMock<IString>;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestGenerate;
  end;
  // Test methods for class TMBRefFactory

  TestTMBRefFactory = class(TTestCase)
  strict private
    FMBRefFactory: IString;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestAsString;
  end;

implementation

procedure TestTMBRef.SetUp;
begin
     MockEntidade := TMock<IString>.Create;
     MockSubEnt   := TMock<IString>.Create;
     MockID       := TMock<IString>.Create;
     MockValor    := TMock<IString>.Create;
     MockEntidade.Setup.WillReturn('11604').When.AsString;
     MockSubEnt.Setup.WillReturn('999').When.AsString;
     MockID.Setup.WillReturn('1234').When.AsString;
     MockValor.Setup.WillReturn('00002586').When.AsString;

     FMBRef := TMBRef.New(MockEntidade, MockSubEnt, MockID, MockValor);
end;

procedure TestTMBRef.TearDown;
begin
  FMBRef := nil;
end;

procedure TestTMBRef.TestGenerate;
var
  ReturnValue: IMBReference;
begin
  ReturnValue := FMBRef.Generate;
  CheckEquals('999123490', ReturnValue.AsString);
end;

procedure TestTMBRefFactory.SetUp;
begin
  FMBRefFactory := TMBRefFactory.New('11604', '999', '1234', '25.86');
end;

procedure TestTMBRefFactory.TearDown;
begin
  FMBRefFactory := nil;
end;

procedure TestTMBRefFactory.TestAsString;
var
  ReturnValue: string;
begin
  ReturnValue := FMBRefFactory.AsString;
  CheckEquals('999123490', ReturnValue);
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTMBRef.Suite);
  RegisterTest(TestTMBRefFactory.Suite);
end.

