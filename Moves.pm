package Chess::PGN::Moves;

use 5.006;
use strict;
use warnings;

require Exporter;

our @ISA = qw(Exporter);
our @EXPORT = qw(
		 %King_Moves
		 %Queen_Moves
		 %Rook_Moves
		 %Bishop_Moves
		 %Knight_Moves
		 %from_algebraic
		 %move_table
		 );
our $VERSION = '0.03';

use vars qw(
	    %King_Moves
	    %Queen_Moves
	    %Rook_Moves
	    %Bishop_Moves
	    %Knight_Moves
	    %from_algebraic
	    %move_table
	    );

%King_Moves = (
a1 => [qw(a2 b2 b1)],
b1 => [qw(a2 b2 c2 a1 c1)],
c1 => [qw(b2 c2 d2 b1 d1)],
d1 => [qw(c2 d2 e2 c1 e1)],
e1 => [qw(d2 e2 f2 d1 f1)],
f1 => [qw(e2 f2 g2 e1 g1)],
g1 => [qw(f2 g2 h2 f1 h1)],
h1 => [qw(g2 h2 g1)],
a2 => [qw(a3 b3 b2 a1 b1)],
b2 => [qw(a3 b3 c3 a2 c2 a1 b1 c1)],
c2 => [qw(b3 c3 d3 b2 d2 b1 c1 d1)],
d2 => [qw(c3 d3 e3 c2 e2 c1 d1 e1)],
e2 => [qw(d3 e3 f3 d2 f2 d1 e1 f1)],
f2 => [qw(e3 f3 g3 e2 g2 e1 f1 g1)],
g2 => [qw(f3 g3 h3 f2 h2 f1 g1 h1)],
h2 => [qw(g3 h3 g2 g1 h1)],
a3 => [qw(a4 b4 b3 a2 b2)],
b3 => [qw(a4 b4 c4 a3 c3 a2 b2 c2)],
c3 => [qw(b4 c4 d4 b3 d3 b2 c2 d2)],
d3 => [qw(c4 d4 e4 c3 e3 c2 d2 e2)],
e3 => [qw(d4 e4 f4 d3 f3 d2 e2 f2)],
f3 => [qw(e4 f4 g4 e3 g3 e2 f2 g2)],
g3 => [qw(f4 g4 h4 f3 h3 f2 g2 h2)],
h3 => [qw(g4 h4 g3 g2 h2)],
a4 => [qw(a5 b5 b4 a3 b3)],
b4 => [qw(a5 b5 c5 a4 c4 a3 b3 c3)],
c4 => [qw(b5 c5 d5 b4 d4 b3 c3 d3)],
d4 => [qw(c5 d5 e5 c4 e4 c3 d3 e3)],
e4 => [qw(d5 e5 f5 d4 f4 d3 e3 f3)],
f4 => [qw(e5 f5 g5 e4 g4 e3 f3 g3)],
g4 => [qw(f5 g5 h5 f4 h4 f3 g3 h3)],
h4 => [qw(g5 h5 g4 g3 h3)],
a5 => [qw(a6 b6 b5 a4 b4)],
b5 => [qw(a6 b6 c6 a5 c5 a4 b4 c4)],
c5 => [qw(b6 c6 d6 b5 d5 b4 c4 d4)],
d5 => [qw(c6 d6 e6 c5 e5 c4 d4 e4)],
e5 => [qw(d6 e6 f6 d5 f5 d4 e4 f4)],
f5 => [qw(e6 f6 g6 e5 g5 e4 f4 g4)],
g5 => [qw(f6 g6 h6 f5 h5 f4 g4 h4)],
h5 => [qw(g6 h6 g5 g4 h4)],
a6 => [qw(a7 b7 b6 a5 b5)],
b6 => [qw(a7 b7 c7 a6 c6 a5 b5 c5)],
c6 => [qw(b7 c7 d7 b6 d6 b5 c5 d5)],
d6 => [qw(c7 d7 e7 c6 e6 c5 d5 e5)],
e6 => [qw(d7 e7 f7 d6 f6 d5 e5 f5)],
f6 => [qw(e7 f7 g7 e6 g6 e5 f5 g5)],
g6 => [qw(f7 g7 h7 f6 h6 f5 g5 h5)],
h6 => [qw(g7 h7 g6 g5 h5)],
a7 => [qw(a8 b8 b7 a6 b6)],
b7 => [qw(a8 b8 c8 a7 c7 a6 b6 c6)],
c7 => [qw(b8 c8 d8 b7 d7 b6 c6 d6)],
d7 => [qw(c8 d8 e8 c7 e7 c6 d6 e6)],
e7 => [qw(d8 e8 f8 d7 f7 d6 e6 f6)],
f7 => [qw(e8 f8 g8 e7 g7 e6 f6 g6)],
g7 => [qw(f8 g8 h8 f7 h7 f6 g6 h6)],
h7 => [qw(g8 h8 g7 g6 h6)],
a8 => [qw(b8 a7 b7)],
b8 => [qw(a8 c8 a7 b7 c7)],
c8 => [qw(b8 d8 b7 c7 d7)],
d8 => [qw(c8 e8 c7 d7 e7)],
e8 => [qw(d8 f8 d7 e7 f7)],
f8 => [qw(e8 g8 e7 f7 g7)],
g8 => [qw(f8 h8 f7 g7 h7)],
h8 => [qw(g8 g7 h7)],
);

