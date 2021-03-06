unit TestObj.SSI.IString;
{

  Delphi DUnit Test Case
  ----------------------
  This unit contains a skeleton test case class generated by the Test Case Wizard.
  Modify the generated code to correctly setup and call the methods from the unit 
  being tested.

}

interface

uses
  TestFramework, Obj.SSI.IString, Delphi.Mocks;

type
  // Test methods for class TString

  TestTString = class(TTestCase)
  strict private
    FString: IString;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestAsString;
  end;
  // Test methods for class TNumbersOnly

  TestTNumbersOnly = class(TTestCase)
  strict private
    FNumbersOnly: IString;
    FNumbersOnlyDoom: IString;
    Mock: TMock<IString>;
    MockDoom: TMock<IString>;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestAsString;
    procedure TestAsStringDoom;
  end;
  // Test methods for class TPadded

  TestTPadded = class(TTestCase)
  strict private
    FPaddedLeft: IString;
    FPaddedRight: IString;
    FPaddedLarger: IString;
    Mock: TMock<IString>;
    MockLarger: TMock<IString>;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestAsStringLeft;
    procedure TestAsStringRight;
    procedure TestAsStringLarger;
  end;
  // Test methods for class TGroupDigits

  TestTGroupDigits = class(TTestCase)
  strict private
    FGroupDigits: IString;
    Mock: TMock<IString>;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestAsString;
  end;

implementation

procedure TestTString.SetUp;
begin
     FString := TString.New('xpto');
end;

procedure TestTString.TearDown;
begin
     FString := nil;
end;

procedure TestTString.TestAsString;
var
   ReturnValue: string;
begin
     ReturnValue := FString.AsString;
     CheckEquals('xpto', ReturnValue);
end;

procedure TestTNumbersOnly.SetUp;
begin
     Mock             := TMock<IString>.Create;
     MockDoom         := TMock<IString>.Create;
     Mock.Setup.WillReturn('xpto123').When.AsString;
     MockDoom.Setup.WillReturn('xpto').When.AsString;
     FNumbersOnly     := TNumbersOnly.New(Mock);
     FNumbersOnlyDoom := TNumbersOnly.New(MockDoom);
end;

procedure TestTNumbersOnly.TearDown;
begin
     FNumbersOnly := nil;
end;

procedure TestTNumbersOnly.TestAsString;
var
   ReturnValue: string;
begin
     ReturnValue := FNumbersOnly.AsString;
     CheckEquals('123', ReturnValue);
end;

procedure TestTNumbersOnly.TestAsStringDoom;
var
   ReturnValue: string;
begin
     ReturnValue := FNumbersOnlyDoom.AsString;
     CheckEquals('', ReturnValue);
end;

procedure TestTPadded.SetUp;
begin
     Mock          := TMock<IString>.Create;
     MockLarger    := TMock<IString>.Create;
     Mock.Setup.WillReturn('123').When.AsString;
     MockLarger.Setup.WillReturn('ABCDEFGH').When.AsString;
     FPaddedLeft   := TPadded.New(Mock, 5, '0', psLeft);
     FPaddedRight  := TPadded.New(Mock, 5, '!', psRight);
     FPaddedLarger := TPadded.New(MockLarger, 5, '0', psLeft);
end;

procedure TestTPadded.TearDown;
begin
     FPaddedLeft   := nil;
     FPaddedRight  := nil;
     FPaddedLarger := nil;
end;

procedure TestTPadded.TestAsStringLeft;
var
   ReturnValue: string;
begin
     ReturnValue := FPaddedLeft.AsString;
     CheckEquals('00123', ReturnValue);
end;

procedure TestTPadded.TestAsStringRight;
var
   ReturnValue: string;
begin
     ReturnValue := FPaddedRight.AsString;
     CheckEquals('123!!', ReturnValue);
end;

procedure TestTPadded.TestAsStringLarger;
var
   ReturnValue: string;
begin
     ReturnValue := FPaddedLarger.AsString;
     CheckEquals('ABCDE', ReturnValue);
end;

procedure TestTGroupDigits.SetUp;
begin
     Mock := TMock<IString>.Create;
     Mock.Setup.WillReturn('0123456789').When.AsString;
     FGroupDigits := TGroupDigits.New(Mock, 3);
end;

procedure TestTGroupDigits.TearDown;
begin
     FGroupDigits := nil;
end;

procedure TestTGroupDigits.TestAsString;
var
   ReturnValue: string;
begin
     ReturnValue := FGroupDigits.AsString;
     CheckEquals('0 123 456 789', ReturnValue);
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTString.Suite);
  RegisterTest(TestTNumbersOnly.Suite);
  RegisterTest(TestTPadded.Suite);
  RegisterTest(TestTGroupDigits.Suite);
end.

