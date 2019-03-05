# AlmAndrews-K-Sets
K Set Graph Coloring Problem

We have two implementations of code to verify that the cyclic two-coloring on K<sub>17</sub> induced by {1,2,4,8,9,13,15,16} (the quadratic residues mod 17) is free of monochromatic K<sub>4</sub>, K<sub>3,3</sub>, and K<sub>5,2</sub> subgraphs.

The implementations are written independently, one in R (using the gtools package) and one in Python (using itertools), and have somewhat different approaches. Both have been run and confirm the desired properties.

These properties of the graph are used in a paper submitted to the journal _Algebra Universalis_.