%Queen_Moves = (
a1 => [qw(b1 c1 d1 e1 f1 g1 h1 a2 a3 a4 a5 a6 a7 a8 b2 c3 d4 e5 f6 g7 h8)],
b1 => [qw(a1 c1 d1 e1 f1 g1 h1 b2 b3 b4 b5 b6 b7 b8 c2 d3 e4 f5 g6 h7 a2)],
c1 => [qw(a1 b1 d1 e1 f1 g1 h1 c2 c3 c4 c5 c6 c7 c8 d2 e3 f4 g5 h6 b2 a3)],
d1 => [qw(a1 b1 c1 e1 f1 g1 h1 d2 d3 d4 d5 d6 d7 d8 e2 f3 g4 h5 c2 b3 a4)],
e1 => [qw(a1 b1 c1 d1 f1 g1 h1 e2 e3 e4 e5 e6 e7 e8 f2 g3 h4 d2 c3 b4 a5)],
f1 => [qw(a1 b1 c1 d1 e1 g1 h1 f2 f3 f4 f5 f6 f7 f8 g2 h3 e2 d3 c4 b5 a6)],
g1 => [qw(a1 b1 c1 d1 e1 f1 h1 g2 g3 g4 g5 g6 g7 g8 h2 f2 e3 d4 c5 b6 a7)],
h1 => [qw(a1 b1 c1 d1 e1 f1 g1 h2 h3 h4 h5 h6 h7 h8 g2 f3 e4 d5 c6 b7 a8)],
a2 => [qw(b2 c2 d2 e2 f2 g2 h2 a1 a3 a4 a5 a6 a7 a8 b3 c4 d5 e6 f7 g8 b1)],
b2 => [qw(a2 c2 d2 e2 f2 g2 h2 b1 b3 b4 b5 b6 b7 b8 a1 c3 d4 e5 f6 g7 h8 c1 a3)],
c2 => [qw(a2 b2 d2 e2 f2 g2 h2 c1 c3 c4 c5 c6 c7 c8 b1 d3 e4 f5 g6 h7 d1 b3 a4)],
d2 => [qw(a2 b2 c2 e2 f2 g2 h2 d1 d3 d4 d5 d6 d7 d8 c1 e3 f4 g5 h6 e1 c3 b4 a5)],
e2 => [qw(a2 b2 c2 d2 f2 g2 h2 e1 e3 e4 e5 e6 e7 e8 d1 f3 g4 h5 f1 d3 c4 b5 a6)],
f2 => [qw(a2 b2 c2 d2 e2 g2 h2 f1 f3 f4 f5 f6 f7 f8 e1 g3 h4 g1 e3 d4 c5 b6 a7)],
g2 => [qw(a2 b2 c2 d2 e2 f2 h2 g1 g3 g4 g5 g6 g7 g8 f1 h3 h1 f3 e4 d5 c6 b7 a8)],
h2 => [qw(a2 b2 c2 d2 e2 f2 g2 h1 h3 h4 h5 h6 h7 h8 g1 g3 f4 e5 d6 c7 b8)],
a3 => [qw(b3 c3 d3 e3 f3 g3 h3 a1 a2 a4 a5 a6 a7 a8 b4 c5 d6 e7 f8 c1 b2)],
b3 => [qw(a3 c3 d3 e3 f3 g3 h3 b1 b2 b4 b5 b6 b7 b8 a2 c4 d5 e6 f7 g8 d1 c2 a4)],
c3 => [qw(a3 b3 d3 e3 f3 g3 h3 c1 c2 c4 c5 c6 c7 c8 a1 b2 d4 e5 f6 g7 h8 e1 d2 b4 a5)],
d3 => [qw(a3 b3 c3 e3 f3 g3 h3 d1 d2 d4 d5 d6 d7 d8 b1 c2 e4 f5 g6 h7 f1 e2 c4 b5 a6)],
e3 => [qw(a3 b3 c3 d3 f3 g3 h3 e1 e2 e4 e5 e6 e7 e8 c1 d2 f4 g5 h6 g1 f2 d4 c5 b6 a7)],
f3 => [qw(a3 b3 c3 d3 e3 g3 h3 f1 f2 f4 f5 f6 f7 f8 d1 e2 g4 h5 h1 g2 e4 d5 c6 b7 a8)],
g3 => [qw(a3 b3 c3 d3 e3 f3 h3 g1 g2 g4 g5 g6 g7 g8 e1 f2 h4 h2 f4 e5 d6 c7 b8)],
h3 => [qw(a3 b3 c3 d3 e3 f3 g3 h1 h2 h4 h5 h6 h7 h8 f1 g2 g4 f5 e6 d7 c8)],
a4 => [qw(b4 c4 d4 e4 f4 g4 h4 a1 a2 a3 a5 a6 a7 a8 b5 c6 d7 e8 d1 c2 b3)],
b4 => [qw(a4 c4 d4 e4 f4 g4 h4 b1 b2 b3 b5 b6 b7 b8 a3 c5 d6 e7 f8 e1 d2 c3 a5)],
c4 => [qw(a4 b4 d4 e4 f4 g4 h4 c1 c2 c3 c5 c6 c7 c8 a2 b3 d5 e6 f7 g8 f1 e2 d3 b5 a6)],
d4 => [qw(a4 b4 c4 e4 f4 g4 h4 d1 d2 d3 d5 d6 d7 d8 a1 b2 c3 e5 f6 g7 h8 g1 f2 e3 c5 b6 a7)],
e4 => [qw(a4 b4 c4 d4 f4 g4 h4 e1 e2 e3 e5 e6 e7 e8 b1 c2 d3 f5 g6 h7 h1 g2 f3 d5 c6 b7 a8)],
f4 => [qw(a4 b4 c4 d4 e4 g4 h4 f1 f2 f3 f5 f6 f7 f8 c1 d2 e3 g5 h6 h2 g3 e5 d6 c7 b8)],
g4 => [qw(a4 b4 c4 d4 e4 f4 h4 g1 g2 g3 g5 g6 g7 g8 d1 e2 f3 h5 h3 f5 e6 d7 c8)],
h4 => [qw(a4 b4 c4 d4 e4 f4 g4 h1 h2 h3 h5 h6 h7 h8 e1 f2 g3 g5 f6 e7 d8)],
a5 => [qw(b5 c5 d5 e5 f5 g5 h5 a1 a2 a3 a4 a6 a7 a8 b6 c7 d8 e1 d2 c3 b4)],
b5 => [qw(a5 c5 d5 e5 f5 g5 h5 b1 b2 b3 b4 b6 b7 b8 a4 c6 d7 e8 f1 e2 d3 c4 a6)],
c5 => [qw(a5 b5 d5 e5 f5 g5 h5 c1 c2 c3 c4 c6 c7 c8 a3 b4 d6 e7 f8 g1 f2 e3 d4 b6 a7)],
d5 => [qw(a5 b5 c5 e5 f5 g5 h5 d1 d2 d3 d4 d6 d7 d8 a2 b3 c4 e6 f7 g8 h1 g2 f3 e4 c6 b7 a8)],
e5 => [qw(a5 b5 c5 d5 f5 g5 h5 e1 e2 e3 e4 e6 e7 e8 a1 b2 c3 d4 f6 g7 h8 h2 g3 f4 d6 c7 b8)],
f5 => [qw(a5 b5 c5 d5 e5 g5 h5 f1 f2 f3 f4 f6 f7 f8 b1 c2 d3 e4 g6 h7 h3 g4 e6 d7 c8)],
g5 => [qw(a5 b5 c5 d5 e5 f5 h5 g1 g2 g3 g4 g6 g7 g8 c1 d2 e3 f4 h6 h4 f6 e7 d8)],
h5 => [qw(a5 b5 c5 d5 e5 f5 g5 h1 h2 h3 h4 h6 h7 h8 d1 e2 f3 g4 g6 f7 e8)],
a6 => [qw(b6 c6 d6 e6 f6 g6 h6 a1 a2 a3 a4 a5 a7 a8 b7 c8 f1 e2 d3 c4 b5)],
b6 => [qw(a6 c6 d6 e6 f6 g6 h6 b1 b2 b3 b4 b5 b7 b8 a5 c7 d8 g1 f2 e3 d4 c5 a7)],
c6 => [qw(a6 b6 d6 e6 f6 g6 h6 c1 c2 c3 c4 c5 c7 c8 a4 b5 d7 e8 h1 g2 f3 e4 d5 b7 a8)],
d6 => [qw(a6 b6 c6 e6 f6 g6 h6 d1 d2 d3 d4 d5 d7 d8 a3 b4 c5 e7 f8 h2 g3 f4 e5 c7 b8)],
e6 => [qw(a6 b6 c6 d6 f6 g6 h6 e1 e2 e3 e4 e5 e7 e8 a2 b3 c4 d5 f7 g8 h3 g4 f5 d7 c8)],
f6 => [qw(a6 b6 c6 d6 e6 g6 h6 f1 f2 f3 f4 f5 f7 f8 a1 b2 c3 d4 e5 g7 h8 h4 g5 e7 d8)],
g6 => [qw(a6 b6 c6 d6 e6 f6 h6 g1 g2 g3 g4 g5 g7 g8 b1 c2 d3 e4 f5 h7 h5 f7 e8)],
h6 => [qw(a6 b6 c6 d6 e6 f6 g6 h1 h2 h3 h4 h5 h7 h8 c1 d2 e3 f4 g5 g7 f8)],
a7 => [qw(b7 c7 d7 e7 f7 g7 h7 a1 a2 a3 a4 a5 a6 a8 b8 g1 f2 e3 d4 c5 b6)],
b7 => [qw(a7 c7 d7 e7 f7 g7 h7 b1 b2 b3 b4 b5 b6 b8 a6 c8 h1 g2 f3 e4 d5 c6 a8)],
c7 => [qw(a7 b7 d7 e7 f7 g7 h7 c1 c2 c3 c4 c5 c6 c8 a5 b6 d8 h2 g3 f4 e5 d6 b8)],
d7 => [qw(a7 b7 c7 e7 f7 g7 h7 d1 d2 d3 d4 d5 d6 d8 a4 b5 c6 e8 h3 g4 f5 e6 c8)],
e7 => [qw(a7 b7 c7 d7 f7 g7 h7 e1 e2 e3 e4 e5 e6 e8 a3 b4 c5 d6 f8 h4 g5 f6 d8)],
f7 => [qw(a7 b7 c7 d7 e7 g7 h7 f1 f2 f3 f4 f5 f6 f8 a2 b3 c4 d5 e6 g8 h5 g6 e8)],
g7 => [qw(a7 b7 c7 d7 e7 f7 h7 g1 g2 g3 g4 g5 g6 g8 a1 b2 c3 d4 e5 f6 h8 h6 f8)],
h7 => [qw(a7 b7 c7 d7 e7 f7 g7 h1 h2 h3 h4 h5 h6 h8 b1 c2 d3 e4 f5 g6 g8)],
a8 => [qw(b8 c8 d8 e8 f8 g8 h8 a1 a2 a3 a4 a5 a6 a7 h1 g2 f3 e4 d5 c6 b7)],
b8 => [qw(a8 c8 d8 e8 f8 g8 h8 b1 b2 b3 b4 b5 b6 b7 a7 h2 g3 f4 e5 d6 c7)],
c8 => [qw(a8 b8 d8 e8 f8 g8 h8 c1 c2 c3 c4 c5 c6 c7 a6 b7 h3 g4 f5 e6 d7)],
d8 => [qw(a8 b8 c8 e8 f8 g8 h8 d1 d2 d3 d4 d5 d6 d7 a5 b6 c7 h4 g5 f6 e7)],
e8 => [qw(a8 b8 c8 d8 f8 g8 h8 e1 e2 e3 e4 e5 e6 e7 a4 b5 c6 d7 h5 g6 f7)],
f8 => [qw(a8 b8 c8 d8 e8 g8 h8 f1 f2 f3 f4 f5 f6 f7 a3 b4 c5 d6 e7 h6 g7)],
g8 => [qw(a8 b8 c8 d8 e8 f8 h8 g1 g2 g3 g4 g5 g6 g7 a2 b3 c4 d5 e6 f7 h7)],
h8 => [qw(a8 b8 c8 d8 e8 f8 g8 h1 h2 h3 h4 h5 h6 h7 a1 b2 c3 d4 e5 f6 g7)],
);

