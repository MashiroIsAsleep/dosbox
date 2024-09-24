program SnakeGame;

uses
  crt;

const
  MaxLength = 100;
  Up = 1;
  Down = 2;
  Left = 3;
  Right = 4;

type
  Position = record
    x, y: integer;
  end;

var
  Snake: array[1..MaxLength] of Position;
  SnakeLength: integer;
  Food: Position;
  Direction: integer;
  GameOver: boolean;
  Ch: char;

procedure InitializeGame;
var
  i: integer;
begin
  clrscr;
  randomize;
  SnakeLength := 5;
  for i := 1 to SnakeLength do
  begin
    Snake[i].x := 40 - i;
    Snake[i].y := 12;
  end;
  Direction := Right;
  Food.x := random(78) + 1;
  Food.y := random(23) + 1;
  GameOver := False;
end;

procedure DrawSnake;
var
  i: integer;
begin
  gotoxy(Food.x, Food.y);
  write('O');
  for i := 1 to SnakeLength do
  begin
    gotoxy(Snake[i].x, Snake[i].y);
    write('*');
  end;
end;

procedure EraseSnake;
var
  i: integer;
begin
  for i := 1 to SnakeLength do
  begin
    gotoxy(Snake[i].x, Snake[i].y);
    write(' ');
  end;
end;

procedure MoveSnake;
var
  i: integer;
begin
  for i := SnakeLength downto 2 do
  begin
    Snake[i] := Snake[i - 1];
  end;

  case Direction of
    Up: Dec(Snake[1].y);
    Down: Inc(Snake[1].y);
    Left: Dec(Snake[1].x);
    Right: Inc(Snake[1].x);
  end;
end;

procedure CheckCollision;
var
  i: integer;
begin
  if (Snake[1].x < 1) or (Snake[1].x > 80) or
     (Snake[1].y < 1) or (Snake[1].y > 24) then
  begin
    GameOver := True;
  end;

  for i := 2 to SnakeLength do
  begin
    if (Snake[1].x = Snake[i].x) and (Snake[1].y = Snake[i].y) then
    begin
      GameOver := True;
    end;
  end;
end;

procedure CheckFood;
begin
  if (Snake[1].x = Food.x) and (Snake[1].y = Food.y) then
  begin
    Inc(SnakeLength);
    Food.x := random(78) + 1;
    Food.y := random(23) + 1;
  end;
end;

procedure ProcessInput;
begin
  if KeyPressed then
  begin
    Ch := ReadKey;
    case Ch of
      #72: if Direction <> Down then Direction := Up;
      #80: if Direction <> Up then Direction := Down;
      #75: if Direction <> Right then Direction := Left;
      #77: if Direction <> Left then Direction := Right;
    end;
  end;
end;

procedure GameLoop;
begin
  while not GameOver do
  begin
    EraseSnake;
    MoveSnake;
    CheckCollision;
    CheckFood;
    DrawSnake;
    ProcessInput;
    Delay(100);
  end;
end;

begin
  InitializeGame;
  GameLoop;
  clrscr;
  writeln('Game Over!');
  readln;
end.