%Rook_Moves = (
a1 => [qw(b1 c1 d1 e1 f1 g1 h1 a2 a3 a4 a5 a6 a7 a8)],
b1 => [qw(a1 c1 d1 e1 f1 g1 h1 b2 b3 b4 b5 b6 b7 b8)],
c1 => [qw(a1 b1 d1 e1 f1 g1 h1 c2 c3 c4 c5 c6 c7 c8)],
d1 => [qw(a1 b1 c1 e1 f1 g1 h1 d2 d3 d4 d5 d6 d7 d8)],
e1 => [qw(a1 b1 c1 d1 f1 g1 h1 e2 e3 e4 e5 e6 e7 e8)],
f1 => [qw(a1 b1 c1 d1 e1 g1 h1 f2 f3 f4 f5 f6 f7 f8)],
g1 => [qw(a1 b1 c1 d1 e1 f1 h1 g2 g3 g4 g5 g6 g7 g8)],
h1 => [qw(a1 b1 c1 d1 e1 f1 g1 h2 h3 h4 h5 h6 h7 h8)],
a2 => [qw(b2 c2 d2 e2 f2 g2 h2 a1 a3 a4 a5 a6 a7 a8)],
b2 => [qw(a2 c2 d2 e2 f2 g2 h2 b1 b3 b4 b5 b6 b7 b8)],
c2 => [qw(a2 b2 d2 e2 f2 g2 h2 c1 c3 c4 c5 c6 c7 c8)],
d2 => [qw(a2 b2 c2 e2 f2 g2 h2 d1 d3 d4 d5 d6 d7 d8)],
e2 => [qw(a2 b2 c2 d2 f2 g2 h2 e1 e3 e4 e5 e6 e7 e8)],
f2 => [qw(a2 b2 c2 d2 e2 g2 h2 f1 f3 f4 f5 f6 f7 f8)],
g2 => [qw(a2 b2 c2 d2 e2 f2 h2 g1 g3 g4 g5 g6 g7 g8)],
h2 => [qw(a2 b2 c2 d2 e2 f2 g2 h1 h3 h4 h5 h6 h7 h8)],
a3 => [qw(b3 c3 d3 e3 f3 g3 h3 a1 a2 a4 a5 a6 a7 a8)],
b3 => [qw(a3 c3 d3 e3 f3 g3 h3 b1 b2 b4 b5 b6 b7 b8)],
c3 => [qw(a3 b3 d3 e3 f3 g3 h3 c1 c2 c4 c5 c6 c7 c8)],
d3 => [qw(a3 b3 c3 e3 f3 g3 h3 d1 d2 d4 d5 d6 d7 d8)],
e3 => [qw(a3 b3 c3 d3 f3 g3 h3 e1 e2 e4 e5 e6 e7 e8)],
f3 => [qw(a3 b3 c3 d3 e3 g3 h3 f1 f2 f4 f5 f6 f7 f8)],
g3 => [qw(a3 b3 c3 d3 e3 f3 h3 g1 g2 g4 g5 g6 g7 g8)],
h3 => [qw(a3 b3 c3 d3 e3 f3 g3 h1 h2 h4 h5 h6 h7 h8)],
a4 => [qw(b4 c4 d4 e4 f4 g4 h4 a1 a2 a3 a5 a6 a7 a8)],
b4 => [qw(a4 c4 d4 e4 f4 g4 h4 b1 b2 b3 b5 b6 b7 b8)],
c4 => [qw(a4 b4 d4 e4 f4 g4 h4 c1 c2 c3 c5 c6 c7 c8)],
d4 => [qw(a4 b4 c4 e4 f4 g4 h4 d1 d2 d3 d5 d6 d7 d8)],
e4 => [qw(a4 b4 c4 d4 f4 g4 h4 e1 e2 e3 e5 e6 e7 e8)],
f4 => [qw(a4 b4 c4 d4 e4 g4 h4 f1 f2 f3 f5 f6 f7 f8)],
g4 => [qw(a4 b4 c4 d4 e4 f4 h4 g1 g2 g3 g5 g6 g7 g8)],
h4 => [qw(a4 b4 c4 d4 e4 f4 g4 h1 h2 h3 h5 h6 h7 h8)],
a5 => [qw(b5 c5 d5 e5 f5 g5 h5 a1 a2 a3 a4 a6 a7 a8)],
b5 => [qw(a5 c5 d5 e5 f5 g5 h5 b1 b2 b3 b4 b6 b7 b8)],
c5 => [qw(a5 b5 d5 e5 f5 g5 h5 c1 c2 c3 c4 c6 c7 c8)],
d5 => [qw(a5 b5 c5 e5 f5 g5 h5 d1 d2 d3 d4 d6 d7 d8)],
e5 => [qw(a5 b5 c5 d5 f5 g5 h5 e1 e2 e3 e4 e6 e7 e8)],
f5 => [qw(a5 b5 c5 d5 e5 g5 h5 f1 f2 f3 f4 f6 f7 f8)],
g5 => [qw(a5 b5 c5 d5 e5 f5 h5 g1 g2 g3 g4 g6 g7 g8)],
h5 => [qw(a5 b5 c5 d5 e5 f5 g5 h1 h2 h3 h4 h6 h7 h8)],
a6 => [qw(b6 c6 d6 e6 f6 g6 h6 a1 a2 a3 a4 a5 a7 a8)],
b6 => [qw(a6 c6 d6 e6 f6 g6 h6 b1 b2 b3 b4 b5 b7 b8)],
c6 => [qw(a6 b6 d6 e6 f6 g6 h6 c1 c2 c3 c4 c5 c7 c8)],
d6 => [qw(a6 b6 c6 e6 f6 g6 h6 d1 d2 d3 d4 d5 d7 d8)],
e6 => [qw(a6 b6 c6 d6 f6 g6 h6 e1 e2 e3 e4 e5 e7 e8)],
f6 => [qw(a6 b6 c6 d6 e6 g6 h6 f1 f2 f3 f4 f5 f7 f8)],
g6 => [qw(a6 b6 c6 d6 e6 f6 h6 g1 g2 g3 g4 g5 g7 g8)],
h6 => [qw(a6 b6 c6 d6 e6 f6 g6 h1 h2 h3 h4 h5 h7 h8)],
a7 => [qw(b7 c7 d7 e7 f7 g7 h7 a1 a2 a3 a4 a5 a6 a8)],
b7 => [qw(a7 c7 d7 e7 f7 g7 h7 b1 b2 b3 b4 b5 b6 b8)],
c7 => [qw(a7 b7 d7 e7 f7 g7 h7 c1 c2 c3 c4 c5 c6 c8)],
d7 => [qw(a7 b7 c7 e7 f7 g7 h7 d1 d2 d3 d4 d5 d6 d8)],
e7 => [qw(a7 b7 c7 d7 f7 g7 h7 e1 e2 e3 e4 e5 e6 e8)],
f7 => [qw(a7 b7 c7 d7 e7 g7 h7 f1 f2 f3 f4 f5 f6 f8)],
g7 => [qw(a7 b7 c7 d7 e7 f7 h7 g1 g2 g3 g4 g5 g6 g8)],
h7 => [qw(a7 b7 c7 d7 e7 f7 g7 h1 h2 h3 h4 h5 h6 h8)],
a8 => [qw(b8 c8 d8 e8 f8 g8 h8 a1 a2 a3 a4 a5 a6 a7)],
b8 => [qw(a8 c8 d8 e8 f8 g8 h8 b1 b2 b3 b4 b5 b6 b7)],
c8 => [qw(a8 b8 d8 e8 f8 g8 h8 c1 c2 c3 c4 c5 c6 c7)],
d8 => [qw(a8 b8 c8 e8 f8 g8 h8 d1 d2 d3 d4 d5 d6 d7)],
e8 => [qw(a8 b8 c8 d8 f8 g8 h8 e1 e2 e3 e4 e5 e6 e7)],
f8 => [qw(a8 b8 c8 d8 e8 g8 h8 f1 f2 f3 f4 f5 f6 f7)],
g8 => [qw(a8 b8 c8 d8 e8 f8 h8 g1 g2 g3 g4 g5 g6 g7)],
h8 => [qw(a8 b8 c8 d8 e8 f8 g8 h1 h2 h3 h4 h5 h6 h7)],
);

%Bishop_Moves = (
a1 => [qw(b2 c3 d4 e5 f6 g7 h8)],
b1 => [qw(c2 d3 e4 f5 g6 h7 a2)],
c1 => [qw(d2 e3 f4 g5 h6 b2 a3)],
d1 => [qw(e2 f3 g4 h5 c2 b3 a4)],
e1 => [qw(f2 g3 h4 d2 c3 b4 a5)],
f1 => [qw(g2 h3 e2 d3 c4 b5 a6)],
g1 => [qw(h2 f2 e3 d4 c5 b6 a7)],
h1 => [qw(g2 f3 e4 d5 c6 b7 a8)],
a2 => [qw(b3 c4 d5 e6 f7 g8 b1)],
b2 => [qw(a1 c3 d4 e5 f6 g7 h8 c1 a3)],
c2 => [qw(b1 d3 e4 f5 g6 h7 d1 b3 a4)],
d2 => [qw(c1 e3 f4 g5 h6 e1 c3 b4 a5)],
e2 => [qw(d1 f3 g4 h5 f1 d3 c4 b5 a6)],
f2 => [qw(e1 g3 h4 g1 e3 d4 c5 b6 a7)],
g2 => [qw(f1 h3 h1 f3 e4 d5 c6 b7 a8)],
h2 => [qw(g1 g3 f4 e5 d6 c7 b8)],
a3 => [qw(b4 c5 d6 e7 f8 c1 b2)],
b3 => [qw(a2 c4 d5 e6 f7 g8 d1 c2 a4)],
c3 => [qw(a1 b2 d4 e5 f6 g7 h8 e1 d2 b4 a5)],
d3 => [qw(b1 c2 e4 f5 g6 h7 f1 e2 c4 b5 a6)],
e3 => [qw(c1 d2 f4 g5 h6 g1 f2 d4 c5 b6 a7)],
f3 => [qw(d1 e2 g4 h5 h1 g2 e4 d5 c6 b7 a8)],
g3 => [qw(e1 f2 h4 h2 f4 e5 d6 c7 b8)],
h3 => [qw(f1 g2 g4 f5 e6 d7 c8)],
a4 => [qw(b5 c6 d7 e8 d1 c2 b3)],
b4 => [qw(a3 c5 d6 e7 f8 e1 d2 c3 a5)],
c4 => [qw(a2 b3 d5 e6 f7 g8 f1 e2 d3 b5 a6)],
d4 => [qw(a1 b2 c3 e5 f6 g7 h8 g1 f2 e3 c5 b6 a7)],
e4 => [qw(b1 c2 d3 f5 g6 h7 h1 g2 f3 d5 c6 b7 a8)],
f4 => [qw(c1 d2 e3 g5 h6 h2 g3 e5 d6 c7 b8)],
g4 => [qw(d1 e2 f3 h5 h3 f5 e6 d7 c8)],
h4 => [qw(e1 f2 g3 g5 f6 e7 d8)],
a5 => [qw(b6 c7 d8 e1 d2 c3 b4)],
b5 => [qw(a4 c6 d7 e8 f1 e2 d3 c4 a6)],
c5 => [qw(a3 b4 d6 e7 f8 g1 f2 e3 d4 b6 a7)],
d5 => [qw(a2 b3 c4 e6 f7 g8 h1 g2 f3 e4 c6 b7 a8)],
e5 => [qw(a1 b2 c3 d4 f6 g7 h8 h2 g3 f4 d6 c7 b8)],
f5 => [qw(b1 c2 d3 e4 g6 h7 h3 g4 e6 d7 c8)],
g5 => [qw(c1 d2 e3 f4 h6 h4 f6 e7 d8)],
h5 => [qw(d1 e2 f3 g4 g6 f7 e8)],
a6 => [qw(b7 c8 f1 e2 d3 c4 b5)],
b6 => [qw(a5 c7 d8 g1 f2 e3 d4 c5 a7)],
c6 => [qw(a4 b5 d7 e8 h1 g2 f3 e4 d5 b7 a8)],
d6 => [qw(a3 b4 c5 e7 f8 h2 g3 f4 e5 c7 b8)],
e6 => [qw(a2 b3 c4 d5 f7 g8 h3 g4 f5 d7 c8)],
f6 => [qw(a1 b2 c3 d4 e5 g7 h8 h4 g5 e7 d8)],
g6 => [qw(b1 c2 d3 e4 f5 h7 h5 f7 e8)],
h6 => [qw(c1 d2 e3 f4 g5 g7 f8)],
a7 => [qw(b8 g1 f2 e3 d4 c5 b6)],
b7 => [qw(a6 c8 h1 g2 f3 e4 d5 c6 a8)],
c7 => [qw(a5 b6 d8 h2 g3 f4 e5 d6 b8)],
d7 => [qw(a4 b5 c6 e8 h3 g4 f5 e6 c8)],
e7 => [qw(a3 b4 c5 d6 f8 h4 g5 f6 d8)],
f7 => [qw(a2 b3 c4 d5 e6 g8 h5 g6 e8)],
g7 => [qw(a1 b2 c3 d4 e5 f6 h8 h6 f8)],
h7 => [qw(b1 c2 d3 e4 f5 g6 g8)],
a8 => [qw(h1 g2 f3 e4 d5 c6 b7)],
b8 => [qw(a7 h2 g3 f4 e5 d6 c7)],
c8 => [qw(a6 b7 h3 g4 f5 e6 d7)],
d8 => [qw(a5 b6 c7 h4 g5 f6 e7)],
e8 => [qw(a4 b5 c6 d7 h5 g6 f7)],
f8 => [qw(a3 b4 c5 d6 e7 h6 g7)],
g8 => [qw(a2 b3 c4 d5 e6 f7 h7)],
h8 => [qw(a1 b2 c3 d4 e5 f6 g7)],
);

%Knight_Moves = (
a1 => [qw(b3 c2)],
b1 => [qw(a3 c3 d2)],
c1 => [qw(a2 b3 d3 e2)],
d1 => [qw(b2 c3 e3 f2)],
e1 => [qw(c2 d3 f3 g2)],
f1 => [qw(d2 e3 g3 h2)],
g1 => [qw(e2 f3 h3)],
h1 => [qw(f2 g3)],
a2 => [qw(b4 c3 c1)],
b2 => [qw(a4 c4 d3 d1)],
c2 => [qw(a1 a3 b4 d4 e3 e1)],
d2 => [qw(b1 b3 c4 e4 f3 f1)],
e2 => [qw(c1 c3 d4 f4 g3 g1)],
f2 => [qw(d1 d3 e4 g4 h3 h1)],
g2 => [qw(e1 e3 f4 h4)],
h2 => [qw(f1 f3 g4)],
a3 => [qw(b5 c4 c2 b1)],
b3 => [qw(a1 a5 c5 d4 d2 c1)],
c3 => [qw(b1 a2 a4 b5 d5 e4 e2 d1)],
d3 => [qw(c1 b2 b4 c5 e5 f4 f2 e1)],
e3 => [qw(d1 c2 c4 d5 f5 g4 g2 f1)],
f3 => [qw(e1 d2 d4 e5 g5 h4 h2 g1)],
g3 => [qw(f1 e2 e4 f5 h5 h1)],
h3 => [qw(g1 f2 f4 g5)],
a4 => [qw(b6 c5 c3 b2)],
b4 => [qw(a2 a6 c6 d5 d3 c2)],
c4 => [qw(b2 a3 a5 b6 d6 e5 e3 d2)],
d4 => [qw(c2 b3 b5 c6 e6 f5 f3 e2)],
e4 => [qw(d2 c3 c5 d6 f6 g5 g3 f2)],
f4 => [qw(e2 d3 d5 e6 g6 h5 h3 g2)],
g4 => [qw(f2 e3 e5 f6 h6 h2)],
h4 => [qw(g2 f3 f5 g6)],
a5 => [qw(b7 c6 c4 b3)],
b5 => [qw(a3 a7 c7 d6 d4 c3)],
c5 => [qw(b3 a4 a6 b7 d7 e6 e4 d3)],
d5 => [qw(c3 b4 b6 c7 e7 f6 f4 e3)],
e5 => [qw(d3 c4 c6 d7 f7 g6 g4 f3)],
f5 => [qw(e3 d4 d6 e7 g7 h6 h4 g3)],
g5 => [qw(f3 e4 e6 f7 h7 h3)],
h5 => [qw(g3 f4 f6 g7)],
a6 => [qw(b8 c7 c5 b4)],
b6 => [qw(a4 a8 c8 d7 d5 c4)],
c6 => [qw(b4 a5 a7 b8 d8 e7 e5 d4)],
d6 => [qw(c4 b5 b7 c8 e8 f7 f5 e4)],
e6 => [qw(d4 c5 c7 d8 f8 g7 g5 f4)],
f6 => [qw(e4 d5 d7 e8 g8 h7 h5 g4)],
g6 => [qw(f4 e5 e7 f8 h8 h4)],
h6 => [qw(g4 f5 f7 g8)],
a7 => [qw(c8 c6 b5)],
b7 => [qw(a5 d8 d6 c5)],
c7 => [qw(b5 a6 a8 e8 e6 d5)],
d7 => [qw(c5 b6 b8 f8 f6 e5)],
e7 => [qw(d5 c6 c8 g8 g6 f5)],
f7 => [qw(e5 d6 d8 h8 h6 g5)],
g7 => [qw(f5 e6 e8 h5)],
h7 => [qw(g5 f6 f8)],
a8 => [qw(c7 b6)],
b8 => [qw(a6 d7 c6)],
c8 => [qw(b6 a7 e7 d6)],
d8 => [qw(c6 b7 f7 e6)],
e8 => [qw(d6 c7 g7 f6)],
f8 => [qw(e6 d7 h7 g6)],
g8 => [qw(f6 e7 h6)],
h8 => [qw(g6 f7)],
);

%from_algebraic = (
		   "a1", 0,"b1", 1,"c1", 2,"d1", 3,"e1", 4,"f1", 5,"g1", 6,"h1", 7,
		   "a2", 8,"b2", 9,"c2",10,"d2",11,"e2",12,"f2",13,"g2",14,"h2",15,
		   "a3",16,"b3",17,"c3",18,"d3",19,"e3",20,"f3",21,"g3",22,"h3",23,
		   "a4",24,"b4",25,"c4",26,"d4",27,"e4",28,"f4",29,"g4",30,"h4",31,
		   "a5",32,"b5",33,"c5",34,"d5",35,"e5",36,"f5",37,"g5",38,"h5",39,
		   "a6",40,"b6",41,"c6",42,"d6",43,"e6",44,"f6",45,"g6",46,"h6",47,
		   "a7",48,"b7",49,"c7",50,"d7",51,"e7",52,"f7",53,"g7",54,"h7",55,
		   "a8",56,"b8",57,"c8",58,"d8",59,"e8",60,"f8",61,"g8",62,"h8",63,
		   );

%move_table = (
	       K => \%King_Moves,
	       Q => \%Queen_Moves,
	       R => \%Rook_Moves,
	       N => \%Knight_Moves,
	       B => \%Bishop_Moves,
	       );


# Preloaded methods go here.

1;
__END__

=head1 NAME

Chess::PGN::Moves - Perl extension for tabular data in support of Chess::PGN::EPD

=head1 SYNOPSIS

  use PGN::Moves;

=head1 DESCRIPTION

These tables (as listed under EXPORT below) describe all of the possible moves for a given piece. The hash %from_algebraic
provides quick translation from algebraic square notation to a more useful numeric index.

=head2 EXPORT

=over

=item %King_Moves

=item %Queen_Moves

=item %Rook_Moves

=item %Bishop_Moves

=item %Knight_Moves

=item %from_algebraic

=item %move_table

=back

=head2 DEPENDENCIES

Since this module doesn't contain any executable code, there are no
actual dependencies. It is more likely that it would be used in concert with
the following:

=over

=item CHESS::PGN::EPD

=item CHESS::PGN::Parse

=back

=head1 KNOWN BUGS

None known; Unknown? Of course, though I try to be neat...

=head1 AUTHOR

B<I<Hugh S. Myers>>

=over

=item Always: hsmyers@sdragons.com

=back

=cut
